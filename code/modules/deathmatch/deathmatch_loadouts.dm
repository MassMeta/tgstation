/datum/deathmatch_loadout
	var/name = "Loadout"
	var/desc = ":KILL:"
	var/list/equipment
	// Just in case, make sure this doesn't have an ID.
	var/datum/outfit/outfit
	var/datum/species/default_species
	var/force_default = FALSE
	var/list/add_mutations = list()
	var/list/datum/species/blacklist = list(/datum/species/plasmaman)

/datum/deathmatch_loadout/proc/pre_equip(mob/living/carbon/human/player)
	return

/datum/deathmatch_loadout/proc/equip(mob/living/carbon/human/player)
	SHOULD_CALL_PARENT(TRUE)
	pre_equip(player)
	if (default_species && (force_default || (player.dna.species.type in blacklist)))
		player.set_species(default_species)
	if (outfit)
		player.equipOutfit(outfit, TRUE)
	for (var/E in equipment)
		var/S = equipment[E]
		if (ispath(E))
			player.equip_to_slot(new E, S, TRUE)
			continue
		for (var/P in E)
			var/count = E[P] ? E[P] : 1
			for (var/I in 1 to count)
				player.equip_to_slot(new P, S, TRUE)
	for(var/mutation in add_mutations)
		player.dna.add_mutation(mutation)
	post_equip(player)

// For stuff you might want to do with the items after equiping.
/datum/deathmatch_loadout/proc/post_equip(mob/living/carbon/human/player)
	return

/datum/deathmatch_loadout/assistant
	name = "Assistant loadout"
	desc = "A simple assistant loadout: greyshirt and a toolbox"
	default_species = /datum/species/human
	equipment = list(
		/obj/item/storage/toolbox/mechanical/old/empty = ITEM_SLOT_HANDS
	)

/datum/deathmatch_loadout/assistant/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/under/color/grey, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/shoes/sneakers/black, ITEM_SLOT_FEET)
	player.equip_to_slot(new /obj/item/storage/backpack, ITEM_SLOT_BACK)
	player.equip_to_slot(new /obj/item/storage/box/survival, ITEM_SLOT_BACKPACK)
	player.equip_to_slot(new /obj/item/modular_computer/pda, ITEM_SLOT_ID) // For the lamp.

/datum/deathmatch_loadout/assistant/weaponless
	name = "Assistant loadout (Weaponless)"
	desc = "What is an assistant without a toolbox? nothing"
	equipment = list()

/datum/deathmatch_loadout/operative
	name = "Operative"
	desc = "A syndicate operative."
	default_species = /datum/species/human

/datum/deathmatch_loadout/operative/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/under/syndicate, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/gloves/tackler/combat/insulated, ITEM_SLOT_GLOVES)
	player.equip_to_slot(new /obj/item/clothing/shoes/combat, ITEM_SLOT_FEET)
	player.equip_to_slot(new /obj/item/storage/backpack, ITEM_SLOT_BACK)
	player.equip_to_slot(new /obj/item/card/id/advanced/chameleon, ITEM_SLOT_ID)

/datum/deathmatch_loadout/operative/ranged
	name = "Ranged Operative"
	desc = "A syndicate operative with a gun and a knife."
	default_species = /datum/species/human
	equipment = list(
		/obj/item/gun/ballistic/automatic/pistol = ITEM_SLOT_HANDS,
		list(/obj/item/ammo_box/magazine/m9mm = 5) = ITEM_SLOT_BACKPACK,
		/obj/item/knife/combat = ITEM_SLOT_LPOCKET
	)

/datum/deathmatch_loadout/operative/ranged/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/gloves/combat, ITEM_SLOT_GLOVES)
	. = ..()

/datum/deathmatch_loadout/operative/melee
	name = "Melee Operative"
	desc = "A syndicate operative with multiple knives."
	default_species = /datum/species/human
	equipment = list(
		/obj/item/clothing/suit/armor/vest = ITEM_SLOT_OCLOTHING,
		/obj/item/clothing/head/helmet = ITEM_SLOT_HEAD,
		list(/obj/item/knife/combat = 6) = ITEM_SLOT_BACKPACK,
		/obj/item/knife/combat = ITEM_SLOT_HANDS,
		/obj/item/knife/combat = ITEM_SLOT_LPOCKET
	)

