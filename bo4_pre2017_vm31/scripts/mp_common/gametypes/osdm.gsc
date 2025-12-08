#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/dm;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/gametypes/os;
#using scripts/mp_common/util;

#namespace osdm;

// Namespace osdm/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0xbf09b9a3, Offset: 0x228
// Size: 0x64
function event_handler[GameType_Init] main( eventstruct )
{
    dm::main();
    os::turn_back_time( "dm" );
    globallogic_audio::set_leader_gametype_dialog( "osStartFfa", "", "gameBoost", "gameBoost" );
}

