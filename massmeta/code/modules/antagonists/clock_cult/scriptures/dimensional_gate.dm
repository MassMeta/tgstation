//==================================//
// !      Dimensional Gate        ! //
//==================================//
/datum/clockcult/scripture/create_structure/dimensional_gate
	name = "Dimensional Gate"
	desc = "Creates a Dimensional Gate, a structure which allows you to warp to Reebe."
	tip = "Essential for the cult, the one of the few way to get to Reebe."
	button_icon_state = "dimensional_gate"
	power_cost = 1000
	invokation_time = 50
	invokation_text = list("Направь мою руку, и мы создадим величие.")
	summoned_structure = /obj/structure/destructible/clockwork/gear_base/dimensional_gate
	category = SPELLTYPE_STRUCTURES

//===============
// Dimensional Gate Structure
//===============

/obj/structure/destructible/clockwork/gear_base/dimensional_gate
	name = "dimensional gate"
	desc = "A portal in a bronze frame."
	clockwork_desc = "A portal in a bronze frame. Use it to warp to Reebe."
	default_icon_state = "dimensional_gate"
	anchored = TRUE
	break_message = span_warning("The dimensional gate shatters!")
	can_unanchor = FALSE

/obj/structure/destructible/clockwork/gear_base/dimensional_gate/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!is_servant_of_ratvar(user))
		to_chat(user, span_warning("Пытаюсь засунуть руку в [src], но чуть не обжигаю её!"))
		return
	var/client_color = user.client.color
	animate(user.client, color = "#AF0AAF", time = 2.5 SECONDS)
	if(!anchored)
		to_chat(user, span_brass("Стоит прикрутить [src] для начала."))
		return
	user.balloon_alert(user,"warping to Reebe...")
	if(!do_after(user, 2.5 SECONDS, src))
		if(user.client)
			animate(user.client, color = client_color, time = 10)
		user.balloon_alert(user,"warp failed!")
		return
	var/turf/T = get_turf(pick(GLOB.servant_spawns))
	if(!T)
		to_chat(user, span_warning("Error, no valid teleport locations found!"))
	try_warp_servant(user, T, TRUE)
	var/prev_alpha = user.alpha
	user.alpha = 0
	animate(user, alpha=prev_alpha, time=10)
	if(user.client)
		animate(user.client, color = client_color, time = 25)
