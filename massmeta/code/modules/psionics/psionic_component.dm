/datum/component/psionics
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/awakened = FALSE
	var/awakened_source

	var/psi_level = 0
	var/psi_levels_unspent = 0
	var/psi_level_max = 4

	var/psi_energy = 0
	var/psi_energy_max = 100
	var/energy_regen = 2

	var/mob/living/psionic_mob
	var/datum/psionic_path/psi_path
	var/datum/action/cooldown/spell/pick_path/path_spell

/datum/component/psionics/Initialize(latent = TRUE, psi_levels = 1, awakening_thing = null)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	psi_levels_unspent = psi_levels
	psionic_mob = parent
	if(!latent)
		wake_up(null, awakening_thing)

/datum/component/psionics/RegisterWithParent()
	RegisterSignal(parent, COMSIG_PSIONIC_HAS_ENERGY, PROC_REF(has_energy))
	RegisterSignal(parent, COMSIG_PSIONIC_ADVANCE_LEVEL, PROC_REF(add_level))
	RegisterSignal(parent, COMSIG_PSIONIC_ASSIGN_PATH, PROC_REF(assign_path))
	RegisterSignal(parent, COMSIG_PSIONIC_SPEND_ENERGY, PROC_REF(try_spend_energy))
	RegisterSignal(parent, COMSIG_PSIONIC_CHECK_PATH, PROC_REF(return_path))
	RegisterSignal(parent, COMSIG_PSIONIC_AWAKEN, PROC_REF(wake_up))
	RegisterSignal(parent, COMSIG_PSIONIC_DEACTIVATE, PROC_REF(unactivate))
	RegisterSignal(parent, COMSIG_LIVING_LIFE, PROC_REF(on_mob_life))

/datum/component/psionics/proc/has_energy(datum/source, amount, feedback)
	SIGNAL_HANDLER

	if(psi_energy >= amount && awakened)
		return COMPONENT_HAS_PSIONIC_ENERGY

	if(feedback && awakened)
		psionic_mob.balloon_alert(psionic_mob, "low energy!")

	return COMPONENT_NO_PSIONIC_ENERGY

/datum/component/psionics/proc/add_level(datum/source, amount, only_active_levels = FALSE, req_awakened = FALSE, feedback = FALSE)
	SIGNAL_HANDLER

	if(psi_level >= psi_level_max)
		if(only_active_levels && amount > 0)
			if(feedback)
				psionic_mob.balloon_alert(psionic_mob, "at maximum level!")
			return COMPONENT_PSIONIC_NO_ADVANCE

	if(req_awakened && !awakened)
		if(feedback)
			psionic_mob.balloon_alert(psionic_mob, "powers unactive!")
		return COMPONENT_PSIONIC_NO_ADVANCE

	if(!psi_path && only_active_levels)
		if(feedback)
			psionic_mob.balloon_alert(psionic_mob, "choose a path first!")
		return COMPONENT_PSIONIC_NO_ADVANCE

	if((psi_level >= psi_level_max && !only_active_levels) || !awakened)
		psi_levels_unspent += 1
	else
		psi_level += 1
		psi_path.on_level_advance()

/datum/component/psionics/proc/assign_path(datum/source, datum/psionic_path/new_psionic_path)
	SIGNAL_HANDLER

	var/datum/psionic_path/new_psipath
	if(!ispath(new_psionic_path))
		new_psipath = new_psionic_path
		if(!istype(new_psipath))
			return
	else
		new_psipath = new new_psionic_path()
	psi_path = new_psipath
	new_psipath.on_assign(src)

/datum/component/psionics/proc/try_spend_energy(datum/source, amount, feedback)
	SIGNAL_HANDLER

	var/result = has_energy(source, amount, feedback)
	if(result & COMPONENT_NO_PSIONIC_ENERGY)
		return COMPONENT_NO_PSIONIC_ENERGY //Cursed
	adjust_energy(-amount)

/datum/component/psionics/proc/adjust_energy(amount)
	psi_energy += max(min(psi_energy_max, psi_energy + amount), 0)

/datum/component/psionics/proc/on_mob_life()
	SIGNAL_HANDLER

	adjust_energy(energy_regen)

/datum/component/psionics/proc/wake_up(datum/source, awakening_thing)
	SIGNAL_HANDLER

	if(awakened)
		return COMPONENT_PSIONIC_AWAKENING_FAILED

	awakened = TRUE
	awakened_source = awakening_thing
	psionic_mob.playsound_local(get_turf(psionic_mob), 'sound/ambience/antag/bloodcult.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	to_chat(psionic_mob, span_reallybig(span_hypnophrase("Your psionic powers have awoken")))
	assign_path(source, /datum/psionic_path/fabricator)

	return COMPONENT_PSIONIC_AWAKENING_SUCESSFULL

/datum/component/psionics/proc/unactivate(datum/source, force, unawakening_thing)
	SIGNAL_HANDLER

	if(!force && unawakening_thing != awakened_source)
		return
	awakened_source = null
	if(path_spell)
		qdel(path_spell)
		path_spell = null
	psi_levels_unspent += psi_level
	psi_level = 0
	awakaned = FALSE
	psi_path.on_level_advance()

/datum/component/psionics/proc/return_path(datum/source)
	SIGNAL_HANDLER

	return psi_path ? psi_path : FALSE
