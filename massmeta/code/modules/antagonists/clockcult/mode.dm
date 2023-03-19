GLOBAL_VAR_INIT(servants_active, FALSE) //This var controls whether or not a lot of the cult's structures work or not

/proc/is_servant_of_ratvar(mob/M)
	return istype(M) && !isobserver(M) && M.mind && M.mind.has_antag_datum(/datum/antagonist/clockcult)

/proc/is_eligible_servant(mob/M)
	if(!istype(M))
		return FALSE
	if(M.mind)
		if(ishuman(M) && (M.mind.assigned_role in list("Captain", "Chaplain")))
			return FALSE
		if(M.mind.enslaved_to && !is_servant_of_ratvar(M.mind.enslaved_to))
			return FALSE
		if(M.mind.unconvertable)
			return FALSE
	else
		return FALSE
	if(iscultist(M) || isconstruct(M) || ispAI(M))
		return FALSE
	if(isliving(M))
		var/mob/living/L = M
		if(HAS_TRAIT(L, TRAIT_MINDSHIELD))
			return FALSE
	if(ishuman(M) || isbrain(M) || isguardian(M) || issilicon(M) || isclockmob(M) || istype(M, /mob/living/simple_animal/drone/cogscarab) || istype(M, /mob/camera/eminence))
		return TRUE
	return FALSE

/proc/add_servant_of_ratvar(mob/L, silent = FALSE, create_team = TRUE)
	if(!L || !L.mind)
		return
	var/update_type = /datum/antagonist/clockcult
	if(silent)
		update_type = /datum/antagonist/clockcult/silent
	var/datum/antagonist/clockcult/C = new update_type(L.mind)
	C.make_team = create_team
	C.show_in_roundend = create_team //tutorial scarabs begone

	if(iscyborg(L))
		var/mob/living/silicon/robot/R = L
		if(R.deployed)
			var/mob/living/silicon/ai/AI = R.mainframe
			R.undeploy()
			to_chat(AI, "<span class='userdanger'>Anomaly Detected. Returned to core!</span>") //The AI needs to be in its core to properly be converted

	. = L.mind.add_antag_datum(C)

	if(!silent && L)
		if(.)
			to_chat(L, "<span class='heavy_brass'>The world before you suddenly glows a brilliant yellow. [issilicon(L) ? "You cannot compute this truth!" : \
			"Your mind is racing!"] You hear the whooshing steam and cl[pick("ank", "ink", "unk", "ang")]ing cogs of a billion billion machines, and all at once it comes to you.<br>\
			Ratvar, the Clockwork Justiciar, [GLOB.ratvar_awakens ? "has been freed from his eternal prison" : "lies in exile, derelict and forgotten in an unseen realm"].</span>")
			flash_color(L, flash_color = list("#BE8700", "#BE8700", "#BE8700", rgb(0,0,0)), flash_time = 50)
		else
			L.visible_message("<span class='boldwarning'>[L] seems to resist an unseen force!</span>", null, null, 7, L)
			to_chat(L, "<span class='heavy_brass'>The world before you suddenly glows a brilliant yellow. [issilicon(L) ? "You cannot compute this truth!" : \
			"Your mind is racing!"] You hear the whooshing steam and cl[pick("ank", "ink", "unk", "ang")]ing cogs of a billion billion machines, and the sound</span> <span class='boldwarning'>\
			is a meaningless cacophony.</span><br>\
			<span class='userdanger'>You see an abomination of rusting parts[GLOB.ratvar_awakens ? ", and it is here.<br>It is too late" : \
			" in an endless grey void.<br>It cannot be allowed to escape"].</span>")
			L.playsound_local(get_turf(L), 'sound/ambience/antag/clockcultalr.ogg', 40, TRUE, frequency = 100000, pressure_affected = FALSE)
			flash_color(L, flash_color = list("#BE8700", "#BE8700", "#BE8700", rgb(0,0,0)), flash_time = 5)




/proc/remove_servant_of_ratvar(mob/L, silent = FALSE)
	if(!L || !L.mind)
		return
	var/datum/antagonist/clockcult/clock_datum = L.mind.has_antag_datum(/datum/antagonist/clockcult)
	if(!clock_datum)
		return FALSE
	clock_datum.silent = silent
	clock_datum.on_removal()
	return TRUE

