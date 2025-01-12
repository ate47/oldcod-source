#using script_20055f2f97341caa;
#using script_26e61ae2e1d842a9;
#using script_309ce7f5a9a023de;
#using script_446b64250de153ef;
#using script_644007a8c3885fc;
#using script_6971dbf38c33bf47;
#using script_727042a075af51b7;
#using scripts\core_common\clientfaceanim_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_supply_drop;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_cleanup;
#using scripts\core_common\load_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\driving_fx;
#using scripts\weapons\zm\weaponobjects;
#using scripts\zm_common\ambient;
#using scripts\zm_common\global_fx;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_aoe;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_traps;

#namespace load;

// Namespace load/load
// Params 0, eflags: 0x6
// Checksum 0x74780aa4, Offset: 0x190
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_5a13dbfcdb2f9b51", &function_aeb1baea, undefined, undefined, undefined);
}

// Namespace load/load
// Params 3, eflags: 0x1 linked
// Checksum 0x6b16ea64, Offset: 0x1d8
// Size: 0x3a
function levelnotifyhandler(clientnum, state, *oldstate) {
    if (oldstate != "") {
        level notify(oldstate, state);
    }
}

// Namespace load/load
// Params 2, eflags: 0x0
// Checksum 0x4f9cf96, Offset: 0x220
// Size: 0x14
function warnmissilelocking(*localclientnum, *set) {
    
}

// Namespace load/load
// Params 2, eflags: 0x0
// Checksum 0xdbeb2dd3, Offset: 0x240
// Size: 0x14
function warnmissilelocked(*localclientnum, *set) {
    
}

// Namespace load/load
// Params 2, eflags: 0x0
// Checksum 0x96845952, Offset: 0x260
// Size: 0x14
function warnmissilefired(*localclientnum, *set) {
    
}

// Namespace load/load
// Params 0, eflags: 0x1 linked
// Checksum 0x8ecbb0a, Offset: 0x280
// Size: 0x3c
function function_aeb1baea() {
    assert(!isdefined(level.var_f18a6bd6));
    level.var_f18a6bd6 = &function_5e443ed1;
}

// Namespace load/load
// Params 0, eflags: 0x1 linked
// Checksum 0x97e98b4e, Offset: 0x2c8
// Size: 0x114
function function_5e443ed1() {
    assert(isdefined(level.first_frame), "<dev string:x38>");
    zm::init();
    level thread util::init_utility();
    util::register_system(#"levelnotify", &levelnotifyhandler);
    register_clientfields();
    level.createfx_disable_fx = getdvarint(#"disable_fx", 0) == 1;
    system::function_c11b0642();
    level thread art_review();
    level flag::set(#"load_main_complete");
}

// Namespace load/load
// Params 0, eflags: 0x1 linked
// Checksum 0xe924c00d, Offset: 0x3e8
// Size: 0x4c
function register_clientfields() {
    clientfield::register("allplayers", "zmbLastStand", 1, 1, "int", &zm::laststand, 0, 1);
}

