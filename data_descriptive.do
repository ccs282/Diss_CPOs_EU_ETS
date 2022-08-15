** mean log returns
	
	summ ln_return_eua if date >= 20071003 & date <= 20140205 // compare to Deeney et al. (2016); mean -0.000815; SD 0.03294; min -0.43208; max 0.24525; obs 1625
	
	summ ln_return_eua if date >= 20080324 & date <= 20121019 // compare to Kemden et al. (2016); mean −0.000866; SD 0.026732; min −0.116029; max 0.245247; obs 1194
		
	summ ln_return_eua if date >= 20080314 & date <= 20140430 // compare to Koch et al. (2014); mean -0.23 [-.00088123 daily]; SD 0.56 [.03466313 daily]; annualised values!!! for log returns, divide by 261; for SD divide by sqrt(261); assume 261 trading days (my calcuations)
	di -0.23/261
	di 0.56/sqrt(261)
	
	* explanatory variables
		foreach var of global ln_return_explanatory { 
			summ `var' if date >= 20080314 & date <= 20120430 // compare to Koch et al. (2014)
			di "mean `var':"
			di r(mean)*261
			di "SD `var':"
			di r(sd)*sqrt(261)
		}
				
/*
capture drop abn_*
forvalues j = -258(1)-4 { // distribution abnormal returns estimation window

				foreach x in bg cz dk fi de el hu it nl pl pt ro sk si es uk xx {
					foreach y in main alt new rev follow leak canc parl nuc {
						forvalues i = 1(1)10 {
							capture confirm scalar `x'_`y'`i'_d
							if _rc == 0 {
								summ AR_`x'_`y'`i' if deviation_`x'_`y'`i' == `j', meanonly
								capture gen abn_`x'_`y'`i' = .
								replace abn_`x'_`y'`i' = r(mean) if _n == `j' + 259
							}
						}
					}
				}
}

capture drop abn_avg
egen abn_avg = rowmean(abn_*)

hist abn_avg, normal
*/