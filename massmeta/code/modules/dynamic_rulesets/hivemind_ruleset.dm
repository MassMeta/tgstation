
//////////////////////////////////////////////
//                                          //
//             ASSIMILATION                 //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/hivemind
	name = "Assimilation"
	antag_flag = ROLE_HIVE
	antag_datum = /datum/antagonist/hivemind
	protected_roles = list(JOB_NAME_SECURITYOFFICER, JOB_NAME_WARDEN, JOB_NAME_DETECTIVE,JOB_NAME_HEADOFSECURITY, JOB_NAME_CAPTAIN)
	restricted_roles = list(JOB_NAME_AI, JOB_NAME_CYBORG)
	required_candidates = 3
	weight = 3
	cost = 30
	requirements = list(100,90,80,60,40,30,10,10,10,10)
	flags = HIGH_IMPACT_RULESET

/datum/dynamic_ruleset/roundstart/hivemind/pre_execute(population)
	. = ..()
	var/num_hosts = max( 3 , rand(0,1) + min(8, round(population / 8) ) )
	for (var/i = 1 to num_hosts)
		var/mob/M = pick_n_take(candidates)
		assigned += M.mind
		M.mind.restricted_roles = restricted_roles
		M.mind.special_role = ROLE_HIVE
	return TRUE

/datum/dynamic_ruleset/roundstart/hivemind/execute()
	for(var/datum/mind/host in assigned)
		var/datum/antagonist/hivemind/new_antag = new antag_datum()
		host.add_antag_datum(new_antag)
	return TRUE
