/obj/machinery/reagent_forge
	name = "\proper the material forge"
	desc = "A bulky machine that can smelt practically any material in existence."
	icon = 'massmeta/icons/obj/3x3.dmi'
	icon_state = "arc_forge"
	bound_width = 96
	bound_height = 96
	anchored = TRUE
	max_integrity = 1000
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 3000
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	circuit = null
	light_range = 5
	light_power = 1.5
	light_color = LIGHT_COLOR_FIRE
	var/datum/reagent/currently_forging //forge one mat at a time
	var/processing = FALSE
	var/list/currently_using = list()
	var/trueamount = 0

/obj/machinery/reagent_forge/examine(mob/user)
	//go fuck yourself if you think I'm using a SIGNAL FOR FUCKING EXAMINING
	. = ..()
	if(trueamount != 0)
		. += "\n The forge contains [span_blue("[trueamount]")] units of [span_blue("[currently_forging]")]"
	else
		. += "\n The forge is empty."

/obj/machinery/reagent_forge/attackby(obj/item/stack/sheet/mineral/reagent/I, mob/living/carbon/human/user)
	if(istype(I, /obj/item/stack/sheet/mineral/reagent))
		var/obj/item/stack/sheet/mineral/reagent/R = I
		if(R.reagent_type)
			var/datum/reagent/RE = R.reagent_type
			if(!initial(RE.can_forge))
				to_chat(user, span_warning("[initial(RE.name)] cannot be forged!"))
				return
			if(!currently_forging || !currently_forging.type)
				//OBSERVE NOW AS I DO SOMETHING **STUPID**
				trueamount += R.amount*MINERAL_MATERIAL_AMOUNT
				to_chat(user, span_notice("You add [R] to [src]"))
				qdel(R)
				currently_forging = new R.reagent_type.type
				return

			if(currently_forging && currently_forging.type && R.reagent_type.type == currently_forging.type)//preventing unnecessary references from being made
				trueamount += R.amount*MINERAL_MATERIAL_AMOUNT
				qdel(R)
				to_chat(user, span_notice("You add [R] to [src]."))
				return
			else
				to_chat(user, span_notice("[currently_forging] is currently being forged, either remove or use it before adding a different material."))//if null is currently being forged comes up i'm gonna scree
				return

/obj/machinery/reagent_forge/interact(mob/user, special_state)
	. = ..()
	if(processing)
		to_chat(user, span_danger("The machine is busy."))
		return
	var/action = tgui_alert(user, "What do you want to do?","Operate Reagent Forge", list("Create", "Dump"))
	switch(action)
		if("Create")
			var/datum/design/forge/poopie
			var/list/designs_list = subtypesof(/datum/design/forge)
			var/datum/design/forge/choice = input(user, "What do you want to forge?", "Forged Weapon Type") as null|anything in designs_list
			if(choice)
				poopie = new choice
			if(!poopie)
				return FALSE
			var/amount = 0
			amount = input("How many?", "How many would you like to forge?", 1) as null|num
			if(amount <= 0)
				return FALSE
			if(!loc)
				return FALSE
			var/amount_needed = poopie.materials[/datum/material/custom] * amount
			if(trueamount >= amount_needed)
				visible_message(span_notice("The forge starts processing your request."))
				processing = TRUE
				for(var/i in 1 to amount)
					addtimer(CALLBACK(src, .proc/create_item, poopie, i == amount), i * 4 SECONDS)
				trueamount -= amount_needed
				. = TRUE
				return .
			else
				visible_message(span_warning("The low material indicator flashes on [src]!"))
				playsound(src, 'sound/machines/buzz-two.ogg', 60, 0)

		if("Dump")
			if(currently_forging)
				trueamount = 0
				currently_forging = null
			else
				visible_message(span_warning("Dump what, exactly? The forge is empty!"))

/obj/machinery/reagent_forge/proc/create_item(datum/design/forge/forged_design, lastitem)
	if(forged_design.build_path)
		var/atom/A = new forged_design.build_path(src.loc)
		if(currently_forging)
			if(istype(forged_design, /datum/design/forge))
				var/obj/item/forged/F = A
				var/paths = subtypesof(/datum/reagent)
				for(var/path in paths)
					var/datum/reagent/RR = new path
					if(RR.type == currently_forging.type)
						F.reagent_type = RR
						F.assign_properties()
						break
					else
						qdel(RR)
	if(lastitem)
		processing = FALSE
		playsound(src, 'sound/machines/ding.ogg', 50, TRUE)
		update_icon()

//Material manipulator

/obj/machinery/reagent_material_manipulator
	name = "\proper the material manipulation machine"
	desc = "A high tech machine that can both analyse material traits and combine material traits with each other."
	icon_state = "circuit_imprinter"
	icon = 'icons/obj/machines/research.dmi'
	density = TRUE
	anchored = TRUE
	use_power = IDLE_POWER_USE
	var/obj/item/loaded
	var/analyse_only = FALSE
	var/datum/reagent/synthesis
	var/datum/reagent/reagent_analyse
	var/list/special_traits
	var/is_bullet = FALSE//because bullets are the snowflakes


