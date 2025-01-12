#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_spawn;

#namespace userspawnselection;

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x2
// Checksum 0x27853ac6, Offset: 0x190
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"userspawnselection", &__init__, undefined, undefined);
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x5a329fac, Offset: 0x1d8
// Size: 0x1cc
function __init__() {
    if (!isdefined(level.spawnselect)) {
        level.spawnselect = spawnstruct();
    }
    level.spawnselect.var_ac099dd5 = [];
    level.spawnselect.lastchosenplayerspawns = [];
    level.spawnselectenabled = getgametypesetting(#"spawnselectenabled");
    level.usespawngroups = getgametypesetting(#"usespawngroups");
    level.spawngroups = [];
    level.next_spawn_group_index = 0;
    level.var_a55ab915 = &function_24bb4ec5;
    level.spawnselect_timelimit_ms = getdvarint(#"spawnselect_timelimit_ms", 10000);
    if (isspawnselectenabled()) {
        callback::on_start_gametype(&on_start_gametype);
        callback::on_disconnect(&on_player_disconnect);
        callback::on_spawned(&onplayerspawned);
        spawning::function_5b468440(&function_edcb9c60);
        level.var_a36df600 = &filter_spawnpoints;
    }
    registerclientfields();
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0x5dfa0fec, Offset: 0x3b0
// Size: 0x94
function function_8325b78c(player) {
    foreach (spawnbeacon in level.spawnselect.var_ac099dd5) {
        if (player == spawnbeacon.owner) {
            return true;
        }
    }
    return false;
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x7600094f, Offset: 0x450
// Size: 0x42
function function_8a2637() {
    if (!isdefined(level.spawnselect)) {
        level.spawnselect = spawnstruct();
    }
    level.spawnselect.var_5723beb4 = 1;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0x8f510d9, Offset: 0x4a0
// Size: 0x3e
function function_24bb4ec5(player) {
    spawnbeacon = player function_cfd342bb();
    if (isdefined(spawnbeacon)) {
        return true;
    }
    return false;
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0xdc4593ab, Offset: 0x4e8
// Size: 0x7c
function onplayerspawned() {
    if (!isdefined(level.spawnselect.lastchosenplayerspawns[self.clientid])) {
        return;
    }
    if (level.spawnselect.lastchosenplayerspawns[self.clientid] == -2) {
        level.spawnselect.lastchosenplayerspawns[self.clientid] = -1;
    }
    closespawnselect();
}

// Namespace userspawnselection/userspawnselection
// Params 2, eflags: 0x0
// Checksum 0x4ac470d0, Offset: 0x570
// Size: 0x62
function registeravailablespawnbeacon(spawnbeaconid, spawnbeacon) {
    assert(!isdefined(level.spawnselect.var_ac099dd5[spawnbeaconid]));
    level.spawnselect.var_ac099dd5[spawnbeaconid] = spawnbeacon;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0x6a2705e5, Offset: 0x5e0
// Size: 0x9c
function removespawnbeacon(spawnbeaconid) {
    if (!isdefined(level.spawnselect.var_ac099dd5[spawnbeaconid])) {
        return;
    }
    spawnbeacon = level.spawnselect.var_ac099dd5[spawnbeaconid];
    if (isdefined(spawnbeacon) && isdefined(spawnbeacon.spawnlist)) {
        clearspawnpoints(spawnbeacon.spawnlist);
    }
    level.spawnselect.var_ac099dd5[spawnbeaconid] = undefined;
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0xfbd77c22, Offset: 0x688
// Size: 0xe
function isspawnselectenabled() {
    return level.spawnselectenabled;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0xe496b189, Offset: 0x6a0
// Size: 0x1c
function getspawngroup(index) {
    return level.spawngroups[index];
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0x8fe17a29, Offset: 0x6c8
// Size: 0xac
function getspawngroupbyname(target) {
    retunrarr = [];
    foreach (spawngroup in level.spawngroups) {
        if (spawngroup.target == target) {
            array::add(retunrarr, spawngroup);
        }
    }
    return retunrarr;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0xf86b9deb, Offset: 0x780
// Size: 0xac
function getspawngroupsforzone(zoneindex) {
    returnarray = [];
    foreach (spawngroup in level.spawngroups) {
        if (spawngroup.script_zoneindex == zoneindex) {
            array::add(returnarray, spawngroup);
        }
    }
    return returnarray;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0xaa6cb713, Offset: 0x838
// Size: 0xbc
function getspawngroupwithscriptnoteworthy(script_noteworthy) {
    returnarray = [];
    foreach (spawngroup in level.spawngroups) {
        if (isdefined(spawngroup.script_noteworthy) && spawngroup.script_noteworthy == script_noteworthy) {
            array::add(returnarray, spawngroup);
        }
    }
    return returnarray;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0xf6c88c92, Offset: 0x900
// Size: 0x64
function changeusability(isusable) {
    usestatusmodel = getclientfieldprefix(self.uiindex) + "useStatus";
    self.ison = isusable;
    level clientfield::set_world_uimodel(usestatusmodel, isusable);
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0xc05ca08c, Offset: 0x970
// Size: 0x54
function changevisibility(isvisible) {
    visstatusmodel = getclientfieldprefix(self.uiindex) + "visStatus";
    level clientfield::set_world_uimodel(visstatusmodel, isvisible);
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0xc9384002, Offset: 0x9d0
// Size: 0xa4
function changeteam(teamname) {
    teamclientfieldindex = getteamclientfieldvalue(teamname);
    teammodel = getclientfieldprefix(self.uiindex) + "team";
    level clientfield::set_world_uimodel(teammodel, teamclientfieldindex);
    enablespawnpointlist(self.spawnlist, util::getteammask(teamname));
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0xfd711e40, Offset: 0xa80
// Size: 0xa8
function setspawngroupsenabled() {
    if (!isdefined(level.spawngroups)) {
        return;
    }
    foreach (spawngroup in level.spawngroups) {
        spawngroup changeusability(1);
        spawngroup changevisibility(1);
    }
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0xf161988f, Offset: 0xb30
// Size: 0x10
function canplayerusespawngroup(spawngroupindex) {
    return true;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0xad132ef8, Offset: 0xb48
// Size: 0x2a
function setspawngroupforplayer(selectedspawngroupindex) {
    level.spawnselect.lastchosenplayerspawns[self.clientid] = selectedspawngroupindex;
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0xdc13fab8, Offset: 0xb80
// Size: 0x108
function function_cfd342bb() {
    player = self;
    if (!isdefined(level.spawnselect.lastchosenplayerspawns[player.clientid])) {
        return undefined;
    }
    spawbeaconid = level.spawnselect.lastchosenplayerspawns[player.clientid];
    if (spawbeaconid == -1 || spawbeaconid == -2) {
        return undefined;
    }
    if (!isdefined(level.spawnselect.var_ac099dd5[spawbeaconid])) {
        return undefined;
    }
    if (isdefined(level.spawnselect.var_ac099dd5[spawbeaconid].var_4bc668ab) && level.spawnselect.var_ac099dd5[spawbeaconid].var_4bc668ab) {
        return undefined;
    }
    return level.spawnselect.var_ac099dd5[spawbeaconid];
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x96bb9369, Offset: 0xc90
// Size: 0xb0
function fillspawnlists() {
    foreach (spawngroup in level.spawngroups) {
        spawngroup setupspawnlistforspawngroup(spawngroup.target, spawngroup.spawnlist, util::get_team_mapping(spawngroup.script_team));
    }
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x61a3c114, Offset: 0xd48
// Size: 0x70
function clearcacheforplayer() {
    if (!isdefined(self) || !isdefined(self.clientid)) {
        return;
    }
    if (isdefined(level.spawnselect.lastchosenplayerspawns) && isdefined(level.spawnselect.lastchosenplayerspawns[self.clientid])) {
        level.spawnselect.lastchosenplayerspawns[self.clientid] = undefined;
    }
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x8ad8ec85, Offset: 0xdc0
// Size: 0x16
function clearcacheforallplayers() {
    level.spawnselect.lastchosenplayerspawns = [];
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x3cc205d3, Offset: 0xde0
// Size: 0x9c
function getlastchosenspawngroupforplayer() {
    if (!isdefined(level.spawnselect.lastchosenplayerspawns[self.clientid])) {
        return undefined;
    }
    if (level.spawnselect.lastchosenplayerspawns[self.clientid] == -2) {
        return undefined;
    }
    lastchosenid = level.spawnselect.lastchosenplayerspawns[self.clientid];
    if (!isdefined(level.spawngroups[lastchosenid])) {
        return undefined;
    }
    return level.spawngroups[lastchosenid];
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x31523d1b, Offset: 0xe88
// Size: 0x34
function onroundchange() {
    clearcacheforallplayers();
    supressspawnselectionmenuforallplayers();
    closespawnselectionmenuforallplayers();
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0xf6c41e56, Offset: 0xec8
// Size: 0x36
function function_ef69b35a() {
    player = self;
    level.spawnselect.lastchosenplayerspawns[player.clientid] = -2;
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x3ea70654, Offset: 0xf08
// Size: 0x12
function supressspawnselectionmenuforallplayers() {
    level.showspawnselectionmenu = [];
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0xdaf42fad, Offset: 0xf28
// Size: 0x164
function shouldshowspawnselectionmenu() {
    isbot = isbot(self);
    var_35e607cd = (isdefined(level.spawnselect.lastchosenplayerspawns[self.clientid]) ? level.spawnselect.lastchosenplayerspawns[self.clientid] : -1) == -2;
    gameended = gamestate::is_game_over();
    nolives = level.numteamlives > 0 && game.lives[self.team] < 0;
    var_5723beb4 = (isdefined(level.spawnselect.var_5723beb4) ? level.spawnselect.var_5723beb4 : 0) && function_8325b78c(self);
    return !isbot && !var_35e607cd && !level.infinalkillcam && !gameended && !nolives || var_5723beb4;
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0xdf2877ee, Offset: 0x1098
// Size: 0x1e
function activatespawnselectionmenu() {
    level.showspawnselectionmenu[self.clientid] = 1;
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0xb67c98a8, Offset: 0x10c0
// Size: 0x6c
function openspawnselect() {
    if (isdefined(level.var_3e9a2fce) && level.var_3e9a2fce) {
        while (isdefined(level.var_3e9a2fce) && level.var_3e9a2fce) {
            waitframe(1);
        }
    }
    self clientfield::set_player_uimodel("hudItems.showSpawnSelect", 1);
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x3632fbb0, Offset: 0x1138
// Size: 0x38
function closespawnselect() {
    self clientfield::set_player_uimodel("hudItems.showSpawnSelect", 0);
    level notify(#"hash_48b4c5f856407d62");
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x89c6e812, Offset: 0x1178
// Size: 0x28
function function_279204ca() {
    return self clientfield::get_player_uimodel("hudItems.showSpawnSelect") == 1;
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x759f1844, Offset: 0x11a8
// Size: 0x90
function closespawnselectionmenuforallplayers() {
    players = getplayers();
    foreach (player in players) {
        player closespawnselect();
    }
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x2f02fd8d, Offset: 0x1240
// Size: 0x54
function function_35d0f353() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    self openspawnselect();
    self thread watchforselectiontimeout();
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x8a30c22c, Offset: 0x12a0
// Size: 0x164
function waitforspawnselection() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    while (true) {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        var_a1548ff0 = 0;
        if (isdefined(level.var_383c29a5)) {
            var_a1548ff0 = [[ level.var_383c29a5 ]](waitresult);
        }
        if (menu == "SpawnSelect" && !var_a1548ff0) {
            if (isplayer(self)) {
                self setspawngroupforplayer(waitresult.intpayload);
                if (!level.infinalkillcam) {
                    self killcam::function_2beac224();
                }
                self closespawnselect();
                self.var_a65a4ffc = 0;
            }
            return;
        }
        waitframe(1);
    }
    self closespawnselect();
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x9ce71658, Offset: 0x1410
// Size: 0x84
function watchforselectiontimeout() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    self.spawnselect_start_time = gettime();
    while (true) {
        if (level.spawnselect_timelimit_ms - gettime() - self.spawnselect_start_time <= 0) {
            self luinotifyevent(#"force_spawn_selection");
            return;
        }
        wait 0.1;
    }
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x4
// Checksum 0xd2d8062, Offset: 0x14a0
// Size: 0x1c
function private on_player_disconnect() {
    self clearcacheforplayer();
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0xe69a4a1e, Offset: 0x14c8
// Size: 0x206
function filter_spawnpoints(spawnpoints) {
    e_player = self;
    if (!isdefined(level.spawnselect.lastchosenplayerspawns[e_player.clientid])) {
        return undefined;
    }
    spawbeaconid = level.spawnselect.lastchosenplayerspawns[e_player.clientid];
    if (spawbeaconid == -1) {
        return undefined;
    }
    if (spawbeaconid == -2) {
        return undefined;
    }
    if (!isdefined(level.spawnselect.var_ac099dd5[spawbeaconid])) {
        /#
            print("<dev string:x30>");
        #/
        level.spawnselect.lastchosenplayerspawns[e_player.clientid] = -1;
        return undefined;
    }
    assert(e_player getteam() == level.spawnselect.var_ac099dd5[spawbeaconid].team);
    if (e_player getteam() != level.spawnselect.var_ac099dd5[spawbeaconid].team) {
        return undefined;
    }
    assert(isdefined(level.spawnselect.var_ac099dd5[spawbeaconid].spawns) && level.spawnselect.var_ac099dd5[spawbeaconid].spawns.size > 0);
    e_player.var_b05340ee = 1;
    return level.spawnselect.var_ac099dd5[spawbeaconid].spawns;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x4
// Checksum 0x4c2a85de, Offset: 0x16d8
// Size: 0x5a2
function private function_edcb9c60(e_player) {
    if (!isdefined(level.spawnselect.lastchosenplayerspawns[e_player.clientid]) || level.usestartspawns) {
        return undefined;
    }
    spawbeaconid = level.spawnselect.lastchosenplayerspawns[e_player.clientid];
    if (spawbeaconid == -1) {
        return undefined;
    }
    if (spawbeaconid == -2) {
        return undefined;
    }
    if (!isdefined(level.spawnselect.var_ac099dd5[spawbeaconid])) {
        /#
            print("<dev string:x30>");
        #/
        level.spawnselect.lastchosenplayerspawns[e_player.clientid] = -1;
        return undefined;
    }
    if (e_player getteam() != level.spawnselect.var_ac099dd5[spawbeaconid].team) {
        /#
            println("<dev string:x8d>");
            println("<dev string:xd4>" + spawbeaconid + "<dev string:xf1>");
            println("<dev string:xf3>" + e_player.team + "<dev string:xf1>");
            for (index = 0; index < level.spawnselect.var_ac099dd5.size; index++) {
                if (!isdefined(level.spawnselect.var_ac099dd5[spawbeaconid])) {
                    continue;
                }
                println("<dev string:x104>" + index + "<dev string:xf1>");
                println("<dev string:x110>" + level.spawnselect.var_ac099dd5[spawbeaconid].objectiveid + "<dev string:xf1>");
                println("<dev string:x11f>" + level.spawnselect.var_ac099dd5[spawbeaconid].team + "<dev string:xf1>");
                if (isdefined(level.spawnselect.var_ac099dd5[spawbeaconid].owner.playername)) {
                    println("<dev string:x126>" + level.spawnselect.var_ac099dd5[spawbeaconid].owner.playername + "<dev string:xf1>");
                }
                println("<dev string:x135>");
            }
            println("<dev string:x149>" + level.numgametypereservedobjectives + "<dev string:xf1>");
            println("<dev string:x160>" + level.releasedobjectives.size + "<dev string:xf1>");
            println("<dev string:x17b>");
            foreach (objid in level.releasedobjectives) {
                println(objid + "<dev string:xf1>");
            }
            println("<dev string:x195>");
            foreach (objid in level.spawnbeaconsettings.var_18176b84) {
                println(objid + "<dev string:xf1>");
            }
            println("<dev string:x1b2>");
        #/
        assert(e_player.team == level.spawnselect.var_ac099dd5[spawbeaconid].team);
        return undefined;
    }
    assert(isdefined(level.spawnselect.var_ac099dd5[spawbeaconid].spawns) && level.spawnselect.var_ac099dd5[spawbeaconid].spawns.size > 0);
    return level.spawnselect.var_ac099dd5[spawbeaconid].spawnlist;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x4
// Checksum 0xd080b068, Offset: 0x1c88
// Size: 0x20
function private getclientfieldprefix(id) {
    return "spawngroupStatus." + id + ".";
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x4
// Checksum 0x94a61b0f, Offset: 0x1cb0
// Size: 0x17c
function private registerclientfields() {
    for (index = 0; index < 20; index++) {
        basename = getclientfieldprefix(index);
        clientfield::register("worlduimodel", basename + "visStatus", 1, 1, "int");
        clientfield::register("worlduimodel", basename + "useStatus", 1, 1, "int");
        clientfield::register("worlduimodel", basename + "team", 1, 2, "int");
    }
    clientfield::register("clientuimodel", "hudItems.showSpawnSelect", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.killcamActive", 1, 1, "int");
    clientfield::register("worlduimodel", "hideautospawnoption", 1, 1, "int");
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0x3a64674c, Offset: 0x1e38
// Size: 0x2c
function waitandenablespawngroups() {
    util::wait_network_frame(1);
    setspawngroupsenabled();
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0x965f2c59, Offset: 0x1e70
// Size: 0x2c
function function_8ee72ea0(shoulddisable) {
    level clientfield::set_world_uimodel("hideautospawnoption", shoulddisable);
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x0
// Checksum 0xdea2b1d, Offset: 0x1ea8
// Size: 0x12e
function on_start_gametype() {
    spawngroups = getentarray("spawn_group_marker", "classname");
    if (!isdefined(spawngroups) || spawngroups.size == 0) {
        return;
    }
    if (level.usespawngroups) {
        spawngroupssorted = arraysort(spawngroups, (0, 0, 0), 1);
        foreach (spawngroup in spawngroupssorted) {
            if (!globallogic_spawn::function_686dd8da(spawngroup)) {
                continue;
            }
            setupspawngroup(spawngroup);
        }
    }
    waitandenablespawngroups();
    if (isspawnselectenabled()) {
    }
}

// Namespace userspawnselection/userspawnselection
// Params 3, eflags: 0x4
// Checksum 0xcacffa7b, Offset: 0x1fe0
// Size: 0x200
function private setupspawnlistforspawngroup(spawngroupkey, spawnlistname, team) {
    rawspawns = struct::get_array(spawngroupkey, "groupname");
    if (!isdefined(rawspawns)) {
        return;
    }
    self.spawns = [];
    var_b7340f98 = 0;
    var_dd368a01 = 0;
    var_339046a = 0;
    var_e75409f9 = 0;
    foreach (spawn in rawspawns) {
        if (!globallogic_spawn::function_686dd8da(spawn)) {
            continue;
        }
        if (!isdefined(spawn.enabled)) {
            spawn.enabled = -1;
        }
        array::add(self.spawns, spawn);
        var_b7340f98 += spawn.origin[0];
        var_dd368a01 += spawn.origin[1];
        var_339046a += spawn.origin[2];
        var_e75409f9++;
    }
    var_f1f02379 = undefined;
    if (var_e75409f9 > 0) {
        var_f1f02379 = (var_b7340f98 / var_e75409f9, var_dd368a01 / var_e75409f9, var_339046a / var_e75409f9);
    }
    addspawnpoints(team, self.spawns, spawnlistname);
    return var_f1f02379;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x4
// Checksum 0x71c4db60, Offset: 0x21e8
// Size: 0x176
function private setupspawngroup(spawngroup) {
    spawngroup.objectiveid = gameobjects::get_next_obj_id();
    if (level.teambased && isdefined(game.switchedsides) && game.switchedsides) {
        spawngroup.team = util::getotherteam(spawngroup.script_team);
    } else {
        spawngroup.team = spawngroup.script_team;
    }
    var_f1f02379 = spawngroup setupspawnlistforspawngroup(spawngroup.target, spawngroup.spawnlist, spawngroup.team);
    objectivename = spawngroup.script_objective;
    objective_add(spawngroup.objectiveid, "active", var_f1f02379, objectivename);
    objective_setteam(spawngroup.objectiveid, spawngroup.team);
    level.spawnselect.var_ac099dd5[spawngroup.objectiveid] = spawngroup;
    spawngroup.var_4bc668ab = 1;
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x0
// Checksum 0x278417bf, Offset: 0x2368
// Size: 0x98
function getteamclientfieldvalue(team) {
    if (!isdefined(team)) {
        return 0;
    }
    teamname = util::get_team_mapping(team);
    if (team == #"allies") {
        return 1;
    } else if (team == #"axis") {
        return 2;
    } else if (team == #"neutral") {
        return 3;
    }
    return 0;
}

