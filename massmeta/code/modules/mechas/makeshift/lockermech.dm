/obj/vehicle/sealed/mecha/working/makeshift
	desc = "A locker with stolen wires, struts, electronics and airlock servos crudely assembled into something that resembles the functions of a mech."
	name = "Locker Mech"
	icon = 'massmeta/icons/obj/mech/lockermech.dmi'
	icon_state = "lockermech"
	base_icon_state = "lockermech"
	max_integrity = 100 //its made of scraps
	lights_power = 5
	movedelay = 4 //Same speed as a ripley, for now.

	armor = list(melee = 20, bullet = 10, laser = 10, energy = 0, bomb = 10, bio = 0, rad = 0, fire = 70, acid = 60) //Same armour as a locker
	internal_damage_threshold = 30 //Its got shitty durability
	max_equip_by_category = list(
		MECHA_UTILITY = 2,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)
	wreckage = null

/obj/vehicle/sealed/mecha/working/makeshift/Destroy()
	new /obj/structure/closet(loc)
	..()

/datum/crafting_recipe/lockermech
	name = "Locker Mech"
	result = /obj/vehicle/sealed/mecha/working/makeshift
	reqs = list(/obj/item/stack/cable_coil = 20,
				/obj/item/stack/sheet/iron = 16,
				/obj/item/storage/toolbox = 2, // For feet
				/obj/item/tank/internals/oxygen = 1, // For air
				/obj/item/electronics/airlock = 1, //You are stealing the motors from airlocks
				/obj/item/extinguisher = 1, //For bastard pnumatics
				/obj/item/paper = 5, //Cause paper is the best for making a mech airtight obviously
				/obj/item/flashlight = 1) //For the mech light
	tool_behaviors = list(TOOL_WIRECUTTER, TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 15 SECONDS
	category = CAT_ROBOT

/datum/crafting_recipe/lockermechdrill
	name = "Makeshift exosuit drill"
	result = /obj/item/mecha_parts/mecha_equipment/drill/makeshift
	reqs = list(/obj/item/stack/cable_coil = 5,
				/obj/item/stack/sheet/iron = 2,
				/obj/item/surgicaldrill = 1)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 5 SECONDS
	category = CAT_ROBOT

/datum/crafting_recipe/lockermechclamp
	name = "Makeshift exosuit clamp"
	result = /obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/makeshift
	reqs = list(/obj/item/stack/cable_coil = 5,
				/obj/item/stack/sheet/iron = 2,
				/obj/item/wirecutters = 1) //Don't ask, its just for the grabby grabby thing
	tool_behaviors = list(TOOL_CROWBAR)
	time = 5 SECONDS
	category = CAT_ROBOT

/datum/crafting_recipe/lockermechvolver
	name = "Makeshift mech revolver .357"
	result = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/mech_revolver
	reqs = list(/obj/item/gun/ballistic/revolver = 1,
				/obj/item/stack/rods = 4,
				/obj/item/stack/cable_coil = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WELDER)
	time = 5 SECONDS
	category = CAT_ROBOT

/datum/crafting_recipe/lockermechvolver_38
	name = "Makeshift mech revolver .38"
	result = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/mech_revolver_38
	reqs = list(/obj/item/gun/ballistic/revolver = 1,
				/obj/item/stack/rods = 4,
				/obj/item/stack/cable_coil = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 5 SECONDS
	category = CAT_ROBOT

/datum/crafting_recipe/lockermechvolverammo
	name = "Makeshift mech revolver ammo packet for .357"
	result = /obj/item/mecha_ammo/mech_revolver
	reqs = list(/obj/item/stack/sheet/cardboard = 5,
				/obj/item/stack/sheet/iron = 2,
				/obj/item/ammo_casing/a357 = 7)
	tool_behaviors = list(TOOL_WIRECUTTER)
	time = 2 SECONDS
	category = CAT_ROBOT

/datum/crafting_recipe/lockermechvolverammo_38
	name = "Makeshift mech revolver ammo packet for .38"
	result = /obj/item/mecha_ammo/mech_revolver_38
	reqs = list(/obj/item/stack/sheet/cardboard = 5,
				/obj/item/stack/sheet/iron = 2,
				/obj/item/ammo_casing/c38 = 7,
				/obj/)
	tool_behaviors = list(TOOL_WIRECUTTER)
	time = 2 SECONDS
	category = CAT_ROBOT
