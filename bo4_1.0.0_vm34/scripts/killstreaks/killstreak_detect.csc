#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_bundles;

#namespace killstreak_detect;

// Namespace killstreak_detect/killstreak_detect
// Params 0, eflags: 0x0
// Checksum 0xbfaf60ad, Offset: 0x148
// Size: 0x29c
function init_shared() {
    if (!isdefined(level.var_d8276f73)) {
        level.var_d8276f73 = {};
        callback::on_localplayer_spawned(&watch_killstreak_detect_perks_changed);
        clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int", &enemyscriptmovervehicle_changed, 0, 0);
        clientfield::register("vehicle", "enemyvehicle", 1, 2, "int", &enemyvehicle_changed, 0, 1);
        clientfield::register("missile", "enemyvehicle", 1, 2, "int", &enemymissilevehicle_changed, 0, 1);
        clientfield::register("actor", "enemyvehicle", 1, 2, "int", &function_ddf75f5f, 0, 1);
        clientfield::register("vehicle", "vehicletransition", 1, 1, "int", &vehicle_transition, 0, 1);
        if (!isdefined(level.enemyvehicles)) {
            level.enemyvehicles = [];
        }
        if (!isdefined(level.enemymissiles)) {
            level.enemymissiles = [];
        }
        if (!isdefined(level.var_d64bf9b9)) {
            level.var_d64bf9b9 = [];
        }
        function_296548cf(level.killstreakcorebundle);
        level.emp_killstreaks = [];
        renderoverridebundle::function_9f4eff5e(#"hash_7d4b6b0d84ddafa3", #"friendly", sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp", &function_cdf4de3a);
    }
}

// Namespace killstreak_detect/killstreak_detect
// Params 3, eflags: 0x0
// Checksum 0x4780517, Offset: 0x3f0
// Size: 0xde
function function_cdf4de3a(local_client_num, bundle, param) {
    if (!self function_31d3dfec()) {
        return false;
    }
    if (!(isdefined(level.friendlycontentoutlines) && level.friendlycontentoutlines)) {
        return false;
    }
    if (function_d224c0e6(local_client_num)) {
        return false;
    }
    if (self.type === "vehicle" && self function_2a8c9709()) {
        return false;
    }
    if (isdefined(level.vision_pulse[local_client_num]) && level.vision_pulse[local_client_num]) {
        return false;
    }
    return true;
}

// Namespace killstreak_detect/killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0xbcbe10e5, Offset: 0x4d8
// Size: 0xc6
function function_ba27f1db(local_client_num, bundle) {
    if (self function_31d3dfec()) {
        return false;
    }
    if (function_d224c0e6(local_client_num)) {
        return false;
    }
    if (self.type === "vehicle" && self function_2a8c9709()) {
        return false;
    }
    if (isdefined(self.isbreachingfirewall) && self.isbreachingfirewall == 1) {
        return false;
    }
    if (function_24e25118(local_client_num, #"specialty_showenemyvehicles")) {
        return true;
    }
    return false;
}

// Namespace killstreak_detect/killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0x1220c65d, Offset: 0x5a8
// Size: 0x164
function function_73288224(local_client_num, newval) {
    bundle = self killstreak_bundles::function_bf8322cd();
    if (!isdefined(bundle)) {
        bundle = level.killstreakcorebundle;
    }
    if (isdefined(bundle)) {
        show_friendly = bundle.("ksROBShowFriendly");
        if (isdefined(show_friendly) && show_friendly) {
            self renderoverridebundle::function_15e70783(local_client_num, #"friendly", bundle.var_e409027f + "friendly");
        }
        show_enemy = bundle.("ksROBShowEnemy");
        if (isdefined(show_enemy) && show_enemy) {
            self renderoverridebundle::function_15e70783(local_client_num, #"enemy", bundle.var_e409027f + "enemy");
        }
        return;
    }
    self renderoverridebundle::function_15e70783(local_client_num, #"friendly", #"hash_7d4b6b0d84ddafa3");
}

// Namespace killstreak_detect/killstreak_detect
// Params 7, eflags: 0x0
// Checksum 0x61dc6b2f, Offset: 0x718
// Size: 0x54
function vehicle_transition(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_73288224(local_client_num, newval);
}

// Namespace killstreak_detect/killstreak_detect
// Params 1, eflags: 0x0
// Checksum 0xf19d7b27, Offset: 0x778
// Size: 0x44
function should_set_compass_icon(local_client_num) {
    return self function_55a8b32b() || function_24e25118(local_client_num, #"specialty_showenemyvehicles");
}

// Namespace killstreak_detect/killstreak_detect
// Params 7, eflags: 0x0
// Checksum 0x2cf2e36e, Offset: 0x7c8
// Size: 0xe4
function enemyscriptmovervehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.scriptmovercompassicons) && isdefined(self.model)) {
        if (isdefined(level.scriptmovercompassicons[self.model])) {
            if (self should_set_compass_icon(local_client_num)) {
                self setcompassicon(level.scriptmovercompassicons[self.model]);
            }
        }
    }
    enemyvehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

// Namespace killstreak_detect/killstreak_detect
// Params 7, eflags: 0x0
// Checksum 0xb1ef2d35, Offset: 0x8b8
// Size: 0xe4
function enemymissilevehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.missilecompassicons) && isdefined(self.weapon)) {
        if (isdefined(level.missilecompassicons[self.weapon])) {
            if (self should_set_compass_icon(local_client_num)) {
                self setcompassicon(level.missilecompassicons[self.weapon]);
            }
        }
    }
    enemymissile_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

// Namespace killstreak_detect/killstreak_detect
// Params 7, eflags: 0x0
// Checksum 0x277be203, Offset: 0x9a8
// Size: 0x74
function enemymissile_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self updateteammissiles(local_client_num, newval);
    self util::add_remove_list(level.enemymissiles, newval);
}

// Namespace killstreak_detect/killstreak_detect
// Params 7, eflags: 0x0
// Checksum 0x996b2c8a, Offset: 0xa28
// Size: 0x14a
function enemyvehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self updateteamvehicles(local_client_num, newval);
    self util::add_remove_list(level.enemyvehicles, newval);
    self updateenemyvehicles(local_client_num, newval);
    if (isdefined(self.model) && self.model == "wpn_t7_turret_emp_core" && self.type === "vehicle") {
        if (!isdefined(level.emp_killstreaks)) {
            level.emp_killstreaks = [];
        } else if (!isarray(level.emp_killstreaks)) {
            level.emp_killstreaks = array(level.emp_killstreaks);
        }
        level.emp_killstreaks[level.emp_killstreaks.size] = self;
    }
}

