// cleaning OCDEL file
	clear
	import excel "C:\Users\Lucy Caffrey Maffei\Downloads\OCDEL Child Care Providers - December 2018 Deliverable - Updated 04112019.xlsx", sheet("REPORT") firstrow case(lower)
	keep if facilitycity == "PHILADELPHIA"
	tostring mpiid, force replace
	gen mpilong = mpiid + "-" + mpilocationid
	order mpiid mpilocationid mpilong
	rename legalentityname legalname
	rename facilityname name
	replace name =upper(name)
	rename facilityaddress address
	replace address=upper(address)
	rename facilityemail email
	replace email=upper(email)
	gen principaldirectordisplayname = responsiblepersonfirstname +" "+responsiblepersonlastname
	replace principaldirectordisplayname =upper(principaldirectordisplayname)
	drop responsiblepersonfirstname responsiblepersonlastname
	replace paprekcounts = "TRUE" if paprekcounts == "Yes"
	replace headstartstatesupplementalas  = "TRUE" if headstartstatesupplementalas == "Yes"
	replace schoolageprovider   = "TRUE" if schoolageprovider  == "Yes"
	replace paprekcounts = "FALSE" if paprekcounts == "No"
	replace headstartstatesupplementalas  = "FALSE" if headstartstatesupplementalas  == "No"
	replace schoolageprovider  = "FALSE" if schoolageprovider   == "No"
	replace schoolageprovider = "TRUE" if capacity == "School Age Provider"
	replace starlevel = "" if starlevel == "No STAR Level"
	replace starlevel = subinstr(starlevel, "STAR 1", "1",.)
	replace starlevel = subinstr(starlevel, "STAR 2", "2",.)
	replace starlevel = subinstr(starlevel, "STAR 3", "3",.)
	replace starlevel = subinstr(starlevel, "STAR 4", "4",.)
	duplicates tag pspid, gen(dup)
	drop if dup > 0
	drop negativesanctions elrc licenseissuedate licenseexpdate providertype dup
	duplicates tag name address, gen(dup)
	tab dup
	sort dup
	sort dup name
	drop in 1730
	drop in 1728
	clear
	duplicates tag name address, gen(dup)
	sort dup name
	drop in 1722
	drop in 1722
	drop in 1723
	drop in 1724
	drop in 1726
	drop dup
	tempfile ocdel
	save `ocdel'
	clear

// cleaning existing GPS records of ECE centers
	import delimited "C:\Users\Lucy Caffrey Maffei\Downloads\report1559938062674.csv", bindquote(strict) varnames(1) 
	rename schoolprofileid publishedid
	duplicates tag pspid, gen(dup)
	drop if dup > 0 
	drop dup
	tempfile gpsreport
	save `gpsreport'
	clear
	import delimited "C:\Users\Lucy Caffrey Maffei\Downloads\report1559938553663.csv", bindquote(strict) varnames(1) 
	rename schoolprofileid unpublishedid
	duplicates tag pspid, gen(dup)
	drop if dup > 0 
	drop dup
	tempfile merge
	save `merge'
	clear
	use `gpsreport'
	merge 1:1 pspid childprofilenameaccountid using `merge'
	drop if _merge ==2
	drop _merge
	rename childprofilenameaccountid accountid
	rename schoolcentername name
	rename legalstreetname legaladdress
	rename legalaptsuitenumber legalapt
	rename schoolphonenumber phone
	rename schoolfaxnumber fax
	rename aptsuitenumber apt
	rename publishedschoolemail email
	rename earlychildhoodcenterlicense license
	rename earlychildhoodcentercapacity capacity
	rename eckeystonestarqualityrating gpsstarrating
	rename starratingeffdate gpsstarratingeffdate
	order pspid accountid publishedid unpublishedid name fullece
	replace name = upper(name)
	replace address = upper(address)
	replace email = upper(email)
	replace principaldirectordisplayname = upper(principaldirectordisplayname)
	rename capacity capacity_gps
	rename schoolageprovider schoolageprovider_gps
	tempfile gpsreport
	save `gpsreport'
	
// merging gps existing records with ocdel file

	merge 1:1 name address using `ocdel'
	preserve
	keep if _merge ==3
	tempfile matched
	save `matched'
	restore
	drop if _merge == 3
	drop if _merge == 2
	drop mpi-_merge
	duplicates tag address, gen(dup)
	sort dup address
	replace name = subinstr(name, "PRESCHOOL/DAYCARE","",.)
	drop in 1026
	replace name =subinstr(name, " ()","",.)
	tempfile master
	save `master'
	drop in 1024
	drop in 1026
	drop in 1027
	drop in 1028
	drop in 1029
	drop in 1032
	drop in 1032
	drop in 1030
	replace address = "1821 SOUTH 9TH STREET" in 1030
	drop in 1031
	drop in 1031
	drop in 1031
	tempfile master
	save `master'
	merge 1:1 name address using `ocdel'
	preserve
	keep if _merge == 3
	drop _merge
	tempfile matched2
	save `matched2'
	use `matched'
	append using `matched2'
	drop dup _merge
	tempfile matched
	save `matched'
	restore
	keep if _merge ==1
	drop _merge
	set obs 988
	replace pspid = "E11965" in 988
	replace accountid = "0011N00001TQzWK" in 988
	replace unpublishedid = "a0j1N00000BfrLf" in 988
	replace publishedid = "a0j1N00000BftRO" in 988
	replace name = "IAC ST HELENA ELEMENTARY SCHOOL" in 988
	replace fullece = 0 in 988
	replace address = "6101 N 5th St" in 988
	replace address = "6101 N 5TH ST" in 988
	replace city = "Philadelphia" in 988
	replace state = "PA" in 988
	replace zipcode = 19120 in 988
	replace legalcity = "PHILADELPHIA" in 988
	replace legalcounty = "Philadelphia" in 988
	replace legalstate = "PA" in 988
	replace legalzipcode = 19120 in 988
	drop dup-legalentitycounty
	tempfile master
	save `master'
	merge 1:1 name address using `ocdel'
	preserve
	keep if _merge == 3
	tempfile matched2
	save `matched2'
	clear
	use `matched'
	append using `matched2'
	drop _merge
	tempfile matched
	save `matched'
	restore
	keep if _merge == 1
	tempfile master
	save `master'


