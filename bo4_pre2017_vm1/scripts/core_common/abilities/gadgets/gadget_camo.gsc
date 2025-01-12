#using scripts/core_common/abilities/ability_gadgets;
#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/values_shared;

#namespace gadget_camo;

// Namespace gadget_camo/gadget_camo
// Params 0, eflags: 0x2
// Checksum 0xe2faaed7, Offset: 0x2c0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_camo", &__init__, undefined, undefined);
}

// Namespace gadget_camo/gadget_camo
// Params 0, eflags: 0x0
// Checksum 0x8ab57c72, Offset: 0x300
// Size: 0x154
function __init__() {
    ability_player::register_gadget_activation_callbacks(2, &camo_gadget_on, &camo_gadget_off);
    ability_player::register_gadget_possession_callbacks(2, &camo_on_give, &camo_on_take);
    ability_player::register_gadget_flicker_callbacks(2, &camo_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(2, &camo_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(2, &camo_is_flickering);
    clientfield::register("allplayers", "camo_shader", 1, 3, "int");
    callback::on_connect(&camo_on_connect);
    callback::on_spawned(&camo_on_spawn);
    callback::on_disconnect(&camo_on_disconnect);
}

// Namespace gadget_camo/gadget_camo
// Params 1, eflags: 0x0
// Checksum 0xb8725ed8, Offset: 0x460
// Size: 0x2a
function camo_is_inuse(slot) {
    return self flagsys::get("camo_suit_on");
}

// Namespace gadget_camo/gadget_camo
// Params 1, eflags: 0x0
// Checksum 0x656e2c02, Offset: 0x498
// Size: 0x22
function camo_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_camo/gadget_camo
// Params 0, eflags: 0x0
// Checksum 0x3b8a9363, Offset: 0x4c8
// Size: 0x50
function camo_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo._on_connect ]]();
    }
}

// Namespace gadget_camo/gadget_camo
// Params 0, eflags: 0x0
// Checksum 0x4ee286eb, Offset: 0x520
// Size: 0x4c
function camo_on_disconnect() {
    if (isdefined(self.sound_ent)) {
        self.sound_ent stoploopsound(0.05);
        self.sound_ent delete();
    }
}

