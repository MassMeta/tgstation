/obj/item/melee/implantarmblade
	name = "implanted arm blade"
	desc = "A long, sharp, mantis-like blade implanted into someones arm. Cleaves through flesh like its particularly strong butter."
	icon = 'massmeta/icons/obj/mantis_blade.dmi'
	lefthand_file = 'massmeta/icons/mob/inhands/mantis_blade_lefthand.dmi'
	righthand_file = 'massmeta/icons/mob/inhands/mantis_blade_righthand.dmi'
	icon_state = "mantis_blade"
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	force = 25
	sharpness = SHARP_EDGED
	armour_penetration = 20
	item_flags = NEEDS_PERMIT
	hitsound = 'massmeta/sounds/misc/mantis_slice.ogg'

/obj/item/melee/implantarmblade/energy
	name = "energy arm blade"
	desc = "A long mantis-like blade made entirely of blazing-hot energy. Stylish and EXTRA deadly!"
	icon_state = "energy_mantis_blade"
	force = 30
	armour_penetration = 10 //Energy isn't as good at going through armor as it is through flesh alone.
	hitsound = 'sound/weapons/blade1.ogg'

/obj/item/organ/internal/cyberimp/arm/armblade
	name = "arm blade implant"
	desc = "An integrated blade implant designed to be installed into a persons arm. Stylish and deadly."
	items_to_create = list(/obj/item/melee/implantarmblade)
	icon = 'massmeta/icons/obj/mantis_blade.dmi'
	icon_state = "mantis_blade"

/obj/item/organ/internal/cyberimp/arm/armblade/emag_act()
	for(var/datum/weakref/created_item in items_list)
	to_chat(usr, span_notice("You unlock [src]'s integrated energy arm blade!"))
	items_list += WEAKREF(new /obj/item/melee/implantarmblade/energy(src))
	return TRUE
