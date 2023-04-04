/datum/uplink_category/species
	name = "Species Restricted"
	weight = 1

/datum/uplink_item/species_restricted
	category = /datum/uplink_category/species
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/species_restricted/moth_lantern
	name = "Extra-Bright Lantern"
	desc = "We heard that moths such as yourself really like lamps, so we decided to grant you early access to a prototype \
	Syndicate brand \"Extra-Bright Lantern™\". Enjoy."
	cost = 2
	item = /obj/item/flashlight/lantern/syndicate
	restricted_species = list(SPECIES_MOTH)
	surplus = 0

/datum/uplink_item/species_restricted/beefplushie
	name = "Living Beef Plushie"
	desc = "A living beefman plushie specimen. It looks very similar to a normal beefman plushie, use this to your advantage. \
	Pet it to make the specimen produce the meat, providing it has gotten time to get ready again."
	cost = 2 
	item = /obj/item/toy/plush/beefplushie/living
	restricted_species = list(SPECIES_BEEFMAN)
