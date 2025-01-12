#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace zm_zodt8_tutorial;

// Namespace zm_zodt8_tutorial/level_init
// Params 1, eflags: 0x40
// Checksum 0xeba6dc10, Offset: 0x250
// Size: 0x3bc
function event_handler[level_init] main(eventstruct) {
    if (util::get_game_type() != "ztutorial") {
        return;
    }
    clientfield::register("actor", "tutorial_keyline_fx", 1, 2, "int", &tutorial_fx, 0, 0);
    clientfield::register("zbarrier", "tutorial_keyline_fx", 1, 2, "int", &function_cfb9537c, 0, 0);
    clientfield::register("item", "tutorial_keyline_fx", 1, 2, "int", &tutorial_fx, 0, 0);
    clientfield::register("scriptmover", "tutorial_keyline_fx", 1, 2, "int", &tutorial_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_1b509b0ba634a25a", 1, 1, "int", &function_bd49fd40, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_1390e08de02cbdc7", 1, 1, "int", &function_c913f7d3, 0, 0);
    clientfield::register("worlduimodel", "hudItems.ztut.showLocation", 1, 1, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hudItems.ztut.showPerks", 1, 1, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hudItems.ztut.showEquipment", 1, 1, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hudItems.ztut.showShield", 1, 1, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hudItems.ztut.showSpecial", 1, 1, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "hudItems.ztut.showElixirs", 1, 1, "int", undefined, 0, 0);
    level._effect[#"hash_1b509b0ba634a25a"] = #"zombie/fx_ritual_barrier_defend_door_wide_zod_zmb";
    level._effect[#"hash_1390e08de02cbdc7"] = #"hash_5b773dbbac0012ff";
    level thread function_f354d24a();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xff4ad4a3, Offset: 0x618
// Size: 0x134
function function_f354d24a() {
    wait 5;
    for (i = 0; i < 4; i++) {
        mdl_icon = getent(0, "altar_icon_" + i, "targetname");
        switch (i) {
        case 0:
            mdl_icon setmodel("p8_zm_vapor_altar_icon_01_staminup");
            break;
        case 1:
            mdl_icon setmodel("p8_zm_vapor_altar_icon_01_bandolierbandit");
            break;
        case 2:
            mdl_icon setmodel("p8_zm_vapor_altar_icon_01_timeslip");
            break;
        case 3:
            mdl_icon setmodel("p8_zm_vapor_altar_icon_01_deadshot");
            break;
        }
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 7, eflags: 0x0
// Checksum 0x4e3d70b9, Offset: 0x758
// Size: 0x154
function tutorial_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self playrenderoverridebundle(#"hash_2ef4d8e5fdbc8a08");
        if (self.model == "p8_fxanim_zm_vapor_altar_zeus_mod") {
            mdl_bird = getent(0, "zeus_bird_head", "targetname");
            mdl_bird playrenderoverridebundle(#"hash_2ef4d8e5fdbc8a08");
        }
        return;
    }
    if (newval == 2) {
        self stoprenderoverridebundle(#"hash_2ef4d8e5fdbc8a08");
        if (self.model == "p8_fxanim_zm_vapor_altar_zeus_mod") {
            mdl_bird = getent(0, "zeus_bird_head", "targetname");
            mdl_bird stoprenderoverridebundle(#"hash_2ef4d8e5fdbc8a08");
        }
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 7, eflags: 0x0
// Checksum 0x24eaa9da, Offset: 0x8b8
// Size: 0x13e
function function_cfb9537c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        n_pieces = self getnumzbarrierpieces();
        for (n_index = 0; n_index < n_pieces; n_index++) {
            e_piece = self zbarriergetpiece(n_index);
            e_piece playrenderoverridebundle(#"hash_2ef4d8e5fdbc8a08");
        }
        return;
    }
    if (newval == 2) {
        n_pieces = self getnumzbarrierpieces();
        for (n_index = 0; n_index < n_pieces; n_index++) {
            e_piece = self zbarriergetpiece(n_index);
            e_piece stoprenderoverridebundle(#"hash_2ef4d8e5fdbc8a08");
        }
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 7, eflags: 0x0
// Checksum 0x2096780b, Offset: 0xa00
// Size: 0xba
function function_bd49fd40(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_6406d61f)) {
        stopfx(localclientnum, self.var_6406d61f);
        self.var_6406d61f = undefined;
    }
    if (newval == 1) {
        self.var_6406d61f = util::playfxontag(localclientnum, level._effect[#"hash_1b509b0ba634a25a"], self, "tag_origin");
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 7, eflags: 0x0
// Checksum 0x6fc4418f, Offset: 0xac8
// Size: 0xdc
function function_c913f7d3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        v_forward = anglestoforward(self.angles);
        self.blocker_fx = playfx(localclientnum, level._effect[#"hash_1390e08de02cbdc7"], self.origin, v_forward);
        return;
    }
    if (isdefined(self.blocker_fx)) {
        stopfx(localclientnum, self.blocker_fx);
    }
}

