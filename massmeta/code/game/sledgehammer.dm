/obj/item/crowbar/sledgehammer
	name = "sledgehammer"
	desc = "It's a big hammer and crowbar in one tool. It doesn't fit in your pockets, because it's big."
	force = 14
	icon_state = "sledgehammer0"
	icon = 'massmeta/icons/obj/sledgehammer.dmi'
	lefthand_file = 'massmeta/icons/mob/inhands/sledgehammer_lefthand.dmi'
	righthand_file = 'massmeta/icons/mob/inhands/sledgehammer_righthand.dmi'
	throwforce = 15
	w_class = WEIGHT_CLASS_HUGE
	throw_speed = 2
	throw_range = 3
	custom_materials = list(/datum/material/iron=140)
	inhand_icon_state = "sledgehammer"
	toolspeed = 0.7

/obj/item/crowbar/sledgehammer/Initialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=14, force_wielded=25, block_power_wielded=20, icon_wielded="sledgehammer1")

/obj/item/crowbar/sledgehammer/attack(mob/living/target, mob/living/user)
	. = ..()
	user.changeNext_move(2 SECONDS)
	return

/obj/item/crowbar/sledgehammer/attack(mob/living/target, mob/living/user)
	if((HAS_TRAIT(user, TRAIT_CLUMSY)) && prob(50))
		to_chat(user, "<span class ='danger'>You hit yourself over the head.</span>")

		user.Knockdown(20 SECONDS)
		user.SetSleeping(10 SECONDS)

		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(1,1*force, BRUTE, BODY_ZONE_HEAD)
		else
			user.take_bodypart_damage(1,1*force)
		return
	else
		if((ishuman(target)) && (user.zone_selected == BODY_ZONE_HEAD) && prob(45))
			target.Knockdown(20 SECONDS)
			target.SetSleeping(10 SECONDS)
		return ..()
