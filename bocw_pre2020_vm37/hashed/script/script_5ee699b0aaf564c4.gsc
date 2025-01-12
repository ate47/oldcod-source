#using script_44b0b8420eabacad;
#using script_75da5547b1822294;
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
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_aaddef5a;

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 0, eflags: 0x1 linked
// Checksum 0x82408515, Offset: 0x110
// Size: 0x1bc
function function_98ebe1b4() {
    callback::on_player_killed(&function_7d709aa4);
    level.var_8c3475b7 = [];
    level.var_8c3475b7[level.var_8c3475b7.size] = {#forwardoffset:150, #rightoffset:50};
    level.var_8c3475b7[level.var_8c3475b7.size] = {#forwardoffset:150, #rightoffset:-50};
    level.var_8c3475b7[level.var_8c3475b7.size] = {#forwardoffset:75, #rightoffset:150};
    level.var_8c3475b7[level.var_8c3475b7.size] = {#forwardoffset:75, #rightoffset:-150};
    level.var_8c3475b7[level.var_8c3475b7.size] = {#forwardoffset:0, #rightoffset:300};
    level.var_8c3475b7[level.var_8c3475b7.size] = {#forwardoffset:0, #rightoffset:-300};
    level.var_ba92f34 = 150;
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 1, eflags: 0x1 linked
// Checksum 0x23c0a080, Offset: 0x2d8
// Size: 0xc
function function_7d709aa4(*params) {
    
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 0, eflags: 0x0
// Checksum 0x45990191, Offset: 0x2f0
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
// Checksum 0x2320cba6, Offset: 0x360
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
// Checksum 0xba47988c, Offset: 0x428
// Size: 0x22
function function_403f2d91() {
    return getgametypesetting(#"hash_564289af24e283db");
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 0, eflags: 0x0
// Checksum 0x40a2052d, Offset: 0x458
// Size: 0xd6
function function_9fac57fa() {
    player = self function_70f1d702();
    var_7c3ed3b8 = spawnstruct();
    if (!isdefined(player)) {
        return;
    }
    var_7c3ed3b8.origin = player.origin;
    var_7c3ed3b8.forward = anglestoforward(player.angles);
    if (!isdefined(var_7c3ed3b8.origin) && !isdefined(var_7c3ed3b8.forward)) {
        var_7c3ed3b8.origin = self.origin;
        var_7c3ed3b8.forward = anglestoforward(self.angles);
    }
    return var_7c3ed3b8;
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 1, eflags: 0x1 linked
// Checksum 0x242b8a9f, Offset: 0x538
// Size: 0x450
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
    rightoffset = level.var_8c3475b7[level.var_5e74f048[player.squad].nextindex].rightoffset;
    forwardoffset = level.var_8c3475b7[level.var_5e74f048[player.squad].nextindex].forwardoffset;
    var_7c3ed3b8.origin = var_5a752f59[#"origin"] + forwarddir * forwardoffset;
    var_7c3ed3b8.origin += rightdir * rightoffset;
    level.var_5e74f048[player.squad].nextindex++;
    return var_7c3ed3b8;
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 1, eflags: 0x1 linked
// Checksum 0x793dd7a, Offset: 0x990
// Size: 0x10c
function function_96d350e9(spawn) {
    if (!isdefined(level.inprematchperiod) || level.inprematchperiod) {
        return;
    }
    if (is_true(self.var_20250438)) {
        spawn = function_46fcf917(self);
    }
    zoffset = getdvarint(#"hash_1e5142ed6dd5c6a0", randomintrange(10000, 10100));
    origin = spawn.origin + (0, 0, zoffset);
    self thread function_2613549d(origin, spawn.angles);
    self luinotifyevent(#"hash_175f8739ed7a932", 0);
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 0, eflags: 0x1 linked
// Checksum 0x1e4c9fa5, Offset: 0xaa8
// Size: 0x152
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
// Checksum 0x9fed8db9, Offset: 0xc08
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
// Params 2, eflags: 0x1 linked
// Checksum 0x32cba510, Offset: 0xda0
// Size: 0x274
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
}

// Namespace namespace_aaddef5a/namespace_f9f7b554
// Params 0, eflags: 0x1 linked
// Checksum 0x30252972, Offset: 0x1020
// Size: 0x34
function function_c147c6c5() {
    if (isdefined(level.var_a1c77c9c)) {
        [[ level.var_a1c77c9c ]](self.team, self.curclass);
    }
}

