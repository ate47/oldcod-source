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

#namespace speedburst;

// Namespace speedburst/gadget_speed_burst
// Params 0, eflags: 0x2
// Checksum 0x28ca433c, Offset: 0x308
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_speed_burst", &__init__, undefined, undefined);
}

// Namespace speedburst/gadget_speed_burst
// Params 0, eflags: 0x0
// Checksum 0x9b9c0e80, Offset: 0x348
// Size: 0x17c
function __init__() {
    clientfield::register("toplayer", "speed_burst", 1, 1, "int");
    ability_player::register_gadget_activation_callbacks(13, &gadget_speed_burst_on, &gadget_speed_burst_off);
    ability_player::register_gadget_possession_callbacks(13, &gadget_speed_burst_on_give, &gadget_speed_burst_on_take);
    ability_player::register_gadget_flicker_callbacks(13, &gadget_speed_burst_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(13, &gadget_speed_burst_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(13, &gadget_speed_burst_is_flickering);
    if (!isdefined(level.vsmgr_prio_visionset_speedburst)) {
        level.vsmgr_prio_visionset_speedburst = 60;
    }
    visionset_mgr::register_info("visionset", "speed_burst", 1, level.vsmgr_prio_visionset_speedburst, 9, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
    callback::on_connect(&gadget_speed_burst_on_connect);
}

// Namespace speedburst/gadget_speed_burst
// Params 1, eflags: 0x0
// Checksum 0x1d4514f3, Offset: 0x4d0
// Size: 0x2a
function gadget_speed_burst_is_inuse(slot) {
    return self flagsys::get("gadget_speed_burst_on");
}

// Namespace speedburst/gadget_speed_burst
// Params 1, eflags: 0x0
// Checksum 0xccf21842, Offset: 0x508
// Size: 0x22
function gadget_speed_burst_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace speedburst/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0x494717df, Offset: 0x538
// Size: 0x34
function gadget_speed_burst_on_flicker(slot, weapon) {
    self thread gadget_speed_burst_flicker(slot, weapon);
}

// Namespace speedburst/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0x62bef57c, Offset: 0x578
// Size: 0x7c
function gadget_speed_burst_on_give(slot, weapon) {
    if (isdefined(level.func_custom_game_speed_burst)) {
        self thread [[ level.func_custom_game_speed_burst ]](slot, weapon);
    }
    flagsys::set("speed_burst_on");
    self clientfield::set_to_player("speed_burst", 0);
}

// Namespace speedburst/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0x23d5ae2d, Offset: 0x600
// Size: 0x4c
function gadget_speed_burst_on_take(slot, weapon) {
    flagsys::clear("speed_burst_on");
    self clientfield::set_to_player("speed_burst", 0);
}

// Namespace speedburst/gadget_speed_burst
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x658
// Size: 0x4
function gadget_speed_burst_on_connect() {
    
}

// Namespace speedburst/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0xc49d549a, Offset: 0x668
// Size: 0xcc
function gadget_speed_burst_on(slot, weapon) {
    self flagsys::set("gadget_speed_burst_on");
    self gadgetsetactivatetime(slot, gettime());
    self clientfield::set_to_player("speed_burst", 1);
    visionset_mgr::activate("visionset", "speed_burst", self, 0.4, 0.1, 1.35);
    self.speedburstlastontime = gettime();
    self.speedburston = 1;
    self.speedburstkill = 0;
}

// Namespace speedburst/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0x877218a6, Offset: 0x740
// Size: 0x100
function gadget_speed_burst_off(slot, weapon) {
    self notify(#"gadget_speed_burst_off");
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

// Namespace speedburst/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0x8b3d36d, Offset: 0x848
// Size: 0xdc
function gadget_speed_burst_flicker(slot, weapon) {
    self endon(#"disconnect");
    if (!self gadget_speed_burst_is_inuse(slot)) {
        return;
    }
    eventtime = self._gadgets_player[slot].gadget_flickertime;
    self set_gadget_status("Flickering", eventtime);
    while (true) {
        if (!self gadgetflickering(slot)) {
            self set_gadget_status("Normal");
            return;
        }
        wait 0.5;
    }
}

// Namespace speedburst/gadget_speed_burst
// Params 2, eflags: 0x0
// Checksum 0xa3b02d94, Offset: 0x930
// Size: 0x9c
function set_gadget_status(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Vision Speed burst: " + status + timestr);
    }
}

