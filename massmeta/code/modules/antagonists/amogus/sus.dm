/mob/living/simple_animal/hostile/imposter
	name = "Imposter"
	desc = "Susususus is it amogus??? Sussy baka."
	icon = 'icons/effects/effects.dmi' //Placeholder sprite
	icon_state = "blank_dspawn"
	icon_living = "blank_dspawn"
	response_help_continuous = "backs away from"
	response_help_simple = "backs away from"
	response_disarm_continuous = "shoves away"
	response_disarm_simple = "shove away"
	response_harm_continuous = "flails at"
	response_harm_simple = "flail at"
	speed = 0
	maxHealth = 100
	health = 100
	dextrous = TRUE
	held_items = list(null, null)

	lighting_cutoff_red = 60
	lighting_cutoff_green = 16
	lighting_cutoff_blue = 10

	sight = SEE_MOBS | SEE_TURFS | SEE_OBJS

	harm_intent_damage = 20
	obj_damage = 25
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "hits"
	attack_verb_simple = "hit"
	attack_sound = 'sound/weapons/blade1.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	speak_emote = list("susses")

	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = INFINITY

	pressure_resistance = INFINITY
	see_invisible = SEE_INVISIBLE_MINIMUM
	gold_core_spawnable = FALSE

/mob/living/simple_animal/hostile/imposter/Initialize()
	..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
