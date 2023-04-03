/datum/species/robotic
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	inherent_traits = list(
		TRAIT_CAN_STRIP,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_RADIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_TOXIMMUNE,
		TRAIT_NOCLONELOSS,
		TRAIT_GENELESS,
		TRAIT_STABLEHEART,
		TRAIT_LIMBATTACHMENT,
		TRAIT_LITERATE,
	)
	mutant_bodyparts = list()
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	burnmod = 1.3 // Every 0.1% is 10% above the base.
	brutemod = 1.3
	coldmod = 1.2
	heatmod = 2
	siemens_coeff = 1.4 //Not more because some shocks will outright crit you, which is very unfun
	payday_modifier = 0.75 // Matches the rest of the pay penalties the non-human crew have
	species_language_holder = /datum/language_holder/machine
	mutant_organs = list(/obj/item/organ/internal/cyberimp/arm/power_cord)
	mutantbrain = /obj/item/organ/internal/brain/ipc_positron
	mutantstomach = /obj/item/organ/internal/stomach/robot_ipc
	mutantears = /obj/item/organ/internal/ears/robot_ipc
	mutanttongue = /obj/item/organ/internal/tongue/robot_ipc
	mutanteyes = /obj/item/organ/internal/eyes/robot_ipc
	mutantlungs = /obj/item/organ/internal/lungs/robot_ipc
	mutantheart = /obj/item/organ/internal/heart/robot_ipc
	mutantliver = /obj/item/organ/internal/liver/robot_ipc
	exotic_blood = /datum/reagent/fuel/oil

/datum/species/robotic/spec_life(mob/living/carbon/human/H)
	if(H.stat == SOFT_CRIT || H.stat == HARD_CRIT)
		H.adjustFireLoss(1) //Still deal some damage in case a cold environment would be preventing us from the sweet release to robot heaven
		H.adjust_bodytemperature(13) //We're overheating!!
		if(prob(10))
			to_chat(H, span_warning("Alert: Critical damage taken! Cooling systems failing!"))
			do_sparks(3, TRUE, H)

/datum/species/robotic/spec_revival(mob/living/carbon/human/H)
	playsound(H.loc, 'sound/machines/chime.ogg', 50, 1, -1)
	H.visible_message(span_notice("[H]'s monitor lights up."), span_notice("All systems nominal. You're back online!"))

/datum/species/robotic/on_species_gain(mob/living/carbon/human/C)
	. = ..()
	var/obj/item/organ/internal/appendix/appendix = C.getorganslot(ORGAN_SLOT_APPENDIX)
	if(appendix)
		appendix.Remove(C)
		qdel(appendix)

/datum/species/robotic/random_name(gender,unique,lastname)
	var/randname = pick(GLOB.posibrain_names)
	randname = "[randname]-[rand(100, 999)]"
	return randname

/datum/species/robotic/get_types_to_preload()
	return ..() - typesof(/obj/item/organ/internal/cyberimp/arm/power_cord) // Don't cache things that lead to hard deletions.

/datum/species/robotic/get_species_description()
	return placeholder_description

/datum/species/robotic/get_species_lore()
	return list(placeholder_lore)

/datum/species/robotic/ipc
	name = "I.P.C."
	id = SPECIES_IPC
	species_traits = list(
		ROBOTIC_DNA_ORGANS,
		EYECOLOR,
		LIPS,
		HAIR,
		NOEYESPRITES,
		ROBOTIC_LIMBS,
		NOTRANSSTING,
	)
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"ipc_antenna" = ACC_RANDOM,
		"ipc_screen" = ACC_RANDOM,
		"ipc_chassis" = ACC_RANDOM,
		"ipc_head" = ACC_RANDOM
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	hair_alpha = 210
	sexes = 0
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/mutant/ipc,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/mutant/ipc,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/robot/mutant/ipc,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/robot/mutant/ipc,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/mutant/ipc,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/mutant/ipc,
	)
	var/datum/action/innate/monitor_change/screen
	var/saved_screen = "Blank"

