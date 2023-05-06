///Is the mob a psionic, and does it have enough psionic energy if it is
#define COMSIG_PSIONIC_HAS_ENERGY "psionic_has_energy"
	///Not enough psionic energy
	#define COMPONENT_NO_PSIONIC_ENERGY (1<<0)
	///Enough psionic energy
	#define COMPONENT_HAS_PSIONIC_ENERGY (1<<1)

///Giving a psionic level to a mob
#define COMSIG_PSIONIC_ADVANCE_LEVEL "psionic_advance_level"
	///No level up(
	#define COMPONENT_PSIONIC_NO_ADVANCE (1<<0)

///Assigning a psionic path to a mob
#define COMSIG_PSIONIC_ASSIGN_PATH "psionic_assign_path"

///Trying to spend psionic energy
#define COMSIG_PSIONIC_SPEND_ENERGY "psionic_spend_energy"

///Checking if the mob has a psionic path
#define COMSIG_PSIONIC_CHECK_PATH "psionic_has_path"

///Awakaning latent psionic powers inside a person
#define COMSIG_PSIONIC_AWAKEN "psionic_awaken"
	#define COMPONENT_PSIONIC_AWAKENING_SUCESSFULL (1<<0)
	#define COMPONENT_PSIONIC_AWAKENING_FAILED (1<<1)

///Making psionic powers unactive
#define COMSIG_PSIONIC_DEACTIVATE "psionic_deactivate"
