//////////////////////////////////////////////
//                                          //
//               CLOCKCULT                  //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/clockcult
	name = "Clockcult"
	antag_flag = ROLE_SERVANT_OF_RATVAR
	antag_datum = /datum/antagonist/servant_of_ratvar
	restricted_roles = list(
		JOB_AI,
		JOB_CAPTAIN,
		JOB_CHAPLAIN,
		JOB_CYBORG,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	required_candidates = 4
	weight = 0 //W.I.P.
	cost = 20
	requirements = list(100,90,80,60,40,30,10,10,10,10)
	required_candidates = 4
	flags = HIGH_IMPACT_RULESET
	antag_cap = list("denominator" = 20, "offset" = 1)

	var/datum/team/clock_cult/main_cult
	var/list/selected_servants = list()

/datum/dynamic_ruleset/roundstart/clockcult/pre_execute()
	//Load Reebe
	LoadReebe()
	//Make cultists
	var/starter_servants = 4
	var/number_players = mode.roundstart_pop_ready
	if(number_players > 30)
		number_players -= 30
		starter_servants += round(number_players / 10)
	starter_servants = min(starter_servants, 8)
	for (var/i in 1 to starter_servants)
		var/mob/servant = pick_n_take(candidates)
		assigned += servant.mind
		servant.mind.assigned_role = ROLE_SERVANT_OF_RATVAR
		servant.mind.special_role = ROLE_SERVANT_OF_RATVAR
	//Generate scriptures
	generate_clockcult_scriptures()
	return TRUE

/datum/dynamic_ruleset/roundstart/clockcult/execute()
	var/list/spawns = GLOB.servant_spawns.Copy()
	main_cult = new
	main_cult.setup_objectives()
	//Create team
	for(var/datum/mind/servant_mind in assigned)
		servant_mind.current.forceMove(pick_n_take(spawns))
		servant_mind.current.set_species(/datum/species/human)
		var/datum/antagonist/servant_of_ratvar/S = add_servant_of_ratvar(servant_mind.current, team=main_cult)
		S.equip_carbon(servant_mind.current)
		S.equip_servant()
		S.prefix = CLOCKCULT_PREFIX_MASTER
	//Setup the conversion limits for auto opening the ark
	calculate_clockcult_values()
	return ..()