/datum/species/robotic/ipc/spec_revival(mob/living/carbon/human/transformer)
	. = ..()
	switch_to_screen(transformer, "Console")
	addtimer(CALLBACK(src, PROC_REF(switch_to_screen), transformer, saved_screen), 5 SECONDS)

/datum/species/robotic/ipc/spec_death(gibbed, mob/living/carbon/human/transformer)
	. = ..()
	saved_screen = transformer.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME]
	switch_to_screen(transformer, "BSOD")
	addtimer(CALLBACK(src, PROC_REF(switch_to_screen), transformer, "Blank"), 5 SECONDS)

/**
 * Simple proc to switch the screen of an IPC and ensuring it updates their appearance.
 *
 * Arguments:
 * * transformer - The human that will be affected by the screen change (read: IPC).
 * * screen_name - The name of the screen to switch the ipc_screen mutant bodypart to.
 */
/datum/species/robotic/ipc/proc/switch_to_screen(mob/living/carbon/human/tranformer, screen_name)
	tranformer.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME] = screen_name
	tranformer.update_body()

/datum/species/robotic/ipc/on_species_gain(mob/living/carbon/human/transformer)
	. = ..()
	if(!screen)
		screen = new
		screen.Grant(transformer)
	var/chassis = transformer.dna.mutant_bodyparts["ipc_chassis"]
	var/head = transformer.dna.mutant_bodyparts["ipc_head"]
	if(!chassis && !head)
		return
	var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.sprite_accessories["ipc_chassis"][chassis["name"]]
	var/datum/sprite_accessory/ipc_head/head_of_choice = GLOB.sprite_accessories["ipc_head"][head["name"]]
	if(chassis_of_choice || head_of_choice)
		examine_limb_id = chassis_of_choice?.icon_state ? chassis_of_choice.icon_state : head_of_choice.icon_state
		// We want to ensure that the IPC gets their chassis and their head correctly.
		for(var/obj/item/bodypart/limb as anything in transformer.bodyparts)
			if(chassis && limb.body_part == CHEST)
				limb.limb_id = chassis_of_choice.icon_state != "none" ? chassis_of_choice.icon_state : "ipc"
				continue

			if(head && limb.body_part == HEAD)
				limb.limb_id = head_of_choice.icon_state != "none" ? head_of_choice.icon_state : "ipc"

		if(chassis_of_choice.color_src)
			species_traits += MUTCOLORS
		transformer.update_body()

/datum/species/robotic/ipc/replace_body(mob/living/carbon/target, datum/species/new_species)
	..()
	var/chassis = target.dna.mutant_bodyparts["ipc_chassis"]
	if(!chassis)
		return
	var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.sprite_accessories["ipc_chassis"][chassis["name"]]

	for(var/obj/item/bodypart/iterating_bodypart as anything in target.bodyparts) //Override bodypart data as necessary
		if(chassis_of_choice.color_src)
			iterating_bodypart.should_draw_greyscale = TRUE
			iterating_bodypart.species_color = target.dna?.features["mcolor"]
		iterating_bodypart.limb_id = chassis_of_choice.icon_state
		iterating_bodypart.name = "\improper[chassis_of_choice.name] [parse_zone(iterating_bodypart.body_zone)]"
		iterating_bodypart.update_limb()

/datum/species/robotic/ipc/on_species_loss(mob/living/carbon/human/C)
	. = ..()
	if(screen)
		screen.Remove(C)
	..()

/datum/action/innate/monitor_change
	name = "Screen Change"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "drone_vision"

/datum/action/innate/monitor_change/Activate()
	var/mob/living/carbon/human/H = owner
	var/new_ipc_screen = input(usr, "Choose your character's screen:", "Monitor Display") as null|anything in GLOB.sprite_accessories["ipc_screen"]
	if(!new_ipc_screen)
		return
	H.dna.species.mutant_bodyparts["ipc_screen"] = new_ipc_screen
	H.update_body()
