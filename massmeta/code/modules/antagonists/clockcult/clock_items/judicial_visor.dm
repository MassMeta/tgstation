//Judicial visor: Grants the ability to smite an area and knocking down the unfaithful nearby every thirty seconds.
/obj/item/clothing/glasses/judicial_visor
	name = "judicial visor"
	desc = "A strange purple-lensed visor. Looking at it inspires an odd sense of guilt."
	icon = 'massmeta/icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "judicial_visor_0"
	worn_icon_state = "sunglasses"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	flash_protect = FLASH_PROTECTION_FLASH
	var/active = FALSE //If the visor is online
	var/recharging = FALSE //If the visor is currently recharging
	var/datum/action/cooldown/judicial_visor/blaster
	var/recharge_cooldown = 300 //divided by 10 if ratvar is alive
	actions_types = list(/datum/action/item_action/clock/toggle_visor)

/obj/item/clothing/glasses/judicial_visor/Initialize()
	. = ..()
	GLOB.all_clockwork_objects += src
	blaster = new(src)
	blaster.visor = src

/obj/item/clothing/glasses/judicial_visor/Destroy()
	GLOB.all_clockwork_objects -= src
	blaster.visor = null
	if(blaster.owner)
		blaster.Remove(owner)
	qdel(blaster)
	return ..()

/obj/item/clothing/glasses/judicial_visor/item_action_slot_check(slot, mob/user)
	if(slot != ITEM_SLOT_EYES)
		return 0
	return ..()

/obj/item/clothing/glasses/judicial_visor/equipped(mob/living/user, slot)
	..()
	if(slot != ITEM_SLOT_EYES)
		update_status(FALSE)
		if(blaster.owner)
			blaster.unset_click_ability(blaster.owner)
		return 0
	if(is_servant_of_ratvar(user))
		update_status(TRUE)
	else
		update_status(FALSE)
	if(IS_CULTIST(user)) //Cultists spontaneously combust
		to_chat(user, "<span class='heavy_brass'>\"Consider yourself judged, whelp.\"</span>")
		to_chat(user, "<span class='userdanger'>You suddenly catch fire!</span>")
		user.adjust_fire_stacks(5)
		user.ignite_mob()
	return 1

/obj/item/clothing/glasses/judicial_visor/dropped(mob/user)
	. = ..()
	addtimer(CALLBACK(src, .proc/check_on_mob, user), 1) //dropped is called before the item is out of the slot, so we need to check slightly later

/obj/item/clothing/glasses/judicial_visor/proc/check_on_mob(mob/user)
	if(user && src != user.get_item_by_slot(ITEM_SLOT_EYES)) //if we happen to check and we AREN'T in the slot, we need to remove our shit from whoever we got dropped from
		update_status(FALSE)
		if(blaster.owner)
			var/to_unset = blaster.owner || user
			blaster.unset_click_ability(to_unset)

/obj/item/clothing/glasses/judicial_visor/attack_self(mob/user)
	if(is_servant_of_ratvar(user) && src == user.get_item_by_slot(ITEM_SLOT_EYES))
		blaster.toggle(user)

/obj/item/clothing/glasses/judicial_visor/proc/update_status(change_to)
	if(recharging || !isliving(loc))
		icon_state = "judicial_visor_0"
		return 0
	if(active == change_to)
		return 0
	var/mob/living/L = loc
	active = change_to
	icon_state = "judicial_visor_[active]"
	if(!is_servant_of_ratvar(L) || L.stat)
		return 0
	switch(active)
		if(TRUE)
			to_chat(L, "<span class='notice'>As you put on [src], its lens begins to glow, information flashing before your eyes.</span>\n\
			<span class='heavy_brass'>Judicial visor active. Use the action button to gain the ability to smite the unworthy.</span>")
		if(FALSE)
			to_chat(L, "<span class='notice'>As you take off [src], its lens darkens once more.</span>")
	return 1

/obj/item/clothing/glasses/judicial_visor/proc/recharge_visor(mob/living/user)
	if(!src)
		return 0
	recharging = FALSE
	if(user && src == user.get_item_by_slot(ITEM_SLOT_EYES))
		to_chat(user, "<span class='brass'>Your [name] hums. It is ready.</span>")
	else
		active = FALSE
	icon_state = "judicial_visor_[active]"

/datum/action/cooldown/judicial_visor
	var/active = FALSE
	click_to_activate = TRUE
	ranged_mousepointer = 'massmeta/icons/effects/visor_reticule.dmi'
	var/obj/item/clothing/glasses/judicial_visor/visor

/datum/action/cooldown/judicial_visor/proc/toggle(mob/user)
	var/message
	if(active)
		message = "<span class='brass'>You dispel the power of [visor].</span>"
		unset_click_ability(user)
	else
		message = "<span class='brass'><i>You harness [visor]'s power.</i> <b>Left-click to place a judicial marker!</b></span>"
		set_click_ability(user)

