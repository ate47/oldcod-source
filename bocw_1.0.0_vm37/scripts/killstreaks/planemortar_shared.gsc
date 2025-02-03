#using script_396f7d71538c9677;
#using script_4721de209091b1a6;
#using script_79aa222369853cdc;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace planemortar;

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x0
// Checksum 0xad9e4513, Offset: 0x238
// Size: 0x104
function init_shared() {
    if (!isdefined(level.planemortar_shared)) {
        level.planemortar_shared = {};
        airsupport::init_shared();
        clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int");
        clientfield::register_clientuimodel("hudItems.planeMortarShotsRemaining", 1, 2, "int");
        killstreaks::function_d8c32ca4("planemortar", &function_a385666);
        killstreaks::function_94c74046("planemortar");
        scene::add_scene_func(#"p9_fxanim_mp_planemortar_01_bundle", &function_ac3ad2f8, "play");
    }
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x0
// Checksum 0x1316741c, Offset: 0x348
// Size: 0x80
function function_a385666(slot) {
    assert(slot != 3);
    var_127d1ed1 = isdefined(self.pers[#"hash_1aaccfe69e328d6e"][slot]) ? self.pers[#"hash_1aaccfe69e328d6e"][slot] : 0;
    return var_127d1ed1 > 0;
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x0
// Checksum 0xd514d0cc, Offset: 0x3d0
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
// Checksum 0x3850d404, Offset: 0x450
// Size: 0x56
function waittill_confirm_location() {
    self endon(#"emp_jammed", #"emp_grenaded");
    waitresult = self waittill(#"confirm_location");
    return waitresult.position;
}

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x0
// Checksum 0xa88d0530, Offset: 0x4b0
// Size: 0x4c
function function_a3cb6b44() {
    radius = sessionmodeiswarzonegame() ? 2000 : 800;
    self beginlocationmortarselection("lui_plane_mortar", radius);
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x0
// Checksum 0x72a39b31, Offset: 0x508
// Size: 0x5a8
function selectplanemortarlocation(hardpointtype) {
    self endon(#"disconnect");
    params = killstreaks::get_script_bundle("planemortar");
    self airsupport::function_9e2054b0(&function_a3cb6b44);
    if (is_true(params.var_7436c1c5) && !is_true(self.pers[#"mortarradarused"])) {
        self thread airsupport::singleradarsweep();
    }
    if (isdefined(level.var_269fec2)) {
        self [[ level.var_269fec2 ]]();
    }
    if (!isdefined(self.var_b86e8690)) {
        self.var_b86e8690 = new throttle();
        [[ self.var_b86e8690 ]]->initialize(1, params.var_e847a141);
    }
    killstreakid = undefined;
    slot = killstreaks::function_a2c375bb(hardpointtype);
    if (!isdefined(self.pers[#"hash_1aaccfe69e328d6e"])) {
        self.pers[#"hash_1aaccfe69e328d6e"] = [];
    } else if (!isarray(self.pers[#"hash_1aaccfe69e328d6e"])) {
        self.pers[#"hash_1aaccfe69e328d6e"] = array(self.pers[#"hash_1aaccfe69e328d6e"]);
    }
    selections = isdefined(self.pers[#"hash_1aaccfe69e328d6e"][slot]) ? self.pers[#"hash_1aaccfe69e328d6e"][slot] : 3;
    self.pers[#"hash_1aaccfe69e328d6e"][slot] = selections;
    clientfield::set_player_uimodel("hudItems.planeMortarShotsRemaining", selections);
    yaw = randomintrange(0, 360);
    for (i = 0; i < selections; i++) {
        location = self airsupport::waitforlocationselection();
        if (!isdefined(location.origin) || i == 0 && self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
            if (isdefined(killstreakid)) {
                self thread function_16f87e96(6);
            }
            self.pers[#"hash_1aaccfe69e328d6e"][slot] = selections - i;
            self.pers[#"mortarradarused"] = 1;
            self notify(#"cancel_selection");
            return false;
        }
        if (!isdefined(killstreakid)) {
            killstreakid = self killstreakrules::killstreakstart("planemortar", self.team, 0, 1);
            if ((isdefined(self.var_fb18d24e) ? self.var_fb18d24e : 0) < gettime()) {
                self namespace_f9b02f80::play_killstreak_start_dialog("planemortar", self.team, killstreakid);
                self.var_fb18d24e = gettime() + int(battlechatter::mpdialog_value("planeMortarCooldown", 7) * 1000);
            }
            self thread function_5f89ffc2(hardpointtype, self.usingkillstreakfrominventory, slot);
        }
        clientfield::set_player_uimodel("hudItems.planeMortarShotsRemaining", selections - i - 1);
        self thread function_c47dc560(location.origin, killstreakid, params, i + 1, selections, yaw, self.usingkillstreakfrominventory, slot);
        self playsoundtoplayer(#"hash_40ab546591b2ecfa", self);
        wait 0.2;
    }
    if (!is_true(self.usingkillstreakfrominventory)) {
        self killstreakrules::function_d9f8f32b("planemortar");
    }
    self notify(#"used");
    self.pers[#"hash_1aaccfe69e328d6e"][slot] = undefined;
    self.pers[#"mortarradarused"] = 0;
    self thread function_16f87e96(6);
    return true;
}

// Namespace planemortar/planemortar_shared
// Params 8, eflags: 0x0
// Checksum 0xe591d82f, Offset: 0xab8
// Size: 0x104
function function_c47dc560(position, killstreakid, params, currentselection, var_cd46130c, yaw, isfrominventory, slot) {
    team = self.team;
    if (currentselection == 1) {
        if (var_cd46130c == 3) {
            self stats::function_e24eec31(params.ksweapon, #"used", 1);
        }
        self thread planemortar_watchforendnotify(team, killstreakid, params.var_d3413870, isfrominventory, slot);
    }
    [[ self.var_b86e8690 ]]->waitinqueue();
    if (isdefined(self)) {
        wait 0.1;
        self function_fd2f978f(params, position, team, yaw);
    }
}

// Namespace planemortar/planemortar_shared
// Params 4, eflags: 0x0
// Checksum 0xeeb31f98, Offset: 0xbc8
// Size: 0x10c
function function_fd2f978f(params, position, team, yaw) {
    self endon(#"disconnect");
    if (isdefined(params.var_675bebb2)) {
        wait params.var_675bebb2;
    }
    var_b0490eb9 = getheliheightlockheight(position);
    trace = groundtrace(position + (0, 0, var_b0490eb9), position + (0, 0, var_b0490eb9 * -1), 1, undefined);
    hitposition = trace[#"position"];
    level influencers::create_enemy_influencer("artillery", hitposition, team);
    self thread function_83e61117(hitposition, yaw);
}

// Namespace planemortar/planemortar_shared
// Params 2, eflags: 0x0
// Checksum 0x120293eb, Offset: 0xce0
// Size: 0x1fc
function doplanemortar(positions, team) {
    self endon(#"emp_jammed", #"disconnect");
    params = killstreaks::get_script_bundle("planemortar");
    wait params.var_675bebb2;
    if (!isdefined(positions)) {
        positions = [];
    } else if (!isarray(positions)) {
        positions = array(positions);
    }
    yaw = randomintrange(0, 360);
    odd = 0;
    foreach (position in positions) {
        level influencers::create_enemy_influencer("artillery", position.origin, team);
        self thread function_4ef32baf(position.origin, yaw, team);
        if (odd == 0) {
            yaw = (yaw + 35) % 360;
        } else {
            yaw = (yaw + 290) % 360;
        }
        odd = (odd + 1) % 2;
        wait 0.8;
    }
    if (positions.size > 1) {
        self function_16f87e96();
    }
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x0
// Checksum 0xc674e7a7, Offset: 0xee8
// Size: 0x68
function function_16f87e96(predelay) {
    self endon(#"disconnect");
    if (isdefined(predelay)) {
        wait predelay;
    }
    self notify(#"planemortarcomplete");
    wait 1;
    if (isdefined(level.plane_mortar_bda_dialog)) {
        self thread [[ level.plane_mortar_bda_dialog ]]();
    }
}

// Namespace planemortar/planemortar_shared
// Params 3, eflags: 0x0
// Checksum 0xa0d94add, Offset: 0xf58
// Size: 0xe4
function function_5f89ffc2(hardpointtype, isfrominventory = 0, slot) {
    result = self waittill(#"death", #"killstreak_used");
    if (isdefined(self) && result._notify == "death") {
        self.pers[#"hash_1aaccfe69e328d6e"][slot] = undefined;
        self killstreaks::function_aa56f6a0(hardpointtype, isfrominventory);
        if (!isfrominventory) {
            self killstreakrules::function_d9f8f32b("planemortar");
        }
    }
}

// Namespace planemortar/planemortar_shared
// Params 5, eflags: 0x0
// Checksum 0x91452c6, Offset: 0x1048
// Size: 0x154
function planemortar_watchforendnotify(team, killstreak_id, *killstreaktype, isfrominventory = 0, slot) {
    self notify("29c03a1d99cbfb50");
    self endon("29c03a1d99cbfb50");
    self waittill(#"disconnect", #"joined_team", #"joined_spectators", #"planemortarcomplete", #"emp_jammed");
    killstreakrules::killstreakstop("planemortar", killstreak_id, killstreaktype);
    if (isdefined(self) && !isfrominventory) {
        var_b47e114f = isdefined(self.pers[#"hash_1aaccfe69e328d6e"][slot]) ? self.pers[#"hash_1aaccfe69e328d6e"][slot] : 0;
        if (!var_b47e114f) {
            self killstreakrules::function_d9f8f32b("planemortar");
        }
    }
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x4
// Checksum 0x715a0950, Offset: 0x11a8
// Size: 0x24a
function private function_ac3ad2f8(ents) {
    var_5496c504 = ents[#"bomb"];
    var_5496c504 endon(#"death");
    var_5496c504 waittill(#"spawn_killcam");
    angles = (35, self.angles[1] - 180, 0);
    direction = anglestoforward(angles);
    scenelength = scene::function_12479eba(#"p9_fxanim_mp_planemortar_01_bundle");
    weapon = getweapon("planemortar");
    killcament = spawn("script_model", var_5496c504 gettagorigin("tag_killcam") + vectorscale(direction, -1500));
    killcament util::deleteaftertime(scenelength * 2);
    killcament.starttime = gettime();
    killcament.angles = angles;
    killcament linkto(var_5496c504, "tag_killcam");
    killcament setweapon(weapon);
    killcament killcam::store_killcam_entity_on_entity(self);
    killcament thread function_6ffdbd95(var_5496c504);
    var_5496c504 waittill(#"magic_missile");
    if (isdefined(self.owner)) {
        bomb = self.owner magicmissile(weapon, self.origin + (0, 0, 100), (0, 0, -5000));
        bomb.killcament = killcament;
    }
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x0
// Checksum 0x4fa365e1, Offset: 0x1400
// Size: 0xac
function function_6ffdbd95(var_5496c504) {
    self endon(#"death");
    var_5496c504 endon(#"death");
    self rotatepitch(15, 3.5);
    wait 3.5;
    self rotatepitch(-15, 3);
    var_5496c504 waittill(#"unlink_killcam");
    self unlink();
}

/#

    // Namespace planemortar/planemortar_shared
    // Params 2, eflags: 0x0
    // Checksum 0x4962189c, Offset: 0x14b8
    // Size: 0x1e0
    function function_77ed0e9b(var_5496c504, fxanim) {
        var_5496c504 endon(#"magic_missile");
        while (true) {
            println("<dev string:x38>" + fxanim.angles);
            println("<dev string:x4b>" + fxanim.origin);
            println("<dev string:x5e>" + var_5496c504.origin);
            println("<dev string:x6f>" + self.origin);
            offset = var_5496c504.origin - self.origin;
            println("<dev string:x84>" + offset);
            var_2c942dba = vectornormalize(offset);
            println("<dev string:x99>" + var_2c942dba);
            println("<dev string:xb5>" + vectortoangles(var_2c942dba));
            println("<dev string:xd1>" + self.angles);
            println("<dev string:xe6>" + anglestoforward(self.angles));
            wait 0.5;
        }
    }

#/

// Namespace planemortar/planemortar_shared
// Params 2, eflags: 0x0
// Checksum 0xde95b9cb, Offset: 0x16a0
// Size: 0xc4
function function_83e61117(position, baseyaw) {
    yaw = baseyaw + randomfloatrange(-1, 1);
    var_81c41c6e = util::spawn_model("tag_origin", position, (0, baseyaw, 0));
    var_81c41c6e.owner = self;
    var_81c41c6e scene::play(#"p9_fxanim_mp_planemortar_01_bundle");
    wait 0.5;
    if (isdefined(var_81c41c6e)) {
        var_81c41c6e delete();
    }
}

// Namespace planemortar/planemortar_shared
// Params 3, eflags: 0x0
// Checksum 0xa260509f, Offset: 0x1770
// Size: 0x564
function function_4ef32baf(position, yaw, team) {
    self endon(#"emp_jammed");
    player = self;
    angles = (0, yaw, 0);
    direction = anglestoforward(angles);
    height = killstreaks::function_43f4782d() + 2000 + randomfloatrange(-200, 200);
    position = (position[0] + randomfloat(30), position[1] + randomfloat(30), height);
    startpoint = position + vectorscale(direction, -12000);
    endpoint = position + vectorscale(direction, 18000);
    height = airsupport::getnoflyzoneheightcrossed(startpoint, endpoint, height);
    height += randomfloatrange(-200, 200);
    startpoint = (startpoint[0], startpoint[1], height);
    position = (position[0], position[1], height);
    endpoint = (endpoint[0], endpoint[1], height);
    plane = spawn("script_model", startpoint);
    plane.weapon = getweapon("planemortar");
    plane setweapon(plane.weapon);
    plane.team = team;
    plane setteam(team);
    plane.targetname = "plane_mortar";
    plane setowner(self);
    plane.owner = self;
    plane endon(#"delete", #"death");
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
    playsoundatposition(#"hash_5a17b7541482a04f", plane.origin);
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
// Checksum 0xab7fcfbc, Offset: 0x1ce0
// Size: 0xcc
function followbomb(plane, *position, direction, impact, player) {
    player endon(#"emp_jammed");
    wait 2 * 5 / 12;
    position.killcament unlink();
    position.killcament moveto(impact[#"position"] + (0, 0, 1000) + vectorscale(direction, -600), 0.8, 0, 0.2);
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x0
// Checksum 0x48fe1bbb, Offset: 0x1db8
// Size: 0xa0
function lookatexplosion(bomb) {
    while (isdefined(self) && isdefined(bomb)) {
        angles = vectortoangles(vectornormalize(bomb.origin - self.origin));
        self.angles = (max(angles[0], 15), angles[1], angles[2]);
        waitframe(1);
    }
}

// Namespace planemortar/planemortar_shared
// Params 1, eflags: 0x0
// Checksum 0x8625b38b, Offset: 0x1e60
// Size: 0x94
function planewatchforemp(*owner) {
    self endon(#"delete", #"death");
    waitresult = self waittill(#"emp_deployed");
    if (isdefined(level.planeawardscoreevent)) {
        thread [[ level.planeawardscoreevent ]](waitresult.attacker, self);
    }
    self plane_cleanupondeath();
}

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x0
// Checksum 0x889fdb94, Offset: 0x1f00
// Size: 0x1c
function plane_cleanupondeath() {
    self delete();
}

// Namespace planemortar/planemortar_shared
// Params 2, eflags: 0x0
// Checksum 0xd707407e, Offset: 0x1f28
// Size: 0x22c
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

