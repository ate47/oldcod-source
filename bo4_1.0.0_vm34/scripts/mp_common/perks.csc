#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace perks;

// Namespace perks/perks
// Params 0, eflags: 0x2
// Checksum 0xb10a3e7c, Offset: 0x210
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"perks", &__init__, undefined, undefined);
}

// Namespace perks/perks
// Params 0, eflags: 0x0
// Checksum 0x9b182b02, Offset: 0x258
// Size: 0x40c
function __init__() {
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
    level.var_3aed2df7 = getscriptbundle(#"awareness");
    level.var_c6d33b09 = getscriptbundle(#"awareness_deadsilence");
    /#
        level thread updatedvars();
    #/
}

// Namespace perks/perks
// Params 0, eflags: 0x0
// Checksum 0xe9c8f92c, Offset: 0x670
// Size: 0xc8
function updatesitrepscan() {
    self endon(#"death");
    while (true) {
        self function_3a7fafc5(0, level.sitrepscan1_enable, level.sitrepscan1_setdesat, level.sitrepscan1_setsolid, level.sitrepscan1_setoutline, level.sitrepscan1_setlinewidth, level.sitrepscan1_setradius, level.sitrepscan1_setfalloff);
        self function_3a7fafc5(1, level.sitrepscan2_enable, level.sitrepscan2_setdesat, level.sitrepscan2_setsolid, level.sitrepscan2_setoutline, level.sitrepscan2_setlinewidth, level.sitrepscan2_setradius, level.sitrepscan2_setfalloff);
        wait 1;
    }
}

/#

    // Namespace perks/perks
    // Params 0, eflags: 0x0
    // Checksum 0xf6de0e68, Offset: 0x740
    // Size: 0x364
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
            level.friendlycontentoutlines = getdvarint(#"friendlycontentoutlines", level.friendlycontentoutlines);
            wait 1;
        }
    }

#/

// Namespace perks/perks
// Params 7, eflags: 0x0
// Checksum 0xc27bc0a7, Offset: 0xab0
// Size: 0x4a
function flying_callback(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.flying = newval;
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0xd0a041fd, Offset: 0xb08
// Size: 0x10c
function on_local_client_connect(local_client_num) {
    registerrewindfx(local_client_num, "player/fx8_plyr_footstep_tracker_l");
    registerrewindfx(local_client_num, "player/fx8_plyr_footstep_tracker_r");
    registerrewindfx(local_client_num, "player/fx_plyr_flying_tracker_l");
    registerrewindfx(local_client_num, "player/fx_plyr_flying_tracker_r");
    registerrewindfx(local_client_num, "player/fx_plyr_footstep_tracker_lf");
    registerrewindfx(local_client_num, "player/fx_plyr_footstep_tracker_rf");
    registerrewindfx(local_client_num, "player/fx_plyr_flying_tracker_lf");
    registerrewindfx(local_client_num, "player/fx_plyr_flying_tracker_rf");
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x6516f5dd, Offset: 0xc20
// Size: 0x26
function on_localplayer_spawned(local_client_num) {
    profilestart();
    self function_43f7f888(local_client_num);
    profilestop();
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x6d9e42a7, Offset: 0xc50
// Size: 0x46
function on_gameplay_started(local_client_num) {
    waittillframeend();
    profilestart();
    local_player = function_f97e7787(local_client_num);
    local_player function_43f7f888(local_client_num);
    profilestop();
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0xbaead917, Offset: 0xca0
// Size: 0x74
function function_43f7f888(local_client_num) {
    if (!self function_60dbc438()) {
        return;
    }
    self thread monitor_detectnearbyenemies(local_client_num);
    if (true) {
        self thread monitor_tracker_perk_killcam(local_client_num);
        self thread monitor_tracker_existing_players(local_client_num);
    }
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x76bf8fe, Offset: 0xd20
// Size: 0x6c
function on_player_spawned(local_client_num) {
    /#
        self thread watch_perks_change(local_client_num);
    #/
    self notify(#"perks_changed");
    if (true) {
        self thread killtrackerfx_on_death(local_client_num);
        self thread monitor_tracker_perk(local_client_num);
    }
}

/#

    // Namespace perks/perks
    // Params 2, eflags: 0x0
    // Checksum 0xb7c4407, Offset: 0xd98
    // Size: 0xba
    function array_equal(&a, &b) {
        if (isdefined(a) && isdefined(b) && isarray(a) && isarray(b) && a.size == b.size) {
            for (i = 0; i < a.size; i++) {
                if (!(a[i] === b[i])) {
                    return 0;
                }
            }
            return 1;
        }
        return 0;
    }

    // Namespace perks/perks
    // Params 1, eflags: 0x0
    // Checksum 0xa02c96c4, Offset: 0xe60
    // Size: 0xe8
    function watch_perks_change(local_client_num) {
        self notify(#"watch_perks_change");
        self endon(#"watch_perks_change");
        self endon(#"death");
        self endon(#"disconnect");
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
// Checksum 0xe41a6ba4, Offset: 0xf50
// Size: 0xc8
function get_players(local_client_num) {
    players = [];
    entities = getentarray(local_client_num);
    if (isdefined(entities)) {
        foreach (ent in entities) {
            if (ent isplayer()) {
                players[players.size] = ent;
            }
        }
    }
    return players;
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x7931dc3, Offset: 0x1020
// Size: 0xf6
function monitor_tracker_existing_players(local_client_num) {
    self endon(#"death");
    self endon(#"monitor_tracker_existing_players");
    self notify(#"monitor_tracker_existing_players");
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
// Checksum 0x42dc4988, Offset: 0x1120
// Size: 0x246
function monitor_tracker_perk_killcam(local_client_num) {
    self notify("monitor_tracker_perk_killcam" + local_client_num);
    self endon("monitor_tracker_perk_killcam" + local_client_num);
    self endon(#"death");
    if (!isdefined(level.trackerspecialtyself)) {
        level.trackerspecialtyself = [];
        level.trackerspecialtycounter = 0;
    }
    if (!isdefined(level.trackerspecialtyself[local_client_num])) {
        level.trackerspecialtyself[local_client_num] = [];
    }
    if (function_1fe374eb(local_client_num)) {
        if (function_24e25118(local_client_num, #"specialty_tracker")) {
            servertime = getservertime(local_client_num);
            for (count = 0; count < level.trackerspecialtyself[local_client_num].size; count++) {
                if (level.trackerspecialtyself[local_client_num][count].time < servertime && level.trackerspecialtyself[local_client_num][count].time > servertime - 5000) {
                    positionandrotationstruct = level.trackerspecialtyself[local_client_num][count];
                    tracker_playfx(local_client_num, positionandrotationstruct);
                }
            }
        }
        return;
    }
    for (;;) {
        waitframe(1);
        positionandrotationstruct = self gettrackerfxposition(local_client_num);
        if (isdefined(positionandrotationstruct)) {
            positionandrotationstruct.time = getservertime(local_client_num);
            level.trackerspecialtyself[local_client_num][level.trackerspecialtycounter] = positionandrotationstruct;
            level.trackerspecialtycounter++;
            if (level.trackerspecialtycounter > 20) {
                level.trackerspecialtycounter = 0;
            }
        }
    }
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0xeb6600b1, Offset: 0x1370
// Size: 0x1b6
function monitor_tracker_perk(local_client_num) {
    self notify(#"monitor_tracker_perk");
    self endon(#"monitor_tracker_perk");
    self endon(#"death");
    self endon(#"disconnect");
    self.flying = 0;
    self.tracker_flying = 0;
    self.tracker_last_pos = self.origin;
    offset = (0, 0, getdvarfloat(#"perk_tracker_fx_foot_height", 0));
    dist2 = 1024;
    while (isdefined(self)) {
        waitframe(1);
        if (self function_60dbc438()) {
            return;
        }
        if (function_24e25118(local_client_num, #"specialty_tracker")) {
            friend = self function_55a8b32b();
            isalive = isalive(self);
            if (!friend && isalive) {
                positionandrotationstruct = self gettrackerfxposition(local_client_num);
                if (isdefined(positionandrotationstruct)) {
                    self tracker_playfx(local_client_num, positionandrotationstruct);
                }
                continue;
            }
            self.tracker_flying = 0;
        }
    }
}

// Namespace perks/perks
// Params 2, eflags: 0x0
// Checksum 0xea9f219b, Offset: 0x1530
// Size: 0x7c
function tracker_playfx(local_client_num, positionandrotationstruct) {
    handle = playfx(local_client_num, positionandrotationstruct.fx, positionandrotationstruct.pos, positionandrotationstruct.fwd, positionandrotationstruct.up);
    self killtrackerfx_track(local_client_num, handle);
}

// Namespace perks/perks
// Params 2, eflags: 0x0
// Checksum 0xe0828ac, Offset: 0x15b8
// Size: 0xea
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
// Checksum 0x3219e1c5, Offset: 0x16b0
// Size: 0x1d0
function killtrackerfx_on_death(local_client_num) {
    self endon(#"disconnect");
    if (!(isdefined(level.killtrackerfxenable) && level.killtrackerfxenable)) {
        return;
    }
    if (self function_60dbc438()) {
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
// Checksum 0xecc14cf1, Offset: 0x1888
// Size: 0x46e
function gettrackerfxposition(local_client_num) {
    positionandrotation = undefined;
    player = self;
    if (isdefined(self._isclone) && self._isclone) {
        player = self.owner;
    }
    playfastfx = player hasperk(local_client_num, #"specialty_trackerjammer");
    if (isdefined(self.flying) && self.flying) {
        offset = (0, 0, getdvarfloat(#"perk_tracker_fx_fly_height", 0));
        dist2 = 1024;
        if (isdefined(self.trailrightfoot) && self.trailrightfoot) {
            if (playfastfx) {
                fx = "player/fx_plyr_flying_tracker_rf";
            } else {
                fx = "player/fx_plyr_flying_tracker_r";
            }
        } else if (playfastfx) {
            fx = "player/fx_plyr_flying_tracker_lf";
        } else {
            fx = "player/fx_plyr_flying_tracker_l";
        }
    } else {
        offset = (0, 0, getdvarfloat(#"perk_tracker_fx_foot_height", 0));
        dist2 = 1024;
        if (isdefined(self.trailrightfoot) && self.trailrightfoot) {
            if (playfastfx) {
                fx = "player/fx_plyr_footstep_tracker_rf";
            } else {
                fx = "player/fx8_plyr_footstep_tracker_r";
            }
        } else if (playfastfx) {
            fx = "player/fx_plyr_footstep_tracker_lf";
        } else {
            fx = "player/fx8_plyr_footstep_tracker_l";
        }
    }
    pos = self.origin + offset;
    fwd = anglestoforward(self.angles);
    right = anglestoright(self.angles);
    up = anglestoup(self.angles);
    vel = self getvelocity();
    if (lengthsquared(vel) > 1) {
        up = vectorcross(vel, right);
        if (lengthsquared(up) < 0.0001) {
            up = vectorcross(fwd, vel);
        }
        fwd = vel;
    }
    if (self isplayer() && self isplayerwallrunning()) {
        if (self isplayerwallrunningright()) {
            up = vectorcross(up, fwd);
        } else {
            up = vectorcross(fwd, up);
        }
    }
    if (!(isdefined(self.tracker_flying) && self.tracker_flying)) {
        self.tracker_flying = 1;
        self.tracker_last_pos = self.origin;
    } else if (distancesquared(self.tracker_last_pos, pos) > dist2) {
        positionandrotation = spawnstruct();
        positionandrotation.fx = fx;
        positionandrotation.pos = pos;
        positionandrotation.fwd = fwd;
        positionandrotation.up = up;
        self.tracker_last_pos = self.origin;
        if (isdefined(self.trailrightfoot) && self.trailrightfoot) {
            self.trailrightfoot = 0;
        } else {
            self.trailrightfoot = 1;
        }
    }
    return positionandrotation;
}

// Namespace perks/perks
// Params 3, eflags: 0x0
// Checksum 0x5a907ecc, Offset: 0x1d00
// Size: 0x48
function function_8ed3406d(dist_sq, var_f7b5d2e8, var_d0a91fcf) {
    return dist_sq < var_d0a91fcf * var_d0a91fcf && var_d0a91fcf * var_d0a91fcf < var_f7b5d2e8 * var_f7b5d2e8;
}

// Namespace perks/perks
// Params 2, eflags: 0x0
// Checksum 0x6637285b, Offset: 0x1d50
// Size: 0xf2
function function_8b2ff2ac(awareness_action, bundle) {
    switch (awareness_action) {
    case #"slide_start":
        return bundle.var_7bb58a82;
    case #"landing":
        return bundle.var_20af6804;
    case #"damage_landing":
        return bundle.var_c6ec3231;
    case #"doublejump_boosted":
        return bundle.var_da1ac4fa;
    case #"hash_589eac8b592bcb4d":
        return bundle.var_4e041bb4;
    case #"weapon_fired":
        return bundle.var_8b8d5219;
    case #"hash_552ed0592ee3fb0e":
        return bundle.var_704756f4;
    }
    return 0;
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x6d294457, Offset: 0x1e50
// Size: 0xd5c
function monitor_detectnearbyenemies(local_client_num) {
    self endon(#"death");
    controllermodel = getuimodelforcontroller(local_client_num);
    var_e36878ed = createuimodel(controllermodel, "hudItems.awareness");
    setuimodelvalue(var_e36878ed, 0);
    var_efff0bae = [];
    for (i = 0; i < 6; i++) {
        array::add(var_efff0bae, createuimodel(controllermodel, "hudItems.awareness.seg" + i + ".segmentValue"));
        setuimodelvalue(var_efff0bae[i], 0);
    }
    enemynearbytime = 0;
    enemylosttime = 0;
    previousenemydetectedbitfield = 0;
    var_4414eb21 = level.var_3aed2df7;
    var_df5ec9a3 = level.var_c6d33b09;
    self.var_d8e813c6 = 0;
    while (true) {
        /#
            if (getdvarint(#"hash_340cb17d497f0877", 0) > 0) {
                level.var_3aed2df7 = getscriptbundle(#"awareness");
                var_4414eb21 = level.var_3aed2df7;
                level.var_c6d33b09 = getscriptbundle(#"awareness_deadsilence");
                var_df5ec9a3 = level.var_c6d33b09;
            }
        #/
        localplayer = function_f97e7787(local_client_num);
        var_8eb25426 = localplayer function_84da65e4();
        range = var_8eb25426 * 0.5;
        if (!localplayer isplayer() || function_24e25118(local_client_num, #"specialty_detectnearbyenemies") == 0 || function_1fe374eb(local_client_num) == 1 || isalive(localplayer) == 0) {
            setuimodelvalue(var_e36878ed, 0);
            previousenemydetectedbitfield = 0;
            self waittill(#"death", #"spawned", #"perks_changed");
            continue;
        }
        if (self isremotecontrolling(local_client_num)) {
            wait 0.5;
            continue;
        }
        if (self.var_d8e813c6 == 0) {
            self thread function_7ace31bc(local_client_num);
        }
        setuimodelvalue(var_e36878ed, 1);
        enemydetectedbitfield = 0;
        playerangles = localplayer.angles;
        var_90a8e715 = getdvarint(#"ui_awareness_rotate", 0);
        if (var_90a8e715) {
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
            if (sixthsenseent function_55a8b32b() || sixthsenseent == localplayer) {
                continue;
            }
            if (!isalive(sixthsenseent)) {
                continue;
            }
            bundle = var_4414eb21;
            player = sixthsenseent;
            if (isdefined(sixthsenseent._isclone) && sixthsenseent._isclone) {
                player = sixthsenseent.owner;
            }
            if (player isplayer() && player hasperk(local_client_num, #"specialty_sixthsensejammer")) {
                bundle = var_df5ec9a3;
            }
            var_415a5f96 = 0;
            speed = sixthsenseent getspeed();
            var_2971e9e1 = 0;
            if (!var_415a5f96 && speed >= bundle.var_f11167e7) {
                movement_type = sixthsenseent getmovementtype();
                if (player isplayer() && (player isplayerswimming() || player function_bf6bfefe())) {
                    movement_type = "";
                }
                switch (movement_type) {
                case #"run":
                case #"walk":
                    if (sixthsenseent isplayerads()) {
                        var_2971e9e1 = bundle.var_999f4d04 * range;
                        var_415a5f96 = 1;
                    } else {
                        stance = sixthsenseent getstance();
                        if (stance == "stand") {
                            var_2971e9e1 = bundle.var_ff367de0 * range;
                            var_415a5f96 = 1;
                        } else if (stance == "crouch") {
                            var_2971e9e1 = bundle.var_bec73ef2 * range;
                            var_415a5f96 = 1;
                        }
                    }
                    break;
                case #"sprint":
                    var_2971e9e1 = bundle.var_11367b5f * range;
                    var_415a5f96 = 1;
                    break;
                }
            }
            distcurrentsq = distance2dsquared(sixthsenseent.origin, localplayer.origin);
            if (isdefined(sixthsenseent.var_1cd0e592)) {
                actionkeys = getarraykeys(sixthsenseent.var_1cd0e592);
                foreach (action in actionkeys) {
                    var_fd6daca3 = sixthsenseent.var_1cd0e592[action];
                    if (!isdefined(var_fd6daca3)) {
                        continue;
                    }
                    if (gettime() - var_fd6daca3 > 500) {
                        sixthsenseent.var_1cd0e592[action] = undefined;
                        continue;
                    }
                    var_7954f8c5 = function_8b2ff2ac(action, bundle) * range;
                    if (!var_415a5f96 || function_8ed3406d(distcurrentsq, var_2971e9e1, var_7954f8c5)) {
                        var_2971e9e1 = var_7954f8c5;
                        var_415a5f96 = 1;
                    }
                }
                arrayremovevalue(sixthsenseent.var_1cd0e592, undefined, 1);
            }
            if (!var_415a5f96) {
                continue;
            }
            var_8416915f = var_2971e9e1 * var_2971e9e1;
            detected = var_2971e9e1 == 0 || distcurrentsq < var_8416915f;
            if (detected) {
                vector = sixthsenseent.origin - localplayer.origin;
                vectorflat = vectornormalize((vector[0], vector[1], 0));
                cosangle = vectordot(vectorflat, localplayeranglestoforward);
                if (distcurrentsq < range * bundle.var_132af1cf * range * bundle.var_132af1cf) {
                    var_54e3e3a = 8;
                } else {
                    var_54e3e3a = 2;
                }
                if (cosangle > 0.707107) {
                    enemydetectedbitfield |= var_54e3e3a << 0;
                    continue;
                }
                if (cosangle < -0.707107) {
                    enemydetectedbitfield |= var_54e3e3a << 9;
                    continue;
                }
                localplayeranglestoright = anglestoright(playerangles);
                var_226e0634 = vectordot(vectorflat, localplayeranglestoright) < 0;
                if (cosangle > 0) {
                    enemydetectedbitfield |= var_54e3e3a << (var_226e0634 ? 15 : 3);
                    continue;
                }
                enemydetectedbitfield |= var_54e3e3a << (var_226e0634 ? 12 : 6);
            }
        }
        if (enemydetectedbitfield) {
            enemylosttime = 0;
            if (previousenemydetectedbitfield != enemydetectedbitfield && enemynearbytime >= 0.05) {
                bitfields = enemydetectedbitfield;
                for (i = 0; i < 6; i++) {
                    self thread function_2e9bdf80(var_efff0bae[i], bitfields & (1 << 4) - 1, bundle.var_385c163d);
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
                for (i = 0; i < 6; i++) {
                    self thread function_2e9bdf80(var_efff0bae[i], 0, bundle.var_385c163d);
                }
                previousenemydetectedbitfield = 0;
            }
            enemylosttime += 0.05;
        }
        wait 0.05;
    }
    setuimodelvalue(var_e36878ed, 1);
}

// Namespace perks/perks
// Params 3, eflags: 0x0
// Checksum 0x364f3dfd, Offset: 0x2bb8
// Size: 0x64
function function_2e9bdf80(var_430f00a6, var_e342d9a2, delay_time) {
    self endon(#"death");
    if (isdefined(delay_time) && delay_time > 0) {
        wait delay_time;
    }
    setuimodelvalue(var_430f00a6, var_e342d9a2);
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x3a794ed6, Offset: 0x2c28
// Size: 0xba
function function_7ace31bc(local_client_num) {
    self endon(#"death");
    self.var_d8e813c6 = 1;
    while (true) {
        waitresult = self waittill(#"awareness_action");
        if (isdefined(waitresult.var_145457a)) {
            var_b09400ed = waitresult.var_145457a;
            if (!isdefined(var_b09400ed.var_1cd0e592)) {
                var_b09400ed.var_1cd0e592 = [];
            }
            var_b09400ed.var_1cd0e592[waitresult.action] = gettime();
        }
    }
}