/datum/deathmatch_loadout/securing_sec
	name = "Security Officer"
	desc = "A security officer."
	default_species = /datum/species/human
	outfit = /datum/outfit/job/security
	equipment = list(
		/obj/item/gun/energy/disabler = ITEM_SLOT_HANDS,
		/obj/item/flashlight/seclite = ITEM_SLOT_LPOCKET,
		/obj/item/knife/combat/survival = ITEM_SLOT_RPOCKET
	)

/datum/deathmatch_loadout/instagib
	name = "Instagib"
	desc = "Assistant with an instakill rifle."
	default_species = /datum/species/human
	equipment = list(
		/obj/item/gun/energy/laser/instakill = ITEM_SLOT_HANDS
	)

/datum/deathmatch_loadout/samurai
	name = "Samurai"
	desc = "Bare-footed man craves to bloodshed."
	default_species = /datum/species/human
	equipment = list(
		/obj/item/katana = ITEM_SLOT_HANDS
	)

/datum/deathmatch_loadout/samurai/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/under/costume/gi, ITEM_SLOT_ICLOTHING)

/datum/deathmatch_loadout/chef
	name = "Chef"
	desc = "He love pizza."
	default_species = /datum/species/human
	outfit = /datum/outfit/job/cook

/datum/deathmatch_loadout/chef/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/gloves/the_sleeping_carp/butcher, ITEM_SLOT_GLOVES)

/datum/deathmatch_loadout/operative/sniper
	name = "Sniper"
	desc = "You know what do you need to do"
	default_species = /datum/species/human
	equipment = list(
		/obj/item/gun/ballistic/rifle/sniper_rifle = ITEM_SLOT_HANDS,
		list(/obj/item/ammo_box/magazine/sniper_rounds = 3) = ITEM_SLOT_BACKPACK,
		/obj/item/knife/combat = ITEM_SLOT_LPOCKET
	)

/datum/deathmatch_loadout/operative/sniper/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/glasses/thermal, ITEM_SLOT_EYES)
	player.equip_to_slot(new /obj/item/clothing/under/syndicate/sniper, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/gloves/tackler/combat/insulated, ITEM_SLOT_GLOVES)
	player.equip_to_slot(new /obj/item/clothing/shoes/combat, ITEM_SLOT_FEET)
	player.equip_to_slot(new /obj/item/storage/backpack, ITEM_SLOT_BACK)

///////////////////////////////////////////////////////////////////////
//					Arena Station loadouts							//
/////////////////////////////////////////////////////////////////////

/datum/deathmatch_loadout/battler
	name = "Battler"
	desc = "What is a battler whith out weapone?."
	default_species = /datum/species/human

/datum/deathmatch_loadout/battler/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/under/syndicate, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/gloves/combat, ITEM_SLOT_GLOVES)
	player.equip_to_slot(new /obj/item/clothing/shoes/combat, ITEM_SLOT_FEET)
	player.equip_to_slot(new /obj/item/storage/backpack, ITEM_SLOT_BACK)
	player.equip_to_slot(new /obj/item/card/id/advanced/chameleon, ITEM_SLOT_ID)

/datum/deathmatch_loadout/battler/soldier
	name = "Soldier"
	desc = "Ready to combat."
	default_species = /datum/species/human
	equipment = list(
		/obj/item/gun/ballistic/rifle = ITEM_SLOT_HANDS,
		list(/obj/item/grenade/smokebomb = 2) = ITEM_SLOT_BACKPACK,
		list(/obj/item/ammo_box/a762 = 4) = ITEM_SLOT_BACKPACK,
		/obj/item/knife/combat = ITEM_SLOT_LPOCKET
	)

/datum/deathmatch_loadout/battler/soldier/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/under/syndicate/rus_army, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/head/helmet/rus_helmet, ITEM_SLOT_HEAD)
	player.equip_to_slot(new /obj/item/clothing/suit/armor/vest, ITEM_SLOT_OCLOTHING)
	player.equip_to_slot(new /obj/item/clothing/gloves/tackler/combat/insulated, ITEM_SLOT_GLOVES)
	. = ..()

