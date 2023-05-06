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

	var/path_choices = list()

	for (var/_the_path in GLOB.psionic_pathes)
		var/datum/psionic_path/the_path = _the_path
		var/image/path_icon = image('massmeta/icons/obj/psychic_powers.dmi', the_path.icon_state)

		var/info_text = span_boldnotice("[initial(the_path.name)]")
		info_text += "<br>[span_notice("[initial(the_path.desc)]")]"

		var/datum/radial_menu_choice/choice = new
		choice.image = path_icon
		choice.info = info_text

		path_choices[initial(the_path.name)] = choice


	var/path_result = show_radial_menu(owner, owner, path_choices, radius = 6, tooltips = TRUE)
	if (isnull(path_result))
		return

	if (SEND_SIGNAL(owner, COMSIG_PSIONIC_CHECK_PATH))
		return

	for (var/_other_path in GLOB.psionic_pathes)
		var/datum/psionic_path/other_path = _other_path
		if (initial(other_path.name) == path_result)
			SEND_SIGNAL(owner, COMSIG_PSIONIC_ASSIGN_PATH, path_result)
			return

/datum/action/cooldown/spell/form_item
	var/weapon_type = /obj/item
	var/obj/item/summoned_item
	var/remove_verb = "dispell"

/datum/action/cooldown/spell/form_item/cast(mob/living/cast_on)
	. = ..()
	if(summoned_item && !QDELETED(summoned_item))
		owner.visible_message(span_notice("[owner] [remove_verb]s [summoned_item.name]."), span_notice("You [remove_verb] the [summoned_item.name]."))
		qdel(summoned_item)
		summoned_item = null
	else
		var/energy_check = SEND_SIGNAL(owner, COMSIG_PSIONIC_SPEND_ENERGY, psi_cost)
		if(energy_check & COMPONENT_NO_PSIONIC_ENERGY)
			owner.balloon_alert(owner, "not enough energy!")
			return
		var/mob/living/carbon/carbon_user = owner
		if(!istype(carbon_user))
			carbon_user.balloon_alert(carbon_user, "not in this form!")
			return
		var/obj/item/held = carbon_user.get_active_held_item()
		if(held && !carbon_user.dropItemToGround(held))
			carbon_user.balloon_alert(carbon_user, "hand occupied!")
			return
		var/item/summoned_item/W = new weapon_type(carbon_user)
		carbon_user.put_in_hands(W)

//Psiforge path spells

/datum/action/cooldown/spell/form_item/psiblade
	name = "Form Psionic Blade"
	desc = "Form a psionic blade in your active hand, the blade gets stronger if you are a level 3 psionic. Costs 30 psi energy to activate."

	sound = 'sound/magic/disable_tech.ogg'

	button_icon = 'massmeta/icons/obj/psychic_powers.dmi'
	button_icon_state = "psiblade_long"

	cooldown_time = 0
	cooldown_reduction_per_rank = 0
	spell_requirements = SPELL_NO_FEEDBACK | SPELL_REQUIRES_PSI

	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_INCAPACITATED | AB_CHECK_CONSCIOUS

	invocation_type = INVOCATION_NONE
	psi_cost = 30

	weapon_type = /obj/item/melee/psiblade/short

/datum/action/cooldown/spell/form_item/psiblade/tool
	name = "Form Psionic Tool"
	desc = "Form a psionic tool in your active hand, it's tool behaviour can be changed at your will. Costs 20 psi energy to activate."

	button_icon_state = "tinker"

	psi_cost = 20

	weapon_type = /obj/item/debug/omnitool/psi_tool

/datum/action/cooldown/spell/form_item/psiblade/gun
	name = "Form Psionic Gun"
	desc = "Form a psionic gun in your active hand, it has 6 shots and can't be dropped or recharged. Costs 55 psi energy to activate."

	button_icon = 'icons/effects/effects.dmi'
	button_icon_state = "plasmasoul"

	psi_cost = 55

	weapon_type = /obj/item/gun/energy/e_gun/mini/psionic

