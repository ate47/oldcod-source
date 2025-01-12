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
function autoexec function_2dc19561() {
    system::register("gadget_camo", &__init__, undefined, undefined);
}

// Namespace gadget_camo/gadget_camo
// Params 0, eflags: 0x0
// Checksum 0x8ab57c72, Offset: 0x300
// Size: 0x154
function __init__() {
    ability_player::register_gadget_activation_callbacks(2, &function_700380c0, &function_3078d9ee);
    ability_player::register_gadget_possession_callbacks(2, &function_58efbfed, &function_9da1d50f);
    ability_player::register_gadget_flicker_callbacks(2, &function_63b9579a);
    ability_player::register_gadget_is_inuse_callbacks(2, &function_6b246a0f);
    ability_player::register_gadget_is_flickering_callbacks(2, &function_558ba1f7);
    clientfield::register("allplayers", "camo_shader", 1, 3, "int");
    callback::on_connect(&function_7af2cde4);
    callback::on_spawned(&function_2fd91ec7);
    callback::on_disconnect(&function_3f5bf600);
}

// Namespace gadget_camo/gadget_camo
// Params 1, eflags: 0x0
// Checksum 0xb8725ed8, Offset: 0x460
// Size: 0x2a
function function_6b246a0f(slot) {
    return self flagsys::get("camo_suit_on");
}

// Namespace gadget_camo/gadget_camo
// Params 1, eflags: 0x0
// Checksum 0x656e2c02, Offset: 0x498
// Size: 0x22
function function_558ba1f7(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_camo/gadget_camo
// Params 0, eflags: 0x0
// Checksum 0x3b8a9363, Offset: 0x4c8
// Size: 0x50
function function_7af2cde4() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo.var_5d2fec30 ]]();
    }
}

// Namespace gadget_camo/gadget_camo
// Params 0, eflags: 0x0
// Checksum 0x4ee286eb, Offset: 0x520
// Size: 0x4c
function function_3f5bf600() {
    if (isdefined(self.sound_ent)) {
        self.sound_ent stoploopsound(0.05);
        self.sound_ent delete();
    }
}

// Namespace gadget_camo/gadget_camo
// Params 0, eflags: 0x0
// Checksum 0x93cbe7, Offset: 0x578
// Size: 0xac
function function_2fd91ec7() {
    self flagsys::clear("camo_suit_on");
    self notify(#"hash_af133c03");
    self function_6f5db838();
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
function function_a68d6bbe(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"hash_af133c03");
    self clientfield::set("camo_shader", 2);
    function_f93698a2(slot, weapon);
    if (self function_6b246a0f(slot)) {
        self clientfield::set("camo_shader", 1);
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x6bf3736d, Offset: 0x6d8
// Size: 0x54
function function_f93698a2(slot, weapon) {
    self endon(#"death");
    self endon(#"hash_af133c03");
    while (self function_558ba1f7(slot)) {
        wait 0.5;
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0xba73ead0, Offset: 0x738
// Size: 0x68
function function_58efbfed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x2ceaf480, Offset: 0x7a8
// Size: 0x78
function function_9da1d50f(slot, weapon) {
    self notify(#"hash_6adca138");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0xd542fb60, Offset: 0x828
// Size: 0x88
function function_63b9579a(slot, weapon) {
    self thread function_1cecfd6a(slot, weapon);
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace gadget_camo/gadget_camo
// Params 1, eflags: 0x0
// Checksum 0x4165503e, Offset: 0x8b8
// Size: 0xd6
function function_de8067aa(value) {
    var_ce588222 = "axis";
    if (self.team == "axis") {
        var_ce588222 = "allies";
    }
    var_4174f437 = getaiarray(var_ce588222);
    for (i = 0; i < var_4174f437.size; i++) {
        testtarget = var_4174f437[i];
        if (!isdefined(testtarget) || !isalive(testtarget)) {
        }
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x8a8894df, Offset: 0x998
// Size: 0x10c
function function_700380c0(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._on ]](slot, weapon);
    }
    self thread function_e4b1d75d(slot, weapon);
    self val::set("camo_ignore", "ignoreme", 1);
    self clientfield::set("camo_shader", 1);
    self flagsys::set("camo_suit_on");
    self thread function_f026eb72(slot, weapon);
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x211b4f59, Offset: 0xab0
// Size: 0x10c
function function_3078d9ee(slot, weapon) {
    self flagsys::clear("camo_suit_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._off ]](slot, weapon);
    }
    if (isdefined(self.sound_ent)) {
    }
    self notify(#"hash_af133c03");
    self val::reset("camo_ignore", "ignoreme");
    self function_6f5db838();
    self.var_9b8eaff2 = gettime();
    self clientfield::set("camo_shader", 0);
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x10be8397, Offset: 0xbc8
// Size: 0xe4
function function_f026eb72(slot, weapon) {
    self notify(#"hash_f026eb72");
    self endon(#"hash_f026eb72");
    self function_6f5db838();
    if (!self function_6b246a0f()) {
        return;
    }
    self.var_3c9c8d7c = spawn("script_model", self.origin);
    self.var_3c9c8d7c setmodel("tag_origin");
    self function_f3c24946(slot, weapon);
    self function_6f5db838();
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0xf9345e3b, Offset: 0xcb8
// Size: 0xa4
function function_f3c24946(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_af133c03");
    self endon(#"hash_f026eb72");
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
function function_6f5db838() {
    if (isdefined(self.var_3c9c8d7c)) {
        self.var_3c9c8d7c delete();
        self.var_3c9c8d7c = undefined;
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0xd1ebc9ab, Offset: 0xda8
// Size: 0xb0
function function_e4b1d75d(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"hash_af133c03");
    while (true) {
        self waittill("weapon_assassination");
        if (self function_6b246a0f()) {
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
function function_1fc332a6(slot) {
    self endon(#"disconnect");
    if (!self function_6b246a0f()) {
        return;
    }
    self notify(#"hash_da72bae5");
    wait 0.1;
    self val::reset("camo_ignore", "ignoreme");
    function_5ec0c7ba(slot);
    if (self function_6b246a0f()) {
        self val::set("camo_ignore", "ignoreme", 1);
    }
}

// Namespace gadget_camo/gadget_camo
// Params 1, eflags: 0x0
// Checksum 0x23ebe5a7, Offset: 0xf30
// Size: 0x6c
function function_5ec0c7ba(slot) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_af133c03");
    self endon(#"hash_da72bae5");
    while (true) {
        if (!self function_558ba1f7(slot)) {
            return;
        }
        wait 0.25;
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x808e01f4, Offset: 0xfa8
// Size: 0xd4
function function_1cecfd6a(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_af133c03");
    if (!self function_6b246a0f()) {
        return;
    }
    self thread function_1fc332a6(slot);
    self thread function_a68d6bbe(slot, weapon);
    while (true) {
        if (!self function_558ba1f7(slot)) {
            self thread function_f026eb72(slot);
            return;
        }
        wait 0.25;
    }
}

// Namespace gadget_camo/gadget_camo
// Params 2, eflags: 0x0
// Checksum 0x88e39a4b, Offset: 0x1088
// Size: 0xa4
function function_c4eeb87f(status, time) {
    timestr = "";
    self.var_3bea8b4a = undefined;
    if (isdefined(time)) {
        timestr = ", ^3time: " + time;
        self.var_3bea8b4a = status;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Camo Reveal: " + status + timestr);
    }
}

