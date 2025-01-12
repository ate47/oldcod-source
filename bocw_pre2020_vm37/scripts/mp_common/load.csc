#using script_20055f2f97341caa;
#using script_26e61ae2e1d842a9;
#using script_309ce7f5a9a023de;
#using script_446b64250de153ef;
#using script_644007a8c3885fc;
#using script_6971dbf38c33bf47;
#using script_727042a075af51b7;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gametype_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_supply_drop;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_cleanup;
#using scripts\core_common\map;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicles\driving_fx;
#using scripts\mp_common\callbacks;
#using scripts\wz_common\wz_perk_paranoia;

#namespace load;

// Namespace load/load
// Params 3, eflags: 0x1 linked
// Checksum 0xe9873bb7, Offset: 0x158
// Size: 0x4e
function levelnotifyhandler(clientnum, state, *oldstate) {
    if (oldstate != "") {
        level notify(oldstate, {#localclientnum:state});
    }
}

// Namespace load/load
// Params 0, eflags: 0x2
// Checksum 0x45b4812b, Offset: 0x1b0
// Size: 0x3c
function autoexec function_aeb1baea() {
    assert(!isdefined(level.var_f18a6bd6));
    level.var_f18a6bd6 = &function_5e443ed1;
}

// Namespace load/load
// Params 0, eflags: 0x1 linked
// Checksum 0x648f1a16, Offset: 0x1f8
// Size: 0xfc
function function_5e443ed1() {
    assert(isdefined(level.first_frame), "<dev string:x38>");
    level thread util::init_utility();
    util::registersystem("levelNotify", &levelnotifyhandler);
    register_clientfields();
    level.createfx_disable_fx = getdvarint(#"disable_fx", 0) == 1;
    map::init();
    gametype::init();
    system::function_c11b0642();
    level flag::set(#"load_main_complete");
}

// Namespace load/load
// Params 0, eflags: 0x1 linked
// Checksum 0xe79d788c, Offset: 0x300
// Size: 0xdc
function register_clientfields() {
    clientfield::register("missile", "cf_m_proximity", 1, 1, "int", &callback::callback_proximity, 0, 0);
    clientfield::register("missile", "cf_m_emp", 1, 1, "int", &callback::callback_emp, 0, 0);
    clientfield::register("missile", "cf_m_stun", 1, 1, "int", &callback::callback_stunned, 0, 0);
}

