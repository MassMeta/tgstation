/datum/bloodsucker_clan/brujah
	name = CLAN_BRUJAH
	description = "The Brujah Clan has proven to be the strongest in melee combat, boasting a powerful punch. \n\
		They also appear to be more calm than the others, entering their 'frenzies' whenever they want, but dont seem affected much by them. \n\
		Be wary, as they are fearsome warriors, rebels and anarchists, with an inclination towards Frenzy. \n\
		The Favorite Vassal gains brawn and a massive increase in brute damage from punching."
	joinable_clan = TRUE
	controlled_frenzy = TRUE
	join_description = "You gain increased damage from your unarmed attacks and from Brawn power.\
		You enter Frenzy much faster then other clans, but you are able to enter and exit it at will,\
		and you are able to use your powers while in Frenzy. Your favourite vassal gains Brawn ability and increased punch damage."
	join_icon_state = "brujah"

/datum/bloodsucker_clan/brujah/New(mob/living/carbon/user)
	. = ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	if(!bloodsuckerdatum)
		return
	bloodsuckerdatum.BuyPower(/datum/action/bloodsucker/brujah) // :)
	bloodsuckerdatum.AddHumanityLost(17.5) // :(
	for(var/obj/item/bodypart/bodypart in user.bodyparts)
		bodypart.unarmed_damage_high += 1.5
		bodypart.unarmed_damage_low += 1.5

/datum/bloodsucker_clan/brujah/on_favorite_vassal(datum/source, datum/antagonist/vassal/vassaldatum, mob/living/bloodsucker)
	. = ..()
	var/mob/living/carbon/carbon_vassal = vassaldatum.owner.current
	if(!istype(carbon_vassal))
		return
	for(var/obj/item/bodypart/bodypart in carbon_vassal.bodyparts)
		bodypart.unarmed_damage_high += 1.5
		bodypart.unarmed_damage_low += 1.5
