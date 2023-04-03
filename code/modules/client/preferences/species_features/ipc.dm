/// IPC Screens

/datum/preference/choiced/ipc_screen
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "feature_ipc_screen"
	savefile_identifier = PREFERENCE_CHARACTER
	main_feature_name = "IPC screen"
	relevant_mutant_bodypart = "ipc_screen"

/datum/preference/choiced/ipc_screen/init_possible_values()
	return GLOB.ipc_screens_list

/datum/preference/choiced/ipc_screen/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ipc_screen"] = value

/// IPC Antennas



/datum/preference/choiced/ipc_antenna
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "feature_ipc_antenna"
	savefile_identifier = PREFERENCE_CHARACTER
	main_feature_name = "IPC antenna"
	relevant_mutant_bodypart = "ipc_antenna"

/datum/preference/choiced/ipc_antenna/init_possible_values()
	return GLOB.ipc_antennas_list

/datum/preference/choiced/ipc_antenna/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ipc_antenna"] = value

/*/datum/preference/tri_color/ipc_antenna
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_antenna_color"
	relevant_mutant_bodypart = "ipc_antenna"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_antenna

/datum/preference/tri_bool/ipc_antenna
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_antenna_emissive"
	relevant_mutant_bodypart = "ipc_antenna"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_antenna
*/
/// IPC Chassis

/datum/preference/choiced/ipc_chassis
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "feature_ipc_chassis"
	savefile_identifier = PREFERENCE_CHARACTER
	main_feature_name = "IPC chassis"
	relevant_mutant_bodypart = "ipc_chassis"

/datum/preference/choiced/ipc_chassis/init_possible_values()
	return GLOB.ipc_chassis_list

/datum/preference/choiced/ipc_chassis/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ipc_chassis"] = value

/*/datum/preference/tri_color/ipc_chassis
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_chassis_color"
	relevant_mutant_bodypart = "ipc_chassis"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_chassis*/


/// IPC Head
/*
/datum/preference/toggle/mutant_toggle/ipc_head
	savefile_key = "ipc_head_toggle"
	relevant_mutant_bodypart = "ipc_head"

/datum/preference/choiced/mutant_choice/ipc_head
	savefile_key = "feature_ipc_head"
	relevant_mutant_bodypart = "ipc_head"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_head
	default_accessory_type = /datum/sprite_accessory/ipc_head/none

/datum/preference/tri_color/ipc_head
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_head_color"
	relevant_mutant_bodypart = "ipc_head"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_head*/
