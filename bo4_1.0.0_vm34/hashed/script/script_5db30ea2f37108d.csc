#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_ab10cedb;

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 0, eflags: 0x2
// Checksum 0x4ede8c3d, Offset: 0x168
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_1f7228023b83d053", &__init__, undefined, undefined);
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 0, eflags: 0x0
// Checksum 0xb938b747, Offset: 0x1b0
// Size: 0x192
function __init__() {
    clientfield::register("toplayer", "" + #"place_spoon", 1, 1, "int", &function_75da28a6, 0, 0);
    clientfield::register("toplayer", "" + #"fill_blood", 1, 4, "int", &function_80a8cb6b, 0, 0);
    clientfield::register("toplayer", "" + #"hash_2058d8d474a6b3e1", 1, 1, "int", &function_6ec946e9, 0, 0);
    clientfield::register("world", "" + #"hash_ef497244490a0fc", 1, 3, "int", &function_26fce438, 0, 0);
    level._effect[#"spk_glint"] = #"zombie/fx_bmode_glint_hook_zod_zmb";
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 7, eflags: 0x0
// Checksum 0xecf254ec, Offset: 0x350
// Size: 0x11c
function function_75da28a6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_ef8ac580)) {
        var_3cc00e05 = struct::get("s_firm_place_trig");
        self.var_ef8ac580 = util::spawn_model(localclientnum, var_3cc00e05.model, var_3cc00e05.origin, var_3cc00e05.angles);
    }
    if (newval) {
        self.var_ef8ac580 show();
        playsound(localclientnum, "zmb_spoon_into_tub", self.var_ef8ac580.origin);
        return;
    }
    self.var_ef8ac580 hide();
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 7, eflags: 0x0
// Checksum 0xa2715765, Offset: 0x478
// Size: 0x3ca
function function_80a8cb6b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_b509d33c = struct::get("scn_filler_up");
    if (!isdefined(self.var_913fdc7f)) {
        self.var_913fdc7f = util::spawn_anim_model(localclientnum, "p8_fxanim_zm_esc_bathtub_filling_mod", var_b509d33c.origin, var_b509d33c.angles);
    }
    switch (newval) {
    case 1:
        self.var_913fdc7f thread animation::play(#"hash_5f152090f657bfe");
        break;
    case 2:
        self.var_913fdc7f animation::play(#"hash_6f7a3a7c471df0f2");
        self.var_913fdc7f thread animation::play(#"hash_2e86999bc8c4290d");
        break;
    case 3:
        self.var_913fdc7f animation::play(#"hash_6f7a397c471def3f");
        self.var_913fdc7f thread animation::play(#"hash_2e86969bc8c423f4");
        break;
    case 4:
        self.var_913fdc7f animation::play(#"hash_6f7a387c471ded8c");
        self.var_913fdc7f thread animation::play(#"hash_2e86979bc8c425a7");
        break;
    case 5:
        self.var_913fdc7f animation::play(#"hash_6f7a377c471debd9");
        self.var_913fdc7f thread animation::play(#"hash_2e86949bc8c4208e");
        break;
    case 6:
        self.var_913fdc7f animation::play(#"hash_6f7a367c471dea26");
        self.var_913fdc7f thread animation::play(#"hash_2e86959bc8c42241");
        break;
    case 7:
        self.var_913fdc7f animation::play(#"hash_6f7a357c471de873");
        self.var_913fdc7f thread animation::play(#"hash_4a67388210398d52");
        break;
    case 8:
        self.var_913fdc7f animation::play(#"hash_4e65f766225b67df");
        self.var_913fdc7f thread animation::play(#"hash_5f152090f657bfe");
        break;
    }
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 7, eflags: 0x0
// Checksum 0x203180f6, Offset: 0x850
// Size: 0x1cc
function function_6ec946e9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        var_7acd8293 = struct::get("s_s_t_loc");
        self.var_f501e25 = util::spawn_model(localclientnum, var_7acd8293.model, var_7acd8293.origin, var_7acd8293.angles);
        self.var_f501e25.var_275b7e94 = self.var_f501e25 gettagorigin("tag_spork");
        self.var_f501e25.var_e113577a = self.var_f501e25 gettagangles("tag_spork");
        self.mdl_spork = util::spawn_model(localclientnum, "wpn_t8_zm_spork_world", self.var_f501e25.var_275b7e94, self.var_f501e25.var_e113577a);
        self.var_4d48cfd0 = util::playfxontag(localclientnum, level._effect[#"spk_glint"], self.var_f501e25, "tag_spork");
        return;
    }
    self.mdl_spork delete();
    if (isdefined(self.var_4d48cfd0)) {
        stopfx(localclientnum, self.var_4d48cfd0);
    }
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 7, eflags: 0x0
// Checksum 0x2d976a13, Offset: 0xa28
// Size: 0x462
function function_26fce438(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    hitoffset = (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5));
    switch (newval) {
    case 1:
        var_ab35e326 = struct::get("s_metal_01", "targetname");
        var_63d847f5 = struct::get(var_ab35e326.target, "targetname");
        force_vector = var_63d847f5.origin - var_ab35e326.origin;
        var_98e7c0e0 = vectornormalize(force_vector);
        var_9c1ffd03 = createdynentandlaunch(localclientnum, var_ab35e326.model, var_ab35e326.origin, var_ab35e326.angles, hitoffset, 4 * var_98e7c0e0);
        break;
    case 2:
        var_ab35e326 = struct::get("s_metal_02", "targetname");
        var_63d847f5 = struct::get(var_ab35e326.target, "targetname");
        force_vector = var_63d847f5.origin - var_ab35e326.origin;
        var_98e7c0e0 = vectornormalize(force_vector);
        var_2a188dc8 = createdynentandlaunch(localclientnum, var_ab35e326.model, var_ab35e326.origin, var_ab35e326.angles, hitoffset, 4 * var_98e7c0e0);
        break;
    case 3:
        var_ab35e326 = struct::get("s_metal_03", "targetname");
        var_63d847f5 = struct::get(var_ab35e326.target, "targetname");
        force_vector = var_63d847f5.origin - var_ab35e326.origin;
        var_98e7c0e0 = vectornormalize(force_vector);
        var_501b0831 = createdynentandlaunch(localclientnum, var_ab35e326.model, var_ab35e326.origin, var_ab35e326.angles, hitoffset, 4 * var_98e7c0e0);
        break;
    case 4:
        var_ab35e326 = struct::get("s_metal_04", "targetname");
        var_63d847f5 = struct::get(var_ab35e326.target, "targetname");
        force_vector = var_63d847f5.origin - var_ab35e326.origin;
        var_98e7c0e0 = vectornormalize(force_vector);
        var_e276c3e = createdynentandlaunch(localclientnum, var_ab35e326.model, var_ab35e326.origin, var_ab35e326.angles, hitoffset, 4 * var_98e7c0e0);
        break;
    }
}

