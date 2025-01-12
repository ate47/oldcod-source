#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace namespace_3a292d50;

// Namespace namespace_3a292d50/gadget_speed_burst
// Params 0, eflags: 0x2
// Checksum 0x28ca433c, Offset: 0x308
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_speed_burst", &__init__, undefined, undefined);
}

// Namespace namespace_3a292d50/gadget_speed_burst
// Params 0, eflags: 0x0
// Checksum 0x9b9c0e80, Offset: 0x348
// Size: 0x17c
function __init__() {
    clientfield::register("toplayer", "speed_burst", 1, 1, "int");
    ability_player::register_gadget_activation_callbacks(13, &function_4471717e, &function_51b450f4);
    ability_player::register_gadget_possession_callbacks(13, &function_41c1ea5a, &function_65a0fef4);
    ability_player::register_gadget_flicker_callbacks(13, &function_70950c7);
    ability_player::register_gadget_is_inuse_callbacks(13, &function_15880b4e);
    ability_player::register_gadget_is_flickering_callbacks(13, &function_8386c640);
    if (!isdefined(level.var_6a6f3b04)) {
        level.var_6a6f3b04 = 60;
    }
    visionset_mgr::register_info("visionset", "speed_burst", 1, level.var_6a6f3b04, 9, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
    callback::on_connect(&function_bfafa469);
}

// Namespace namespace_3a292d50/gadget_speed_burst
// Params 1, eflags: 0x0
// Checksum 0x1d4514f3, Offset: 0x4d0
// Size: 0x2a
function function_15880b4e(slot) {
    return self flagsys::get("gadget_speed_burst_on");
}

// Namespace namespace_3a292d50/gadget_speed_burst
// Params 1, eflags: 0x0
// Checksum 0xccf21842, Offset: 0x508
// Size: 0x22
function function_8386c640(slot) {
    return self gadgetflickering(slot);
}

// Namespace namespace_3a292d50/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0x494717df, Offset: 0x538
// Size: 0x34
function function_70950c7(slot, weapon) {
    self thread function_5b8d7647(slot, weapon);
}

// Namespace namespace_3a292d50/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0x62bef57c, Offset: 0x578
// Size: 0x7c
function function_41c1ea5a(slot, weapon) {
    if (isdefined(level.var_47a0942f)) {
        self thread [[ level.var_47a0942f ]](slot, weapon);
    }
    flagsys::set("speed_burst_on");
    self clientfield::set_to_player("speed_burst", 0);
}

// Namespace namespace_3a292d50/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0x23d5ae2d, Offset: 0x600
// Size: 0x4c
function function_65a0fef4(slot, weapon) {
    flagsys::clear("speed_burst_on");
    self clientfield::set_to_player("speed_burst", 0);
}

// Namespace namespace_3a292d50/gadget_speed_burst
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x658
// Size: 0x4
function function_bfafa469() {
    
}

// Namespace namespace_3a292d50/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0xc49d549a, Offset: 0x668
// Size: 0xcc
function function_4471717e(slot, weapon) {
    self flagsys::set("gadget_speed_burst_on");
    self gadgetsetactivatetime(slot, gettime());
    self clientfield::set_to_player("speed_burst", 1);
    visionset_mgr::activate("visionset", "speed_burst", self, 0.4, 0.1, 1.35);
    self.speedburstlastontime = gettime();
    self.speedburston = 1;
    self.speedburstkill = 0;
}

// Namespace namespace_3a292d50/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0x877218a6, Offset: 0x740
// Size: 0x100
function function_51b450f4(slot, weapon) {
    self notify(#"hash_51b450f4");
    self flagsys::clear("gadget_speed_burst_on");
    self clientfield::set_to_player("speed_burst", 0);
    self.speedburstlastontime = gettime();
    self.speedburston = 0;
    if (isalive(self) && isdefined(level.playgadgetsuccess)) {
        if (isdefined(self.speedburstkill) && self.speedburstkill) {
            self [[ level.playgadgetsuccess ]](weapon);
        } else {
            self [[ level.playgadgetoff ]](weapon);
        }
    }
    self.speedburstkill = 0;
}

// Namespace namespace_3a292d50/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0x8b3d36d, Offset: 0x848
// Size: 0xdc
function function_5b8d7647(slot, weapon) {
    self endon(#"disconnect");
    if (!self function_15880b4e(slot)) {
        return;
    }
    eventtime = self._gadgets_player[slot].gadget_flickertime;
    self function_39b1b87b("Flickering", eventtime);
    while (true) {
        if (!self gadgetflickering(slot)) {
            self function_39b1b87b("Normal");
            return;
        }
        wait 0.5;
    }
}

// Namespace namespace_3a292d50/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0xa3b02d94, Offset: 0x930
// Size: 0x9c
function function_39b1b87b(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Vision Speed burst: " + status + timestr);
    }
}

