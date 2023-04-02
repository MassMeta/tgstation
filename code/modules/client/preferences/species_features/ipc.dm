/// IPC Screens

/datum/preference/toggle/mutant_toggle/ipc_screen
	savefile_key = "ipc_screen_toggle"
	relevant_mutant_bodypart = "ipc_screen"

/datum/preference/choiced/mutant_choice/ipc_screen
	savefile_key = "feature_ipc_screen"
	relevant_mutant_bodypart = "ipc_screen"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_screen
	default_accessory_type = /datum/sprite_accessory/screen/none

/datum/preference/tri_color/ipc_screen
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_screen_color"
	relevant_mutant_bodypart = "ipc_screen"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_screen

/datum/preference/tri_bool/ipc_screen
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_screen_emissive"
	relevant_mutant_bodypart = "ipc_screen"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_screen

/// IPC Antennas

/datum/preference/toggle/mutant_toggle/ipc_antenna
	savefile_key = "ipc_antenna_toggle"
	relevant_mutant_bodypart = "ipc_antenna"

/datum/preference/choiced/mutant_choice/ipc_antenna
	savefile_key = "feature_ipc_antenna"
	relevant_mutant_bodypart = "ipc_antenna"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_antenna
	default_accessory_type = /datum/sprite_accessory/antenna/none

/datum/preference/tri_color/ipc_antenna
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

/// IPC Chassis

/datum/preference/toggle/mutant_toggle/ipc_chassis
	savefile_key = "ipc_chassis_toggle"
	relevant_mutant_bodypart = "ipc_chassis"

/datum/preference/choiced/mutant_choice/ipc_chassis
	savefile_key = "feature_ipc_chassis"
	relevant_mutant_bodypart = "ipc_chassis"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_chassis
	default_accessory_type = /datum/sprite_accessory/ipc_chassis/none

/datum/preference/tri_color/ipc_chassis
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_chassis_color"
	relevant_mutant_bodypart = "ipc_chassis"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_chassis


/// IPC Head

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
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_head
