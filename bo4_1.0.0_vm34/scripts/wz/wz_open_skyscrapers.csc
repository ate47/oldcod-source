#using script_4da75c87643c8b07;
#using script_58d14a82f7aa9d6d;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\load;
#using scripts\wz\wz_open_skyscrapers_fx;
#using scripts\wz\wz_open_skyscrapers_sound;
#using scripts\wz_common\wz_array_broadcast;
#using scripts\wz_common\wz_buoy_stash;
#using scripts\wz_common\wz_firing_range;
#using scripts\wz_common\wz_jukebox;
#using scripts\wz_common\wz_nuketown_sign;

#namespace wz_open_skyscrapers;

// Namespace wz_open_skyscrapers/level_init
// Params 1, eflags: 0x40
// Checksum 0x1872e3a6, Offset: 0xe8
// Size: 0xdc
function event_handler[level_init] main(eventstruct) {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    wz_open_skyscrapers_fx::main();
    wz_open_skyscrapers_sound::main();
    load::main();
    setdvar(#"cg_aggressivecullradius", 100);
    setdvar(#"hash_53f625ed150e7700", 12000);
    util::waitforclient(0);
    wz_firing_range::init_targets("firing_range_target");
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 1, eflags: 0x0
// Checksum 0xa73889b3, Offset: 0x1d0
// Size: 0x124
function on_localplayer_spawned(local_client_num) {
    if (isprofilebuild()) {
        if (self.name === "SemajRedins") {
            setdvar(#"cg_aggressivecullradius", 70);
            setdvar(#"hash_53f625ed150e7700", 15000);
            wait 20;
            setdvar(#"cl_jqprof_threshold", 100);
            setdvar(#"cl_jqprof_frequency", 60);
            setdvar(#"cl_jqprof_enabled", 1);
            setdvar(#"cl_jqprof_continuous", 1);
        }
    }
}

