#define ORGAN_SLOT_SCANNER "scanner"

/obj/item/organ/internal/cyberimp/chest/scanner
	name = "internal health analyzer"
	desc = "An advanced health analyzer implant, designed to directly interface with a host's body and relay scan information to the brain on command."
	slot = ORGAN_SLOT_SCANNER
	icon = 'massmeta/icons/obj/organs.dmi'
	icon_state = "internal_HA"
	implant_overlay = null
	implant_color = null
	actions_types = list(/datum/action/item_action/organ_action/use)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/organ/internal/cyberimp/chest/scanner/ui_action_click(owner, action)
	if(istype(action, /datum/action/item_action/organ_action/use))
		if(organ_flags & ORGAN_FAILING)
			to_chat(owner, span_warning("Your health analyzer relays an error! It can't interface with your body in its current condition!"))
			return
		else
			healthscan(owner, owner, 1, TRUE)
			chemscan(owner, owner)

/obj/item/organ/internal/cyberimp/brain/anti_sleep
	name = "CNS jumpstarter"
	desc = "This implant will automatically attempt to jolt you awake when it detects you have fallen unconscious outside of REM sleeping cycles. Has a short cooldown."
	implant_color = "#0356fc"
	slot = ORGAN_SLOT_BRAIN_ANTISTUN
	var/cooldown = FALSE

/obj/item/organ/internal/cyberimp/brain/anti_sleep/on_life(mob/living/carbon/human/H)
	H = owner
	if(H.stat == UNCONSCIOUS && cooldown==FALSE)
		H.AdjustUnconscious(-100, FALSE)
		H.AdjustSleeping(-100, FALSE)
		to_chat(owner, span_notice("You feel a rush of energy course through your body!"))
		cooldown = TRUE
		addtimer(CALLBACK(src, PROC_REF(sleepytimerend)), 50)
	else
		return

/obj/item/organ/internal/cyberimp/brain/anti_sleep/proc/sleepytimerend()
	cooldown = FALSE
	to_chat(owner, span_notice("You hear a small beep in your head as your CNS Jumpstarter finishes recharging."))

/obj/item/organ/internal/cyberimp/brain/anti_sleep/emp_act(severity, mob/living/carbon/human/H)
	. = ..()
	H = owner
	if((organ_flags & ORGAN_FAILING) || . & EMP_PROTECT_SELF)
		return
	organ_flags |= ORGAN_FAILING
	H.AdjustUnconscious(20 SECONDS)
	cooldown = TRUE
	addtimer(CALLBACK(src, PROC_REF(reboot)), 90 / severity)

/obj/item/organ/internal/cyberimp/brain/anti_sleep/proc/reboot()
	organ_flags &= ~ORGAN_FAILING
	cooldown = FALSE

/obj/item/organ/internal/cyberimp/arm/cooler
	name = "sub-dermal cooling implant"
	desc = "Special inhand implant that cools you down if overheated."
	icon_state = "hand_implant"
	implant_overlay = "hand_implant_overlay"
	implant_color = "#00e1ff"
	actions_types = list()
	icon = 'massmeta/icons/obj/organs.dmi'

/obj/item/organ/internal/cyberimp/arm/cooler/on_life()
	. = ..()
	var/amt = BODYTEMP_NORMAL - owner.get_body_temp_normal()
	if(amt == 0)
		return
	owner.add_body_temperature_change("dermal_cooler_[zone]",clamp(amt,-1,0))

/obj/item/organ/internal/cyberimp/arm/cooler/Remove(mob/living/carbon/M, special)
	. = ..()
	owner.remove_body_temperature_change("dermal_cooler_[zone]")

/obj/item/organ/internal/cyberimp/arm/heater
	name = "sub-dermal heater implant"
	desc = "Special inhand implant that heats you up if overcooled."
	icon_state = "hand_implant"
	icon = 'massmeta/icons/obj/organs.dmi'
	implant_overlay = "hand_implant_overlay"
	implant_color = "#ff9100"
	actions_types = list()

