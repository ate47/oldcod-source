#using script_4721de209091b1a6;
#using scripts\core_common\array_shared;
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
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\util;
#using scripts\weapons\heatseekingmissile;

#namespace recon_plane;

// Namespace recon_plane/recon_plane
// Params 0, eflags: 0x6
// Checksum 0x362c6c28, Offset: 0x248
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"recon_plane", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace recon_plane/recon_plane
// Params 0, eflags: 0x5 linked
// Checksum 0xdd149a30, Offset: 0x298
// Size: 0x24c
function private function_70a657d8() {
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            level.var_eb10c6a7[team] = 0;
        }
    } else {
        level.var_eb10c6a7 = [];
    }
    level.var_42ce45d5 = [];
    bundlename = "killstreak_recon_plane";
    if (sessionmodeiswarzonegame()) {
        bundlename += "_wz";
    }
    if (tweakables::gettweakablevalue("killstreak", "allowradardirection")) {
        killstreaks::register_killstreak(bundlename, &function_732dcb56);
    }
    callback::on_connect(&onplayerconnect);
    callback::on_spawned(&onplayerspawned);
    globallogic_score::register_kill_callback(getweapon("recon_plane"), &function_ed29480b);
    callback::add_callback(#"hash_425352b435722271", &fx_flesh_hit_neck_fatal);
    clientfield::register("scriptmover", "recon_plane", 1, 1, "int");
    clientfield::register("scriptmover", "recon_plane_reveal", 1, 1, "int");
    level thread function_bde85071();
}

// Namespace recon_plane/recon_plane
// Params 0, eflags: 0x1 linked
// Checksum 0xe24f01ca, Offset: 0x4f0
// Size: 0x54
function onplayerconnect() {
    self.entnum = self getentitynumber();
    if (!level.teambased) {
        level.var_eb10c6a7[self.entnum] = 0;
    }
    level.var_42ce45d5[self.entnum] = 0;
}

// Namespace recon_plane/recon_plane
// Params 1, eflags: 0x1 linked
// Checksum 0x74513b6b, Offset: 0x550
// Size: 0x2c
function onplayerspawned(*local_client_num) {
    if (!level.teambased) {
        function_65f48f1a(self);
    }
}

// Namespace recon_plane/recon_plane
// Params 1, eflags: 0x1 linked
// Checksum 0xf65c193d, Offset: 0x588
// Size: 0xb0
function function_769ed4e8(ent) {
    if (!(isdefined(ent) && isdefined(self))) {
        return;
    }
    bundle = killstreaks::get_script_bundle("recon_plane");
    var_b2231ba3 = function_a3f6cdac((isdefined(bundle.var_e77ca4a1) ? bundle.var_e77ca4a1 : 0) / 2);
    return distance2dsquared(ent.origin, self.var_23cd2a2f.origin) <= var_b2231ba3;
}

// Namespace recon_plane/recon_plane
// Params 0, eflags: 0x1 linked
// Checksum 0xaaa7ff24, Offset: 0x640
// Size: 0x32
function function_e7ed088a() {
    return isdefined(level.var_42ce45d5[self.entnum]) && level.var_42ce45d5[self.entnum] > 0;
}

