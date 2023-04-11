/obj/item/organ/internal/tongue/cybernetic
	name = "cybernetic tongue"
	icon = 'massmeta/icons/obj/organs.dmi'
	icon_state = "cybertongue"
	desc =  "A fully-functional synthetic tongue, encased in soft silicone. Features include high-resolution vocals and taste receptors."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	say_mod = "states"
	modifies_speech = TRUE
	taste_sensitivity = 20

/obj/item/organ/internal/tongue/cybernetic/can_speak_language(language)
	return TRUE // THE MAGIC OF ELECTRONICS

/obj/item/organ/internal/tongue/cybernetic/modify_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT
