/atom/movable/screen/psionic
	name = "Psionic Energy"
	icon_state = "heat_bar"
	screen_loc = "EAST-1:28,CENTER-4:7"
	icon = 'massmeta/icons/obj/screen_psi.dmi'
	var/mutable_appearance/energy_counter

/atom/movable/screen/psionic/New(var/mob/living/owner)
	energy_counter = mutable_appearance(icon, "")
	..()

/atom/movable/screen/psionic/proc/update_count(amount)
	energy_counter.icon_state = "heat_[round(amount / 5, 5)]"
	add_overlay(energy_counter)
