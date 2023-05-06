GLOBAL_LIST_INIT(psionic_pathes, subtypesof(/datum/psionic_path))

/datum/psionic_path
	var/name = "Amogus"
	var/desc = "Sus"

	var/icon_state = "psiblade_long"

	var/datum/component/psionics/psi_component
	var/list/spell_map = list(
		/datum/action/cooldown/spell = 1
	)

/datum/psionic_path/proc/on_level_advance()
/*	for (var/progression_level in 1 to psi_component.psi_level_max)
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
			power = new power ()
			power.Grant(psi_component.psionic_mob)*/ //Doesn't work(
	return

/datum/psionic_path/proc/on_assign(datum/component/psionics/new_component, debug = FALSE)
	psi_component = new_component
	psi_component.path_spell.Remove(psi_component.psionic_mob)
	var/amount = min(psi_component.psi_levels_unspent, psi_component.psi_level_max) //convert inactiva points to active
	if(amount)
		psi_component.psi_levels_unspent -= amount
		psi_component.add_level(null, amount, FALSE)
		if(debug)
			to_chat(psi_component.psionic_mob, span_notice("[amount] inactive levels converted"))
	on_level_advance()
	qdel(psi_component.path_spell)

/*/datum/psionic_path/proc/on_special_progression_effect(effect_string, progression_level)
	return*/

/datum/psionic_path/fabricator
	name = "Fabricator"
	desc = "A path, that allows you to form weapons and various tools from your energy"
	/*spell_map = list (
		/datum/action/cooldown/spell/form_item/psiblade = 1,
		/datum/action/cooldown/spell/form_item/psiblade/tool = 2,
		"change_tool_and_weapon" = 3,
		/datum/action/cooldown/spell/form_item/psiblade/gun = 4,
	)*/

	var/datum/action/cooldown/spell/form_item/psiblade/blade_spell
	var/datum/action/cooldown/spell/form_item/psiblade/tool/tool_spell
	var/datum/action/cooldown/spell/form_item/psiblade/gun/gun_spell

/datum/psionic_path/fabricator/on_level_advance()
	if(psi_component.psi_level >= 1)
		if(!blade_spell || QDELETED(blade_spell))
			blade_spell = new blade_spell (psi_component.psionic_mob)
			blade_spell.Grant(psi_component.psionic_mob)
	else
		blade_spell.Remove(psi_component.psionic_mob)
		qdel(blade_spell)
		blade_spell = null

	if(psi_component.psi_level >= 2)
		if(!tool_spell || QDELETED(tool_spell))
			tool_spell = new tool_spell (psi_component.psionic_mob)
			tool_spell.Grant(psi_component.psionic_mob)
	else
		tool_spell.Remove(psi_component.psionic_mob)
		qdel(tool_spell)
		tool_spell = null

	if(psi_component.psi_level >= 3)
		blade_spell.weapon_type = /obj/item/melee/psiblade
		tool_spell.weapon_type = /obj/item/debug/omnitool/psi_tool/better
	else
		if(blade_spell)
			blade_spell.weapon_type = initial(blade_spell.weapon_type)
		if(tool_spell)
			tool_spell.weapon_type = initial(tool_spell.weapon_type)

	if(psi_component.psi_level >= 4)
		if(!gun_spell || QDELETED(gun_spell))
			gun_spell = new gun_spell (psi_component.psionic_mob)
			gun_spell.Grant(psi_component.gun_spell)
	else
		gun_spell.Remove(psi_component.gun_spell)
		qdel(gun_spell)
		gun_spell = null

/*/datum/psionic_path/fabricator/on_special_progression_effect(effect_string, progression_level)
	if("change_tool_and_weapon")
		for(var/datum/action/cooldown/spell/form_item/form_spell in psi_component.psionic_mob.actions)
			if(istype(form_spell, /datum/action/cooldown/spell/form_item/psiblade))
				if(progression_level <= psi_component.psi_level)
					form_spell.weapon_type = /obj/item/melee/psiblade
				else
					form_spell.weapon_type = /obj/item/melee/psiblade/short
			
			if(istype(form_spell, /datum/action/cooldown/spell/form_item/psiblade/tool))
				if(progression_level <= psi_component.psi_level)
					form_spell.weapon_type = /obj/item/debug/omnitool/psi_tool/better
				else
					form_spell.weapon_type = /obj/item/debug/omnitool/psi_tool
*/
