#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace flashlight;

// Namespace flashlight/flashlight
// Params 0, eflags: 0x6
// Checksum 0x7554bd46, Offset: 0x1d8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"flashlight", &function_f64316de, undefined, undefined, undefined);
}

// Namespace flashlight/flashlight
// Params 1, eflags: 0x0
// Checksum 0xc61e5f96, Offset: 0x220
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
// Checksum 0xa57b4de, Offset: 0x360
// Size: 0x9e
function function_8d59ee47(flashlight_out = 0) {
    if (flashlight_out) {
        if (function_b8090745()) {
            self thread function_1ad12840("detach", &function_229440d2);
        } else {
            function_229440d2();
        }
    } else {
        function_ac53d0fb();
    }
    self.flashlight.out = flashlight_out;
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x0
// Checksum 0xd7cc1bf7, Offset: 0x408
// Size: 0x38
function function_b8090745() {
    if (self getblackboardattribute("_flashlight") === "flashlight_out") {
        return true;
    }
    return false;
}

// Namespace flashlight/flashlight
// Params 2, eflags: 0x0
// Checksum 0x80e3feb7, Offset: 0x448
// Size: 0x62
function function_7b72a4ab(flashlightmodel, var_f8962b6d) {
    if (!isdefined(self.flashlight)) {
        self.flashlight = {};
    }
    self.flashlight.modeloverride = flashlightmodel;
    self.flashlight.var_69749c1 = isdefined(var_f8962b6d) ? var_f8962b6d : flashlightmodel;
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x0
// Checksum 0x317aa5dc, Offset: 0x4b8
// Size: 0x72
function function_3ed8613f() {
    modelname = "com_flashlight_on_xforward_no_tag_weapon";
    if (isdefined(self.flashlight.modeloverride)) {
        modelname = self.flashlight.modeloverride;
    } else if (isdefined(level.flashlight.modeloverride)) {
        modelname = level.flashlight.modeloverride;
    }
    return modelname;
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x0
// Checksum 0x1b28582b, Offset: 0x538
// Size: 0x72
function function_54c2c072() {
    modelname = "com_flashlight_on_xforward_no_tag_weapon_off";
    if (isdefined(self.flashlight.var_69749c1)) {
        modelname = self.flashlight.var_69749c1;
    } else if (isdefined(level.flashlight.var_69749c1)) {
        modelname = level.flashlight.var_69749c1;
    }
    return modelname;
}

// Namespace flashlight/flashlight
// Params 1, eflags: 0x0
// Checksum 0x5f0674ae, Offset: 0x5b8
// Size: 0x4a
function function_32fb7a97(var_704fb596 = "tag_accessory_left") {
    if (!isdefined(self.flashlight)) {
        self.flashlight = {};
    }
    self.flashlight.var_7a9de72 = var_704fb596;
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x0
// Checksum 0xc44930e7, Offset: 0x610
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
// Params 1, eflags: 0x0
// Checksum 0xa01d6ee3, Offset: 0x690
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
// Params 0, eflags: 0x0
// Checksum 0x43e1224b, Offset: 0x7a0
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
// Params 0, eflags: 0x0
// Checksum 0xd2f911c5, Offset: 0x870
// Size: 0x1c4
function function_7db73593() {
    model = function_54c2c072();
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
// Params 0, eflags: 0x0
// Checksum 0x294fbef7, Offset: 0xa40
// Size: 0xc4
function function_7c2f623b() {
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
    self setblackboardattribute("_flashlight", "flashlight_out");
    self clientfield::set("flashlightfx", 1);
}

// Namespace flashlight/flashlight
// Params 2, eflags: 0x0
// Checksum 0x95271d86, Offset: 0xb10
// Size: 0x114
function function_229440d2(forced = 0, fxtag) {
    if (!isdefined(self.flashlight)) {
        self.flashlight = {};
    }
    if (!forced) {
        if (isdefined(self.flashlight.model)) {
            return;
        }
        if (!is_true(self.flashlight.out)) {
            return;
        }
        if (is_true(self.flashlight.on)) {
            return;
        }
    }
    self.flashlight.on = 1;
    self.flashlight.var_229440d2 = 1;
    self.flashlight.tag = isdefined(fxtag) ? fxtag : "tag_muzzle";
    self clientfield::set("gunflashlightfx", 1);
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x0
// Checksum 0xe96d4066, Offset: 0xc30
// Size: 0x22
function function_47df32b8() {
    return is_true(self.flashlight.on);
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x0
// Checksum 0x79ec9883, Offset: 0xc60
// Size: 0xcc
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
    self setblackboardattribute("_flashlight", "flashlight_stow");
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x0
// Checksum 0x6198d25e, Offset: 0xd38
// Size: 0x22
function function_3aec1b7() {
    return is_true(self.flashlight.var_229440d2);
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x0
// Checksum 0x98636bcd, Offset: 0xd68
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
// Checksum 0xc3aef3f1, Offset: 0xde0
// Size: 0x1ae
function function_51dea76e(othersentient) {
    entnum = self getentitynumber();
    range_sq = sqr(isdefined(self.var_1c936867) ? self.var_1c936867 : 850);
    cosfov = 0.866;
    if (is_true(self.flashlight.on)) {
        var_78601034 = othersentient geteye();
        flash_origin = self gettagorigin(self.flashlight.tag);
        flash_angles = self gettagangles(self.flashlight.tag);
        if (isdefined(flash_origin) && isdefined(flash_angles) && distancesquared(flash_origin, var_78601034) < range_sq) {
            if (self util::function_aae7d83d(flash_origin, flash_angles, var_78601034, cosfov)) {
                if (sighttracepassed(flash_origin + anglestoforward(flash_angles) * 20, var_78601034, 0, othersentient)) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x4
// Checksum 0xd7450c28, Offset: 0xf98
// Size: 0x4c
function private function_f64316de() {
    function_bc948200();
    level.var_ab828d57 = &function_7db73593;
    callback::on_ai_spawned(&function_fb6fb7ad);
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x4
// Checksum 0x6c0b5f9d, Offset: 0xff0
// Size: 0x94
function private function_bc948200() {
    clientfield::register("actor", "flashlightfx", 1, 1, "int");
    clientfield::register("scriptmover", "flashlightfx", 1, 2, "int");
    clientfield::register("actor", "gunflashlightfx", 1, 1, "int");
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x4
// Checksum 0x4879039c, Offset: 0x1090
// Size: 0x9c
function private function_fb6fb7ad() {
    if (self.species !== "human") {
        return;
    }
    self.var_710f0e6e = &function_65e5c8c8;
    self.fnstealthflashlightdetach = &function_bfffb3fe;
    self.fnstealthflashlighton = &function_7c2f623b;
    self.fnstealthflashlightoff = &light_off;
    self setblackboardattribute("_flashlight", "flashlight_stow");
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x4
// Checksum 0x883dd706, Offset: 0x1138
// Size: 0x5c
function private function_4e897ec7() {
    self notify("18d939c31eb079a4");
    self endon("18d939c31eb079a4");
    self endon(#"hash_41c8d256b3d76cf");
    self waittill(#"death");
    if (isdefined(self)) {
        self thread function_7db73593();
    }
}

// Namespace flashlight/flashlight
// Params 2, eflags: 0x0
// Checksum 0x77b836fd, Offset: 0x11a0
// Size: 0x11e
function function_1ad12840(var_baa290f1, var_affc8431) {
    self notify("2fee7b78d59cad0e");
    self endon("2fee7b78d59cad0e");
    self endon(#"death", #"entitydeleted", #"hash_335827d811ed5f67");
    result = self waittilltimeout(5, #"attach", #"detach");
    if (result._notify === "attach") {
        self function_65e5c8c8(1);
    } else if (result._notify === "detach") {
        self function_bfffb3fe();
    }
    if (result._notify === var_baa290f1) {
        self [[ var_affc8431 ]]();
    }
}

