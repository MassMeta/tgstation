/datum/action/cooldown/spell/hive_dominance
	name = "One Mind"
	desc = "Our true power... finally within reach."
	panel = "Hivemind Abilities"
	charge_type = "charges"
	charge_max = 1
	invocation_type = "none"
	clothes_req = 0
	human_req = 1
	button_icon = 'massmeta/icons/mob/actions/actions_hive.dmi'
	background_icon_state = "bg_hive"
	button_icon_state = "assim"
	antimagic_allowed = TRUE

/datum/action/cooldown/spell/hive_dominance/cast(atom/cast_on)
	var/mob/living/user = cast_on
	if(!istype(user))
		return
	var/datum/antagonist/hivemind/hive = user.mind.has_antag_datum(/datum/antagonist/hivemind)
	if(!hive)
		to_chat(user, "<span class='notice'>This is a bug. Error:HIVE1</span>")
		return
	hive.glow = mutable_appearance('icons/effects/hivemind.dmi', "awoken", -BODY_BEHIND_LAYER)
	for(var/datum/antagonist/hivevessel/vessel in hive.avessels)
		var/mob/living/carbon/C = vessel.owner?.current
		C.Jitter(15)
		C.Unconscious(150)
		to_chat(C, "<span class='boldwarning'>Something's wrong...</span>")
		addtimer(CALLBACK(GLOBAL_PROC, /proc/to_chat, C, "<span class='boldwarning'>...your memories are becoming fuzzy.</span>"), 45)
		addtimer(CALLBACK(GLOBAL_PROC, /proc/to_chat, C, "<span class='boldwarning'>You try to remember who you are...</span>"), 90)
		addtimer(CALLBACK(GLOBAL_PROC, /proc/to_chat, C, "<span class='assimilator'>There is no you...</span>"), 110)
		addtimer(CALLBACK(GLOBAL_PROC, /proc/to_chat, C, "<span class='bigassimilator'>...there is only us.</span>"), 130)
		addtimer(CALLBACK(C, /atom/proc/add_overlay, hive.glow), 150)

	for(var/datum/antagonist/hivemind/enemy in GLOB.hivehosts)
		if(enemy.owner)
			enemy.owner.RemoveSpell(new/obj/effect/proc_holder/spell/self/hive_dominance)
			var/mob/living/carbon/C = enemy.owner?.current
			if(!(enemy.hiveID == hive.hiveID))
				to_chat(C, "<span class='boldwarning'>Something's wrong...</span>")
				addtimer(CALLBACK(GLOBAL_PROC, /proc/to_chat, C, "<span class='boldwarning'>...a new presence.</span>"), 45)
				addtimer(CALLBACK(GLOBAL_PROC, /proc/to_chat, C, "<span class='boldwarning'>It feels overwhelming...</span>"), 90)
				addtimer(CALLBACK(GLOBAL_PROC, /proc/to_chat, C, "<span class='assimilator'>It can't be!</span>"), 110)
				addtimer(CALLBACK(GLOBAL_PROC, /proc/to_chat, C, "<span class='bigassimilator'>Get away, run!</span>"), 130)
	sound_to_playing_players('sound/effects/one_mind.ogg')
	addtimer(CALLBACK(user, /atom/proc/add_overlay, hive.glow), 150)
	addtimer(CALLBACK(hive, /datum/antagonist/hivemind/proc/dominance), 150)
	addtimer(CALLBACK(GLOBAL_PROC, /proc/send_to_playing_players, "<span class='bigassimilator'>THE ONE MIND RISES</span>"), 150)
	addtimer(CALLBACK(GLOBAL_PROC, /proc/sound_to_playing_players, 'sound/effects/magic.ogg'), 150)
