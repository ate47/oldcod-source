#using script_324d329b31b9b4ec;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_bundles;

#namespace swat_team;

// Namespace swat_team/swat_team
// Params 0, eflags: 0x2
// Checksum 0xe75d0004, Offset: 0x1c8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"swat_team", &__init__, undefined, #"killstreaks");
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x0
// Checksum 0x18a6bd27, Offset: 0x218
// Size: 0x19c
function __init__() {
    ir_strobe::init_shared();
    bundle = struct::get_script_bundle("killstreak", "killstreak_swat_team");
    ai::add_archetype_spawn_function("human", &spawned, bundle);
    clientfield::register("actor", "swat_light_strobe", 1, 1, "int", &function_42438124, 0, 0);
    clientfield::register("actor", "swat_shocked", 1, 1, "int", &function_13edaef6, 0, 0);
    clientfield::register("vehicle", "swat_helicopter_death_fx", 1, getminbitcountfornum(2), "int", &function_13c97741, 0, 0);
    clientfield::register("actor", "swat_rob_state", 1, 1, "int", &function_addad1a3, 0, 0);
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x0
// Checksum 0x49e19a2f, Offset: 0x3c0
// Size: 0x2c
function spawned(local_client_num, bundle) {
    self killstreak_bundles::spawned(local_client_num, bundle);
}

// Namespace swat_team/swat_team
// Params 7, eflags: 0x0
// Checksum 0xd9d2d004, Offset: 0x3f8
// Size: 0x8c
function function_13c97741(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        forward = self.origin + (0, 0, 1) - self.origin;
        playfx(localclientnum, "killstreaks/fx_heli_exp_lg", self.origin, forward);
    }
}

// Namespace swat_team/swat_team
// Params 7, eflags: 0x0
// Checksum 0x11084381, Offset: 0x490
// Size: 0x94
function function_42438124(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        util::playfxontag(localclientnum, "light/fx8_light_plyr_strobe", self, "tag_char_vis_light_strobe_01");
        util::playfxontag(localclientnum, "light/fx8_light_plyr_strobe", self, "tag_char_vis_light_strobe_02");
    }
}

// Namespace swat_team/swat_team
// Params 7, eflags: 0x0
// Checksum 0x9fd5821e, Offset: 0x530
// Size: 0xa4
function function_13edaef6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_17dd02d3 = util::playfxontag(localclientnum, "player/fx8_plyr_shocked_3p", self, "j_spineupper");
        return;
    }
    if (isdefined(self.var_17dd02d3)) {
        stopfx(localclientnum, self.var_17dd02d3);
    }
}

// Namespace swat_team/swat_team
// Params 7, eflags: 0x4
// Checksum 0x4c6c8baa, Offset: 0x5e0
// Size: 0xbc
function private function_addad1a3(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        if (self flag::exists(#"friendly")) {
            self renderoverridebundle::stop_bundle(#"friendly", sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp");
        }
    }
}

