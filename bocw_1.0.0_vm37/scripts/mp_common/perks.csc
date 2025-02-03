#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace perks;

// Namespace perks/perks
// Params 0, eflags: 0x6
// Checksum 0x49011a3e, Offset: 0x1e8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"perks", &preinit, undefined, undefined, undefined);
}

// Namespace perks/perks
// Params 0, eflags: 0x4
// Checksum 0x71a01c7c, Offset: 0x230
// Size: 0x3fc
function private preinit() {
    clientfield::register("allplayers", "flying", 1, 1, "int", &flying_callback, 0, 1);
    callback::on_localclient_connect(&on_local_client_connect);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_spawned(&on_player_spawned);
    level.killtrackerfxenable = 1;
    if (true) {
        level._monitor_tracker = &monitor_tracker_perk;
    }
    level.sitrepscan1_enable = getdvarint(#"scr_sitrepscan1_enable", 2);
    level.sitrepscan1_setoutline = getdvarint(#"scr_sitrepscan1_setoutline", 1);
    level.sitrepscan1_setsolid = getdvarint(#"scr_sitrepscan1_setsolid", 1);
    level.sitrepscan1_setlinewidth = getdvarint(#"scr_sitrepscan1_setlinewidth", 1);
    level.sitrepscan1_setradius = getdvarint(#"scr_sitrepscan1_setradius", 50000);
    level.sitrepscan1_setfalloff = getdvarfloat(#"scr_sitrepscan1_setfalloff", 0.01);
    level.sitrepscan1_setdesat = getdvarfloat(#"scr_sitrepscan1_setdesat", 0.4);
    level.sitrepscan2_enable = getdvarint(#"scr_sitrepscan2_enable", 2);
    level.sitrepscan2_setoutline = getdvarint(#"scr_sitrepscan2_setoutline", 10);
    level.sitrepscan2_setsolid = getdvarint(#"scr_sitrepscan2_setsolid", 0);
    level.sitrepscan2_setlinewidth = getdvarint(#"scr_sitrepscan2_setlinewidth", 1);
    level.sitrepscan2_setradius = getdvarint(#"scr_sitrepscan2_setradius", 50000);
    level.sitrepscan2_setfalloff = getdvarfloat(#"scr_sitrepscan2_setfalloff", 0.01);
    level.sitrepscan2_setdesat = getdvarfloat(#"scr_sitrepscan2_setdesat", 0.4);
    callback::on_gameplay_started(&on_gameplay_started);
    level.var_6fc25f5c = getscriptbundle(#"awareness");
    level.var_842a5e1f = getscriptbundle(#"awareness_deadsilence");
    /#
        level thread updatedvars();
    #/
}

// Namespace perks/perks
// Params 0, eflags: 0x0
// Checksum 0x14ccbbe1, Offset: 0x638
// Size: 0x2c
function updatesitrepscan() {
    self endon(#"death");
    while (true) {
        wait 1;
    }
}

/#

    // Namespace perks/perks
    // Params 0, eflags: 0x0
    // Checksum 0x90d3dd80, Offset: 0x670
    // Size: 0x2c0
    function updatedvars() {
        while (true) {
            level.sitrepscan1_enable = getdvarint(#"scr_sitrepscan1_enable", level.sitrepscan1_enable);
            level.sitrepscan1_setoutline = getdvarint(#"scr_sitrepscan1_setoutline", level.sitrepscan1_setoutline);
            level.sitrepscan1_setsolid = getdvarint(#"scr_sitrepscan1_setsolid", level.sitrepscan1_setsolid);
            level.sitrepscan1_setlinewidth = getdvarint(#"scr_sitrepscan1_setlinewidth", level.sitrepscan1_setlinewidth);
            level.sitrepscan1_setradius = getdvarint(#"scr_sitrepscan1_setradius", level.sitrepscan1_setradius);
            level.sitrepscan1_setfalloff = getdvarfloat(#"scr_sitrepscan1_setfalloff", level.sitrepscan1_setfalloff);
            level.sitrepscan1_setdesat = getdvarfloat(#"scr_sitrepscan1_setdesat", level.sitrepscan1_setdesat);
            level.sitrepscan2_enable = getdvarint(#"scr_sitrepscan2_enable", level.sitrepscan2_enable);
            level.sitrepscan2_setoutline = getdvarint(#"scr_sitrepscan2_setoutline", level.sitrepscan2_setoutline);
            level.sitrepscan2_setsolid = getdvarint(#"scr_sitrepscan2_setsolid", level.sitrepscan2_setsolid);
            level.sitrepscan2_setlinewidth = getdvarint(#"scr_sitrepscan2_setlinewidth", level.sitrepscan2_setlinewidth);
            level.sitrepscan2_setradius = getdvarint(#"scr_sitrepscan2_setradius", level.sitrepscan2_setradius);
            level.sitrepscan2_setfalloff = getdvarfloat(#"scr_sitrepscan2_setfalloff", level.sitrepscan2_setfalloff);
            level.sitrepscan2_setdesat = getdvarfloat(#"scr_sitrepscan2_setdesat", level.sitrepscan2_setdesat);
            wait 1;
        }
    }

#/

// Namespace perks/perks
// Params 7, eflags: 0x0
// Checksum 0xc889cd75, Offset: 0x938
// Size: 0x4a
function flying_callback(*local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self.flying = bwastimejump;
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x3b9a2caa, Offset: 0x990
// Size: 0xac
function on_local_client_connect(local_client_num) {
    registerrewindfx(local_client_num, "player/fx9_perk_tracker_footstep_lft");
    registerrewindfx(local_client_num, "player/fx9_perk_tracker_footstep_rgt");
    registerrewindfx(local_client_num, "player/fx_plyr_footstep_tracker_lf");
    registerrewindfx(local_client_num, "player/fx_plyr_footstep_tracker_rf");
    registerrewindfx(local_client_num, "player/fx8_plyr_footstep_tracker_inair");
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x129af3bc, Offset: 0xa48
// Size: 0x26
function on_localplayer_spawned(local_client_num) {
    profilestart();
    self function_92725cf9(local_client_num);
    profilestop();
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x565ac040, Offset: 0xa78
// Size: 0x86
function on_gameplay_started(local_client_num) {
    if (sessionmodeismultiplayergame() && !isdefined(level.var_783d3911)) {
        level.var_783d3911 = getservertime(local_client_num);
    }
    waittillframeend();
    profilestart();
    local_player = function_5c10bd79(local_client_num);
    local_player function_92725cf9(local_client_num);
    profilestop();
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0xb2875278, Offset: 0xb08
// Size: 0x74
function function_92725cf9(local_client_num) {
    if (!self function_21c0fa55()) {
        return;
    }
    self thread function_e3426b1f(local_client_num);
    if (true) {
        self thread monitor_tracker_perk_killcam(local_client_num);
        self thread monitor_tracker_existing_players(local_client_num);
    }
}

// Namespace perks/perks
// Params 3, eflags: 0x0
// Checksum 0x6bac4755, Offset: 0xb88
// Size: 0x8e
function function_67c434(local_client_num, localplayer, spawningplayer) {
    if (!localplayer hasperk(local_client_num, #"specialty_detectnearbyenemies")) {
        return false;
    }
    if (localplayer.team == spawningplayer.team) {
        return false;
    }
    if (self hasperk(local_client_num, #"specialty_spycraft")) {
        return false;
    }
    return true;
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x1ade168f, Offset: 0xc20
// Size: 0x124
function on_player_spawned(local_client_num) {
    /#
        self thread watch_perks_change(local_client_num);
    #/
    self notify(#"perks_changed");
    if (true) {
        self thread killtrackerfx_on_death(local_client_num);
        self thread monitor_tracker_perk(local_client_num);
    }
    localplayer = function_5c10bd79(local_client_num);
    if (function_67c434(local_client_num, localplayer, self)) {
        if (!isdefined(level.nearbyspawns)) {
            level.nearbyspawns = [];
        }
        spawnlocation = spawnstruct();
        spawnlocation.origin = self.origin;
        spawnlocation.spawntime = getservertime(local_client_num);
        level.nearbyspawns[level.nearbyspawns.size] = spawnlocation;
    }
}

/#

    // Namespace perks/perks
    // Params 2, eflags: 0x0
    // Checksum 0xd4b1dec3, Offset: 0xd50
    // Size: 0xac
    function array_equal(&a, &b) {
        if (isdefined(a) && isdefined(b) && isarray(a) && isarray(b) && a.size == b.size) {
            for (i = 0; i < a.size; i++) {
                if (a[i] !== b[i]) {
                    return 0;
                }
            }
            return 1;
        }
        return 0;
    }

    // Namespace perks/perks
    // Params 1, eflags: 0x0
    // Checksum 0x4786c2b5, Offset: 0xe08
    // Size: 0xd8
    function watch_perks_change(local_client_num) {
        self notify(#"watch_perks_change");
        self endon(#"watch_perks_change");
        self endon(#"death");
        self.last_perks = self getperks(local_client_num);
        while (isdefined(self)) {
            perks = self getperks(local_client_num);
            if (!array_equal(perks, self.last_perks)) {
                self.last_perks = perks;
                self notify(#"perks_changed");
            }
            wait 1;
        }
    }

#/

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0xef66e58, Offset: 0xee8
// Size: 0xd2
function get_players(local_client_num) {
    players = [];
    entities = getentarray(local_client_num);
    if (isdefined(entities)) {
        foreach (ent in entities) {
            if (isplayer(ent)) {
                players[players.size] = ent;
            }
        }
    }
    return players;
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x7001a3f0, Offset: 0xfc8
// Size: 0xfe
function monitor_tracker_existing_players(local_client_num) {
    self notify(#"monitor_tracker_existing_players");
    self endon(#"death", #"monitor_tracker_existing_players");
    players = getplayers(local_client_num);
    foreach (player in players) {
        if (isdefined(player) && player != self) {
            player thread monitor_tracker_perk(local_client_num);
        }
        waitframe(1);
    }
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0xb081e745, Offset: 0x10d0
// Size: 0x2b4
function monitor_tracker_perk_killcam(local_client_num) {
    self notify("monitor_tracker_perk_killcam" + local_client_num);
    self endon("monitor_tracker_perk_killcam" + local_client_num);
    self endon(#"death");
    if (!isdefined(level.trackerspecialtyself)) {
        level.trackerspecialtyself = [];
        level.trackerspecialtycounter = [];
    }
    if (!isdefined(level.trackerspecialtyself[local_client_num])) {
        level.trackerspecialtyself[local_client_num] = [];
    }
    if (!isdefined(level.trackerspecialtycounter[local_client_num])) {
        level.trackerspecialtycounter[local_client_num] = 0;
    }
    if (function_1cbf351b(local_client_num)) {
        if (function_5778f82(local_client_num, #"specialty_tracker")) {
            servertime = getservertime(local_client_num);
            for (count = 0; count < level.trackerspecialtyself[local_client_num].size; count++) {
                if (!isdefined(level.trackerspecialtyself[local_client_num][count])) {
                    continue;
                }
                if (level.trackerspecialtyself[local_client_num][count].time < servertime && level.trackerspecialtyself[local_client_num][count].time > servertime - 5000) {
                    positionandrotationstruct = level.trackerspecialtyself[local_client_num][count];
                    tracker_playfx(local_client_num, positionandrotationstruct);
                }
            }
        }
        return;
    }
    for (;;) {
        wait 0.24;
        isinvehicle = isdefined(getplayervehicle(self));
        if (isinvehicle) {
            continue;
        }
        positionandrotationstruct = self gettrackerfxposition(local_client_num);
        if (isdefined(positionandrotationstruct)) {
            positionandrotationstruct.time = getservertime(local_client_num);
            level.trackerspecialtyself[local_client_num][level.trackerspecialtycounter[local_client_num]] = positionandrotationstruct;
            level.trackerspecialtycounter[local_client_num]++;
            if (level.trackerspecialtycounter[local_client_num] > 20) {
                level.trackerspecialtycounter[local_client_num] = 0;
            }
        }
    }
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x5f7d0c4e, Offset: 0x1390
// Size: 0xc6
function function_26757b5e(local_client_num) {
    if (!function_5778f82(local_client_num, #"specialty_tracker")) {
        return false;
    }
    if (self function_ca024039()) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (is_true(self.flying)) {
        return false;
    }
    if (isdefined(getplayervehicle(self))) {
        return false;
    }
    if (self hasperk(local_client_num, "specialty_spycraft")) {
        return false;
    }
    return true;
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x53a0c640, Offset: 0x1460
// Size: 0x188
function monitor_tracker_perk(local_client_num) {
    self notify(#"monitor_tracker_perk");
    self endon(#"death", #"monitor_tracker_perk");
    var_560db6a = self getentitynumber() % 15;
    var_9426f90f = int(gettime() / 16) % 15;
    self.tracker_last_pos = self.origin;
    while (isdefined(self)) {
        if (var_9426f90f == var_560db6a) {
            wait 0.24;
        } else {
            self waittilltimeout((15 + var_560db6a - var_9426f90f) % 15 * 0.016, #"death");
        }
        if (self function_21c0fa55()) {
            return;
        }
        var_9426f90f = int(gettime() / 16) % 15;
        if (self function_26757b5e(local_client_num)) {
            positionandrotationstruct = self gettrackerfxposition(local_client_num);
            if (isdefined(positionandrotationstruct)) {
                self tracker_playfx(local_client_num, positionandrotationstruct);
            }
        }
    }
}

// Namespace perks/perks
// Params 2, eflags: 0x0
// Checksum 0x6ce42409, Offset: 0x15f0
// Size: 0x6c
function tracker_playfx(local_client_num, positionandrotationstruct) {
    handle = playfx(local_client_num, positionandrotationstruct.fx, positionandrotationstruct.pos, positionandrotationstruct.fwd);
    self killtrackerfx_track(local_client_num, handle);
}

// Namespace perks/perks
// Params 2, eflags: 0x0
// Checksum 0x301b4eff, Offset: 0x1668
// Size: 0xde
function killtrackerfx_track(local_client_num, handle) {
    if (handle && isdefined(self.killtrackerfx)) {
        servertime = getservertime(local_client_num);
        killfxstruct = spawnstruct();
        killfxstruct.time = servertime;
        killfxstruct.handle = handle;
        index = self.killtrackerfx.index;
        if (index >= 40) {
            index = 0;
        }
        self.killtrackerfx.array[index] = killfxstruct;
        self.killtrackerfx.index = index + 1;
    }
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0xc1ea21d2, Offset: 0x1750
// Size: 0x1bc
function killtrackerfx_on_death(local_client_num) {
    if (!is_true(level.killtrackerfxenable)) {
        return;
    }
    if (self function_21c0fa55()) {
        return;
    }
    if (isdefined(self.killtrackerfx)) {
        self.killtrackerfx.array = [];
        self.killtrackerfx.index = 0;
        self.killtrackerfx = undefined;
    }
    killtrackerfx = spawnstruct();
    killtrackerfx.array = [];
    killtrackerfx.index = 0;
    self.killtrackerfx = killtrackerfx;
    self waittill(#"death");
    servertime = getservertime(local_client_num);
    foreach (killfxstruct in killtrackerfx.array) {
        if (isdefined(killfxstruct) && killfxstruct.time + 5000 > servertime) {
            killfx(local_client_num, killfxstruct.handle);
        }
    }
    killtrackerfx.array = [];
    killtrackerfx.index = 0;
    killtrackerfx = undefined;
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0xab740af, Offset: 0x1918
// Size: 0x262
function gettrackerfxposition(local_client_num) {
    positionandrotation = undefined;
    player = self;
    if (is_true(self._isclone)) {
        player = self.owner;
    }
    if (!isdefined(level.var_19d86f63)) {
        level.var_19d86f63 = (0, 0, getdvarfloat(#"perk_tracker_fx_foot_height", 0));
    }
    pos = self.origin + level.var_19d86f63;
    if (!isdefined(self.tracker_last_pos)) {
        self.tracker_last_pos = pos;
    }
    if (distancesquared(self.tracker_last_pos, pos) > 1024) {
        playfastfx = player hasperk(local_client_num, #"specialty_trackerjammer");
        if (is_true(self.trailrightfoot)) {
            if (playfastfx) {
                fx = #"player/fx_plyr_footstep_tracker_rf";
            } else {
                fx = #"player/fx9_perk_tracker_footstep_rgt";
            }
        } else if (playfastfx) {
            fx = #"player/fx_plyr_footstep_tracker_lf";
        } else {
            fx = #"player/fx9_perk_tracker_footstep_lft";
        }
        fwd = self getvelocity();
        if (lengthsquared(fwd) < 1) {
            fwd = anglestoforward(self.angles);
        }
        positionandrotation = {#fx:fx, #pos:pos, #fwd:fwd};
        self.tracker_last_pos = self.origin;
        self.trailrightfoot = !is_true(self.trailrightfoot);
    }
    return positionandrotation;
}

// Namespace perks/perks
// Params 3, eflags: 0x0
// Checksum 0xdcf14099, Offset: 0x1b88
// Size: 0x5e
function function_3edf2cf8(dist_sq, var_73491815, var_47435b6f) {
    return dist_sq < sqr(var_47435b6f) && sqr(var_47435b6f) < sqr(var_73491815);
}

// Namespace perks/perks
// Params 2, eflags: 0x0
// Checksum 0x4e259b8f, Offset: 0x1bf0
// Size: 0xf2
function function_365c39ef(awareness_action, bundle) {
    switch (awareness_action) {
    case #"slide_start":
        return bundle.var_146483e7;
    case #"landing":
        return bundle.var_fe0aa1d2;
    case #"damage_landing":
        return bundle.var_6ae8117c;
    case #"doublejump_boosted":
        return bundle.var_37bac39d;
    case #"hash_589eac8b592bcb4d":
        return bundle.var_3b22f5be;
    case #"weapon_fired":
        return bundle.var_abea5dd8;
    case #"hash_552ed0592ee3fb0e":
        return bundle.var_301350af;
    }
    return 0;
}

// Namespace perks/perks
// Params 4, eflags: 0x0
// Checksum 0xbbdc29e8, Offset: 0x1cf0
// Size: 0x120
function function_255fe01d(var_bf36ab55, localplayerorigin, playerforward, playerright) {
    vector = var_bf36ab55 - localplayerorigin;
    vectorflat = vectornormalize((vector[0], vector[1], 0));
    var_451ea257 = vectordot(vectorflat, playerforward);
    var_2f93b65 = var_451ea257 > 0;
    var_8add8d51 = vectordot(vectorflat, playerright);
    var_b1d7b2f5 = var_8add8d51 > 0;
    if (var_2f93b65) {
        if (var_b1d7b2f5) {
            quadindex = 0;
        } else {
            quadindex = 3;
        }
    } else if (var_b1d7b2f5) {
        quadindex = 1;
    } else {
        quadindex = 2;
    }
    return quadindex;
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x232f828d, Offset: 0x1e18
// Size: 0x368
function function_e3426b1f(local_client_num) {
    self endon(#"death");
    level.nearbyspawns = [];
    var_e4ed29e4 = createuimodel(function_1df4c3b0(local_client_num, #"hud_items"), "awareness");
    setuimodelvalue(var_e4ed29e4, 1);
    var_c948d7f9 = [];
    for (i = 0; i < 4; i++) {
        array::add(var_c948d7f9, createuimodel(function_1df4c3b0(local_client_num, #"hud_items"), "awareness.seg" + i + ".segmentValue"));
    }
    while (true) {
        localplayer = function_5c10bd79(local_client_num);
        playerangles = localplayer.angles;
        var_92b00101 = getdvarint(#"ui_awareness_rotate", 0);
        if (var_92b00101) {
            if (playerangles[0] > 0) {
                playerangles = (1, 0, 0);
            } else {
                playerangles = (-1, 0, 0);
            }
        }
        localplayeranglestoforward = anglestoforward(playerangles);
        localplayeranglestoright = anglestoright(playerangles);
        var_46fc4dd6 = [0, 0, 0, 0];
        var_bb2f1c40 = pow(2, 3);
        for (index = level.nearbyspawns.size - 1; index >= 0; index--) {
            difftime = getservertime(local_client_num) - level.nearbyspawns[index].spawntime;
            if (2500 < difftime) {
                arrayremoveindex(level.nearbyspawns, index);
                continue;
            }
            var_b371d6ae = function_255fe01d(level.nearbyspawns[index].origin, localplayer.origin, localplayeranglestoforward, localplayeranglestoright);
            var_46fc4dd6[var_b371d6ae] = var_bb2f1c40;
        }
        for (index = 0; index < var_c948d7f9.size; index++) {
            self thread function_c90f8547(var_c948d7f9[index], var_46fc4dd6[index], 0);
        }
        wait 0.24;
    }
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x11202895, Offset: 0x2188
// Size: 0xeac
function monitor_detectnearbyenemies(local_client_num) {
    var_3790ba24 = 0;
    if (var_3790ba24) {
        return;
    }
    self endon(#"death");
    var_e4ed29e4 = createuimodel(function_1df4c3b0(local_client_num, #"hud_items"), "awareness");
    setuimodelvalue(var_e4ed29e4, 0);
    var_c948d7f9 = [];
    for (i = 0; i < 4; i++) {
        array::add(var_c948d7f9, createuimodel(function_1df4c3b0(local_client_num, #"hud_items"), "awareness.seg" + i + ".segmentValue"));
        setuimodelvalue(var_c948d7f9[i], 0);
    }
    enemynearbytime = 0;
    enemylosttime = 0;
    previousenemydetectedbitfield = 0;
    var_55336d8d = level.var_6fc25f5c;
    var_c394e130 = level.var_842a5e1f;
    self.var_7122b2ff = 0;
    while (true) {
        /#
            if (getdvarint(#"hash_340cb17d497f0877", 0) > 0) {
                level.var_6fc25f5c = getscriptbundle(#"awareness");
                var_55336d8d = level.var_6fc25f5c;
                level.var_842a5e1f = getscriptbundle(#"awareness_deadsilence");
                var_c394e130 = level.var_842a5e1f;
            }
        #/
        localplayer = function_5c10bd79(local_client_num);
        if (isdefined(localplayer) && isplayer(localplayer) && isalive(localplayer)) {
            var_99edc583 = localplayer function_fd82b127();
        } else {
            var_99edc583 = 0;
        }
        range = var_99edc583 * 0.5;
        if (!isdefined(localplayer) || !isplayer(localplayer) || function_5778f82(local_client_num, #"specialty_detectnearbyenemies") == 0 || function_1cbf351b(local_client_num) == 1 || isalive(localplayer) == 0) {
            setuimodelvalue(var_e4ed29e4, 0);
            previousenemydetectedbitfield = 0;
            if (isdefined(level.var_783d3911) && gettime() < level.var_783d3911 + 12000) {
                wait 0.5;
                continue;
            }
            self waittill(#"death", #"spawned", #"perks_changed");
            continue;
        }
        if (self isremotecontrolling(local_client_num)) {
            setuimodelvalue(var_e4ed29e4, 0);
            if (previousenemydetectedbitfield != 0) {
                for (i = 0; i < 4; i++) {
                    self thread function_c90f8547(var_c948d7f9[i], 0, 0);
                }
            }
            previousenemydetectedbitfield = 0;
            wait 0.5;
            continue;
        }
        if (self.var_7122b2ff == 0) {
            self thread function_c2b5b27c(local_client_num);
        }
        setuimodelvalue(var_e4ed29e4, 1);
        enemydetectedbitfield = 0;
        playerangles = localplayer.angles;
        var_92b00101 = getdvarint(#"ui_awareness_rotate", 0);
        if (var_92b00101) {
            if (playerangles[0] > 0) {
                playerangles = (1, 0, 0);
            } else {
                playerangles = (-1, 0, 0);
            }
        }
        localplayeranglestoforward = anglestoforward(playerangles);
        players = getplayers(local_client_num);
        clones = getclones(local_client_num);
        sixthsenseents = arraycombine(players, clones, 0, 0);
        foreach (sixthsenseent in sixthsenseents) {
            if (sixthsenseent function_ca024039() || sixthsenseent == localplayer) {
                continue;
            }
            if (!isalive(sixthsenseent)) {
                continue;
            }
            bundle = var_55336d8d;
            player = sixthsenseent;
            if (is_true(sixthsenseent._isclone)) {
                player = sixthsenseent.owner;
            }
            if (isplayer(player) && player hasperk(local_client_num, #"specialty_sixthsensejammer")) {
                bundle = var_c394e130;
            }
            var_7aeac1e7 = 0;
            speed = sixthsenseent getspeed();
            var_d6ff0766 = 0;
            distcurrentsq = distance2dsquared(sixthsenseent.origin, localplayer.origin);
            if (!var_7aeac1e7) {
                if (speed >= bundle.var_293163bd) {
                    movement_type = sixthsenseent getmovementtype();
                    if (isplayer(player) && (player isplayerswimming() || player function_d76efdcc())) {
                        movement_type = "";
                    }
                    switch (movement_type) {
                    case #"run":
                    case #"walk":
                        if (sixthsenseent isplayerads()) {
                            var_d6ff0766 = bundle.var_2b6e9133 * range;
                            var_7aeac1e7 = 1;
                        } else {
                            stance = sixthsenseent getstance();
                            if (stance == "stand") {
                                var_d6ff0766 = bundle.var_dbf6038b * range;
                                var_7aeac1e7 = 1;
                            } else if (stance == "crouch") {
                                var_d6ff0766 = bundle.var_dccff18f * range;
                                var_7aeac1e7 = 1;
                            }
                        }
                        break;
                    case #"sprint":
                        var_d6ff0766 = bundle.var_a8e88375 * range;
                        var_7aeac1e7 = 1;
                        break;
                    }
                } else if (speed <= (isdefined(bundle.var_6cb0467e) ? bundle.var_6cb0467e : 0) && (isdefined(bundle.var_ad484b97) ? bundle.var_ad484b97 : 0) != 0) {
                    var_d6ff0766 = (isdefined(bundle.var_ad484b97) ? bundle.var_ad484b97 : 0) * range;
                    if (distcurrentsq < sqr(var_d6ff0766)) {
                        var_7aeac1e7 = 1;
                    }
                }
            }
            if (isdefined(sixthsenseent.var_629d0f94)) {
                actionkeys = getarraykeys(sixthsenseent.var_629d0f94);
                foreach (action in actionkeys) {
                    var_aaf15d9a = sixthsenseent.var_629d0f94[action];
                    if (!isdefined(var_aaf15d9a)) {
                        continue;
                    }
                    if (gettime() - var_aaf15d9a > 500) {
                        sixthsenseent.var_629d0f94[action] = undefined;
                        continue;
                    }
                    var_7cecdeb5 = function_365c39ef(action, bundle) * range;
                    if (!var_7aeac1e7 || function_3edf2cf8(distcurrentsq, var_d6ff0766, var_7cecdeb5)) {
                        var_d6ff0766 = var_7cecdeb5;
                        var_7aeac1e7 = 1;
                    }
                }
                arrayremovevalue(sixthsenseent.var_629d0f94, undefined, 1);
            }
            if (!var_7aeac1e7) {
                continue;
            }
            var_482e2661 = sqr(var_d6ff0766);
            detected = var_d6ff0766 == 0 || distcurrentsq < var_482e2661;
            if (detected) {
                vector = sixthsenseent.origin - localplayer.origin;
                vectorflat = vectornormalize((vector[0], vector[1], 0));
                cosangle = vectordot(vectorflat, localplayeranglestoforward);
                if (distcurrentsq < sqr(range * bundle.var_7c9cab4f)) {
                    var_c729e60c = 8;
                } else {
                    var_c729e60c = 2;
                }
                if (cosangle > 0.707107) {
                    enemydetectedbitfield |= var_c729e60c << 0;
                    continue;
                }
                if (cosangle < -0.707107) {
                    enemydetectedbitfield |= var_c729e60c << 9;
                    continue;
                }
                localplayeranglestoright = anglestoright(playerangles);
                var_21060744 = vectordot(vectorflat, localplayeranglestoright) < 0;
                if (cosangle > 0) {
                    enemydetectedbitfield |= var_c729e60c << (var_21060744 ? 15 : 3);
                    continue;
                }
                enemydetectedbitfield |= var_c729e60c << (var_21060744 ? 12 : 6);
            }
        }
        if (enemydetectedbitfield) {
            enemylosttime = 0;
            if (previousenemydetectedbitfield != enemydetectedbitfield && enemynearbytime >= 0.05) {
                bitfields = enemydetectedbitfield;
                for (i = 0; i < 4; i++) {
                    self thread function_c90f8547(var_c948d7f9[i], bitfields & (1 << 4) - 1, bundle.var_a3d426e6);
                    bitfields >>= 3;
                }
                enemynearbytime = 0;
                diff = enemydetectedbitfield ^ previousenemydetectedbitfield;
                if (diff & enemydetectedbitfield) {
                    shouldplaysound = 0;
                    if (shouldplaysound) {
                        self playsound(local_client_num, #"uin_sixth_sense_ping_on");
                    }
                }
                if (diff & previousenemydetectedbitfield) {
                }
                previousenemydetectedbitfield = enemydetectedbitfield;
            }
            enemynearbytime += 0.05;
        } else {
            enemynearbytime = 0;
            if (previousenemydetectedbitfield != 0 && enemylosttime >= 0.05) {
                for (i = 0; i < 4; i++) {
                    self thread function_c90f8547(var_c948d7f9[i], 0, bundle.var_a3d426e6);
                }
                previousenemydetectedbitfield = 0;
            }
            enemylosttime += 0.05;
        }
        wait 0.05;
    }
    setuimodelvalue(var_e4ed29e4, 1);
}

// Namespace perks/perks
// Params 3, eflags: 0x0
// Checksum 0x8ffb47b9, Offset: 0x3040
// Size: 0x64
function function_c90f8547(var_8bced359, var_832d6681, delay_time) {
    self endon(#"death");
    if (isdefined(delay_time) && delay_time > 0) {
        wait delay_time;
    }
    setuimodelvalue(var_8bced359, var_832d6681);
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x5c77b06f, Offset: 0x30b0
// Size: 0xb4
function function_c2b5b27c(*local_client_num) {
    self endon(#"death");
    self.var_7122b2ff = 1;
    while (true) {
        waitresult = self waittill(#"awareness_action");
        if (isdefined(waitresult.var_53714565)) {
            var_9f19a239 = waitresult.var_53714565;
            if (!isdefined(var_9f19a239.var_629d0f94)) {
                var_9f19a239.var_629d0f94 = [];
            }
            var_9f19a239.var_629d0f94[waitresult.action] = gettime();
        }
    }
}

