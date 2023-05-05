GLOBAL_LIST_INIT(psionic_pathes, subtypesof(/datum/psionic_path))

/datum/psionic_path
	var/name = "Amogus"
	var/desc = "Sus"

	var/icon_state = "sussymogus"

	var/datum/component/psionics/psi_component
	var/list/spell_map(
		1 = /datum/action/cooldown/spell
	)

/datum/psionic_path/proc/on_level_advance()
	var/new_level = psi_component.psi_level
	for (var/progression_level in 1 to psi_component.psi_level_max)
		var/datum/action/cooldown/spell/power = spell_map[progression_level]
		if(!istype(power))
			continue
		var/datum/action/has_action = null
		for(var/datum/action in psi_component.psionic_mob.actions)
			if(istype(action, power))
				has_action = action
				break
		if(has_action)
			if(progression_level > psi_component.psi_level)
				has_action.Remove(psi_component.psionic_mob)
				qdel(has_action)
		else if(progression_level <= psi_component.psi_level)
			power = new spell_map[progression_level] ()
			power.Grant(psi_component.psionic_mob)

/datum/psionic_path/proc/on_assign(/datum/component/psionics/new_component)
	psi_component = new_component
	psi_component.path_spell.Remove(psi_component.psionic_mob)
	var/amount = psi_component.psi_levels_unspent
	if(amount)
		psi_component.psi_levels_unspent = 0
		psi_component.add_level(amount)
	qdel(psi_component.path_spell)