/obj/item/organ/internal/cyberimp/arm/heater/on_life()
	. = ..()
	var/amt = BODYTEMP_NORMAL - owner.get_body_temp_normal()
	if(amt == 0)
		return
	owner.add_body_temperature_change("dermal_heater_[zone]",clamp(amt,0,1))

/obj/item/organ/internal/cyberimp/arm/heater/Remove(mob/living/carbon/M, special)
	. = ..()
	owner.remove_body_temperature_change("dermal_heater_[zone]")

/obj/item/organ/internal/cyberimp/chest/filtration
	name = "S.I.L.V.E.R. filtration pump"
	desc = "This implant purges your body of any toxins and drugs extremely quickly"
	implant_color = "#00e7b5"
	slot = ORGAN_SLOT_STOMACH_AID
	var/removal_speed = 1
	var/list/reagent_quirks = list()
	var/num_reagent_quirks = 0

/obj/item/organ/internal/cyberimp/chest/filtration/emp_act(severity)
	. = ..()
	for(var/i in 0 to rand(0,5))
		reagent_quirks += get_random_reagent_id()

/obj/item/organ/internal/cyberimp/chest/filtration/Initialize()
	. = ..()
	for(var/i in 0 to num_reagent_quirks)
		reagent_quirks += get_random_reagent_id()

/obj/item/organ/internal/cyberimp/chest/filtration/on_life()
	. = ..()

	for(var/R in owner.reagents.reagent_list)
		if(istype(R,/datum/reagent/toxin) || istype(R,/datum/reagent/drug) || is_type_in_list(R,reagent_quirks))
			owner.reagents.remove_reagent(R,removal_speed)

/obj/item/organ/internal/cyberimp/chest/filtration/offbrand
	name = "offbrand filtration pump"
	desc = "You're not sure if it is a great idea, this implant purges your body of any toxins and drugs extremely quickly"
	implant_color = "#0d3d33"
	slot = ORGAN_SLOT_STOMACH_AID
	removal_speed = 2
	num_reagent_quirks = 5

/obj/item/organ/internal/cyberimp/leg
	name = "leg-mounted implant"
	desc = "You shouldn't see this! Adminhelp and report this as an issue on github!"
	zone = BODY_ZONE_R_LEG
	icon_state = "implant-toolkit"
	w_class = WEIGHT_CLASS_SMALL

	var/double_legged = FALSE

/obj/item/organ/internal/cyberimp/leg/Initialize()
	. = ..()
	update_icon()
	SetSlotFromZone()

/obj/item/organ/internal/cyberimp/leg/proc/SetSlotFromZone()
	switch(zone)
		if(BODY_ZONE_R_LEG)
			slot = ORGAN_SLOT_LEFT_LEG_AUG
		if(BODY_ZONE_L_LEG)
			slot = ORGAN_SLOT_RIGHT_LEG_AUG
		else
			CRASH("Invalid zone for [type]")

/obj/item/organ/internal/cyberimp/leg/update_icon()
	if(zone == BODY_ZONE_R_LEG)
		transform = null
	else // Mirroring the icon
		transform = matrix(-1, 0, 0, 0, 1, 0)

/obj/item/organ/internal/cyberimp/leg/examine(mob/user)
	. = ..()
	. += "<span class='info'>[src] is assembled in the [zone == BODY_ZONE_R_LEG ? "right" : "left"] LEG configuration. You can use a screwdriver to reassemble it.</span>"

/obj/item/organ/internal/cyberimp/leg/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return TRUE
	I.play_tool_sound(src)
	if(zone == BODY_ZONE_R_LEG)
		zone = BODY_ZONE_L_LEG
	else
		zone = BODY_ZONE_R_LEG
	SetSlotFromZone()
	to_chat(user, "<span class='notice'>You modify [src] to be installed on the [zone == BODY_ZONE_R_LEG ? "right" : "left"] leg.</span>")
	update_icon()

/obj/item/organ/internal/cyberimp/leg/Insert(mob/living/carbon/M, special, drop_if_replaced)
	. = ..()
	if(!double_legged)
		on_full_insert(M, special, drop_if_replaced)
		return
	var/obj/item/organ/organ = M.get_organ_slot(slot == ORGAN_SLOT_LEFT_LEG_AUG ? ORGAN_SLOT_RIGHT_LEG_AUG : ORGAN_SLOT_LEFT_LEG_AUG)
	if(organ && organ.type == type)
		on_full_insert(M, special, drop_if_replaced)