// Namespace recon_plane/recon_plane
// Params 5, eflags: 0x1 linked
// Checksum 0xe9284552, Offset: 0x680
// Size: 0x164
function function_ed29480b(attacker, victim, *weapon, *attackerweapon, *meansofdeath) {
    if (attackerweapon util::isenemyplayer(meansofdeath) && attackerweapon function_e7ed088a() && (!isdefined(level.var_3d960463) || isdefined(level.var_3d960463) && !attackerweapon [[ level.var_3d960463 ]]())) {
        arrayremovevalue(level.var_d952ba86, undefined);
        foreach (var_257b2daf in level.var_d952ba86) {
            if (attackerweapon === var_257b2daf.owner && var_257b2daf function_769ed4e8(meansofdeath)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace recon_plane/recon_plane
// Params 1, eflags: 0x1 linked
// Checksum 0xf455c2a0, Offset: 0x7f0
// Size: 0x1bc
function fx_flesh_hit_neck_fatal(params) {
    if (!isdefined(level.var_3d960463) || isdefined(level.var_3d960463) && !params.attacker [[ level.var_3d960463 ]]()) {
        foreach (player in params.players) {
            if (player function_e7ed088a()) {
                arrayremovevalue(level.var_d952ba86, undefined);
                foreach (var_257b2daf in level.var_d952ba86) {
                    if (player === var_257b2daf.owner && var_257b2daf function_769ed4e8(self)) {
                        scoreevents::processscoreevent(#"hash_2bca2bdbbd783d4e", player, undefined, undefined);
                    }
                }
            }
        }
    }
}

// Namespace recon_plane/recon_plane
// Params 0, eflags: 0x1 linked
// Checksum 0xad5db31e, Offset: 0x9b8
// Size: 0x628
function function_732dcb56() {
    if (self killstreakrules::iskillstreakallowed("recon_plane", self.team) == 0) {
        return false;
    }
    killstreak_id = self killstreakrules::killstreakstart("recon_plane", self.team);
    if (killstreak_id == -1) {
        return false;
    }
    self playsoundtoplayer(#"hash_17c47150ae72b926", self);
    bundle = killstreaks::get_script_bundle("recon_plane");
    adjustedpath = function_98e60435(self.origin, bundle);
    startposition = adjustedpath[#"startposition"];
    endposition = adjustedpath[#"endposition"];
    angles = adjustedpath[#"angles"];
    recon_plane = spawn("script_model", startposition);
    if (!isdefined(level.var_d952ba86)) {
        level.var_d952ba86 = [];
    } else if (!isarray(level.var_d952ba86)) {
        level.var_d952ba86 = array(level.var_d952ba86);
    }
    level.var_d952ba86[level.var_d952ba86.size] = recon_plane;
    var_e4467d10 = spawn("script_model", self.origin);
    var_e4467d10 setmodel(#"tag_origin");
    var_e4467d10 setteam(self.team);
    var_e4467d10 clientfield::set("recon_plane_reveal", 1);
    recon_plane.var_23cd2a2f = var_e4467d10;
    weapon = getweapon("recon_plane");
    recon_plane setmodel(bundle.var_c6eab8b5);
    recon_plane setenemymodel(bundle.var_aa0b97e1);
    recon_plane.killstreak_id = killstreak_id;
    recon_plane.owner = self;
    recon_plane.ownerentnum = self getentitynumber();
    recon_plane.team = self.team;
    recon_plane setteam(self.team);
    recon_plane setowner(self);
    recon_plane killstreaks::configure_team("recon_plane", killstreak_id, self, undefined, undefined, &configureteampost);
    recon_plane killstreak_hacking::enable_hacking("recon_plane", &hackedprefunction, undefined);
    recon_plane.targetname = "recon_plane";
    recon_plane.leaving = 0;
    recon_plane.var_c31213a5 = 1;
    recon_plane thread killstreaks::function_2b6aa9e8("recon_plane", &function_e55922df, &onlowhealth);
    recon_plane thread function_f724cfe4(100000);
    recon_plane thread killstreaks::waittillemp(&function_b16d07ad);
    recon_plane.killstreakdamagemodifier = &killstreakdamagemodifier;
    recon_plane.rocketdamage = recon_plane.maxhealth / 3 + 1;
    recon_plane moveto(endposition, 40000 * 0.002);
    recon_plane.angles = angles;
    target_set(recon_plane);
    recon_plane clientfield::set("enemyvehicle", 1);
    recon_plane clientfield::set("recon_plane", 1);
    recon_plane killstreaks::function_a781e8d2();
    recon_plane thread killstreaks::waitfortimeout("recon_plane", 40000, &ontimeout, "death", "crashing");
    recon_plane thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "death", undefined, 1);
    self namespace_f9b02f80::play_killstreak_start_dialog("recon_plane", self.team, killstreak_id);
    recon_plane thread killstreaks::player_killstreak_threat_tracking("recon_plane", 0.984808);
    self stats::function_e24eec31(getweapon("recon_plane"), #"used", 1);
    recon_plane thread killstreaks::function_5a7ecb6b();
    return true;
}

// Namespace recon_plane/recon_plane
// Params 2, eflags: 0x1 linked
// Checksum 0x31378e7a, Offset: 0xfe8
// Size: 0x56c
function function_98e60435(var_d44b8c3e, bundle) {
    var_6e3ae51a = randomfloatrange(isdefined(level.var_84f1b20f) ? level.var_84f1b20f : 90, isdefined(level.var_26837e34) ? level.var_26837e34 : 180);
    startangles = (0, var_6e3ae51a, 0);
    startforward = anglestoforward(startangles);
    if (sessionmodeiswarzonegame()) {
        var_12306a94 = 25000;
        zoffset = var_d44b8c3e[2] + 9500;
    } else {
        var_12306a94 = airsupport::getmaxmapwidth() * 1.5;
        zoffset = killstreaks::function_43f4782d() + 9500;
    }
    if (sessionmodeiswarzonegame()) {
        var_51cabd75 = 180 / 30;
        var_ddd8ddab = var_12306a94 * 2 / (3 - 1);
        var_c8e01926 = undefined;
        var_37db735d = [];
        var_51c6fb78 = 0;
        forward = startforward;
        angles = startangles;
        while (var_51c6fb78 < var_51cabd75) {
            var_59a518e1 = [];
            for (i = 0; i < 3; i++) {
                position = var_d44b8c3e + vectorscale(forward, -1 * var_12306a94 + var_ddd8ddab * i);
                if (i == 0) {
                    var_90aa61b = position;
                }
                var_b0490eb9 = getheliheightlockheight(position);
                if (var_b0490eb9 != position[2]) {
                    var_59a518e1[var_59a518e1.size] = var_b0490eb9;
                }
            }
            if (var_59a518e1.size) {
                var_59a518e1 = array::sort_by_value(var_59a518e1, 1);
                maxheight = var_59a518e1[var_59a518e1.size - 1];
                var_35637e22 = maxheight - var_59a518e1[0];
                trace = groundtrace((var_d44b8c3e[0], var_d44b8c3e[1], maxheight), var_d44b8c3e - (0, 0, 5000), 0, undefined);
                var_6be9958b = trace[#"position"][2];
                var_6b1fb8d9 = var_6be9958b + (maxheight - var_6be9958b) * bundle.var_ff73e08c;
                endposition = var_90aa61b + vectorscale(forward, var_12306a94 * 2);
                if (var_35637e22 < 2000) {
                    adjustedpath[#"startposition"] = (var_90aa61b[0], var_90aa61b[1], var_6b1fb8d9);
                    adjustedpath[#"endposition"] = (endposition[0], endposition[1], var_6b1fb8d9);
                    adjustedpath[#"angles"] = angles;
                    return adjustedpath;
                }
                if (!isdefined(var_c8e01926) || var_35637e22 < var_c8e01926) {
                    var_c8e01926 = var_35637e22;
                    var_af2fe365[#"startposition"] = (var_90aa61b[0], var_90aa61b[1], var_6b1fb8d9);
                    var_af2fe365[#"endposition"] = (endposition[0], endposition[1], var_6b1fb8d9);
                    var_af2fe365[#"angles"] = angles;
                }
            }
            angles += (0, 30, 0);
            forward = anglestoforward(angles);
            var_51c6fb78++;
            waitframe(1);
        }
        if (isdefined(var_af2fe365)) {
            return var_af2fe365;
        }
    }
    adjustedpath[#"startposition"] = var_d44b8c3e + vectorscale(startforward, -1 * var_12306a94) + (0, 0, zoffset);
    adjustedpath[#"endposition"] = var_d44b8c3e + vectorscale(startforward, var_12306a94) + (0, 0, zoffset);
    adjustedpath[#"angles"] = startangles;
    return adjustedpath;
}

// Namespace recon_plane/recon_plane
// Params 1, eflags: 0x1 linked
// Checksum 0xeeb9cd6b, Offset: 0x1560
// Size: 0x1e
function function_f724cfe4(health) {
    waitframe(1);
    self.health = health;
}

// Namespace recon_plane/recon_plane
// Params 1, eflags: 0x1 linked
// Checksum 0xdfcc19fc, Offset: 0x1588
// Size: 0x2c
function hackedprefunction(*hacker) {
    recon_plane = self;
    recon_plane function_cf33d294();
}

// Namespace recon_plane/recon_plane
// Params 2, eflags: 0x1 linked
// Checksum 0x4efe0e29, Offset: 0x15c0
// Size: 0xb4
function configureteampost(owner, *ishacked) {
    recon_plane = self;
    recon_plane thread teams::waituntilteamchangesingleton(ishacked, "ReconPlane_watch_team_change_" + recon_plane getentitynumber(), &onteamchange, self.entnum, "delete", "death", "leaving");
    recon_plane setvisibletoall();
    recon_plane function_e6689aef();
}

// Namespace recon_plane/recon_plane
// Params 2, eflags: 0x1 linked
// Checksum 0xaa455bc6, Offset: 0x1680
// Size: 0x14
function onlowhealth(*attacker, *weapon) {
    
}

// Namespace recon_plane/recon_plane
// Params 2, eflags: 0x1 linked
// Checksum 0xa3083b5b, Offset: 0x16a0
// Size: 0x24
function onteamchange(*entnum, *event) {
    function_e55922df();
}

// Namespace recon_plane/recon_plane
// Params 0, eflags: 0x1 linked
// Checksum 0xf292a41e, Offset: 0x16d0
// Size: 0x1c4
function ontimeout() {
    self namespace_f9b02f80::play_pilot_dialog_on_owner("timeout", "recon_plane");
    self.leaving = 1;
    self function_171f5ed8();
    if (target_istarget(self)) {
        target_remove(self);
    }
    self clientfield::set("recon_plane", 0);
    airsupport::leave(10);
    assert(10 > 3);
    self util::delay(10 - 3, undefined, &killstreaks::function_3696d106);
    wait 10 - 1;
    self killstreaks::function_90e951f2();
    waitframe(1);
    if (isdefined(self)) {
        profilestart();
        if (isdefined(self.var_23cd2a2f)) {
            self.var_23cd2a2f clientfield::set("recon_plane_reveal", 0);
            self.var_23cd2a2f delete();
        }
        profilestop();
        wait 1;
        if (isdefined(self)) {
            arrayremovevalue(level.var_d952ba86, self);
            self delete();
        }
    }
}

// Namespace recon_plane/recon_plane
// Params 2, eflags: 0x1 linked
// Checksum 0x46dd6e12, Offset: 0x18a0
// Size: 0x44
function function_b16d07ad(attacker, *arg) {
    function_e55922df(arg, getweapon(#"emp"));
}

// Namespace recon_plane/recon_plane
// Params 2, eflags: 0x1 linked
// Checksum 0xeaad9627, Offset: 0x18f0
// Size: 0x2f6
function function_e55922df(attacker, weapon) {
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
        attacker battlechatter::function_eebf94f6("recon_plane");
        challenges::destroyedaircraft(attacker, weapon, 0);
        scoreevents::processscoreevent("spy_plane_killjoy", attacker, self.owner, weapon);
        attacker challenges::addflyswatterstat(weapon, self);
        luinotifyevent(#"player_callout", 2, #"hash_18fd62979f21a7de", attacker.entnum);
        if (!self.leaving) {
            self namespace_f9b02f80::play_destroyed_dialog_on_owner("recon_plane", self.killstreak_id);
        }
    }
    self notify(#"crashing");
    params = killstreaks::get_script_bundle("recon_plane");
    if (isdefined(params.ksexplosionfx)) {
        playfxontag(params.ksexplosionfx, self, "tag_origin");
    }
    self killstreaks::function_7d265bd3();
    self killstreaks::function_90e951f2();
    self setmodel(#"tag_origin");
    if (target_istarget(self)) {
        target_remove(self);
    }
    wait 0.5;
    if (isdefined(self)) {
        profilestart();
        if (!self.leaving) {
            self function_171f5ed8();
        }
        self clientfield::set("recon_plane", 0);
        if (isdefined(self.var_23cd2a2f)) {
            self.var_23cd2a2f clientfield::set("recon_plane_reveal", 0);
            self.var_23cd2a2f delete();
        }
        arrayremovevalue(level.var_d952ba86, self);
        self delete();
        profilestop();
    }
}

// Namespace recon_plane/recon_plane
// Params 0, eflags: 0x1 linked
// Checksum 0x501b5cea, Offset: 0x1bf0
// Size: 0x68
function function_e6689aef() {
    if (level.teambased) {
        level.var_eb10c6a7[self.team]++;
    } else {
        level.var_eb10c6a7[self.ownerentnum]++;
    }
    level.var_42ce45d5[self.ownerentnum]++;
    level notify(#"hash_25b529a667fde073");
}

// Namespace recon_plane/recon_plane
// Params 0, eflags: 0x1 linked
// Checksum 0xb31c64a4, Offset: 0x1c60
// Size: 0x44
function function_171f5ed8() {
    self function_cf33d294();
    killstreakrules::killstreakstop("recon_plane", self.originalteam, self.killstreak_id);
}

// Namespace recon_plane/recon_plane
// Params 0, eflags: 0x1 linked
// Checksum 0xe6857438, Offset: 0x1cb0
// Size: 0x168
function function_cf33d294() {
    if (level.teambased) {
        level.var_eb10c6a7[self.team]--;
        assert(level.var_eb10c6a7[self.team] >= 0);
        if (level.var_eb10c6a7[self.team] < 0) {
            level.var_eb10c6a7[self.team] = 0;
        }
    } else if (isdefined(self.ownerentnum)) {
        level.var_eb10c6a7[self.ownerentnum]--;
        assert(level.var_eb10c6a7[self.ownerentnum] >= 0);
        if (level.var_eb10c6a7[self.ownerentnum] < 0) {
            level.var_eb10c6a7[self.ownerentnum] = 0;
        }
    }
    assert(isdefined(self.ownerentnum));
    level.var_42ce45d5[self.ownerentnum]--;
    assert(level.var_42ce45d5[self.ownerentnum] >= 0);
    level notify(#"hash_25b529a667fde073");
}

// Namespace recon_plane/recon_plane
// Params 0, eflags: 0x1 linked
// Checksum 0xf580db66, Offset: 0x1e20
// Size: 0x1b0
function function_bde85071() {
    level endon(#"game_ended");
    while (true) {
        level waittill(#"hash_25b529a667fde073");
        if (level.teambased) {
            foreach (team, _ in level.teams) {
                var_eb10c6a7 = level.var_eb10c6a7[team];
                var_a06a125 = var_eb10c6a7 + (isdefined(level.activeuavs) && isdefined(level.activeuavs[team]) ? level.activeuavs[team] : 0);
                function_e72ac8f4(team, var_eb10c6a7 > 0);
                util::set_team_radar(team, var_a06a125 > 0);
            }
            continue;
        }
        for (i = 0; i < level.players.size; i++) {
            function_65f48f1a(level.players[i]);
        }
    }
}

// Namespace recon_plane/recon_plane
// Params 1, eflags: 0x1 linked
// Checksum 0x4f929a70, Offset: 0x1fd8
// Size: 0xe6
function function_65f48f1a(player) {
    if (!isdefined(player.entnum)) {
        player.entnum = player getentitynumber();
    }
    var_eb10c6a7 = level.var_eb10c6a7[player.entnum];
    var_a06a125 = var_eb10c6a7 + (isdefined(level.activeuavs) && isdefined(level.activeuavs[player.team]) ? level.activeuavs[player.team] : 0);
    player setclientuivisibilityflag("radar_client", var_a06a125 > 0);
    player.var_83266838 = var_eb10c6a7 > 0;
}

// Namespace recon_plane/recon_plane
// Params 12, eflags: 0x1 linked
// Checksum 0x415a7a8a, Offset: 0x20c8
// Size: 0x7c
function killstreakdamagemodifier(damage, *attacker, *direction, *point, smeansofdeath, *tagname, *modelname, *partname, *weapon, *flags, *inflictor, *chargelevel) {
    if (chargelevel == "MOD_PROJECTILE_SPLASH") {
        return 0;
    }
    return inflictor;
}

