/datum/design/cyberimp_nv
	name = "Night Vision Eyes"
	desc = "These cybernetic eyes will give you Night Vision. Big, mean, and green."
	id = "ci-nv"
	build_type = MECHFAB | PROTOLATHE
	construction_time = 60
	materials = list(/datum/material/iron = 600, /datum/material/glass = 600, /datum/material/silver = 600, /datum/material/gold = 600, /datum/material/uranium = 1000,)
	build_path = /obj/item/organ/internal/eyes/night_vision/cyber
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_antisleep
	name = "CNS Jumpstarter Implant"
	desc = "This implant will automatically attempt to jolt you awake from unconsciousness, with a short cooldown between jolts. Conflicts with the CNS Rebooter."
	id = "ci-antisleep"
	build_type = MECHFAB | PROTOLATHE
	construction_time = 60
	materials = list(/datum/material/iron = 600, /datum/material/glass = 600, /datum/material/silver = 1000, /datum/material/gold = 500)
	build_path = /obj/item/organ/internal/cyberimp/brain/anti_sleep
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_scanner
	name = "Internal Medical Analyzer"
	desc = "This implant interfaces with a host's body, sending detailed readouts of the vessel's condition on command via the mind."
	id = "ci-scanner"
	build_type = MECHFAB | PROTOLATHE
	construction_time = 40
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 2500, /datum/material/silver = 2000, /datum/material/gold = 1500)
	build_path = /obj/item/organ/internal/cyberimp/chest/scanner
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_tongue
	name = "Cybernetic Tongue"
	desc = "A cybernetic tongue."
	id = "cybernetic_tongue"
	construction_time = 50
	build_type = MECHFAB | PROTOLATHE
	materials = list(/datum/material/iron = 800, /datum/material/glass = 600)
	build_path = /obj/item/organ/internal/tongue/cybernetic
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL


/datum/design/cyberimp_nanite_heart
	name = "Nanite Heart"
	desc = "A heart that improves the functions of nanites"
	id = "ci-nanite-heart"
	build_type = MECHFAB | PROTOLATHE
	construction_time = 60
	materials = list(/datum/material/iron = 200, /datum/material/glass = 500, /datum/material/silver = 300, /datum/material/gold = 300)
	build_path = /obj/item/organ/internal/heart/nanite
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/tableclimber
	name = "Table-gliding cybernetic"
	desc = "A cybernetic implant, which increases your climbing speed, through it doesn't help with getting down. You should insert two of them in order to make them work."
	id = "ci-tableclimber"
	build_type = MECHFAB | PROTOLATHE
	construction_time = 40
	materials = list(/datum/material/iron = 7000, /datum/material/silver = 2000)
	build_path = /obj/item/organ/internal/cyberimp/leg/table_glider
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
