#using scripts\core_common\clientfield_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace planemortar;

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x0
// Checksum 0x7ffb2584, Offset: 0x1d8
// Size: 0x74
function init_shared() {
    if (!isdefined(level.planemortar_shared)) {
        level.planemortar_shared = {};
        airsupport::init_shared();
        level.planemortarexhaustfx = "killstreaks/fx_ls_exhaust_afterburner";
        clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int");
    }
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x0
// Checksum 0xd6883478, Offset: 0x258
// Size: 0x74
function usekillstreakplanemortar(hardpointtype) {
    if (self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
        return false;
    }
    result = self selectplanemortarlocation(hardpointtype);
    if (!isdefined(result) || !result) {
        return false;
    }
    return true;
}

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x0
// Checksum 0x6ebf84ca, Offset: 0x2d8
// Size: 0x4e
function waittill_confirm_location() {
    self endon(#"emp_jammed");
    self endon(#"emp_grenaded");
    waitresult = self waittill(#"confirm_location");
    return waitresult.position;
}

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x0
// Checksum 0x6755b597, Offset: 0x330
// Size: 0x34
function function_9f02fce1() {
    self beginlocationmortarselection("map_mortar_selector", 800, "map_mortar_selector_done", "map_mortar_selector_radius");
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x0
// Checksum 0x996d05d, Offset: 0x370
// Size: 0x1f2
function selectplanemortarlocation(hardpointtype) {
    self airsupport::function_277a9e(&function_9f02fce1);
    locations = [];
    if (!isdefined(self.pers[#"mortarradarused"]) || !self.pers[#"mortarradarused"]) {
        self thread singleradarsweep();
    }
    if (isdefined(level.var_86d52c42)) {
        self [[ level.var_86d52c42 ]]();
    }
    for (i = 0; i < 3; i++) {
        location = self airsupport::waitforlocationselection();
        if (!isdefined(self)) {
            return 0;
        }
        if (!isdefined(location.origin)) {
            self.pers[#"mortarradarused"] = 1;
            self notify(#"cancel_selection");
            return 0;
        }
        locations[i] = location;
    }
    if (self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
        self.pers[#"mortarradarused"] = 1;
        self notify(#"cancel_selection");
        return 0;
    }
    self.pers[#"mortarradarused"] = 0;
    return self airsupport::function_4293d951(locations, &useplanemortar, "planemortar");
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x0
// Checksum 0x3ba68dac, Offset: 0x570
// Size: 0x90
function waitplaybacktime(soundalias) {
    self endon(#"death");
    self endon(#"disconnect");
    playbacktime = soundgetplaybacktime(soundalias);
    if (playbacktime >= 0) {
        waittime = playbacktime * 0.001;
        wait waittime;
    } else {
        wait 1;
    }
    self notify(soundalias);
}

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x0
// Checksum 0xd7424bce, Offset: 0x608
// Size: 0x84
function singleradarsweep() {
    self endon(#"disconnect");
    self endon(#"cancel_selection");
    wait 0.5;
    self playlocalsound(#"mpl_killstreak_satellite");
    if (self.hasspyplane == 0 && !level.forceradar) {
        self thread doradarsweep();
    }
}

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x0
// Checksum 0xbba9961b, Offset: 0x698
// Size: 0x4c
function doradarsweep() {
    self setclientuivisibilityflag("g_compassShowEnemies", 1);
    wait 0.2;
    self setclientuivisibilityflag("g_compassShowEnemies", 0);
}

// Namespace planemortar/planemortar_shared
// Params 2, eflags: 0x0
// Checksum 0x52ace3f2, Offset: 0x6f0
// Size: 0xa8
function useplanemortar(positions, killstreak_id) {
    team = self.team;
    self.planemortarpilotindex = killstreaks::get_random_pilot_index("planemortar");
    self killstreaks::play_pilot_dialog("arrive", "planemortar", undefined, self.planemortarpilotindex);
    self thread planemortar_watchforendnotify(team, killstreak_id);
    self thread doplanemortar(positions, team, killstreak_id);
    return true;
}

// Namespace planemortar/planemortar_shared
// Params 3, eflags: 0x0
// Checksum 0xcf471249, Offset: 0x7a0
// Size: 0x1c0
function doplanemortar(positions, team, killstreak_id) {
    self endon(#"emp_jammed");
    self endon(#"disconnect");
    yaw = randomintrange(0, 360);
    odd = 0;
    wait 1.25;
    foreach (position in positions) {
        level influencers::create_enemy_influencer("artillery", position.origin, team);
        self thread dobombrun(position.origin, yaw, team);
        if (odd == 0) {
            yaw = (yaw + 35) % 360;
        } else {
            yaw = (yaw + 290) % 360;
        }
        odd = (odd + 1) % 2;
        wait 0.8;
    }
    self notify(#"planemortarcomplete");
    wait 1;
    if (isdefined(level.plane_mortar_bda_dialog)) {
        self thread [[ level.plane_mortar_bda_dialog ]]();
    }
}

// Namespace planemortar/planemortar_shared
// Params 2, eflags: 0x0
// Checksum 0xefc9013a, Offset: 0x968
// Size: 0x84
function planemortar_watchforendnotify(team, killstreak_id) {
    self waittill(#"disconnect", #"joined_team", #"joined_spectators", #"planemortarcomplete", #"emp_jammed");
    planemortar_killstreakstop(team, killstreak_id);
}

// Namespace planemortar/planemortar_shared
// Params 2, eflags: 0x0
// Checksum 0x259b2482, Offset: 0x9f8
// Size: 0x34
function planemortar_killstreakstop(team, killstreak_id) {
    killstreakrules::killstreakstop("planemortar", team, killstreak_id);
}

// Namespace planemortar/planemortar_shared
// Params 3, eflags: 0x0
// Checksum 0x4436f18b, Offset: 0xa38
// Size: 0x53c
function dobombrun(position, yaw, team) {
    self endon(#"emp_jammed");
    player = self;
    angles = (0, yaw, 0);
    direction = anglestoforward(angles);
    height = airsupport::getminimumflyheight() + 2000 + randomfloatrange(-200, 200);
    position = (position[0] + randomfloat(30), position[1] + randomfloat(30), height);
    startpoint = position + vectorscale(direction, -12000);
    endpoint = position + vectorscale(direction, 18000);
    height = airsupport::getnoflyzoneheightcrossed(startpoint, endpoint, height);
    height += randomfloatrange(-200, 200);
    startpoint = (startpoint[0], startpoint[1], height);
    position = (position[0], position[1], height);
    endpoint = (endpoint[0], endpoint[1], height);
    plane = spawn("script_model", startpoint);
    plane.team = team;
    plane setteam(team);
    plane.targetname = "plane_mortar";
    plane setowner(self);
    plane.owner = self;
    plane endon(#"delete");
    plane endon(#"death");
    plane thread planewatchforemp(self);
    plane.angles = angles;
    plane setmodel("veh_t8_mil_air_jet_fighter_mp_light");
    plane setenemymodel("veh_t8_mil_air_jet_fighter_mp_dark");
    plane clientfield::set("planemortar_contrail", 1);
    plane clientfield::set("enemyvehicle", 1);
    plane playsound(#"mpl_lightning_flyover_boom");
    plane setdrawinfrared(1);
    plane.killcament = spawn("script_model", plane.origin + (0, 0, 700) + vectorscale(direction, -1500));
    plane.killcament util::deleteaftertime(2 * 3);
    plane.killcament.angles = (15, yaw, 0);
    plane.killcament.starttime = gettime();
    plane.killcament linkto(plane);
    start = (position[0], position[1], plane.origin[2]);
    impact = bullettrace(start, start + (0, 0, -100000), 1, plane);
    plane moveto(endpoint, 2 * 5 / 4, 0, 0);
    plane.killcament thread followbomb(plane, position, direction, impact, player);
    wait 2 / 2;
    if (isdefined(self)) {
        self thread dropbomb(plane, position);
    }
    wait 2 * 3 / 4;
    plane plane_cleanupondeath();
}

// Namespace planemortar/planemortar_shared
// Params 5, eflags: 0x0
// Checksum 0x693427f5, Offset: 0xf80
// Size: 0xcc
function followbomb(plane, position, direction, impact, player) {
    player endon(#"emp_jammed");
    wait 2 * 5 / 12;
    plane.killcament unlink();
    plane.killcament moveto(impact[#"position"] + (0, 0, 1000) + vectorscale(direction, -600), 0.8, 0, 0.2);
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x0
// Checksum 0x6b179a2d, Offset: 0x1058
// Size: 0xa8
function lookatexplosion(bomb) {
    while (isdefined(self) && isdefined(bomb)) {
        angles = vectortoangles(vectornormalize(bomb.origin - self.origin));
        self.angles = (max(angles[0], 15), angles[1], angles[2]);
        waitframe(1);
    }
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x0
// Checksum 0x23dec2ab, Offset: 0x1108
// Size: 0x8c
function planewatchforemp(owner) {
    self endon(#"delete");
    self endon(#"death");
    waitresult = self waittill(#"emp_deployed");
    if (isdefined(level.planeawardscoreevent)) {
        thread [[ level.planeawardscoreevent ]](waitresult.attacker, self);
    }
    self plane_cleanupondeath();
}

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x0
// Checksum 0x94ab99e8, Offset: 0x11a0
// Size: 0x1c
function plane_cleanupondeath() {
    self delete();
}

// Namespace planemortar/planemortar_shared
// Params 2, eflags: 0x0
// Checksum 0xe87c5499, Offset: 0x11c8
// Size: 0x23c
function dropbomb(plane, bombposition) {
    if (!isdefined(plane.owner)) {
        return;
    }
    z = bombposition[2];
    targets = getplayers();
    foreach (target in targets) {
        if (plane.owner util::isenemyplayer(target) && distance2dsquared(target.origin, bombposition) < 250000) {
            if (bullettracepassed((target.origin[0], target.origin[1], plane.origin[2]), target.origin, 0, plane)) {
                bombposition = target.origin;
                break;
            }
        }
    }
    bombposition = (bombposition[0], bombposition[1], z - 100);
    bomb = self magicmissile(getweapon("planemortar"), bombposition, (0, 0, -5000));
    bomb.soundmod = "heli";
    bomb playsound(#"mpl_lightning_bomb_incoming");
    bomb.killcament = plane.killcament;
    plane.killcament thread lookatexplosion(bomb);
}

