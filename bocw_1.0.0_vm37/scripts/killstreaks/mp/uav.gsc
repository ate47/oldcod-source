#using script_4721de209091b1a6;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\util;
#using scripts\weapons\heatseekingmissile;

#namespace uav;

// Namespace uav/uav
// Params 0, eflags: 0x6
// Checksum 0x29caa059, Offset: 0x250
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"uav", &preinit, undefined, &function_1c601b99, #"killstreaks");
}

// Namespace uav/uav
// Params 0, eflags: 0x4
// Checksum 0x95311d90, Offset: 0x2b0
// Size: 0x2c
function private function_6fe2ffad() {
    if (sessionmodeiswarzonegame()) {
        return "killstreak_uav_wz";
    }
    return "killstreak_uav";
}

// Namespace uav/uav
// Params 0, eflags: 0x4
// Checksum 0x900143a4, Offset: 0x2e8
// Size: 0x244
function private preinit() {
    level.activeuavs = [];
    level.activeplayeruavs = [];
    level.spawneduavs = [];
    level.var_baadd01f = &function_1b3ab65e;
    if (tweakables::gettweakablevalue("killstreak", "allowradar")) {
        killstreaks::register_killstreak(function_6fe2ffad(), &activateuav);
    }
    level thread uavtracker();
    callback::on_connect(&onplayerconnect);
    callback::on_spawned(&onplayerspawned);
    callback::on_joined_team(&onplayerjoinedteam);
    callback::add_callback(#"hash_7c6da2f2c9ef947a", &fx_flesh_hit_neck_fatal);
    globallogic_score::register_kill_callback(getweapon("uav"), &function_9ee62e18);
    globallogic_score::function_78aac1c6(getweapon("uav"), #"hash_15da16b6b9032af");
    setmatchflag("radar_allies", 0);
    setmatchflag("radar_axis", 0);
    airsupport::init_shared();
    clientfield::register("scriptmover", "uav", 1, 1, "int");
    clientfield::register("scriptmover", "uav_fx", 1, 1, "int");
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xb36abbb7, Offset: 0x538
// Size: 0xa6
function function_1c601b99() {
    if (isdefined(level.var_1b900c1d)) {
        [[ level.var_1b900c1d ]](getweapon(#"uav"), &function_bff5c062);
    }
    if (false) {
        profilestart();
        level.var_b59e7114 = killstreaks::function_f3875fb0(level.var_49dafe2a, isdefined(level.var_eb2556e1) ? level.var_eb2556e1 : 5000, 60, -1, 1);
        profilestop();
    }
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x4c307de2, Offset: 0x5e8
// Size: 0x2a
function onplayerconnect() {
    if (!isdefined(self.entnum)) {
        self.entnum = self getentitynumber();
    }
}

// Namespace uav/uav
// Params 2, eflags: 0x0
// Checksum 0xbce91db6, Offset: 0x620
// Size: 0x10c
function function_bff5c062(uav, attackingplayer) {
    uav hackedprefunction(attackingplayer);
    uav.owner = attackingplayer;
    uav killstreaks::configure_team_internal(attackingplayer, 1);
    if (isdefined(level.var_f1edf93f)) {
        uav notify(#"hacked");
        uav notify(#"cancel_timeout");
        var_eb79e7c3 = int([[ level.var_f1edf93f ]]() * 1000);
        uav thread killstreaks::waitfortimeout("uav", var_eb79e7c3, &ontimeout, "delete", "death", "crashing");
    }
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xcbdddd25, Offset: 0x738
// Size: 0x5c
function function_ef80ceac() {
    if (isdefined(level.activeplayeruavs[self.entnum])) {
        var_86510a2 = level.activeplayeruavs[self.entnum];
        if (level.forceradar == 1) {
            var_86510a2--;
        }
        return (var_86510a2 > 0);
    }
    return false;
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xf7ab484a, Offset: 0x7a0
// Size: 0xb2
function function_1b3ab65e() {
    foreach (uav in level.spawneduavs) {
        if (uav.team === self.team) {
            continue;
        }
        if (uav function_457c378e(self)) {
            return true;
        }
    }
    return false;
}

// Namespace uav/uav
// Params 1, eflags: 0x0
// Checksum 0xffb7cfe0, Offset: 0x860
// Size: 0x204
function fx_flesh_hit_neck_fatal(params) {
    if (!isdefined(level.var_3d960463) || isdefined(level.var_3d960463) && !params.attacker [[ level.var_3d960463 ]]()) {
        foreach (player in params.players) {
            if (player function_ef80ceac()) {
                foreach (var_ee444909 in level.spawneduavs) {
                    if (player === var_ee444909.owner && var_ee444909 function_457c378e(self)) {
                        scoregiven = scoreevents::processscoreevent(#"uav_assist", player, undefined, undefined);
                        if (isdefined(scoregiven)) {
                            player challenges::earneduavassistscore(scoregiven);
                            killstreakindex = level.killstreakindices[#"uav"];
                            killstreaks::killstreak_assist(player, self, killstreakindex);
                        }
                    }
                }
            }
        }
    }
}

// Namespace uav/uav
// Params 1, eflags: 0x0
// Checksum 0xcb9aee59, Offset: 0xa70
// Size: 0x2c
function hackedprefunction(*hacker) {
    uav = self;
    uav resetactiveuav();
}

// Namespace uav/uav
// Params 2, eflags: 0x0
// Checksum 0xaa8b8a72, Offset: 0xaa8
// Size: 0x9c
function configureteampost(owner, *ishacked) {
    uav = self;
    uav thread teams::waituntilteamchangesingleton(ishacked, "UAV_watch_team_change_" + uav getentitynumber(), &onteamchange, ishacked.entnum, "delete", "death", "leaving");
    ishacked addactiveuav();
}

// Namespace uav/uav
// Params 1, eflags: 0x0
// Checksum 0xf8178af7, Offset: 0xb50
// Size: 0x1e
function function_f724cfe4(health) {
    waitframe(1);
    self.health = health;
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xf45725b, Offset: 0xb78
// Size: 0x898
function activateuav() {
    assert(isdefined(level.players));
    if (self killstreakrules::iskillstreakallowed("uav", self.team) == 0) {
        return false;
    }
    killstreak_id = self killstreakrules::killstreakstart("uav", self.team);
    if (killstreak_id == -1) {
        return false;
    }
    attach_angle = -90;
    minflyheight = killstreaks::function_43f4782d();
    uav = spawn("script_model", self.origin + (0, 0, minflyheight + 1000));
    if (!isdefined(level.spawneduavs)) {
        level.spawneduavs = [];
    } else if (!isarray(level.spawneduavs)) {
        level.spawneduavs = array(level.spawneduavs);
    }
    level.spawneduavs[level.spawneduavs.size] = uav;
    bundle = killstreaks::get_script_bundle("uav");
    uav setmodel(bundle.ksmodel);
    uav setenemymodel(bundle.var_aa0b97e1);
    uav.weapon = getweapon("uav");
    uav setweapon(uav.weapon);
    uav setforcenocull();
    uav.targetname = "uav";
    uav util::make_sentient();
    uav killstreaks::configure_team("uav", killstreak_id, self, undefined, undefined, &configureteampost);
    uav killstreak_hacking::enable_hacking("uav", &hackedprefunction, undefined);
    uav clientfield::set("enemyvehicle", 1);
    killstreak_detect::killstreaktargetset(uav);
    uav setdrawinfrared(1);
    uav.killstreak_id = killstreak_id;
    uav.leaving = 0;
    uav.victimsoundmod = "vehicle";
    uav.var_48d842c3 = 1;
    uav thread killstreaks::function_2b6aa9e8("uav", &destroyuav, &onlowhealth);
    uav thread function_f724cfe4(100000);
    bundle = killstreaks::get_script_bundle("uav");
    uav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "crashing", undefined, 1);
    uav.rocketdamage = uav.maxhealth + 1;
    uav clientfield::set("uav_fx", 1);
    uav clientfield::set("scorestreakActive", 1);
    uav killstreaks::function_a781e8d2();
    if (false) {
        uav killstreaks::function_67d553c4(level.var_b59e7114, isdefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000, isdefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000, -1);
        uav clientfield::set("uav", 1);
    } else {
        if (sessionmodeiswarzonegame()) {
            var_b0490eb9 = getheliheightlockheight(self.origin);
            trace = groundtrace((self.origin[0], self.origin[1], var_b0490eb9), self.origin - (0, 0, 5000), 0, uav);
            groundheight = trace[#"position"][2];
            var_5f8c899e = groundheight + (var_b0490eb9 - groundheight) * bundle.var_ff73e08c;
            var_5f8c899e -= killstreaks::function_43f4782d();
        } else {
            var_5f8c899e = 5000;
        }
        uav.var_b59e7114 = killstreaks::function_f3875fb0(self.origin, isdefined(level.var_eb2556e1) ? level.var_eb2556e1 : var_5f8c899e, 60, -1, 1);
        uav killstreaks::function_67d553c4(uav.var_b59e7114, isdefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000, isdefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000, -1);
        uav.var_b59e7114 clientfield::set("uav", 1);
        uav.var_b59e7114 setteam(uav.team);
    }
    uav killstreakrules::function_2e6ff61a("uav", killstreak_id, {#origin:uav.var_b59e7114.origin, #team:uav.team});
    self stats::function_e24eec31(getweapon("uav"), #"used", 1);
    uav thread killstreaks::waitfortimeout("uav", 30000, &ontimeout, "delete", "death", "crashing");
    uav thread killstreaks::waitfortimecheck(30000 / 2, &ontimecheck, "delete", "death", "crashing");
    uav thread startuavfx();
    self namespace_f9b02f80::play_killstreak_start_dialog("uav", self.team, killstreak_id);
    uav namespace_f9b02f80::play_pilot_dialog_on_owner("arrive", "uav", killstreak_id);
    uav thread killstreaks::player_killstreak_threat_tracking("uav", 0.965926);
    uav thread killstreaks::function_5a7ecb6b();
    return true;
}

// Namespace uav/uav
// Params 2, eflags: 0x0
// Checksum 0xcab85d35, Offset: 0x1418
// Size: 0x94
function onlowhealth(*attacker, *weapon) {
    self.is_damaged = 1;
    params = killstreaks::get_script_bundle("uav");
    if (isdefined(params.fxlowhealth)) {
        playfxontag(params.fxlowhealth, self, "tag_origin");
    }
    self killstreaks::function_8b4513ca();
}

// Namespace uav/uav
// Params 1, eflags: 0x0
// Checksum 0xb0cfc83, Offset: 0x14b8
// Size: 0xe8
function function_457c378e(ent) {
    if (!(isdefined(ent) && isdefined(self))) {
        return;
    }
    bundle = killstreaks::get_script_bundle("uav");
    var_b2231ba3 = sqr((isdefined(bundle.var_dd0e1146) ? bundle.var_dd0e1146 : 0) / 2);
    if (1 && isdefined(self.var_b59e7114)) {
        var_59848c4e = self.var_b59e7114.origin;
    } else {
        var_59848c4e = self.origin;
    }
    return distance2dsquared(ent.origin, var_59848c4e) <= var_b2231ba3;
}

// Namespace uav/uav
// Params 2, eflags: 0x0
// Checksum 0x41ed874b, Offset: 0x15a8
// Size: 0x2c
function onteamchange(*entnum, *event) {
    destroyuav(undefined, undefined);
}

// Namespace uav/uav
// Params 2, eflags: 0x0
// Checksum 0x4abf04ea, Offset: 0x15e0
// Size: 0x36c
function destroyuav(attacker, weapon) {
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
        attacker battlechatter::function_eebf94f6("uav");
        challenges::destroyedaircraft(attacker, weapon, 0, self);
        luinotifyevent(#"player_callout", 2, #"hash_7f902a0b5852fe90", attacker.entnum);
        attacker challenges::addflyswatterstat(weapon, self);
    }
    if (isdefined(self.var_b59e7114)) {
        self.var_b59e7114 delete();
    }
    if (!self.leaving) {
        self removeactiveuav();
        self namespace_f9b02f80::play_destroyed_dialog_on_owner("uav", self.killstreak_id);
    }
    self notify(#"crashing");
    self playsound(#"exp_veh_large");
    params = killstreaks::get_script_bundle("uav");
    if (isdefined(params.ksexplosionfx)) {
        playfxontag(params.ksexplosionfx, self, "tag_origin");
    }
    if (isdefined(params.var_bb6c29b4) && isdefined(weapon) && weapon == getweapon(#"shock_rifle")) {
        playfxontag(params.var_bb6c29b4, self, "tag_origin");
    }
    self killstreaks::function_7d265bd3();
    self stoploopsound();
    self setmodel(#"tag_origin");
    self setenemymodel(#"tag_origin");
    self killstreaks::function_90e951f2();
    if (target_istarget(self)) {
        target_remove(self);
    }
    self unlink();
    wait 0.5;
    arrayremovevalue(level.spawneduavs, self);
    if (isdefined(self)) {
        self notify(#"delete");
        self delete();
    }
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x36c293a7, Offset: 0x1958
// Size: 0x64
function onplayerspawned() {
    self endon(#"disconnect");
    if (level.teambased == 0 || level.multiteam == 1 || level.forceradar == 1) {
        uavtracker();
    }
}

// Namespace uav/uav
// Params 5, eflags: 0x0
// Checksum 0x5e1e51c2, Offset: 0x19c8
// Size: 0x144
function function_9ee62e18(attacker, victim, *weapon, *attackerweapon, *meansofdeath) {
    if (attackerweapon util::isenemyplayer(meansofdeath) && attackerweapon function_ef80ceac() && (!isdefined(level.var_3d960463) || isdefined(level.var_3d960463) && !attackerweapon [[ level.var_3d960463 ]]())) {
        foreach (var_ee444909 in level.spawneduavs) {
            if (attackerweapon === var_ee444909.owner && var_ee444909 function_457c378e(meansofdeath)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace uav/uav
// Params 1, eflags: 0x0
// Checksum 0xf88b0475, Offset: 0x1b18
// Size: 0x1c
function onplayerjoinedteam(*params) {
    hidealluavstosameteam();
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xcc993d1b, Offset: 0x1b40
// Size: 0x26c
function ontimeout() {
    playafterburnerfx();
    if (is_true(self.is_damaged)) {
        params = getscriptbundle(function_6fe2ffad());
        if (isdefined(params.var_3d1f54ee)) {
            playfxontag(params.var_3d1f54ee, self, isdefined(params.var_a559066f) ? params.var_a559066f : "tag_origin");
        }
    }
    self namespace_f9b02f80::play_pilot_dialog_on_owner("timeout", "uav");
    self.leaving = 1;
    self clientfield::set("uav_fx", 0);
    if (isdefined(self.var_b59e7114)) {
        self.var_b59e7114 clientfield::set("uav", 0);
        self.var_b59e7114 delete();
    }
    if (isdefined(level.var_14151f16)) {
        [[ level.var_14151f16 ]](self, 0);
    }
    self removeactiveuav();
    if (sessionmodeiswarzonegame()) {
        var_384be02f = 4000;
    }
    airsupport::leave(10, var_384be02f);
    self util::delay(10 - 3, undefined, &killstreaks::outro_scaling);
    wait 10;
    self killstreaks::function_90e951f2();
    waitframe(1);
    if (target_istarget(self)) {
        target_remove(self);
    }
    arrayremovevalue(level.spawneduavs, self);
    self delete();
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xae850467, Offset: 0x1db8
// Size: 0x34
function ontimecheck() {
    self namespace_f9b02f80::play_pilot_dialog_on_owner("timecheck", "uav", self.killstreak_id);
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xfb29e944, Offset: 0x1df8
// Size: 0xa4
function startuavfx() {
    self endon(#"death");
    wait 0.1;
    if (isdefined(self)) {
        params = getscriptbundle(function_6fe2ffad());
        if (isdefined(params.var_7291f2f7)) {
            playfxontag(params.var_7291f2f7, self, isdefined(params.var_907ff222) ? params.var_907ff222 : "tag_origin");
        }
    }
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x611e3508, Offset: 0x1ea8
// Size: 0x84
function playafterburnerfx() {
    self endon(#"death");
    wait 0.1;
    if (isdefined(self)) {
        self stoploopsound();
        team = util::getotherteam(self.team);
        self playsoundtoteam(#"veh_kls_uav_afterburner", team);
    }
}

// Namespace uav/uav
// Params 1, eflags: 0x0
// Checksum 0xfdebed24, Offset: 0x1f38
// Size: 0x36
function hasuav(team) {
    return isdefined(level.activeuavs[team]) && level.activeuavs[team] > 0;
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x958a5e5f, Offset: 0x1f78
// Size: 0xac
function addactiveuav() {
    assert(isdefined(self.team));
    if (!isdefined(level.activeuavs[self.team])) {
        level.activeuavs[self.team] = 0;
    }
    level.activeuavs[self.team]++;
    if (!isdefined(level.activeplayeruavs[self.entnum])) {
        level.activeplayeruavs[self.entnum] = 0;
    }
    level.activeplayeruavs[self.entnum]++;
    uavtracker();
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x6e068d25, Offset: 0x2030
// Size: 0x54
function removeactiveuav() {
    uav = self;
    uav resetactiveuav();
    uav killstreakrules::killstreakstop("uav", self.originalteam, self.killstreak_id);
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xe6ec6717, Offset: 0x2090
// Size: 0x11c
function resetactiveuav() {
    if (!isdefined(level.activeuavs[self.team])) {
        return;
    }
    level.activeuavs[self.team]--;
    assert(level.activeuavs[self.team] >= 0);
    if (level.activeuavs[self.team] <= 0) {
        level.activeuavs[self.team] = undefined;
    }
    if (isdefined(self.owner) && isdefined(level.activeplayeruavs[self.ownerentnum])) {
        level.activeplayeruavs[self.ownerentnum]--;
        assert(level.activeplayeruavs[self.ownerentnum] >= 0);
        if (level.activeplayeruavs[self.ownerentnum] <= 0) {
            level.activeplayeruavs[self.ownerentnum] = undefined;
        }
    }
    uavtracker();
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x588e4722, Offset: 0x21b8
// Size: 0x29e
function uavtracker() {
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            if (!isdefined(level.activeuavs[team])) {
                setteamspyplane(team, 0);
                continue;
            }
            activeuavs = level.activeuavs[team];
            activeuavsandsatellites = activeuavs + (isdefined(level.activesatellites) ? level.activesatellites[team] : 0);
            setteamspyplane(team, int(min(activeuavs, 2)));
            util::set_team_radar(team, activeuavsandsatellites > 0);
        }
        return;
    }
    foreach (player in level.players) {
        if (!isdefined(level.activeuavs[player.team])) {
            player setclientuivisibilityflag("radar_client", 0);
            player.hasspyplane = 0;
            continue;
        }
        activeuavs = level.activeuavs[player.team];
        activeuavsandsatellites = activeuavs + (isdefined(level.activesatellites) ? level.activesatellites[player.team] : 0);
        player setclientuivisibilityflag("radar_client", activeuavsandsatellites > 0);
        player.hasspyplane = 1;
    }
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x78785e4d, Offset: 0x2460
// Size: 0x90
function hidealluavstosameteam() {
    foreach (uav in level.spawneduavs) {
        if (isdefined(uav)) {
            uav teams::hidetosameteam();
        }
    }
}