/obj/item/organ/internal/cyberimp/leg/proc/on_full_insert(mob/living/carbon/M, special, drop_if_replaced)
	return

/obj/item/organ/internal/cyberimp/leg/emp_act(severity)
	. = ..()
	owner.apply_damage(10,BURN,zone)

/obj/item/organ/internal/cyberimp/leg/table_glider
	name = "table-glider implant"
	desc = "Implant that allows you quickly glide tables. You need to implant this in both of your legs to make it work."
	double_legged = TRUE

/obj/item/organ/internal/cyberimp/leg/table_glider/on_full_insert(mob/living/carbon/M, special, drop_if_replaced)
	. = ..()
	ADD_TRAIT(owner,TRAIT_FAST_CLIMBER,type)

/obj/item/organ/internal/cyberimp/leg/table_glider/Remove(mob/living/carbon/M, special)
	REMOVE_TRAIT(owner,TRAIT_FAST_CLIMBER,type)
	return ..()

/obj/item/organ/internal/cyberimp/leg/shove_resist
	name = "BU-TAM resistor implant"
	desc = "Implant that allows you to resist shoves, instead shoves deal pure stamina damage. You need to implant this in both of your legs to make it work."
	double_legged = TRUE

/obj/item/organ/internal/cyberimp/leg/shove_resist/on_full_insert(mob/living/carbon/M, special, drop_if_replaced)
	. = ..()
	ADD_TRAIT(owner,TRAIT_SHOVE_RESIST,type)

/obj/item/organ/internal/cyberimp/leg/shove_resist/Remove(mob/living/carbon/M, special)
	REMOVE_TRAIT(owner,TRAIT_SHOVE_RESIST,type)
	return ..()

/obj/item/organ/internal/cyberimp/leg/accelerator
	name = "P.R.Y.Z.H.O.K. accelerator system"
	desc = "Russian implant that allows you to tackle people. You need to implant this in both of your legs to make it work."
	double_legged = TRUE
	var/datum/component/tackler

/obj/item/organ/internal/cyberimp/leg/accelerator/on_full_insert(mob/living/carbon/M, special, drop_if_replaced)
	. = ..()
	tackler = M.AddComponent(/datum/component/tackler, stamina_cost=30, base_knockdown = 1.5, range = 5, speed = 2, skill_mod = 1.5, min_distance = 3)

/obj/item/organ/internal/cyberimp/leg/accelerator/Remove(mob/living/carbon/M, special)
	if(tackler)
		qdel(tackler)
	return ..()

/obj/item/organ/internal/cyberimp/leg/chemplant
	name = "Debug Chemplant"
	desc = "You shouldn't see this!"
	icon_state = "chemplant"
	implant_overlay = "chemplant_overlay"
	icon = 'massmeta/icons/obj/organs.dmi'
	var/list/reagent_list = list()
	var/health_threshold = 40
	var/max_ticks_cooldown = 60 SECONDS
	var/current_ticks_cooldown = 0
	var/mutable_appearance/overlay

/obj/item/organ/internal/cyberimp/leg/chemplant/Initialize()
	. = ..()

/obj/item/organ/internal/cyberimp/leg/chemplant/on_life()
	//Cost of refilling is a little bit of nutrition, some blood and getting jittery
	if(owner.nutrition > NUTRITION_LEVEL_STARVING && owner.blood_volume > BLOOD_VOLUME_SURVIVE && current_ticks_cooldown > 0)

		owner.nutrition -= 5
		owner.blood_volume--
		owner.adjust_jitter(1 SECONDS)
		owner.adjust_dizzy(1 SECONDS)

		current_ticks_cooldown -= SSmobs.wait

		return

	if(owner.health < health_threshold)
		current_ticks_cooldown = max_ticks_cooldown
		on_effect()

/obj/item/organ/internal/cyberimp/leg/chemplant/emp_act(severity)
	. = ..()
	health_threshold += rand(-10,10)
	current_ticks_cooldown = max_ticks_cooldown
	on_effect()