/obj/machinery/reagent_material_manipulator/Initialize()
	. = ..()
	create_reagents(100)

/obj/machinery/reagent_material_manipulator/attackby(obj/item/I, mob/living/carbon/human/user)
	if(user.combat_mode)
		return ..()

	if(panel_open)
		to_chat(user, span_warning("You can't load the [I] while it's opened!"))
		return

	var/obj/item/forged/R //since all forged weapons have the same vars/procs this lets it compile as the actual type is assigned at runtime during this proc
	special_traits = list()

	if(istype(I, /obj/item/reagent_containers/glass/beaker))
		var/obj/item/reagent_containers/glass/beaker/W = I
		if(LAZYLEN(W.reagents.reagent_list) == 1)
			for(var/X in W.reagents.reagent_list)
				var/datum/reagent/S = X

				if(!S.can_forge)
					to_chat(user, span_warning("[S] cannot be added!"))
					return

				if(synthesis && S.type != synthesis.type)
					to_chat(user, span_warning("[src] already has a reagent of a different type, remove it before adding something else!"))
					return

				if(W.reagents.total_volume && reagents.total_volume < reagents.maximum_volume)
					to_chat(user, span_notice("You add [S] to the machine."))
					W.reagents.trans_to(src, W.reagents.total_volume)
					for(var/RS in reagents.reagent_list)
						synthesis = RS
					return
		else
			to_chat(user, span_warning("[src] only accepts one type of reagent at a time!"))
			return


	else if(istype(I, /obj/item/stack/sheet/mineral/reagent))
		R = I
		analyse_only = TRUE

	else if(istype(I, /obj/item/forged))
		R = I

	else if(istype(I, /obj/item/twohanded/forged))
		R = I

	else if(istype(I, /obj/item/ammo_casing/forged))
		R = I
		var/obj/item/ammo_casing/forged/F = I
		if(!F.loaded_projectile)//this has no bullet
			return

		if(!F.caliber)
			to_chat(user, span_warning("[I] needs to be shaped to a caliber before it can be added!"))
			return

		var/obj/projectile/bullet/forged/FB = F.loaded_projectile
		special_traits = FB.special_traits
		is_bullet = TRUE

	if(loaded)
		to_chat(user, span_warning("[src] is full!"))
		return

	if(R && R.reagent_type)//we move it out of their hands and store it as a 'ghost' object
		user.dropItemToGround(R)
		R.forceMove(get_turf(src))
		R.invisibility = INVISIBILITY_ABSTRACT
		R.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		R.anchored = TRUE
		loaded = R
		reagent_analyse = R.reagent_type
		if(analyse_only)//used by ingots and other non weapons without their own seperate list of instantiated traits
			for(var/D in reagent_analyse.special_traits)
				var/datum/special_trait/S = new D
				LAZYADD(special_traits, S)
		else if(!is_bullet)
			special_traits = R.special_traits

	else
		..()

/obj/machinery/reagent_material_manipulator/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		if(synthesis)
			. += "There's [synthesis.volume] units of [synthesis.name] in it."
		if(synthesis && synthesis.special_traits)
			for(var/D in synthesis.special_traits)
				var/datum/special_trait/S = new D
				. += "The [synthesis.name] has the [S.name] trait. [S.desc]"
		if(loaded)
			. += "There's a [loaded.name] inside of the machine."


/obj/machinery/reagent_material_manipulator/interact(mob/user)
	. = ..()
	var/warning = tgui_alert(user, "How would you like to operate the machine?","Operate Reagent Manipulator", list("Eject Weapon", "Flash freeze reagents", "Add Trait"))
	switch(warning)
		if("Eject Weapon")
			if(loaded)
				loaded.forceMove(get_turf(usr))
				loaded.invisibility = initial(loaded.invisibility)
				loaded.mouse_opacity = initial(loaded.mouse_opacity)
				loaded.anchored = initial(loaded.anchored)
				to_chat(usr, span_notice("You eject [loaded]."))
				loaded = null
				reagent_analyse = null
				special_traits = null
				analyse_only = FALSE
				is_bullet = FALSE
				return TRUE
		if("Flash freeze reagents")
			if(synthesis)
				synthesis.reagent_state = SOLID
				var/obj/item/food/solid_reagent/Sr = new /obj/item/food/solid_reagent(src.loc)
				Sr.reagents.add_reagent(synthesis.type, synthesis.volume)
				Sr.reagent_type = synthesis.type
				Sr.name = "solidified [synthesis.name]"
				Sr.add_atom_colour(color, FIXED_COLOUR_PRIORITY)
				Sr.color = synthesis.color
				to_chat(usr, span_notice("[synthesis] is flash frozen and dispensed out of the machine in the form of a solid bar!"))
				synthesis = null
				reagents.clear_reagents()
				return TRUE

		if("Add Trait")
			if(loaded && synthesis && reagent_analyse)
				if(reagents.total_volume < 50)
					to_chat(usr, span_warning("You need at least [SPECIAL_TRAIT_ADD_COST] units of [synthesis] to add a trait!"))
					return

				if(analyse_only)
					to_chat(usr, span_warning("The machine is locked in analyse only mode, perhaps you are trying to modify the traits of a reagent directly?"))
					return

				if(LAZYLEN(special_traits) >= SPECIAL_TRAIT_MAXIMUM)
					to_chat(usr, span_warning("[loaded] has too many special traits already!"))
					return

				var/obj/item/forged/R
				if(istype(loaded, /obj/item/forged))
					R = loaded

				else if(istype(loaded, /obj/item/twohanded/forged))
					R = loaded

				else if(istype(loaded, /obj/item/ammo_casing/forged))
					var/obj/item/ammo_casing/forged/F = loaded
					if(!F.loaded_projectile)//this has no bullet
						return
					R = F.loaded_projectile

				if(!R)
					return
				for(var/I in synthesis.special_traits)
					var/datum/special_trait/D = new I
					if(locate(D) in R.special_traits)
						to_chat(usr, span_warning("[R] already has the [D] trait!"))
					else
						R.special_traits += D//doesn't work with lazyadd due to type mismatch (it checks for an explicitly initialized list)
						R.speed += SPECIAL_TRAIT_ADD_SPEED_DEBUFF
						D.on_apply(R, R.identifier)
						reagents.remove_any(SPECIAL_TRAIT_ADD_COST)
						to_chat(usr, span_notice("You add the trait [D] to [R]."))