// Namespace gadget_camo/gadget_camo
// Params 0, eflags: 0x0
// Checksum 0x93cbe7, Offset: 0x578
// Size: 0xac
function camo_on_spawn() {
    self flagsys::clear("camo_suit_on");
    self notify(#"camo_off");
    self camo_bread_crumb_delete();
    self clientfield::set("camo_shader", 0);
    if (isdefined(self.sound_ent)) {
        self.sound_ent stoploopsound(0.05);
        self.sound_ent delete();
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x3a623724, Offset: 0x630
// Size: 0x9c
function suspend_camo_suit(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"camo_off");
    self clientfield::set("camo_shader", 2);
    suspend_camo_suit_wait(slot, weapon);
    if (self camo_is_inuse(slot)) {
        self clientfield::set("camo_shader", 1);
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x6bf3736d, Offset: 0x6d8
// Size: 0x54
function suspend_camo_suit_wait(slot, weapon) {
    self endon(#"death");
    self endon(#"camo_off");
    while (self camo_is_flickering(slot)) {
        wait 0.5;
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0xba73ead0, Offset: 0x738
// Size: 0x68
function camo_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo._on_give ]](slot, weapon);
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x2ceaf480, Offset: 0x7a8
// Size: 0x78
function camo_on_take(slot, weapon) {
    self notify(#"camo_removed");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo._on_take ]](slot, weapon);
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0xd542fb60, Offset: 0x828
// Size: 0x88
function camo_on_flicker(slot, weapon) {
    self thread camo_suit_flicker(slot, weapon);
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_camo/gadget_camo
// Params 1, eflags: 0x0
// Checksum 0x4165503e, Offset: 0x8b8
// Size: 0xd6
function camo_all_actors(value) {
    str_opposite_team = "axis";
    if (self.team == "axis") {
        str_opposite_team = "allies";
    }
    aitargets = getaiarray(str_opposite_team);
    for (i = 0; i < aitargets.size; i++) {
        testtarget = aitargets[i];
        if (!isdefined(testtarget) || !isalive(testtarget)) {
        }
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x8a8894df, Offset: 0x998
// Size: 0x10c
function camo_gadget_on(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._on ]](slot, weapon);
    }
    self thread camo_takedown_watch(slot, weapon);
    self val::set("camo_ignore", "ignoreme", 1);
    self clientfield::set("camo_shader", 1);
    self flagsys::set("camo_suit_on");
    self thread camo_bread_crumb(slot, weapon);
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x211b4f59, Offset: 0xab0
// Size: 0x10c
function camo_gadget_off(slot, weapon) {
    self flagsys::clear("camo_suit_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._off ]](slot, weapon);
    }
    if (isdefined(self.sound_ent)) {
    }
    self notify(#"camo_off");
    self val::reset("camo_ignore", "ignoreme");
    self camo_bread_crumb_delete();
    self.gadget_camo_off_time = gettime();
    self clientfield::set("camo_shader", 0);
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x10be8397, Offset: 0xbc8
// Size: 0xe4
function camo_bread_crumb(slot, weapon) {
    self notify(#"camo_bread_crumb");
    self endon(#"camo_bread_crumb");
    self camo_bread_crumb_delete();
    if (!self camo_is_inuse()) {
        return;
    }
    self._camo_crumb = spawn("script_model", self.origin);
    self._camo_crumb setmodel("tag_origin");
    self camo_bread_crumb_wait(slot, weapon);
    self camo_bread_crumb_delete();
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0xf9345e3b, Offset: 0xcb8
// Size: 0xa4
function camo_bread_crumb_wait(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"camo_off");
    self endon(#"camo_bread_crumb");
    starttime = gettime();
    while (true) {
        currenttime = gettime();
        if (currenttime - starttime > self._gadgets_player[slot].gadget_breadcrumbduration) {
            return;
        }
        wait 0.5;
    }
}

// Namespace gadget_camo/gadget_camo
// Params 0, eflags: 0x0
// Checksum 0x21163a9b, Offset: 0xd68
// Size: 0x36
function camo_bread_crumb_delete() {
    if (isdefined(self._camo_crumb)) {
        self._camo_crumb delete();
        self._camo_crumb = undefined;
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0xd1ebc9ab, Offset: 0xda8
// Size: 0xb0
function camo_takedown_watch(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"camo_off");
    while (true) {
        self waittill("weapon_assassination");
        if (self camo_is_inuse()) {
            if (self._gadgets_player[slot].gadget_takedownrevealtime > 0) {
                self ability_gadgets::setflickering(slot, self._gadgets_player[slot].gadget_takedownrevealtime);
            }
        }
    }
}

// Namespace gadget_camo/gadget_camo
// Params 1, eflags: 0x0
// Checksum 0x82946a2d, Offset: 0xe60
// Size: 0xc4
function camo_temporary_dont_ignore(slot) {
    self endon(#"disconnect");
    if (!self camo_is_inuse()) {
        return;
    }
    self notify(#"temporary_dont_ignore");
    wait 0.1;
    self val::reset("camo_ignore", "ignoreme");
    camo_temporary_dont_ignore_wait(slot);
    if (self camo_is_inuse()) {
        self val::set("camo_ignore", "ignoreme", 1);
    }
}

// Namespace gadget_camo/gadget_camo
// Params 1, eflags: 0x0
// Checksum 0x23ebe5a7, Offset: 0xf30
// Size: 0x6c
function camo_temporary_dont_ignore_wait(slot) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"camo_off");
    self endon(#"temporary_dont_ignore");
    while (true) {
        if (!self camo_is_flickering(slot)) {
            return;
        }
        wait 0.25;
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x808e01f4, Offset: 0xfa8
// Size: 0xd4
function camo_suit_flicker(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"camo_off");
    if (!self camo_is_inuse()) {
        return;
    }
    self thread camo_temporary_dont_ignore(slot);
    self thread suspend_camo_suit(slot, weapon);
    while (true) {
        if (!self camo_is_flickering(slot)) {
            self thread camo_bread_crumb(slot);
            return;
        }
        wait 0.25;
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x88e39a4b, Offset: 0x1088
// Size: 0xa4
function set_camo_reveal_status(status, time) {
    timestr = "";
    self._gadget_camo_reveal_status = undefined;
    if (isdefined(time)) {
        timestr = ", ^3time: " + time;
        self._gadget_camo_reveal_status = status;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Camo Reveal: " + status + timestr);
    }
}