/datum/action/cooldown/judicial_visor/Activate(atom/target)
	if(owner.incapacitated() || !visor || visor != owner.get_item_by_slot(ITEM_SLOT_EYES))
		unset_click_ability(owner)
		return

	var/turf/T = owner.loc
	if(!isturf(T))
		return FALSE

	if(target in view(7, get_turf(owner)))
		visor.recharging = TRUE
		visor.update_status()
		for(var/obj/item/clothing/glasses/judicial_visor/V in owner.get_all_contents())
			if(V == visor)
				continue
			V.recharging = TRUE //To prevent exploiting multiple visors to bypass the cooldown
			V.update_status()
			addtimer(CALLBACK(V, /obj/item/clothing/glasses/judicial_visor.proc/recharge_visor, owner), (GLOB.ratvar_awakens ? visor.recharge_cooldown*0.1 : visor.recharge_cooldown) * 2)
		clockwork_say(owner, text2ratvar("Kneel, heathens!"))
		owner.visible_message("<span class='warning'>[owner]'s judicial visor fires a stream of energy at [target], creating a strange mark!</span>", "<span class='heavy_brass'>You direct [visor]'s power to [target]. You must wait for some time before doing this again.</span>")
		var/turf/targetturf = get_turf(target)
		new/obj/effect/clockwork/judicial_marker(targetturf, owner)
		log_combat(owner, targetturf, "created a judicial marker")
		owner.update_action_buttons_icon()
		owner.update_inv_glasses()
		addtimer(CALLBACK(visor, /obj/item/clothing/glasses/judicial_visor.proc/recharge_visor, owner), GLOB.ratvar_awakens ? visor.recharge_cooldown*0.1 : visor.recharge_cooldown)//Cooldown is reduced by 10x if Ratvar is up
		unset_click_ability(owner)

		return TRUE
	return FALSE

//Judicial marker: Created by the judicial visor. Immediately applies Belligerent and briefly knocks down, then after 3 seconds does large damage and briefly knocks down again
/obj/effect/clockwork/judicial_marker
	name = "judicial marker"
	desc = "You get the feeling that you shouldn't be standing here."
	clockwork_desc = "A sigil that will soon erupt and smite any unenlightened nearby."
	icon = 'icons/effects/96x96.dmi'
	icon_state = "transparent"
	pixel_x = -32
	pixel_y = -32
	layer = BELOW_MOB_LAYER
	var/mob/user

/obj/effect/clockwork/judicial_marker/Initialize(mapload, caster)
	. = ..()
	set_light(1.4, 2, "#FE9C11")
	user = caster
	INVOKE_ASYNC(src, .proc/judicialblast)

/obj/effect/clockwork/judicial_marker/singularity_act()
	return

/obj/effect/clockwork/judicial_marker/singularity_pull()
	return

/obj/effect/clockwork/judicial_marker/proc/judicialblast()
	playsound(src, 'sound/magic/magic_missile.ogg', 50, TRUE, TRUE, TRUE)
	flick("judicial_marker", src)
	for(var/mob/living/carbon/C in range(1, src))
		var/datum/status_effect/belligerent/B = C.apply_status_effect(STATUS_EFFECT_BELLIGERENT)
		if(!QDELETED(B))
			B.duration = world.time + 30
			C.Paralyze(5) //knocks down for half a second if affected
	sleep(!GLOB.ratvar_approaches ? 16 : 10)
	name = "judicial blast"
	layer = ABOVE_ALL_MOB_LAYER
	flick("judicial_explosion", src)
	set_light(1.4, 2, "#B451A1")
	sleep(13)
	name = "judicial explosion"
	var/targetsjudged = 0
	playsound(src, 'sound/effects/explosion_distant.ogg', 100, TRUE, TRUE, TRUE)
	set_light(0)
	for(var/mob/living/L in range(1, src))
		if(is_servant_of_ratvar(L))
			continue
		if(L.can_block_magic(MAGIC_RESISTANCE))
			continue
		L.Paralyze(15) //knocks down briefly when exploding
		if(!IS_CULTIST(L))
			L.visible_message("<span class='warning'>[L] is struck by a judicial explosion!</span>", \
			"<span class='userdanger'>[!issilicon(L) ? "An unseen force slams you into the ground!" : "ERROR: Motor servos disabled by external source!"]</span>")
		else
			L.visible_message("<span class='warning'>[L] is struck by a judicial explosion!</span>", \
			"<span class='heavy_brass'>\"Keep an eye out, filth.\"</span>\n<span class='userdanger'>A burst of heat crushes you against the ground!</span>")
			L.adjust_fire_stacks(2) //sets cultist targets on fire
			L.ignite_mob()
			L.adjustFireLoss(5)
		targetsjudged++
		if(!QDELETED(L))
			L.adjustBruteLoss(20) //does a decent amount of damage
		log_combat(user, L, "struck with a judicial blast")
	to_chat(user, "<span class='brass'><b>[targetsjudged ? "Successfully judged <span class='neovgre'>[targetsjudged]</span>":"Judged no"] heretic[targetsjudged == 1 ? "":"s"].</b></span>")
	sleep(3) //so the animation completes properly
	qdel(src)

/obj/effect/clockwork/judicial_marker/ex_act(severity)
	return