//Reagent refinery
/obj/machinery/reagent_sheet
	name = "\improper reagent refinery"
	desc = "Smelts and refines solid reagents into ingots usable by the forge."
	icon_state = "furnace"
	icon = 'icons/obj/machines/mining_machines.dmi'
	density = TRUE
	anchored = TRUE
	use_power = IDLE_POWER_USE
	light_power = 0.5
	light_range = 2
	light_color = LIGHT_COLOR_FLARE
	var/obj/item/food/solid_reagent/working = null
	var/work_time = 300
	var/end_volume = 100
	circuit = /obj/item/circuitboard/machine/reagent_sheet

/obj/machinery/reagent_sheet/RefreshParts()
	for(var/obj/item/stock_parts/micro_laser/ML in component_parts)
		work_time = (initial(work_time)/ML.rating)
	for(var/obj/item/stock_parts/matter_bin/MB in component_parts)
		end_volume = initial(end_volume) * MB.rating

/obj/machinery/reagent_sheet/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: Outputting <b>[end_volume/20]</b> ingot(s) after <b>[work_time*0.1]</b> seconds of processing.")

/obj/machinery/reagent_sheet/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/food/solid_reagent) && !panel_open)
		if(!is_operational && BROKEN)
			to_chat(user, span_warning("[src] is broken!"))
			return
		if(working)
			to_chat(user, span_warning("[src] is busy!"))
			return
		else
			var/area/a = loc.loc // Gets our locations location, like a dream within a dream
			if(!isarea(a))
				return
			if(a.power_equip == 0) // There's no APC in this area, don't try to cheat power!
				to_chat(user, span_warning("[src] seems to be powered off!"))
				return
			if(!user.transferItemToLoc(I,src) && !I.reagents)
				to_chat(user, span_alert("[src] rejects [I]."))
				return
			working = I
			var/chem_material = working.reagents.total_volume * end_volume
			use_power = working.reagents.total_volume
			updateUsrDialog()
			addtimer(CALLBACK(src, .proc/create_sheets, chem_material), work_time)
			to_chat(user, span_notice("You add [working] to [src]."))
			visible_message(span_notice("[src] activates!"))
		if(!in_range(src, working) || !user.Adjacent(src))
			return
	else
		if(!working && default_deconstruction_screwdriver(user, icon_state, icon_state, I))
			return
		if(default_deconstruction_crowbar(I))
			return
		return ..()

/obj/machinery/reagent_sheet/deconstruct()
	if(working)
		working.forceMove(drop_location())
	return ..()

/obj/machinery/reagent_sheet/Destroy()
	QDEL_NULL(working)
	return ..()

/obj/machinery/reagent_sheet/proc/create_sheets(amount)
	var/sheet_amount = max(round(amount / MINERAL_MATERIAL_AMOUNT), 1)
	var/obj/item/stack/sheet/mineral/reagent/RS = new(get_turf(src))
	visible_message(span_notice("[src] finishes processing."))
	playsound(src, 'sound/machines/ping.ogg', 50, 0)
	RS.amount = sheet_amount
	for(var/path in subtypesof(/datum/reagent))
		var/datum/reagent/RR = new path
		if(RR.type == working.reagent_type)
			RS.reagent_type = RR
			RS.name = "[RR.name] ingots"
			RS.singular_name = "[RR.name] ingot"
			RS.add_atom_colour(RR.color, FIXED_COLOUR_PRIORITY)
			break
		else
			del(RR) //lol
	QDEL_NULL(working)
	return

/obj/item/circuitboard/machine/reagent_sheet
	name = "Reagent Refinery (Machine Board)"
	build_path = /obj/machinery/reagent_sheet
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 3)
