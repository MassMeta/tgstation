// This spell exists mainly for debugging purposes, and also to show how casting works
/datum/action/cooldown/spell/pick_path
	name = "Pick Path"
	desc = "Pick your psionic path."

	cooldown_time = 5 SECONDS
	cooldown_reduction_per_rank = 1.25 SECONDS
	spell_requirements = SPELL_NO_FEEDBACK | SPELL_REQUIRES_PSI

	invocation_type = INVOCATION_NONE
    psi_cost = 0

/datum/action/cooldown/spell/pick_path/cast(mob/living/cast_on)
	. = ..()

	path_choices = list()

	for (var/_the_path in GLOB.psionic_pathes)
        var/datum/psionic_path/the_path = _the_path
		var/image/path_icon = image('icons/mob/nonhuman-player/blob.dmi', the_path.icon_state)

		var/info_text = span_boldnotice("[initial(the_path.name)]")
		info_text += "<br>[span_notice("[initial(the_path.desc)]")]"

		var/datum/radial_menu_choice/choice = new
		choice.image = path_icon
		choice.info = info_text

		path_choices[initial(path.name)] = choice


	var/path_result = show_radial_menu(owner, owner, path_choices, radius = BLOB_REROLL_RADIUS, tooltips = TRUE)
	if (isnull(path_result))
		return

	if (SEND_SIGNAL(owner, COMSIG_PSIONIC_CHECK_PATH))
		return

	for (var/_other_path in GLOB.psionic_pathes)
		var/datum/psionic_path/other_path = _other_path
		if (initial(other_path.name) == path_result)
            SEND_SIGNAL(owner, COMSIG_PSIONIC_ASSIGN_PATH, path_result)

			return
