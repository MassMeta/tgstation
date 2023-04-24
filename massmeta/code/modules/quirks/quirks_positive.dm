/datum/quirk/cyberorgan //random upgraded cybernetic organ
	name = "Cybernetic Organ"
	desc = "Due to a past incident you lost function of one of your organs, but now have a fancy upgraded cybernetic organ!"
	icon = "building-ngo"
	value = 4
	var/slot_string = "organ"
	var/list/organ_list = list(ORGAN_SLOT_LUNGS, ORGAN_SLOT_HEART, ORGAN_SLOT_LIVER)
	medical_record_text = "During physical examination, patient was found to have an upgraded cybernetic organ."

/datum/quirk/cyberorgan/add_unique(client/client_source)
	var/mob/living/carbon/human/H = quirk_holder
	var/list/temp = organ_list.Copy() //pretty sure this is global so i dont want to bugger with it :)
	if(isjellyperson(H))
		temp -= ORGAN_SLOT_LIVER
	var/organ_slot = pick(temp)
	var/obj/item/organ/old_part = H.get_organ_slot(organ_slot)
	var/obj/item/organ/prosthetic
	switch(organ_slot)
		if(ORGAN_SLOT_LUNGS)
			prosthetic = new/obj/item/organ/internal/lungs/cybernetic/tier3(quirk_holder)
			slot_string = "lungs"
		if(ORGAN_SLOT_HEART)
			prosthetic = new/obj/item/organ/internal/heart/cybernetic/tier3(quirk_holder)
			slot_string = "heart"
		if(ORGAN_SLOT_LIVER)
			prosthetic = new/obj/item/organ/internal/liver/cybernetic/tier3(quirk_holder)
			slot_string = "liver"
	prosthetic.Insert(H)
	qdel(old_part)
	H.regenerate_icons()

/datum/quirk/cyberorgan/post_add()
	to_chat(quirk_holder, "<span class='boldannounce'>Your [slot_string] has been replaced with an upgraded cybernetic variant.</span>")
