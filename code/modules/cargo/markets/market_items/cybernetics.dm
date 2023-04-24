/datum/market_item/cybernetics
	category = "Cybernetics"
	stock_max = 2

// LEGS

/datum/market_item/cybernetics/table_glider
	name = "Table-gliding cybernetic"
	desc = "Works like a charm, can get you up any table in a second, don't ask if you can also quickly get down, we are still figuring that part out."
	item = /obj/item/organ/internal/cyberimp/leg/table_glider
	availability_prob = 20
	stock = 2 // ok, ok these require 2 implants on each leg to work
	price_min = 200
	price_max = 400

/datum/market_item/cybernetics/shove_resist
	name = "BU-TAM resistor cybernetic"
	desc = "This bad boy roots you in ground whenever you get shoved, doesn't come with muscle actuators so your legs will get tired after a while."
	item = /obj/item/organ/internal/cyberimp/leg/shove_resist
	availability_prob = 15
	stock = 2 // ok, ok these require 2 implants on each leg to work
	price_min = 300
	price_max = 600

/datum/market_item/cybernetics/accelerator
	name = "P.R.Y.Z.H.O.K. accelerator cybernetic"
	desc = "Advanced russian implant that allows you to tackle people without special gloves or training, very rare to aquire these as TerraGov has cracked down on the sales."
	item = /obj/item/organ/internal/cyberimp/leg/accelerator
	availability_prob = 10
	stock = 2 // ok, ok these require 2 implants on each leg to work
	price_min = 400
	price_max = 800

/datum/market_item/cybernetics/chemplant_drug
	name = "deep-vein emergency morale rejuvenator"
	desc = "Interdyne Pharmaceutic's cybernetic that was recenetly 'legally' aquired by us, now we are willing to sell a one of these bad boys to anyone in need of some rejuvenation!"
	item = /obj/item/organ/internal/cyberimp/leg/chemplant/drugs
	availability_prob = 10
	price_min = 500
	price_max = 1000

/datum/market_item/cybernetics/chemplant_emergency
	name = "deep emergency chemical infuser"
	desc = "Nanotrasens attempt at recreating Interdyne's success with in-leg chemical cybernetics. This implant will inject you with healing chemicals given the situation is dire."
	item = /obj/item/organ/internal/cyberimp/leg/chemplant/emergency
	availability_prob = 20
	price_min = 400
	price_max = 800

/datum/market_item/cybernetics/chemplant_rage
	name = "R.A.G.E. chemical system"
	desc = "An implant created by Terragov scientists, later modified by their prison warden's to serve as both a torture tool and a last-stand implant by their military."
	item = /obj/item/organ/internal/cyberimp/leg/chemplant/rage
	availability_prob = 10
	price_min = 700
	price_max = 1000

/// ARMS

/datum/market_item/cybernetics/laser
	name = "in-built laser cybernetic"
	desc = "Laser implant of Terran design, used by their high-ranking officers."
	item = /obj/item/organ/internal/cyberimp/arm/gun/laser
	availability_prob = 5
	price_min = 1200
	price_max = 2200

/datum/market_item/cybernetics/toolset
	name = "integrated toolset implant"
	desc = "Doesn't NT produce those en masse? Oh well, if you are willing to buy, we are willing to sell."
	item = /obj/item/organ/internal/cyberimp/arm/toolset
	availability_prob = 25
	price_min = 300
	price_max = 800

/datum/market_item/cybernetics/surgery
	name = "surgery toolset cybernetic"
	desc = "Doesn't NT produce those en masse? Oh well, if you are willing to buy, we are willing to sell."
	item = /obj/item/organ/internal/cyberimp/arm/surgery
	availability_prob = 25
	price_min = 300
	price_max = 800

/datum/market_item/cybernetics/heater
	name = "sub-dermal heating implant"
	desc = "Helps you stabilize your temperature, extra useful for those filthy lizards, I wonder if they made this thing?"
	item = /obj/item/organ/internal/cyberimp/arm/heater
	availability_prob = 25
	price_min = 100
	price_max = 500

/datum/market_item/cybernetics/cooler
	name = "sub-dermal cooling implant"
	desc = "Helps you stabilize your temperature, extra useful for those filthy lizards, I wonder if they made this thing?"
	item = /obj/item/organ/internal/cyberimp/arm/cooler
	availability_prob = 25
	price_min = 100
	price_max = 500

/datum/market_item/cybernetics/filter
	name = "S.I.L.V.E.R. filtration pump"
	desc = "Another major success of Interdyne, this time this blood pump will filter out all harmful substances from your system."
	item = /obj/item/organ/internal/cyberimp/chest/filtration
	availability_prob = 10
	price_min = 800
	price_max = 1000

/datum/market_item/cybernetics/filter_offbrand
	name = "offbrand filtration pump"
	desc = "An offbrand version of Interdyne's filtration pump, god I hope this one works."
	item = /obj/item/organ/internal/cyberimp/chest/filtration/offbrand
	availability_prob = 20
	price_min = 200
	price_max = 400
