/proc/is_hivemember(mob/living/L)
	if(!L)
		return FALSE
	var/datum/mind/M = L.mind
	if(!M)
		return FALSE
	for(var/datum/antagonist/hivemind/H as() in GLOB.hivehosts)
		if(H.hivemembers.Find(M))
			return TRUE
	return FALSE

/proc/remove_hivemember(mob/living/L) //Removes somebody from all hives as opposed to the antag proc remove_from_hive()
	var/datum/mind/M = L?.mind
	if(!M)
		return
	for(var/datum/antagonist/hivemind/H as() in GLOB.hivehosts)
		if(H.hivemembers.Find(M))
			H.remove_hive_overlay(M.current)
			H.hivemembers -= M
			H.calc_size()
	var/datum/antagonist/hivevessel/V = IS_WOKEVESSEL(L)
	if(V && M)
		M.remove_antag_datum(/datum/antagonist/hivevessel)
