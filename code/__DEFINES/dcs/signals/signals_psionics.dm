///Is the mob a psionic, and does it have enough psionic energy if it is
#define COMSIG_PSIONIC_HAS_ENERGY "psionic_has_energy"
    ///Not enough psionic energy
	#define COMPONENT_NO_PSIONIC_ENERGY(1<<0)
    ///Enough psionic energy
    #define COMPONENT_HAS_PSIONIC_ENERGY(1<<1)

///Giving a psionic level to a mob
#define COMSIG_PSIONIC_ADVANCE_LEVEL "psionic_advance_level"
    ///No level up(
	#define COMPONENT_PSIONIC_NO_ADVANCE(1<<0)

///Assigning a psionic path to a mob
#define COMSIG_PSIONIC_ASSIGN_PATH "psionic_assign_path"

///Trying to spend psionic energy
#define COMSIG_PSIONIC_SPEND_ENERGY "psionic_spend_energy"
