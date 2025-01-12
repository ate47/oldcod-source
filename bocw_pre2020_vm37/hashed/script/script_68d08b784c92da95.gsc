#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace flashlight;

// Namespace flashlight/flashlight
// Params 0, eflags: 0x6
// Checksum 0xbc6c5788, Offset: 0x1a8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"flashlight", &function_f64316de, undefined, undefined, undefined);
}

// Namespace flashlight/flashlight
// Params 1, eflags: 0x0
// Checksum 0xc64d7e33, Offset: 0x1f0
// Size: 0x134
function function_9b7441d1(flashlight_out = 0) {
    if (!isdefined(self.flashlight)) {
        self.flashlight = {};
    }
    var_5e61cb7e = self getblackboardattribute("_flashlight");
    if (is_true(flashlight_out) && var_5e61cb7e !== "flashlight_out" || !is_true(flashlight_out) && var_5e61cb7e !== "flashlight_stow") {
        self.flashlight.transition = 1;
        self thread function_1ad12840();
    } else if (is_true(self.flashlight.transition)) {
        self.flashlight.transition = undefined;
    }
    self.flashlight.out = flashlight_out;
    function_ac53d0fb();
}

// Namespace flashlight/flashlight
// Params 1, eflags: 0x0
// Checksum 0xd0d4807e, Offset: 0x330
// Size: 0x5e
function function_8d59ee47(flashlight_out = 0) {
    if (flashlight_out) {
        function_229440d2();
    } else {
        function_ac53d0fb();
    }
    self.flashlight.out = flashlight_out;
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x0
// Checksum 0xafb5650d, Offset: 0x398
// Size: 0x38
function function_b8090745() {
    if (self getblackboardattribute("_flashlight") === "flashlight_out") {
        return true;
    }
    return false;
}

// Namespace flashlight/flashlight
// Params 1, eflags: 0x0
// Checksum 0xe4b0ef6c, Offset: 0x3d8
// Size: 0x36
function function_7b72a4ab(flashlightmodel) {
    if (!isdefined(self.flashlight)) {
        self.flashlight = {};
    }
    self.flashlight.var_52620179 = flashlightmodel;
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x1 linked
// Checksum 0x35697fe7, Offset: 0x418
// Size: 0x72
function function_3ed8613f() {
    modelname = "com_flashlight_on_xforward_no_tag_weapon";
    if (isdefined(self.flashlight.var_52620179)) {
        modelname = self.flashlight.var_52620179;
    } else if (isdefined(level.flashlight.var_52620179)) {
        modelname = level.flashlight.var_52620179;
    }
    return modelname;
}

// Namespace flashlight/flashlight
// Params 1, eflags: 0x0
// Checksum 0x7a1a3ef2, Offset: 0x498
// Size: 0x4a
function function_32fb7a97(var_704fb596 = "tag_accessory_left") {
    if (!isdefined(self.flashlight)) {
        self.flashlight = {};
    }
    self.flashlight.var_7a9de72 = var_704fb596;
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x1 linked
// Checksum 0xb3a44825, Offset: 0x4f0
// Size: 0x72
function function_e77dc163() {
    tag = "tag_accessory_left";
    if (isdefined(self.flashlight.var_7a9de72)) {
        tag = self.flashlight.var_7a9de72;
    } else if (isdefined(level.flashlight.var_7a9de72)) {
        tag = level.flashlight.var_7a9de72;
    }
    return tag;
}

// Namespace flashlight/flashlight
// Params 1, eflags: 0x1 linked
// Checksum 0x63094a0e, Offset: 0x570
// Size: 0x104
function function_65e5c8c8(var_45c9e542) {
    if (!isdefined(self.flashlight)) {
        self.flashlight = {};
    }
    if (isdefined(self.flashlight.model)) {
        return;
    }
    modelname = self function_3ed8613f();
    tag = self function_e77dc163();
    self attach(modelname, tag, 1);
    self.flashlight.model = modelname;
    self.flashlight.tag = tag;
    if (is_true(var_45c9e542) && isdefined(self.fnstealthflashlighton)) {
        self [[ self.fnstealthflashlighton ]]();
    }
    self thread function_4e897ec7();
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x1 linked
// Checksum 0x3314e9e0, Offset: 0x680
// Size: 0xc6
function function_bfffb3fe() {
    if (!isdefined(self.flashlight.model)) {
        return;
    }
    if (isdefined(self.fnstealthflashlightoff)) {
        self [[ self.fnstealthflashlightoff ]]();
    }
    if (isdefined(self.flashlight.model) && isdefined(self.flashlight.tag)) {
        self detach(self.flashlight.model, self.flashlight.tag);
    }
    self.flashlight.model = undefined;
    self.flashlight.tag = undefined;
    self notify(#"hash_41c8d256b3d76cf");
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x1 linked
// Checksum 0x981cedde, Offset: 0x750
// Size: 0x1c4
function function_7db73593() {
    model = self.flashlight.model;
    tag = self.flashlight.tag;
    self function_bfffb3fe();
    if (isdefined(model) && isdefined(tag)) {
        origin = self gettagorigin(tag);
        angles = self gettagangles(tag);
        if (isdefined(origin) && isdefined(angles)) {
            ent = spawn("script_model", origin);
            if (isdefined(ent)) {
                ent endon(#"death");
                ent setmodel(model);
                ent.angles = angles;
                ent physicslaunch();
                ent clientfield::set("flashlightfx", 1);
                if (is_true(self.in_melee_death)) {
                    wait randomfloatrange(3, 4);
                }
                wait randomfloatrange(0.1, 0.3);
                ent clientfield::set("flashlightfx", 2);
            }
        }
    }
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x1 linked
// Checksum 0x542a73e7, Offset: 0x920
// Size: 0xa4
function light_on() {
    if (!isdefined(self.flashlight.model)) {
        self function_65e5c8c8(1);
    }
    if (!isdefined(self.flashlight.model)) {
        return;
    }
    if (is_true(self.flashlight.on)) {
        return;
    }
    self.flashlight.on = 1;
    self clientfield::set("flashlightfx", 1);
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x1 linked
// Checksum 0xff19287f, Offset: 0x9d0
// Size: 0xdc
function function_229440d2() {
    if (!isdefined(self.flashlight)) {
        self.flashlight = {};
    }
    if (isdefined(self.flashlight.model)) {
        return;
    }
    if (!is_true(self.flashlight.out)) {
        return;
    }
    if (is_true(self.flashlight.on)) {
        return;
    }
    self.flashlight.on = 1;
    self.flashlight.var_229440d2 = 1;
    self.flashlight.tag = "tag_muzzle";
    self clientfield::set("gunflashlightfx", 1);
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x0
// Checksum 0x15c7bfd6, Offset: 0xab8
// Size: 0x22
function function_47df32b8() {
    return is_true(self.flashlight.on);
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x1 linked
// Checksum 0xea03e1e7, Offset: 0xae8
// Size: 0xa4
function function_ac53d0fb() {
    if (!isdefined(self.flashlight)) {
        self.flashlight = {};
    }
    if (isdefined(self.flashlight.model)) {
        return;
    }
    if (!is_true(self.flashlight.on)) {
        return;
    }
    self.flashlight.on = undefined;
    self.flashlight.tag = undefined;
    self.flashlight.var_229440d2 = undefined;
    self clientfield::set("gunflashlightfx", 0);
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x0
// Checksum 0x5019628d, Offset: 0xb98
// Size: 0x22
function function_3aec1b7() {
    return is_true(self.flashlight.var_229440d2);
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x1 linked
// Checksum 0x9c082279, Offset: 0xbc8
// Size: 0x6c
function light_off() {
    if (!isdefined(self.flashlight.model)) {
        return;
    }
    if (!is_true(self.flashlight.on)) {
        return;
    }
    self.flashlight.on = undefined;
    self clientfield::set("flashlightfx", 0);
}

// Namespace flashlight/flashlight
// Params 1, eflags: 0x0
// Checksum 0x8858b8ac, Offset: 0xc40
// Size: 0x1ae
function function_51dea76e(var_4efdd43) {
    entnum = self getentitynumber();
    var_bcd4dcab = function_a3f6cdac(isdefined(self.var_1c936867) ? self.var_1c936867 : 850);
    cosfov = 0.866;
    if (is_true(self.flashlight.on)) {
        var_78601034 = var_4efdd43 geteye();
        var_4a15e24e = self gettagorigin(self.flashlight.tag);
        var_72902a5c = self gettagangles(self.flashlight.tag);
        if (isdefined(var_4a15e24e) && isdefined(var_72902a5c) && distancesquared(var_4a15e24e, var_78601034) < var_bcd4dcab) {
            if (self util::function_aae7d83d(var_4a15e24e, var_72902a5c, var_78601034, cosfov)) {
                if (sighttracepassed(var_4a15e24e + anglestoforward(var_72902a5c) * 20, var_78601034, 0, var_4efdd43)) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x5 linked
// Checksum 0xd42a53bb, Offset: 0xdf8
// Size: 0x4c
function private function_f64316de() {
    function_bc948200();
    level.var_ab828d57 = &function_7db73593;
    callback::on_ai_spawned(&function_fb6fb7ad);
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x5 linked
// Checksum 0xab4b62ba, Offset: 0xe50
// Size: 0x94
function private function_bc948200() {
    clientfield::register("actor", "flashlightfx", 1, 1, "int");
    clientfield::register("scriptmover", "flashlightfx", 1, 2, "int");
    clientfield::register("actor", "gunflashlightfx", 1, 1, "int");
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x5 linked
// Checksum 0x4cadd299, Offset: 0xef0
// Size: 0x9c
function private function_fb6fb7ad() {
    if (self.species !== "human") {
        return;
    }
    self.var_710f0e6e = &function_65e5c8c8;
    self.fnstealthflashlightdetach = &function_bfffb3fe;
    self.fnstealthflashlighton = &light_on;
    self.fnstealthflashlightoff = &light_off;
    self setblackboardattribute("_flashlight", "flashlight_stow");
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x5 linked
// Checksum 0xf79ef7a2, Offset: 0xf98
// Size: 0x5c
function private function_4e897ec7() {
    self notify("3a6add2f8429d146");
    self endon("3a6add2f8429d146");
    self endon(#"hash_41c8d256b3d76cf");
    self waittill(#"death");
    if (isdefined(self)) {
        self thread function_7db73593();
    }
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x5 linked
// Checksum 0x5b5f0b77, Offset: 0x1000
// Size: 0xec
function private function_1ad12840() {
    self notify("6b92f0ad05c6023a");
    self endon("6b92f0ad05c6023a");
    self endon(#"death", #"entitydeleted", #"hash_335827d811ed5f67");
    result = self waittilltimeout(5, #"attach", #"detach");
    if (result._notify === "attach") {
        self function_65e5c8c8(1);
        return;
    }
    if (result._notify === "detach") {
        self function_bfffb3fe();
    }
}

