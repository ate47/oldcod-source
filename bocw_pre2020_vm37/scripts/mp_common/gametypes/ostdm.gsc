#using script_1cc417743d7c262d;
#using scripts\mp_common\gametypes\os;
#using scripts\mp_common\gametypes\tdm;

#namespace ostdm;

// Namespace ostdm/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x52514d84, Offset: 0xa0
// Size: 0x64
function event_handler[gametype_init] main(*eventstruct) {
    tdm::main();
    os::turn_back_time("tdm");
    globallogic_audio::set_leader_gametype_dialog("osStartTdm", "", "gameBoost", "gameBoost");
}