//Servant of Ratvar outfit
/datum/outfit/servant_of_ratvar
	name = "Servant of Ratvar"
	uniform = /obj/item/clothing/under/chameleon/ratvar
	shoes = /obj/item/clothing/shoes/sneakers/black
	back = /obj/item/storage/backpack
	ears = /obj/item/radio/headset
	gloves = /obj/item/clothing/gloves/color/yellow
	belt = /obj/item/storage/belt/utility/servant
	backpack_contents = list(/obj/item/storage/box/survival/engineer = 1, \
	/obj/item/clockwork/replica_fabricator = 1, /obj/item/stack/tile/brass/fifty = 1, /obj/item/paper/servant_primer = 1)
	id = /obj/item/modular_computer/pda
	var/plasmaman //We use this to determine if we should activate internals in post_equip()

/datum/outfit/servant_of_ratvar/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(H.dna.species.id == "plasmaman") //Plasmamen get additional equipment because of how they work
		head = /obj/item/clothing/head/helmet/space/plasmaman
		uniform = /obj/item/clothing/under/plasmaman //Plasmamen generally shouldn't need chameleon suits anyways, since everyone expects them to wear their fire suit
		r_hand = /obj/item/tank/internals/plasmaman/belt/full
		mask = /obj/item/clothing/mask/breath
		plasmaman = TRUE

/datum/outfit/servant_of_ratvar/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	var/obj/item/card/id/W = new(H)
	var/obj/item/modular_computer/pda/PDA = H.wear_id
	W.assignment = "Assistant"
	W.access += ACCESS_MAINT_TUNNELS
	W.registered_name = H.real_name
	W.update_label()
	if(plasmaman && !visualsOnly) //If we need to breathe from the plasma tank, we should probably start doing that
		H.internal = H.get_item_for_held_index(2)
		H.update_internals_hud_icon(1)
	PDA.owner = H.real_name
	PDA.ownjob = "Assistant"
	PDA.update_label()
	PDA.id_check(H, W)
	H.sec_hud_set_ID()


//This paper serves as a quick run-down to the cult as well as a changelog to refer to.
//Check strings/clockwork_cult_changelog.txt for the changelog, and update it when you can!
/obj/item/paper/servant_primer
	name = "The Ark And You: A Primer On Servitude"
	color = "#DAAA18"
	info = "<b>DON'T PANIC.</b><br><br>\
	Here's a quick primer on what you should know here.\
	<ol>\
	<li>You're in a place called Reebe right now. The crew can't get here normally.</li>\
	<li>In the north is your base camp, with supplies, consoles, and the Ark. In the south is an inaccessible area that the crew can walk between \
	once they arrive (more on that later.) Everything between that space is an open area.</li>\
	<li>Your job as a servant is to build fortifications and defenses to protect the Ark and your base once the Ark activates. You can do this \
	however you like, but work with your allies and coordinate your efforts.</li>\
	<li>Once the Ark activates, the station will be alerted. Portals to Reebe will open up in nearly every room. When they take these portals, \
	the crewmembers will arrive in the area that you can't access, but can get through it freely - whereas you can't. Treat this as the \"spawn\" of the \
	crew and defend it accordingly.</li>\
	</ol>\
	<hr>\
	Here is the layout of Reebe, from left to right:\
	<ul>\
	<li><b>Dressing Room:</b> Contains clothing, a dresser, and a mirror. There are spare slabs and absconders here.</li>\
	<li><b>Listening Station:</b> Contains intercoms, a telecomms relay, and a list of frequencies.</li>\
	<li><b>Ark Chamber:</b> Houses the Ark.</li>\
	<li><b>Observation Room:</b> Contains five camera observers. These can be used to watch the station through its cameras, as well as to teleport down \
	to most areas. To do this, use the Warp action while hovering over the tile you want to warp to.</li>\
	<li><b>Infirmary:</b> Contains sleepers and basic medical supplies for superficial wounds. The sleepers can consume Vitality to heal any occupants. \
	This room is generally more useful during the preparation phase; when defending the Ark, scripture is more useful.</li>\
	</ul>\
	<hr>\
	<h2>Things that have changed:</h2>\
	<ul>\
	CLOCKCULTCHANGELOG\
	</ul>\
	<hr>\
	<b>Good luck!</b>"

/obj/item/paper/servant_primer/Initialize()
	. = ..()
	var/changelog = world.file2list("strings/clockwork_cult_changelog.txt")
	var/changelog_contents = ""
	for(var/entry in changelog)
		changelog_contents += "<li>[entry]</li>"
	info = replacetext(info, "CLOCKCULTCHANGELOG", changelog_contents)

/obj/item/paper/servant_primer/examine(mob/user)
	. = ..()
	if(!is_servant_of_ratvar(user) && !isobserver(user))
		. += "<span class='danger'>You can't understand any of the words on [src].</span>"
