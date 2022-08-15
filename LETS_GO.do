
*** SET WD
	cd ""
	
*** IMPORT DATA
	clear all
	import delimited "Data.csv"
	/* Install package mmerge!*/

*** PREP DATA
	quietly do data_prep

*** DATA DESCRIPTIVE
	// quietly do data_descriptive // ignore, not necessary
		
*** GENERATE (AB)NORMAL RETURNS

	** Define scalars/matrices

		* Test one specific date only (independent of country exit dates)
			scalar test_specific_date = "no" // "yes" when determining one specific date only; must be unequal "yes" when analysing countries' coal phase-outs
			scalar date_specific = 20190126 // determine date to be tested if test_specific_date == "yes"

		* Phase out announcements
			quietly do phase_out

		* Event Study Settings
			scalar event_length_pre = 3 // length of event window pre event (days)
			scalar event_length_post = 3 // length of event window post event (days)

			scalar est_length = 255 // length of estimation window (days)
			scalar earliest_date = 20080314 // earliest date for estimation window; no need to change
						
			scalar reg_type = 3 // 1: constant mean return 2: zero mean return 3: main abatement cost model (all log returns) 5: same as 3, but using differenced log returns for coal and gas
			
			scalar show_days = 1 // 1: show not only pre / post estimations but also every single day
			
			scalar price = "yes" // price event study (default)
			scalar volume = "n" // volume event study

	quietly do event_study

*** Postestimation: Test significance
	quietly do post_estimation
	do matrices