/datum/deathmatch_loadout/battler/druid
	name = "Druid"
	desc = "How this plants can help you?"
	force_default = TRUE
	default_species = /datum/species/pod
	equipment = list(
		/obj/item/gun/ballistic/bow = ITEM_SLOT_HANDS,
		/obj/item/ammo_casing/caseless/arrow = ITEM_SLOT_HANDS,
		list(/obj/item/reagent_containers/syringe/crude/mushroomhallucinogen) = ITEM_SLOT_BACKPACK,
		list(/obj/item/reagent_containers/syringe/crude/blastoff) = ITEM_SLOT_BACKPACK,
		list(/obj/item/ammo_casing/caseless/arrow) = ITEM_SLOT_BACKPACK,
		list(/obj/item/food/grown/nettle/death/powerful = 2) = ITEM_SLOT_BACKPACK,
		list(/obj/item/food/grown/banana = 2) = ITEM_SLOT_BACKPACK,
		list(/obj/item/food/grown/cherry_bomb = 2) = ITEM_SLOT_BACKPACK,
		list(/obj/item/food/grown/tomato/blood = 2) = ITEM_SLOT_BACKPACK,
		list(/obj/item/food/grown/mushroom/walkingmushroom = 2) = ITEM_SLOT_BACKPACK,
		list(/obj/item/seeds/kudzu) = ITEM_SLOT_BACKPACK,
		/obj/item/knife/shiv/carrot = ITEM_SLOT_LPOCKET,
		/obj/item/flashlight/lantern = ITEM_SLOT_RPOCKET
	)

/datum/deathmatch_loadout/battler/druid/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/food/grown/ambrosia/gaia, ITEM_SLOT_HEAD)
	player.equip_to_slot(new /obj/item/clothing/under/shorts/green, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/mask/gas/tiki_mask, ITEM_SLOT_MASK)
	player.equip_to_slot(new /obj/item/clothing/glasses/thermal, ITEM_SLOT_EYES)
	player.equip_to_slot(new /obj/item/clothing/neck/cloak/botancloak, ITEM_SLOT_NECK)
	player.equip_to_slot(new /obj/item/clothing/gloves/botanic_leather, ITEM_SLOT_GLOVES)
	player.equip_to_slot(new /obj/item/gun/syringe/blowgun, ITEM_SLOT_BELT)
	player.equip_to_slot(new /obj/item/storage/backpack/santabag, ITEM_SLOT_BACK)
	player.equip_to_slot(new /obj/item/clothing/shoes/sandal, ITEM_SLOT_FEET)
	. = ..()

/datum/deathmatch_loadout/battler/northstar
	name = "North star"
	desc = "flip flip flip"
	default_species = /datum/species/human
	equipment = list(
		list(/obj/item/throwing_star = 6) = ITEM_SLOT_BACKPACK,
		list(/obj/item/restraints/legcuffs/bola/tactical = 2) = ITEM_SLOT_BACKPACK
	)
/datum/deathmatch_loadout/battler/northstar/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/under/suit/carpskin, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/head/fedora/carpskin, ITEM_SLOT_HEAD)
	player.equip_to_slot(new /obj/item/clothing/gloves/chameleon/rapid, ITEM_SLOT_GLOVES)
	. = ..()

/datum/deathmatch_loadout/battler/janitor
	name = "Janitor"
	desc = "Regular work"
	default_species = /datum/species/human
	equipment = list(
		/obj/item/pushbroom = ITEM_SLOT_HANDS,
		list(/obj/item/grenade/chem_grenade/cleaner = 2) = ITEM_SLOT_BACKPACK,
		list(/obj/item/restraints/legcuffs/beartrap = 3) = ITEM_SLOT_BACKPACK,
		list(/obj/item/soap) = ITEM_SLOT_BACKPACK,
		/obj/item/reagent_containers/spray/lube = ITEM_SLOT_LPOCKET
	)
/datum/deathmatch_loadout/battler/janitor/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/under/rank/civilian/janitor, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/suit/caution, ITEM_SLOT_OCLOTHING)
	player.equip_to_slot(new /obj/item/reagent_containers/cup/bucket, ITEM_SLOT_HEAD)
	player.equip_to_slot(new /obj/item/clothing/shoes/chameleon/noslip, ITEM_SLOT_FEET)
	. = ..()

/datum/deathmatch_loadout/battler/surgeon
	name = "Surgeon"
	desc = "Treatment has come"
	default_species = /datum/species/human
	equipment = list(
		/obj/item/chainsaw  = ITEM_SLOT_HANDS,
		list(/obj/item/reagent_containers/hypospray/combat) = ITEM_SLOT_LPOCKET,
		list(/obj/item/reagent_containers/hypospray/medipen/penthrite) = ITEM_SLOT_RPOCKET,
		list(/obj/item/storage/medkit/tactical) = ITEM_SLOT_BACKPACK,
		list(/obj/item/reagent_containers/hypospray/medipen/stimulants) = ITEM_SLOT_BACKPACK
	)
