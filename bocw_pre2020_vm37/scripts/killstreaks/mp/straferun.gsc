#using script_1d0f884737f7cbe8;
#using script_3819e7a1427df6d2;
#using script_396f7d71538c9677;
#using script_4721de209091b1a6;
#using scripts\core_common\battlechatter;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\targetting_delay;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\util;
#using scripts\weapons\heatseekingmissile;

#namespace straferun;

// Namespace straferun/straferun
// Params 0, eflags: 0x6
// Checksum 0x49df67eb, Offset: 0x548
// Size: 0x64
function private autoexec __init__system__() {
    system::register(#"straferun", &function_70a657d8, &postinit, &function_3675de8b, #"killstreaks");
}

// Namespace straferun/straferun
// Params 0, eflags: 0x5 linked
// Checksum 0x81381c3f, Offset: 0x5b8
// Size: 0x22c
function private function_70a657d8() {
    level.straferunnumrockets = 2;
    level.var_e8d7c111 = 8;
    level.straferunrocketdelay = 0.35;
    level.straferungunlookahead = 4000;
    level.straferungunoffset = -800;
    level.straferungunradius = 500;
    level.straferunexitunits = 20000;
    level.straferunmaxstrafes = 4;
    level.straferunflaredelay = 2;
    level.straferunshellshockduration = 2.5;
    level.straferunshellshockradius = 512;
    level.straferunkillsbeforeexit = 10;
    level.straferunnumkillcams = 5;
    level.var_95b9b85f = "veh_t6_air_a10f";
    level.straferunmodelenemy = #"hash_771795fd7b9b3033";
    level.straferunvehicle = "vehicle_straferun_mp";
    level.straferungunweapon = getweapon(#"straferun_gun");
    level.var_831bdf5d = "wpn_a10_shot_loop_npc";
    level.straferunrocketweapon = getweapon(#"straferun_rockets");
    level.straferunrockettags = [];
    level.straferunrockettags[0] = "tag_attach_hardpoint_1";
    level.straferunrockettags[1] = "tag_attach_hardpoint_9";
    level.straferunrockettags[2] = "tag_attach_hardpoint_2";
    level.straferunrockettags[3] = "tag_attach_hardpoint_8";
    level.straferunexplodesound = "evt_helicopter_midair_exp";
    level.straferunshellshock = "straferun";
    createkillcams(level.straferunnumkillcams, level.straferunnumrockets);
    killcam::function_2f7579f(#"straferun_gun");
}

// Namespace straferun/straferun
// Params 0, eflags: 0x5 linked
// Checksum 0x2ad71efc, Offset: 0x7f0
// Size: 0x1c4
function private postinit() {
    var_fc96f513 = killstreaks::function_e2c3bda3("straferun", "killstreak_straferun");
    killstreaks::register_killstreak(var_fc96f513, &usekillstreakstraferun);
    level.var_14fa3231 = [];
    var_99f22d3c = level.var_14fa3231;
    var_99f22d3c[var_99f22d3c.size] = {#targetname:"chopper", #var_d3413870:"helicopter_comlink", #var_4c13f1ac:"inventory_helicopter_comlink"};
    var_99f22d3c[var_99f22d3c.size] = {#targetname:"chopper", #var_d3413870:"supply_drop", #var_4c13f1ac:"inventory_supply_drop"};
    var_99f22d3c[var_99f22d3c.size] = {#targetname:"chopperGunner"};
    var_99f22d3c[var_99f22d3c.size] = {#targetname:"napalm_strike"};
    var_99f22d3c[var_99f22d3c.size] = {#targetname:"uav"};
    var_99f22d3c[var_99f22d3c.size] = {#targetname:"counteruav"};
    level.var_53bed697 = [];
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0xb56d99ef, Offset: 0x9c0
// Size: 0x48
function function_3675de8b() {
    if (isdefined(level.var_1b900c1d)) {
        [[ level.var_1b900c1d ]](getweapon("straferun"), &function_bff5c062);
    }
}

// Namespace straferun/straferun
// Params 2, eflags: 0x1 linked
// Checksum 0x53023103, Offset: 0xa10
// Size: 0x64
function function_bff5c062(var_c4b91241, attackingplayer) {
    var_c4b91241 killstreaks::function_73566ec7(attackingplayer, getweapon(#"gadget_icepick"), var_c4b91241.owner);
    var_c4b91241 thread explode();
}

// Namespace straferun/straferun
// Params 1, eflags: 0x1 linked
// Checksum 0x1a5ec511, Offset: 0xa80
// Size: 0x16a
function usekillstreakstraferun(hardpointtype) {
    bundle = killstreaks::get_script_bundle("straferun");
    if (self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
        return 0;
    }
    self airsupport::function_9e2054b0(&beginlocationselection);
    if (is_true(bundle.var_7436c1c5) && !is_true(self.pers[#"hash_7b70f0ba82b19814"])) {
        self thread airsupport::singleradarsweep();
    }
    location = self airsupport::waitforlocationselection();
    if (!isdefined(self)) {
        return 0;
    }
    if (!isdefined(location.origin)) {
        self.pers[#"hash_7b70f0ba82b19814"] = 1;
        return 0;
    }
    self.pers[#"hash_7b70f0ba82b19814"] = 0;
    return self airsupport::function_83904681(location, &function_3d070ab6, hardpointtype);
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0x8046f4a6, Offset: 0xbf8
// Size: 0x6c
function beginlocationselection() {
    bundle = killstreaks::get_script_bundle("straferun");
    self beginlocationnapalmselection("lui_napalm_strike", (isdefined(bundle.var_a2daa406) ? bundle.var_a2daa406 : 3000) * 0.5);
}

// Namespace straferun/straferun
// Params 2, eflags: 0x1 linked
// Checksum 0x22b3ac67, Offset: 0xc70
// Size: 0x8a
function function_3d070ab6(location, killstreak_id) {
    profilestart();
    killstreak_started = self function_db619336("straferun", killstreak_id, location);
    if (!killstreak_started && killstreak_id != -1) {
        killstreakrules::killstreakstop("straferun", self.team, killstreak_id);
    }
    profilestop();
    return killstreak_started;
}

// Namespace straferun/straferun
// Params 3, eflags: 0x1 linked
// Checksum 0x80a91cad, Offset: 0xd08
// Size: 0x2c0
function function_db619336(hardpointtype, killstreak_id, location) {
    if (sessionmodeiswarzonegame()) {
        position = location.origin;
        trace = bullettrace(position + (0, 0, 10000), position - (0, 0, 10000), 0, undefined);
        targetpoint = trace[#"fraction"] > 1 ? (position[0], position[1], 0) : trace[#"position"];
        var_b0490eb9 = getheliheightlockheight(position);
        var_6be9958b = trace[#"position"][2];
        bundle = killstreaks::get_script_bundle("straferun");
        var_8cdd01c7 = var_6be9958b + (var_b0490eb9 - var_6be9958b) * bundle.var_ff73e08c;
    }
    planea = function_1e30e51e(hardpointtype, killstreak_id, location, #"hash_1dfff61be0d43f2d", "warthog_strafe1_a_start", "warthog_strafe1_pivot_a", (0, 0, 0), var_8cdd01c7);
    if (!isdefined(planea)) {
        return false;
    }
    planeb = function_1e30e51e(hardpointtype, killstreak_id, location, #"hash_1dfff31be0d43a14", "warthog_strafe1_b_start", "warthog_strafe1_pivot_b", (200, 200, 50), var_8cdd01c7);
    if (!isdefined(planeb)) {
        planea thread explode();
        return false;
    }
    planea.var_14494df9 = 1;
    planeb.var_3971b935 = planea;
    level.var_996bc142[killstreak_id] = 2;
    level.var_32934cf9[killstreak_id] = 0;
    self stats::function_e24eec31(getweapon(#"straferun"), #"used", 1);
    return true;
}

// Namespace straferun/straferun
// Params 8, eflags: 0x1 linked
// Checksum 0xb59a3491, Offset: 0xfd0
// Size: 0x8c0
function function_1e30e51e(hardpointtype, killstreak_id, location, var_a6b1bda0, start_node_name, var_9c00e6d8, var_49d19de7, var_e4c839a6) {
    startnode = getvehiclenode(start_node_name, "targetname");
    if (!isdefined(startnode)) {
        startnode = getvehiclenode("warthog_start", "targetname");
    }
    if (!isdefined(startnode)) {
        println("<dev string:x38>");
        return undefined;
    }
    /#
        if (level.var_5bd68a8f === 1) {
            return undefined;
        }
    #/
    plane = spawnvehicle(level.straferunvehicle, startnode.origin, (0, 0, 0), "straferun");
    if (!isdefined(plane)) {
        println("<dev string:x67>");
        return undefined;
    }
    plane clientfield::set("scorestreakActive", 1);
    plane.var_739aa202 = var_a6b1bda0;
    var_6f0661aa = plane.var_739aa202 == #"hash_1dfff61be0d43f2d";
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
    plane.targetname = "strafePlane";
    plane.identifier_weapon = getweapon("straferun");
    plane.numstrafes = 0;
    plane.numflares = 1;
    plane.soundmod = "straferun";
    plane setdrawinfrared(1);
    self.straferunkills = 0;
    self.straferunbda = 0;
    plane thread function_d4896942();
    target_set(plane, (0, 0, 0));
    plane.gunsoundentity = spawn("script_model", plane gettagorigin("tag_flash"));
    plane.gunsoundentity linkto(plane, "tag_flash", (0, 0, 0), (0, 0, 0));
    if (!issentient(plane)) {
        plane util::make_sentient();
        plane.ignoreme = 1;
    }
    plane.killcament = spawn("script_model", plane.origin + (0, 0, 700));
    plane.killcament setfovforkillcam(25);
    plane.killcament.angles = (15, 0, 0);
    plane.killcament.starttime = gettime();
    offset_x = getdvarint(#"hash_6354a081bacd5b72", -2500);
    offset_y = getdvarint(#"hash_6354a181bacd5d25", 0);
    offset_z = getdvarint(#"hash_63549e81bacd580c", -150);
    offset_pitch = getdvarint(#"hash_53fdb5b01cf6f7dc", 2);
    plane.killcament linkto(plane, "tag_origin", (offset_x, offset_y, offset_z), (offset_pitch, 0, 0));
    plane.killcament setweapon(level.straferungunweapon);
    plane resetkillcams();
    plane thread watchforotherkillstreaks();
    bundle = getscriptbundle(killstreaks::function_e2c3bda3("straferun", "killstreak_straferun"));
    plane thread watchforkills();
    plane thread watchdamage(bundle);
    plane thread dostraferuns(bundle, var_a6b1bda0);
    pivot = struct::get(var_9c00e6d8, "targetname");
    if (isdefined(pivot)) {
        var_1c847d0f = pivot.origin;
        var_dda93e6c = pivot.angles;
    }
    if (!isdefined(var_1c847d0f)) {
        var_1c847d0f = level.mapcenter;
    }
    if (!isdefined(var_dda93e6c)) {
        var_dda93e6c = (0, 90, 0);
    }
    var_b818f98a = function_2e532eed(location);
    var_b818f98a.origin += var_49d19de7;
    plane vehicle::function_bb9b43a9(startnode, var_1c847d0f, var_dda93e6c, var_b818f98a, var_e4c839a6);
    plane.killbox = [];
    plane.killbox[#"origin"] = var_b818f98a.origin;
    plane.killbox[#"angles"] = (0, var_b818f98a.yaw, 0);
    plane thread vehicle::get_on_and_go_path(startnode);
    plane thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "death");
    plane thread watchforownerexit(self);
    plane thread targetting_delay::function_7e1a12ce(12000);
    plane thread function_c24cc26a();
    if (var_6f0661aa) {
        plane killstreakrules::function_2e6ff61a(hardpointtype, killstreak_id, {#origin:var_b818f98a.origin, #team:plane.team});
        util::function_a3f7de13(21, self.team, self getentitynumber(), level.killstreaks[#"straferun"].uiname);
    }
    aiutility::addaioverridedamagecallback(plane, &function_16abaea4);
    if (var_6f0661aa) {
        plane killstreaks::function_b182645e(self, hardpointtype);
    }
    return plane;
}

// Namespace straferun/straferun
// Params 15, eflags: 0x1 linked
// Checksum 0xa3663824, Offset: 0x1898
// Size: 0xf2
function function_16abaea4(*inflictor, attacker, damage, idflags, meansofdeath, weapon, *point, *dir, *hitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
    chargelevel = 0;
    weapon_damage = killstreak_bundles::get_weapon_damage("straferun", self.maxhealth, psoffsettime, vsurfacenormal, partname, damagefromunderneath, modelindex, chargelevel);
    if (!isdefined(weapon_damage)) {
        weapon_damage = killstreaks::get_old_damage(psoffsettime, vsurfacenormal, partname, damagefromunderneath, 1);
    }
    return weapon_damage;
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0x200c2504, Offset: 0x1998
// Size: 0x30e
function function_c24cc26a() {
    self endon(#"death");
    level endon(#"game_ended");
    var_2974acb8 = battlechatter::mpdialog_value("taacomPilotWarnDistanceWarthog", 5000);
    var_13d70215 = var_2974acb8 * var_2974acb8;
    while (true) {
        wait 0.1;
        if (!isdefined(self)) {
            return;
        }
        if (self.var_14494df9 !== 1) {
            continue;
        }
        if (!isdefined(self.currentnode)) {
            continue;
        }
        if (isdefined(self.var_90110858) ? self.var_90110858 : 0) {
            continue;
        }
        var_19d3cc8e = 0;
        currentnode = getvehiclenode(self.currentnode.target, "targetname");
        if (!isdefined(currentnode)) {
            return;
        }
        var_661ad37a = distancesquared(currentnode.origin, self.origin);
        var_4c8f226e = 0;
        while (true) {
            if (!isdefined(currentnode.target)) {
                continue;
            }
            if (var_661ad37a > var_13d70215) {
                var_4c8f226e = 1;
                break;
            }
            nextnode = getvehiclenode(currentnode.target, "targetname");
            if (!isdefined(nextnode)) {
                continue;
            }
            if (isdefined(nextnode.script_noteworthy) && nextnode.script_noteworthy == "strafe_start") {
                break;
            }
            var_50eb39dc = distancesquared(currentnode.origin, nextnode.origin);
            var_661ad37a += var_50eb39dc;
            currentnode = nextnode;
        }
        if (var_4c8f226e) {
            continue;
        }
        if (!is_true(self.leavenexttime)) {
            if (self.numstrafes == 0) {
                self namespace_f9b02f80::play_pilot_dialog_on_owner("arrive", "straferun", self.killstreakid);
            } else if (self.numstrafes == level.straferunmaxstrafes - 1) {
                self namespace_f9b02f80::play_pilot_dialog_on_owner("waveStartFinal", "straferun", self.killstreakid);
            } else {
                self namespace_f9b02f80::play_pilot_dialog_on_owner("waveStart", "straferun", self.killstreakid);
            }
        }
        self.var_90110858 = 1;
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0xa5d1b925, Offset: 0x1cb0
// Size: 0xac
function playcontrail() {
    self endon(#"death");
    wait 0.1;
    params = getscriptbundle(killstreaks::function_e2c3bda3("straferun", "killstreak_straferun"));
    playfxontag(params.var_47592079, self, "tag_origin");
    self playloopsound(#"veh_a10_engine_loop", 1);
}

// Namespace straferun/straferun
// Params 1, eflags: 0x1 linked
// Checksum 0x12434ecd, Offset: 0x1d68
// Size: 0x136
function cleanupondeath(team) {
    self waittill(#"death");
    if (self.var_14494df9 === 1 && isdefined(self.var_3971b935)) {
        self.var_3971b935.var_14494df9 = 1;
    }
    var_e130ebce = 1;
    if (isdefined(level.var_996bc142[self.killstreakid])) {
        level.var_996bc142[self.killstreakid]--;
        if (level.var_996bc142[self.killstreakid] > 0) {
            var_e130ebce = 0;
        }
    }
    if (var_e130ebce) {
        killstreakrules::killstreakstop("straferun", team, self.killstreakid);
        level.var_53bed697[self.killstreakid] = undefined;
    }
    if (isdefined(self.gunsoundentity)) {
        self.gunsoundentity stoploopsound();
        self.gunsoundentity delete();
        self.gunsoundentity = undefined;
    }
}

// Namespace straferun/straferun
// Params 1, eflags: 0x1 linked
// Checksum 0x4185d06f, Offset: 0x1ea8
// Size: 0x392
function watchdamage(bundle) {
    self endon(#"death");
    self.maxhealth = 999999;
    self.health = self.maxhealth;
    self.maxhealth = isdefined(bundle.kshealth) ? bundle.kshealth : 100;
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
            self.damage_debug = damage + "<dev string:x93>" + weapon.name + "<dev string:x99>";
        #/
        if (!isdefined(weapon) || weapon.rootweapon != getweapon(#"tr_flechette_t8")) {
            if (mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE") {
                damage += isdefined(bundle.kshealth) ? bundle.kshealth : 100;
            }
        }
        if (!issentient(self) && damage > 0) {
            self.attacker = attacker;
        }
        damage_taken += damage;
        if (damage_taken >= (isdefined(bundle.kshealth) ? bundle.kshealth : 100)) {
            self thread explode();
            var_d63ac213 = 0;
            if (isdefined(level.var_32934cf9[self.killstreakid])) {
                level.var_32934cf9[self.killstreakid]++;
                if (level.var_32934cf9[self.killstreakid] >= 2) {
                    var_d63ac213 = 1;
                }
            }
            if (self.owner util::isenemyplayer(attacker)) {
                self killstreaks::function_73566ec7(attacker, weapon, self.owner);
                challenges::destroyedaircraft(attacker, weapon, 0, 1);
                attacker challenges::addflyswatterstat(weapon, self);
                if (var_d63ac213) {
                    attacker battlechatter::function_eebf94f6("straferun", weapon);
                    self namespace_f9b02f80::play_destroyed_dialog_on_owner("straferun", self.killstreakid);
                }
            }
            return;
        }
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0xd8731c60, Offset: 0x2248
// Size: 0x13e
function watchforotherkillstreaks() {
    self endon(#"death");
    for (;;) {
        waitresult = level waittill(#"killstreak_started");
        killstreaktype = waitresult.killstreaktype;
        teamname = waitresult.team;
        attacker = waitresult.attacker;
        if (!isdefined(self.owner)) {
            self thread explode();
            return;
        }
        if (killstreaktype == "emp") {
            if (self.owner util::isenemyplayer(attacker)) {
                self thread explode();
                attacker challenges::addflyswatterstat(killstreaktype, self);
                return;
            }
            continue;
        }
        if (killstreaktype == "missile_swarm") {
            if (self.owner util::isenemyplayer(attacker)) {
                self.leavenexttime = 1;
            }
        }
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0x2c82b949, Offset: 0x2390
// Size: 0x5e
function watchforkills() {
    self endon(#"death");
    for (;;) {
        waitresult = self waittill(#"killed");
        if (isplayer(waitresult.victim)) {
        }
    }
}

// Namespace straferun/straferun
// Params 1, eflags: 0x1 linked
// Checksum 0x2fe9f1c8, Offset: 0x23f8
// Size: 0x62
function watchforownerexit(owner) {
    self endon(#"death");
    owner waittill(#"disconnect", #"joined_team", #"joined_spectators");
    self.leavenexttime = 1;
}

// Namespace straferun/straferun
// Params 0, eflags: 0x0
// Checksum 0x905453f5, Offset: 0x2468
// Size: 0x24
function addstraferunkill() {
    if (!isdefined(self.straferunkills)) {
        self.straferunkills = 0;
    }
    self.straferunkills++;
}

// Namespace straferun/straferun
// Params 2, eflags: 0x1 linked
// Checksum 0x87ec7de9, Offset: 0x2498
// Size: 0x3e8
function dostraferuns(bundle, var_a6b1bda0) {
    self endon(#"death");
    if (!isdefined(level.var_6edf8307)) {
        level.var_6edf8307 = [];
    }
    level.var_6edf8307[self.killstreakid] = 0;
    self.var_23493b54 = 0;
    for (;;) {
        waitresult = self waittill(#"noteworthy");
        noteworthy = waitresult.noteworthy;
        noteworthynode = waitresult.noteworthy_node;
        if (noteworthy == "strafe_start") {
            self.straferungunlookahead = level.straferungunlookahead;
            self.straferungunradius = level.straferungunradius;
            self.straferungunoffset = level.straferungunoffset;
            self.var_90110858 = 0;
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
                if (isdefined(bundle.var_d483e967) ? bundle.var_d483e967 : 0) {
                    self thread function_ec6320ce(bundle, var_a6b1bda0);
                } else {
                    self thread startstrafe();
                }
            }
            if (true) {
                self thread firerockets();
            }
            continue;
        }
        if (noteworthy == "strafe_stop") {
            if (!(isdefined(bundle.var_d483e967) ? bundle.var_d483e967 : 0)) {
                self stopstrafe();
            }
            continue;
        }
        if (noteworthy == "strafe_leave") {
            if (self shouldleavemap()) {
                if (!is_true(self.leavenexttime) && level.var_6edf8307[self.killstreakid] != 1) {
                    level.var_6edf8307[self.killstreakid] = 1;
                    self namespace_f9b02f80::play_taacom_dialog_response_on_owner("timeoutConfirmed", "straferun", self.killstreakid);
                }
                self thread leavemap();
            }
            continue;
        }
        if (noteworthy == "fire_rockets") {
            if (true) {
                self thread firerockets();
            }
        }
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0x3e74015c, Offset: 0x2888
// Size: 0x90
function function_d4896942() {
    self endon(#"death", #"strafe_stop");
    while (true) {
        self waittill(#"flare_deployed");
        if (!is_true(self.leavenexttime)) {
            self namespace_f9b02f80::play_pilot_dialog_on_owner("damageEvaded", "straferun", self.killstreakid);
        }
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0x9cdbd247, Offset: 0x2920
// Size: 0x36a
function startstrafe() {
    self endon(#"death", #"strafe_stop");
    if (isdefined(self.strafing)) {
        iprintlnbold("TRYING TO STRAFE WHEN ALREADY STRAFING!\n");
        return;
    }
    self.strafing = 1;
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
// Params 2, eflags: 0x1 linked
// Checksum 0x452eec92, Offset: 0x2c98
// Size: 0x40c
function function_ec6320ce(bundle, var_a6b1bda0) {
    self endon(#"death");
    if (isdefined(self.strafing)) {
        iprintlnbold("TRYING TO STRAFE WHEN ALREADY STRAFING!\n");
        return;
    }
    self.strafing = 1;
    self.var_23493b54++;
    var_6a6f2e87 = self.killbox[#"origin"];
    trace_results = bullettrace((var_6a6f2e87[0], var_6a6f2e87[1], 5000), (var_6a6f2e87[0], var_6a6f2e87[1], -5000), 0, undefined, 0, 1);
    var_6a6f2e87 = (var_6a6f2e87[0], var_6a6f2e87[1], trace_results[#"position"][2]);
    var_5455cb95 = anglestoforward((0, self.angles[1], 0));
    var_f6fe02b9 = vectorcross(var_5455cb95, (0, 0, 1));
    var_b01435f6 = vectorscale(var_5455cb95, isdefined(bundle.var_a2daa406) ? bundle.var_a2daa406 : 1000);
    var_9ec4e10e = var_6a6f2e87 - var_b01435f6 * 0.5;
    var_d7e70604 = bundle.var_66cb3945;
    weaponshoottime = max(level.straferungunweapon.firetime, 0.05);
    var_acb6bcc8 = gettime();
    var_6703392b = isdefined(bundle.var_e479aa7d) ? bundle.var_e479aa7d : 1000;
    for (;;) {
        gunorigin = self gettagorigin("tag_flash");
        gunorigin += (0, 0, self.straferungunoffset);
        var_af2dc9d2 = (gettime() - var_acb6bcc8) / var_6703392b;
        if (var_af2dc9d2 > 1) {
            break;
        }
        var_47f1292b = var_9ec4e10e + vectorscale(var_b01435f6, var_af2dc9d2);
        var_b3a734d8 = isdefined(bundle.var_a6bb5503) ? bundle.var_a6bb5503 : level.straferungunradius;
        if (var_a6b1bda0 == #"hash_1dfff61be0d43f2d") {
            var_47f1292b += vectorscale(var_f6fe02b9, var_d7e70604 + randomfloatrange(var_b3a734d8 * -1, var_b3a734d8));
        } else {
            var_47f1292b -= vectorscale(var_f6fe02b9, var_d7e70604 + randomfloatrange(var_b3a734d8 * -1, var_b3a734d8));
        }
        /#
            if (getdvarint(#"scr_devstraferunbulletsdebugdraw", 0)) {
                sphere(var_47f1292b, 10, (1, 0, 0), 0.8, 0, 20, 180);
            }
        #/
        self turretsettarget(0, var_47f1292b);
        self fireweapon();
        self shellshockplayers(var_47f1292b);
        wait weaponshoottime;
    }
    self stopstrafe();
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0x19dbee97, Offset: 0x30b0
// Size: 0x290
function firerockets() {
    if (!isdefined(self.var_577f39f7)) {
        self.var_577f39f7 = 0;
    }
    if (self.var_577f39f7 >= level.var_e8d7c111) {
        return;
    }
    self notify(#"firing_rockets");
    self endon(#"death", #"strafe_stop", #"firing_rockets");
    self.owner endon(#"disconnect");
    forward = anglestoforward(self.angles);
    for (rocketindex = 0; rocketindex < level.straferunnumrockets; rocketindex++) {
        if (self.var_577f39f7 >= level.var_e8d7c111) {
            return;
        }
        best_target = self function_f7055dec();
        if (!isdefined(best_target)) {
            return;
        }
        rockettag = level.straferunrockettags[rocketindex % level.straferunrockettags.size];
        rocketorigin = self gettagorigin(rockettag);
        targetorigin = deadrecontargetorigin(rocketorigin, best_target);
        rocketorigin = self gettagorigin(rockettag);
        rocket = magicbullet(level.straferunrocketweapon, rocketorigin, rocketorigin + forward, self);
        self.var_577f39f7++;
        rocket missile_settarget(best_target, (0, 0, 0));
        rocket.soundmod = "straferun";
        rocket attachkillcamtorocket(level.straferunkillcams[self.var_739aa202].rockets[rocketindex], best_target, targetorigin);
        /#
            if (getdvarint(#"scr_devstraferunkillcamsdebugdraw", 0)) {
                rocket thread airsupport::debug_draw_bomb_path(undefined, (0, 0.5, 0), 400);
            }
        #/
        wait level.straferunrocketdelay;
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0xbf3f0b4b, Offset: 0x3348
// Size: 0x1b0
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
    if (isdefined(bdadialog) && !is_true(self.leavenexttime)) {
        self namespace_f9b02f80::play_pilot_dialog_on_owner(bdadialog, "straferun", self.killstreakid);
    }
    owner.straferunbda = 0;
    self.gunsoundentity stoploopsound();
    self.gunsoundentity playsound(#"wpn_a10_shot_decay_npc");
    self.numstrafes++;
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0xc8e80919, Offset: 0x3500
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
// Params 0, eflags: 0x1 linked
// Checksum 0x70a373df, Offset: 0x3570
// Size: 0x114
function leavemap() {
    self unlinkkillcams();
    exitorigin = self.origin + vectorscale(anglestoforward(self.angles), level.straferunexitunits);
    self setyawspeed(5, 999, 999);
    self setgoal(exitorigin, 1);
    if (isdefined(self.killcament)) {
        self.killcament unlink();
    }
    wait 5;
    if (isdefined(self)) {
        if (isdefined(self.killcament)) {
            self.killcament delete();
            self.killcament = undefined;
        }
        self delete();
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0xe004f9bb, Offset: 0x3690
// Size: 0x14c
function explode() {
    self endon(#"delete");
    forward = self.origin + (0, 0, 100) - self.origin;
    params = getscriptbundle(killstreaks::function_e2c3bda3("straferun", "killstreak_straferun"));
    if (isdefined(params.var_5ebb3c10)) {
        playfx(params.var_5ebb3c10, self.origin, forward);
    }
    self playsound(level.straferunexplodesound);
    if (isdefined(self.killcament)) {
        self.killcament unlink();
    }
    wait 0.1;
    if (isdefined(self)) {
        if (isdefined(self.killcament)) {
            self.killcament delete();
            self.killcament = undefined;
        }
        self delete();
    }
}

// Namespace straferun/straferun
// Params 1, eflags: 0x1 linked
// Checksum 0x2f80af3e, Offset: 0x37e8
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
// Checksum 0xac34b124, Offset: 0x3898
// Size: 0x1fa
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
    var_2910def0 = self targetting_delay::function_1c169b3a(player);
    self targetting_delay::function_a4d6d6d8(player, int((isdefined(level.straferunrocketdelay) ? level.straferunrocketdelay : 0.35) * 1000));
    if (!var_2910def0) {
        return 0;
    }
    return cantargetentity(player);
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0x13c1b824, Offset: 0x3aa0
// Size: 0x8a
function cantargetactor(actor) {
    if (!isdefined(actor)) {
        return 0;
    }
    if (actor.team == self.team) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0x10750244, Offset: 0x3b38
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
// Params 0, eflags: 0x1 linked
// Checksum 0xe04e5f5e, Offset: 0x3bd8
// Size: 0x29c
function function_f7055dec() {
    if (!isdefined(level.var_53bed697[self.killstreakid])) {
        level.var_53bed697[self.killstreakid] = [];
    }
    var_e0345575 = level.var_53bed697[self.killstreakid];
    now = gettime();
    var_6a3a9bb1 = function_a3f6cdac(8000);
    foreach (var_e53a042f in level.var_14fa3231) {
        var_61203702 = getentarray(var_e53a042f.targetname, "targetname");
        if (var_61203702.size == 0) {
            continue;
        }
        foreach (var_62e5f4cc in var_61203702) {
            if (isdefined(var_e53a042f.var_d3413870) && !(var_62e5f4cc.killstreaktype === var_e53a042f.var_d3413870 || var_62e5f4cc.killstreaktype === var_e53a042f.var_4c13f1ac)) {
                continue;
            }
            var_4ef4e267 = var_62e5f4cc getentitynumber();
            if (isdefined(var_e0345575[var_4ef4e267]) && var_e0345575[var_4ef4e267] + 2000 > now) {
                continue;
            }
            if (distance2dsquared(self.killbox[#"origin"], var_62e5f4cc.origin) > var_6a3a9bb1) {
                continue;
            }
            if (!util::function_fbce7263(self.team, var_62e5f4cc.team)) {
                continue;
            }
            var_e0345575[var_4ef4e267] = now;
            return var_62e5f4cc;
        }
    }
    return undefined;
}

// Namespace straferun/straferun
// Params 2, eflags: 0x1 linked
// Checksum 0xf2984897, Offset: 0x3e80
// Size: 0xa2
function deadrecontargetorigin(rocket_start, target) {
    target_velocity = target getvelocity();
    missile_speed = 7000;
    target_delta = target.origin - rocket_start;
    target_dist = length(target_delta);
    time_to_target = target_dist / missile_speed;
    return target.origin + target_velocity * time_to_target;
}

// Namespace straferun/straferun
// Params 1, eflags: 0x1 linked
// Checksum 0x1e45141d, Offset: 0x3f30
// Size: 0xd0
function shellshockplayers(origin) {
    if (!isdefined(self.team)) {
        return;
    }
    var_dea37f82 = function_f6f34851(self.team, origin, level.straferunshellshockradius);
    foreach (player in var_dea37f82) {
        player thread straferunshellshock(self);
    }
}

// Namespace straferun/straferun
// Params 1, eflags: 0x1 linked
// Checksum 0xb378826a, Offset: 0x4008
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
// Params 2, eflags: 0x1 linked
// Checksum 0x6ea367b1, Offset: 0x40e8
// Size: 0x190
function createkillcams(*numkillcams, numrockets) {
    if (!isdefined(level.straferunkillcams)) {
        level.straferunkillcams = [];
        level.straferunkillcams[#"hash_1dfff61be0d43f2d"] = spawnstruct();
        level.straferunkillcams[#"hash_1dfff31be0d43a14"] = spawnstruct();
        level.straferunkillcams[#"hash_1dfff61be0d43f2d"].rockets = [];
        level.straferunkillcams[#"hash_1dfff31be0d43a14"].rockets = [];
        for (i = 0; i < numrockets; i++) {
            level.straferunkillcams[#"hash_1dfff61be0d43f2d"].rockets[level.straferunkillcams[#"hash_1dfff61be0d43f2d"].rockets.size] = createkillcament();
            level.straferunkillcams[#"hash_1dfff31be0d43a14"].rockets[level.straferunkillcams[#"hash_1dfff31be0d43a14"].rockets.size] = createkillcament();
        }
    }
}

// Namespace straferun/straferun
// Params 1, eflags: 0x1 linked
// Checksum 0x8df935c3, Offset: 0x4280
// Size: 0xbc
function resetkillcams(time) {
    self endon(#"death");
    assert(isdefined(self.var_739aa202));
    if (isdefined(time)) {
        wait time;
    }
    for (i = 0; i < level.straferunkillcams[self.var_739aa202].rockets.size; i++) {
        level.straferunkillcams[self.var_739aa202].rockets[i] resetrocketkillcament(self, i);
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0xe229dc33, Offset: 0x4348
// Size: 0x104
function unlinkkillcams() {
    numrockets = level.straferunkillcams[#"hash_1dfff61be0d43f2d"].rockets.size;
    assert(level.straferunkillcams[#"hash_1dfff61be0d43f2d"].rockets.size == level.straferunkillcams[#"hash_1dfff31be0d43a14"].rockets.size);
    for (i = 0; i < numrockets; i++) {
        level.straferunkillcams[#"hash_1dfff61be0d43f2d"].rockets[i] unlink();
        level.straferunkillcams[#"hash_1dfff31be0d43a14"].rockets[i] unlink();
    }
}

// Namespace straferun/straferun
// Params 0, eflags: 0x1 linked
// Checksum 0xae37c58a, Offset: 0x4458
// Size: 0x60
function createkillcament() {
    killcament = spawn("script_model", (0, 0, 0));
    killcament.targetname = "createKillcamEnt";
    killcament setfovforkillcam(25);
    return killcament;
}

// Namespace straferun/straferun
// Params 1, eflags: 0x0
// Checksum 0xdd87bb51, Offset: 0x44c0
// Size: 0x10c
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
// Params 2, eflags: 0x1 linked
// Checksum 0xa7aba55b, Offset: 0x45d8
// Size: 0x134
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
// Checksum 0x928a2f50, Offset: 0x4718
// Size: 0x3c
function deletewhenparentdies(parent) {
    parent waittill(#"death");
    self delete();
}

// Namespace straferun/straferun
// Params 1, eflags: 0x1 linked
// Checksum 0x4b1d0c77, Offset: 0x4760
// Size: 0x5c
function unlinkwhenparentdies(parent) {
    self endon(#"reset", #"unlink");
    parent waittill(#"death");
    self unlink();
}

// Namespace straferun/straferun
// Params 3, eflags: 0x1 linked
// Checksum 0x58022858, Offset: 0x47c8
// Size: 0x1bc
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
// Params 3, eflags: 0x1 linked
// Checksum 0xa6413f31, Offset: 0x4990
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

