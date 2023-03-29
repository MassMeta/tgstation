/datum/action/cooldown/spell/hive_loyal
	name = "Concentrated Infiltration"
	desc = "We prepare for a focused attack on a mind, penetrating mindshield technology, the mindshield will still be present after the attack (toggle)."
	panel = "Hivemind Abilities"
	charge_max = 1
	invocation_type = "none"
	clothes_req = 0
	human_req = 1
	action_icon = 'massmeta/icons/mob/actions/actions_hive.dmi'
	action_background_icon_state = "bg_hive"
	action_icon_state = "loyal"
	antimagic_allowed = TRUE

/datum/action/cooldown/spell/hive_loyal/cast(atom/cast_on)
	var/mob/living/user = owner
	var/datum/antagonist/hivemind/hive = user.mind.has_antag_datum(/datum/antagonist/hivemind)
	if(!hive)
		to_chat(user, "<span class='notice'>This is a bug. Error:HIVE1</span>")
		return
	var/datum/action/cooldown/spell/pointed/hive_add/the_spell = locate(/datum/action/cooldown/spell/pointed/hive_add/hive_add) in user.actions
	if(!the_spell)
		to_chat(user, "<span class='notice'>This is a bug. Error:HIVE5</span>")
		return
	the_spell.ignore_mindshield = !active
	to_chat(user, "<span class='notice'>We [active?"let our minds rest and ease up on our concentration.":"prepare to spear through mindshielding technology!"]</span>")
