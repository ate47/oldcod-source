#using script_1cc417743d7c262d;
#using script_396f7d71538c9677;
#using script_4721de209091b1a6;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\planemortar_shared;
#using scripts\killstreaks\zm\airsupport;
#using scripts\zm_common\zm_player;

#namespace planemortar;

// Namespace planemortar/planemortar
// Params 0, eflags: 0x6
// Checksum 0x9625bd8f, Offset: 0x220
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"planemortar", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x5 linked
// Checksum 0xd2effedb, Offset: 0x270
// Size: 0xd4
function private function_70a657d8() {
    init_shared();
    clientfield::register("scriptmover", "planemortar_marker_on", 1, 1, "int");
    bundlename = "killstreak_planemortar" + "_zm";
    killstreaks::register_killstreak(bundlename, &function_d022334c);
    level.plane_mortar_bda_dialog = &plane_mortar_bda_dialog;
    level.var_269fec2 = &function_269fec2;
    zm_player::register_player_damage_callback(&function_5e7e3e86);
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x1 linked
// Checksum 0x954efe29, Offset: 0x350
// Size: 0x26
function function_269fec2() {
    if (isdefined(level.var_30264985)) {
        self notify(#"mortarradarused");
    }
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x1 linked
// Checksum 0xca27a17e, Offset: 0x380
// Size: 0x1de
function plane_mortar_bda_dialog() {
    if (isdefined(self.planemortarbda)) {
        if (self.planemortarbda === 1) {
            bdadialog = "kill1";
            killconfirmed = "killConfirmed1_p";
        } else if (self.planemortarbda === 2) {
            bdadialog = "kill2";
            killconfirmed = "killConfirmed2_p";
        } else if (self.planemortarbda === 3) {
            bdadialog = "kill3";
            killconfirmed = "killConfirmed3_p";
        } else if (isdefined(self.planemortarbda) && self.planemortarbda > 3) {
            bdadialog = "killMultiple";
            killconfirmed = "killConfirmedMult_p";
        }
        self namespace_f9b02f80::play_pilot_dialog(bdadialog, "planemortar", undefined, self.planemortarpilotindex);
        if (battlechatter::dialog_chance("taacomPilotKillConfirmChance")) {
            self namespace_f9b02f80::play_taacom_dialog_response(killconfirmed, "planemortar", undefined, self.planemortarpilotindex);
        } else {
            self namespace_f9b02f80::play_taacom_dialog_response("hitConfirmed_p", "planemortar", undefined, self.planemortarpilotindex);
        }
        globallogic_audio::play_taacom_dialog("confirmHit");
    } else {
        namespace_f9b02f80::play_pilot_dialog("killNone", "planemortar", undefined, self.planemortarpilotindex);
        globallogic_audio::play_taacom_dialog("confirmMiss");
    }
    self.planemortarbda = undefined;
}

// Namespace planemortar/planemortar
// Params 1, eflags: 0x1 linked
// Checksum 0x2809a54b, Offset: 0x568
// Size: 0x6a
function function_d022334c(hardpointtype) {
    if (self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
        return 0;
    }
    result = self function_9480de5f();
    return is_true(result);
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x1 linked
// Checksum 0x3020fdc, Offset: 0x5e0
// Size: 0x174
function function_9480de5f() {
    self endon(#"disconnect");
    s_params = killstreaks::get_script_bundle("planemortar");
    var_2558cb51 = array("planemortar_complete", "planemortar_failed");
    self namespace_bf7415ae::function_890b3889(s_params.var_fc0c8eae, 2500, &function_92c6373d, &function_ccf02f24, var_2558cb51);
    s_location = self namespace_bf7415ae::function_be6de952();
    if (isdefined(s_location)) {
        killstreak_id = self killstreakrules::killstreakstart("planemortar", self.team, 0, 1);
        if (killstreak_id == -1) {
            self notify(#"planemortar_failed");
            return false;
        }
        self thread function_9dea13ff(killstreak_id);
        self thread function_8f181838(s_params, s_location.origin);
        return true;
    }
    return false;
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x5 linked
// Checksum 0xaded31be, Offset: 0x760
// Size: 0x24
function private function_92c6373d() {
    self clientfield::set("planemortar_marker_on", 1);
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x5 linked
// Checksum 0xca332844, Offset: 0x790
// Size: 0x24
function private function_ccf02f24() {
    self clientfield::set("planemortar_marker_on", 0);
}

// Namespace planemortar/planemortar
// Params 1, eflags: 0x5 linked
// Checksum 0x86936a6f, Offset: 0x7c0
// Size: 0x5c
function private function_9dea13ff(killstreakid) {
    self waittill(#"disconnect", #"planemortar_complete");
    self killstreakrules::killstreakstop("planemortar", self.team, killstreakid);
}

// Namespace planemortar/planemortar
// Params 2, eflags: 0x5 linked
// Checksum 0x315b3df, Offset: 0x828
// Size: 0x236
function private function_8f181838(params, targetposition) {
    self endon(#"disconnect");
    if (isdefined(params.var_675bebb2)) {
        wait params.var_675bebb2;
    }
    n_yaw = randomintrange(0, 360);
    for (i = 0; i < 15; i++) {
        if (i != 0) {
            n_interval = randomfloatrange(0.5, 2);
            wait n_interval;
        }
        n_radius = 500 * randomfloat(1);
        n_angle = randomintrange(0, 360);
        v_position = targetposition + (n_radius * cos(n_angle), n_radius * sin(n_angle), 0);
        var_86f8b2c9 = (0, 0, getheliheightlockheight(v_position));
        a_trace = groundtrace(v_position + var_86f8b2c9, v_position - var_86f8b2c9, 1, undefined);
        var_5acfe25f = a_trace[#"position"];
        self thread function_83e61117(var_5acfe25f, n_yaw);
    }
    n_length = scene::function_12479eba(#"p9_fxanim_mp_planemortar_01_bundle");
    wait n_length + 0.5;
    self notify(#"planemortar_complete");
}

// Namespace planemortar/planemortar
// Params 10, eflags: 0x5 linked
// Checksum 0xa907a89f, Offset: 0xa68
// Size: 0x8c
function private function_5e7e3e86(*einflictor, eattacker, *idamage, *idflags, *smeansofdeath, weapon, *vpoint, *vdir, *shitloc, *psoffsettime) {
    if (shitloc === self && psoffsettime == getweapon("planemortar")) {
        return 20;
    }
    return -1;
}

