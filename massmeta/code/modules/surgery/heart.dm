/obj/item/organ/internal/heart/nanite
	name = "Nanite heart"
	desc = "A specialized heart constructed from nanites that helps coordinate nanites allowing them to regenerate quicker inside the body without any ill effects. Caution this organ will fall apart without nanites to sustain itself!"
	icon_state = "heart-nanites"
    icon = 'massmeta/icons/obj/organs.dmi'
	organ_flags = ORGAN_SYNTHETIC
	var/nanite_boost = 1
    var/active = FALSE

/obj/item/organ/heart/nanite/emp_act()
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return .
	Stop()

/obj/item/organ/internal/heart/nanite/on_life()
	. = ..()
	if(owner)//makes nanites tick on every life tick, only about 33% speed increase
		var/datum/component/nan = owner.GetExactComponent(/datum/component/nanites)
		if(nan)
			nan.process()

	if(SEND_SIGNAL(owner, COMSIG_HAS_NANITES))
		SEND_SIGNAL(owner, COMSIG_NANITE_ADJUST_VOLUME, nanite_boost)
        active = TRUE
	else if(active)
		if(owner)
			to_chat(owner, span_userdanger("You feel your heart collapse in on itself!"))
			Remove(owner) //the heart is made of nanites so without them it just breaks down
		qdel(src)