// Namespace killstreak_detect/killstreak_detect
// Params 7, eflags: 0x0
// Checksum 0x5d86a02b, Offset: 0xb80
// Size: 0x74
function function_ddf75f5f(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::add_remove_list(level.var_d64bf9b9, newval);
    self function_9e98b610(local_client_num, newval);
}

// Namespace killstreak_detect/killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0xb4376e20, Offset: 0xc00
// Size: 0x2c
function updateteamvehicles(local_client_num, newval) {
    self checkteamvehicles(local_client_num);
}

// Namespace killstreak_detect/killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0x67d29aea, Offset: 0xc38
// Size: 0x2c
function updateteammissiles(local_client_num, newval) {
    self checkteammissiles(local_client_num);
}

// Namespace killstreak_detect/killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0x55c3a295, Offset: 0xc70
// Size: 0x34
function function_9e98b610(local_client_num, newval) {
    if (!isdefined(self)) {
        return;
    }
    function_73288224(local_client_num, newval);
}

// Namespace killstreak_detect/killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0x4f8e2a16, Offset: 0xcb0
// Size: 0x34
function updateenemyvehicles(local_client_num, newval) {
    if (!isdefined(self)) {
        return;
    }
    function_73288224(local_client_num, newval);
}

// Namespace killstreak_detect/killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0x4e8df308, Offset: 0xcf0
// Size: 0x34
function updateenemymissiles(local_client_num, newval) {
    if (!isdefined(self)) {
        return;
    }
    function_73288224(local_client_num, newval);
}

