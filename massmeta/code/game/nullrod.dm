/obj/item/nullrod/dualsword
	name = "blades of the apostate"
	desc = "You can't seem to make out the writing on the side."
	icon = 'massmeta/icons/obj/clothing/belts.dmi'
	worn_icon = 'massmeta/icons/mob/clothing/belt.dmi'
	icon_state = "fulldual"
	worn_icon_state = "fulldual"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_HUGE
	force = 12
	block_chance = 10
	wound_bonus = -20
	attack_verb_continuous = list("thwacks")
	attack_verb_simple = list("thwack")
	menu_description = "A sheath, containing two holy blades. Can be Atl+Clicked while worn to draw the blades from it."
	var/swords = TRUE
	var/obj/item/nullrod/handedsword/swordright
	var/obj/item/nullrod/handedsword/other/swordleft

/obj/item/nullrod/dualsword/examine(mob/user)
	. = ..()
	. += span_notice("Alt+Click it while wearing on your belt slot to draw the blades from it.")

/obj/item/nullrod/dualsword/AltClick(mob/user)
	. = ..()
	if(loc != user)
		to_chat(user, "you awkwardly struggle to pull the blades out of the sheathe while not wearing it.")
		return
	if(swords)
		if(LAZYLEN(user.get_empty_held_indexes()) < 2)
			to_chat(user, "you need both hands free to draw your swords.")
			return

		user.drop_all_held_items() //in case they have some sneaky 3rd hand shit

		swordright = new(src) //copies stats from the sheathe to the weapons to allow for varedit shenanigans
		swordright.force = force
		swordright.armour_penetration = armour_penetration
		swordright.block_chance = block_chance
		swordright.wound_bonus = wound_bonus
		swordright.bare_wound_bonus = bare_wound_bonus
		swordright.sheath = src
		user.put_in_r_hand(swordright)

		swordleft = new(src)
		swordleft.force = force
		swordleft.armour_penetration = armour_penetration
		swordleft.block_chance = block_chance
		swordleft.wound_bonus = wound_bonus
		swordleft.bare_wound_bonus = bare_wound_bonus
		swordleft.sheath = src
		user.put_in_l_hand(swordleft)

		to_chat(user, "you draw your righteous blades.")
		playsound(user, 'sound/items/unsheath.ogg', 25, TRUE)
		swords = FALSE
		update_icon()

/obj/item/nullrod/dualsword/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/nullrod/handedsword))
		qdel(I)

		var/otherhand = user.get_inactive_held_item()
		if(istype(otherhand, /obj/item/nullrod/handedsword))
			qdel(otherhand)

		to_chat(user, "you sheathe your blades.")
		playsound(user, 'sound/items/sheath.ogg', 25, TRUE)
		swords = TRUE
		update_icon()

/obj/item/nullrod/dualsword/update_icon()
	. = ..()
	worn_icon_state = swords ? "fulldual" : "emptydual"
	icon_state = worn_icon_state

/obj/item/nullrod/handedsword
	name = "Justice"
	desc = "Ashes to ashes... Rust to rust..."
	icon = 'massmeta/icons/obj/swords.dmi'
	icon_state = "dualright"
	inhand_icon_state = "dualright"
	lefthand_file = 'massmeta/icons/mob/inhands/swords_lefthand.dmi'
	righthand_file = 'massmeta/icons/mob/inhands/swords_righthand.dmi'
	attack_verb_continuous = list("attacks", "slashes", "stabbs", "slices", "ripps", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "ripp", "dice", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	w_class = WEIGHT_CLASS_HUGE
	chaplain_spawnable = FALSE
	var/obj/item/nullrod/dualsword/sheath //so the sheathe is refilled when the swords are dropped

/obj/item/nullrod/handedsword/other
	name = "Splendor"
	desc = "\"I'm going to ultrakill you!\" -Righteous Judge"
	icon = 'massmeta/icons/obj/swords.dmi'
	icon_state = "dualleft"
	inhand_icon_state = "dualleft"

/obj/item/nullrod/handedsword/attack(mob/living/target_mob, mob/living/user, params, secondattack = FALSE)
	set waitfor = FALSE
	. = ..()
	var/obj/item/nullrod/handedsword/secondsword = user.get_inactive_held_item()
	if(istype(secondsword, /obj/item/nullrod/handedsword) && !secondattack)
		sleep(0.2 SECONDS)
		if(QDELETED(secondsword) || QDELETED(src))
			return
		user.swap_hand()
		secondsword.attack(target_mob, user, params, TRUE)
		user.changeNext_move(CLICK_CD_MELEE)
	return

/obj/item/nullrod/handedsword/dropped(mob/user, silent = TRUE)
	. = ..()
	if(QDELETED(src))
		return
	var/otherhand = user.get_inactive_held_item()
	if(istype(otherhand, /obj/item/nullrod/handedsword))
		qdel(otherhand)
	if(sheath)
		to_chat("you sheathe your blades.")
		sheath.swords = TRUE
		sheath.update_icon()
		playsound(user, 'sound/items/sheath.ogg', 25, TRUE)
	qdel(src)
