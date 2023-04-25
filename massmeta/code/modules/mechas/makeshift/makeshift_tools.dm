/obj/item/mecha_parts/mecha_equipment/drill/makeshift
	name = "Makeshift exosuit drill"
	desc = "Cobbled together from likely stolen parts, this drill is nowhere near as effective as the real deal."
//Its slow as shit
	equip_cooldown = 60
//Its not very strong
	force = 10
	drill_delay = 15

/obj/item/mecha_parts/mecha_equipment/drill/makeshift/can_attach(obj/vehicle/sealed/mecha/M as obj)
	if(istype(M, /obj/vehicle/sealed/mecha/working/makeshift))
		return TRUE
	return FALSE

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/makeshift
	name = "makeshift clamp"
	desc = "Loose arrangement of cobbled together bits resembling a clamp."
	equip_cooldown = 25
	clamp_damage = 10

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/makeshift/can_attach(obj/vehicle/sealed/mecha/M as obj)
	if(istype(M, /obj/vehicle/sealed/mecha/working/makeshift))
		return TRUE
	return FALSE
