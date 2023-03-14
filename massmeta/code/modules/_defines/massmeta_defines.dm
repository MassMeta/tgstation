///monsterhunter signals
#define COMSIG_RABBIT_FOUND "rabbit_found"
#define COMSIG_GAIN_INSIGHT "gain_insight"
#define COMSIG_BEASTIFY "beastify"

#define isdarkspawn(A) (A.mind && A.mind.has_antag_datum(/datum/antagonist/darkspawn))
#define isveil(A) (A.mind && A.mind.has_antag_datum(/datum/antagonist/veil))
#define is_darkspawn_or_veil(A) (A.mind && isdarkspawn(A) || isveil(A))

#define DARKSPAWN_DIM_LIGHT 0.2 //light of this intensity suppresses healing and causes very slow burn damage
#define DARKSPAWN_BRIGHT_LIGHT 0.3 //light of this intensity causes rapid burn damage

#define DARKSPAWN_DARK_HEAL 5 //how much damage of each type (with fire damage half rate) is healed in the dark
#define DARKSPAWN_LIGHT_BURN 7 //how much damage the darkspawn receives per tick in lit areas
