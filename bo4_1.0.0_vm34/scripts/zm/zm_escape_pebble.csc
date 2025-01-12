#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_escape_pebble;

// Namespace zm_escape_pebble/zm_escape_pebble
// Params 0, eflags: 0x2
// Checksum 0x30a5aad, Offset: 0x128
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_escape_pebble", &__init__, undefined, undefined);
}

// Namespace zm_escape_pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x8562e619, Offset: 0x170
// Size: 0x3b2
function __init__() {
    clientfield::register("actor", "" + #"hash_7792af358100c735", 1, 1, "int", &function_7d469582, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_92008cb81480da0", 1, 1, "int", &function_b2fcb911, 0, 0);
    clientfield::register("toplayer", "" + #"hash_f2d0b920043dbbd", 1, 1, "counter", &function_165c92c9, 0, 0);
    clientfield::register("world", "" + #"attic_room", 1, 1, "int", &attic_room, 0, 0);
    clientfield::register("world", "" + #"narrative_room", 1, 1, "int", &narrative_room, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_46dbc12bdc275121", 1, 1, "int", &glyph_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_59623b8b4fc694c8", 1, 2, "int", &function_de6f445e, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_ce418c45d804842", 1, 1, "counter", &function_8a83e23f, 0, 0);
    level._effect[#"hash_7184fc7d78dcf1c0"] = #"hash_73000f9a6abd5658";
    level._effect[#"hash_20080a107a8533e"] = #"hash_7965ec9e0938553f";
    level._effect[#"walnut_teleport"] = #"hash_2844b7026fd0f451";
    level._effect[#"hash_7792af358100c735"] = #"hash_3d18884453d39646";
    level._effect[#"light_red"] = #"hash_6fdf0d26a4ab7a7";
}

// Namespace zm_escape_pebble/zm_escape_pebble
// Params 7, eflags: 0x0
// Checksum 0x6e0ed126, Offset: 0x530
// Size: 0x84
function function_165c92c9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self thread postfx::playpostfxbundle(#"hash_114ea20734e794cf");
    playsound(localclientnum, #"hash_307805bbe1d946b", (0, 0, 0));
}

// Namespace zm_escape_pebble/zm_escape_pebble
// Params 7, eflags: 0x0
// Checksum 0xa3b8a73e, Offset: 0x5c0
// Size: 0x1a2
function function_b2fcb911(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self stoprenderoverridebundle("rob_skull_grab");
    if (isdefined(self.var_cc96ab43)) {
        self stoploopsound(self.var_cc96ab43);
        self.var_cc96ab43 = undefined;
    }
    if (newval) {
        self playrenderoverridebundle(#"hash_68ee9247aaae4517");
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Brightness", 1);
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Alpha", 1);
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1);
        self playsound(localclientnum, #"hash_11be55c692103bd");
        if (!isdefined(self.var_cc96ab43)) {
            self.var_cc96ab43 = self playloopsound(#"hash_6d59947a89f48b03");
        }
    }
}

// Namespace zm_escape_pebble/zm_escape_pebble
// Params 7, eflags: 0x0
// Checksum 0x4cb8922c, Offset: 0x770
// Size: 0x74
function function_7d469582(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"hash_7792af358100c735"], self, "j_spine_4");
}

// Namespace zm_escape_pebble/zm_escape_pebble
// Params 7, eflags: 0x0
// Checksum 0xacd90f31, Offset: 0x7f0
// Size: 0x84
function narrative_room(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        function_a419c9f1(localclientnum, "broom_closet");
        return;
    }
    function_9fb45cd8(localclientnum, "broom_closet");
}

// Namespace zm_escape_pebble/zm_escape_pebble
// Params 7, eflags: 0x0
// Checksum 0x5ada721e, Offset: 0x880
// Size: 0x84
function attic_room(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        function_a419c9f1(localclientnum, "back_room");
        return;
    }
    function_9fb45cd8(localclientnum, "back_room");
}

// Namespace zm_escape_pebble/zm_escape_pebble
// Params 7, eflags: 0x0
// Checksum 0x6eacd0f8, Offset: 0x910
// Size: 0x74
function glyph_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"hash_7184fc7d78dcf1c0"], self, "tag_origin");
}

// Namespace zm_escape_pebble/zm_escape_pebble
// Params 7, eflags: 0x0
// Checksum 0x370a3c8a, Offset: 0x990
// Size: 0x1c6
function function_de6f445e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_3c864e23 = util::playfxontag(localclientnum, level._effect[#"light_red"], self, "tag_eye_rt");
        self.var_a208ea66 = util::playfxontag(localclientnum, level._effect[#"light_red"], self, "tag_eye_lt");
        return;
    }
    if (newval == 2) {
        self.var_9629249d = util::playfxontag(localclientnum, level._effect[#"hash_20080a107a8533e"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_3c864e23)) {
        killfx(localclientnum, self.var_3c864e23);
        self.var_3c864e23 = undefined;
    }
    if (isdefined(self.var_a208ea66)) {
        killfx(localclientnum, self.var_a208ea66);
        self.var_a208ea66 = undefined;
    }
    if (isdefined(self.var_9629249d)) {
        stopfx(localclientnum, self.var_9629249d);
        self.var_9629249d = undefined;
    }
}

// Namespace zm_escape_pebble/zm_escape_pebble
// Params 7, eflags: 0x0
// Checksum 0x1a845a2b, Offset: 0xb60
// Size: 0x74
function function_8a83e23f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"walnut_teleport"], self, "tag_origin");
}