/datum/deathmatch_loadout/battler/surgeon/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/under/rank/medical/scrubs/blue, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/glasses/hud/health/night, ITEM_SLOT_EYES)
	player.equip_to_slot(new /obj/item/clothing/suit/apron/surgical, ITEM_SLOT_OCLOTHING)
	player.equip_to_slot(new /obj/item/clothing/head/utility/surgerycap, ITEM_SLOT_HEAD)
	player.equip_to_slot(new /obj/item/clothing/mask/surgical, ITEM_SLOT_MASK)
	. = ..()

/datum/deathmatch_loadout/battler/raider
	name = "Raider"
	desc = "Not from Shadow Legends"
	default_species = /datum/species/human
	equipment = list(
		/obj/item/nullrod/claymore/chainsaw_sword  = ITEM_SLOT_HANDS,
		list(/obj/item/switchblade) = ITEM_SLOT_RPOCKET
	)
/datum/deathmatch_loadout/battler/raider/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/under/costume/jabroni, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/spear, ITEM_SLOT_BACK)
	player.equip_to_slot(new /obj/item/gun/magic/hook, ITEM_SLOT_BELT)
	player.equip_to_slot(new /obj/item/clothing/head/utility/welding, ITEM_SLOT_HEAD)
	. = ..()

/datum/deathmatch_loadout/battler/clown
	name = "Clown"
	desc = "Who called this honking clown"
	default_species = /datum/species/human
	outfit = /datum/outfit/job/clown
	equipment = list(
		/obj/item/pneumatic_cannon/pie/selfcharge = ITEM_SLOT_HANDS,
		/obj/item/melee/energy/sword/bananium = ITEM_SLOT_LPOCKET,
		/obj/item/shield/energy/bananium = ITEM_SLOT_RPOCKET,
		/obj/item/bikehorn = ITEM_SLOT_HANDS,
		list(/obj/item/reagent_containers/cup/soda_cans/canned_laughter) = ITEM_SLOT_BACKPACK,
		list(/obj/item/instrument/bikehorn) = ITEM_SLOT_BACKPACK,
		list(/obj/item/bikehorn/airhorn) = ITEM_SLOT_BACKPACK,
		list(/obj/item/food/grown/banana = 2) = ITEM_SLOT_BACKPACK,
		list(/obj/item/food/pie/cream = 2) = ITEM_SLOT_BACKPACK
	)
/datum/deathmatch_loadout/battler/clown/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/storage/backpack/clown, ITEM_SLOT_BACK)
	player.equip_to_slot(new /obj/item/clothing/under/rank/civilian/clown, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/shoes/clown_shoes, ITEM_SLOT_FEET)
	player.equip_to_slot(new /obj/item/clothing/gloves/tackler/rocket, ITEM_SLOT_GLOVES)
	. = ..()

/datum/deathmatch_loadout/battler/tgcoder
	name = "TG coder"
	desc = "What"
	default_species = /datum/species/human
	equipment = list(
		/obj/item/toy/katana = ITEM_SLOT_HANDS,
		list(/obj/item/reagent_containers/cup/soda_cans/pwr_game = 10) = ITEM_SLOT_BACKPACK
	)
/datum/deathmatch_loadout/battler/tgcoder/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/under/costume/schoolgirl, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/suit/costume/nerdshirt, ITEM_SLOT_OCLOTHING)
	player.equip_to_slot(new /obj/item/clothing/shoes/clown_shoes/meown_shoes, ITEM_SLOT_FEET)
	player.equip_to_slot(new /obj/item/organ/internal/ears/cat, ITEM_SLOT_HEAD)
	. = ..()

/datum/deathmatch_loadout/battler/enginer
	name = "Enginer"
	desc = "Meet the enginer"
	default_species = /datum/species/human
	equipment = list(
		/obj/item/storage/toolbox/emergency/turret = ITEM_SLOT_HANDS
	)
/datum/deathmatch_loadout/battler/enginer/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/under/rank/engineering/engineer, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/gloves/color/yellow, ITEM_SLOT_GLOVES)
	player.equip_to_slot(new /obj/item/clothing/shoes/magboots, ITEM_SLOT_FEET)
	player.equip_to_slot(new /obj/item/clothing/head/utility/hardhat, ITEM_SLOT_HEAD)
	player.equip_to_slot(new /obj/item/fireaxe, ITEM_SLOT_BACK)
	. = ..()

