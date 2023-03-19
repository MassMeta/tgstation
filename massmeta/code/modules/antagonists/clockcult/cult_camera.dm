
//Used by servants of Ratvar! They let you beam to the station.
/obj/machinery/computer/camera_advanced/ratvar
	name = "ratvarian camera observer"
	desc = "A console used to snoop on the station's goings-on. A jet of steam occasionally whooshes out from slats on its sides."
	use_power = FALSE
	networks = list("ss13", "minisat") //:eye:
	var/datum/action/innate/servant_warp/warp_action = new

/obj/machinery/computer/camera_advanced/ratvar/Initialize()
	. = ..()
	ratvar_act()

/obj/machinery/computer/camera_advanced/ratvar/process()
	if(prob(1))
		playsound(src, 'sound/machines/clockcult/steam_whoosh.ogg', 25, TRUE)
		new/obj/effect/temp_visual/steam_release(get_turf(src))

/obj/machinery/computer/camera_advanced/ratvar/CreateEye()
	..()
	eyeobj.visible_icon = TRUE
	eyeobj.icon = 'icons/mob/cameramob.dmi' //in case you still had any doubts
	eyeobj.icon_state = "generic_camera"

/obj/machinery/computer/camera_advanced/ratvar/GrantActions(mob/living/carbon/user)
	..()
	if(warp_action)
		warp_action.Grant(user)
		warp_action.target = src
		actions += warp_action

/obj/machinery/computer/camera_advanced/ratvar/can_use(mob/living/user)
	if(!is_servant_of_ratvar(user))
		to_chat(user, "<span class='warning'>[src]'s keys are in a language foreign to you, and you don't understand anything on its screen.</span>")
		return
	if(clockwork_ark_active())
		to_chat(user, "<span class='warning'>The Ark is active, and [src] has shut down.</span>")
		return
	. = ..()

/datum/action/innate/servant_warp
	name = "Warp"
	desc = "Warps to the tile you're viewing. You can use the Abscond scripture to return. Clicking this button again cancels the warp."
	button_icon = 'massmeta/icons/mob/actions/actions_clockcult.dmi'
	button_icon_state = "warp_down"
	background_icon_state = "bg_clock"
	buttontooltipstyle = "clockcult"
	var/cancel = FALSE //if TRUE, an active warp will be canceled
	var/obj/effect/temp_visual/ratvar/warp_marker/warping

/datum/action/innate/servant_warp/Activate()
	if(QDELETED(target) || !(ishuman(owner) || iscyborg(owner)) || !owner.canUseTopic(target))
		return
	if(!GLOB.servants_active) //No leaving unless there's servants from the get-go
		return
	if(warping)
		cancel = TRUE
		return
	var/mob/living/carbon/human/user = owner
	var/mob/camera/aiEye/remote/remote_eye = user.remote_control
	var/obj/machinery/computer/camera_advanced/ratvar/R  = target
	var/turf/T = get_turf(remote_eye)
	if(!is_reebe(user.z) || !is_station_level(T.z))
		return
	if(isclosedturf(T))
		to_chat(user, "<span class='sevtug_small'>You can't teleport into a wall.</span>")
		return
	else if(isspaceturf(T))
		to_chat(user, "<span class='sevtug_small'>[prob(1) ? "Servant cannot into space." : "You can't teleport into space."]</span>")
		return
	else if(T.flags_1 & NOTELEPORT)
		to_chat(user, "<span class='sevtug_small'>This tile is blessed by holy water and deflects the warp.</span>")
		return
	var/area/AR = get_area(T)
	if(!AR.clockwork_warp_allowed)
		to_chat(user, "<span class='sevtug_small'>[AR.clockwork_warp_fail]</span>")
		return
	if(alert(user, "Are you sure you want to warp to [AR]?", target.name, "Warp", "Cancel") == "Cancel" || QDELETED(R) || !user.canUseTopic(R))
		return
	do_sparks(5, TRUE, user)
	do_sparks(5, TRUE, T)
	warping = new(T)
	user.visible_message("<span class='warning'>[user]'s [target.name] flares!</span>", "<span class='bold sevtug_small'>You begin warping to [AR]...</span>")
	button_icon_state = "warp_cancel"
	owner.update_action_buttons()
	if(!do_after(user, 50, target = warping, extra_checks = CALLBACK(src, .proc/is_canceled)))
		to_chat(user, "<span class='bold sevtug_small'>Warp interrupted.</span>")
		QDEL_NULL(warping)
		button_icon_state = "warp_down"
		owner.update_action_buttons()
		cancel = FALSE
		return
	button_icon_state = "warp_down"
	owner.update_action_buttons()
	T.visible_message("<span class='warning'>[user] warps in!</span>")
	playsound(user, 'sound/magic/magic_missile.ogg', 50, TRUE)
	playsound(T, 'sound/magic/magic_missile.ogg', 50, TRUE)
	user.forceMove(get_turf(T))
	user.setDir(SOUTH)
	flash_color(user, flash_color = "#AF0AAF", flash_time = 5)
	R.remove_eye_control(user)
	QDEL_NULL(warping)

/datum/action/innate/servant_warp/proc/is_canceled()
	return !cancel
