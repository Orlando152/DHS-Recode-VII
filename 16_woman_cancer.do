*w_papsmear	Women received a pap smear  (1/0)
gen w_papsmear = .

*w_mammogram	Women received a mammogram (1/0)
gen w_mammogram = .

capture confirm variable s714dd s714ee
if _rc==0 {
    replace w_papsmear=1 if s714dd==1 & s714ee==1
	replace w_papsmear=0 if s714dd==0 | s714ee==0
	replace w_papsmear=. if s714dd==9 | s714ee==9
}


capture confirm variable s1017 s1020
if _rc==0 {
    replace w_mammogram=. if s1017==. | s1017==9 | s1020==9
}

* SouthAfrica2016 
if inlist(name,"SouthAfrica2016") {
	tempfile tpf1
	drop w_papsmear
	preserve
		use "${SOURCE}/DHS-`name'/DHS-`name'wm.dta", clear	
		gen w_papsmear = s1407 if !inlist(s1407,.,8) // period: 3yr, 4-5, 6-10, >10 
		keep w_* caseid
		sort caseid
		save `tpf1'
	restore
	merge 1:1 caseid using `tpf1'
	tab _m
	drop if _m ==2 // for _m ==2, variables necessary for 4.do and 5.do are all missing
	drop _m
}
