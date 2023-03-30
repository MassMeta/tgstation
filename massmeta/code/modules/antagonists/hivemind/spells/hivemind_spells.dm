/datum/action/cooldown/spell/target_hive
	panel = "Hivemind Abilities"
	invocation_type = "none"
	button_icon = 'massmeta/icons/mob/actions/actions_hive.dmi'
	background_icon_state = "bg_hive"
	button_icon_state = "spell_default"
	spell_requirements = SPELL_REQUIRES_HUMAN
	var/target_external = 0 //Whether or not we select targets inside or outside of the hive


/datum/action/cooldown/spell/target_hive/proc/choose_targets()
	var/mob/living/user = owner
	var/datum/antagonist/hivemind/hive = user.mind.has_antag_datum(/datum/antagonist/hivemind)
	if(!hive || !hive.hivemembers)
		to_chat(user, "<span class='notice'>This is a bug. Error:HIVE1</span>")
		return
	var/list/possible_targets = list()
	var/list/targets = list()

	if(target_external)
		for(var/mob/living/carbon/H in range(range, user))
			if(user == H)
				continue
			if(!can_target(H))
				continue
			if(!hive.is_carbon_member(H))
				possible_targets += H
	else
		possible_targets = hive.get_carbon_members()
		if(range)
			possible_targets &= range(range, user)

	var/mob/living/carbon/human/H = input("Choose the target for the spell.", "Targeting") as null|mob in possible_targets
	targets += H
	return targets

