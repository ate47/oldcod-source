#using script_4e53735256f112ac;
#using script_d67878983e3d7c;
#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_32e85820;

// Namespace namespace_32e85820/namespace_32e85820
// Params 0, eflags: 0x6
// Checksum 0x7b4e65c3, Offset: 0x1c0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_36a2cb0be45d9374", &function_70a657d8, undefined, undefined, #"hash_13a43d760497b54d");
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 0, eflags: 0x5 linked
// Checksum 0x136a4857, Offset: 0x210
// Size: 0xdc
function private function_70a657d8() {
    clientfield::register("toplayer", "fx_heal_aoe_player_clientfield", 1, 1, "counter", &function_813dcaec, 1, 0);
    clientfield::register("scriptmover", "fx_heal_aoe_bubble_clientfield", 1, 1, "int", &function_4d38c566, 1, 0);
    clientfield::register("scriptmover", "fx_heal_aoe_bubble_beam_clientfield", 1, 1, "int", &function_456c29d0, 1, 0);
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 7, eflags: 0x1 linked
// Checksum 0x90659ef, Offset: 0x2f8
// Size: 0x74
function function_456c29d0(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self thread function_93b178ae();
        self thread function_952f1795(fieldname);
    }
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 7, eflags: 0x1 linked
// Checksum 0x169929cd, Offset: 0x378
// Size: 0xa4
function function_4d38c566(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self.var_e648d182 = self playloopsound(#"hash_10d90ad6f03be83e");
        function_239993de(fieldname, "zm_weapons/fx9_fld_healing_aura_lvl5_3p", self, "tag_origin");
        self thread function_93b178ae();
    }
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 7, eflags: 0x1 linked
// Checksum 0x676136a6, Offset: 0x428
// Size: 0x7c
function function_813dcaec(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isplayer(self)) {
        function_239993de(bwastimejump, "zm_weapons/fx9_fld_healing_aura_pulse_tgt", self, "j_spine4");
    }
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 0, eflags: 0x1 linked
// Checksum 0x626d0d91, Offset: 0x4b0
// Size: 0x4c
function function_93b178ae() {
    level endon(#"game_ended");
    self endon(#"death");
    wait 10;
    self delete();
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 1, eflags: 0x1 linked
// Checksum 0xd4e8e60b, Offset: 0x508
// Size: 0x2e
function function_a4b3da97(trace) {
    if (trace[#"fraction"] < 1) {
        return false;
    }
    return true;
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 1, eflags: 0x1 linked
// Checksum 0x4a921e69, Offset: 0x540
// Size: 0x1aa
function function_952f1795(localclientnum) {
    self endon(#"death");
    while (true) {
        foreach (player in getplayers(localclientnum)) {
            if (distance2d(self.origin, player.origin) < 256) {
                beamname = "beam9_zm_fld_healing_aura_pulse";
                pos = self.origin;
                otherpos = player.origin;
                trace = beamtrace(pos, otherpos, 1, self, 1);
                if (self function_a4b3da97(trace)) {
                    beam_id = self beam::launch(self, "tag_origin", player, "j_spine4", beamname);
                    level thread function_d7031739(localclientnum, beam_id);
                }
            }
        }
        wait 1;
    }
}

// Namespace namespace_32e85820/namespace_32e85820
// Params 2, eflags: 0x1 linked
// Checksum 0xf0798e3b, Offset: 0x6f8
// Size: 0x4c
function function_d7031739(localclientnum, beamid) {
    level endon(#"game_ended");
    wait 1;
    beam::function_47deed80(localclientnum, beamid);
}