/datum/deathmatch_loadout/battler/scientist
	name = "Scientist"
	desc = "What a nerd"
	default_species = /datum/species/human
	equipment = list(
		list(/obj/item/reagent_containers/syringe/plasma) = ITEM_SLOT_HANDS,
		list(/obj/item/reagent_containers/cup/bottle/plasma) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/burning/grey) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/burning/adamantine) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/burning/gold) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/burning/blue) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/burning/sepia) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/chilling/green) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/chilling/grey) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/industrial/oil) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/charged/silver) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/charged/black) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/burning/rainbow) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/stabilized/sepia) = ITEM_SLOT_LPOCKET,
		list(/obj/item/slimecross/chilling/adamantine) = ITEM_SLOT_BACKPACK,
		list(/obj/item/slimecross/stabilized/purple) = ITEM_SLOT_RPOCKET
	)
/datum/deathmatch_loadout/battler/scientist/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/suit/armor/reactive/stealth, ITEM_SLOT_OCLOTHING)
	player.equip_to_slot(new /obj/item/clothing/under/rank/rnd/scientist, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/mask/gas, ITEM_SLOT_MASK)
	. = ..()

/datum/deathmatch_loadout/battler/bloodminer
	name = "Blood miner"
	desc = "bloodshed"
	default_species = /datum/species/human
	add_mutations = list(
		/datum/mutation/human/dash
	)
	equipment = list(
		list(/obj/item/melee/cleaving_saw) = ITEM_SLOT_HANDS,
		list(/obj/item/gun/energy/recharge/kinetic_accelerator) = ITEM_SLOT_HANDS
	)
/datum/deathmatch_loadout/battler/bloodminer/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/suit/hooded/explorer, ITEM_SLOT_OCLOTHING)
	player.equip_to_slot(new /obj/item/clothing/shoes/workboots/mining, ITEM_SLOT_FEET)
	player.equip_to_slot(new /obj/item/clothing/under/rank/cargo/miner/lavaland, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/mask/gas/explorer, ITEM_SLOT_MASK)
	. = ..()

/datum/deathmatch_loadout/battler/ripper
	name = "Ripper"
	desc = "Die die die!!!"
	default_species = /datum/species/human
	equipment = list(
		list(/obj/item/gun/ballistic/shotgun/doublebarrel/ripper) = ITEM_SLOT_HANDS,
		list(/obj/item/gun/ballistic/shotgun/doublebarrel/ripper) = ITEM_SLOT_HANDS
	)
/datum/deathmatch_loadout/battler/ripper/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/suit/hooded/cultrobes/eldritch, ITEM_SLOT_OCLOTHING)
	player.equip_to_slot(new /obj/item/clothing/under/costume/skeleton, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/mask/gas/cyborg, ITEM_SLOT_MASK)
	player.equip_to_slot(new /obj/item/soulscythe, ITEM_SLOT_BACK)
	player.equip_to_slot(new /obj/item/clothing/shoes/sandal, ITEM_SLOT_FEET)
	. = ..()

/datum/deathmatch_loadout/battler/cowboy
	name = "Cowboy"
	desc = "EEEE HA"
	default_species = /datum/species/human
	equipment = list(
		list(/obj/item/clothing/mask/cigarette/cigar) = ITEM_SLOT_HANDS,
		list(/obj/item/melee/curator_whip) = ITEM_SLOT_HANDS,
		list(/obj/item/lighter) = ITEM_SLOT_LPOCKET
	)
/datum/deathmatch_loadout/battler/cowboy/pre_equip(mob/living/carbon/human/player)
	player.equip_to_slot(new /obj/item/clothing/accessory/vest_sheriff, ITEM_SLOT_OCLOTHING)
	player.equip_to_slot(new /obj/item/clothing/under/rank/security/detective, ITEM_SLOT_ICLOTHING)
	player.equip_to_slot(new /obj/item/clothing/head/cowboy/brown, ITEM_SLOT_HEAD)
	player.equip_to_slot(new /obj/item/storage/belt/holster/detective/full, ITEM_SLOT_BELT)
	player.equip_to_slot(new /obj/item/clothing/shoes/cowboy, ITEM_SLOT_FEET)
	. = ..()

/////////////////////////////////////////////////////////////////////////////////////
