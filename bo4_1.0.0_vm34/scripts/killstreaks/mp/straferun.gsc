#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\targetting_delay;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\util;
#using scripts\weapons\heatseekingmissile;

#namespace straferun;

// Namespace straferun/straferun
// Params 0, eflags: 0x2
// Checksum 0x8fa9e4de, Offset: 0x390
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"straferun", &__init__, undefined, #"killstreaks");
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x6d9ff744, Offset: 0x3e0
// Size: 0x2d4
function __init__() {
    level.straferunnumrockets = 8;
    level.straferunrocketdelay = 0.35;
    level.straferungunlookahead = 4000;
    level.straferungunoffset = -800;
    level.straferungunradius = 500;
    level.straferunexitunits = 20000;
    level.straferunmaxstrafes = 6;
    level.straferunflaredelay = 2;
    level.straferunshellshockduration = 2.5;
    level.straferunshellshockradius = 512;
    level.straferunkillsbeforeexit = 10;
    level.straferunnumkillcams = 5;
    level.straferunmodel = "veh_t6_air_a10f";
    level.straferunmodelenemy = "veh_t6_air_a10f_alt";
    level.straferunvehicle = "vehicle_straferun_mp";
    level.straferungunweapon = getweapon(#"straferun_gun");
    level.straferungunsound = "wpn_a10_shot_loop_npc";
    level.straferunrocketweapon = getweapon(#"straferun_rockets");
    level.straferunrockettags = [];
    level.straferunrockettags[0] = "tag_attach_hardpoint_1";
    level.straferunrockettags[1] = "tag_attach_hardpoint_9";
    level.straferunrockettags[2] = "tag_attach_hardpoint_2";
    level.straferunrockettags[3] = "tag_attach_hardpoint_8";
    level.straferuncontrailfx = "_t7/killstreaks/fx_wh_contrail";
    level.var_7326daad = "killstreaks/fx_wh_chaff_trail";
    level.straferunexplodefx = "destruct/fx8_atk_chppr_exp";
    level.straferunexplodesound = "evt_helicopter_midair_exp";
    level.straferunshellshock = "straferun";
    killstreaks::register_killstreak("killstreak_straferun", &usekillstreakstraferun);
    killstreaks::register_alt_weapon("straferun", level.straferungunweapon);
    killstreaks::register_alt_weapon("straferun", level.straferunrocketweapon);
    createkillcams(level.straferunnumkillcams, level.straferunnumrockets);
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0x1e6031d7, Offset: 0x6c0
// Size: 0x4c0
function usekillstreakstraferun(hardpointtype) {
    startnode = getvehiclenode("warthog_start", "targetname");
    if (!isdefined(startnode)) {
        println("<dev string:x30>");
        return false;
    }
    killstreak_id = self killstreakrules::killstreakstart("straferun", self.team, 0, 0);
    if (killstreak_id == -1) {
        return false;
    }
    plane = spawnvehicle(level.straferunvehicle, startnode.origin, (0, 0, 0), "straferun");
    plane.attackers = [];
    plane.attackerdata = [];
    plane.attackerdamage = [];
    plane.flareattackerdamage = [];
    plane killstreaks::configure_team("straferun", killstreak_id, self);
    plane setenemymodel(level.straferunmodelenemy);
    plane makevehicleunusable();
    plane thread cleanupondeath(plane.team);
    plane.health = 999999;
    plane.maxhealth = 999999;
    plane clientfield::set("enemyvehicle", 1);
    plane.numstrafes = 0;
    plane.numflares = 1;
    plane.soundmod = "straferun";
    plane setdrawinfrared(1);
    self.straferunkills = 0;
    self.straferunbda = 0;
    self killstreaks::play_killstreak_start_dialog("straferun", self.pers[#"team"], killstreak_id);
    self stats::function_4f10b697(getweapon(#"straferun"), #"used", 1);
    plane thread function_56ca8b1b();
    target_set(plane, (0, 0, 0));
    plane.gunsoundentity = spawn("script_model", plane gettagorigin("tag_flash"));
    plane.gunsoundentity linkto(plane, "tag_flash", (0, 0, 0), (0, 0, 0));
    if (!issentient(plane)) {
        plane makesentient();
        plane.ignoreme = 1;
    }
    plane resetkillcams();
    plane thread watchforotherkillstreaks();
    plane thread watchforkills();
    plane thread watchdamage();
    plane thread dostraferuns();
    plane thread vehicle::get_on_and_go_path(startnode);
    plane thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("death");
    plane thread watchforownerexit(self);
    plane thread targetting_delay::function_3362444f(12000);
    util::function_d1f9db00(21, self.team, self getentitynumber(), level.killstreaks[#"straferun"].uiname);
    return true;
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0xf093a415, Offset: 0xb88
// Size: 0x6c
function playcontrail() {
    self endon(#"death");
    wait 0.1;
    playfxontag(level.straferuncontrailfx, self, "tag_origin");
    self playloopsound(#"veh_a10_engine_loop", 1);
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0x53142481, Offset: 0xc00
// Size: 0x8e
function cleanupondeath(team) {
    self waittill(#"death");
    killstreakrules::killstreakstop("straferun", team, self.killstreakid);
    if (isdefined(self.gunsoundentity)) {
        self.gunsoundentity stoploopsound();
        self.gunsoundentity delete();
        self.gunsoundentity = undefined;
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x662bf834, Offset: 0xc98
// Size: 0x292
function watchdamage() {
    self endon(#"death");
    self.maxhealth = 999999;
    self.health = self.maxhealth;
    self.maxhealth = 1000;
    low_health = 0;
    damage_taken = 0;
    for (;;) {
        waitresult = self waittill(#"damage");
        attacker = waitresult.attacker;
        mod = waitresult.mod;
        damage = waitresult.amount;
        weapon = waitresult.weapon;
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        /#
            self.damage_debug = damage + "<dev string:x5c>" + weapon.name + "<dev string:x5f>";
        #/
        if (mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE") {
            damage += 1000;
        }
        if (!issentient(self) && damage > 0) {
            self.attacker = attacker;
        }
        damage_taken += damage;
        if (damage_taken >= 1000) {
            self thread explode();
            if (self.owner util::isenemyplayer(attacker)) {
                attacker battlechatter::function_b5530e2c("straferun", weapon);
                self killstreaks::play_destroyed_dialog_on_owner("straferun", self.killstreak_id);
                self killstreaks::function_8acf563(attacker, weapon, self.owner);
                attacker challenges::addflyswatterstat(weapon, self);
            }
            return;
        }
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x372533b9, Offset: 0xf38
// Size: 0x14e
function watchforotherkillstreaks() {
    self endon(#"death");
    for (;;) {
        waitresult = level waittill(#"killstreak_started");
        hardpointtype = waitresult.hardpoint_type;
        teamname = waitresult.team;
        attacker = waitresult.attacker;
        if (!isdefined(self.owner)) {
            self thread explode();
            return;
        }
        if (hardpointtype == "emp") {
            if (self.owner util::isenemyplayer(attacker)) {
                self thread explode();
                attacker challenges::addflyswatterstat(hardpointtype, self);
                return;
            }
            continue;
        }
        if (hardpointtype == "missile_swarm") {
            if (self.owner util::isenemyplayer(attacker)) {
                self.leavenexttime = 1;
            }
        }
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x908c8fdd, Offset: 0x1090
// Size: 0x56
function watchforkills() {
    self endon(#"death");
    for (;;) {
        waitresult = self waittill(#"killed");
        if (isplayer(waitresult.victim)) {
        }
    }
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0x56baa895, Offset: 0x10f0
// Size: 0x62
function watchforownerexit(owner) {
    self endon(#"death");
    owner waittill(#"disconnect", #"joined_team", #"joined_spectators");
    self.leavenexttime = 1;
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x5ae72152, Offset: 0x1160
// Size: 0x24
function addstraferunkill() {
    if (!isdefined(self.straferunkills)) {
        self.straferunkills = 0;
    }
    self.straferunkills++;
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0xf6236be6, Offset: 0x1190
// Size: 0x2a8
function dostraferuns() {
    self endon(#"death");
    for (;;) {
        waitresult = self waittill(#"noteworthy");
        noteworthy = waitresult.noteworthy;
        noteworthynode = waitresult.noteworthy_node;
        if (noteworthy == "strafe_start") {
            self.straferungunlookahead = level.straferungunlookahead;
            self.straferungunradius = level.straferungunradius;
            self.straferungunoffset = level.straferungunoffset;
            /#
                self.straferungunlookahead = getdvarint(#"scr_straferunlookahead", level.straferungunlookahead);
                self.straferungunradius = getdvarint(#"scr_straferunradius", level.straferungunradius);
                self.straferungunoffset = getdvarint(#"scr_straferunoffset", level.straferungunoffset);
            #/
            if (isdefined(noteworthynode)) {
                if (isdefined(noteworthynode.script_parameters)) {
                    self.straferungunlookahead = float(noteworthynode.script_parameters);
                }
                if (isdefined(noteworthynode.script_radius)) {
                    self.straferungunradius = float(noteworthynode.script_radius);
                }
                if (isdefined(noteworthynode.script_float)) {
                    self.straferungunoffset = float(noteworthynode.script_float);
                }
            }
            if (isdefined(self.owner)) {
                self thread startstrafe();
            }
            continue;
        }
        if (noteworthy == "strafe_stop") {
            self stopstrafe();
            continue;
        }
        if (noteworthy == "strafe_leave") {
            if (self shouldleavemap()) {
                if (!(isdefined(self.leavenexttime) && self.leavenexttime)) {
                    self killstreaks::play_taacom_dialog_response_on_owner("timeoutConfirmed", "straferun", self.killstreakid);
                }
                self thread leavemap();
            }
        }
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x44f06f6d, Offset: 0x1440
// Size: 0x90
function function_56ca8b1b() {
    self endon(#"death");
    self endon(#"strafe_stop");
    while (true) {
        self waittill(#"flare_deployed");
        if (!(isdefined(self.leavenexttime) && self.leavenexttime)) {
            self killstreaks::play_pilot_dialog_on_owner("damageEvaded", "straferun", self.killstreakid);
        }
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x2fefe7bd, Offset: 0x14d8
// Size: 0x474
function startstrafe() {
    self endon(#"death");
    self endon(#"strafe_stop");
    if (isdefined(self.strafing)) {
        iprintlnbold("TRYING TO STRAFE WHEN ALREADY STRAFING!\n");
        return;
    }
    self.strafing = 1;
    if (!(isdefined(self.leavenexttime) && self.leavenexttime)) {
        if (self.numstrafes == 0) {
            self killstreaks::play_pilot_dialog_on_owner("arrive", "straferun", self.killstreak_id);
        } else if (self.numstrafes == level.straferunmaxstrafes - 1) {
            self killstreaks::play_pilot_dialog_on_owner("waveStartFinal", "straferun", self.killstreakid);
        } else {
            self killstreaks::play_pilot_dialog_on_owner("waveStart", "straferun", self.killstreakid);
        }
    }
    self thread firerockets();
    self thread function_59173a32();
    count = 0;
    weaponshoottime = level.straferungunweapon.firetime;
    for (;;) {
        gunorigin = self gettagorigin("tag_flash");
        gunorigin += (0, 0, self.straferungunoffset);
        forward = anglestoforward(self.angles);
        forwardnoz = vectornormalize((forward[0], forward[1], 0));
        right = vectorcross(forwardnoz, (0, 0, 1));
        perfectattackstartvector = gunorigin + vectorscale(forwardnoz, self.straferungunlookahead);
        attackstartvector = perfectattackstartvector + vectorscale(right, randomfloatrange(0 - self.straferungunradius, self.straferungunradius));
        trace = bullettrace(attackstartvector, (attackstartvector[0], attackstartvector[1], -500), 0, self, 0);
        self turretsettarget(0, trace[#"position"]);
        self fireweapon();
        self shellshockplayers(trace[#"position"]);
        /#
            if (getdvarint(#"scr_devstraferunbulletsdebugdraw", 0)) {
                time = 300;
                airsupport::debug_line(attackstartvector, trace[#"position"] - (0, 0, 20), (1, 0, 0), time, 0);
                if (count % 30 == 0) {
                    trace = bullettrace(perfectattackstartvector, (perfectattackstartvector[0], perfectattackstartvector[1], -100000), 0, self, 0, 1);
                    airsupport::debug_line(trace[#"position"] + (0, 0, 20), trace[#"position"] - (0, 0, 20), (0, 0, 1), time, 0);
                }
            }
        #/
        count++;
        wait weaponshoottime;
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1958
// Size: 0x4
function firststrafe() {
    
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x84734ede, Offset: 0x1968
// Size: 0x3a2
function firerockets() {
    self notify(#"firing_rockets");
    self endon(#"death");
    self endon(#"strafe_stop");
    self endon(#"firing_rockets");
    self.owner endon(#"disconnect");
    forward = anglestoforward(self.angles);
    self.firedrockettargets = [];
    for (rocketindex = 0; rocketindex < level.straferunnumrockets; rocketindex++) {
        rockettag = level.straferunrockettags[rocketindex % level.straferunrockettags.size];
        targets = getvalidtargets();
        rocketorigin = self gettagorigin(rockettag);
        targetorigin = rocketorigin + forward * 10000;
        if (targets.size > 0) {
            selectedtarget = undefined;
            foreach (target in targets) {
                alreadyattacked = 0;
                foreach (oldtarget in self.firedrockettargets) {
                    if (oldtarget == target) {
                        alreadyattacked = 1;
                        break;
                    }
                }
                if (!alreadyattacked) {
                    selectedtarget = target;
                    break;
                }
            }
            if (isdefined(selectedtarget)) {
                self.firedrockettargets[self.firedrockettargets.size] = selectedtarget;
                targetorigin = deadrecontargetorigin(rocketorigin, selectedtarget);
            }
        }
        rocketorigin = self gettagorigin(rockettag);
        rocket = magicbullet(level.straferunrocketweapon, rocketorigin, rocketorigin + forward, self);
        if (isdefined(selectedtarget)) {
            rocket missile_settarget(selectedtarget, (0, 0, 0));
        }
        rocket.soundmod = "straferun";
        rocket attachkillcamtorocket(level.straferunkillcams.rockets[rocketindex], selectedtarget, targetorigin);
        /#
            if (getdvarint(#"scr_devstraferunkillcamsdebugdraw", 0)) {
                rocket thread airsupport::debug_draw_bomb_path(undefined, (0, 0.5, 0), 400);
            }
        #/
        wait level.straferunrocketdelay;
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0xc3e0d3de, Offset: 0x1d18
// Size: 0x1c8
function stopstrafe() {
    self notify(#"strafe_stop");
    self.strafing = undefined;
    self thread resetkillcams(3);
    self turretcleartarget(0);
    owner = self.owner;
    if (!isdefined(owner)) {
        return;
    }
    if (owner.straferunbda == 0) {
        bdadialog = "killNone";
    } else if (owner.straferunbda == 1) {
        bdadialog = "kill1";
    } else if (owner.straferunbda == 2) {
        bdadialog = "kill2";
    } else if (owner.straferunbda == 3) {
        bdadialog = "kill3";
    } else if (owner.straferunbda > 3) {
        bdadialog = "killMultiple";
    }
    if (isdefined(bdadialog) && !(isdefined(self.leavenexttime) && self.leavenexttime)) {
        self killstreaks::play_pilot_dialog_on_owner(bdadialog, "straferun", self.killstreakid);
    }
    owner.straferunbda = 0;
    self.gunsoundentity stoploopsound();
    self.gunsoundentity playsound(#"wpn_a10_shot_decay_npc");
    self.numstrafes++;
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x510d708d, Offset: 0x1ee8
// Size: 0x64
function shouldleavemap() {
    if (isdefined(self.leavenexttime) && self.leavenexttime) {
        return true;
    }
    if (self.numstrafes >= level.straferunmaxstrafes) {
        return true;
    }
    if (self.owner.straferunkills >= level.straferunkillsbeforeexit) {
        return true;
    }
    return false;
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x532ecba4, Offset: 0x1f58
// Size: 0xb4
function leavemap() {
    self unlinkkillcams();
    exitorigin = self.origin + vectorscale(anglestoforward(self.angles), level.straferunexitunits);
    self setyawspeed(5, 999, 999);
    self setgoal(exitorigin, 1);
    wait 5;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0xedc9ccc4, Offset: 0x2018
// Size: 0xac
function explode() {
    self endon(#"delete");
    forward = self.origin + (0, 0, 100) - self.origin;
    playfx(level.straferunexplodefx, self.origin, forward);
    self playsound(level.straferunexplodesound);
    wait 0.1;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0x47fbc34e, Offset: 0x20d0
// Size: 0xa6
function cantargetentity(entity) {
    heli_centroid = self.origin + (0, 0, -160);
    heli_forward_norm = anglestoforward(self.angles);
    heli_turret_point = heli_centroid + 144 * heli_forward_norm;
    visible_amount = entity sightconetrace(heli_turret_point, self);
    if (visible_amount < level.heli_target_recognition) {
        return false;
    }
    return true;
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0xd2be2498, Offset: 0x2180
// Size: 0x202
function cantargetplayer(player) {
    if (!isalive(player) || player.sessionstate != "playing") {
        return 0;
    }
    if (player == self.owner) {
        return 0;
    }
    if (player airsupport::cantargetplayerwithspecialty() == 0) {
        return 0;
    }
    if (!isdefined(player.team)) {
        return 0;
    }
    if (level.teambased && player.team == self.team) {
        return 0;
    }
    if (player.team == #"spectator") {
        return 0;
    }
    if (isdefined(player.spawntime) && float(gettime() - player.spawntime) / 1000 <= level.heli_target_spawnprotection) {
        return 0;
    }
    if (!targetinfrontofplane(player)) {
        return 0;
    }
    if (player isinmovemode("noclip")) {
        return 0;
    }
    var_56b0611 = self targetting_delay::function_3b2437d9(player);
    self targetting_delay::function_4ba58de4(player, int((isdefined(level.straferunrocketdelay) ? level.straferunrocketdelay : 0.35) * 1000));
    if (!var_56b0611) {
        return 0;
    }
    return cantargetentity(player);
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0x1ad3bb2d, Offset: 0x2390
// Size: 0xa2
function cantargetactor(actor) {
    if (!isdefined(actor)) {
        return 0;
    }
    if (level.teambased && actor.team == self.team) {
        return 0;
    }
    if (isdefined(actor.script_owner) && self.owner == actor.script_owner) {
        return 0;
    }
    if (!targetinfrontofplane(actor)) {
        return 0;
    }
    return cantargetentity(actor);
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0x507b4b0f, Offset: 0x2440
// Size: 0x98
function targetinfrontofplane(target) {
    forward_dir = anglestoforward(self.angles);
    target_delta = vectornormalize(target.origin - self.origin);
    dot = vectordot(forward_dir, target_delta);
    if (dot < 0.5) {
        return true;
    }
    return true;
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0xcb594544, Offset: 0x24e0
// Size: 0x158
function getvalidtargets() {
    targets = [];
    foreach (player in level.players) {
        if (self cantargetplayer(player)) {
            if (isdefined(player)) {
                targets[targets.size] = player;
            }
        }
    }
    tanks = getentarray("talon", "targetname");
    foreach (tank in tanks) {
        if (self cantargetactor(tank)) {
            targets[targets.size] = tank;
        }
    }
    return targets;
}

// Namespace straferun/straferun
// Params 2, eflags: 0x0
// Checksum 0xe8d8aeb3, Offset: 0x2640
// Size: 0xb2
function deadrecontargetorigin(rocket_start, target) {
    target_velocity = target getvelocity();
    missile_speed = 7000;
    target_delta = target.origin - rocket_start;
    target_dist = length(target_delta);
    time_to_target = target_dist / missile_speed;
    return target.origin + target_velocity * time_to_target;
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0x7f051d0d, Offset: 0x2700
// Size: 0x138
function shellshockplayers(origin) {
    foreach (player in level.players) {
        if (!isalive(player)) {
            continue;
        }
        if (player == self.owner) {
            continue;
        }
        if (!isdefined(player.team)) {
            continue;
        }
        if (level.teambased && player.team == self.team) {
            continue;
        }
        if (distancesquared(player.origin, origin) <= level.straferunshellshockradius * level.straferunshellshockradius) {
            player thread straferunshellshock(self);
        }
    }
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0xfcaa17e2, Offset: 0x2840
// Size: 0xd2
function straferunshellshock(straferun) {
    self endon(#"disconnect");
    if (isdefined(self.beingstraferunshellshocked) && self.beingstraferunshellshocked) {
        return;
    }
    self.beingstraferunshellshocked = 1;
    params = getstatuseffect("deaf_straferun");
    self status_effect::status_effect_apply(params, level.straferunrocketweapon, straferun.owner, 0, int(level.straferunshellshockduration * 1000));
    wait level.straferunshellshockduration + 1;
    self.beingstraferunshellshocked = 0;
}

// Namespace straferun/straferun
// Params 2, eflags: 0x0
// Checksum 0x54edcf4b, Offset: 0x2920
// Size: 0x17e
function createkillcams(numkillcams, numrockets) {
    if (!isdefined(level.straferunkillcams)) {
        level.straferunkillcams = spawnstruct();
        level.straferunkillcams.rockets = [];
        for (i = 0; i < numrockets; i++) {
            level.straferunkillcams.rockets[level.straferunkillcams.rockets.size] = createkillcament();
        }
        level.straferunkillcams.strafes = [];
        for (i = 0; i < numkillcams; i++) {
            level.straferunkillcams.strafes[level.straferunkillcams.strafes.size] = createkillcament();
            /#
                if (getdvarint(#"scr_devstraferunkillcamsdebugdraw", 0)) {
                    level.straferunkillcams.strafes[i] thread airsupport::debug_draw_bomb_path(undefined, (0, 0, 0.5), 200);
                }
            #/
        }
    }
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0xa40221b9, Offset: 0x2aa8
// Size: 0xe6
function resetkillcams(time) {
    self endon(#"death");
    if (isdefined(time)) {
        wait time;
    }
    for (i = 0; i < level.straferunkillcams.rockets.size; i++) {
        level.straferunkillcams.rockets[i] resetrocketkillcament(self, i);
    }
    for (i = 0; i < level.straferunkillcams.strafes.size; i++) {
        level.straferunkillcams.strafes[i] resetkillcament(self);
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x4c4d13db, Offset: 0x2b98
// Size: 0xb6
function unlinkkillcams() {
    for (i = 0; i < level.straferunkillcams.rockets.size; i++) {
        level.straferunkillcams.rockets[i] unlink();
    }
    for (i = 0; i < level.straferunkillcams.strafes.size; i++) {
        level.straferunkillcams.strafes[i] unlink();
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x2cd43e27, Offset: 0x2c58
// Size: 0x50
function createkillcament() {
    killcament = spawn("script_model", (0, 0, 0));
    killcament setfovforkillcam(25);
    return killcament;
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0x9e89742e, Offset: 0x2cb0
// Size: 0x114
function resetkillcament(parent) {
    self notify(#"reset");
    parent endon(#"death");
    offset_x = getdvarint(#"scr_killcamplaneoffsetx", -3000);
    offset_y = getdvarint(#"scr_killcamplaneoffsety", 0);
    offset_z = getdvarint(#"scr_killcamplaneoffsetz", 740);
    self linkto(parent, "tag_origin", (offset_x, offset_y, offset_z), (10, 0, 0));
    self thread unlinkwhenparentdies(parent);
}

// Namespace straferun/straferun
// Params 2, eflags: 0x0
// Checksum 0x41effac2, Offset: 0x2dd0
// Size: 0x13c
function resetrocketkillcament(parent, rocketindex) {
    self notify(#"reset");
    parent endon(#"death");
    offset_x = getdvarint(#"scr_killcamplaneoffsetx", -3000);
    offset_y = getdvarint(#"scr_killcamplaneoffsety", 0);
    offset_z = getdvarint(#"scr_killcamplaneoffsetz", 740);
    rockettag = level.straferunrockettags[rocketindex % level.straferunrockettags.size];
    self linkto(parent, rockettag, (offset_x, offset_y, offset_z), (10, 0, 0));
    self thread unlinkwhenparentdies(parent);
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0x56ac0763, Offset: 0x2f18
// Size: 0x3c
function deletewhenparentdies(parent) {
    parent waittill(#"death");
    self delete();
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0x9a2914df, Offset: 0x2f60
// Size: 0x5c
function unlinkwhenparentdies(parent) {
    self endon(#"reset");
    self endon(#"unlink");
    parent waittill(#"death");
    self unlink();
}

// Namespace straferun/straferun
// Params 3, eflags: 0x0
// Checksum 0x22e04628, Offset: 0x2fc8
// Size: 0x1c4
function attachkillcamtorocket(killcament, selectedtarget, targetorigin) {
    offset_x = getdvarint(#"scr_killcamrocketoffsetx", -400);
    offset_y = getdvarint(#"scr_killcamrocketoffsety", 0);
    offset_z = getdvarint(#"scr_killcamrocketoffsetz", 110);
    self.killcament = killcament;
    forward = vectorscale(anglestoforward(self.angles), offset_x);
    right = vectorscale(anglestoright(self.angles), offset_y);
    up = vectorscale(anglestoup(self.angles), offset_z);
    killcament unlink();
    killcament.angles = (0, 0, 0);
    killcament.origin = self.origin;
    killcament linkto(self, "", (offset_x, offset_y, offset_z), (9, 0, 0));
    killcament thread unlinkwhenclose(selectedtarget, targetorigin, self);
}

// Namespace straferun/straferun
// Params 3, eflags: 0x0
// Checksum 0xc20032c1, Offset: 0x3198
// Size: 0x118
function unlinkwhenclose(selectedtarget, targetorigin, plane) {
    plane endon(#"death");
    self notify(#"unlink_when_close");
    self endon(#"unlink_when_close");
    distsqr = 1000000;
    while (true) {
        if (isdefined(selectedtarget)) {
            if (distancesquared(self.origin, selectedtarget.origin) < distsqr) {
                self unlink();
                self.angles = (0, 0, 0);
                return;
            }
        } else if (distancesquared(self.origin, targetorigin) < distsqr) {
            self unlink();
            self.angles = (0, 0, 0);
            return;
        }
        wait 0.1;
    }
}

// Namespace straferun/straferun
// Params 3, eflags: 0x0
// Checksum 0x6565c5d0, Offset: 0x32b8
// Size: 0x86
function function_f576a8db(previous_origin, var_7042d757, lookahead) {
    delta = var_7042d757 - previous_origin;
    forwardnoz = vectornormalize((delta[0], delta[1], 0));
    origin = var_7042d757 + vectorscale(forwardnoz, lookahead);
    return origin;
}

// Namespace straferun/straferun
// Params 3, eflags: 0x0
// Checksum 0x46754a2c, Offset: 0x3348
// Size: 0x330
function function_1ff1cd99(parent, node, distance) {
    parent endon(#"death");
    self endon(#"reset");
    waitframe(1);
    self notify(#"unlink");
    self unlink();
    self.angles = (0, 0, 0);
    accel_time = 0.2;
    speed = 20000;
    var_f2fece9b = -800;
    var_ab811279 = level.mapcenter[2] - 500;
    var_cc2800a0 = function_afc3c2a4(node, self.origin, distance);
    start_origin = var_cc2800a0.origin;
    node = var_cc2800a0.node;
    previous_origin = self.origin;
    start_origin = function_f576a8db(previous_origin, start_origin, parent.straferungunlookahead + 1000);
    trace = bullettrace((start_origin[0], start_origin[1], start_origin[2] + var_f2fece9b), (start_origin[0], start_origin[1], var_ab811279), 0, parent, 1, 1);
    var_9483e5c9 = trace[#"position"][2];
    self function_796447da(trace[#"position"], speed, accel_time, var_9483e5c9);
    speed = 500;
    while (isdefined(node)) {
        previous_origin = node.origin;
        node = getvehiclenode(node.target, "targetname");
        start_origin = function_f576a8db(previous_origin, node.origin, parent.straferungunlookahead + 1000);
        trace = bullettrace((start_origin[0], start_origin[1], start_origin[2] + var_f2fece9b), (start_origin[0], start_origin[1], var_ab811279), 0, parent, 1, 1);
        self function_796447da(trace[#"position"], speed, 0, var_9483e5c9);
    }
}

// Namespace straferun/straferun
// Params 4, eflags: 0x0
// Checksum 0x577074b9, Offset: 0x3680
// Size: 0x11a
function function_796447da(goal, speed, accel, var_9483e5c9) {
    self endon(#"reset");
    height_offset = randomintrange(350, 450);
    origin = (goal[0], goal[1], goal[2] + height_offset);
    dist = distance(origin, self.origin);
    time = dist / speed;
    if (accel > time) {
        accel = time;
    }
    self moveto(origin, time, accel, 0);
    self waittill(#"movedone");
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0xe30cd65b, Offset: 0x37a8
// Size: 0x104
function function_59173a32() {
    node = getvehiclenode(self.currentnode.target, "targetname");
    var_16a9c00f = function_84e97a43(node);
    var_a07e4bb6 = var_16a9c00f / (level.straferunkillcams.strafes.size + 1);
    current_dist = 10;
    for (i = 0; i < level.straferunkillcams.strafes.size; i++) {
        level.straferunkillcams.strafes[i] thread function_1ff1cd99(self, node, current_dist);
        current_dist += var_a07e4bb6;
    }
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0x4db174e6, Offset: 0x38b8
// Size: 0x136
function function_84e97a43(node) {
    previous_node = node;
    next_node = getvehiclenode(previous_node.target, "targetname");
    dist = 0;
    while ((!isdefined(previous_node.script_noteworthy) || previous_node.script_noteworthy != "strafe_stop") && next_node != node) {
        dist += distance((previous_node.origin[0], previous_node.origin[1], 0), (next_node.origin[0], next_node.origin[1], 0));
        previous_node = next_node;
        next_node = getvehiclenode(previous_node.target, "targetname");
    }
    return dist;
}

// Namespace straferun/straferun
// Params 3, eflags: 0x0
// Checksum 0x4e794cf4, Offset: 0x39f8
// Size: 0x2e2
function function_afc3c2a4(node, start_origin, var_f5263c8e) {
    var_fd427482 = spawnstruct();
    var_d60f0e77 = distance((start_origin[0], start_origin[1], 0), (node.origin[0], node.origin[1], 0));
    dist = 0;
    if (dist + var_d60f0e77 > var_f5263c8e) {
        forwardvec = vectornormalize((node.origin[0], node.origin[1], 0) - (start_origin[0], start_origin[1], 0));
        var_fd427482.origin = start_origin + forwardvec * (var_f5263c8e - dist);
        var_fd427482.node = node;
        return var_fd427482;
    }
    dist = var_d60f0e77;
    previous_node = node;
    for (next_node = getvehiclenode(previous_node.target, "targetname"); (!isdefined(previous_node.script_noteworthy) || previous_node.script_noteworthy != "strafe_stop") && next_node != node; next_node = getvehiclenode(previous_node.target, "targetname")) {
        var_d60f0e77 = distance((previous_node.origin[0], previous_node.origin[1], 0), (next_node.origin[0], next_node.origin[1], 0));
        if (dist + var_d60f0e77 > var_f5263c8e) {
            forwardvec = vectornormalize(next_node.origin - previous_node.origin);
            var_fd427482.origin = previous_node.origin + forwardvec * (var_f5263c8e - dist);
            var_fd427482.node = previous_node;
            return var_fd427482;
        }
        dist += var_d60f0e77;
        previous_node = next_node;
    }
}

