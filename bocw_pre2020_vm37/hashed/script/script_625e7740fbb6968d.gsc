#using script_774302f762d76254;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\values_shared;
#using scripts\mp_common\gametypes\globallogic;

#namespace doa;

// Namespace doa/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x803f9a39, Offset: 0xa8
// Size: 0x54
function event_handler[gametype_init] main(*eventstruct) {
    globallogic::init();
    callback::on_spawned(&on_player_spawned);
    level thread namespace_4dae815d::init();
}

// Namespace doa/doa
// Params 0, eflags: 0x0
// Checksum 0x62643999, Offset: 0x108
// Size: 0x54
function on_player_spawned() {
    self val::reset(#"hash_5bb0dd6b277fc20c", "freezecontrols");
    self val::reset(#"hash_5bb0dd6b277fc20c", "disablegadgets");
}

