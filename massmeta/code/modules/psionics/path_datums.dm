/datum/psionic_path
	var/name = "Amogus"
	var/desc = "Sus"

	var/datum/component/psionics/psi_component
	var/list/spell_map()

/datum/psionic_path/proc/on_level_advance()
	return

/datum/psionic_path/proc/on_assign(/datum/component/psionics/new_component)
	psi_component = new_component
