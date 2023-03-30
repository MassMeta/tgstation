/datum/action/cooldown/spell/forcewall/hive
	name = "Telekinetic Field"
	desc = "Our psionic powers form a barrier around us in the physical world that only we can pass through."
	panel = "Hivemind Abilities"
	charge_max = 600
	clothes_req = 0
	human_req = 1
	invocation_type = "none"
	button_icon = 'massmeta/icons/mob/actions/actions_hive.dmi'
	background_icon_state = "bg_hive"
	button_icon_state = "forcewall"
	range = -1
	include_user = 1
	antimagic_allowed = TRUE
	wall_type = /obj/effect/forcefield/wizard/hive
	var/wall_type_b = /obj/effect/forcefield/wizard/hive/invis

/obj/effect/forcefield/wizard/hive
	name = "Telekinetic Field"
	desc = "You think, therefore it is."
	timeleft = 150
	pixel_x = -32 //Centres the 96x96 sprite
	pixel_y = -32
	icon = 'icons/effects/96x96.dmi'
	icon_state = "hive_shield"
	layer = ABOVE_ALL_MOB_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/forcefield/wizard/hive/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(mover == wizard)
		return TRUE
	return FALSE

/obj/effect/forcefield/wizard/hive/invis
	icon = null
	icon_state = null
	pixel_x = 0
	pixel_y = 0
	invisibility = INVISIBILITY_MAXIMUM
