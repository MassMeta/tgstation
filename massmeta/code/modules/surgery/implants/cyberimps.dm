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
