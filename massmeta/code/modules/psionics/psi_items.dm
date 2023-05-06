/obj/item/melee/psiblade
	name = "psionic blade"
	desc = "My life for Aiur!"
	icon = 'massmeta/icons/obj/psychic_powers.dmi'
	icon_state = "psiblade_long"
	inhand_icon_state = "psiblade_long"
	lefthand_file = 'massmeta/icons/mob/inhands/psiblade_lefthand.dmi'
	righthand_file = 'massmeta/icons/mob/inhands/psiblade_righthand.dmi'
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 23
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/weapons/blade1.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts", "burns")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut", "burn")
	sharpness = SHARP_EDGED
	wound_bonus = -20
	bare_wound_bonus = 20
	armour_penetration = 20

/obj/item/melee/psiblade/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)
	if(ismob(loc))
		loc.visible_message(span_warning("Concentrated psionic energy forms around [loc.name]\'s arm!"), span_warning("You concentrate your psionic power around your arm, forming a dealy weapon."))
	AddComponent(/datum/component/butchering, \
	speed = 6 SECONDS, \
	effectiveness = 80, \
	)

/obj/item/melee/psiblade/short
	force = 16
	name = "lesser psionic blade"
	icon_state = "psiblade_short"
	armour_penetration = 10

/obj/item/debug/omnitool/psi_tool //Kill me
	name = "psi tool"
	desc = "An energy... tool? Use it inhands to choose it's behaviour"
	icon = 'massmeta/icons/obj/psychic_powers.dmi'
	icon_state = "tinker"
	inhand_icon_state = "psiblade"
	usesound = list('sound/weapons/blade1.ogg')
	lefthand_file = 'massmeta/icons/mob/inhands/psiblade_lefthand.dmi'
	righthand_file = 'massmeta/icons/mob/inhands/psiblade_righthand.dmi'
	toolspeed = 1

/obj/item/debug/omnitool/psi_tool/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)

/obj/item/debug/omnitool/psi_tool/better
	toolspeed = 0.6

/obj/item/gun/energy/e_gun/mini/psionic
	name = "psionic pistol"
	desc = "A manifestation of it's owner's psionic powers, it is capable of firing multiple laser beams."
	icon_state = "mini"
	inhand_icon_state = "gun"
	w_class = WEIGHT_CLASS_SMALL
	color = COLOR_BLUE_LIGHT
	ammo_type = list(/obj/item/ammo_casing/energy/laser/psi)
	can_bayonet = FALSE
	pinless = TRUE
	item_flags = ABSTRACT | DROPDEL

/obj/item/gun/energy/e_gun/mini/psionic/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)

/obj/item/ammo_casing/energy/laser/psi
	projectile_type = /obj/projectile/beam/laser/psi
	e_cost = 100
	select_name = "kill"

/obj/projectile/beam/laser/psi
	color = COLOR_BLUE_LIGHT
	name = "psionic beam"
	damage = 15

/obj/item/gun/energy/e_gun/mini/psionic/add_seclight_point()
	return

/obj/item/gun/energy/e_gun/mini/psionic/emp_act(severity)
	return

/obj/item/gun/energy/e_gun/mini/psionic/screwdriver_act()
	return

/obj/item/psi_enchancer
	name = "psi enchancer"
	desc = "a complex device, which is capable of increasing psionic strength of a human."
	icon = 'massmeta/icons/obj/psychic_powers.dmi'
	icon_state = "volkite"

/obj/item/psi_enchancer/attack_self(mob/living/user)
	if(!isliving(user))
		return
	var/psionic_check = SEND_SIGNAL(user, COMSIG_PSIONIC_HAS_ENERGY, 1)
	if(!psionic_check)
		user.visible_message(span_warning("[user] stab themself with [src]!"), span_warning("You stab yourself with [src], but it has no effect!"))
		user.balloon_alert(user, "not a psionic!")
		return
	var/level_check = SEND_SIGNAL(user, COMSIG_PSIONIC_ADVANCE_LEVEL, 1, TRUE, TRUE, TRUE)
	if(level_check & COMPONENT_PSIONIC_NO_ADVANCE)
		user.visible_message(span_warning("[user] stab themself with [src]!"), span_warning("You stab yourself with [src], but it has no effect!"))
		return
	user.visible_message(span_warning("[user] stab themself with [src]!"), "<span class='warning'>You stab yourself with [src], and</span> <span class='hypnophrase'>feel power flooding through your mind!</span>")
	user.adjust_confusion(rand(5 SECONDS, 10 SECONDS))
	user.adjust_eye_blur(rand(5 SECONDS, 10 SECONDS))
	user.adjust_hallucinations(rand(15 SECONDS, 30 SECONDS))
	qdel(src)
