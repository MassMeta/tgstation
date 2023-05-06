GLOBAL_LIST_INIT(psionic_pathes, subtypesof(/datum/psionic_path))

/datum/psionic_path
	var/name = "Amogus"
	var/desc = "Sus"

	var/icon_state = "psiblade_long"

	var/datum/component/psionics/psi_component
	var/list/spell_map = list(
		1 = /datum/action/cooldown/spell
	)

/datum/psionic_path/proc/on_level_advance()
	var/new_level = psi_component.psi_level
	for (var/progression_level in 1 to psi_component.psi_level_max)
		var/datum/action/cooldown/spell/power = spell_map[progression_level]
		if(!istype(power))
			on_special_progression_effect(power, progression_level)
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
	var/amount = min(psi_component.psi_levels_unspent, psi_component.psi_level_max)
	if(amount)
		psi_component.psi_levels_unspent -= amount
		psi_component.add_level(null, amount, FALSE)
	qdel(psi_component.path_spell)

/datum/psionic_path/fabricator
	name = "Fabricator"
	desc = "A path, that allows you to form weapons and various tools from your energy"
	spell_map = list (
		1 = /datum/action/cooldown/spell/form_item/psiblade,
		2 = /datum/action/cooldown/spell/form_item/psiblade/tool,
		3 = "change_tool_and_weapon",
		4 = /datum/action/cooldown/spell/form_item/psiblade/gun,
	)

/datum/psionic_path/proc/on_special_progression_effect(effect_string, progression_level)
	if("change_tool_and_weapon")
		for(var/datum/action/cooldown/spell/form_item/form_spell in psi_component.psionic_mob.actions)
			if(istype(/datum/action/cooldown/spell/form_item/psiblade))
				if(progression_level <= psi_component.psi_level)
					weapon_type = /obj/item/melee/psiblade
				else
					weapon_type = /obj/item/melee/psiblade/short
			
			if(istype(/datum/action/cooldown/spell/form_item/psiblade/tool))
				if(progression_level <= psi_component.psi_level)
					weapon_type = /obj/item/debug/omnitool/psi_tool/better
				else
					weapon_type = /obj/item/debug/omnitool/psi_tool
