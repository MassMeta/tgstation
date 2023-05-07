//no better place to put this, I think
/obj/item/food/solid_reagent
	name = "solidified chemicals"
	desc = "Are you sure eating this is a good idea?"
	icon = 'massmeta/icons/obj/chemical.dmi'
	icon_state = "chembar"
	obj_flags = UNIQUE_RENAME
	var/reagent_type
	foodtypes = TOXIC
	volume = 200
	reagent_flags = TRANSPARENT

/obj/item/food/solid_reagent/Initialize()
	. = ..()
	pixel_x = rand(8,-8)
	pixel_y = rand(8,-8)

/obj/item/food/solid_reagent/microwave_act(obj/machinery/microwave/M)
	if(reagents)
		reagents.expose_temperature(1000)


/obj/item/food/solid_reagent/ex_act()
		..()

/obj/item/food/solid_reagent/fire_act(exposed_temperature, exposed_volume)
	reagents.expose_temperature(exposed_temperature)

/obj/item/food/solid_reagent/attackby(obj/item/I, mob/user, params)
	var/hotness = I.get_temperature()
	if(hotness && reagents)
		reagents.expose_temperature(hotness)
		to_chat(user, "<span class='notice'>You heat [src] with [I].</span>"))


/obj/item/food/solid_reagent/afterattack(obj/target, mob/user , proximity)
	if(!proximity)
		return
	if(target.is_open_container())
		if(!target.reagents.total_volume)
			to_chat(user, "<span class='warning'>[target] is empty! There's nothing to dissolve [src] in.</span>")
			return
		to_chat(user, "<span class='notice'>You dissolve [src] in [target].</span>")
		for(var/mob/O in viewers(2, user))	//viewers is necessary here because of the small radius
			to_chat(O, "<span class='warning'>[user] dissolves [src] into [target]!</span>")
		reagents.trans_to(target, reagents.total_volume)
		qdel(src)