/obj/item/organ/internal/cyberimp/leg/chemplant/proc/on_effect()
	var/obj/effect/temp_visual/chempunk/punk = new /obj/effect/temp_visual/chempunk(get_turf(owner))
	punk.color = implant_color
	owner.reagents.add_reagent_list(reagent_list)

	overlay = mutable_appearance('massmeta/icons/effects/effects.dmi', "biogas",ABOVE_MOB_LAYER)
	overlay.color = implant_color

	RegisterSignal(owner,COMSIG_ATOM_UPDATE_OVERLAYS,.proc/update_owner_overlay)

	addtimer(CALLBACK(src,.proc/remove_overlay),max_ticks_cooldown/2)

	to_chat(owner,"<span class = 'notice'> You feel a sharp pain as the cocktail of chemicals is injected into your bloodstream!</span>")
	return

/obj/item/organ/internal/cyberimp/leg/chemplant/proc/update_owner_overlay(atom/source, list/overlays)
	SIGNAL_HANDLER

	if(overlay)
		overlays += overlay

/obj/item/organ/internal/cyberimp/leg/chemplant/proc/remove_overlay()
	QDEL_NULL(overlay)

	UnregisterSignal(owner,COMSIG_ATOM_UPDATE_OVERLAYS)

/obj/effect/temp_visual/chempunk
	icon = 'massmeta/icons/effects/biogas.dmi'
	icon_state = "chempunk"
	pixel_x = -32 //So the big ol' 96x96 sprite shows up right
	pixel_y = -32
	layer = BELOW_MOB_LAYER
	duration = 5

/obj/item/organ/internal/cyberimp/leg/chemplant/drugs
	name = "deep-vein emergency morale rejuvenator"
	desc = "Dangerous implant used by the syndicate to reinforce their assault forces that go on suicide missions."
	implant_color = "#74942a"
	reagent_list = list(/datum/reagent/determination = 5, /datum/reagent/drug/methamphetamine = 5 , /datum/reagent/medicine/atropine = 5)

/obj/item/organ/internal/cyberimp/leg/chemplant/emergency
	name = "deep emergency chemical infuser"
	desc = "Dangerous implant used by the syndicate to reinforce their assault forces that go on suicide missions."
	implant_color = "#2a6194"
	reagent_list = list(/datum/reagent/medicine/atropine = 5, /datum/reagent/medicine/omnizine = 3 , /datum/reagent/medicine/leporazine = 3, /datum/reagent/medicine/c2/aiuri = 2, /datum/reagent/medicine/c2/libital = 2)

/obj/item/organ/internal/cyberimp/leg/chemplant/rage
	name = "R.A.G.E. chemical system"
	desc = "Extremely dangerous system that fills the user with a mix of potent drugs in dire situation."
	implant_color = "#ce3914"
	reagent_list = list(/datum/reagent/determination = 2, /datum/reagent/medicine/c2/penthrite = 3 , /datum/reagent/drug/bath_salts = 5 , /datum/reagent/medicine/ephedrine = 5)

/obj/item/organ/internal/cyberimp/arm/cook
	name = "kitchenware toolset implant"
	desc = "A set of kitchen tools hidden behind a concealed panel on the user's arm."
	items_to_create = list(/obj/item/kitchen/rollingpin,/obj/item/knife/kitchen,/obj/item/reagent_containers/cup/beaker)

/obj/item/organ/internal/cyberimp/arm/janitor
	name = "janitorial toolset implant"
	desc = "A set of janitorial tools hidden behind a concealed panel on the user's arm."
	items_to_create = list(/obj/item/mop/advanced,/obj/item/reagent_containers/cup/bucket,/obj/item/soap,/obj/item/reagent_containers/spray/cleaner)

/obj/item/organ/internal/cyberimp/arm/atmospherics
	name = "atmospherics toolset implant"
	desc = "A set of atmospheric tools hidden behind a concealed panel on the user's arm."
	items_to_create = list(/obj/item/extinguisher,/obj/item/analyzer,/obj/item/crowbar,/obj/item/holosign_creator/atmos)