// Namespace killstreak_detect/killstreak_detect
// Params 1, eflags: 0x0
// Checksum 0x27e30289, Offset: 0xd30
// Size: 0x176
function watch_killstreak_detect_perks_changed(local_client_num) {
    if (!self function_60dbc438()) {
        return;
    }
    self notify(#"watch_killstreak_detect_perks_changed");
    self endon(#"watch_killstreak_detect_perks_changed");
    self endon(#"death");
    self endon(#"disconnect");
    while (isdefined(self)) {
        waitframe(1);
        util::clean_deleted(level.var_d64bf9b9);
        util::clean_deleted(level.enemyvehicles);
        util::clean_deleted(level.enemymissiles);
        array::thread_all(level.var_d64bf9b9, &function_9e98b610, local_client_num, 1);
        array::thread_all(level.enemyvehicles, &updateenemyvehicles, local_client_num, 1);
        array::thread_all(level.enemymissiles, &updateenemymissiles, local_client_num, 1);
        self waittill(#"perks_changed");
    }
}

// Namespace killstreak_detect/killstreak_detect
// Params 1, eflags: 0x0
// Checksum 0x3721f46d, Offset: 0xeb0
// Size: 0x13e
function checkteamvehicles(localclientnum) {
    if (!isdefined(self.owner) || !isdefined(self.owner.team)) {
        return;
    }
    if (!isdefined(self.vehicleoldteam)) {
        self.vehicleoldteam = self.team;
    }
    if (!isdefined(self.vehicleoldownerteam)) {
        self.vehicleoldownerteam = self.owner.team;
    }
    var_71fb4650 = function_98901e1a(localclientnum);
    if (!isdefined(self.vehicleoldwatcherteam)) {
        self.vehicleoldwatcherteam = var_71fb4650;
    }
    if (self.vehicleoldteam != self.team || self.vehicleoldownerteam != self.owner.team || self.vehicleoldwatcherteam != var_71fb4650) {
        self.vehicleoldteam = self.team;
        self.vehicleoldownerteam = self.owner.team;
        self.vehicleoldwatcherteam = var_71fb4650;
        self notify(#"team_changed");
    }
}

// Namespace killstreak_detect/killstreak_detect
// Params 1, eflags: 0x0
// Checksum 0x3e4a450f, Offset: 0xff8
// Size: 0x13e
function checkteammissiles(localclientnum) {
    if (!isdefined(self.owner) || !isdefined(self.owner.team)) {
        return;
    }
    if (!isdefined(self.missileoldteam)) {
        self.missileoldteam = self.team;
    }
    if (!isdefined(self.missileoldownerteam)) {
        self.missileoldownerteam = self.owner.team;
    }
    var_71fb4650 = function_98901e1a(localclientnum);
    if (!isdefined(self.missileoldwatcherteam)) {
        self.missileoldwatcherteam = var_71fb4650;
    }
    if (self.missileoldteam != self.team || self.missileoldownerteam != self.owner.team || self.missileoldwatcherteam != var_71fb4650) {
        self.missileoldteam = self.team;
        self.missileoldownerteam = self.owner.team;
        self.missileoldwatcherteam = var_71fb4650;
        self notify(#"team_changed");
    }
}

// Namespace killstreak_detect/killstreak_detect
// Params 1, eflags: 0x0
// Checksum 0x627c8a0, Offset: 0x1140
// Size: 0xfc
function function_296548cf(bundle) {
    show_friendly = bundle.("ksROBShowFriendly");
    if (isdefined(show_friendly) && show_friendly) {
        renderoverridebundle::function_9f4eff5e(bundle.var_e409027f + "friendly", bundle.("ksROBFriendly"), &function_cdf4de3a);
    }
    show_enemy = bundle.("ksROBShowEnemy");
    if (isdefined(show_enemy) && show_enemy) {
        renderoverridebundle::function_9f4eff5e(bundle.var_e409027f + "enemy", bundle.("ksROBEnemy"), &function_ba27f1db);
    }
}

