/datum/action/cooldown/spell/aoe/hive_rally
	name = "Hive Rythms"
	desc = "We send out a burst of psionic energy, invigorating us and nearby awakened vessels, removing any stuns."
	panel = "Hivemind Abilities"
	charge_max = 3000
	cast_range = 7
	invocation_type = "none"
	spell_requirements = NONE
	button_icon = 'massmeta/icons/mob/actions/actions_hive.dmi'
	background_icon_state = "bg_hive"
	button_icon_state = "rally"

/datum/action/cooldown/spell/aoe/hive_rally/get_things_to_cast_on(atom/center)
	RETURN_TYPE(/list)

	var/list/things = list()
	var/datum/antagonist/hivemind/hive = owner.mind.has_antag_datum(/datum/antagonist/hivemind)
	// Default behavior is to get all atoms in cast_range, center and owner not included.
	for(var/mob/living/carbon/human/nearby_thing in cast_range(aoe_radius, center))
		if(!istype(nearby_thing))
			continue
		if(nearby_thing == owner || nearby_thing == center)
			continue
		if(nearby_thing.stat == DEAD)
			continue

		if(!IS_HIVEHOST(nearby_thing))
			var/datum/mind/mind = nearby_thing.mind
			if(!(mind in hive.avessels))
				continue

		things += nearby_thing

	return things

/datum/action/cooldown/spell/aoe/hive_rally/cast_on_thing_in_aoe(atom/victim, atom/caster)
	var/mob/living/carbon/affected = victim
	if(!istype(affected))
		return
	to_chat(affected, "<span class='assimilator'>Otherworldly strength flows through us!</span>")
	affected.SetSleeping(0)
	affected.SetUnconscious(0)
	affected.SetStun(0)
	affected.SetKnockdown(0)
	affected.SetImmobilized(0)
	affected.SetParalyzed(0)
	affected.adjustStaminaLoss(-200)
	flash_color(affected, flash_color="#800080", flash_time=10)
