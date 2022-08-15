/* I used this code mainly for my tables to transfer them to excel. The code for the graphics is outdated*/


** Tables
local estimation_length = est_length
local xx = event_length_post+event_length_pre+1
local regtype = reg_type
local xxx = No

putexcel set output_`estimation_length'_`xx'_`regtype'_`xxx', replace 
putexcel A1=matrix(output_phases), names //nformat(number_d2)

putexcel set output_`estimation_length'_`xx'_`regtype'_`xxx', modify 
putexcel H1=matrix(output_days), names //nformat(number_d2)

/*
** Graphs
capture drop CAR*
capture drop dev_graph

forvalues t = -$pre(1)$post {
    local nom = `t' + event_length_pre + 1
    capture gen dev_graph = . 
    replace dev_graph = `t' if _n == `nom'
}


foreach x in bg cz dk fi de el hu it nl pl pt ro sk si es uk xx {
	foreach y in main alt new rev follow leak canc parl nuc {
		forvalues i = 1(1)10 {
			capture confirm scalar `x'_`y'`i'_d
			if _rc == 0 {
                forvalues t = -$pre(1)$post {
                    local nom = `t' + event_length_pre + 1
                    capture gen CAR_`x'_`y'`i' = .
                    replace CAR_`x'_`y'`i' = CAR`nom'_`x'_`y'`i' if _n == `nom'
			    }
			}
		}
	}
}

forvalues t = -$pre(1)$post {
    local nom = `t' + event_length_pre + 1
    capture gen CAR_avg = .
    replace CAR_avg = CAR_d`nom'_avg if _n == `nom'
}
*/