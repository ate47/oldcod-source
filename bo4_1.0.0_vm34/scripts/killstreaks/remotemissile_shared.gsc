#using script_342e0d1a78771d3f;
#using script_5afbda9de6000ad9;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dialog_shared;
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
// Params 1, eflags: 0x0
// Checksum 0x8ba788c3, Offset: 0x3e8
// Size: 0x34c
function init_shared(bundlename) {
    if (!(isdefined(level.var_2d85b616) && level.var_2d85b616) && !isdefined(level.remotemissile_shared)) {
        level.remotemissile_shared = {};
        airsupport::init_shared();
        level.rockets = [];
        killstreak_detect::init_shared();
        if (!isdefined(bundlename)) {
            bundlename = "killstreak_remote_missile";
        }
        bundle = struct::get_script_bundle("killstreak", bundlename);
        killstreaks::register_bundle(bundle, &tryusepredatormissile);
        killstreaks::set_team_kill_penalty_scale("remote_missile", level.teamkillreducedpenalty);
        clientfield::register("missile", "remote_missile_bomblet_fired", 1, 1, "int");
        clientfield::register("missile", "remote_missile_fired", 1, 2, "int");
        clientfield::register("missile", "remote_missile_phase2", 1, 1, "int");
        clientfield::register("toplayer", "remote_missile_screenfx", 1, 1, "int");
        clientfield::register("clientuimodel", "hudItems.remoteMissilePhase2", 1, 1, "int");
        clientfield::register("scriptmover", "hellstorm_camera", 1, 1, "int");
        clientfield::register("scriptmover", "hellstorm_deploy", 1, 1, "int");
        level.missilesforsighttraces = [];
        level.missileremotedeployfx = bundle.var_62c9db4c;
        level.missileremotelaunchvert = 12000;
        level.missileremotelaunchhorz = 7000;
        level.missileremotelaunchtargetdist = 1500;
        level.remote_missile_targets = remote_missile_targets::register("remote_missile_targets");
        level.var_3e65a005 = [];
        for (ti = 0; ti < 6; ti++) {
            level.var_3e65a005[ti] = remote_missile_target_lockon::register("remote_missile_target_lockon" + ti);
        }
        callback::on_spawned(&on_player_spawned);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0x836daecd, Offset: 0x740
// Size: 0x24
function on_player_spawned() {
    self.lockedin = undefined;
    self destroy_missile_hud();
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x4e75aa07, Offset: 0x770
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
    self.remotemissilepilotindex = killstreaks::get_random_pilot_index("remote_missile");
    returnvar = _fire(lifeid, self, team, killstreak_id);
    return returnvar;
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x27199c99, Offset: 0x8c0
// Size: 0x3c
function function_6ba537a7(waittime) {
    self endon(#"disconnect");
    wait waittime;
    lui::screen_fade_in(0.1);
}

// Namespace remotemissile/remotemissile_shared
// Params 4, eflags: 0x0
// Checksum 0x8d286991, Offset: 0x908
// Size: 0xf18
function _fire(lifeid, player, team, killstreak_id) {
    weapon = getweapon(#"remote_missile");
    settings = getscriptbundle(weapon.customsettings);
    streamermodelhint(weapon.var_bb65ee6b, 7);
    remotemissilespawnarray = getentarray("remoteMissileSpawn", "targetname");
    foreach (spawn in remotemissilespawnarray) {
        if (isdefined(spawn.target)) {
            spawn.targetent = getent(spawn.target, "targetname");
        }
    }
    if (remotemissilespawnarray.size > 0) {
        remotemissilespawn = player getbestspawnpoint(remotemissilespawnarray);
    } else {
        remotemissilespawn = undefined;
    }
    if (isdefined(remotemissilespawn)) {
        startpos = remotemissilespawn.origin;
        targetpos = airsupport::getmapcenter();
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
    offset = level.var_2412e4d3 * 200;
    level.var_2412e4d3++;
    if (level.var_2412e4d3 > 3) {
        level.var_2412e4d3 = 0;
    }
    startpos += ((isdefined(level.var_ed094102) ? level.var_ed094102 : 0) + offset, (isdefined(level.var_793192b9) ? level.var_793192b9 : 0) + offset, isdefined(level.var_5646e564) ? level.var_5646e564 : 0);
    var_5f1827c1 = (level.mapcenter[0], level.mapcenter[1], startpos[2]);
    startpos = var_5f1827c1 - (5000, 0, 0);
    fwd = var_5f1827c1 - startpos;
    startangles = vectortoangles(fwd);
    veh = spawn("script_model", startpos);
    /#
        recordent(veh);
    #/
    self killstreaks::play_killstreak_start_dialog("remote_missile", self.pers[#"team"], killstreak_id);
    veh setmodel(weapon.var_bb65ee6b);
    veh setenemymodel(weapon.stowedmodel);
    veh playloopsound("veh_hellstorm_dropship_base");
    var_a2a4614f = veh gettagorigin("tag_camera");
    cam = spawn("script_model", var_a2a4614f);
    cam setmodel(#"tag_origin");
    cam linkto(veh, "tag_camera");
    player clientfield::set_to_player("remote_missile_screenfx", 1);
    cam clientfield::set("hellstorm_camera", 1);
    veh clientfield::set("hellstorm_deploy", 1);
    player clientfield::set("remote_killstreak_static", 1);
    veh moveto(var_5f1827c1, 2.5);
    veh useanimtree("generic");
    veh setanim(#"hash_4b6a7686ae8c1f16", 1);
    if (isdefined(level.var_4ac15ffa)) {
        self [[ level.var_4ac15ffa ]](killstreak_id, team);
    }
    player val::set(#"hellstorm_intro", "show_hud", 0);
    player camerasetposition(cam.origin);
    player camerasetlookat(cam.angles);
    player cameraactivate(1);
    player playsoundtoplayer("veh_hellstorm_bay_doors", player);
    animlen = getanimlength(#"hash_4b6a7686ae8c1f16");
    wait animlen * 0.7;
    thread function_6ba537a7(0.3);
    lui::screen_fade_out(0.1);
    startpos = veh.origin - (0, 0, 30);
    rocket = magicbullet(getweapon(#"remote_missile_missile"), startpos, targetpos, player);
    rocket.forceonemissile = 1;
    forceanglevector = vectornormalize(targetpos - startpos);
    rocket.angles = vectortoangles(forceanglevector);
    rocket missile_settarget(undefined);
    rocket.targetname = "remote_missile";
    rocket killstreaks::configure_team("remote_missile", killstreak_id, self, undefined, undefined, undefined);
    rocket killstreak_hacking::enable_hacking("remote_missile", undefined, &hackedpostfunction);
    killstreak_detect::killstreaktargetset(rocket);
    rocket.hackedhealthupdatecallback = &hackedhealthupdate;
    rocket clientfield::set("enemyvehicle", 1);
    rocket clientfield::set("remote_missile_phase2", 0);
    player clientfield::set_player_uimodel("hudItems.remoteMissilePhase2", 0);
    self clientfield::set_player_uimodel("vehicle.vehicleAttackMode", 0);
    player killstreaks::thermal_glow(1);
    rocket thread handledamage(killstreak_id);
    rocket thread function_3493689b(player);
    player linktomissile(rocket, 1, 1);
    rocket.owner = player;
    rocket.killcament = player;
    player val::reset(#"hellstorm_intro", "show_hud");
    cam clientfield::set("hellstorm_camera", 0);
    veh clientfield::set("hellstorm_deploy", 0);
    waitframe(1);
    cam delete();
    player cameraactivate(0);
    player thread cleanupwaiter(rocket, player.team, killstreak_id);
    player setmodellodbias(isdefined(level.remotemissile_lod_bias) ? level.remotemissile_lod_bias : 12);
    self clientfield::set("operating_predator", 1);
    self stats::function_4f10b697(getweapon(#"remote_missile"), #"used", 1);
    player val::reset(#"remote_missile_fire", "freezecontrols");
    player thread create_missile_hud(rocket);
    rocket thread function_24247628();
    rocket function_73eab378(veh, 0, 0);
    veh unlink();
    fwd = anglestoforward(veh.angles);
    endpos = veh.origin + vectorscale(fwd, 20000);
    time = 5;
    rocket notify(#"hash_2dd8cca4f8f64e9d");
    veh moveto(endpos, time);
    veh thread waitthendelete(time);
    rocket thread watch_missile_kill_z();
    rocket missile_sound_play(player);
    rocket playsound("wpn_remote_missile_launch_npc");
    rocket thread missile_brake_timeout_watch();
    rocket thread missile_sound_impact(player, 3800);
    player thread missile_sound_boost(rocket);
    player thread missile_deploy_watch(rocket);
    player thread remote_missile_game_end_think(rocket, player.team, killstreak_id);
    player thread watch_missile_death(rocket, player.team, killstreak_id);
    player thread sndwatchexplo();
    rocket influencers::create_entity_enemy_influencer("small_vehicle", rocket.team);
    player waittill(#"remotemissle_killstreak_done");
    return true;
}

// Namespace remotemissile/remotemissile_shared
// Params 3, eflags: 0x0
// Checksum 0xdcc9d85, Offset: 0x1828
// Size: 0x8e
function remote_missile_game_end_think(rocket, team, killstreak_id) {
    self endon(#"remotemissle_killstreak_done");
    level waittill(#"game_ended", #"pre_potm");
    self thread function_9313445(rocket, 1, 1, team, killstreak_id);
    self notify(#"remotemissle_killstreak_done");
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x2b0227fb, Offset: 0x18c0
// Size: 0x3fa
function getbestspawnpoint(remotemissilespawnpoints) {
    validenemies = [];
    foreach (spawnpoint in remotemissilespawnpoints) {
        spawnpoint.validplayers = [];
        spawnpoint.spawnscore = 0;
    }
    foreach (player in level.players) {
        if (!isalive(player)) {
            continue;
        }
        if (player.team == self.team) {
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
// Params 0, eflags: 0x0
// Checksum 0x4b6d49b7, Offset: 0x1cc8
// Size: 0x44
function function_24247628() {
    self endon(#"death");
    wait 0.1;
    self clientfield::set("remote_missile_fired", 1);
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0xf5e9ba38, Offset: 0x1d18
// Size: 0xa4
function watch_missile_kill_z() {
    if (!isdefined(level.remotemissile_kill_z)) {
        return;
    }
    rocket = self;
    kill_z = level.remotemissile_kill_z;
    rocket endon(#"remotemissle_killstreak_done");
    rocket endon(#"death");
    while (rocket.origin[2] > kill_z) {
        wait 0.1;
    }
    rocket detonate();
}

// Namespace remotemissile/remotemissile_shared
// Params 3, eflags: 0x0
// Checksum 0x3d6c83c3, Offset: 0x1dc8
// Size: 0x96
function watch_missile_death(rocket, team, killstreak_id) {
    self endon(#"remotemissle_killstreak_done");
    rocket waittill(#"death");
    self thread function_9313445(rocket, 1, 1, team, killstreak_id);
    self thread remotemissile_bda_dialog();
    self notify(#"remotemissle_killstreak_done");
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0xf1781d1e, Offset: 0x1e68
// Size: 0xc
function hackedhealthupdate(hacker) {
    
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x7770745f, Offset: 0x1e80
// Size: 0x3c
function hackedpostfunction(hacker) {
    rocket = self;
    hacker missile_deploy(rocket, 1);
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0x3d946472, Offset: 0x1ec8
// Size: 0x2e
function rotaterig() {
    for (;;) {
        self rotateyaw(-360, 60);
        wait 60;
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0xc921f71a, Offset: 0x1f00
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
// Params 1, eflags: 0x0
// Checksum 0x61f46004, Offset: 0x2018
// Size: 0x4c
function waitthendelete(waittime) {
    self endon(#"delete");
    self endon(#"death");
    wait waittime;
    self delete();
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0x1e8b47e6, Offset: 0x2070
// Size: 0xa6
function function_9cc246bf() {
    rocket = self;
    var_6685d964 = getweapon(#"hash_33be4792feeabece");
    mini_missile = magicbullet(var_6685d964, rocket.origin, rocket.origin + anglestoforward(rocket.angles) * 1000, rocket.owner);
}

// Namespace remotemissile/remotemissile_shared
// Params 3, eflags: 0x0
// Checksum 0x479d65d5, Offset: 0x2120
// Size: 0x288
function function_73eab378(veh, var_86d74465, var_3016e3cc) {
    rocket = self;
    rocket.descend = 0;
    starttime = gettime();
    fire_time = 0;
    missiles_fired = 0;
    var_9bc07092 = 0;
    if (var_86d74465 > 0) {
        time_threshold = var_86d74465;
        var_a1a79032 = 0;
        while (isdefined(rocket)) {
            if (isdefined(rocket.owner) && rocket.owner attackbuttonpressed()) {
                if (!(isdefined(var_a1a79032) && var_a1a79032)) {
                    if (missiles_fired < var_9bc07092) {
                        rocket function_9cc246bf();
                        missiles_fired++;
                    } else {
                        break;
                    }
                }
                if (missiles_fired == var_9bc07092) {
                    fire_time = gettime();
                }
                var_a1a79032 = 1;
            } else {
                var_a1a79032 = 0;
            }
            rocket.origin = veh.origin;
            elapsedtime = gettime() - starttime;
            if (elapsedtime > time_threshold * 1000) {
                break;
            }
            if (fire_time > 0) {
                elapsedtime = gettime() - fire_time;
                if (elapsedtime > var_3016e3cc * 1000) {
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
    rocket.var_304cd1c4 = gettime();
    if (isdefined(level.var_f32b1ce9)) {
        self thread [[ level.var_f32b1ce9 ]](rocket);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 5, eflags: 0x0
// Checksum 0x3effc403, Offset: 0x23b0
// Size: 0x344
function function_9313445(rocket, performplayerkillstreakend, unlink, team, killstreak_id) {
    self notify(#"player_missile_end_singleton");
    self endon(#"player_missile_end_singleton");
    if (isalive(rocket)) {
        if (!(isdefined(rocket.bomblets_deployed) && rocket.bomblets_deployed)) {
            params = spawnstruct();
            params.position = rocket.origin;
            params.var_f100eab4 = 0;
            self thread callback::callback(#"hash_7e19bff37ddc39e3", params);
        }
        rocket influencers::remove_influencers();
        rocket clientfield::set("remote_missile_fired", 0);
        rocket delete();
    }
    self notify(#"snd1stpersonexplo");
    if (isdefined(self)) {
        self thread destroy_missile_hud();
        self clientfield::set_to_player("remote_missile_screenfx", 0);
        self clientfield::set("remote_killstreak_static", 0);
        if (isdefined(performplayerkillstreakend) && performplayerkillstreakend) {
            self playrumbleonentity("grenade_rumble");
            if (level.gameended == 0) {
                self sendkillstreakdamageevent(600);
                self thread hud::fade_to_black_for_x_sec(0, 0.4, 0, 0.1);
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
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0x80ad5819, Offset: 0x2700
// Size: 0xbc
function missile_brake_timeout_watch() {
    rocket = self;
    player = rocket.owner;
    self endon(#"death");
    self waittill(#"missile_brake");
    rocket playsound(#"wpn_remote_missile_brake_npc");
    player playlocalsound(#"wpn_remote_missile_brake_plr");
    wait 1.5;
    if (isdefined(self)) {
        self setmissilebrake(0);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0xa78267b1, Offset: 0x27c8
// Size: 0x3c
function stopondeath(snd) {
    self waittill(#"death");
    if (isdefined(snd)) {
        snd delete();
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 3, eflags: 0x0
// Checksum 0xfa5e5ab1, Offset: 0x2810
// Size: 0x96
function cleanupwaiter(rocket, team, killstreak_id) {
    self endon(#"remotemissle_killstreak_done");
    self waittill(#"joined_team", #"joined_spectators", #"disconnect");
    self thread function_9313445(rocket, 0, 0, team, killstreak_id);
    self notify(#"remotemissle_killstreak_done");
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x410946b9, Offset: 0x28b0
// Size: 0x240
function handledamage(killstreak_id) {
    self endon(#"death", #"deleted");
    self setcandamage(1);
    self.health = 99999;
    for (;;) {
        waitresult = self waittill(#"damage");
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        damage = waitresult.amount;
        if (isdefined(attacker) && isdefined(self.owner)) {
            if (self.owner util::isenemyplayer(attacker)) {
                challenges::destroyedaircraft(attacker, weapon, 1);
                attacker challenges::addflyswatterstat(weapon, self);
                self killstreaks::function_8acf563(attacker, weapon, self.owner);
                attacker stats::function_4f10b697(weapon, #"destroyed_controlled_killstreak", 1);
                self killstreaks::play_destroyed_dialog_on_owner("remote_missile", killstreak_id);
                if (isdefined(level.var_32e3865c)) {
                    self.owner [[ level.var_32e3865c ]](attacker, weapon);
                }
            }
            self.owner sendkillstreakdamageevent(int(damage));
        }
        self influencers::remove_influencers();
        self detonate();
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0xdf48e3fa, Offset: 0x2af8
// Size: 0x64
function rocket_cleanupondeath() {
    entitynumber = self getentitynumber();
    level.rockets[entitynumber] = self;
    self waittill(#"death");
    level.rockets[entitynumber] = undefined;
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x6b7982e9, Offset: 0x2b68
// Size: 0x12c
function function_3493689b(player) {
    self.var_afc442a6 = spawn("script_model", self.origin);
    self.var_afc442a6 setmodel(#"tag_origin");
    self.var_afc442a6 linkto(self);
    self.var_afc442a6 setinvisibletoall();
    self.var_afc442a6 setvisibletoplayer(player);
    self.var_afc442a6 playloopsound(#"hash_1375217a84811e44", 0.5);
    self waittill(#"hash_2dd8cca4f8f64e9d");
    self.var_afc442a6 stoploopsound(0.5);
    self thread stopondeath(self.var_afc442a6);
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x793ad550, Offset: 0x2ca0
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
// Params 1, eflags: 0x0
// Checksum 0x7576c69b, Offset: 0x2ea8
// Size: 0x174
function missile_sound_boost(rocket) {
    self endon(#"remotemissile_done", #"joined_team", #"joined_spectators", #"disconnect");
    self waittill(#"missile_boost");
    if (isdefined(rocket)) {
        rocket playsound(#"wpn_remote_missile_fire_boost_npc");
        rocket.snd_third playloopsound(#"wpn_remote_missile_boost_npc");
        self playlocalsound(#"wpn_remote_missile_fire_boost_plr");
        rocket.snd_first playloopsound(#"wpn_remote_missile_boost_plr");
        self playrumbleonentity("sniper_fire");
        if (rocket.origin[2] - self.origin[2] > 4000) {
            rocket notify(#"stop_impact_sound");
            rocket thread missile_sound_impact(self, 6300);
        }
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 2, eflags: 0x0
// Checksum 0x2a196dca, Offset: 0x3028
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
// Params 0, eflags: 0x0
// Checksum 0x9be54f16, Offset: 0x3108
// Size: 0x9c
function sndwatchexplo() {
    self endon(#"remotemissle_killstreak_done", #"remotemissile_done", #"joined_team", #"joined_spectators", #"disconnect", #"bomblets_deployed");
    self waittill(#"snd1stpersonexplo");
    self playlocalsound(#"wpn_remote_missile_explode_plr");
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0x4b329fb4, Offset: 0x31b0
// Size: 0x34
function missile_sound_deploy_bomblets() {
    self.snd_first playloopsound(#"wpn_remote_missile_loop_plr", 0.5);
}

// Namespace remotemissile/remotemissile_shared
// Params 3, eflags: 0x0
// Checksum 0xf1026b1c, Offset: 0x31f0
// Size: 0x718
function getvalidtargets(rocket, trace, max_targets) {
    pixbeginevent(#"remotemissile_getvts_header");
    targets = [];
    forward = anglestoforward(rocket.angles);
    rocketz = rocket.origin[2];
    mapcenterz = level.mapcenter[2];
    diff = mapcenterz - rocketz;
    ratio = diff / forward[2];
    var_a1851f6b = rocket.origin + forward * ratio;
    rocket.var_a1851f6b = var_a1851f6b;
    pixendevent();
    pixbeginevent(#"remotemissile_getvts_enemies");
    enemies = self getenemies();
    foreach (player in enemies) {
        if (!isplayer(player)) {
            continue;
        }
        if (player.ignoreme === 1) {
            continue;
        }
        if (distance2dsquared(player.origin, var_a1851f6b) < 810000 && !player hasperk(#"specialty_nokillstreakreticle")) {
            if (trace) {
                if (bullettracepassed(player.origin + (0, 0, 60), player.origin + (0, 0, 600), 0, player)) {
                    targets[targets.size] = player;
                }
            } else {
                targets[targets.size] = player;
            }
            if (targets.size >= max_targets) {
                return targets;
            }
        }
    }
    dogs = getentarray("attack_dog", "targetname");
    foreach (dog in dogs) {
        if (dog.team != self.team && distance2dsquared(dog.origin, var_a1851f6b) < 810000) {
            if (trace) {
                if (bullettracepassed(dog.origin + (0, 0, 60), dog.origin + (0, 0, 600), 0, dog)) {
                    targets[targets.size] = dog;
                }
            } else {
                targets[targets.size] = dog;
            }
            if (targets.size >= max_targets) {
                return targets;
            }
        }
    }
    tanks = getentarray("talon", "targetname");
    foreach (tank in tanks) {
        if (tank.team != self.team && distance2dsquared(tank.origin, var_a1851f6b) < 810000) {
            if (trace) {
                if (bullettracepassed(tank.origin + (0, 0, 60), tank.origin + (0, 0, 600), 0, tank)) {
                    targets[targets.size] = tank;
                }
            } else {
                targets[targets.size] = tank;
            }
            if (targets.size >= max_targets) {
                return targets;
            }
        }
    }
    turrets = getentarray("auto_turret", "classname");
    foreach (turret in turrets) {
        if (turret.team != self.team && distance2dsquared(turret.origin, var_a1851f6b) < 810000) {
            if (trace) {
                if (bullettracepassed(turret.origin + (0, 0, 60), turret.origin + (0, 0, 600), 0, turret)) {
                    targets[targets.size] = turret;
                }
            } else {
                targets[targets.size] = turret;
            }
            if (targets.size >= max_targets) {
                return targets;
            }
        }
    }
    pixendevent();
    return targets;
}

// Namespace remotemissile/remotemissile_shared
// Params 2, eflags: 0x0
// Checksum 0xfef19f4e, Offset: 0x3910
// Size: 0x32e
function getbesttarget(rocket, trace) {
    weapon = getweapon(#"remote_missile");
    settings = getscriptbundle(weapon.customsettings);
    target_radius = isdefined(settings.target_radius) ? settings.target_radius : 600;
    best_target = undefined;
    best_dist2 = target_radius * target_radius;
    fwd = anglestoforward(rocket.angles);
    enemies = self getenemies();
    foreach (player in enemies) {
        if (!isplayer(player) || isdefined(player.lockedin) && player.lockedin) {
            continue;
        }
        dir = player.origin - rocket.origin;
        dot = vectordot(dir, fwd);
        proj = rocket.origin + vectorscale(fwd, dot);
        dist2 = distancesquared(player.origin, proj);
        if (dist2 < best_dist2) {
            if (trace && !bullettracepassed(player.origin + (0, 0, 60), player.origin + (0, 0, 600), 0, player)) {
                continue;
            }
            best_target = player;
            best_dist2 = dist2;
        }
    }
    if (isdefined(best_target)) {
        rocket.var_a1851f6b = best_target.origin;
        rocket.aimtarget = best_target;
    } else {
        rocket.var_a1851f6b = rocket.origin + vectorscale(fwd, 3000);
        rocket.aimtarget = undefined;
    }
    targets = [];
    targets[0] = best_target;
    return targets;
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x3dd79eaa, Offset: 0x3c48
// Size: 0x25a
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
            if (!bullettracepassed(target.origin + (0, 0, 60), target.origin + (0, 0, 600), 0, target)) {
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
// Params 1, eflags: 0x0
// Checksum 0x435a859e, Offset: 0x3eb0
// Size: 0x2ac
function create_missile_hud(rocket) {
    player = self;
    if (!level.remote_missile_targets remote_missile_targets::is_open(self)) {
        level.remote_missile_targets remote_missile_targets::open(self);
    }
    player.var_a3ccec6f = [];
    player.var_433859ac = [];
    player_entnum = player getentitynumber();
    for (ti = 0; ti < 6; ti++) {
        player.var_a3ccec6f[ti] = spawnstruct();
        player.var_a3ccec6f[ti].state = 0;
        uifield = level.var_3e65a005[ti];
        if (!uifield remote_missile_target_lockon::is_open(player)) {
            uifield remote_missile_target_lockon::open(player, 1);
        }
        uifield remote_missile_target_lockon::set_clientnum(player, player_entnum);
        uifield remote_missile_target_lockon::set_target_locked(player, 0);
    }
    enemies = getplayers(util::getotherteam(player.team));
    ti = 0;
    foreach (enemy in enemies) {
        if (isplayer(enemy)) {
            entnum = enemy getentitynumber();
            player.var_433859ac[entnum] = ti;
            ti++;
            if (ti >= 6) {
                break;
            }
        }
    }
    rocket.iconindexother = 0;
    self thread targeting_hud_think(rocket);
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0x92c64cc1, Offset: 0x4168
// Size: 0xb6
function destroy_missile_hud() {
    if (level.remote_missile_targets remote_missile_targets::is_open(self)) {
        level.remote_missile_targets remote_missile_targets::close(self);
    }
    for (ti = 0; ti < 6; ti++) {
        if (level.var_3e65a005[ti] remote_missile_target_lockon::is_open(self)) {
            level.var_3e65a005[ti] remote_missile_target_lockon::close(self);
        }
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x4ee2a221, Offset: 0x4228
// Size: 0x54a
function targeting_hud_think(rocket) {
    self endon(#"disconnect", #"remotemissile_done");
    rocket endon(#"death");
    level endon(#"game_ended");
    player = self;
    targets = self getvalidtargets(rocket, 1, 6);
    framessincetargetscan = 0;
    while (true) {
        framessincetargetscan++;
        if (framessincetargetscan > 5) {
            targets = self getvalidtargets(rocket, 1, 6);
            framessincetargetscan = 0;
        }
        enemies = getplayers(util::getotherteam(player.team));
        foreach (target in enemies) {
            var_fa0cbe4c = target getentitynumber();
            ti = player.var_433859ac[var_fa0cbe4c];
            if (isdefined(ti)) {
                player.var_a3ccec6f[ti].state = 0;
            }
        }
        if (targets.size > 0) {
            foreach (target in targets) {
                if (!isdefined(target)) {
                    continue;
                }
                if (isplayer(target)) {
                    if (isalive(target)) {
                        var_fa0cbe4c = target getentitynumber();
                        ti = player.var_433859ac[var_fa0cbe4c];
                        if (isdefined(ti)) {
                            player.var_a3ccec6f[ti].state = 1;
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
                assertmsg("<dev string:x30>");
            }
        }
        enemies = getplayers(util::getotherteam(player.team));
        foreach (target in enemies) {
            var_fa0cbe4c = target getentitynumber();
            ti = player.var_433859ac[var_fa0cbe4c];
            if (isdefined(ti) && isdefined(player.var_a3ccec6f[ti])) {
                level.var_3e65a005[ti] remote_missile_target_lockon::set_clientnum(player, var_fa0cbe4c);
                level.var_3e65a005[ti] remote_missile_target_lockon::set_target_locked(player, player.var_a3ccec6f[ti].state);
            }
        }
        waitframe(1);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x38f1f949, Offset: 0x4780
// Size: 0x14a
function missile_deploy_watch(rocket) {
    self endon(#"disconnect", #"remotemissile_done");
    rocket endon(#"remotemissile_bomblets_launched", #"death");
    level endon(#"game_ended");
    params = level.killstreakbundle[#"remote_missile"];
    var_e57293c3 = isdefined(params.var_bd18b0c2) ? params.var_bd18b0c2 : 3000;
    wait 0.25;
    while (self attackbuttonpressed()) {
        waitframe(1);
    }
    while (true) {
        if (self attackbuttonpressed() || rocket.origin[2] < var_e57293c3) {
            self thread missile_deploy(rocket, 0);
            continue;
        }
        waitframe(1);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 2, eflags: 0x0
// Checksum 0x96194ab9, Offset: 0x48d8
// Size: 0x330
function missile_deploy(rocket, hacked) {
    rocket notify(#"remotemissile_bomblets_launched");
    rocket.bomblets_deployed = 1;
    waitframes = 2;
    targets = self getvalidtargets(rocket, 1, 6);
    var_7afd6664 = getweapon(#"remote_missile_bomblet");
    if (targets.size > 0) {
        foreach (target in targets) {
            self thread fire_bomblet(var_7afd6664, rocket, target, waitframes);
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
    rocket clientfield::set("remote_missile_fired", 2);
    for (i = targets.size; i < 6; i++) {
        self thread fire_random_bomblet(rocket, i % 6, waitframes);
        waitframes++;
    }
    playfx(level.missileremotedeployfx, rocket.origin, anglestoforward(rocket.angles));
    self playrumbleonentity("sniper_fire");
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
// Params 1, eflags: 0x0
// Checksum 0x3e3a08dd, Offset: 0x4c18
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
// Params 0, eflags: 0x0
// Checksum 0x647add6e, Offset: 0x4cf8
// Size: 0x64
function setup_bomblet_map_icon() {
    self endon(#"death");
    wait 0.1;
    self clientfield::set("remote_missile_bomblet_fired", 1);
    self clientfield::set("enemyvehicle", 1);
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x7a578df1, Offset: 0x4d68
// Size: 0x94
function setup_bomblet(bomb) {
    bomb.team = self.team;
    bomb setteam(self.team);
    bomb thread setup_bomblet_map_icon();
    bomb.killcament = self;
    bomb thread function_4e20a5bd(self);
    bomb thread function_a8e459a8(self);
}

// Namespace remotemissile/remotemissile_shared
// Params 4, eflags: 0x0
// Checksum 0xdeced324, Offset: 0x4e08
// Size: 0xcc
function fire_bomblet(weapon, rocket, target, waitframes) {
    origin = rocket.origin;
    targetorigin = target.origin + (0, 0, 50);
    waitframe(waitframes);
    if (isdefined(rocket)) {
        origin = rocket.origin;
    }
    bomb = magicbullet(weapon, origin, targetorigin, self, target, (0, 0, 30));
    setup_bomblet(bomb);
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0xf6416d24, Offset: 0x4ee0
// Size: 0xac
function function_a8e459a8(player) {
    bomblet = self;
    bomblet waittill(#"death");
    if (!isdefined(bomblet)) {
        return;
    }
    params = spawnstruct();
    params.position = bomblet.origin;
    params.var_f100eab4 = 1;
    player thread callback::callback(#"hash_7e19bff37ddc39e3", params);
}

// Namespace remotemissile/remotemissile_shared
// Params 3, eflags: 0x0
// Checksum 0x5addcc8, Offset: 0x4f98
// Size: 0x1f4
function fire_random_bomblet(rocket, quadrant, waitframes) {
    origin = rocket.origin;
    angles = rocket.angles;
    owner = rocket.owner;
    fwd = anglestoforward(rocket.angles);
    aimtarget = rocket.origin + vectorscale(fwd, 3000);
    waitframe(waitframes);
    angle = randomintrange(10 + 60 * quadrant, 50 + 60 * quadrant);
    radius = randomintrange(200, 1000);
    x = min(radius, 850) * cos(angle);
    y = min(radius, 850) * sin(angle);
    bomb = magicbullet(getweapon(#"remote_missile_bomblet"), origin, aimtarget + (x, y, 0), self);
    setup_bomblet(bomb);
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0xf41e734f, Offset: 0x5198
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
// Params 1, eflags: 0x0
// Checksum 0x15c5eb94, Offset: 0x5260
// Size: 0xa0
function function_4e20a5bd(player) {
    player thread cleanup_bombs(self);
    player endon(#"disconnect", #"remotemissile_done", #"death");
    level endon(#"game_ended");
    self waittill(#"death");
    player notify(#"bomblet_exploded");
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0x3d04673b, Offset: 0x5308
// Size: 0x13e
function remotemissile_bda_dialog() {
    if (!(isdefined(self.var_da7e2c4e) && self.var_da7e2c4e)) {
        if (isdefined(self.remotemissilebda)) {
            if (self.remotemissilebda === 1) {
                bdadialog = "kill1";
            } else if (self.remotemissilebda === 2) {
                bdadialog = "kill2";
            } else if (self.remotemissilebda === 3) {
                bdadialog = "kill3";
            } else if (isdefined(self.remotemissilebda) && self.remotemissilebda > 3) {
                bdadialog = "killMultiple";
            }
            wait dialog_shared::mpdialog_value("remoteMissileResultDelay", 1);
            self killstreaks::play_taacom_dialog(bdadialog, "remote_missile", undefined);
        } else {
            wait dialog_shared::mpdialog_value("remoteMissileResultDelay", 1);
            killstreaks::play_taacom_dialog("killNone", "remote_missile", undefined);
        }
        self.remotemissilebda = undefined;
    }
}

