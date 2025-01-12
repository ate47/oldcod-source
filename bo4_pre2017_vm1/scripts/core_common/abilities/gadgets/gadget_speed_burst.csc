#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_speed_burst;

// Namespace gadget_speed_burst/gadget_speed_burst
// Params 0, eflags: 0x2
// Checksum 0xe0029c9, Offset: 0x280
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_speed_burst", &__init__, undefined, undefined);
}

// Namespace gadget_speed_burst/gadget_speed_burst
// Params 0, eflags: 0x0
// Checksum 0x4bf2f38e, Offset: 0x2c0
// Size: 0x94
function __init__() {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    clientfield::register("toplayer", "speed_burst", 1, 1, "int", &function_d6b43cb, 0, 1);
    visionset_mgr::register_visionset_info("speed_burst", 1, 9, undefined, "speed_burst_initialize");
}

// Namespace gadget_speed_burst/gadget_speed_burst
// Params 1, eflags: 0x0
// Checksum 0xdaf2b715, Offset: 0x360
// Size: 0x54
function on_localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    filter::init_filter_speed_burst(self);
    filter::disable_filter_speed_burst(self, 3);
}

// Namespace gadget_speed_burst/gadget_speed_burst
// Params 7, eflags: 0x0
// Checksum 0xab7ad98c, Offset: 0x3c0
// Size: 0xbc
function function_d6b43cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self == getlocalplayer(localclientnum)) {
            filter::enable_filter_speed_burst(self, 3);
        }
        return;
    }
    if (self == getlocalplayer(localclientnum)) {
        filter::disable_filter_speed_burst(self, 3);
    }
}

