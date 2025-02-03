#using script_1cc417743d7c262d;
#using scripts\mp_common\gametypes\dm;
#using scripts\mp_common\gametypes\os;

#namespace osdm;

// Namespace osdm/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xa1ce767f, Offset: 0xa0
// Size: 0x64
function event_handler[gametype_init] main(*eventstruct) {
    dm::main();
    os::turn_back_time("dm");
    globallogic_audio::set_leader_gametype_dialog("osStartFfa", "", "gameBoost", "gameBoost");
}

