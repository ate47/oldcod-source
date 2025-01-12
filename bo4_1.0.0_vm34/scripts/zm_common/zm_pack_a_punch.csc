#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_pack_a_punch;

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x2
// Checksum 0x9bab2139, Offset: 0xf0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_pack_a_punch", &__init__, undefined, undefined);
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x1dc612a2, Offset: 0x138
// Size: 0x4c
function __init__() {
    clientfield::register("zbarrier", "pap_working_fx", 1, 1, "int", &pap_working_fx_handler, 0, 0);
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 7, eflags: 0x0
// Checksum 0x4cbc96e6, Offset: 0x190
// Size: 0xd4
function pap_working_fx_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        pap_play_fx(localclientnum, 0, "base_jnt");
        return;
    }
    if (isdefined(self.n_pap_fx)) {
        stopfx(localclientnum, self.n_pap_fx);
        self.n_pap_fx = undefined;
    }
    wait 1;
    if (isdefined(self.mdl_fx)) {
        self.mdl_fx delete();
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 3, eflags: 0x4
// Checksum 0xa53849f5, Offset: 0x270
// Size: 0x152
function private pap_play_fx(localclientnum, n_piece_index, str_tag) {
    mdl_piece = self zbarriergetpiece(n_piece_index);
    if (isdefined(self.mdl_fx)) {
        self.mdl_fx delete();
    }
    if (isdefined(self.n_pap_fx)) {
        deletefx(localclientnum, self.n_pap_fx);
        self.n_pap_fx = undefined;
    }
    self.mdl_fx = util::spawn_model(localclientnum, "tag_origin", mdl_piece gettagorigin(str_tag), mdl_piece gettagangles(str_tag));
    self.mdl_fx linkto(mdl_piece, str_tag);
    self.n_pap_fx = util::playfxontag(localclientnum, level._effect[#"pap_working_fx"], self.mdl_fx, "tag_origin");
}

