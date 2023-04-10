/*
 * EMAG AND SUBTYPES
 */
/obj/item/card/emag
	desc = "It's a card with a magnetic strip attached to some circuitry."
	name = "cryptographic sequencer"
	icon_state = "emag"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	item_flags = NO_MAT_REDEMPTION | NOBLUDGEON
	slot_flags = ITEM_SLOT_ID
	worn_icon_state = "emag"
	var/prox_check = TRUE //If the emag requires you to be in range
	var/list/consumer_types //List of types that consume a charge upon hacking
	var/charges = 3 //How many charges do we currently have
	var/max_charges = 3 //How many charges can we hold in total
	var/charge_time = 1 MINUTES //How long does it take to gain a new charge
	var/list/current_cooldown = list() //How long until we gain our next charge

/obj/item/card/emag/Initialize(mapload)
	. = ..()
	consumer_types = list(
		typesof(/obj/machinery/door/airlock),
		typesof(/obj/machinery/door/window/))

/obj/item/card/emag/attack_self(mob/user) //for traitors with balls of plastitanium
	if(Adjacent(user))
		user.visible_message(span_notice("[user] shows you: [icon2html(src, viewers(user))] [name]."), span_notice("You show [src]."))
	add_fingerprint(user)

/obj/item/card/emag/bluespace
	name = "bluespace cryptographic sequencer"
	desc = "It's a blue card with a magnetic strip attached to some circuitry. It appears to have some sort of transmitter attached to it."
	color = rgb(40, 130, 255)
	prox_check = FALSE

/obj/item/card/emag/halloween
	name = "hack-o'-lantern"
	desc = "It's a pumpkin with a cryptographic sequencer sticking out."
	icon_state = "hack_o_lantern"

/obj/item/card/emagfake
	desc = "It's a card with a magnetic strip attached to some circuitry. Closer inspection shows that this card is a poorly made replica, with a \"Donk Co.\" logo stamped on the back."
	name = "cryptographic sequencer"
	icon_state = "emag"
	inhand_icon_state = "card-id"
	slot_flags = ITEM_SLOT_ID
	worn_icon_state = "emag"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/emagfake/attack_self(mob/user) //for assistants with balls of plasteel
	if(Adjacent(user))
		user.visible_message(span_notice("[user] shows you: [icon2html(src, viewers(user))] [name]."), span_notice("You show [src]."))
	add_fingerprint(user)

/obj/item/card/emagfake/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if (!proximity_flag)
		return
	. |= AFTERATTACK_PROCESSED_ITEM
	playsound(src, 'sound/items/bikehorn.ogg', 50, TRUE)

/obj/item/card/emag/afterattack(atom/target, mob/user, proximity)
	. = ..()
	var/atom/A = target
	if(!proximity && prox_check)
		return
	. |= AFTERATTACK_PROCESSED_ITEM
	if(!can_emag(target, user))
		return
	log_combat(user, A, "attempted to emag")
	A.emag_act(user, src)

/obj/item/card/emag/proc/use_charge(mob/user)
	charges --
	to_chat(user, span_notice("You use [src]. It now has [charges] charges remaining."))
	current_cooldown.Add(addtimer(CALLBACK(src, PROC_REF(recharge)), charge_time, TIMER_STOPPABLE))

/obj/item/card/emag/proc/can_emag(atom/target, mob/user)
	for (var/list/subtypelist in consumer_types)
		if((target.type in subtypelist) && charges <= 0)
			to_chat(user, span_warning("[src] is out of charges, give it <b>[timeleft(current_cooldown[1]) * 0.1] seconds </b> to recharge!"))
			return FALSE
	return TRUE

/obj/item/card/emag/proc/recharge(mob/user)
	charges = min(charges+1, max_charges)
	playsound(src,'sound/machines/twobeep.ogg',10,TRUE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	current_cooldown.Remove(current_cooldown[1])

/obj/item/card/emag/examine(mob/user)
	. = ..()
	. += span_notice("It has [charges] charges remaining.")
	var/timeleft = timeleft(current_cooldown[1])
	var/loadingbar = num2loadingbar(timeleft/charge_time)
	if(charges == max_charges)
		. += span_notice("<b> All [charges] charges are ready for use!</b>")
	else
		. += "[span_notice("<b>A small display on the back reads:")]</b>"
		for (var/i in 1 to length(current_cooldown))
			timeleft = timeleft(current_cooldown[i])
			. += span_notice("<b>CHARGE #[i]: [loadingbar] ([DisplayTimeText(timeleft)])</b>")



/*
 * Battlecruiser Access
 */
/obj/item/card/emag/battlecruiser
	name = "battlecruiser coordinates upload card"
	desc = "An ominous card that contains the location of the station, and when applied to a communications console, \
	the ability to long-distance contact the Syndicate fleet."
	icon_state = "battlecruisercaller"
	worn_icon_state = "emag"
	///whether we have called the battlecruiser
	var/used = FALSE
	/// The battlecruiser team that the battlecruiser will get added to
	var/datum/team/battlecruiser/team

/obj/item/card/emag/battlecruiser/proc/use_card(mob/user)
	used = TRUE
	to_chat(user, span_boldwarning("You use [src], and it interfaces with the communication console. No going back..."))

/obj/item/card/emag/battlecruiser/examine(mob/user)
	. = ..()
	. += span_notice("It can only be used on the communications console.")

/obj/item/card/emag/battlecruiser/can_emag(atom/target, mob/user)
	if(used)
		to_chat(user, span_warning("[src] is used up."))
		return FALSE
	if(!istype(target, /obj/machinery/computer/communications))
		to_chat(user, span_warning("[src] is unable to interface with this. It only seems to interface with the communication console."))
		return FALSE
	return TRUE
