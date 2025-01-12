#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
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
#using scripts\killstreaks\mp\counteruav;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\util;
#using scripts\weapons\heatseekingmissile;

#namespace uav;

// Namespace uav/uav
// Params 0, eflags: 0x2
// Checksum 0xad90d474, Offset: 0x208
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"uav", &__init__, undefined, #"killstreaks");
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x8c6036e, Offset: 0x258
// Size: 0x1f4
function __init__() {
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            level.activeuavs[team] = 0;
        }
    } else {
        level.activeuavs = [];
    }
    level.activeplayeruavs = [];
    level.spawneduavs = [];
    if (tweakables::gettweakablevalue("killstreak", "allowradar")) {
        killstreaks::register_killstreak("killstreak_uav", &activateuav);
    }
    level thread uavtracker();
    callback::on_connect(&onplayerconnect);
    callback::on_spawned(&onplayerspawned);
    callback::on_joined_team(&onplayerjoinedteam);
    callback::on_finalize_initialization(&function_6567e2dd);
    callback::add_callback(#"hash_425352b435722271", &function_967a80ab);
    setmatchflag("radar_allies", 0);
    setmatchflag("radar_axis", 0);
}

// Namespace uav/uav
// Params 1, eflags: 0x0
// Checksum 0x5b026556, Offset: 0x458
// Size: 0x240
function function_967a80ab(params) {
    enemycuavactive = 0;
    if (params.attacker hasperk(#"specialty_immunecounteruav") == 0) {
        foreach (team, _ in level.teams) {
            if (team == params.attacker.team) {
                continue;
            }
            if (counteruav::teamhasactivecounteruav(team)) {
                enemycuavactive = 1;
            }
        }
    }
    if (enemycuavactive == 0) {
        foreach (player in params.players) {
            if (isdefined(level.activeplayeruavs)) {
                activeuav = level.activeplayeruavs[player.entnum];
                if (level.forceradar == 1) {
                    activeuav--;
                }
                if (activeuav > 0) {
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

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x196fafc6, Offset: 0x6a0
// Size: 0x1e
function function_6567e2dd() {
    profilestart();
    initrotatingrig();
    profilestop();
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x2bae110, Offset: 0x6c8
// Size: 0x1e4
function initrotatingrig() {
    if (isdefined(level.var_719a5529)) {
        map_center = airsupport::getmapcenter();
        rotator_offset = (isdefined(level.var_719a5529) ? level.var_719a5529 : map_center[0], isdefined(level.var_7a55d00e) ? level.var_7a55d00e : map_center[1], isdefined(level.var_b95d206f) ? level.var_b95d206f : 1200);
        level.var_4fa08491 = spawn("script_model", rotator_offset);
    } else {
        map_center = airsupport::getmapcenter();
        rotator_offset = (isdefined(level.var_da8b4158) ? level.var_da8b4158 : 0, isdefined(level.var_757589f) ? level.var_757589f : 0, 1200);
        level.var_4fa08491 = spawn("script_model", map_center + rotator_offset);
    }
    level.var_4fa08491 setmodel(#"tag_origin");
    level.var_4fa08491.angles = (0, 115, 0);
    level.var_4fa08491 hide();
    level.var_4fa08491 thread rotaterig();
    level.var_4fa08491 thread swayrig();
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xbad5ae2e, Offset: 0x8b8
// Size: 0x2e
function rotaterig() {
    for (;;) {
        self rotateyaw(-360, 60);
        wait 60;
    }
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xcc2657ea, Offset: 0x8f0
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

// Namespace uav/uav
// Params 1, eflags: 0x0
// Checksum 0x8c605a8f, Offset: 0xa08
// Size: 0x2c
function hackedprefunction(hacker) {
    uav = self;
    uav resetactiveuav();
}

// Namespace uav/uav
// Params 2, eflags: 0x0
// Checksum 0x29b6350c, Offset: 0xa40
// Size: 0xc4
function configureteampost(owner, ishacked) {
    uav = self;
    uav thread teams::waituntilteamchangesingleton(owner, "UAV_watch_team_change", &onteamchange, owner.entnum, "delete", "death", "leaving");
    if (ishacked == 0) {
        uav teams::hidetosameteam();
    } else {
        uav setvisibletoall();
    }
    owner addactiveuav();
}

// Namespace uav/uav
// Params 1, eflags: 0x0
// Checksum 0x803a52a7, Offset: 0xb10
// Size: 0x1e
function function_b240d230(health) {
    waitframe(1);
    self.health = health;
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xa3d6c54e, Offset: 0xb38
// Size: 0x650
function activateuav() {
    assert(isdefined(level.players));
    if (self killstreakrules::iskillstreakallowed("uav", self.team) == 0) {
        return false;
    }
    killstreak_id = self killstreakrules::killstreakstart("uav", self.team);
    if (killstreak_id == -1) {
        return false;
    }
    rotator = level.var_4fa08491;
    attach_angle = -90;
    uav = spawn("script_model", rotator gettagorigin("tag_origin"));
    if (!isdefined(level.spawneduavs)) {
        level.spawneduavs = [];
    } else if (!isarray(level.spawneduavs)) {
        level.spawneduavs = array(level.spawneduavs);
    }
    level.spawneduavs[level.spawneduavs.size] = uav;
    uav setmodel(level.killstreakbundle[#"uav"].ksmodel);
    uav.targetname = "uav";
    uav killstreaks::configure_team("uav", killstreak_id, self, undefined, undefined, &configureteampost);
    uav killstreak_hacking::enable_hacking("uav", &hackedprefunction, undefined);
    uav clientfield::set("enemyvehicle", 1);
    killstreak_detect::killstreaktargetset(uav);
    uav setdrawinfrared(1);
    uav.killstreak_id = killstreak_id;
    uav.leaving = 0;
    uav.victimsoundmod = "vehicle";
    uav thread killstreaks::function_1c47e9c9("uav", &destroyuav, &onlowhealth);
    uav thread function_b240d230(100000);
    uav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", undefined, 1);
    uav.rocketdamage = uav.maxhealth + 1;
    minflyheight = int(airsupport::getminimumflyheight());
    zoffset = minflyheight + (isdefined(level.uav_z_offset) ? level.uav_z_offset : 2500);
    angle = randomint(360);
    radiusoffset = (isdefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000) + randomint(isdefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000);
    xoffset = cos(angle) * radiusoffset;
    yoffset = sin(angle) * radiusoffset;
    anglevector = vectornormalize((xoffset, yoffset, zoffset));
    anglevector *= zoffset;
    anglevector = (anglevector[0], anglevector[1], zoffset - rotator.origin[2]);
    uav linkto(rotator, "tag_origin", anglevector, (0, angle + attach_angle, 0));
    self stats::function_4f10b697(getweapon("uav"), #"used", 1);
    uav thread killstreaks::waitfortimeout("uav", 20000, &ontimeout, "delete", "death", "crashing");
    uav thread killstreaks::waitfortimecheck(20000 / 2, &ontimecheck, "delete", "death", "crashing");
    uav thread startuavfx();
    self killstreaks::play_killstreak_start_dialog("uav", self.team, killstreak_id);
    uav killstreaks::play_pilot_dialog_on_owner("arrive", "uav", killstreak_id);
    uav thread killstreaks::player_killstreak_threat_tracking("uav");
    return true;
}

// Namespace uav/uav
// Params 2, eflags: 0x0
// Checksum 0xd54db4a8, Offset: 0x1190
// Size: 0x7c
function onlowhealth(attacker, weapon) {
    self.is_damaged = 1;
    params = level.killstreakbundle[#"uav"];
    if (isdefined(params.fxlowhealth)) {
        playfxontag(params.fxlowhealth, self, "tag_origin");
    }
}

// Namespace uav/uav
// Params 2, eflags: 0x0
// Checksum 0x365ba774, Offset: 0x1218
// Size: 0x2c
function onteamchange(entnum, event) {
    destroyuav(undefined, undefined);
}

// Namespace uav/uav
// Params 2, eflags: 0x0
// Checksum 0x5f220dbb, Offset: 0x1250
// Size: 0x284
function destroyuav(attacker, weapon) {
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
        attacker battlechatter::function_b5530e2c("uav", weapon);
        challenges::destroyedaircraft(attacker, weapon, 0);
        luinotifyevent(#"player_callout", 2, #"hash_7f902a0b5852fe90", attacker.entnum);
        attacker challenges::addflyswatterstat(weapon, self);
    }
    if (!self.leaving) {
        self removeactiveuav();
        self killstreaks::play_destroyed_dialog_on_owner("uav", self.killstreak_id);
    }
    self notify(#"crashing");
    self playsound(#"evt_helicopter_midair_exp");
    params = level.killstreakbundle[#"uav"];
    if (isdefined(params.ksexplosionfx)) {
        playfxontag(params.ksexplosionfx, self, "tag_origin");
    }
    self stoploopsound();
    self setmodel(#"tag_origin");
    target_remove(self);
    self unlink();
    wait 0.5;
    arrayremovevalue(level.spawneduavs, self);
    self notify(#"delete");
    self delete();
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x41ceff5c, Offset: 0x14e0
// Size: 0x5e
function onplayerconnect() {
    self.entnum = self getentitynumber();
    if (!level.teambased) {
        level.activeuavs[self.entnum] = 0;
    }
    level.activeplayeruavs[self.entnum] = 0;
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x9f031c41, Offset: 0x1548
// Size: 0x50
function onplayerspawned() {
    self endon(#"disconnect");
    if (level.teambased == 0 || level.multiteam == 1) {
        level notify(#"uav_update");
    }
}

// Namespace uav/uav
// Params 1, eflags: 0x0
// Checksum 0xe924481f, Offset: 0x15a0
// Size: 0x1c
function onplayerjoinedteam(params) {
    hidealluavstosameteam();
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x9f5c113e, Offset: 0x15c8
// Size: 0xfc
function ontimeout() {
    playafterburnerfx();
    if (isdefined(self.is_damaged) && self.is_damaged) {
        playfxontag("killstreaks/fx_uav_damage_trail", self, "tag_body");
    }
    self killstreaks::play_pilot_dialog_on_owner("timeout", "uav");
    self.leaving = 1;
    self removeactiveuav();
    airsupport::leave(10);
    wait 10;
    target_remove(self);
    arrayremovevalue(level.spawneduavs, self);
    self delete();
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x62950503, Offset: 0x16d0
// Size: 0x34
function ontimecheck() {
    self killstreaks::play_pilot_dialog_on_owner("timecheck", "uav", self.killstreak_id);
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x1ab42973, Offset: 0x1710
// Size: 0x74
function startuavfx() {
    self endon(#"death");
    wait 0.1;
    if (isdefined(self)) {
        playfxontag("killstreaks/fx_uav_lights", self, "tag_origin");
        self playloopsound(#"veh_uav_engine_loop", 1);
    }
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x53ad2400, Offset: 0x1790
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
// Checksum 0x6f049e74, Offset: 0x1820
// Size: 0x20
function hasuav(team_or_entnum) {
    return level.activeuavs[team_or_entnum] > 0;
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x68c10e6e, Offset: 0x1848
// Size: 0xd8
function addactiveuav() {
    if (level.teambased) {
        assert(isdefined(self.team));
        level.activeuavs[self.team]++;
    } else {
        assert(isdefined(self.entnum));
        if (!isdefined(self.entnum)) {
            self.entnum = self getentitynumber();
        }
        level.activeuavs[self.entnum]++;
    }
    level.activeplayeruavs[self.entnum]++;
    level notify(#"uav_update");
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x7da913e5, Offset: 0x1928
// Size: 0x54
function removeactiveuav() {
    uav = self;
    uav resetactiveuav();
    uav killstreakrules::killstreakstop("uav", self.originalteam, self.killstreak_id);
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xe77ab91d, Offset: 0x1988
// Size: 0x200
function resetactiveuav() {
    if (level.teambased) {
        level.activeuavs[self.team]--;
        assert(level.activeuavs[self.team] >= 0);
        if (level.activeuavs[self.team] < 0) {
            level.activeuavs[self.team] = 0;
        }
    } else if (isdefined(self.owner)) {
        assert(isdefined(self.owner.entnum));
        if (!isdefined(self.owner.entnum)) {
            self.owner.entnum = self.owner getentitynumber();
        }
        level.activeuavs[self.owner.entnum]--;
        assert(level.activeuavs[self.owner.entnum] >= 0);
        if (level.activeuavs[self.owner.entnum] < 0) {
            level.activeuavs[self.owner.entnum] = 0;
        }
    }
    if (isdefined(self.owner)) {
        level.activeplayeruavs[self.owner.entnum]--;
        assert(level.activeplayeruavs[self.owner.entnum] >= 0);
    }
    level notify(#"uav_update");
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0xa4b27a2a, Offset: 0x1b90
// Size: 0x2ac
function uavtracker() {
    level endon(#"game_ended");
    while (true) {
        level waittill(#"uav_update");
        if (level.teambased) {
            foreach (team, _ in level.teams) {
                activeuavs = level.activeuavs[team];
                activeuavsandsatellites = activeuavs + (isdefined(level.activesatellites) ? level.activesatellites[team] : 0);
                setteamspyplane(team, int(min(activeuavs, 2)));
                util::set_team_radar(team, activeuavsandsatellites > 0);
            }
            continue;
        }
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            assert(isdefined(player.entnum));
            if (!isdefined(player.entnum)) {
                player.entnum = player getentitynumber();
            }
            activeuavs = level.activeuavs[player.entnum];
            activeuavsandsatellites = activeuavs + (isdefined(level.activesatellites) ? level.activesatellites[player.entnum] : 0);
            player setclientuivisibilityflag("radar_client", activeuavsandsatellites > 0);
            player.hasspyplane = int(min(activeuavs, 2));
        }
    }
}

// Namespace uav/uav
// Params 0, eflags: 0x0
// Checksum 0x390ec538, Offset: 0x1e48
// Size: 0x88
function hidealluavstosameteam() {
    foreach (uav in level.spawneduavs) {
        if (isdefined(uav)) {
            uav teams::hidetosameteam();
        }
    }
}

