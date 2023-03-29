///monsterhunter signals
#define COMSIG_RABBIT_FOUND "rabbit_found"
#define COMSIG_GAIN_INSIGHT "gain_insight"
#define COMSIG_BEASTIFY "beastify"

///Checks if given mob is a hive host
#define IS_HIVEHOST(mob) (mob.mind?.has_antag_datum(/datum/antagonist/hivemind))
///Checks if given mob is an awakened vessel
#define IS_WOKEVESSEL(mob) (mob.mind?.has_antag_datum(/datum/antagonist/hivevessel))
