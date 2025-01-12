#using script_442f1042340e6bf1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_sq_modules;

#namespace namespace_d17fd4ae;

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 0, eflags: 0x0
// Checksum 0x6d5e757d, Offset: 0xc0
// Size: 0x284
function init() {
    level._effect[#"soul_fx"] = #"zombie/fx_trail_blood_soul_zmb";
    level._effect[#"hash_169b53a5e4572fdc"] = #"hash_6dbaf2955bfc8971";
    level._effect[#"clue_fx"] = #"zombie/fx_ritual_glow_relic_zod_zmb";
    level._effect[#"despawn_fx"] = #"hash_73a1b4258b95cb4a";
    a_s_chests = struct::get_array(#"hash_396f65af88a25e7d");
    foreach (s_chest in a_s_chests) {
        zm_sq_modules::function_8ab612a3(s_chest.script_noteworthy, 1, s_chest.script_noteworthy, 400, level._effect[#"soul_fx"], level._effect[#"hash_169b53a5e4572fdc"]);
    }
    level.heldconcentratetext = zm_zod_wonderweapon_quest::register("heldConcentrateText");
    clientfield::register("scriptmover", "" + #"clue_fx", 1, 1, "int", &clue_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"despawn_fx", 1, 1, "int", &despawn_fx, 0, 0);
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 7, eflags: 0x0
// Checksum 0x2b369af5, Offset: 0x350
// Size: 0x6c
function despawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self callback::on_shutdown(&function_8c14b9e8);
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x0
// Checksum 0xe8ab49d5, Offset: 0x3c8
// Size: 0x8c
function function_8c14b9e8(localclientnum) {
    if (isdefined(self)) {
        playfx(localclientnum, level._effect[#"despawn_fx"], self.origin + (0, 0, 32), anglestoforward(self.angles), anglestoup(self.angles));
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 7, eflags: 0x0
// Checksum 0x614ead74, Offset: 0x460
// Size: 0xbc
function clue_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_38dd65af = playfx(localclientnum, level._effect[#"clue_fx"], self.origin - (0, 0, 6));
        self callback::on_shutdown(&function_c448fd63);
    }
}

// Namespace namespace_d17fd4ae/namespace_7f0b76a
// Params 1, eflags: 0x0
// Checksum 0x912d6bf5, Offset: 0x528
// Size: 0x34
function function_c448fd63(localclientnum) {
    if (isdefined(self.var_38dd65af)) {
        killfx(localclientnum, self.var_38dd65af);
    }
}

