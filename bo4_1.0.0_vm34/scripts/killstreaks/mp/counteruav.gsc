#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\teams\teams;
#using scripts\weapons\heatseekingmissile;

#namespace counteruav;

// Namespace counteruav/counteruav
// Params 0, eflags: 0x2
// Checksum 0x2a004f88, Offset: 0x1f0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"counteruav", &__init__, undefined, #"killstreaks");
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x45e139e2, Offset: 0x240
// Size: 0x28c
function __init__() {
    level.activecounteruavs = [];
    level.counter_uav_offsets = buildoffsetlist((0, 0, 0), 3, 450, 450);
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            level.activecounteruavs[team] = 0;
        }
    } else {
        level.activecounteruavs = [];
    }
    level.activeplayercounteruavs = [];
    level.counter_uav_entities = [];
    if (tweakables::gettweakablevalue("killstreak", "allowcounteruav")) {
        killstreaks::register_killstreak("killstreak_counteruav", &activatecounteruav);
    }
    clientfield::register("toplayer", "counteruav", 1, 1, "int");
    level thread watchcounteruavs();
    callback::on_connect(&onplayerconnect);
    callback::on_spawned(&onplayerspawned);
    callback::on_joined_team(&onplayerjoinedteam);
    callback::on_finalize_initialization(&function_6567e2dd);
    callback::on_connect(&onplayerconnect);
    callback::add_callback(#"hash_425352b435722271", &function_967a80ab);
    /#
        if (getdvarint(#"scr_cuav_offset_debug", 0)) {
            level thread waitanddebugdrawoffsetlist();
        }
    #/
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x0
// Checksum 0xfbedf601, Offset: 0x4d8
// Size: 0x118
function function_967a80ab(params) {
    foreach (player in params.players) {
        if (level.activeplayercounteruavs[player.entnum] > 0) {
            scoregiven = scoreevents::processscoreevent(#"counter_uav_assist", player, undefined, undefined);
            if (isdefined(scoregiven)) {
                player challenges::earnedcuavassistscore(scoregiven);
                killstreakindex = level.killstreakindices[#"counteruav"];
                killstreaks::killstreak_assist(player, self, killstreakindex);
            }
        }
    }
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x8cc06bf2, Offset: 0x5f8
// Size: 0x1e
function function_6567e2dd() {
    profilestart();
    initrotatingrig();
    profilestop();
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xa631b31b, Offset: 0x620
// Size: 0x5e
function onplayerconnect() {
    self.entnum = self getentitynumber();
    if (!level.teambased) {
        level.activecounteruavs[self.entnum] = 0;
    }
    level.activeplayercounteruavs[self.entnum] = 0;
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x7015f314, Offset: 0x688
// Size: 0x5c
function onplayerspawned() {
    if (self enemycounteruavactive()) {
        self clientfield::set_to_player("counteruav", 1);
        return;
    }
    self clientfield::set_to_player("counteruav", 0);
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x8cbd837, Offset: 0x6f0
// Size: 0x1d4
function initrotatingrig() {
    if (isdefined(level.var_2a5b90f0)) {
        map_center = airsupport::getmapcenter();
        rotator_offset = (isdefined(level.var_2a5b90f0) ? level.var_2a5b90f0 : map_center[0], isdefined(level.var_580f865b) ? level.var_580f865b : map_center[1], isdefined(level.var_1c64b02a) ? level.var_1c64b02a : 1200);
        level.var_77491466 = spawn("script_model", rotator_offset);
    } else {
        level.var_77491466 = spawn("script_model", airsupport::getmapcenter() + (isdefined(level.var_776a2779) ? level.var_776a2779 : 0, isdefined(level.var_eafbfac2) ? level.var_eafbfac2 : 0, 1200));
    }
    level.var_77491466 setmodel(#"tag_origin");
    level.var_77491466.angles = (0, 115, 0);
    level.var_77491466 hide();
    level.var_77491466 thread rotaterig();
    level.var_77491466 thread swayrig();
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xafae3d29, Offset: 0x8d0
// Size: 0x2e
function rotaterig() {
    for (;;) {
        self rotateyaw(360, 60);
        wait 60;
    }
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x8f61265a, Offset: 0x908
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

// Namespace counteruav/counteruav
// Params 1, eflags: 0x0
// Checksum 0x62855ff6, Offset: 0xa20
// Size: 0x14a
function generaterandompoints(count) {
    points = [];
    for (i = 0; i < count; i++) {
        point = airsupport::getrandommappoint(isdefined(level.cuav_map_x_offset) ? level.cuav_map_x_offset : 0, isdefined(level.cuav_map_y_offset) ? level.cuav_map_y_offset : 0, isdefined(level.cuav_map_x_percentage) ? level.cuav_map_x_percentage : 0.5, isdefined(level.cuav_map_y_percentage) ? level.cuav_map_y_percentage : 0.5);
        minflyheight = airsupport::getminimumflyheight();
        point += (0, 0, minflyheight + (isdefined(level.counter_uav_position_z_offset) ? level.counter_uav_position_z_offset : 1000));
        points[i] = point;
    }
    return points;
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x0
// Checksum 0x4acbb121, Offset: 0xb78
// Size: 0x12e
function movementmanagerthink(teamorentnum) {
    while (true) {
        level waittill(#"counter_uav_updated");
        activecount = 0;
        while (level.activecounteruavs[teamorentnum] > 0) {
            if (activecount == 0) {
                activecount = level.activecounteruavs[teamorentnum];
            }
            currentindex = level.counter_uav_position_index[teamorentnum];
            for (newindex = currentindex; newindex == currentindex; newindex = randomintrange(0, 20)) {
            }
            destination = level.counter_uav_positions[newindex];
            level.counter_uav_position_index[teamorentnum] = newindex;
            level notify("counter_uav_move_" + teamorentnum);
            wait 5 + randomintrange(5, 10);
        }
    }
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x0
// Checksum 0xf23573a2, Offset: 0xcb0
// Size: 0x5a
function getcurrentposition(teamorentnum) {
    baseposition = level.counter_uav_positions[level.counter_uav_position_index[teamorentnum]];
    offset = level.counter_uav_offsets[self.cuav_offset_index];
    return baseposition + offset;
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xda8876f5, Offset: 0xd18
// Size: 0x2c
function assignfirstavailableoffsetindex() {
    self.cuav_offset_index = getfirstavailableoffsetindex();
    maintaincouteruaventities();
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x164b97ee, Offset: 0xd50
// Size: 0x11e
function getfirstavailableoffsetindex() {
    available_offsets = [];
    for (i = 0; i < level.counter_uav_offsets.size; i++) {
        available_offsets[i] = 1;
    }
    foreach (cuav in level.counter_uav_entities) {
        if (isdefined(cuav)) {
            available_offsets[cuav.cuav_offset_index] = 0;
        }
    }
    for (i = 0; i < available_offsets.size; i++) {
        if (available_offsets[i]) {
            return i;
        }
    }
    /#
        util::warning("<dev string:x30>");
    #/
    return 0;
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xef398e88, Offset: 0xe78
// Size: 0x66
function maintaincouteruaventities() {
    for (i = level.counter_uav_entities.size; i >= 0; i--) {
        if (!isdefined(level.counter_uav_entities[i])) {
            arrayremoveindex(level.counter_uav_entities, i);
        }
    }
}

/#

    // Namespace counteruav/counteruav
    // Params 0, eflags: 0x0
    // Checksum 0x3ccad01d, Offset: 0xee8
    // Size: 0x34
    function waitanddebugdrawoffsetlist() {
        level endon(#"game_ended");
        wait 10;
        debugdrawoffsetlist();
    }

    // Namespace counteruav/counteruav
    // Params 0, eflags: 0x0
    // Checksum 0x5b50e893, Offset: 0xf28
    // Size: 0xd0
    function debugdrawoffsetlist() {
        baseposition = level.counter_uav_positions[0];
        foreach (offset in level.counter_uav_offsets) {
            util::debug_sphere(baseposition + offset, 24, (0.95, 0.05, 0.05), 0.75, 9999999);
        }
    }

#/

// Namespace counteruav/counteruav
// Params 4, eflags: 0x0
// Checksum 0x7fa10fc3, Offset: 0x1000
// Size: 0x142
function buildoffsetlist(startoffset, depth, offset_x, offset_y) {
    offsets = [];
    for (col = 0; col < depth; col++) {
        itemcount = math::pow(2, col);
        startingindex = itemcount - 1;
        for (i = 0; i < itemcount; i++) {
            x = offset_x * col;
            y = 0;
            if (itemcount > 1) {
                y = i * offset_y;
                total_y = offset_y * startingindex;
                y -= total_y / 2;
            }
            offsets[startingindex + i] = startoffset + (x, y, 0);
        }
    }
    return offsets;
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xd40f2fbc, Offset: 0x1150
// Size: 0x64
function function_56985ad4() {
    self endon(#"delete");
    waitresult = self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    destroycounteruav(waitresult.attacker, waitresult.weapon);
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xf97a0bda, Offset: 0x11c0
// Size: 0x2c0
function activatecounteruav() {
    if (self killstreakrules::iskillstreakallowed("counteruav", self.team) == 0) {
        return false;
    }
    killstreak_id = self killstreakrules::killstreakstart("counteruav", self.team);
    if (killstreak_id == -1) {
        return false;
    }
    counteruav = spawncounteruav(self, killstreak_id);
    if (!isdefined(counteruav)) {
        return false;
    }
    counteruav clientfield::set("enemyvehicle", 1);
    counteruav.killstreak_id = killstreak_id;
    counteruav thread killstreaks::waittillemp(&destroycounteruavbyemp);
    counteruav thread killstreaks::waitfortimeout("counteruav", 20000, &ontimeout, "delete", "death", "crashing");
    counteruav thread killstreaks::waitfortimecheck(20000 / 2, &ontimecheck, "delete", "death", "crashing");
    counteruav thread function_56985ad4();
    counteruav thread killstreaks::function_1c47e9c9("counteruav", &destroycounteruav, &onlowhealth, undefined);
    counteruav playloopsound("veh_uav_engine_loop", 1);
    counteruav function_c1d73465();
    self killstreaks::play_killstreak_start_dialog("counteruav", self.team, killstreak_id);
    counteruav killstreaks::play_pilot_dialog_on_owner("arrive", "counteruav", killstreak_id);
    counteruav thread killstreaks::player_killstreak_threat_tracking("counteruav");
    self stats::function_4f10b697(getweapon("counteruav"), #"used", 1);
    return true;
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x3e2ae41f, Offset: 0x1488
// Size: 0x1dc
function function_c1d73465() {
    minflyheight = int(airsupport::getminimumflyheight());
    zoffset = minflyheight + (isdefined(level.var_5fa88d7b) ? level.var_5fa88d7b : 2500);
    angle = randomint(360);
    radiusoffset = (isdefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000) + randomint(isdefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000);
    xoffset = cos(angle) * radiusoffset;
    yoffset = sin(angle) * radiusoffset;
    anglevector = vectornormalize((xoffset, yoffset, zoffset));
    anglevector *= zoffset;
    anglevector = (anglevector[0], anglevector[1], zoffset - level.var_77491466.origin[2]);
    self linkto(level.var_77491466, "tag_origin", anglevector, (0, angle + 90, 0));
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x0
// Checksum 0xfec1e5f4, Offset: 0x1670
// Size: 0x2c
function hackedprefunction(hacker) {
    cuav = self;
    cuav resetactivecounteruav();
}

// Namespace counteruav/counteruav
// Params 2, eflags: 0x0
// Checksum 0xa016126e, Offset: 0x16a8
// Size: 0x226
function spawncounteruav(owner, killstreak_id) {
    minflyheight = airsupport::getminimumflyheight();
    bundle = struct::get_script_bundle("killstreak", "killstreak_counteruav");
    cuav = spawnvehicle(bundle.ksvehicle, airsupport::getmapcenter() + (0, 0, minflyheight + (isdefined(level.counter_uav_position_z_offset) ? level.counter_uav_position_z_offset : 1000)), (0, 0, 0), "counteruav");
    cuav assignfirstavailableoffsetindex();
    cuav killstreaks::configure_team("counteruav", killstreak_id, owner, undefined, undefined, &configureteampost);
    cuav killstreak_hacking::enable_hacking("counteruav", &hackedprefunction, undefined);
    cuav.targetname = "counteruav";
    killstreak_detect::killstreaktargetset(cuav);
    cuav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", undefined, 1);
    cuav setdrawinfrared(1);
    if (!isdefined(level.counter_uav_entities)) {
        level.counter_uav_entities = [];
    } else if (!isarray(level.counter_uav_entities)) {
        level.counter_uav_entities = array(level.counter_uav_entities);
    }
    level.counter_uav_entities[level.counter_uav_entities.size] = cuav;
    return cuav;
}

// Namespace counteruav/counteruav
// Params 2, eflags: 0x0
// Checksum 0x3b84c162, Offset: 0x18d8
// Size: 0xc4
function configureteampost(owner, ishacked) {
    cuav = self;
    if (ishacked == 0) {
        cuav teams::hidetosameteam();
    } else {
        cuav setvisibletoall();
    }
    cuav thread teams::waituntilteamchangesingleton(owner, "CUAV_watch_team_change", &onteamchange, self.entnum, "death", "leaving", "crashing");
    cuav addactivecounteruav();
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xcfc71cca, Offset: 0x19a8
// Size: 0x72
function listenformove() {
    self endon(#"death");
    self endon(#"leaving");
    while (true) {
        self thread counteruavmove();
        level waittill("counter_uav_move_" + self.team, "counter_uav_move_" + self.ownerentnum);
    }
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x855a7c4d, Offset: 0x1a28
// Size: 0x14c
function counteruavmove() {
    self endon(#"death");
    self endon(#"leaving");
    level endon("counter_uav_move_" + self.team);
    destination = (0, 0, 0);
    if (level.teambased) {
        destination = self getcurrentposition(self.team);
    } else {
        destination = self getcurrentposition(self.ownerentnum);
    }
    lookangles = vectortoangles(destination - self.origin);
    rotationaccelerationduration = 0.5 * 0.2;
    rotationdecelerationduration = 0.5 * 0.2;
    travelaccelerationduration = 5 * 0.2;
    traveldecelerationduration = 5 * 0.2;
    self setgoal(destination, 1, 0);
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x0
// Checksum 0xde386a79, Offset: 0x1b80
// Size: 0x54
function playfx(name) {
    self endon(#"death");
    wait 0.1;
    if (isdefined(self)) {
        playfxontag(name, self, "tag_origin");
    }
}

// Namespace counteruav/counteruav
// Params 2, eflags: 0x0
// Checksum 0xf369c321, Offset: 0x1be0
// Size: 0x7c
function onlowhealth(attacker, weapon) {
    self.is_damaged = 1;
    params = level.killstreakbundle[#"counteruav"];
    if (isdefined(params.fxlowhealth)) {
        playfxontag(params.fxlowhealth, self, "tag_origin");
    }
}

// Namespace counteruav/counteruav
// Params 2, eflags: 0x0
// Checksum 0x1a6c8fa5, Offset: 0x1c68
// Size: 0x2c
function onteamchange(entnum, event) {
    destroycounteruav(undefined, undefined);
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x0
// Checksum 0xf541feb2, Offset: 0x1ca0
// Size: 0x1c
function onplayerjoinedteam(params) {
    hideallcounteruavstosameteam();
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xe9c1f26a, Offset: 0x1cc8
// Size: 0xb4
function ontimeout() {
    self.leaving = 1;
    self.owner globallogic_audio::play_taacom_dialog("timeout", "counteruav");
    self airsupport::leave(5);
    wait 5;
    self removeactivecounteruav();
    if (target_istarget(self)) {
        target_remove(self);
    }
    self delete();
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x349d9b1d, Offset: 0x1d88
// Size: 0x34
function ontimecheck() {
    self killstreaks::play_pilot_dialog_on_owner("timecheck", "counteruav", self.killstreak_id);
}

// Namespace counteruav/counteruav
// Params 2, eflags: 0x0
// Checksum 0xe13f6fbb, Offset: 0x1dc8
// Size: 0x44
function destroycounteruavbyemp(attacker, arg) {
    destroycounteruav(attacker, getweapon(#"emp"));
}

// Namespace counteruav/counteruav
// Params 2, eflags: 0x0
// Checksum 0x2cee8d45, Offset: 0x1e18
// Size: 0x1dc
function destroycounteruav(attacker, weapon) {
    if (self.leaving !== 1) {
        self killstreaks::play_destroyed_dialog_on_owner("counteruav", self.killstreak_id);
    }
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
        attacker battlechatter::function_b5530e2c("counteruav", weapon);
        challenges::destroyedaircraft(attacker, weapon, 0);
        self killstreaks::function_8acf563(attacker, weapon, self.owner);
        luinotifyevent(#"player_callout", 2, #"hash_3544b7c59fa5c59c", attacker.entnum);
        attacker challenges::addflyswatterstat(weapon, self);
    }
    self playsound(#"evt_helicopter_midair_exp");
    self removeactivecounteruav();
    if (target_istarget(self)) {
        target_remove(self);
    }
    self thread deletecounteruav();
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xd0ec81eb, Offset: 0x2000
// Size: 0xbc
function deletecounteruav() {
    self notify(#"crashing");
    params = level.killstreakbundle[#"counteruav"];
    if (isdefined(params.ksexplosionfx)) {
        self thread playfx(params.ksexplosionfx);
    }
    wait 0.1;
    self setmodel(#"tag_origin");
    wait 0.2;
    self notify(#"delete");
    self delete();
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x59588d95, Offset: 0x20c8
// Size: 0x14a
function enemycounteruavactive() {
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            if (team == self.team) {
                continue;
            }
            if (teamhasactivecounteruav(team)) {
                return true;
            }
        }
    } else {
        enemies = self teams::getenemyplayers();
        foreach (player in enemies) {
            if (player hasactivecounteruav()) {
                return true;
            }
        }
    }
    return false;
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x2995e311, Offset: 0x2220
// Size: 0x18
function hasactivecounteruav() {
    return level.activecounteruavs[self.entnum] > 0;
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x0
// Checksum 0x2f57c127, Offset: 0x2240
// Size: 0x20
function teamhasactivecounteruav(team) {
    return level.activecounteruavs[team] > 0;
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x0
// Checksum 0xe7a50d0f, Offset: 0x2268
// Size: 0x20
function hasindexactivecounteruav(team_or_entnum) {
    return level.activecounteruavs[team_or_entnum] > 0;
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xdec7cadb, Offset: 0x2290
// Size: 0x1b0
function addactivecounteruav() {
    if (level.teambased) {
        level.activecounteruavs[self.team]++;
        foreach (team, _ in level.teams) {
            if (team == self.team) {
                continue;
            }
            if (killstreaks::hassatellite(team)) {
                self.owner challenges::blockedsatellite();
            }
        }
    } else {
        level.activecounteruavs[self.ownerentnum]++;
        keys = getarraykeys(level.activecounteruavs);
        for (i = 0; i < keys.size; i++) {
            if (keys[i] == self.ownerentnum) {
                continue;
            }
            if (killstreaks::hassatellite(keys[i])) {
                self.owner challenges::blockedsatellite();
                break;
            }
        }
    }
    level.activeplayercounteruavs[self.ownerentnum]++;
    level notify(#"counter_uav_updated");
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x5de82285, Offset: 0x2448
// Size: 0x54
function removeactivecounteruav() {
    cuav = self;
    cuav resetactivecounteruav();
    cuav killstreakrules::killstreakstop("counteruav", self.originalteam, self.killstreak_id);
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xf0f83e55, Offset: 0x24a8
// Size: 0x180
function resetactivecounteruav() {
    if (level.teambased) {
        level.activecounteruavs[self.team]--;
        assert(level.activecounteruavs[self.team] >= 0);
        if (level.activecounteruavs[self.team] < 0) {
            level.activecounteruavs[self.team] = 0;
        }
    } else if (isdefined(self.owner)) {
        assert(isdefined(self.ownerentnum));
        if (!isdefined(self.ownerentnum)) {
            self.ownerentnum = self.owner getentitynumber();
        }
        level.activecounteruavs[self.ownerentnum]--;
        assert(level.activecounteruavs[self.ownerentnum] >= 0);
        if (level.activecounteruavs[self.ownerentnum] < 0) {
            level.activecounteruavs[self.ownerentnum] = 0;
        }
    }
    level.activeplayercounteruavs[self.ownerentnum]--;
    level notify(#"counter_uav_updated");
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xd21337f7, Offset: 0x2630
// Size: 0xe4
function watchcounteruavs() {
    while (true) {
        level waittill(#"counter_uav_updated");
        foreach (player in level.players) {
            if (player enemycounteruavactive()) {
                player clientfield::set_to_player("counteruav", 1);
                continue;
            }
            player clientfield::set_to_player("counteruav", 0);
        }
    }
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0xafa69a45, Offset: 0x2720
// Size: 0x88
function hideallcounteruavstosameteam() {
    foreach (counteruav in level.counter_uav_entities) {
        if (isdefined(counteruav)) {
            counteruav teams::hidetosameteam();
        }
    }
}

