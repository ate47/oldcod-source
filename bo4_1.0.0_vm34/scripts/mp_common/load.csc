#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\map;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicles\driving_fx;
#using scripts\mp_common\callbacks;
#using scripts\mp_common\gametypes\gametype;

#namespace load;

// Namespace load/load
// Params 3, eflags: 0x0
// Checksum 0xb40870bf, Offset: 0xe8
// Size: 0x4e
function levelnotifyhandler(clientnum, state, oldstate) {
    if (state != "") {
        level notify(state, {#localclientnum:clientnum});
    }
}

// Namespace load/load
// Params 0, eflags: 0x0
// Checksum 0xd3e17d97, Offset: 0x140
// Size: 0x11c
function main() {
    assert(isdefined(level.first_frame), "<dev string:x30>");
    level thread util::servertime();
    level thread util::init_utility();
    util::registersystem("levelNotify", &levelnotifyhandler);
    register_clientfields();
    level.createfx_disable_fx = getdvarint(#"disable_fx", 0) == 1;
    map::init();
    gametype::init();
    system::wait_till("all");
    level flagsys::set(#"load_main_complete");
}

// Namespace load/load
// Params 0, eflags: 0x0
// Checksum 0x93d0a66f, Offset: 0x268
// Size: 0xdc
function register_clientfields() {
    clientfield::register("missile", "cf_m_proximity", 1, 1, "int", &callback::callback_proximity, 0, 0);
    clientfield::register("missile", "cf_m_emp", 1, 1, "int", &callback::callback_emp, 0, 0);
    clientfield::register("missile", "cf_m_stun", 1, 1, "int", &callback::callback_stunned, 0, 0);
}

