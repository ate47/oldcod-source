#using script_78825cbb1ab9f493;
#using scripts\core_common\clientfield_shared;

#namespace fireteam_elimination;

// Namespace fireteam_elimination/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x5583e601, Offset: 0xb0
// Size: 0x164
function event_handler[gametype_init] main(*eventstruct) {
    namespace_17baa64d::init();
    teamcount = getgametypesetting(#"teamcount");
    for (i = 3; i <= teamcount; i++) {
        clientfield::function_5b7d846d("hudItems.team" + i + ".livesCount", #"hash_410fe12a68d6e801", [#"team" + i, #"livescount"], 1, 8, "int", undefined, 0, 0);
        clientfield::function_5b7d846d("hudItems.team" + i + ".noRespawnsLeft", #"hash_410fe12a68d6e801", [#"team" + i, #"norespawnsleft"], 1, 1, "int", undefined, 0, 0);
    }
}

