#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_utility;

#namespace zm_bgb_burned_out;

// Namespace zm_bgb_burned_out/zm_bgb_burned_out
// Params 0, eflags: 0x2
// Checksum 0x50ce2005, Offset: 0x190
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_burned_out", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_burned_out/zm_bgb_burned_out
// Params 0, eflags: 0x0
// Checksum 0x4229eed5, Offset: 0x1e0
// Size: 0x222
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_burned_out", "event");
    clientfield::register("toplayer", "zm_bgb_burned_out" + "_1p" + "toplayer", 1, 1, "counter", &function_9c2ec371, 0, 0);
    clientfield::register("allplayers", "zm_bgb_burned_out" + "_3p" + "_allplayers", 1, 1, "counter", &function_c8cfe3c0, 0, 0);
    clientfield::register("actor", "zm_bgb_burned_out" + "_fire_torso" + "_actor", 1, 1, "counter", &function_34caa903, 0, 0);
    clientfield::register("vehicle", "zm_bgb_burned_out" + "_fire_torso" + "_vehicle", 1, 1, "counter", &function_69abda16, 0, 0);
    level._effect["zm_bgb_burned_out" + "_1p"] = "zombie/fx_bgb_burned_out_1p_zmb";
    level._effect["zm_bgb_burned_out" + "_3p"] = "zombie/fx_bgb_burned_out_3p_zmb";
    level._effect["zm_bgb_burned_out" + "_fire_torso"] = "zombie/fx_bgb_burned_out_fire_torso_zmb";
}

// Namespace zm_bgb_burned_out/zm_bgb_burned_out
// Params 7, eflags: 0x0
// Checksum 0x87033232, Offset: 0x410
// Size: 0x94
function function_9c2ec371(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self zm_utility::function_a96d4c46(localclientnum)) {
        util::playfxontag(localclientnum, level._effect["zm_bgb_burned_out" + "_1p"], self, "tag_origin");
    }
}

// Namespace zm_bgb_burned_out/zm_bgb_burned_out
// Params 7, eflags: 0x0
// Checksum 0x619c2021, Offset: 0x4b0
// Size: 0x94
function function_c8cfe3c0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self zm_utility::function_a96d4c46(localclientnum)) {
        util::playfxontag(localclientnum, level._effect["zm_bgb_burned_out" + "_3p"], self, "tag_origin");
    }
}

// Namespace zm_bgb_burned_out/zm_bgb_burned_out
// Params 7, eflags: 0x0
// Checksum 0x3d2a34c, Offset: 0x550
// Size: 0xac
function function_34caa903(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_68b2c2e8 = "j_spinelower";
    if (isdefined(self gettagorigin(var_68b2c2e8))) {
        var_68b2c2e8 = "tag_origin";
    }
    util::playfxontag(localclientnum, level._effect["zm_bgb_burned_out" + "_fire_torso"], self, var_68b2c2e8);
}

// Namespace zm_bgb_burned_out/zm_bgb_burned_out
// Params 7, eflags: 0x0
// Checksum 0x2143ea03, Offset: 0x608
// Size: 0xac
function function_69abda16(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_68b2c2e8 = "tag_body";
    if (isdefined(self gettagorigin(var_68b2c2e8))) {
        var_68b2c2e8 = "tag_origin";
    }
    util::playfxontag(localclientnum, level._effect["zm_bgb_burned_out" + "_fire_torso"], self, var_68b2c2e8);
}

