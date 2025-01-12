#using script_312c65d6c946308;
#using scripts\core_common\aat_shared;
#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lightning_chain;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ammomod_deadwire;

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 0, eflags: 0x1 linked
// Checksum 0xde3de40d, Offset: 0x270
// Size: 0x264
function function_af1f180() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("ammomod_deadwire", #"zmui/zm_ammomod_deadwire", "t7_icon_zm_aat_dead_wire");
    aat::register("ammomod_deadwire_1", #"zmui/zm_ammomod_deadwire", "t7_icon_zm_aat_dead_wire");
    aat::register("ammomod_deadwire_2", #"zmui/zm_ammomod_deadwire", "t7_icon_zm_aat_dead_wire");
    aat::register("ammomod_deadwire_3", #"zmui/zm_ammomod_deadwire", "t7_icon_zm_aat_dead_wire");
    aat::register("ammomod_deadwire_4", #"zmui/zm_ammomod_deadwire", "t7_icon_zm_aat_dead_wire");
    aat::register("ammomod_deadwire_5", #"zmui/zm_ammomod_deadwire", "t7_icon_zm_aat_dead_wire");
    clientfield::register("actor", "zm_ammomod_deadwire_explosion", 1, 1, "counter", &function_4e26277b, 0, 0);
    clientfield::register("vehicle", "zm_ammomod_deadwire_explosion", 1, 1, "counter", &function_4e26277b, 0, 0);
    clientfield::register("actor", "zm_ammomod_deadwire_zap", 1, 4, "int", &zm_ammomod_deadwire_zap, 0, 0);
    clientfield::register("vehicle", "zm_ammomod_deadwire_zap", 1, 4, "int", &zm_ammomod_deadwire_zap, 0, 0);
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 7, eflags: 0x1 linked
// Checksum 0xab9bed03, Offset: 0x4e0
// Size: 0x206
function zm_ammomod_deadwire_zap(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        str_fx_tag = isdefined(self gettagorigin("j_spine4")) ? "j_spine4" : "tag_origin";
        if (bwastimejump >= 5) {
            self.var_5900d892 = util::playfxontag(fieldname, "zm_weapons/fx9_aat_dead_wire_lvl5_aoe", self, str_fx_tag);
        } else if (bwastimejump >= 1 && bwastimejump < 5) {
            self.var_5900d892 = util::playfxontag(fieldname, "zm_weapons/fx9_aat_dead_wire_lvl2_aoe", self, str_fx_tag);
        }
        self.var_43835d52 = util::playfxontag(fieldname, "zm_weapons/fx9_aat_dead_wire_lvl1_stun", self, str_fx_tag);
        if (!isdefined(self.var_8d3dbdcc)) {
            self.var_8d3dbdcc = self playloopsound("zmb_aat_kilowatt_stunned_lp");
        }
        return;
    }
    if (isdefined(self.var_43835d52)) {
        stopfx(fieldname, self.var_43835d52);
        self.var_43835d52 = undefined;
    }
    if (isdefined(self.var_5900d892)) {
        stopfx(fieldname, self.var_5900d892);
        self.var_5900d892 = undefined;
    }
    if (isdefined(self.var_8d3dbdcc)) {
        self stoploopsound(self.var_8d3dbdcc);
        self.var_8d3dbdcc = undefined;
    }
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 7, eflags: 0x1 linked
// Checksum 0x868492f1, Offset: 0x6f0
// Size: 0x94
function function_4e26277b(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isalive(self)) {
        self thread function_d84b2bab(bwastimejump);
        self playsound(bwastimejump, #"zmb_aat_kilowatt_explode");
    }
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 1, eflags: 0x1 linked
// Checksum 0x4b821db0, Offset: 0x790
// Size: 0x2e
function function_a4b3da97(trace) {
    if (trace[#"fraction"] < 1) {
        return false;
    }
    return true;
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 1, eflags: 0x1 linked
// Checksum 0x2502e8ef, Offset: 0x7c8
// Size: 0x2a0
function function_d84b2bab(localclientnum) {
    player = function_5c10bd79(localclientnum);
    n_range = player namespace_e86ffa8::function_cd6787b(localclientnum, 2) ? 512 : 256;
    zombies = getentitiesinradius(localclientnum, self.origin, n_range, 15);
    waittime = float(150) / 1000;
    beamname = "beam9_zm_aat_dead_wire_arc";
    pos = (self.origin[0], self.origin[1], self.origin[2] + 50);
    foreach (zombie in zombies) {
        if (distance2d(self.origin, zombie.origin) < n_range && isalive(zombie)) {
            otherpos = zombie.origin;
            trace = beamtrace(pos, otherpos, 1, self, 1);
            str_fx_tag = isdefined(self gettagorigin("j_spine4")) ? "j_spine4" : "tag_origin";
            if (self function_a4b3da97(trace)) {
                beam_id = self beam::launch(self, str_fx_tag, zombie, str_fx_tag, beamname);
                level thread function_149bbdd9(localclientnum, waittime, beam_id);
            }
        }
    }
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 3, eflags: 0x1 linked
// Checksum 0xd1d92d98, Offset: 0xa70
// Size: 0x54
function function_149bbdd9(localclientnum, waittime, beam_id) {
    level endon(#"game_ended");
    wait waittime;
    self beam::function_47deed80(localclientnum, beam_id);
}

