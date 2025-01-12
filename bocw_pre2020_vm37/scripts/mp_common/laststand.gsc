#using script_243ea03c7a285692;
#using script_45fdb6cec5580007;
#using script_5394c653bafe1358;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\player\player_damage;
#using scripts\weapons\weapon_utils;
#using scripts\weapons\weapons;

#namespace laststand_mp;

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x6
// Checksum 0x7ec98570, Offset: 0x330
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"laststand_mp", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x5 linked
// Checksum 0xfc3e22ef, Offset: 0x378
// Size: 0x644
function private function_70a657d8() {
    if (!isdefined(level.skiplaststand)) {
        level.skiplaststand = 0;
    }
    if (!isdefined(level.var_f19192e3)) {
        level.var_f19192e3 = 1;
    }
    if (!isdefined(level.var_39d772ad)) {
        level.var_39d772ad = 0;
    }
    if (!isdefined(level.var_6dec0ba0)) {
        level.var_6dec0ba0 = 0;
    }
    if (!isdefined(level.var_b21f0c3)) {
        level.var_b21f0c3 = 1;
    }
    if (!isdefined(level.var_e735bd66)) {
        level.var_e735bd66 = 0;
    }
    if (!isdefined(level.var_b1c167f1)) {
        level.var_b1c167f1 = 1;
    }
    if (!isdefined(level.var_55615499)) {
        level.var_55615499 = 1;
    }
    if (!isdefined(level.var_3709909d)) {
        level.var_3709909d = 1;
    }
    function_349ff038();
    clientfield::register_clientuimodel("hudItems.laststand.progress", 13000, 5, "float");
    clientfield::register_clientuimodel("hudItems.laststand.beingRevived", 13000, 1, "int");
    clientfield::register_clientuimodel("hudItems.laststand.revivingClientNum", 1, 7, "int");
    clientfield::register_clientuimodel("hudItems.laststand.reviveProgress", 1, 5, "float");
    clientfield::register_clientuimodel("EnemyTeamLastLivesData.numPlayersDowned", 1, 3, "int");
    clientfield::register_clientuimodel("PlayerTeamLastLivesData.numPlayersDowned", 1, 3, "int");
    clientfield::register("allplayers", "laststand_bleed", 1, 1, "int");
    level.var_8e910e84 = 1;
    level.var_97c6ee7c = &playerlaststand;
    level.skiplaststand = getgametypesetting(#"skiplaststand");
    level.var_25364e47 = getgametypesetting(#"hash_83f11b8abac148f");
    level.var_5c13c13f = getgametypesetting(#"hash_4c7c8c4bd1b2a58b");
    level.var_57e7d5a = getgametypesetting(#"hash_67d54bbc52811921");
    level.var_b5087de4 = getgametypesetting(#"hash_3e13b420d6773b4c");
    level.var_5bf4f34b = isdefined(getgametypesetting(#"wzenablecowardswayout")) ? getgametypesetting(#"wzenablecowardswayout") : 0;
    level.laststandweapon = getweapon(#"downed");
    level.var_e273f858 = getweapon(#"notdowned");
    level.var_e86679bd = [];
    if (isdefined(level.revive_hud)) {
        level thread revive_hud_think();
    }
    level.var_91c33dcb = getscriptbundle(#"finishers");
    if (!isdefined(getdvar(#"revive_trigger_radius"))) {
        setdvar(#"revive_trigger_radius", 100);
    }
    callback::on_connect(&on_player_connect);
    callback::on_joined_team(&on_joined_team);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_damage(&on_player_damage);
    callback::on_player_killed(&on_player_killed);
    callback::on_disconnect(&on_player_disconnect);
    level.var_dea23a93 = [];
    level.var_ead46974 = [];
    foreach (team, teamstr in level.teams) {
        level.var_dea23a93[team] = 0;
        level.var_ead46974[team] = 0;
    }
    /#
        level thread function_86c92a7e();
    #/
    setdvar(#"g_revivetime", getgametypesetting(#"laststandrevivetime"));
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xe0854207, Offset: 0x9c8
// Size: 0x9c
function function_349ff038() {
    var_f6784858 = 6;
    if (sessionmodeiswarzonegame()) {
        var_f6784858 = 4;
    }
    var_f48ab2e1 = [];
    for (i = 0; i < var_f6784858; i++) {
        var_c4d0fe29 = i + 1;
        var_f48ab2e1[i] = mp_revive_prompt::register();
    }
    level.mp_revive_prompt = var_f48ab2e1;
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xa50fb92e, Offset: 0xa70
// Size: 0x50
function function_feb3e91d() {
    return isdefined(getgametypesetting(#"laststandfinishing")) ? getgametypesetting(#"laststandfinishing") : 0;
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x0
// Checksum 0x4959446c, Offset: 0xac8
// Size: 0x1c
function function_367cfa1b(callbackfunc) {
    level.var_dcc41ae = callbackfunc;
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x0
// Checksum 0xe620531d, Offset: 0xaf0
// Size: 0x1c
function function_eb8c0e47(callbackfunc) {
    level.var_f80fdd3f = callbackfunc;
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x650275f0, Offset: 0xb18
// Size: 0x64
function function_414115a0(time, health) {
    tier = {#time:time, #health:health};
    level.var_e86679bd[level.var_e86679bd.size] = tier;
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xddf24bb, Offset: 0xb88
// Size: 0xc0
function on_player_connect() {
    foreach (prompt in level.mp_revive_prompt) {
        [[ prompt ]]->set_clientnum(self, int(pow(2, 7) - 2));
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x19730d59, Offset: 0xc50
// Size: 0x6c
function on_joined_team(*params) {
    self clientfield::set_player_uimodel("PlayerTeamLastLivesData.numPlayersDowned", level.var_dea23a93[self.team]);
    self clientfield::set_player_uimodel("EnemyTeamLastLivesData.numPlayersDowned", level.var_ead46974[self.team]);
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x8a1afa3f, Offset: 0xcc8
// Size: 0x8e
function on_player_spawned() {
    if (isdefined(level.revive_hud)) {
        self laststand::revive_hud_create();
    }
    self clientfield::set_player_uimodel("hudItems.laststand.revivingClientNum", int(pow(2, 7) - 2));
    self.var_d887a4ad = undefined;
    self.var_156bf46e = undefined;
}

// Namespace laststand_mp/exit_vehicle
// Params 1, eflags: 0x40
// Checksum 0xf661e997, Offset: 0xd60
// Size: 0xc2
function event_handler[exit_vehicle] codecallback_vehicleexit(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    if (self inlaststand()) {
        self.var_156bf46e = eventstruct.vehicle;
        return;
    }
    if (isairborne(eventstruct.vehicle)) {
        self.var_156bf46e = eventstruct.vehicle;
        waitframe(1);
        if (isalive(self) && !self inlaststand()) {
            self.var_156bf46e = undefined;
        }
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x31b267c0, Offset: 0xe30
// Size: 0xb2
function on_player_damage(params) {
    if (self is_reviving_any()) {
        if (isdefined(self.reviving_player) && isdefined(self.reviving_player.var_d75a6ff5)) {
            self.reviving_player.var_d75a6ff5.var_d733f8d7 += params.idamage;
            if (self.health <= params.idamage) {
                self.reviving_player.var_d75a6ff5.var_bb36e277 = 1;
            }
        }
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x2740c4c3, Offset: 0xef0
// Size: 0x3c
function on_player_killed(*params) {
    if (is_true(level.var_f19192e3)) {
        self function_7ff2fc91();
    }
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x468ee32f, Offset: 0xf38
// Size: 0xde
function on_player_disconnect() {
    if (is_true(level.var_f19192e3)) {
        self function_7ff2fc91();
    }
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    if (isdefined(self.laststandparams)) {
        attacker = self.laststandparams.attacker;
        weapon = self.laststandparams.weapon;
        smeansofdeath = self.laststandparams.smeansofdeath;
        if (self util::isenemyplayer(attacker)) {
        }
    }
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xade27488, Offset: 0x1020
// Size: 0x108
function function_7ff2fc91() {
    var_4cf51823 = function_ed72859e();
    if (!var_4cf51823) {
        friendlies = function_78d8cf9b(self);
        foreach (player in friendlies) {
            if (player != self && isalive(player) && player laststand::player_is_in_laststand()) {
                player thread bleed_out(1);
            }
        }
    }
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x1 linked
// Checksum 0xaab1c57d, Offset: 0x1130
// Size: 0xbc
function function_263a2944(prompt, var_a1258c6b) {
    var_a1258c6b waittill(#"player_revived", #"disconnect", #"bled_out", #"death");
    if (isdefined(self)) {
        [[ prompt ]]->close(self);
        [[ prompt ]]->set_clientnum(self, int(pow(2, 7) - 2));
    }
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x39ed3f62, Offset: 0x11f8
// Size: 0xba
function function_c025efba(prompt, var_a1258c6b) {
    var_a1258c6b endon(#"player_revived", #"disconnect", #"bled_out", #"death");
    self endon(#"disconnect");
    while (true) {
        [[ prompt ]]->set_health(self, var_a1258c6b.var_2d19ce3c);
        [[ prompt ]]->set_reviveprogress(self, var_a1258c6b.reviveprogress);
        waitframe(1);
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x85604783, Offset: 0x12c0
// Size: 0x134
function function_5de626dc(var_a1258c6b) {
    foreach (prompt in level.mp_revive_prompt) {
        if (![[ prompt ]]->function_7bfd10e6(self)) {
            [[ prompt ]]->open(self);
            [[ prompt ]]->set_health(self, 1);
            [[ prompt ]]->set_reviveprogress(self, 0);
            [[ prompt ]]->set_clientnum(self, var_a1258c6b getentitynumber());
            self thread function_263a2944(prompt, var_a1258c6b);
            self thread function_c025efba(prompt, var_a1258c6b);
            break;
        }
    }
}

// Namespace laststand_mp/laststand
// Params 7, eflags: 0x1 linked
// Checksum 0x6a5731e, Offset: 0x1400
// Size: 0x2c2
function function_dc7906e8(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc) {
    self.laststandparams = spawnstruct();
    self.var_bfc8055f = spawnstruct();
    self.laststandparams.einflictor = einflictor;
    self.var_bfc8055f.var_b5346661 = isdefined(einflictor) ? einflictor getentitynumber() : -1;
    self.laststandparams.attacker = attacker;
    self.var_bfc8055f.attackernum = isdefined(attacker) ? attacker getentitynumber() : -1;
    self.laststandparams.attackerorigin = attacker.origin;
    if (isplayer(attacker)) {
        self.laststandparams.var_83634238 = attacker getplayerangles();
    } else {
        self.laststandparams.var_83634238 = attacker.angles;
    }
    self.laststandparams.idamage = idamage;
    self.laststandparams.smeansofdeath = smeansofdeath;
    self.laststandparams.weapon = weapon;
    self.laststandparams.vdir = vdir;
    self.laststandparams.shitloc = shitloc;
    self.laststandparams.laststandstarttime = gettime();
    self.laststandparams.victimorigin = self.origin;
    self.laststandparams.var_5fceefd4 = self getplayerangles();
    self.laststandparams.victimweapon = self.currentweapon;
    self.laststandparams.matchtime = gettime();
    self.laststandparams.bledout = 0;
    self.laststandparams.var_59b19c1b = 1;
    if (isdefined(einflictor) && isdefined(einflictor.item) && einflictor.item.name === #"planemortar") {
        self.laststandparams.killcam_entity_info_cached = killcam::get_killcam_entity_info(attacker, einflictor, weapon);
    }
}

// Namespace laststand_mp/laststand
// Params 7, eflags: 0x0
// Checksum 0x7d5af7da, Offset: 0x16d0
// Size: 0x1ca
function function_67b38e11(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc) {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.laststandparams)) {
        self.laststandparams = [];
    }
    if (!isdefined(self.var_bfc8055f)) {
        self.var_bfc8055f = [];
    }
    self.laststandparams.einflictor = einflictor;
    self.var_bfc8055f.var_b5346661 = isdefined(einflictor) ? einflictor getentitynumber() : -1;
    self.laststandparams.attacker = attacker;
    self.var_bfc8055f.attackernum = isdefined(attacker) ? attacker getentitynumber() : -1;
    self.laststandparams.idamage = idamage;
    self.laststandparams.smeansofdeath = smeansofdeath;
    self.laststandparams.weapon = weapon;
    self.laststandparams.vdir = vdir;
    self.laststandparams.shitloc = shitloc;
    if (isdefined(einflictor) && isdefined(einflictor.item) && einflictor.item.name === #"planemortar") {
        self.laststandparams.killcam_entity_info_cached = killcam::get_killcam_entity_info(attacker, einflictor, weapon);
    }
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x1 linked
// Checksum 0xe675b527, Offset: 0x18a8
// Size: 0x2c
function function_d5db8d2e(*attacker, *weapon) {
    self function_2907ce7a();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xece22225, Offset: 0x18e0
// Size: 0xde
function function_ed72859e() {
    friendlies = function_78d8cf9b(self);
    foreach (player in friendlies) {
        if (player == self) {
            continue;
        }
        if (isalive(player) && !player laststand::player_is_in_laststand()) {
            return true;
        }
    }
    return false;
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x8727892c, Offset: 0x19c8
// Size: 0x196
function function_78d8cf9b(player) {
    assert(isplayer(player));
    friendlies = [];
    if (!isplayer(player)) {
        return friendlies;
    }
    if (player.squad != #"none" && squads::function_a9758423()) {
        friendlies = arraycombine(friendlies, function_c65231e2(player.squad), 0, 0);
    } else {
        teams = player function_2b77bc35();
        foreach (team in teams) {
            players = getplayers(team);
            friendlies = arraycombine(friendlies, players, 0, 0);
        }
    }
    return friendlies;
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xfd71eb61, Offset: 0x1b68
// Size: 0x6e
function function_2b77bc35() {
    teams = [];
    if (!isdefined(teams)) {
        teams = [];
    } else if (!isarray(teams)) {
        teams = array(teams);
    }
    teams[teams.size] = self.team;
    return teams;
}

/#

    // Namespace laststand_mp/laststand
    // Params 0, eflags: 0x0
    // Checksum 0xd6f0127b, Offset: 0x1be0
    // Size: 0x270
    function function_86c92a7e() {
        level endon(#"game_ended");
        while (true) {
            var_e796bc31 = getdvarstring(#"scr_last_stand", "<dev string:x38>");
            if (var_e796bc31 == "<dev string:x3c>") {
                host = util::gethostplayer();
                angles = host getplayerangles();
                dir = anglestoforward(angles);
                eye = host geteye();
                dir *= 500;
                trace = bullettrace(eye, eye + dir, 1, host);
                target = trace[#"entity"];
                if (!isdefined(target) || !isplayer(target)) {
                    target = host;
                }
                target dodamage(1000, target.origin);
            } else if (var_e796bc31 == "<dev string:x50>") {
                foreach (player in getplayers()) {
                    if (isdefined(player.revivetrigger)) {
                        player notify(#"auto_revive");
                    }
                }
            }
            setdvar(#"scr_last_stand", "<dev string:x38>");
            wait 0.1;
        }
    }

#/

// Namespace laststand_mp/laststand
// Params 4, eflags: 0x1 linked
// Checksum 0xc01effa9, Offset: 0x1e58
// Size: 0x43e
function function_b1158c52(attacker, idamage, smeansofdeath, var_4cf51823) {
    if (is_true(level.skiplaststand)) {
        return true;
    } else if (is_true(level.var_f19192e3) && !var_4cf51823) {
        return true;
    } else if (is_true(level.var_39d772ad) && self.usingremote) {
        return true;
    } else if (is_true(level.var_6dec0ba0) && isdefined(attacker) && attacker == self) {
        return true;
    } else if (is_true(level.var_25364e47) && self.laststandcount > level.var_25364e47) {
        return true;
    } else if (is_true(level.var_b21f0c3) && self isplayerswimming()) {
        return true;
    } else if (is_true(level.var_e735bd66) && isvehicle(self.var_156bf46e) && !self.var_156bf46e isremotecontrol()) {
        return true;
    } else if (is_true(level.var_b1c167f1) && isvehicle(self.var_156bf46e) && !self.var_156bf46e isremotecontrol() && isairborne(self.var_156bf46e) && function_5ffabd64(self.var_156bf46e, self)) {
        return true;
    } else if (is_true(level.var_55615499) && isvehicle(self.var_156bf46e) && !self.var_156bf46e isremotecontrol() && self.var_156bf46e.vehicleclass === "boat" && function_61c14ebf(self.var_156bf46e, self)) {
        return true;
    } else if (is_true(level.var_3709909d) && isdefined(smeansofdeath) && isdefined(idamage) && smeansofdeath == "MOD_FALLING" && idamage >= self.maxhealth) {
        return true;
    } else if (!function_3238d10d(self.origin)) {
        return true;
    } else if (is_true(self.var_f5dc0dbf)) {
        self.var_f5dc0dbf = undefined;
        return true;
    } else {
        var_b145f8cd = self.laststandcount - 1;
        if (var_b145f8cd >= level.var_e86679bd.size) {
            var_b145f8cd = level.var_e86679bd.size - 1;
        }
        var_e86679bd = level.var_e86679bd[var_b145f8cd];
        if (isdefined(var_e86679bd)) {
            return (var_e86679bd.time <= 0);
        }
    }
    return false;
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x5 linked
// Checksum 0xaa4b252e, Offset: 0x22a0
// Size: 0x7c
function private function_5ffabd64(vehicle, player) {
    trace = groundtrace(player.origin, player.origin - (0, 0, 300), 0, vehicle);
    if (trace[#"fraction"] >= 1) {
        return true;
    }
    return false;
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x5 linked
// Checksum 0x39c916e4, Offset: 0x2328
// Size: 0x100
function private function_61c14ebf(vehicle, player) {
    exitposition = vehicle function_212db732(player);
    traceorigin = isdefined(exitposition) ? exitposition : player.origin;
    ignoreent = isdefined(exitposition) ? undefined : vehicle;
    trace = groundtrace(traceorigin, traceorigin - (0, 0, 500), 0, ignoreent, 1);
    if (trace[#"fraction"] >= 1 || oob::chr_party(trace[#"position"])) {
        return true;
    }
    return false;
}

// Namespace laststand_mp/laststand
// Params 9, eflags: 0x1 linked
// Checksum 0x45ffbd81, Offset: 0x2430
// Size: 0x87c
function playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, *psoffsettime, *delayoverride) {
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    self.var_60956d6 = self getcurrentweapon();
    self function_dc7906e8(idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride);
    if (!isdefined(self.laststandcount)) {
        self.laststandcount = 0;
    }
    self.laststandcount++;
    self function_ecdd4b27();
    if (isdefined(level.var_f7b64ada)) {
        [[ level.var_f7b64ada ]]();
    }
    friendlies = getplayers(self.team);
    var_4cf51823 = self function_ed72859e();
    if (self function_b1158c52(smeansofdeath, weapon, vdir, var_4cf51823)) {
        self undolaststand();
        self.uselaststandparams = 1;
        self function_6da86ae();
        self suicide(vdir, smeansofdeath.origin);
        if (isdefined(self.var_d75a6ff5)) {
            self.var_d75a6ff5.death = 1;
        }
        self function_1e8018b0();
        if (!var_4cf51823) {
            foreach (player in friendlies) {
                if (player != self && isalive(player) && player laststand::player_is_in_laststand()) {
                    player thread bleed_out();
                }
            }
        }
        return;
    }
    obituary(self, smeansofdeath, level.weaponnone, "MOD_DOWNED");
    if (isdefined(smeansofdeath) && isplayer(smeansofdeath)) {
        if (util::function_fbce7263(smeansofdeath.team, self.team) && !function_7afe7d1e(smeansofdeath, self) && self.var_179765d7 !== 1) {
            scoreevents::processscoreevent(#"downed_enemy", smeansofdeath, self, shitloc);
        }
        if (isdefined(level.var_dcc41ae)) {
            [[ level.var_dcc41ae ]](smeansofdeath, self, idamage, shitloc, vdir);
        }
    }
    self.reviveprogress = 0;
    self.var_2d19ce3c = 1;
    level.var_dea23a93[self.team]++;
    var_9b6c9b51 = level.var_dea23a93[self.team];
    foreach (player in friendlies) {
        player clientfield::set_player_uimodel("PlayerTeamLastLivesData.numPlayersDowned", var_9b6c9b51);
        player thread function_5de626dc(self);
    }
    foreach (team, count in level.var_ead46974) {
        if (!util::function_fbce7263(team, self.team)) {
            continue;
        }
        count++;
        level.var_ead46974[team] = count;
        foreach (player in getplayers(team)) {
            player clientfield::set_player_uimodel("EnemyTeamLastLivesData.numPlayersDowned", count);
        }
    }
    self notify(#"entering_last_stand");
    self allowjump(0);
    self disableoffhandweapons();
    self.health = 5;
    self.laststand = 1;
    self.meleeattackers = undefined;
    callback::callback(#"on_player_laststand");
    self function_d5db8d2e(smeansofdeath, shitloc);
    if (!is_true(self.no_revive_trigger)) {
        self revive_trigger_spawn();
    }
    self thread laststand_disable_player_weapons();
    bleedout_time = getdvarfloat(#"player_laststandbleedouttime", 0);
    var_969fabf4 = self.maxhealth;
    var_b145f8cd = self.laststandcount - 1;
    if (var_b145f8cd >= level.var_e86679bd.size) {
        var_b145f8cd = level.var_e86679bd.size - 1;
    }
    var_e86679bd = level.var_e86679bd[var_b145f8cd];
    if (isdefined(var_e86679bd)) {
        bleedout_time = var_e86679bd.time;
        var_969fabf4 = var_e86679bd.health;
    }
    self clientfield::set("laststand_bleed", 1);
    /#
        bleedout_time = getdvarfloat(#"overridebleedouttime", bleedout_time);
    #/
    self thread laststand_bleedout(bleedout_time, var_969fabf4);
    self thread laststand_invulnerability();
    demo::bookmark(#"player_downed", gettime(), self);
    potm::bookmark(#"player_downed", gettime(), self);
    self thread laststand::function_d4c9e1b5();
    self thread auto_revive_on_notify();
    self thread function_5ccd602d();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xe9e192d6, Offset: 0x2cb8
// Size: 0x64
function function_5ccd602d() {
    self endon(#"player_revived", #"disconnect");
    self waittill(#"death");
    self function_2907ce7a();
    self undolaststand();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xa40fb277, Offset: 0x2d28
// Size: 0xe4
function laststand_disable_player_weapons() {
    self endon(#"death", #"disconnect");
    self giveweapon(level.laststandweapon);
    self givemaxammo(level.laststandweapon);
    self switchtoweaponimmediate(level.laststandweapon, 1);
    self disableweaponcycling();
    self disableoffhandweapons();
    self waittilltimeout(1, #"weapon_change_complete");
    self weapons::detach_all_weapons();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xc693ddb8, Offset: 0x2e18
// Size: 0x64
function function_102748f8() {
    self takeweapon(level.laststandweapon);
    self giveweapon(level.var_e273f858);
    self switchtoweaponimmediate(level.var_e273f858, 1);
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x2566720c, Offset: 0x2e88
// Size: 0x74
function laststand_enable_player_weapons() {
    self takeweapon(level.var_e273f858);
    self enableweaponcycling();
    self enableoffhandweapons();
    self weapons::function_d571ac59(self.var_60956d6);
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xe5306c96, Offset: 0x2f08
// Size: 0x164
function laststand_clean_up_on_interrupt(playerbeingrevived) {
    level endon(#"game_ended");
    self endon(#"do_revive_ended_normally", #"disconnect");
    revivetrigger = playerbeingrevived.revivetrigger;
    playerbeingrevived waittill(#"death", #"disconnect");
    if (isdefined(playerbeingrevived)) {
        playerbeingrevived clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 0);
    }
    self stoploopsound(1);
    if (isdefined(revivetrigger)) {
        revivetrigger delete();
    }
    self function_2907ce7a();
    self function_92bfddb4();
    self clientfield::set_player_uimodel("hudItems.laststand.revivingClientNum", int(pow(2, 7) - 2));
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xd5a00a2a, Offset: 0x3078
// Size: 0x318
function laststand_bleedout_damage() {
    level endon(#"game_ended");
    self endon(#"player_revived", #"disconnect", #"bled_out");
    while (true) {
        waitresult = self waittill(#"laststand_damage");
        if (self.var_d887a4ad === 1) {
            return;
        }
        if (function_58f9f9c5(waitresult)) {
            self.var_969fabf4 = 0;
        } else {
            self.var_969fabf4 -= waitresult.idamage;
        }
        if (self.var_969fabf4 <= 0) {
            self.bleedout_time = 0;
            self.var_1cc38de0 = 1;
            vattacker = isdefined(waitresult.eattacker) ? waitresult.eattacker : self;
            self.var_a1d415ee = {#einflictor:waitresult.einflictor, #attacker:waitresult.eattacker, #attackerorigin:vattacker.origin, #var_83634238:isplayer(vattacker) ? vattacker getplayerangles() : vattacker.angles, #idamage:waitresult.idamage, #smeansofdeath:waitresult.smeansofdeath, #weapon:waitresult.weapon, #vdir:waitresult.vdir, #shitloc:waitresult.shitloc, #matchtime:function_f8d53445()};
        }
        if (isdefined(self.var_d75a6ff5)) {
            self.var_d75a6ff5.damage += int(waitresult.idamage);
        }
        self function_a6872ca5(waitresult.idamage, waitresult.eattacker, waitresult.idflags, waitresult.smeansofdeath, waitresult.weapon, waitresult.vpoint, waitresult.shitloc, waitresult.vdamageorigin, waitresult.boneindex, waitresult.vsurfacenormal, self.var_969fabf4 <= 0);
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x427334c, Offset: 0x3398
// Size: 0xba
function function_58f9f9c5(var_acdfb38d) {
    attacker = player::figure_out_attacker(var_acdfb38d.eattacker);
    if (!isplayer(attacker) || !isdefined(var_acdfb38d.einflictor) || var_acdfb38d.einflictor != attacker) {
        return false;
    }
    return var_acdfb38d.smeansofdeath == "MOD_MELEE" || var_acdfb38d.smeansofdeath == "MOD_MELEE_WEAPON_BUTT" || var_acdfb38d.smeansofdeath == "MOD_MELEE_ASSASSINATE";
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x6612ae33, Offset: 0x3460
// Size: 0x34
function is_being_revived() {
    return isdefined(self.revivetrigger) && is_true(self.revivetrigger.beingrevived);
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x87abad68, Offset: 0x34a0
// Size: 0x34
function function_72e0c544() {
    return isdefined(self.revivetrigger) && is_true(self.revivetrigger.beingfinished);
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x5da16964, Offset: 0x34e0
// Size: 0x3dc
function laststand_bleedout(bleedouttime, var_969fabf4) {
    level endon(#"game_ended");
    self endon(#"player_revived", #"player_bleedout", #"death", #"disconnect");
    self.var_84c0402e = bleedouttime;
    self.bleedout_time = bleedouttime;
    self.var_969fabf4 = var_969fabf4;
    self.var_2d19ce3c = 0;
    self.var_1cc38de0 = 0;
    self.var_eb33efbc = 0;
    var_cb141a23 = int(0.1 * 1000);
    var_93b9385d = bleedouttime * 0.06;
    var_cebeb781 = !self usebuttonpressed();
    if (self.bleedout_time > 0) {
        if (!is_true(level.var_7624ce4c)) {
            self thread laststand_bleedout_damage();
        }
        var_7c962084 = undefined;
        var_9da219f5 = gettime();
        while (self.bleedout_time > 0) {
            time = gettime();
            if (is_true(level.var_5bf4f34b) && var_cebeb781 && self usebuttonpressed() && !self is_being_revived() && !self function_72e0c544()) {
                if (!isdefined(var_7c962084)) {
                    var_7c962084 = time;
                }
                self.var_eb33efbc = 1;
                if (time >= var_7c962084 + var_cb141a23) {
                    self.bleedout_time -= var_93b9385d;
                    var_7c962084 = time;
                    var_9da219f5 += var_cb141a23;
                }
            } else if (time >= var_9da219f5) {
                self.bleedout_time -= 1;
                var_7c962084 = undefined;
                var_9da219f5 = time + int(1 * 1000);
            }
            self.var_2d19ce3c = self.bleedout_time / bleedouttime;
            if (self.var_d887a4ad !== 1) {
                self clientfield::set_player_uimodel("hudItems.laststand.progress", self.var_2d19ce3c);
            }
            waitframe(1);
            var_cebeb781 |= !self usebuttonpressed();
            self.var_eb33efbc = 0;
            while (!is_true(self.var_1cc38de0) && (self is_being_revived() || self function_72e0c544())) {
                waitframe(1);
            }
        }
    }
    if (is_true(self.var_d887a4ad)) {
        return;
    }
    self notify(#"bled_out");
    self thread bleed_out();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x4162ffda, Offset: 0x38c8
// Size: 0x4c
function laststand_invulnerability() {
    self endon(#"death");
    self enableinvulnerability();
    wait level.var_5c13c13f;
    self disableinvulnerability();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xa24fc153, Offset: 0x3920
// Size: 0x46
function function_6da86ae() {
    if (isdefined(self) && isdefined(self.laststandparams) && !isdefined(self.laststandparams.attacker)) {
        self.laststandparams.attacker = self;
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x4ce26a8a, Offset: 0x3970
// Size: 0x444
function bleed_out(var_7414b854 = 0) {
    self endon(#"player_revived", #"death");
    util::wait_network_frame();
    self function_2907ce7a();
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    self clientfield::set("laststand_bleed", 0);
    demo::bookmark(#"player_bledout", gettime(), self, undefined, 1);
    potm::bookmark(#"player_bledout", gettime(), self, undefined, 1);
    level notify(#"bleed_out", {#character_index:self.characterindex});
    self notify(#"player_bleedout");
    callback::callback(#"on_player_bleedout");
    self undolaststand();
    self.uselaststandparams = 1;
    self function_6da86ae();
    assert(isdefined(self.laststandparams));
    self.laststandparams.var_7414b854 = var_7414b854;
    if (!is_true(self.var_1cc38de0)) {
        self.laststandparams.bledout = 1;
    }
    if (isdefined(self.var_d75a6ff5)) {
        self.var_d75a6ff5.death = is_true(self.var_1cc38de0);
        self.var_d75a6ff5.bleed_out = !self.var_d75a6ff5.death;
        self function_1e8018b0();
    }
    self function_2907ce7a();
    self bledout(self.laststandparams.einflictor, self.laststandparams.attacker, self.laststandparams.idamage, self.laststandparams.smeansofdeath, self.laststandparams.weapon, self.laststandparams.vdir, self.laststandparams.shitloc);
    if (getdvarint(#"hash_62b8db0428755a32", 1) && isplayer(self)) {
        var_d7e063c = getdvarfloat(#"hash_44de9418bb6289ac", 1.5);
        self playsoundtoplayer(#"hash_11d39dca0f911535", self);
        self lui::screen_fade(var_d7e063c, 1, 0, "black", 0);
        wait var_d7e063c + 0.2;
        self lui::screen_fade(var_d7e063c, 0, 1, "black", 0);
    }
    if (isdefined(self) && self.no_respawn !== 1) {
        self thread respawn_player_after_time(15);
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x6572c8f0, Offset: 0x3dc0
// Size: 0xbc
function respawn_player_after_time(n_time_seconds) {
    self endon(#"death", #"disconnect");
    players = getplayers();
    if (players.size == 1) {
        return;
    }
    self waittill(#"spawned_spectator");
    level endon(#"objective_changed");
    wait n_time_seconds;
    if (self.sessionstate == #"spectator") {
        self thread globallogic_spawn::waitandspawnclient();
    }
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x25a63311, Offset: 0x3e88
// Size: 0x64
function function_2907ce7a() {
    self clientfield::set_player_uimodel("hudItems.laststand.progress", 0);
    self clientfield::set_player_uimodel("hudItems.laststand.reviveProgress", 0);
    self clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 0);
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xd293e754, Offset: 0x3ef8
// Size: 0x17c
function revive_trigger_spawn() {
    radius = getdvarint(#"revive_trigger_radius", 100);
    self.revivetrigger = spawn("trigger_radius", (0, 0, 0), 0, radius, radius);
    self.revivetrigger sethintstring("");
    self.revivetrigger setcursorhint("HINT_NOICON");
    self.revivetrigger setmovingplatformenabled(1);
    self.revivetrigger enablelinkto();
    self.revivetrigger.origin = self.origin;
    self.revivetrigger linkto(self);
    self.revivetrigger.beingrevived = 0;
    self.revivetrigger.createtime = gettime();
    self.revivetrigger.radius = radius;
    self.revivetrigger setteamfortrigger(self.team);
    self thread revive_trigger_think();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x8ef60ff9, Offset: 0x4080
// Size: 0x378
function revive_trigger_think() {
    self endon(#"death", #"stop_revive_trigger");
    level endon(#"game_ended");
    while (true) {
        wait 0.1;
        if (!isdefined(self.revivetrigger)) {
            self notify(#"stop_revive_trigger");
        }
        self.revivetrigger sethintstring("");
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i].team != self.team) {
                continue;
            }
            if (players[i] can_revive(self)) {
                self.revivetrigger setrevivehintstring(#"hash_51a0f083a5566a3", self.team);
                break;
            }
        }
        for (i = 0; i < players.size; i++) {
            reviver = players[i];
            if (!isdefined(reviver)) {
                continue;
            }
            if (reviver.team != self.team) {
                continue;
            }
            if (self == reviver || !reviver is_reviving(self)) {
                continue;
            }
            if (reviver isgestureplaying(reviver gestures::function_c77349d4("gestable_t9_stimshot_last_stand"))) {
                continue;
            }
            reviver gestures::function_56e00fbf("gestable_t9_stimshot_last_stand");
            reviver disableweaponcycling();
            reviver disableusability();
            reviver disableoffhandweapons();
            revive_success = reviver revive_do_revive(self);
            if (isdefined(reviver)) {
                reviver function_92bfddb4();
            }
            if (revive_success) {
                self thread revive_success(reviver);
                self function_2907ce7a();
                return;
            }
        }
        if (function_feb3e91d()) {
            foreach (team in level.teams) {
                if (team === self.team) {
                    continue;
                }
                if (function_356caede(team)) {
                    return;
                }
            }
        }
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x6835fc2b, Offset: 0x4400
// Size: 0x652
function function_356caede(team) {
    if (!isdefined(self)) {
        return false;
    }
    if (function_a1ef346b(team).size == 0) {
        return false;
    }
    if (!isdefined(self.revivetrigger)) {
        return false;
    }
    players = getplayers(team, self.revivetrigger.origin, self.revivetrigger.radius);
    height = getdvarint(#"hash_48068f92d21e2a64", 15);
    foreach (player in players) {
        if (player can_revive(self, 1, height)) {
            self.revivetrigger setrevivehintstring(#"hash_a9213d7fcad1656", team);
            break;
        }
    }
    foreach (finisher in players) {
        if (self == finisher || !finisher is_reviving(self, 0, height) || finisher is_reviving_any() || is_true(finisher.var_5c574004)) {
            continue;
        }
        finisher increment_finishing();
        bundle_index = randomintrange(1, level.var_91c33dcb.finishers.size - 1);
        assert(level.var_91c33dcb.finishers.size >= bundle_index);
        var_abdbed5a = level.var_91c33dcb.finishers[bundle_index].("finisherbundle");
        var_d1d9820d = getscriptbundle(var_abdbed5a);
        if (isdefined(var_d1d9820d.("attacker_gesture"))) {
            finisher function_c6775cf9(var_d1d9820d.("attacker_gesture"));
        }
        if (isdefined(var_d1d9820d.("victim_gesture"))) {
            self function_c6775cf9(var_d1d9820d.("victim_gesture"));
        }
        self function_fab0e07e(finisher);
        if (!isdefined(finisher)) {
            return false;
        }
        if (!isdefined(self) || !isalive(self) || !isalive(finisher)) {
            finisher function_b16f016a();
            return false;
        }
        finisher disableweaponcycling();
        finisher disableusability();
        finisher disableoffhandweapons();
        self flag::clear(#"hash_40e3b09bdbcdac81");
        var_62728357 = finisher function_1c8cab15(self);
        if (isdefined(finisher)) {
            finisher function_b16f016a();
            finisher enableweaponcycling();
            finisher enableusability();
            finisher enableoffhandweapons();
            kill_angles = finisher gettagangles("tag_sync");
            kill_origin = finisher gettagorigin("tag_sync");
            if (isdefined(self)) {
                if (is_true(var_62728357)) {
                    self function_516a3bef(0);
                    self setplayerangles(kill_angles);
                    self setorigin(kill_origin);
                    self dodamage(self.var_969fabf4, self.origin, finisher, undefined, "none", "MOD_MELEE_ASSASSINATE", 8192);
                    self function_2907ce7a();
                    return true;
                } else {
                    self function_516a3bef(1);
                    self function_7c685040();
                }
            }
            finisher function_7c685040();
        }
    }
    return false;
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xaa800dae, Offset: 0x4a60
// Size: 0x24
function increment_finishing() {
    if (!isdefined(self.var_5c574004)) {
        self.var_5c574004 = 0;
    }
    self.var_5c574004++;
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x7efb90c0, Offset: 0x4a90
// Size: 0x4e
function function_b16f016a() {
    self.var_5c574004--;
    if (self.var_5c574004 < 0) {
        self.var_5c574004 = 0;
        return;
    }
    if (self.var_5c574004 > 99999) {
        self.var_5c574004 = 99999;
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xceb2747f, Offset: 0x4ae8
// Size: 0xc4
function function_fab0e07e(finisher) {
    self endon(#"disconnect");
    finisher endon(#"disconnect");
    waitframe(1);
    if (isdefined(self) && isdefined(finisher) && isalive(self) && isalive(finisher)) {
        self.laststandparams.var_3f57b6a0 = self.origin;
        self.laststandparams.savedangles = self.angles;
        self playerlinkto(finisher, "tag_sync");
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xb2dc9437, Offset: 0x4bb8
// Size: 0x84
function function_516a3bef(replace) {
    if (isalive(self) && function_feb3e91d()) {
        self unlink();
        if (replace) {
            self setorigin(self.laststandparams.var_3f57b6a0);
        }
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x68eb990f, Offset: 0x4c48
// Size: 0xb6
function function_c82a14d1(finisher) {
    self endon(#"death", #"disconnect", #"finish_abort");
    finisher endon(#"death", #"disconnect");
    waitresult = self waittill(#"contact");
    self flag::set(#"hash_40e3b09bdbcdac81");
    self notify(#"player_finished");
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x2be8d704, Offset: 0x4d08
// Size: 0x170
function function_1c8cab15(var_b4bb7319) {
    var_b4bb7319 endon(#"disconnect");
    self endon(#"disconnect");
    var_b4bb7319.revivetrigger.beingfinished = 1;
    var_b4bb7319 thread function_c82a14d1(self);
    while (isdefined(var_b4bb7319) && isalive(var_b4bb7319) && isalive(self) && !self laststand::player_is_in_laststand() && var_b4bb7319 laststand::player_is_in_laststand() && !var_b4bb7319 flag::get(#"hash_40e3b09bdbcdac81") && !self is_reviving_any()) {
        waitframe(1);
    }
    if (isdefined(var_b4bb7319.revivetrigger)) {
        var_b4bb7319.revivetrigger.beingfinished = 0;
    }
    if (isdefined(var_b4bb7319) && var_b4bb7319 flag::get(#"hash_40e3b09bdbcdac81")) {
        return true;
    }
    return false;
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x6d373d0e, Offset: 0x4e80
// Size: 0xfc
function function_92bfddb4() {
    if (!isdefined(self)) {
        return;
    }
    self stopgestureviewmodel(self gestures::function_c77349d4("gestable_t9_stimshot_last_stand"));
    self enableusability();
    self.is_reviving_any--;
    if (self.is_reviving_any < 0) {
        self.is_reviving_any = 0;
    } else if (self.is_reviving_any > 99999) {
        self.is_reviving_any = 99999;
    }
    if (is_true(self.laststand)) {
        return;
    }
    self enableweaponcycling();
    self enableoffhandweapons();
    self weapons::function_d571ac59();
}

// Namespace laststand_mp/laststand
// Params 3, eflags: 0x1 linked
// Checksum 0x8215945c, Offset: 0x4f88
// Size: 0x2d6
function can_revive(revivee, ignore_touch_checks = 0, height = undefined) {
    if (!isdefined(revivee.revivetrigger)) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (self laststand::player_is_in_laststand()) {
        return false;
    }
    if (isdefined(level.can_revive) && ![[ level.can_revive ]](revivee)) {
        return false;
    }
    if (isdefined(level.var_1461fd14) && ![[ level.var_1461fd14 ]](revivee)) {
        return false;
    }
    if (isdefined(level.revive_trigger_should_ignore_sight_checks)) {
        ignore_sight_checks = [[ level.revive_trigger_should_ignore_sight_checks ]](self);
        if (ignore_sight_checks && isdefined(revivee.revivetrigger.beingrevived) && revivee.revivetrigger.beingrevived == 1) {
            ignore_touch_checks = 1;
        }
    }
    if (!ignore_touch_checks) {
        if (!self istouching(revivee.revivetrigger)) {
            return false;
        }
    }
    if (isdefined(height)) {
        delta = revivee.origin[2] - self.origin[2];
        if (delta > height || delta < height * -1) {
            return false;
        }
    }
    if (!self laststand::is_facing(revivee, 0.8)) {
        return false;
    }
    if (distancesquared(revivee.origin, self.origin) > function_a3f6cdac(140)) {
        return false;
    }
    if (!sighttracepassed(self.origin + (0, 0, 50), revivee.origin + (0, 0, 30), 0, undefined)) {
        return false;
    }
    if (!bullettracepassed(self.origin + (0, 0, 50), revivee.origin + (0, 0, 30), 0, undefined)) {
        return false;
    }
    return true;
}

// Namespace laststand_mp/laststand
// Params 3, eflags: 0x1 linked
// Checksum 0xde861579, Offset: 0x5268
// Size: 0xac
function is_reviving(revivee, ignore_touch_checks = 0, height = undefined) {
    if (!isdefined(self) || !isdefined(revivee)) {
        return false;
    }
    if (!isalive(revivee)) {
        return false;
    }
    if (!isdefined(revivee.revivetrigger)) {
        return false;
    }
    return self usebuttonpressed() && can_revive(revivee, ignore_touch_checks, height);
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x58108925, Offset: 0x5320
// Size: 0x1a
function is_reviving_any() {
    return is_true(self.is_reviving_any);
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x9da0d133, Offset: 0x5348
// Size: 0x612
function revive_do_revive(playerbeingrevived) {
    self endon(#"disconnect");
    if (!isdefined(playerbeingrevived)) {
        return 0;
    }
    assert(self is_reviving(playerbeingrevived));
    revivetime = getdvarfloat(#"g_revivetime", 3) * self function_bd85bc2f();
    timer = 0;
    revived = 0;
    playerbeingrevived clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 1);
    playerbeingrevived.revivetrigger.beingrevived = 1;
    playerbeingrevived.revivetrigger sethintstring("");
    playerbeingrevived function_6bf621ea(#"hash_5b6f9e0c346eb0a", 2, int(revivetime * 1000), playerbeingrevived getentitynumber());
    if (isplayer(playerbeingrevived)) {
        playerbeingrevived startrevive(self);
    }
    self thread laststand_clean_up_on_interrupt(playerbeingrevived);
    if (!isdefined(self.is_reviving_any)) {
        self.is_reviving_any = 0;
    }
    self.is_reviving_any++;
    self playsound(#"hash_7f077925d3f525ad");
    self playloopsound(#"hash_67a426610a2d2a2d");
    if (isdefined(playerbeingrevived.var_d75a6ff5)) {
        playerbeingrevived.var_d75a6ff5.var_d10f3b9a++;
    }
    self.reviving_player = playerbeingrevived;
    self clientfield::set_player_uimodel("hudItems.laststand.revivingClientNum", playerbeingrevived getentitynumber());
    while (self is_reviving(playerbeingrevived)) {
        if (self laststand::player_is_in_laststand()) {
            playerbeingrevived.reviveprogress = 0;
            break;
        }
        if (is_true(playerbeingrevived.revivetrigger.auto_revive)) {
            playerbeingrevived.reviveprogress = 0;
            break;
        }
        playerbeingrevived.reviveprogress = min(timer / revivetime, 1);
        if (timer >= revivetime) {
            revived = 1;
            break;
        }
        self clientfield::set_player_uimodel("hudItems.laststand.reviveProgress", playerbeingrevived.reviveprogress);
        timer += float(function_60d95f53()) / 1000;
        waitframe(1);
    }
    self clientfield::set_player_uimodel("hudItems.laststand.reviveProgress", 0);
    self clientfield::set_player_uimodel("hudItems.laststand.revivingClientNum", int(pow(2, 7) - 2));
    self stoploopsound(1);
    if (isdefined(playerbeingrevived)) {
        playerbeingrevived clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 0);
        playerbeingrevived.reviveprogress = 0;
        if (is_true(revived)) {
            playerbeingrevived playsound(#"hash_39e55bff84ce34c8");
        } else {
            self playsound(#"hash_c2688a5ec1ca2b5");
        }
        if (!is_true(playerbeingrevived.revivetrigger.auto_revive) && !revived) {
            playerbeingrevived function_6bf621ea(#"hash_c21960dae38833d", 1, playerbeingrevived getentitynumber());
            if (isplayer(playerbeingrevived)) {
                playerbeingrevived stoprevive(self);
            }
        }
        playerbeingrevived.revivetrigger sethintstring(#"hash_51a0f083a5566a3");
        playerbeingrevived.revivetrigger.beingrevived = 0;
        if (is_true(revived) && isdefined(level.var_f80fdd3f)) {
            [[ level.var_f80fdd3f ]](playerbeingrevived, self);
        }
    }
    self.reviving_player = undefined;
    self notify(#"do_revive_ended_normally");
    self.is_reviving_any--;
    if (self.is_reviving_any < 0) {
        self.is_reviving_any = 0;
    } else if (self.is_reviving_any > 99999) {
        self.is_reviving_any = 99999;
    }
    return revived;
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x1d41b9f2, Offset: 0x5968
// Size: 0x74
function auto_revive_on_notify() {
    self endon(#"death", #"disconnect", #"player_revived");
    waitresult = self waittill(#"auto_revive");
    auto_revive(waitresult.reviver);
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xc4c6efb0, Offset: 0x59e8
// Size: 0x1ae
function auto_revive(reviver) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"disconnect");
    self.var_d887a4ad = 1;
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger.auto_revive = 1;
        while (is_true(self.revivetrigger.beingrevived)) {
            util::wait_network_frame();
        }
        self.revivetrigger.auto_trigger = 0;
    }
    self function_102748f8();
    if (!isdefined(self)) {
        return;
    }
    self reviveplayer();
    self.var_d887a4ad = undefined;
    self notify(#"stop_revive_trigger");
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    self function_2907ce7a();
    self laststand_enable_player_weapons();
    self allowjump(1);
    self.laststand = undefined;
    self lui::screen_close_menu();
    self notify(#"player_revived", {#reviver:reviver});
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x1 linked
// Checksum 0xf14c15e4, Offset: 0x5ba0
// Size: 0x34c
function revive_success(reviver, b_track_stats = 1) {
    self.var_156bf46e = undefined;
    if (!isplayer(self)) {
        self notify(#"player_revived", {#reviver:reviver});
        return;
    }
    self function_102748f8();
    self.var_d887a4ad = 1;
    if (!isdefined(self)) {
        return;
    }
    if (is_true(b_track_stats)) {
        demo::bookmark(#"player_revived", gettime(), reviver, self);
        potm::bookmark(#"player_revived", gettime(), reviver, self);
    }
    if (isplayer(self)) {
        self allowjump(1);
    }
    self.laststand = undefined;
    self notify(#"player_revived", {#reviver:reviver});
    self reviveplayer();
    self.var_d887a4ad = undefined;
    health = getgametypesetting(#"laststandrevivehealth");
    if (isdefined(reviver)) {
        var_e705e073 = reviver function_15098882();
        if (var_e705e073 > 0) {
            health = var_e705e073;
        }
        if (!function_7e980623(reviver, self) && self.var_db459f8d !== 1) {
            reviver scoreevents::processscoreevent(#"revived_teammate", reviver, self);
        }
    }
    self.health = health;
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    self clientfield::set("laststand_bleed", 0);
    self function_2907ce7a();
    self laststand_enable_player_weapons();
    self lui::screen_close_menu();
    self function_1e8018b0();
    callback::callback(#"on_player_revived");
    if (isdefined(level.var_1a0c2b72)) {
        reviver [[ level.var_1a0c2b72 ]](self);
    }
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x416c3a3a, Offset: 0x5ef8
// Size: 0x294
function revive_hud_think() {
    level endon(#"game_ended");
    while (true) {
        wait 0.1;
        if (!laststand::player_any_player_in_laststand()) {
            continue;
        }
        revived = 0;
        foreach (team, _ in level.teams) {
            playertorevive = undefined;
            foreach (player in function_a1ef346b(team)) {
                if (!isdefined(player.revivetrigger) || !isdefined(player.revivetrigger.createtime)) {
                    continue;
                }
                if (!isdefined(playertorevive) || playertorevive.revivetrigger.createtime > player.revivetrigger.createtime) {
                    playertorevive = player;
                }
            }
            if (isdefined(playertorevive)) {
                foreach (player in function_a1ef346b(team)) {
                    if (player laststand::player_is_in_laststand()) {
                        continue;
                    }
                    player thread faderevivemessageover(playertorevive, 3);
                }
                playertorevive.revivetrigger.createtime = undefined;
                revived = 1;
            }
        }
        if (revived) {
            wait 3.5;
        }
    }
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x1 linked
// Checksum 0xeacefc30, Offset: 0x6198
// Size: 0x3c
function faderevivemessageover(playertorevive, time) {
    self thread laststand::revive_hud_show_n_fade(#"hash_14cc93f11ba8334a", time, playertorevive);
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x3dcd961b, Offset: 0x61e0
// Size: 0xf6
function function_ecdd4b27() {
    if (!isplayer(self) || isdefined(self.var_d75a6ff5)) {
        return;
    }
    self.var_d75a6ff5 = {#player_xuid:int(self getxuid(1)), #start_time:gettime(), #end_time:0, #damage:0, #death:0, #bleed_out:0, #var_d10f3b9a:0, #var_d733f8d7:0, #var_35b89428:0};
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xc3b80c68, Offset: 0x62e0
// Size: 0x284
function function_1e8018b0() {
    if (!isplayer(self) || !isdefined(self.var_d75a6ff5)) {
        return;
    }
    self.var_d75a6ff5.end_time = gettime();
    function_92d1707f(#"hash_142816c2e7c5da66", self.var_d75a6ff5);
    self.var_d75a6ff5 = undefined;
    level.var_dea23a93[self.team]--;
    var_9b6c9b51 = level.var_dea23a93[self.team];
    foreach (player in getplayers(self.team)) {
        player clientfield::set_player_uimodel("PlayerTeamLastLivesData.numPlayersDowned", var_9b6c9b51);
    }
    foreach (team, count in level.var_ead46974) {
        if (!util::function_fbce7263(team, self.team)) {
            continue;
        }
        count--;
        level.var_ead46974[team] = count;
        foreach (player in getplayers(team)) {
            player clientfield::set_player_uimodel("EnemyTeamLastLivesData.numPlayersDowned", count);
        }
    }
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x543a4cf0, Offset: 0x6570
// Size: 0x6a
function function_b394486e() {
    self.var_d292d803 = spawnstruct();
    self.var_d292d803.cheating = 0;
    self.var_d292d803.downs = array();
    self.var_d292d803.revives = array();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x622b27d9, Offset: 0x65e8
// Size: 0x22
function is_cheating() {
    if (!isdefined(self.var_d292d803)) {
        return 0;
    }
    return self.var_d292d803.cheating;
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x1 linked
// Checksum 0xa626d843, Offset: 0x6618
// Size: 0x3da
function function_7afe7d1e(attacker, victim) {
    if (!isdefined(level.var_57e7d5a) || level.var_57e7d5a == 0) {
        return 0;
    }
    if (!isdefined(attacker.var_d292d803)) {
        attacker function_b394486e();
    } else if (attacker is_cheating()) {
        return 1;
    }
    if (!isdefined(attacker.var_d292d803.downs[victim.entnum])) {
        attacker.var_d292d803.downs[victim.entnum] = array();
        if (!isdefined(attacker.var_d292d803.downs[victim.entnum])) {
            attacker.var_d292d803.downs[victim.entnum] = [];
        } else if (!isarray(attacker.var_d292d803.downs[victim.entnum])) {
            attacker.var_d292d803.downs[victim.entnum] = array(attacker.var_d292d803.downs[victim.entnum]);
        }
        attacker.var_d292d803.downs[victim.entnum][attacker.var_d292d803.downs[victim.entnum].size] = gettime();
        return 0;
    }
    if (!isdefined(attacker.var_d292d803.downs[victim.entnum])) {
        attacker.var_d292d803.downs[victim.entnum] = [];
    } else if (!isarray(attacker.var_d292d803.downs[victim.entnum])) {
        attacker.var_d292d803.downs[victim.entnum] = array(attacker.var_d292d803.downs[victim.entnum]);
    }
    attacker.var_d292d803.downs[victim.entnum][attacker.var_d292d803.downs[victim.entnum].size] = gettime();
    numdowns = attacker.var_d292d803.downs[victim.entnum].size;
    if (numdowns < level.var_57e7d5a) {
        return 0;
    }
    var_1053d9e9 = attacker.var_d292d803.downs[victim.entnum][numdowns - 1];
    var_6ab74732 = attacker.var_d292d803.downs[victim.entnum][numdowns - level.var_57e7d5a];
    if (var_1053d9e9 - var_6ab74732 <= int(60 * 1000)) {
        attacker.var_d292d803.cheating = 1;
        attacker.var_d292d803.downs = undefined;
        attacker.var_d292d803.revives = undefined;
    }
    return attacker is_cheating();
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x73fb9f39, Offset: 0x6a00
// Size: 0x3da
function function_7e980623(reviver, victim) {
    if (!isdefined(level.var_b5087de4) || level.var_b5087de4 == 0) {
        return 0;
    }
    if (!isdefined(reviver.var_d292d803)) {
        reviver function_b394486e();
    } else if (reviver is_cheating()) {
        return 1;
    }
    if (!isdefined(reviver.var_d292d803.revives[victim.entnum])) {
        reviver.var_d292d803.revives[victim.entnum] = array();
        if (!isdefined(reviver.var_d292d803.revives[victim.entnum])) {
            reviver.var_d292d803.revives[victim.entnum] = [];
        } else if (!isarray(reviver.var_d292d803.revives[victim.entnum])) {
            reviver.var_d292d803.revives[victim.entnum] = array(reviver.var_d292d803.revives[victim.entnum]);
        }
        reviver.var_d292d803.revives[victim.entnum][reviver.var_d292d803.revives[victim.entnum].size] = gettime();
        return 0;
    }
    if (!isdefined(reviver.var_d292d803.revives[victim.entnum])) {
        reviver.var_d292d803.revives[victim.entnum] = [];
    } else if (!isarray(reviver.var_d292d803.revives[victim.entnum])) {
        reviver.var_d292d803.revives[victim.entnum] = array(reviver.var_d292d803.revives[victim.entnum]);
    }
    reviver.var_d292d803.revives[victim.entnum][reviver.var_d292d803.revives[victim.entnum].size] = gettime();
    numrevives = reviver.var_d292d803.revives[victim.entnum].size;
    if (numrevives < level.var_b5087de4) {
        return 0;
    }
    var_1053d9e9 = reviver.var_d292d803.revives[victim.entnum][numrevives - 1];
    var_6ab74732 = reviver.var_d292d803.revives[victim.entnum][numrevives - level.var_b5087de4];
    if (var_1053d9e9 - var_6ab74732 <= int(60 * 1000)) {
        reviver.var_d292d803.cheating = 1;
        reviver.var_d292d803.downs = undefined;
        reviver.var_d292d803.revives = undefined;
    }
    return reviver is_cheating();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xc21cfd00, Offset: 0x6de8
// Size: 0x42
function function_7e714b6a() {
    if (!isplayer(self)) {
        assert(0);
        return;
    }
    self.laststandcount = 0;
}

