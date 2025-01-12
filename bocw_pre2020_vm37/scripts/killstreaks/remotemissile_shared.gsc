#using script_342e0d1a78771d3f;
#using script_396f7d71538c9677;
#using script_4721de209091b1a6;
#using script_5afbda9de6000ad9;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace remotemissile;

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x5da048f9, Offset: 0x518
// Size: 0x32c
function init_shared(bundlename) {
    if (!is_true(level.var_e3049e92) && !isdefined(level.remotemissile_shared)) {
        level.remotemissile_shared = {};
        airsupport::init_shared();
        level.rockets = [];
        killstreak_detect::init_shared();
        if (!isdefined(bundlename)) {
            bundlename = "killstreak_remote_missile";
        }
        bundle = getscriptbundle(bundlename);
        killstreaks::register_bundle(bundle, &tryusepredatormissile);
        clientfield::register("missile", "remote_missile_brakes", 1, 1, "int");
        clientfield::register("missile", "remote_missile_bomblet_fired", 1, 1, "int");
        clientfield::register("missile", "remote_missile_fired", 1, 2, "int");
        clientfield::register("missile", "remote_missile_phase2", 1, 1, "int");
        clientfield::register("toplayer", "remote_missile_screenfx", 1, 1, "int");
        clientfield::register_clientuimodel("hudItems.remoteMissilePhase2", 1, 1, "int");
        clientfield::register("scriptmover", "hellstorm_camera", 1, 1, "int");
        clientfield::register("scriptmover", "hellstorm_deploy", 1, 1, "int");
        level.missilesforsighttraces = [];
        level.missileremotelaunchvert = 12000;
        level.missileremotelaunchhorz = 7000;
        level.missileremotelaunchtargetdist = 1500;
        level.remote_missile_targets = remote_missile_targets::register();
        level.var_aac98621 = [];
        for (ti = 0; ti < 6; ti++) {
            level.var_aac98621[ti] = remote_missile_target_lockon::register();
        }
        callback::on_spawned(&on_player_spawned);
        callback::on_finalize_initialization(&function_3675de8b);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x30afa406, Offset: 0x850
// Size: 0x48
function function_3675de8b() {
    if (isdefined(level.var_1b900c1d)) {
        [[ level.var_1b900c1d ]](getweapon("remote_missile"), &function_bff5c062);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xb67c53a1, Offset: 0x8a0
// Size: 0xf4
function function_bff5c062(remotemissile, attackingplayer) {
    remotemissile dodamage(1000, remotemissile.origin, attackingplayer);
    if (isdefined(remotemissile.bomblets)) {
        foreach (bomblet in remotemissile.bomblets) {
            if (!isdefined(bomblet)) {
                continue;
            }
            bomblet detonate();
            bomblet notify(#"bombletdestroyed");
        }
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x8a8b2ce9, Offset: 0x9a0
// Size: 0x2c
function on_player_spawned() {
    self.lockedin = undefined;
    self.processed = undefined;
    self destroy_missile_hud();
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x23211a16, Offset: 0x9d8
// Size: 0x142
function tryusepredatormissile(lifeid) {
    waterdepth = self depthofplayerinwater();
    if (!self isonground() || self util::isusingremote() || waterdepth > 2) {
        self iprintlnbold(#"hash_3f750164757cd400");
        return 0;
    }
    team = self.team;
    killstreak_id = self killstreakrules::killstreakstart("remote_missile", team, 0, 1);
    if (killstreak_id == -1) {
        return 0;
    }
    self.remotemissilepilotindex = namespace_f9b02f80::get_random_pilot_index("remote_missile");
    returnvar = _fire(lifeid, self, team, killstreak_id);
    return returnvar;
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf2b8f282, Offset: 0xb28
// Size: 0x3c
function function_203098f4(waittime) {
    self endon(#"disconnect");
    wait waittime;
    lui::screen_fade_in(0.1);
}

// Namespace remotemissile/remotemissile_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x368df4c1, Offset: 0xb70
// Size: 0x1290
function _fire(*lifeid, player, team, killstreak_id) {
    player notify(#"remote_missile_fired");
    weapon = getweapon(#"remote_missile");
    missileweapon = getweapon(#"remote_missile_missile");
    settings = getscriptbundle(weapon.customsettings);
    streamermodelhint(weapon.var_22082a57, 7);
    streamermodelhint(missileweapon.projectilemodel, 7);
    player forcestreambundle(#"p9_fxanim_mp_remote_missile_bundle");
    remotemissilespawnarray = getentarray("remoteMissileSpawn", "targetname");
    foreach (spawn in remotemissilespawnarray) {
        if (isdefined(spawn.target)) {
            spawn.targetent = getent(spawn.target, "targetname");
        }
    }
    if (remotemissilespawnarray.size > 0) {
        remotemissilespawn = player function_af29fe57(remotemissilespawnarray);
    } else {
        remotemissilespawn = undefined;
    }
    if (isdefined(remotemissilespawn)) {
        startpos = remotemissilespawn.origin;
        targetpos = level.mapcenter;
        /#
        #/
        vector = vectornormalize(startpos - targetpos);
        startpos = vector * level.missileremotelaunchvert + targetpos;
    } else {
        upvector = (0, 0, level.missileremotelaunchvert);
        backdist = level.missileremotelaunchhorz;
        targetdist = level.missileremotelaunchtargetdist;
        forward = anglestoforward(player.angles);
        startpos = player.origin + upvector + forward * backdist * -1;
        targetpos = player.origin + forward * targetdist;
    }
    self util::setusingremote("remote_missile");
    self val::set(#"remote_missile_fire", "freezecontrols");
    player disableweaponcycling();
    result = self killstreaks::init_ride_killstreak("remote_missile");
    if (result != "success" || level.gameended) {
        if (result != "disconnect") {
            player val::reset(#"remote_missile_fire", "freezecontrols");
            player killstreaks::clear_using_remote();
            player killstreaks::thermal_glow(0);
            player enableweaponcycling();
            killstreakrules::killstreakstop("remote_missile", team, killstreak_id);
        }
        return false;
    }
    if (isdefined(player)) {
        player callback::callback(#"hash_247d67dbf83dbc1a");
    }
    offset = level.var_46c23c0f * 200;
    level.var_46c23c0f++;
    if (level.var_46c23c0f > 3) {
        level.var_46c23c0f = 0;
    }
    if (sessionmodeiswarzonegame() && isdefined(player)) {
        var_77689551 = (player.origin[0] + (isdefined(level.var_5d4b4923) ? level.var_5d4b4923 : 0) + offset, player.origin[1] + (isdefined(level.var_462a6e1e) ? level.var_462a6e1e : 0) + offset, startpos[2] + (isdefined(level.var_654c4b25) ? level.var_654c4b25 : 0));
    } else {
        var_77689551 = (level.mapcenter[0] + (isdefined(level.var_5d4b4923) ? level.var_5d4b4923 : 0) + offset, level.mapcenter[1] + (isdefined(level.var_462a6e1e) ? level.var_462a6e1e : 0) + offset, startpos[2] + (isdefined(level.var_654c4b25) ? level.var_654c4b25 : 0));
    }
    startpos = var_77689551 - (5000, 0, 0);
    veh = spawn("script_model", startpos);
    veh.weapon = weapon;
    veh setweapon(weapon);
    veh.owner = player;
    veh setowner(player);
    /#
        recordent(veh);
    #/
    self namespace_f9b02f80::play_killstreak_start_dialog("remote_missile", self.pers[#"team"], killstreak_id);
    veh setmodel(weapon.var_22082a57);
    veh setenemymodel(weapon.stowedmodel);
    veh playsound("veh_hellstorm_dropship_boom");
    veh playloopsound("veh_hellstorm_dropship_base");
    var_52df21ae = veh gettagorigin("tag_camera");
    cam = spawn("script_model", var_52df21ae);
    cam setmodel(#"tag_origin");
    cam linkto(veh, "tag_camera");
    cam setowner(player);
    cam clientfield::set("hellstorm_camera", 1);
    player clientfield::set("remote_killstreak_static", 1);
    veh moveto(var_77689551, 2.5);
    player val::set(#"hellstorm_intro", "show_hud", 0);
    player camerasetposition(cam.origin);
    player camerasetlookat(cam.angles);
    player cameraactivate(1);
    while (is_true(level.var_e891c5ba)) {
        waitframe(1);
    }
    veh clientfield::set("hellstorm_deploy", 1);
    veh useanimtree("generic");
    veh setanim(#"hash_21fa3a72d877f87a", 1);
    if (isdefined(level.var_5951cb24)) {
        self [[ level.var_5951cb24 ]](killstreak_id, team);
    }
    player playsoundtoplayer(#"hash_1f70287e92a32746", player);
    animlen = getanimlength(#"hash_21fa3a72d877f87a");
    wait animlen * 0.9;
    if (!isdefined(player)) {
        return false;
    }
    player clientfield::set_to_player("remote_missile_screenfx", 1);
    thread function_203098f4(0.3);
    lui::screen_fade_out(0.1);
    player function_66b6e720(#"p9_fxanim_mp_remote_missile_bundle");
    startpos = veh.origin - (0, 0, 100);
    missileweapon = getweapon(#"remote_missile_missile");
    rocket = magicbullet(missileweapon, startpos, targetpos, player);
    rocket.forceonemissile = 1;
    forceanglevector = vectornormalize(targetpos - startpos);
    rocket.angles = vectortoangles(forceanglevector);
    rocket missile_settarget(undefined);
    var_36c78ec = (-70, 100, 0);
    var_f5a6dd61 = (-70, -100, 0);
    rocket.rocket1 = spawn("script_model", startpos);
    rocket.rocket1 setmodel(missileweapon.projectilemodel);
    rocket.rocket2 = spawn("script_model", startpos);
    rocket.rocket2 setmodel(missileweapon.projectilemodel);
    rocket.rocket1 linkto(rocket, "tag_origin", var_36c78ec);
    rocket.rocket2 linkto(rocket, "tag_origin", var_f5a6dd61);
    rocket.targetname = "remote_missile";
    rocket killstreaks::configure_team("remote_missile", killstreak_id, self, undefined, undefined, undefined);
    rocket killstreak_hacking::enable_hacking("remote_missile", undefined, &hackedpostfunction);
    killstreak_detect::killstreaktargetset(rocket);
    rocket.hackedhealthupdatecallback = &hackedhealthupdate;
    rocket clientfield::set("enemyvehicle", 1);
    rocket clientfield::set("remote_missile_phase2", 0);
    rocket.identifier_weapon = getweapon("remote_missile");
    if (!isdefined(rocket.bomblets)) {
        rocket.bomblets = [];
    }
    player clientfield::set_player_uimodel("hudItems.remoteMissilePhase2", 0);
    self clientfield::set_player_uimodel("vehicle.vehicleAttackMode", 0);
    player killstreaks::thermal_glow(1);
    rocket.killstreak_id = killstreak_id;
    rocket killstreaks::function_2b6aa9e8("remote_missile", &function_b4f589cc);
    player linktomissile(rocket, 1, 1);
    player.rocket = rocket;
    rocket.owner = player;
    rocket.killcament = player;
    player val::reset(#"hellstorm_intro", "show_hud");
    cam clientfield::set("hellstorm_camera", 0);
    veh clientfield::set("hellstorm_deploy", 0);
    waitframe(1);
    if (!isdefined(player)) {
        waitframe(1);
        if (isdefined(rocket)) {
            rocket notify(#"death");
            rocket deletedelay();
        }
        if (isdefined(veh)) {
            veh delete();
        }
        return false;
    }
    cam delete();
    player cameraactivate(0);
    player thread cleanupwaiter(rocket, player.team, killstreak_id);
    player setmodellodbias(isdefined(level.remotemissile_lod_bias) ? level.remotemissile_lod_bias : 12);
    self clientfield::set("operating_predator", 1);
    self stats::function_e24eec31(getweapon(#"remote_missile"), #"used", 1);
    player.var_a8c5fe4e = 1;
    player val::reset(#"remote_missile_fire", "freezecontrols");
    player thread create_missile_hud(rocket);
    rocket thread function_9761dd1d();
    rocket function_17485b5(veh, 0, 0);
    veh unlink();
    fwd = anglestoforward(veh.angles);
    endpos = veh.origin + vectorscale(fwd, 20000);
    time = 5;
    veh moveto(endpos, time);
    veh thread waitthendelete(time);
    rocket thread watch_missile_kill_z();
    rocket missile_sound_play(player);
    rocket playsound("wpn_remote_missile_launch_npc");
    rocket thread missile_brake_timeout_watch();
    rocket thread missile_sound_impact(player, 3800);
    player thread missile_sound_boost(rocket);
    player thread function_8fba4483(rocket);
    player thread remote_missile_game_end_think(rocket, player.team, killstreak_id);
    player thread watch_missile_death(rocket, player.team, killstreak_id);
    player thread sndwatchexplo();
    rocket influencers::create_entity_enemy_influencer("small_vehicle", rocket.team);
    player waittill(#"remotemissle_killstreak_done");
    return true;
}

// Namespace remotemissile/remotemissile_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xddcc4c4, Offset: 0x1e08
// Size: 0x8e
function remote_missile_game_end_think(rocket, team, killstreak_id) {
    self endon(#"remotemissle_killstreak_done");
    level waittill(#"game_ended", #"pre_potm");
    self thread function_97f822ec(rocket, 1, 1, team, killstreak_id);
    self notify(#"remotemissle_killstreak_done");
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x594d62fd, Offset: 0x1ea0
// Size: 0x40a
function function_af29fe57(remotemissilespawnpoints) {
    validenemies = [];
    foreach (spawnpoint in remotemissilespawnpoints) {
        spawnpoint.validplayers = [];
        spawnpoint.spawnscore = 0;
    }
    foreach (player in level.players) {
        if (!isalive(player)) {
            continue;
        }
        if (!player util::isenemyteam(self.team)) {
            continue;
        }
        if (player.team == #"spectator") {
            continue;
        }
        bestdistance = 999999999;
        bestspawnpoint = undefined;
        foreach (spawnpoint in remotemissilespawnpoints) {
            spawnpoint.validplayers[spawnpoint.validplayers.size] = player;
            potentialbestdistance = distance2dsquared(spawnpoint.targetent.origin, player.origin);
            if (potentialbestdistance <= bestdistance) {
                bestdistance = potentialbestdistance;
                bestspawnpoint = spawnpoint;
            }
        }
        bestspawnpoint.spawnscore += 2;
    }
    bestspawn = remotemissilespawnpoints[0];
    foreach (spawnpoint in remotemissilespawnpoints) {
        foreach (player in spawnpoint.validplayers) {
            spawnpoint.spawnscore += 1;
            if (bullettracepassed(player.origin + (0, 0, 32), spawnpoint.origin, 0, player)) {
                spawnpoint.spawnscore += 3;
            }
            if (spawnpoint.spawnscore > bestspawn.spawnscore) {
                bestspawn = spawnpoint;
                continue;
            }
            if (spawnpoint.spawnscore == bestspawn.spawnscore) {
                if (math::cointoss()) {
                    bestspawn = spawnpoint;
                }
            }
        }
    }
    return bestspawn;
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x2306e206, Offset: 0x22b8
// Size: 0x44
function function_9761dd1d() {
    self endon(#"death");
    wait 0.1;
    self clientfield::set("remote_missile_fired", 1);
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x6f59e340, Offset: 0x2308
// Size: 0x9c
function watch_missile_kill_z() {
    if (!isdefined(level.remotemissile_kill_z)) {
        return;
    }
    rocket = self;
    kill_z = level.remotemissile_kill_z;
    rocket endon(#"remotemissle_killstreak_done", #"death");
    while (rocket.origin[2] > kill_z) {
        wait 0.1;
    }
    rocket detonate();
}

// Namespace remotemissile/remotemissile_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x189dec33, Offset: 0x23b0
// Size: 0x136
function watch_missile_death(rocket, team, killstreak_id) {
    self endon(#"remotemissle_killstreak_done");
    var_6c90b45c = rocket.rocket1;
    var_bae2d0ff = rocket.rocket2;
    rocket waittill(#"death");
    if (isdefined(var_6c90b45c)) {
        var_6c90b45c deletedelay();
        if (isdefined(rocket.rocket1)) {
            rocket.rocket1 = undefined;
        }
    }
    if (isdefined(var_bae2d0ff)) {
        var_bae2d0ff deletedelay();
        if (isdefined(rocket.rocket2)) {
            rocket.rocket2 = undefined;
        }
    }
    self thread function_97f822ec(rocket, 1, 1, team, killstreak_id);
    self thread remotemissile_bda_dialog();
    self notify(#"remotemissle_killstreak_done");
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xde2d5ff4, Offset: 0x24f0
// Size: 0xc
function hackedhealthupdate(*hacker) {
    
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x1769ece9, Offset: 0x2508
// Size: 0x34
function hackedpostfunction(hacker) {
    rocket = self;
    hacker missile_deploy(rocket, 1);
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0x7f191da4, Offset: 0x2548
// Size: 0x2e
function rotaterig() {
    for (;;) {
        self rotateyaw(-360, 60);
        wait 60;
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0x7fa2dc3c, Offset: 0x2580
// Size: 0x10e
function swayrig() {
    centerorigin = self.origin;
    for (;;) {
        z = randomintrange(-200, -100);
        time = randomintrange(3, 6);
        self moveto(centerorigin + (0, 0, z), time, 1, 1);
        wait time;
        z = randomintrange(100, 200);
        time = randomintrange(3, 6);
        self moveto(centerorigin + (0, 0, z), time, 1, 1);
        wait time;
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x7969ee52, Offset: 0x2698
// Size: 0x4c
function waitthendelete(waittime) {
    self endon(#"delete", #"death");
    wait waittime;
    self delete();
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x4cb253cf, Offset: 0x26f0
// Size: 0x96
function function_71f4cd34() {
    rocket = self;
    var_d0c52d0b = getweapon(#"hash_33be4792feeabece");
    var_a70219cf = magicbullet(var_d0c52d0b, rocket.origin, rocket.origin + anglestoforward(rocket.angles) * 1000, rocket.owner);
}

// Namespace remotemissile/remotemissile_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x3e2839b9, Offset: 0x2790
// Size: 0x268
function function_17485b5(veh, var_7e0e1fa6, var_3d0e8f5b) {
    rocket = self;
    rocket.descend = 0;
    starttime = gettime();
    fire_time = 0;
    missiles_fired = 0;
    var_ecf86986 = 0;
    if (var_7e0e1fa6 > 0) {
        time_threshold = var_7e0e1fa6;
        var_facd4b29 = 0;
        while (isdefined(rocket)) {
            if (isdefined(rocket.owner) && rocket.owner attackbuttonpressed()) {
                if (!is_true(var_facd4b29)) {
                    if (missiles_fired < var_ecf86986) {
                        rocket function_71f4cd34();
                        missiles_fired++;
                    } else {
                        break;
                    }
                }
                if (missiles_fired == var_ecf86986) {
                    fire_time = gettime();
                }
                var_facd4b29 = 1;
            } else {
                var_facd4b29 = 0;
            }
            rocket.origin = veh.origin;
            elapsedtime = gettime() - starttime;
            if (elapsedtime > time_threshold * 1000) {
                break;
            }
            if (fire_time > 0) {
                elapsedtime = gettime() - fire_time;
                if (elapsedtime > var_3d0e8f5b * 1000) {
                    break;
                }
            }
            waitframe(1);
        }
    }
    rocket clientfield::set("remote_missile_phase2", 1);
    rocket.owner clientfield::set_player_uimodel("hudItems.remoteMissilePhase2", 1);
    rocket.owner clientfield::set_player_uimodel("vehicle.vehicleAttackMode", 1);
    earthquake(0.5, 2, rocket.origin, 200);
    rocket.descend = 1;
    rocket.var_b5bcdb0c = gettime();
    if (isdefined(level.var_dab39bb8)) {
        self thread [[ level.var_dab39bb8 ]](rocket);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 5, eflags: 0x1 linked
// Checksum 0xd9e72deb, Offset: 0x2a00
// Size: 0x3dc
function function_97f822ec(rocket, performplayerkillstreakend, unlink, team, killstreak_id) {
    self notify(#"player_missile_end_singleton");
    self endon(#"player_missile_end_singleton");
    if (isalive(rocket)) {
        if (!is_true(rocket.bomblets_deployed)) {
            params = spawnstruct();
            params.position = rocket.origin;
            params.var_7148a82 = 0;
            self thread callback::callback(#"hash_7e19bff37ddc39e3", params);
        }
        rocket influencers::remove_influencers();
        rocket clientfield::set("remote_missile_fired", 0);
        rocket deletedelay();
        if (isdefined(rocket.rocket1)) {
            rocket.rocket1 deletedelay();
            rocket.rocket1 = undefined;
        }
        if (isdefined(rocket.rocket2)) {
            rocket.rocket2 deletedelay();
            rocket.rocket2 = undefined;
        }
    }
    self notify(#"snd1stpersonexplo");
    if (isdefined(self)) {
        self thread destroy_missile_hud();
        self clientfield::set_to_player("remote_missile_screenfx", 0);
        self clientfield::set("remote_killstreak_static", 0);
        if (is_true(performplayerkillstreakend)) {
            self playrumbleonentity("killstreak_remote_missile_impact_1p");
            if (level.gameended == 0) {
                self sendkillstreakdamageevent(600);
                if (!is_true(self.player_disconnected)) {
                    self thread hud::fade_to_black_for_x_sec(0, 0.4, 0, 0.1);
                }
            }
            if (isdefined(rocket)) {
                rocket hide();
            }
        }
        self clientfield::set("operating_predator", 0);
        self setmodellodbias(0);
        if (unlink) {
            self unlinkfrommissile();
        }
        self notify(#"remotemissile_done");
        self val::reset(#"remote_missile_fire", "freezecontrols");
        self killstreaks::clear_using_remote();
        self killstreaks::thermal_glow(0);
        self enableweaponcycling();
        killstreakrules::killstreakstop("remote_missile", team, killstreak_id);
        self callback::callback(#"hash_72a7670db71677f");
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x22313ca2, Offset: 0x2de8
// Size: 0xf4
function missile_brake_timeout_watch() {
    rocket = self;
    player = rocket.owner;
    self endon(#"death");
    self waittill(#"missile_brake");
    rocket clientfield::set("remote_missile_brakes", 1);
    rocket playsound(#"wpn_remote_missile_brake_npc");
    player playlocalsound(#"wpn_remote_missile_brake_plr");
    wait 1.5;
    if (isdefined(self)) {
        rocket clientfield::set("remote_missile_brakes", 0);
        self setmissilebrake(0);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x595347a0, Offset: 0x2ee8
// Size: 0x3c
function stopondeath(snd) {
    self waittill(#"death");
    if (isdefined(snd)) {
        snd deletedelay();
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x32722676, Offset: 0x2f30
// Size: 0x96
function cleanupwaiter(rocket, team, killstreak_id) {
    self endon(#"remotemissle_killstreak_done");
    self waittill(#"joined_team", #"joined_spectators", #"disconnect");
    self thread function_97f822ec(rocket, 0, 0, team, killstreak_id);
    self notify(#"remotemissle_killstreak_done");
}

// Namespace remotemissile/remotemissile_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x3787c8a, Offset: 0x2fd0
// Size: 0x10c
function function_b4f589cc(attacker, weapon) {
    if (self.owner util::isenemyplayer(attacker)) {
        challenges::destroyedaircraft(attacker, weapon, 1, 1);
        attacker challenges::addflyswatterstat(weapon, self);
        attacker stats::function_e24eec31(weapon, #"destroyed_controlled_killstreak", 1);
        self namespace_f9b02f80::play_destroyed_dialog_on_owner("remote_missile", self.killstreak_id);
        if (isdefined(level.var_feddd85a)) {
            self.owner [[ level.var_feddd85a ]](attacker, weapon);
        }
    }
    self influencers::remove_influencers();
    self detonate();
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0xd72cc3b6, Offset: 0x30e8
// Size: 0x58
function rocket_cleanupondeath() {
    entitynumber = self getentitynumber();
    level.rockets[entitynumber] = self;
    self waittill(#"death");
    level.rockets[entitynumber] = undefined;
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x2e997f64, Offset: 0x3148
// Size: 0x1fc
function missile_sound_play(player) {
    self.snd_first = spawn("script_model", self.origin);
    self.snd_first setmodel(#"tag_origin");
    self.snd_first linkto(self);
    self.snd_first setinvisibletoall();
    self.snd_first setvisibletoplayer(player);
    player playlocalsound(#"hash_520c69ce78db3657");
    self.snd_first playloopsound(#"wpn_remote_missile_loop_plr", 0.5);
    self thread stopondeath(self.snd_first);
    self.snd_third = spawn("script_model", self.origin);
    self.snd_third setmodel(#"tag_origin");
    self.snd_third linkto(self);
    self.snd_third setvisibletoall();
    self.snd_third setinvisibletoplayer(player);
    self.snd_third playloopsound(#"wpn_remote_missile_loop_npc", 0.2);
    self thread stopondeath(self.snd_third);
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x37990e60, Offset: 0x3350
// Size: 0x174
function missile_sound_boost(rocket) {
    self endon(#"remotemissile_done", #"joined_team", #"joined_spectators", #"disconnect");
    self waittill(#"missile_boost");
    if (isdefined(rocket)) {
        rocket playsound(#"wpn_remote_missile_fire_boost_npc");
        rocket.snd_third playloopsound(#"wpn_remote_missile_boost_npc");
        self playlocalsound(#"wpn_remote_missile_fire_boost_plr");
        rocket.snd_first playloopsound(#"wpn_remote_missile_boost_plr");
        self playrumbleonentity("killstreak_remote_missile_boost_1p");
        if (rocket.origin[2] - self.origin[2] > 4000) {
            rocket notify(#"stop_impact_sound");
            rocket thread missile_sound_impact(self, 6300);
        }
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xf91c2eb2, Offset: 0x34d0
// Size: 0xd8
function missile_sound_impact(player, distance) {
    self endon(#"death", #"stop_impact_sound");
    player endon(#"disconnect", #"remotemissile_done", #"joined_team", #"joined_spectators");
    for (;;) {
        if (self.origin[2] - player.origin[2] < distance / 0.525) {
            self playsound(#"wpn_remote_missile_inc");
            return;
        }
        waitframe(1);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xb1b358be, Offset: 0x35b0
// Size: 0x9c
function sndwatchexplo() {
    self endon(#"remotemissle_killstreak_done", #"remotemissile_done", #"joined_team", #"joined_spectators", #"disconnect", #"bomblets_deployed");
    self waittill(#"snd1stpersonexplo");
    self playlocalsound(#"wpn_remote_missile_explode_plr");
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x2bf9bf46, Offset: 0x3658
// Size: 0x34
function missile_sound_deploy_bomblets() {
    self.snd_first playloopsound(#"wpn_remote_missile_loop_plr", 0.5);
}

// Namespace remotemissile/remotemissile_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x631061e6, Offset: 0x3698
// Size: 0x830
function getvalidtargets(rocket, trace, max_targets) {
    pixbeginevent(#"remotemissile_getvts_header");
    targets = [];
    if (isdefined(self.missiles_fired) && self.missiles_fired >= 2) {
        pixendevent();
        return targets;
    }
    forward = anglestoforward(rocket.angles);
    rocketz = rocket.origin[2];
    mapcenterz = level.mapcenter[2];
    diff = mapcenterz - rocketz;
    ratio = diff / forward[2];
    var_7650a84 = rocket.origin + forward * ratio;
    rocket.var_7650a84 = var_7650a84;
    pixendevent();
    pixbeginevent(#"remotemissile_getvts_enemies");
    var_591b6fbd = 90000;
    enemies = self getenemies();
    foreach (player in enemies) {
        if (!isplayer(player)) {
            continue;
        }
        if (player hasperk(#"specialty_nokillstreakreticle")) {
            continue;
        }
        if (player.ignoreme === 1) {
            continue;
        }
        dir = player.origin - rocket.origin;
        dot = vectordot(dir, forward);
        proj = rocket.origin + vectorscale(forward, dot);
        dist2 = distancesquared(player.origin, proj);
        if (dist2 < var_591b6fbd && !player hasperk(#"specialty_nokillstreakreticle")) {
            if (trace) {
                if (bullettracepassed(player.origin + (0, 0, 60), player.origin + (0, 0, 1000), 0, player)) {
                    targets[targets.size] = player;
                }
            } else {
                targets[targets.size] = player;
            }
            if (targets.size >= max_targets) {
                pixendevent();
                return targets;
            }
        }
    }
    dogs = getentarray("attack_dog", "targetname");
    foreach (dog in dogs) {
        if (util::function_fbce7263(dog.team, self.team) && distance2dsquared(dog.origin, var_7650a84) < 90000) {
            if (trace) {
                if (bullettracepassed(dog.origin + (0, 0, 60), dog.origin + (0, 0, 1000), 0, dog)) {
                    targets[targets.size] = dog;
                }
            } else {
                targets[targets.size] = dog;
            }
            if (targets.size >= max_targets) {
                pixendevent();
                return targets;
            }
        }
    }
    tanks = getentarray("talon", "targetname");
    foreach (tank in tanks) {
        if (util::function_fbce7263(tank.team, self.team) && distance2dsquared(tank.origin, var_7650a84) < 90000) {
            if (trace) {
                if (bullettracepassed(tank.origin + (0, 0, 60), tank.origin + (0, 0, 1000), 0, tank)) {
                    targets[targets.size] = tank;
                }
            } else {
                targets[targets.size] = tank;
            }
            if (targets.size >= max_targets) {
                pixendevent();
                return targets;
            }
        }
    }
    turrets = getentarray("auto_turret", "classname");
    foreach (turret in turrets) {
        if (util::function_fbce7263(turret.team, self.team) && distance2dsquared(turret.origin, var_7650a84) < 90000) {
            if (trace) {
                if (bullettracepassed(turret.origin + (0, 0, 60), turret.origin + (0, 0, 1000), 0, turret)) {
                    targets[targets.size] = turret;
                }
            } else {
                targets[targets.size] = turret;
            }
            if (targets.size >= max_targets) {
                pixendevent();
                return targets;
            }
        }
    }
    pixendevent();
    return targets;
}

// Namespace remotemissile/remotemissile_shared
// Params 2, eflags: 0x0
// Checksum 0x4a03a7ec, Offset: 0x3ed0
// Size: 0x328
function getbesttarget(rocket, trace) {
    weapon = getweapon(#"remote_missile");
    settings = getscriptbundle(weapon.customsettings);
    target_radius = isdefined(settings.target_radius) ? settings.target_radius : 600;
    best_target = undefined;
    best_dist2 = target_radius * target_radius;
    fwd = anglestoforward(rocket.angles);
    enemies = self getenemies();
    foreach (player in enemies) {
        if (!isplayer(player) || is_true(player.lockedin)) {
            continue;
        }
        if (player hasperk(#"specialty_nokillstreakreticle")) {
            continue;
        }
        dir = player.origin - rocket.origin;
        dot = vectordot(dir, fwd);
        proj = rocket.origin + vectorscale(fwd, dot);
        dist2 = distancesquared(player.origin, proj);
        if (dist2 < best_dist2) {
            if (trace && !bullettracepassed(player.origin + (0, 0, 60), player.origin + (0, 0, 1000), 0, player)) {
                continue;
            }
            best_target = player;
            best_dist2 = dist2;
        }
    }
    if (isdefined(best_target)) {
        rocket.var_7650a84 = best_target.origin;
        rocket.aimtarget = best_target;
    } else {
        rocket.var_7650a84 = rocket.origin + vectorscale(fwd, 3000);
        rocket.aimtarget = undefined;
    }
    targets = [];
    targets[0] = best_target;
    return targets;
}

// Namespace remotemissile/remotemissile_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xffd86b1d, Offset: 0x4200
// Size: 0x316
function gettarget(rocket, trace) {
    weapon = getweapon(#"remote_missile");
    settings = getscriptbundle(weapon.customsettings);
    target_radius = isdefined(settings.target_radius) ? settings.target_radius : 600;
    best_target = undefined;
    best_dist2 = target_radius * target_radius;
    fwd = anglestoforward(rocket.angles);
    enemies = self getenemies();
    foreach (target in enemies) {
        if (!isplayer(target)) {
            continue;
        }
        if (target hasperk(#"specialty_nokillstreakreticle")) {
            continue;
        }
        if (isdefined(target.processed)) {
            continue;
        }
        var_4ef4e267 = target getentitynumber();
        ti = self.var_ebf52bbc[var_4ef4e267];
        if (!(isdefined(ti) && self.var_bbe80eed[ti].state === 1)) {
            continue;
        }
        dir = target.origin - rocket.origin;
        dot = vectordot(dir, fwd);
        proj = rocket.origin + vectorscale(fwd, dot);
        dist2 = distancesquared(target.origin, proj);
        if (dist2 < best_dist2) {
            if (trace && !bullettracepassed(target.origin + (0, 0, 60), target.origin + (0, 0, 1000), 0, target)) {
                continue;
            }
            best_target = target;
            best_dist2 = dist2;
        }
    }
    return best_target;
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x7743ecb0, Offset: 0x4520
// Size: 0x22a
function checktarget(rocket) {
    target = rocket.aimtarget;
    if (isdefined(target) && isalive(target)) {
        weapon = getweapon(#"remote_missile");
        settings = getscriptbundle(weapon.customsettings);
        target_radius = isdefined(settings.target_radius) ? settings.target_radius : 600;
        cutoff_dist2 = target_radius * target_radius;
        fwd = anglestoforward(rocket.angles);
        dir = target.origin - rocket.origin;
        dot = vectordot(dir, fwd);
        proj = rocket.origin + vectorscale(fwd, dot);
        dist2 = distancesquared(target.origin, proj);
        if (dist2 < cutoff_dist2) {
            if (!bullettracepassed(target.origin + (0, 0, 60), target.origin + (0, 0, 1000), 0, target)) {
                target = undefined;
            }
        } else {
            target = undefined;
        }
    } else {
        target = undefined;
    }
    targets = [];
    if (isdefined(target)) {
        targets[0] = target;
    } else {
        rocket missile_settarget(undefined);
        rocket.aimtarget = undefined;
    }
    return targets;
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf8e2fc14, Offset: 0x4758
// Size: 0x2bc
function create_missile_hud(rocket) {
    player = self;
    if (!level.remote_missile_targets remote_missile_targets::is_open(self)) {
        level.remote_missile_targets remote_missile_targets::open(self);
    }
    player.var_bbe80eed = [];
    player.var_ebf52bbc = [];
    player_entnum = player getentitynumber();
    for (ti = 0; ti < 6; ti++) {
        player.var_bbe80eed[ti] = spawnstruct();
        player.var_bbe80eed[ti].state = 0;
        uifield = level.var_aac98621[ti];
        if (!uifield remote_missile_target_lockon::is_open(player)) {
            uifield remote_missile_target_lockon::open(player, 1);
        }
        uifield remote_missile_target_lockon::set_clientnum(player, player_entnum);
        uifield remote_missile_target_lockon::set_target_locked(player, 0);
        uifield remote_missile_target_lockon::set_ishawktag(player, 0);
    }
    enemies = getplayers();
    ti = 0;
    foreach (enemy in enemies) {
        if (isplayer(enemy) && util::function_fbce7263(player.team, enemy.team)) {
            entnum = enemy getentitynumber();
            player.var_ebf52bbc[entnum] = ti;
            ti++;
            if (ti >= 6) {
                break;
            }
        }
    }
    if (isdefined(rocket)) {
        rocket.iconindexother = 0;
    }
    self thread targeting_hud_think(rocket);
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x936065f4, Offset: 0x4a20
// Size: 0xb4
function destroy_missile_hud() {
    if (level.remote_missile_targets remote_missile_targets::is_open(self)) {
        level.remote_missile_targets remote_missile_targets::close(self);
    }
    for (ti = 0; ti < 6; ti++) {
        if (level.var_aac98621[ti] remote_missile_target_lockon::is_open(self)) {
            level.var_aac98621[ti] remote_missile_target_lockon::close(self);
        }
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xb84d6e98, Offset: 0x4ae0
// Size: 0x198
function function_8fba4483(rocket) {
    self endon(#"disconnect", #"remotemissile_done", #"missile_boost");
    rocket endon(#"death");
    level endon(#"game_ended");
    player = self;
    target = self gettarget(rocket, 1);
    framessincetargetscan = 0;
    self.missiles_fired = 0;
    self clientfield::set_player_uimodel("vehicle.rocketAmmo", 2);
    while (true) {
        framessincetargetscan++;
        if (framessincetargetscan > 3) {
            target = self gettarget(rocket, 1);
            if (isdefined(target)) {
                target.processed = 1;
                function_2c190692(rocket, target);
                self.missiles_fired++;
                self clientfield::set_player_uimodel("vehicle.rocketAmmo", 2 - self.missiles_fired);
                if (self.missiles_fired >= 2) {
                    break;
                }
            }
            framessincetargetscan = 0;
        }
        waitframe(1);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xec1f4e14, Offset: 0x4c80
// Size: 0x56a
function targeting_hud_think(rocket) {
    self endon(#"disconnect", #"remotemissile_done");
    rocket endon(#"death");
    level endon(#"game_ended");
    player = self;
    targets = self getvalidtargets(rocket, 1, 2);
    framessincetargetscan = 0;
    while (true) {
        framessincetargetscan++;
        if (framessincetargetscan > 3) {
            targets = self getvalidtargets(rocket, 1, 2);
            framessincetargetscan = 0;
        }
        enemies = getplayers();
        foreach (target in enemies) {
            if (util::function_fbce7263(player.team, target.team)) {
                var_4ef4e267 = target getentitynumber();
                ti = player.var_ebf52bbc[var_4ef4e267];
                if (isdefined(ti)) {
                    player.var_bbe80eed[ti].state = 0;
                }
            }
        }
        if (targets.size > 0) {
            foreach (target in targets) {
                if (!isdefined(target)) {
                    continue;
                }
                if (isplayer(target)) {
                    if (isalive(target)) {
                        var_4ef4e267 = target getentitynumber();
                        ti = player.var_ebf52bbc[var_4ef4e267];
                        if (isdefined(ti)) {
                            player.var_bbe80eed[ti].state = 1;
                        }
                    }
                    continue;
                }
                if (!isdefined(target.missileiconindex)) {
                    target.missileiconindex = rocket.iconindexother;
                    rocket.iconindexother = (rocket.iconindexother + 1) % 3;
                }
                index = target.missileiconindex;
                if (index == 0) {
                    level.remote_missile_targets remote_missile_targets::set_extra_target_1(self, target getentitynumber());
                    continue;
                }
                if (index == 1) {
                    level.remote_missile_targets remote_missile_targets::set_extra_target_2(self, target getentitynumber());
                    continue;
                }
                if (index == 2) {
                    level.remote_missile_targets remote_missile_targets::set_extra_target_2(self, target getentitynumber());
                    continue;
                }
                assertmsg("<dev string:x38>");
            }
        }
        enemies = getplayers();
        foreach (target in enemies) {
            if (util::function_fbce7263(player.team, target.team)) {
                var_4ef4e267 = target getentitynumber();
                ti = player.var_ebf52bbc[var_4ef4e267];
                if (isdefined(ti) && isdefined(player.var_bbe80eed[ti])) {
                    level.var_aac98621[ti] remote_missile_target_lockon::set_clientnum(player, var_4ef4e267);
                    level.var_aac98621[ti] remote_missile_target_lockon::set_target_locked(player, player.var_bbe80eed[ti].state);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x98b5e687, Offset: 0x51f8
// Size: 0x14a
function missile_deploy_watch(rocket) {
    self endon(#"disconnect", #"remotemissile_done");
    rocket endon(#"remotemissile_bomblets_launched", #"death");
    level endon(#"game_ended");
    params = killstreaks::get_script_bundle("remote_missile");
    var_dc54c0bd = isdefined(params.var_538e1d5) ? params.var_538e1d5 : 3000;
    wait 0.25;
    while (self attackbuttonpressed()) {
        waitframe(1);
    }
    while (true) {
        if (self attackbuttonpressed() || rocket.origin[2] < var_dc54c0bd) {
            self thread missile_deploy(rocket, 0);
            continue;
        }
        waitframe(1);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xa5f622da, Offset: 0x5350
// Size: 0x3c0
function missile_deploy(rocket, hacked) {
    rocket notify(#"remotemissile_bomblets_launched");
    rocket.bomblets_deployed = 1;
    waitframes = 2;
    targets = self getvalidtargets(rocket, 1, 2);
    var_940444a6 = getweapon(#"remote_missile_bomblet");
    if (targets.size > 0) {
        foreach (target in targets) {
            self thread fire_bomblet(var_940444a6, rocket, target, waitframes);
            waitframes++;
        }
    }
    if (rocket.origin[2] - self.origin[2] > 4000) {
        rocket notify(#"stop_impact_sound");
    }
    if (hacked == 1) {
        rocket.originalowner thread hud::fade_to_black_for_x_sec(0, 0.15, 0, 0, "white");
        self notify(#"remotemissile_done");
    }
    rocket hidepart("tag_attach_panel_right", "", 1);
    rocket hidepart("tag_attach_panel_left", "", 1);
    rocket clientfield::set("remote_missile_fired", 2);
    for (i = targets.size; i < 2; i++) {
        self thread fire_random_bomblet(rocket, i % 6, waitframes);
        waitframes++;
    }
    params = getscriptbundle("killstreak_remote_missile");
    if (isdefined(params.var_64cbe61e)) {
        playfx(params.var_64cbe61e, rocket.origin, anglestoforward(rocket.angles));
    }
    self playrumbleonentity("killstreak_remote_missile_bomblet_launch_1p");
    earthquake(0.2, 0.2, rocket.origin, 200);
    if (hacked == 0) {
        self thread hud::fade_to_black_for_x_sec(0, 0.15, 0, 0, "white");
    }
    rocket missile_sound_deploy_bomblets();
    self notify(#"bomblets_deployed");
    if (hacked == 1) {
        rocket notify(#"death");
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x90f479c6, Offset: 0x5720
// Size: 0x27c
function function_2c190692(rocket, target) {
    var_6aece548 = getweapon(#"remote_missile_bomblet");
    origin = rocket.origin;
    targetorigin = target.origin + (0, 0, 50);
    if (isdefined(rocket)) {
        origin = rocket.origin;
    }
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(rocket.rocket1)) {
        origin += (-70, -100, 0);
    } else {
        origin += (-70, 100, 0);
    }
    var_67ee15f2 = magicbullet(var_6aece548, origin, targetorigin, self, target, (0, 0, 30));
    if (isdefined(rocket.rocket1)) {
        rocket.rocket1 delete();
        rocket.rocket1 = undefined;
    } else if (isdefined(rocket.rocket2)) {
        rocket.rocket2 delete();
        rocket.rocket2 = undefined;
    }
    var_67ee15f2 missile_settarget(target);
    var_67ee15f2.team = self.team;
    var_67ee15f2 setteam(self.team);
    params = killstreaks::get_script_bundle("remote_missile");
    if (isdefined(rocket)) {
        if (isdefined(params.var_64cbe61e)) {
            playfx(params.var_64cbe61e, rocket.origin, anglestoforward(rocket.angles));
        }
        self playrumbleonentity("killstreak_remote_missile_bomblet_launch_1p");
        earthquake(0.2, 0.2, rocket.origin, 200);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x5ad8121a, Offset: 0x59a8
// Size: 0xd6
function bomblet_camera_waiter(rocket) {
    self endon(#"disconnect", #"remotemissile_done");
    rocket endon(#"death");
    level endon(#"game_ended");
    delay = getdvarfloat(#"scr_rmbomblet_camera_delaytime", 1);
    self waittill(#"bomblet_exploded");
    wait delay;
    rocket notify(#"death");
    self notify(#"remotemissile_done");
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x5e9b5f54, Offset: 0x5a88
// Size: 0x64
function setup_bomblet_map_icon() {
    self endon(#"death");
    wait 0.1;
    self clientfield::set("remote_missile_bomblet_fired", 1);
    self clientfield::set("enemyvehicle", 1);
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x2cc901bd, Offset: 0x5af8
// Size: 0x84
function setup_bomblet(bomb) {
    bomb.team = self.team;
    bomb setteam(self.team);
    bomb thread setup_bomblet_map_icon();
    bomb.killcament = self;
    bomb thread function_22e29ec5(self);
    bomb thread function_4c8c3b0b(self);
}

// Namespace remotemissile/remotemissile_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x92c1d5a7, Offset: 0x5b88
// Size: 0x184
function fire_bomblet(weapon, rocket, target, waitframes) {
    origin = rocket.origin;
    targetorigin = target.origin + (0, 0, 50);
    waitframe(waitframes);
    if (isdefined(rocket)) {
        origin = rocket.origin;
    }
    if (!isdefined(self) || !isdefined(target)) {
        return;
    }
    bomb = magicbullet(weapon, origin, targetorigin, self, target, (0, 0, 30));
    if (isdefined(rocket) && isdefined(bomb)) {
        if (!isdefined(rocket.bomblets)) {
            rocket.bomblets = [];
        }
        if (!isdefined(rocket.bomblets)) {
            rocket.bomblets = [];
        } else if (!isarray(rocket.bomblets)) {
            rocket.bomblets = array(rocket.bomblets);
        }
        rocket.bomblets[rocket.bomblets.size] = bomb;
    }
    setup_bomblet(bomb);
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xd6c0b034, Offset: 0x5d18
// Size: 0xac
function function_4c8c3b0b(player) {
    self endon(#"bombletdestroyed");
    bomblet = self;
    bomblet waittill(#"death");
    if (!isdefined(bomblet)) {
        return;
    }
    params = spawnstruct();
    params.position = bomblet.origin;
    params.var_7148a82 = 1;
    player thread callback::callback(#"hash_7e19bff37ddc39e3", params);
}

// Namespace remotemissile/remotemissile_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x3880a765, Offset: 0x5dd0
// Size: 0x1ec
function fire_random_bomblet(rocket, quadrant, waitframes) {
    origin = rocket.origin;
    angles = rocket.angles;
    owner = rocket.owner;
    fwd = anglestoforward(rocket.angles);
    aimtarget = rocket.origin + vectorscale(fwd, 3000);
    waitframe(waitframes);
    if (!isdefined(self)) {
        return;
    }
    angle = randomintrange(10 + 60 * quadrant, 50 + 60 * quadrant);
    radius = randomintrange(200, 400);
    x = min(radius, 250) * cos(angle);
    y = min(radius, 250) * sin(angle);
    bomb = magicbullet(getweapon(#"remote_missile_bomblet"), origin, aimtarget + (x, y, 0), self);
    setup_bomblet(bomb);
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x2040b791, Offset: 0x5fc8
// Size: 0xbc
function cleanup_bombs(bomb) {
    player = self;
    bomb endon(#"death");
    player waittill(#"joined_team", #"joined_spectators", #"disconnect", #"delete");
    if (isdefined(bomb)) {
        bomb clientfield::set("remote_missile_bomblet_fired", 0);
        bomb delete();
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf1b1b929, Offset: 0x6090
// Size: 0xa0
function function_22e29ec5(player) {
    player thread cleanup_bombs(self);
    player endon(#"disconnect", #"remotemissile_done", #"death");
    level endon(#"game_ended");
    self waittill(#"death");
    player notify(#"bomblet_exploded");
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xb3328a39, Offset: 0x6138
// Size: 0x1b4
function remotemissile_bda_dialog() {
    waittillframeend();
    self endon(#"disconnect");
    wait battlechatter::mpdialog_value("remoteMissileResultDelay", 0);
    if (!isdefined(self)) {
        return;
    }
    if (!is_true(self.var_5c0f88a5)) {
        if (isdefined(self.remotemissilebda)) {
            if (self.remotemissilebda === 1) {
                bdadialog = "kill1";
            } else if (self.remotemissilebda === 2) {
                bdadialog = "kill2";
            } else if (self.remotemissilebda === 3) {
                bdadialog = "kill3";
            } else if (self.remotemissilebda > 3) {
                bdadialog = "killMultiple";
            }
            taacomdialog = "confirmHit";
        } else if (is_true(self.("remote_missile" + "_hitconfirmed"))) {
            taacomdialog = "confirmHit";
        } else {
            taacomdialog = "confirmMiss";
            bdadialog = "killNone";
        }
        self namespace_f9b02f80::play_taacom_dialog(bdadialog, "remote_missile", undefined);
        self namespace_f9b02f80::play_taacom_dialog(taacomdialog);
        self.remotemissilebda = undefined;
        self.("remote_missile" + "_hitconfirmed") = undefined;
    }
}

