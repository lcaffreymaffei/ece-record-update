doedit "Y:\GPS\Lucy Caffrey-Maffei\Data Projects\ECE\OCDEL refresh do file.do" 
import delimited "C:\Users\Lucy Caffrey Maffei\Downloads\report1559938062674.csv", bindquote(strict) varnames(1) 
rename schoolprofileid publishedid
duplicates tag pspid, gen(dup)
tab dup
dropd up
drop dup
tempfile gpsreport
save `gpsreport'
clear
import delimited "C:\Users\Lucy Caffrey Maffei\Downloads\report1559938214177.csv", bindquote(strict) varnames(1) 
duplicates tag pspid, gen(dup)
tab dup
drop dup
tempfile merge
save `merge'
clear
use `gpsreport'
merge 1:1 pspid childprofilenameaccountid using `merge'
drop if _merge ==2
drop _merge
order pspid childprofilenameaccountid publishedid unpublishedid
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
order pspid-name fullece
tempfile gpsreport
save `gpsreport'
order pspid childprofilename accountid publishedid unpublishedid
order pspid name accountid publishedid unpublishedid
tab schoolname if publishedid== publishedid
tab name if publishedid== publishedid
clear
import delimited "C:\Users\Lucy Caffrey Maffei\Downloads\report1559938062674.csv", bindquote(strict) varnames(1) 
rename schoolprofileid publishedid
duplicates tag pspid, gen(dup)
tempfile gpsreport
save `gpsreport'
clear
import delimited "C:\Users\Lucy Caffrey Maffei\Downloads\report1559938553663.csv", bindquote(strict) varnames(1) 
rename schoolprofileid unpublishedid
tempfile merge
save `merge'
clear
use `gpsreport'
merge 1:1 pspid childprofilenameaccountid using `merge'
drop if _merge ==2
drop _merge
order pspid name accountid publishedid unpublishedid
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
order pspid-name fullece
tempfile gpsreport
save `gpsreport'
order pspid accountid publishedid unpublishedid name fullece
tab dup
drop dup
tempfile gpsreport
save `gpsreport
save `gpsreport'
clear
clear
import excel "C:\Users\Lucy Caffrey Maffei\Downloads\OCDEL Child Care Providers - December 2018 Deliverable - Updated 04112019.xlsx", sheet("REPORT") firstrow case(lower)
keep if facilitycity == "PHILADELPHIA"
tostring mpiid, force replace
gen mpilong = mpiid + "-" + mpilocationid
order mpiid mpilocationid mpilong
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
drop negativesanctions elrc licenseissuedate licenseexpdate providertype
tempfile ocdel
save `ocdel'
drop mpiid mpilocationid
tempfile ocdel
save `ocdel'
unique mpilong
rename mpilong mpi
tempfile ocdel
save `ocdel'
use `gps report
use `gps report'
use `gpsreport'
replace name = upper(name)
replace address = upper(address)
tempfile gpsreport
save `gpsreport'
clear
use `ocdel'
rename facilityname name
replace name =upper(name)
rename facilityaddress address
replace address=upper(address)
gen principaldirectordisplayname = responsiblepersonfirstname +" "+responsiblepersonlastname
rename facilityemail email
replace email=upper(email)
replace principaldirectordisplayname =upper(principaldirectordisplayname
replace principaldirectordisplayname =upper(principaldirectordisplayname)
drop responsiblepersonfirstname responsiblepersonlastname
tempfile ocdel
save `ocdel'
clear
use `gpsreport'
merge 1:1 name using `ocdel'
duplicates tag, gen(dup)
drop dup
duplicates tag name, gen(dup)
tab dup
drop dup
unique address
unique phone
unique fax
sort address
sort phone
unique name phone
duplicates tag name phone, gen (dup)
tab duplicates
tag dup
tab dup
sort dup
drop dup
unique name address
merge 1:1 name address using `ocdel'
rename capacity capacity_gps
merge 1:1 name address using `ocdel'
rename schoolageprovider schoolageprovider_gps
merge 1:1 name address using `ocdel'
tempfile gpsreport
save `gpsreport'
clear
use `ocdel'
unique name address
duplicates tag name address, gen(dup)
tab dup
sort dup
sort dup name
drop in 1730
drop in 1728
clear
use `ocdel'
duplicates tag name address, gen(dup)
sort dup
sort dup name
keep if dup >1
clear
use `ocdel'
duplicates tag name address, gen(dup)
sort dup name
keep if dup >0
export excel using "C:\Users\Lucy Caffrey Maffei\Documents\ocdel duplicates.xlsx"
clear
use `ocdel'
duplicates tag name address, gen(dup)
sort dup name
drop in 1722
unique mpi
drop in 1722
drop in 1723
drop in 1724
drop in 1726
drop dup
tempfile ocdel
save `ocdel'
clear
use `gpsreport'
replace name=upper(name)
replace address=upper(address)
merge 1:1 name address using `ocdel'
preserve
keep if _merge ==3
tempfile matched
save `matched'
restore
drop if _merge == 3
drop _merge == 2
drop if _merge == 2
tempfile master
save `master'
replace email = upper(email)
replace principaldirectordisplayname = upper(principaldirectordisplayname)
drop mpi-_merge
unique name
unique address
unique phone
unique name phone
duplicates tag name phone, gen(dup)
tab dup
sort dup
sort dup name
drop dup
duplicates tag address, gen(dup)
sort dup address
tempfile master
save `master'
replace name = subinstr(name, "PRESCHOOL/DAYCARE","",.)
replace name = trim(name)
drop dup
merge 1:1 name address using `ocdel'
drop if _merge == 2
drop _merge
duplicates tag address, gen(dup)
sort dup address
drop mpi-legalentitycounty
drop in 1026
clear
use `master'
replace name = subinstr(name, "PRESCHOOL/DAYCARE","",.)
duplicates tag address, gen(dup)
sort dup address
drop dup
duplicates tag address, gen(dup)
sort dup address
drop in 1026
replace name =subinstri(name, " ()","",.)
replace name =subinstr(name, " ()","",.)
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
tempfile matched2
save `matched2'
use `matched'
append using `matched2'
drop _merge
append using `matched2'
drop dup _merge
clear
use `matched'
drop _merge
append using `matched2'
drop _merge
tempfile matched
save `matched'
restore
keep if _merge ==1
drop _merge
unique name
unique address
unique name address
unique name phone
unique name fax
unique name license
tempfile master
save `master'
merge 1:1 address using `ocdel'
tab name if missing(address)
use `ocdel'
unique address
duplicates tag address, gen(dup)
sort dup address
clear
use `master'
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
merge 1:1 name address using `ocdel"
merge 1:1 name address using `ocdel'
preserve
keep if _merge == 3
tempfile matched2
save `matched2'
clear `use'
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
unique address
clear
use `ocdel'
unique address
clear
use `master'
replace phone = subinstr(phone,") ","",.)
replace phone = subinstr(phone,"(","",.)
replace phone = subinstr(phone,"-","",.)
drop pspid mpi-_merge
replace fax = subinstr(fax,") ","",.)
replace fax = subinstr(fax,"(","",.)
replace fax = subinstr(fax,"-","",.)
unique name phone
duplicates tag name phone, gen(dup)
sort dup name
unique address phone
tempfile master
save `master'
merge 1:1 address phone using `ocdel'
clear
use `ocdel'
rename facilityphone phone
tempfile `ocdel
tempfile ocdel
save `ocdel'
clear
use `master'
drop dup
merge 1:1 address phone using `ocdel'
merge 1:m address using `ocdel'
drop if _merge ==2
sort merge
sort _merge
clear
use `ocdel'
rename name facilityname
tempfile ocdel
save `ocdel'
clear
use `master'
unique address
merge 1:m address using `ocdel'
drop if _merge ==2
sort _merge
list name facilityname if _merge ==3
gen keep = 0
replace keep = ""
replace keep = .
replace keep = 1 in 680
replace keep = 1 in 681
replace keep = 0 in 682
replace keep = 1 in 683
replace keep = 1 in 684
replace keep = 1 in 685
replace keep = 1 in 686
replace keep = 0 in 687
replace keep = 1 in 688
replace keep = 0 in 689
replace keep = 1 in 690
replace keep = 1 in 691
replace keep = 1 in 692
replace keep = 1 in 693
replace keep = 1 in 694
replace keep = 1 in 695
replace keep = 1 in 696
replace keep = 1 in 697
replace keep = 0 in 698
replace keep = 0 in 699
replace keep = 1 in 700
replace keep = 0 in 701
replace keep = 1 in 702
replace keep = 1 in 703
replace keep = 1 in 704
replace keep = 1 in 705
replace keep = 1 in 706
replace keep = 1 in 707
replace keep = 1 in 708
replace keep = 1 in 709
replace keep = 1 in 710
replace keep = 1 in 711
replace keep = 0 in 712
replace keep = 1 in 713
replace keep = 1 in 714
replace keep = 0 in 715
replace keep = 1 in 716
replace keep = 1 in 717
replace keep = 1 in 718
replace keep = 0 in 719
replace keep = 1 in 720
replace keep = 0 in 721
replace keep = 0 in 722
replace keep = 1 in 723
replace keep = 1 in 724
replace keep = 1 in 725
replace keep = 1 in 726
replace keep = 0 in 727
replace keep = 1 in 728
replace keep = 1 in 729
replace keep = 1 in 730
replace keep = 1 in 731
replace keep = 0 in 732
replace keep = 1 in 733
replace keep = 1 in 734
replace keep = 0 in 735
replace keep = 1 in 736
replace keep = 1 in 737
replace keep = 1 in 738
replace keep = 1 in 739
replace keep = 1 in 740
replace keep = 1 in 741
clear
use `ocdel'
rename facilityname name_ocdel
rename phone phone_ocdel
rename facilityfax fax_ocdel
rename email email_ocdel
rename license license _ocdel
rename licensenumber license_ocdel
rename principaldirectordisplayname principaldirectordisplayname_ocdel
rename principaldirectordisplayname responsibleperson_ocdel
tempfile ocdel
save `ocdel'
clear
use `master'
drop dup
rename license license_gps
rename email email_gps
rename phone phone_gps
rename fax fax_gps
tempfile master
save `master'
clear
use `ocdel'
clear
use `master'
merge 1:m address using `ocdel
merge 1:m address using `ocdel'
drop if _merge ==2
sort _merge
gen keep=.
list name name_ocdel if _merge==3
replace keep = 1 in 680
replace keep = 1 in 681
replace keep = 1 in 682
replace keep = 1 in 683
replace keep = 1 in 684
replace keep = 1 in 685
replace keep = 1 in 686
replace keep = 1 in 687
replace keep = 1 in 688
replace keep = 1 in 689
replace keep = 1 in 690
replace keep = 1 in 691
replace keep = 1 in 692
replace keep = 1 in 693
replace keep = 1 in 694
replace keep = 1 in 695
replace keep = 1 in 696
replace keep = 1 in 697
replace keep = 1 in 698
replace keep = 1 in 699
replace keep = 1 in 700
replace keep = 1 in 701
replace keep = 0 in 702
replace keep = 1 in 703
replace keep = 1 in 704
replace keep = 0 in 705
replace keep = 1 in 706
replace keep = 1 in 707
replace keep = 1 in 708
replace keep = 0 in 709
replace keep = 1 in 710
replace keep = 1 in 711
replace keep = 1 in 712
replace keep = 1 in 713
replace keep = 1 in 714
replace keep = 1 in 715
replace keep = 1 in 716
replace keep = 1 in 717
replace keep = 1 in 718
replace keep = 1 in 719
replace keep = 1 in 720
replace keep = 1 in 721
replace keep = 1 in 722
replace keep = 0 in 723
replace keep = 1 in 724
replace keep = 1 in 725
replace keep = 1 in 726
replace keep = 1 in 727
replace keep = 1 in 728
replace keep = 1 in 729
replace keep = 1 in 730
replace keep = 0 in 731
replace keep = 1 in 732
replace keep = 1 in 733
replace keep = 0 in 734
replace keep = 1 in 735
replace keep = 0 in 736
replace keep = 1 in 737
replace keep = 1 in 738
replace keep = 1 in 739
replace keep = 1 in 740
replace keep = 1 in 741
replace keep = 1 in 742
replace keep = 1 in 743
replace keep = 1 in 744
replace keep = 0 in 745
replace keep = 1 in 746
replace keep = 1 in 747
replace keep = 1 in 748
replace keep = 1 in 749
replace keep = 1 in 750
replace keep = 0 in 751
replace keep = 1 in 752
replace keep = 1 in 753
replace keep = 1 in 754
replace keep = 1 in 755
replace keep = 1 in 756
replace keep = 1 in 757
replace keep = 1 in 758
replace keep = 1 in 759
replace keep = 1 in 760
replace keep = 0 in 760
replace keep = 1 in 761
replace keep = 0 in 762
replace keep = 1 in 763
replace keep = 0 in 764
replace keep = 1 in 765
replace keep = 1 in 766
replace keep = 0 in 767
replace keep = 1 in 768
replace keep = 1 in 769
replace keep = 0 in 770
replace keep = 0 in 771
replace keep = 1 in 772
replace keep = 1 in 773
replace keep = 1 in 774
replace keep = 1 in 775
replace keep = 1 in 776
replace keep = 1 in 777
replace keep = 1 in 778
replace keep = . in 779
replace keep = 0 in 779
replace keep = 0 in 780
replace keep = 1 in 781
replace keep = 0 in 782
replace keep = 1 in 783
replace keep = 1 in 784
replace keep = 0 in 785
replace keep = 1 in 786
replace keep = 0 in 787
replace keep = 0 in 788
replace keep = 1 in 789
replace keep = 1 in 790
replace keep = 0 in 791
replace keep = 1 in 792
replace keep = 1 in 793
replace keep = 1 in 794
replace keep = 1 in 795
replace keep = 1 in 796
replace keep = 1 in 797
replace keep = 1 in 798
replace keep = 0 in 799
replace keep = 0 in 800
replace keep = 1 in 801
replace keep = 1 in 802
replace keep = 1 in 803
replace keep = 1 in 804
replace keep = 1 in 805
replace keep = 1 in 806
replace keep = 1 in 807
replace keep = 1 in 808
replace keep = 1 in 809
replace keep = 1 in 810
replace keep = 1 in 811
replace keep = 1 in 812
replace keep = 1 in 813
replace keep = 1 in 814
replace keep = 1 in 815
replace keep = 1 in 816
replace keep = 1 in 817
replace keep = 1 in 818
replace keep = 1 in 819
replace keep = 1 in 820
replace keep = 1 in 821
replace keep = 1 in 822
replace keep = 1 in 823
replace keep = 1 in 824
replace keep = 1 in 825
replace keep = 1 in 826
replace keep = 1 in 827
replace keep = 1 in 828
replace keep = 1 in 829
replace keep = 0 in 830
replace keep = 0 in 831
replace keep = 1 in 832
replace keep = 1 in 833
replace keep = 1 in 834
replace keep = 1 in 835
replace keep = 1 in 836
replace keep = 0 in 837
replace keep = 1 in 838
replace keep = 1 in 839
replace keep = 1 in 840
replace keep = 1 in 841
replace keep = 1 in 842
replace keep = 0 in 843
replace keep = 1 in 844
replace keep = 1 in 845
replace keep = 0 in 846
replace keep = 1 in 847
replace keep = 0 in 848
replace keep = 1 in 849
replace keep = 1 in 850
replace keep = 0 in 851
replace keep = 1 in 852
replace keep = 1 in 853
replace keep = 1 in 854
replace keep = 1 in 855
replace keep = 1 in 856
replace keep = 1 in 857
replace keep = 1 in 858
replace keep = 1 in 859
replace keep = 0 in 860
replace keep = 1 in 861
replace keep = 1 in 862
replace keep = 1 in 863
replace keep = 1 in 864
replace keep = 0 in 864
replace keep = 0 in 865
replace keep = 0 in 866
replace keep = 1 in 867
replace keep = 1 in 868
replace keep = 1 in 869
replace keep = 1 in 870
replace keep = 1 in 871
replace keep = 1 in 872
replace keep = 0 in 873
replace keep = 1 in 874
replace keep = 1 in 875
replace keep = 1 in 876
replace keep = 1 in 877
replace keep = 1 in 878
replace keep = 1 in 879
replace keep = 0 in 880
replace keep = 1 in 881
replace keep = 1 in 882
replace keep = 1 in 883
replace keep = 0 in 884
replace keep = 1 in 885
replace keep = 1 in 886
replace keep = 1 in 887
replace keep = 0 in 888
replace keep = 1 in 889
replace keep = 0 in 890
replace keep = 1 in 891
replace keep = 0 in 892
replace keep = 1 in 893
replace keep = 0 in 893
replace keep = 1 in 894
replace keep = 1 in 895
replace keep = 1 in 896
replace keep = 1 in 897
replace keep = 1 in 898
replace keep = 0 in 898
replace keep = 1 in 899
replace keep = 1 in 900
replace keep = 1 in 901
replace keep = 1 in 902
replace keep = 1 in 903
replace keep = 1 in 904
replace keep = 1 in 905
replace keep = 1 in 906
replace keep = 1 in 907
replace keep = 1 in 908
replace keep = 0 in 909
replace keep = 1 in 910
replace keep = 0 in 911
replace keep = 1 in 912
replace keep = 1 in 913
replace keep = 1 in 914
replace keep = 1 in 915
replace keep = 1 in 916
replace keep = 1 in 917
replace keep = 0 in 918
replace keep = 0 in 919
replace keep = 1 in 920
replace keep = 0 in 921
replace keep = 1 in 922
replace keep = 1 in 923
replace keep = 1 in 924
replace keep = 1 in 925
replace keep = 1 in 926
replace keep = 1 in 927
replace keep = 1 in 928
replace keep = 1 in 929
replace keep = 1 in 930
replace keep = 1 in 931
replace keep = 1 in 932
replace keep = 1 in 933
replace keep = 1 in 934
replace keep = 1 in 935
replace keep = 1 in 936
replace keep = . in 937
replace keep = 0 in 937
replace keep = 1 in 938
replace keep = 1 in 939
replace keep = 1 in 940
replace keep = 1 in 941
replace keep = 1 in 942
replace keep = 1 in 943
replace keep = 1 in 944
replace keep = 1 in 945
replace keep = 1 in 946
replace keep = 1 in 947
replace keep = 1 in 948
replace keep = 1 in 949
replace keep = 1 in 950
replace keep = 0 in 951
replace keep = 1 in 952
replace keep = 1 in 953
replace keep = 1 in 954
replace keep = 1 in 955
replace keep = 1 in 956
replace keep = 1 in 957
replace keep = 1 in 958
replace keep = 1 in 959
replace keep = 1 in 960
replace keep = 1 in 961
replace keep = 0 in 962
replace keep = 1 in 963
replace keep = 1 in 964
replace keep = 1 in 965
replace keep = 0 in 961
replace keep = 1 in 962
replace keep = 0 in 964
replace keep = 1 in 966
replace keep = 0 in 967
replace keep = 1 in 968
replace keep = 1 in 969
replace keep = 1 in 970
replace keep = 1 in 971
replace keep = 1 in 972
replace keep = 1 in 973
replace keep = 1 in 974
replace keep = 1 in 975
replace keep = 1 in 976
replace keep = 1 in 977
replace keep = 1 in 978
replace keep = 1 in 979
replace keep = 1 in 980
replace keep = 1 in 981
replace keep = 0 in 982
replace keep = 0 in 983
replace keep = 1 in 984
replace keep = 0 in 985
replace keep = 1 in 986
replace keep = 1 in 987
replace keep = 1 in 988
replace keep = 1 in 989
replace keep = 1 in 990
replace keep = 1 in 991
replace keep = 1 in 992
replace keep = . in 993
replace keep = 0 in 993
replace keep = 1 in 994
replace keep = 1 in 995
list name name_ocdel if keep == 0 & phone_gps == phone_ocdel
replace keep = 1 in 770
replace keep = 1 in 780
replace keep = 1 in 782
replace keep = 1 in 785
replace keep = 1 in 864
replace keep = 1 in 865
preserve
keep if _merge == 3 & keep == 1
drop _merge _keep
tempfile matched2
save `matched2'
clear
use `matched'
append using `matched2'
drop _merge keep
tempfile matched
save `matched'
clear
restore
keep if _merge == 1 | keep == 0
drop mpi-keep
tempfile master
save `master'
unique name address
unique address
unique name
duplicates tag name, gen(dup)
sort dup name
clear
use `ocdel'
rename name_ocdel name
rename address address_ocdel
tempfile ocdel
save `ocdel'
clear
use `master'
duplicates tag name, gen(dup)
sort dup name
clear
use `matched'
unique mpi
duplicates tag mpi, gen(dup)
drop dup
duplicates tag mpi, gen(dup)
sort dup name
sort dup mpi
drop in 1481
drop in 1482
replace mpi = "102388115-0001" in 1483
drop in 1484
drop in 1486
drop in 1487
drop in 1488
replace mpi = "102509337-0001" in 1489
replace address = "1419 W Courtland St" in 1489
drop in 1490
drop in 1492
unique mpi
drop dup
duplicates tag mpi, gen(dup)
sort dup mpi
drop in 1491
tempfile matched
save `matched'
use `ocdel'
unique mpi
merge 1:1 mpi using `matched'
keep if _merge ==1
clear
use `ocdel'
clear
use `matched'
clear
use `ocdel'
rename name name_ocdel
merge 1:1 mpi using `matched'
keep if _merge == 1
drop pspid-_merge
tempfile ocdel
save `ocdel'
unique name
unique address
unique address_ocdel
unique phone
unique address_ocdel phone_ocdel
duplicates tag name, gen(dup)
sort dup name
clear
use `master'
unique name
duplicates tag name, gen(dup)
sort dup name
drop dup
clear
use `ocdel'
rename name_ocdel name
duplicates tag name, gen(dup)
sort dup name
drop dup
tempfile ocdel
save `ocdel'
clear
use `master'
merge m:m name using `ocdel'
drop if _merge == 2
sort _merge
unique name
duplicates tag name, gen(dup)
sort _merge dup
clear
use `master'
duplicates tag name, gen(dup)
sort dup name
clear
use `ocdel'
duplicates tag name, gen(dup)
sort dup name
clear
use `master'
merge m:m name using `ocdel'
sort _merge
drop if _merge ==2
list address address_ocdel if _merge ==3
gen keep = .
replace keep = 0 in 687
replace keep = 0 in 693
replace keep = 0 in 694
replace keep = 0 in 699
replace keep = 0 in 710
replace keep = 0 in 712
replace keep = 0 in 713
replace keep = . in 713
replace keep = 0 in 718
replace keep = 0 in 723
replace keep = 0 in 729
preserve
keep if _merge == 3 & keep != 0
drop _merge
tempfile matched2
save `matched2'
clear
use `matched'
append using `matched2'
tempfile `matched'
tempfile matched
save `matched'
restore
keep if _merge == 1 | keep == 0
drop mpi-keep
tempfile master
save `master'
clear
use `ocdel'
merge 1:1 mpi using `matched'
keep if _merge == 1
drop pspid-_merge
tempfile ocdel
save `ocdel'
count if missing(phone_ocdel)
unique phone_ocdel
duplicates tag phone_ocdel, gen(dup)
sort dup phone
clear
use `master'
count if missing(phone)
replace address = subinstr(address,".","",.)
tempfile master
save `master'
clear
use `ocdel'
replace address_ocdel = subinstr(address_ocdel,".","",.)
rename address_ocdel address
tempfile ocdel
save `ocdel'
unique address
duplicates tag address, gen(dup)
sort dup address
drop dup
clear
use `master'
unique address
duplicates tag address, gen(dup)
sort dup address
drop dup
merge m:m address using `ocdel'
drop if _merge == 2
sort _merge address
clear
use `ocdel'
rename name name_ocdel
tempfile ocdel
save `ocdel'
clear
use `master'
merge m:m address using `ocdel'
drop if _merge == 2
sort _merge
list name name_ocdel if _merge ==3
gen keep = .
list name name_ocdel address if _merge ==3
drop in 639
list name name_ocdel if _merge ==3
replace keep = 0 in 639
replace keep = 0 in 640
replace keep = 0 in 641
replace keep = 0 in 642
replace keep = 0 in 643
replace keep = 0 in 644
replace keep = 0 in 645
replace keep = 1 in 646
replace keep = 0 in 647
replace keep = 0 in 648
replace keep = 1 in 649
replace keep = 0 in 650
replace keep = 0 in 651
save "Y:\GPS\Lucy Caffrey-Maffei\Data Projects\ECE\ocdel.dta"
replace keep = 0 in 652
replace keep = 0 in 653
replace keep = 1 in 654
replace keep = 0 in 655
drop in 656
drop in 655
drop in 653
drop in 639
drop in 640
drop in 640
drop in 641
drop in 643
drop in 643
drop in 645
drop in 645
replace keep = 0 in 646
replace keep = 0 in 647
replace address = "3033 W GLENWOOD AVENUE" in 647
drop in 648
replace keep = 0 in 648
replace keep = 0 in 649
replace keep = 0 in 650
drop in 651
replace keep = 0 in 651
replace address = "5000 N 11TH ST" in 652
replace zipcode = 19141 in 652
replace legaladdress = "5000 N 11TH ST" in 652
replace legalzipcode = 19151 in 652
replace legalzipcode = 19141 in 652
drop in 652
drop in 652
replace keep = 1 in 652
replace keep = 1 in 653
replace keep = 0 in 654
replace keep = 1 in 655
replace keep = 0 in 656
replace keep = 0 in 657
replace keep = 0 in 658
replace keep = 0 in 659
drop in 660
drop in 660
drop in 660
drop in 660
drop in 660
drop in 660
replace keep = 1 in 660
replace keep = 1 in 661
replace keep = 0 in 662
replace keep = 0 in 663
replace keep = 0 in 664
drop in 665
drop in 665
replace keep = 0 in 665
preserve
keep if keep == 1
tempfile matched2
save `matched2'
clear
use `matched'
append using `matched2'
drop keep _merge
tempfile matched
save `matched'
restore
drop if keep == 1
drop mpi-keep
tempfile master
save `master'
clear
use `ocdel
use `ocdel'
merge 1:1 mpi using `matched'
drop if _merge == 3 | _merge ==2
tempfile ocdel
save `ocdel'
clear
use `master'
gen mpi = .
tostring mpi, replace
replace mpi = "" if mpi == "."
replace mpi = "103368556-0001" in 611
replace mpi = "103342531-0002" in 648
replace mpi = "103381119-0001" in 645
preserve
keep if mpi != ""
tempfile matched2
save `matched2'
clear
use `matched'
append using `matched2'
unique mpi
duplicates tag mpi, gen(dup)
drop dup
duplicates tag mpi, gen(dup)
sort dup name
drop in 1541
drop in 1540
drop dup
tempfile matched
save `matched'
restore
drop if mpi !=""
tempfile master
save `master'
clear
use `matched'
clear
use `master'
gen mpi = .
drop mpi
gen mpi=.
tostring mpi, replace
replace mpi = "" if mpi == "."
replace mpi = "102201566-0004" in 410
preserve
keep if mpi!=""
tempfile matched2
save `matched2'
clear
use `matched'
append using `matched2'
drop in 519
tempfile matched
save `matched'
clear
restore
drop if mpi!=""
drop mpi
tempfile master
save `master'
clear
use `ocdel'
match 1:1 mpi using `matched'
merge 1:1 mpi using `matched'
drop _merge
merge 1:1 mpi using `matched'
drop if _merge == 3 | _merge == 2
tempfile ocdel
save `ocdel'
