#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_aat_plasmatic_burst;

// Namespace zm_aat_plasmatic_burst/zm_aat_plasmatic_burst
// Params 0, eflags: 0x2
// Checksum 0xfcc238f4, Offset: 0x190
// Size: 0x34
function autoexec __init__system__() {
    system::register("zm_aat_plasmatic_burst", &__init__, undefined, undefined);
}

// Namespace zm_aat_plasmatic_burst/zm_aat_plasmatic_burst
// Params 0, eflags: 0x0
// Checksum 0xec9bace3, Offset: 0x1d0
// Size: 0x1ba
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_plasmatic_burst", #"hash_164d02d599d1fa8f", "t7_icon_zm_aat_blast_furnace");
    clientfield::register("actor", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter", &zm_aat_plasmatic_burst_explosion, 0, 0);
    clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter", &zm_aat_plasmatic_burst_explosion, 0, 0);
    clientfield::register("actor", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "counter", &function_9651ba9f, 0, 0);
    clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "counter", &function_229d256, 0, 0);
    level._effect[#"zm_aat_plasmatic_burst"] = "zm_weapons/fx8_aat_plasmatic_burst_torso";
}

// Namespace zm_aat_plasmatic_burst/zm_aat_plasmatic_burst
// Params 7, eflags: 0x0
// Checksum 0x4d803e13, Offset: 0x398
// Size: 0xac
function zm_aat_plasmatic_burst_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playsound(0, #"hash_6990e5a39e894c04", self.origin);
    util::playfxontag(localclientnum, level._effect[#"zm_aat_plasmatic_burst"], self, self zm_utility::function_a7776589(1));
}

// Namespace zm_aat_plasmatic_burst/zm_aat_plasmatic_burst
// Params 7, eflags: 0x0
// Checksum 0xebb0087e, Offset: 0x450
// Size: 0xa4
function function_9651ba9f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    tag = "j_spine4";
    v_tag = self gettagorigin(tag);
    if (!isdefined(v_tag)) {
        tag = "tag_origin";
    }
    level thread function_bf2d5a46(localclientnum, self, tag);
}

// Namespace zm_aat_plasmatic_burst/zm_aat_plasmatic_burst
// Params 7, eflags: 0x0
// Checksum 0xe029ed61, Offset: 0x500
// Size: 0xa4
function function_229d256(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    tag = "tag_body";
    v_tag = self gettagorigin(tag);
    if (!isdefined(v_tag)) {
        tag = "tag_origin";
    }
    level thread function_bf2d5a46(localclientnum, self, tag);
}

// Namespace zm_aat_plasmatic_burst/zm_aat_plasmatic_burst
// Params 3, eflags: 0x0
// Checksum 0x19c1ce71, Offset: 0x5b0
// Size: 0x144
function function_bf2d5a46(localclientnum, e_zombie, tag) {
    e_zombie.var_6219199c = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_plasmatic_burst_torso_fire", e_zombie, tag);
    e_zombie.var_5d27a40d = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_plasmatic_burst_head", e_zombie, "j_head");
    if (!isdefined(e_zombie.var_1b2e602a)) {
        e_zombie.var_1b2e602a = e_zombie playloopsound(#"hash_645b60f29309dc9b");
    }
    e_zombie waittill(#"death");
    if (isdefined(e_zombie)) {
        if (isdefined(e_zombie.var_1b2e602a)) {
            e_zombie stoploopsound(e_zombie.var_1b2e602a);
        }
        stopfx(localclientnum, e_zombie.var_6219199c);
        stopfx(localclientnum, e_zombie.var_5d27a40d);
    }
}

