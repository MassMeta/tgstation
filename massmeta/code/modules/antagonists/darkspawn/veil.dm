
/mob/living/proc/add_veil()
	if(!istype(mind))
		return FALSE
	if(HAS_TRAIT(src, TRAIT_MINDSHIELD))
		src.visible_message("<span class='warning'>[src] seems to resist an unseen force!</span>")
		to_chat(src, "<b>Your mind goes numb. Your thoughts go blank. You feel utterly empty. \n\
		A mind brushes against your own. You dream.\n\
		Of a vast, empty Void in the deep of space.\n\
		Something lies in the Void. Ancient. Unknowable. It watches you with hungry eyes. \n\
		Eyes filled with stars.</b>\n\
		<span class='boldwarning'>It needs to die.</span>")
		return FALSE
	return mind.add_antag_datum(/datum/antagonist/veil)

/mob/living/proc/remove_veil()
	if(!istype(mind))
		return FALSE
	return mind.remove_antag_datum(/datum/antagonist/veil)
