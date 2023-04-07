/datum/design/cyberimp_mantis
	name = "Mantis Blade Implant"
	desc = "A long, sharp, mantis-like blade installed within the forearm, acting as a deadly self defense weapon."
	id = "ci-mantis"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 200
	materials = list (/datum/material/iron = 3500, /datum/material/glass = 1500, /datum/material/silver = 1500)
	build_path = /obj/item/organ/internal/cyberimp/arm/armblade
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_COMBAT
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
