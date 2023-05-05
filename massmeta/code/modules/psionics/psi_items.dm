/obj/item/melee/psiblade
	name = "psionic blade"
	desc = "My life for Aiur!"
	icon_state = "psi_blade"
	inhand_icon_state = "psi_blade"
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 24
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/weapons/blade1.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts", "burns")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut", "burn")
	sharpness = SHARP_EDGED
	wound_bonus = -20
	bare_wound_bonus = 20

/obj/item/melee/psiblade/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)
	if(ismob(loc))
		loc.visible_message(span_warning("Concentrated psionic energy forms around [loc.name]\'s arm!"), span_warning("You concentrate your psionic power around your arm, forming a dealy weapon."))
	AddComponent(/datum/component/butchering, \
	speed = 6 SECONDS, \
	effectiveness = 80, \
	)

/obj/item/melee/psiblade/short
	force = 17
	name = "lesser psionic blade"

/obj/item/debug/omnitool/psi_tool //Kill me
	name = "psi tool"
	desc = "An energy... tool? Use it inhands to choose it's behaviour"
	toolspeed = 1
