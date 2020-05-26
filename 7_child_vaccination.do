
******************************
*** Child vaccination ********
******************************

*c_measles	child			Child received measles1/MMR1 vaccination
    gen c_measles  = inlist(h9,1,2,3)    if h9<=3

*c_dpt1	child			Child received DPT1/Pentavalent 1 vaccination
  cap g h51=.
    gen c_dpt1  = (inlist(h3,1,2,3) |inlist(h51,1,2,3))   if (h3<=3 | h51<=3)

*c_dpt2	child			Child received DPT2/Pentavalent2 vaccination
  cap g h52=.
    gen c_dpt2  = (inlist(h5,1,2,3) |inlist(h52,1,2,3))   if (h5<=3 | h52<=3)

*c_dpt3	child			Child received DPT3/Pentavalent3 vaccination
  cap g h53=.
    gen c_dpt3  = (inlist(h7,1,2,3) |inlist(h53,1,2,3))   if (h7<=3 | h53<=3)

*c_bcg	child			Child received BCG vaccination
		gen c_bcg  = inlist(h2,1,2,3)   if h2<=3

*c_polio: OPV
    gen cpolio0  = inlist(h0,1,2,3) if h0<=3

*c_polio1	child			Child received polio1/OPV1 vaccination
		gen c_polio1  = inlist(h4,1,2,3) if h4<=3

*c_polio2	child			Child received polio2/OPV2 vaccination
		gen c_polio2  = inlist(h6,1,2,3) if h6<=3

*c_polio3	child			Child received polio3/OPV3 vaccination
		gen c_polio3  = inlist(h8,1,2,3) if h8<=3

*c_fullimm	child			Child fully vaccinated
		gen c_fullimm =.  										/*Note: polio0 is not part of allvacc- see DHS final report*/
		replace c_fullimm =1 if (c_measles==1 & c_dpt1 ==1 & c_dpt2 ==1 & c_dpt3 ==1 & c_bcg ==1 & c_polio1 ==1 & c_polio2 ==1 & c_polio3 ==1)
		replace c_fullimm =0 if (c_measles==0 | c_dpt1 ==0 | c_dpt2 ==0 | c_dpt3 ==0 | c_bcg ==0 | c_polio1 ==0 | c_polio2 ==0 | c_polio3 ==0)
    replace c_fullimm =. if b5 ==0
