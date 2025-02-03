#using script_1cc417743d7c262d;
#using script_44b0b8420eabacad;
#using script_7dc3a36c222eaf22;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory_util;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_aaddef5a;

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 0, eflags: 0x0
// Checksum 0xfd2e50d0, Offset: 0x150
// Size: 0x1e4
function function_98ebe1b4() {
    callback::on_player_killed(&function_7d709aa4);
    level.var_8c3475b7 = [];
    level.var_8c3475b7[level.var_8c3475b7.size] = {#forwardoffset:300, #rightoffset:100};
    level.var_8c3475b7[level.var_8c3475b7.size] = {#forwardoffset:300, #rightoffset:-100};
    level.var_8c3475b7[level.var_8c3475b7.size] = {#forwardoffset:150, #rightoffset:300};
    level.var_8c3475b7[level.var_8c3475b7.size] = {#forwardoffset:150, #rightoffset:-300};
    level.var_8c3475b7[level.var_8c3475b7.size] = {#forwardoffset:0, #rightoffset:500};
    level.var_8c3475b7[level.var_8c3475b7.size] = {#forwardoffset:0, #rightoffset:-500};
    if (!isdefined(level.var_b113cd65)) {
        level.var_b113cd65 = 1;
    }
    level thread function_1e077098();
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 1, eflags: 0x0
// Checksum 0x9747bb37, Offset: 0x340
// Size: 0xc
function function_7d709aa4(*params) {
    
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 0, eflags: 0x0
// Checksum 0x74c92eb7, Offset: 0x358
// Size: 0x62
function function_855ba783() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self waittill(#"spawned");
    if (self.currentspectatingclient > -1) {
        self.var_26074a5b = self.currentspectatingclient;
    }
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 0, eflags: 0x0
// Checksum 0xc36e748e, Offset: 0x3c8
// Size: 0xbc
function function_c3144b08() {
    self endon(#"disconnect", #"spawned", #"force_spawn");
    level endon(#"game_ended");
    waitresult = self waittill(#"waitingtospawn");
    var_fa9f2461 = waitresult.timeuntilspawn + -0.5;
    if (var_fa9f2461 > 0) {
        wait var_fa9f2461;
    }
    self luinotifyevent(#"hash_175f8739ed7a932", 0);
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 0, eflags: 0x0
// Checksum 0xcdc91bb3, Offset: 0x490
// Size: 0x22
function function_403f2d91() {
    return getgametypesetting(#"hash_564289af24e283db");
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 1, eflags: 0x0
// Checksum 0xdefe92b2, Offset: 0x4c0
// Size: 0x438
function function_46fcf917(player) {
    point_team = player.pers[#"team"];
    influencer_team = player.pers[#"team"];
    vis_team_mask = util::getotherteamsmask(player.pers[#"team"]);
    var_5f9a6e72 = ["start_spawn"];
    if (!isdefined(level.var_5e74f048)) {
        level.var_5e74f048 = [];
    }
    if (!isdefined(level.var_5e74f048[player.squad])) {
        level.var_5e74f048[player.squad] = spawnstruct();
    }
    if (!isdefined(level.var_5e74f048[player.squad].lasttime)) {
        level.var_5e74f048[player.squad].lasttime = 0;
    }
    if (!isdefined(level.var_5e74f048[player.squad].nextindex)) {
        level.var_5e74f048[player.squad].nextindex = 0;
    }
    if (level.var_5e74f048[player.squad].lasttime + 6000 < gettime()) {
        var_ffdfd3c9 = util::get_start_time();
        level.var_5e74f048[player.squad].anchorpoint = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, 0, var_5f9a6e72);
        util::note_elapsed_time(var_ffdfd3c9, "spawn point");
        level.var_5e74f048[player.squad].lasttime = gettime();
        level.var_5e74f048[player.squad].nextindex = 0;
    }
    var_5a752f59 = level.var_5e74f048[player.squad].anchorpoint;
    assert(isdefined(var_5a752f59));
    if (!isdefined(var_5a752f59)) {
        return {#origin:level.mapcenter, #angles:(0, 0, 0)};
    }
    var_7c3ed3b8 = spawnstruct();
    rightdir = anglestoright(var_5a752f59[#"angles"]);
    forwarddir = anglestoforward(var_5a752f59[#"angles"]);
    var_7c3ed3b8.angles = var_5a752f59[#"angles"];
    assert(level.var_5e74f048[player.squad].nextindex < level.var_8c3475b7.size);
    nextindex = level.var_5e74f048[player.squad].nextindex;
    var_8c3475b7 = level.var_8c3475b7[nextindex];
    var_7c3ed3b8.origin = var_5a752f59[#"origin"] + forwarddir * var_8c3475b7.forwardoffset;
    var_7c3ed3b8.origin += rightdir * var_8c3475b7.rightoffset;
    level.var_5e74f048[player.squad].nextindex++;
    return var_7c3ed3b8;
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 1, eflags: 0x0
// Checksum 0x5d058c9, Offset: 0x900
// Size: 0x1ac
function function_96d350e9(spawn) {
    if (!isdefined(level.inprematchperiod) || level.inprematchperiod) {
        return;
    }
    origin = spawn.origin;
    angles = spawn.angles;
    if (is_true(self.var_20250438)) {
        spawn = function_46fcf917(self);
    } else if (level.var_b113cd65) {
        var_613ca383 = function_70f1d702();
        if (isdefined(var_613ca383)) {
            origin = var_613ca383.origin;
            forward = anglestoforward(level.mapcenter - var_613ca383.origin);
            angles = vectortoangles(forward);
        }
    }
    zoffset = getdvarint(#"hash_1e5142ed6dd5c6a0", randomintrange(10000, 10100));
    origin += (0, 0, zoffset);
    self thread function_2613549d(origin, angles);
    self luinotifyevent(#"hash_516ebb180cde442", 0);
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 0, eflags: 0x0
// Checksum 0x1d52beda, Offset: 0xab8
// Size: 0x1aa
function function_70f1d702() {
    if (isdefined(self.var_26074a5b)) {
        player = getentbynum(self.var_26074a5b);
        if (isalive(player) && player.team == self.team) {
            return player;
        }
    }
    players = function_a1cff525(self.squad);
    validplayers = [];
    time = gettime();
    foreach (player in players) {
        if (player function_9a0edd92() || player isinfreefall()) {
            continue;
        } else if (!is_true(player.laststand)) {
            continue;
        }
        if (player.lastspawntime < time) {
            validplayers[validplayers.size] = player;
        }
    }
    if (validplayers.size > 0) {
        return validplayers[randomint(validplayers.size)];
    }
    return undefined;
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 2, eflags: 0x0
// Checksum 0x2f8865a9, Offset: 0xc70
// Size: 0x18c
function function_b74c009d(groundpoint, angles) {
    players = function_c65231e2(self.squad);
    if (players.size <= 0) {
        return;
    }
    for (squadindex = 0; squadindex < players.size; squadindex++) {
        if (self == players[squadindex]) {
            break;
        }
    }
    slice = 360 / players.size;
    angle = squadindex * slice;
    r = randomintrange(150, 200);
    xoffset = r * cos(angle);
    yoffset = r * sin(angle);
    zoffset = getdvarint(#"hash_1e5142ed6dd5c6a0", randomintrange(10000, 10100));
    origin = groundpoint + (xoffset, yoffset, zoffset);
    self thread function_2613549d(origin, angles);
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 2, eflags: 0x0
// Checksum 0x761107df, Offset: 0xe08
// Size: 0x28c
function function_2613549d(origin, angles) {
    level endon(#"game_ended");
    self endon(#"disconnect", #"end_respawn");
    vehicle = self.var_b88236d6;
    self.var_b88236d6 = undefined;
    launchvelocity = (0, 0, 0);
    if (isdefined(vehicle)) {
        vehicle.origin = origin;
        vehicle.angles = angles;
        self ghost();
        self notsolid();
        self dontinterpolate();
        self setclientthirdperson(1);
        self function_648c1f6(vehicle, undefined, 0, 180, 180, 180, 180, 0);
        self setplayerangles(angles);
        wait 0;
        self setclientthirdperson(0);
        self startcameratween(0);
        self show();
        self solid();
        self unlink();
        launchvelocity = anglestoforward(self getplayerangles());
        vehicle deletedelay();
    } else {
        waitframe(1);
    }
    self setorigin(origin);
    self setplayerangles((85, angles[1], 0));
    self player_insertion::start_freefall(launchvelocity, 1);
    self function_c147c6c5();
    level thread function_5d5011dc(self);
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 1, eflags: 0x0
// Checksum 0xef9da401, Offset: 0x10a0
// Size: 0x58
function function_5d5011dc(var_b1cf3b20) {
    wait 1;
    if (!isdefined(var_b1cf3b20)) {
        return;
    }
    level.var_a349ea8[var_b1cf3b20 getentitynumber()] = undefined;
    level.var_c1413cbd[level.var_c1413cbd.size] = var_b1cf3b20;
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 0, eflags: 0x0
// Checksum 0x87194e98, Offset: 0x1100
// Size: 0x4fe
function function_1e077098() {
    level endon(#"game_ended");
    level.var_c1413cbd = [];
    var_e11beb90 = sqr(500);
    level.var_a349ea8 = [];
    while (true) {
        var_dbcced97 = [];
        var_c1413cbd = level.var_c1413cbd;
        level.var_c1413cbd = [];
        var_24c3509f = 0;
        foreach (var_ab9478c7 in var_c1413cbd) {
            if (var_24c3509f >= 2) {
                var_24c3509f = 0;
                waitframe(1);
            }
            var_24c3509f++;
            if (!isdefined(var_ab9478c7)) {
                continue;
            }
            if (var_ab9478c7 isonground()) {
                level.var_a349ea8[var_ab9478c7 getentitynumber()] = undefined;
                continue;
            }
            trace = groundtrace(var_ab9478c7.origin, var_ab9478c7.origin - (0, 0, 5000), 0, var_ab9478c7, 0, 0);
            if (trace[#"surfacetype"] == #"none") {
                var_dbcced97[var_dbcced97.size] = var_ab9478c7;
                continue;
            }
            if (distancesquared(var_ab9478c7.origin, trace[#"position"]) < var_e11beb90) {
                level.var_a349ea8[var_ab9478c7 getentitynumber()] = undefined;
                continue;
            }
            var_7ec01616 = getplayers(undefined, trace[#"position"], 3000);
            var_c3d4dc49 = isdefined(level.var_a349ea8[var_ab9478c7 getentitynumber()]) ? level.var_a349ea8[var_ab9478c7 getentitynumber()] : [];
            foreach (var_ba607277 in var_7ec01616) {
                if (var_ba607277 == var_ab9478c7) {
                    continue;
                }
                if (!isalive(var_ba607277)) {
                    continue;
                }
                if (isdefined(var_c3d4dc49[var_ba607277 getentitynumber()])) {
                    continue;
                }
                if (var_ba607277.team != var_ab9478c7.team) {
                    if (isdefined(var_ba607277.var_7adbb832) && var_ba607277.var_7adbb832 > gettime()) {
                        continue;
                    }
                    var_ba607277 globallogic_audio::play_taacom_dialog("airSpawnEnemyDropping", undefined, undefined, undefined, undefined, undefined, 1);
                    var_ba607277.var_7adbb832 = gettime() + int(5 * 1000);
                } else {
                    if (isdefined(var_ba607277.var_291cbaa3) && var_ba607277.var_291cbaa3 > gettime()) {
                        continue;
                    }
                    var_ba607277 globallogic_audio::play_taacom_dialog("airSpawnFriendlyDropping", undefined, undefined, undefined, undefined, undefined, 1);
                    var_ba607277.var_291cbaa3 = gettime() + int(5 * 1000);
                }
                var_c3d4dc49[var_ba607277 getentitynumber()] = 1;
            }
            level.var_a349ea8[var_ab9478c7 getentitynumber()] = var_c3d4dc49;
            var_dbcced97[var_dbcced97.size] = var_ab9478c7;
        }
        level.var_c1413cbd = arraycombine(var_dbcced97, level.var_c1413cbd, 0, 0);
        waitframe(1);
    }
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 0, eflags: 0x0
// Checksum 0xfe5c7218, Offset: 0x1608
// Size: 0x34
function function_c147c6c5() {
    if (isdefined(level.var_a1c77c9c)) {
        [[ level.var_a1c77c9c ]](self.team, self.curclass);
    }
}

