/obj/item/melee/nunchaku
	name = "nunchaku"
	desc = "Traditional Okinawan martial arts weapon"
	force = 4
	icon_state = "nunchaku"
	icon = 'massmeta/icons/obj/nunchaku.dmi'
	lefthand_file = 'massmeta/icons/mob/inhands/nunchaku_lefthand.dmi'
	righthand_file = 'massmeta/icons/mob/inhands/nunchaku_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BELT
	wound_bonus = -10
	demolition_mod = 0.25
	throw_range = 2

	var/stamina_damage = 11
	var/fast_attack_speed = CLICK_CD_MELEE / 2

	var/attack_sound = 'sound/effects/woodhit.ogg'

/obj/item/melee/nunchaku/Initialize(mapload)
	. = ..()
	// Adding an extra break for the sake of presentation
	if(stamina_damage != 0)
		offensive_notes = "\nVarious interviewed forces report being able to beat felinids into exhaustion with only [span_warning("[CEILING(100 / stamina_damage, 1)] hit\s!")]"

/obj/item/melee/nunchaku/proc/check_parried(mob/living/carbon/human/human_target, mob/living/user)
	if(!ishuman(human_target))
		return
	if (human_target.check_shields(src, 0, "[user]'s [name]", MELEE_ATTACK))
		playsound(human_target, 'sound/weapons/genhit.ogg', 50, TRUE)
		return TRUE
	if(check_martial_counter(human_target, user))
		return TRUE

/obj/item/melee/nunchaku/attack(mob/living/target, mob/living/user, params)

	if(QDELETED(target))
		return
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	if(check_parried(target, user))
		return

	if((HAS_TRAIT(user, TRAIT_CLUMSY)) && prob(30))
		user.visible_message(span_danger("[user] accidentally hits [user.p_them()]self with [src]!"), span_userdanger("You accidentally hit yourself with [src]!"))
		user.Knockdown(2 SECONDS)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(3*force, BRUTE, BODY_ZONE_HEAD)
		else
			user.take_bodypart_damage(3*force)
		..()
		return

	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		..()
		user.changeNext_move(fast_attack_speed)
		return

	user.do_attack_animation(target)

	check_parried(target, user)

	user.changeNext_move(fast_attack_speed)
	target.apply_damage(stamina_damage, STAMINA)

	playsound(get_turf(src), attack_sound, 50, TRUE)

	target.visible_message(span_danger("[user] knocks [target] with [src]!"), \
		span_userdanger("[user] knocks you with [src]!"))

/datum/crafting_recipe/nunchaku
	name = "nunchaku"
	result = /obj/item/melee/nunchaku
	reqs = list(
		/obj/item/restraints/handcuffs/cable = 2,
		/obj/item/stack/sheet/mineral/wood = 6,
	)
	tool_behaviors = list(TOOL_KNIFE)
	time = 12 SECONDS
	category = CAT_WEAPON_MELEE
