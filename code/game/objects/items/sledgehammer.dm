/obj/item/sledgehammer
	name = "sledgehammer"
	desc = "It's a big hammer! It doesn't fit in your pockets, because it's big..."
	force = 14
	icon_state = "sledgehammer0"
	base_icon_state = "sledgehammer"
	icon = 'massmeta/icons/obj/sledgehammer.dmi'
	lefthand_file = 'massmeta/icons/mob/inhands/sledgehammer_lefthand.dmi'
	righthand_file = 'massmeta/icons/mob/inhands/sledgehammer_righthand.dmi'
	throwforce = 15
	w_class = WEIGHT_CLASS_HUGE
	throw_speed = 2
	throw_range = 3
	attack_speed = 2.4 SECONDS
	custom_materials = list(/datum/material/iron=140)

/obj/item/sledgehammer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
		icon_wielded = "[base_icon_state]1", \
		force_unwielded = 14, \
		force_wielded = 25, \
	)

/obj/item/sledgehammer/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/item/sledgehammer/attack(mob/living/target, mob/living/user)
	..()

	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		return

	if((HAS_TRAIT(user, TRAIT_CLUMSY)) && prob(50))
		to_chat(user, "<span class ='danger'>You hit yourself over the head.</span>")

		user.Knockdown(40 SECONDS)
		user.SetSleeping(20 SECONDS)

		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(1,1*force, BRUTE, BODY_ZONE_HEAD)
		else
			user.take_bodypart_damage(1,1*force)
		return

	if((ishuman(target)) && (user.zone_selected == BODY_ZONE_HEAD) && prob(45))
		target.Knockdown(20 SECONDS)
		target.Stun(10 SECONDS)
		return
