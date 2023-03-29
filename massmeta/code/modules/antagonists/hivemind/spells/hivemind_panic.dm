/datum/action/cooldown/spell/aoe/induce_panic
	name = "Induce Panic"
	desc = "We unleash a burst of psionic energy, inducing a debilitating fear in those around us and reducing their combat readiness. We can also briefly affect silicon-based life with this burst."
	panel = "Hivemind Abilities"
	charge_max = 900
	range = 7
	invocation_type = "none"
	clothes_req = 0
	max_targets = 0
	antimagic_allowed = TRUE
	action_icon = 'massmeta/icons/mob/actions/actions_hive.dmi'
	action_background_icon_state = "bg_hive"
	action_icon_state = "panic"

/datum/action/cooldown/spell/aoe/induce_panic/get_things_to_cast_on(atom/center)
	RETURN_TYPE(/list)

	var/list/things = list()
	// Default behavior is to get all atoms in range, center and owner not included.
	for(var/mob/living/carbon/human/nearby_thing in range(aoe_radius, center))
		if(!istype(nearby_thing))
			continue
		if(nearby_thing == owner || nearby_thing == center)
			continue
		if(nearby_thing.stat == DEAD)
			continue

		things += nearby_thing

	return things

/datum/action/cooldown/spell/aoe/cast_on_thing_in_aoe(atom/victim, atom/caster)
	var/mob/living/carbon/human/target = victim
	if(!istype(victim))
		return
	target.Jitter(14)
	target.apply_damage(35 + rand(0,15), STAMINA, target.get_bodypart(BODY_ZONE_HEAD))
	if(IS_HIVEHOST(target))
		return
	if(prob(20))
		var/text = pick(";HELP!","I'm losing control of the situation!!","Get me outta here!")
		target.say(text, forced = "panic")
		var/effect = rand(1,4)
	switch(effect)
		if(1)
			to_chat(target, "<span class='userdanger'>You panic and drop everything to the ground!</span>")
			target.drop_all_held_items()
		if(2)
			to_chat(target, "<span class='userdanger'>You panic and flail around!</span>")
			target.click_random_mob()
			addtimer(CALLBACK(target, /mob/proc/click_random_mob), 5)
			addtimer(CALLBACK(target, /mob/proc/click_random_mob), 10)
			addtimer(CALLBACK(target, /mob/proc/click_random_mob), 15)
			addtimer(CALLBACK(target, /mob/proc/click_random_mob), 20)
			addtimer(CALLBACK(target, /mob/living.proc/Stun, 30), 25)
			target.confused += 10
		if(3)
			to_chat(target, "<span class='userdanger'>You freeze up in fear!</span>")
			target.Stun(30)
		if(4)
			to_chat(target, "<span class='userdanger'>You feel nauseous as dread washes over you!</span>")
			target.Dizzy(15)
			target.apply_damage(30, STAMINA, target.get_bodypart(BODY_ZONE_HEAD))
			target.hallucination += 45
	target.Unconscious(50)
