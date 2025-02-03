#using scripts\core_common\callbacks_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\helicopter_shared;
#using scripts\mp_common\callbacks;
#using scripts\mp_common\vehicle;

#namespace callback;

// Namespace callback/callbacks
// Params 0, eflags: 0x6
// Checksum 0x78a57c25, Offset: 0x128
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"callback", &preinit, undefined, undefined, undefined);
}

// Namespace callback/callbacks
// Params 0, eflags: 0x4
// Checksum 0xebd44fc2, Offset: 0x170
// Size: 0x1c
function private preinit() {
    level thread set_default_callbacks();
}

// Namespace callback/callbacks
// Params 0, eflags: 0x0
// Checksum 0x31c5274e, Offset: 0x198
// Size: 0x124
function set_default_callbacks() {
    level.callbackplayerspawned = &playerspawned;
    level.callbackplayerlaststand = &playerlaststand;
    level.var_beec2b1 = &function_27cbba18;
    level.callbacklocalclientconnect = &localclientconnect;
    level.callbackcreatingcorpse = &creating_corpse;
    level.callbackentityspawned = &entityspawned;
    level.var_69b47c50 = &entervehicle;
    level.var_db2ec524 = &exitvehicle;
    level.callbackairsupport = &airsupport;
    level.callbackplayaifootstep = &footsteps::playaifootstep;
    level._custom_weapon_cb_func = &spawned_weapon_type;
    level.var_6b11d5f6 = &function_cbfd8fd6;
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0x56c63a96, Offset: 0x2c8
// Size: 0x7c
function localclientconnect(localclientnum) {
    println("<dev string:x38>" + localclientnum);
    if (isdefined(level.charactercustomizationsetup)) {
        [[ level.charactercustomizationsetup ]](localclientnum);
    }
    callback(#"on_localclient_connect", localclientnum);
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0x3da2a88d, Offset: 0x350
// Size: 0x2c
function function_27cbba18(localclientnum) {
    self callback(#"hash_781399e15b138a4e", localclientnum);
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0x1473bb19, Offset: 0x388
// Size: 0x44
function playerlaststand(localclientnum) {
    self endon(#"death");
    callback(#"on_player_laststand", localclientnum);
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0x4bc9e4f6, Offset: 0x3d8
// Size: 0x104
function playerspawned(localclientnum) {
    self endon(#"death");
    self notify(#"playerspawned_callback");
    self endon(#"playerspawned_callback");
    if (isdefined(level.infraredvisionset)) {
        function_8608b950(localclientnum, level.infraredvisionset);
    }
    if (isdefined(level._playerspawned_override)) {
        self thread [[ level._playerspawned_override ]](localclientnum);
        return;
    }
    if (self function_21c0fa55()) {
        level notify(#"localplayer_spawned");
        callback(#"on_localplayer_spawned", localclientnum);
    }
    callback(#"on_player_spawned", localclientnum);
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0x15abde75, Offset: 0x4e8
// Size: 0x2b4
function entityspawned(localclientnum) {
    self endon(#"death");
    if (isplayer(self)) {
        if (isdefined(level._clientfaceanimonplayerspawned)) {
            self thread [[ level._clientfaceanimonplayerspawned ]](localclientnum);
        }
    }
    if (isdefined(level._entityspawned_override)) {
        self thread [[ level._entityspawned_override ]](localclientnum);
        return;
    }
    if (!isdefined(self.type)) {
        println("<dev string:x68>");
        return;
    }
    if (self.type == "missile") {
        if (isdefined(level._custom_weapon_cb_func)) {
            self thread [[ level._custom_weapon_cb_func ]](localclientnum);
        }
        return;
    }
    if (self.type == "vehicle" || self.type == "helicopter" || self.type == "plane") {
        if (isdefined(level._customvehiclecbfunc)) {
            self thread [[ level._customvehiclecbfunc ]](localclientnum);
        }
        self thread vehicle::field_toggle_exhaustfx_handler(localclientnum, undefined, 0, 1);
        self thread vehicle::field_toggle_lights_handler(localclientnum, undefined, 0, 1);
        if (self.type == "plane" || self.type == "helicopter") {
            self thread vehicle::aircraft_dustkick();
        }
        return;
    }
    if (self.type == "scriptmover") {
        if (isdefined(level.var_83485e06)) {
            self thread [[ level.var_83485e06 ]](localclientnum);
        }
        return;
    }
    if (self.type == "actor") {
        if (isdefined(level._customactorcbfunc)) {
            self thread [[ level._customactorcbfunc ]](localclientnum);
        }
        self callback(#"hash_1fc6e31d0d02aa3", localclientnum);
        return;
    }
    if (self.type == "NA") {
        if (isdefined(self.weapon)) {
            if (isdefined(level.var_6b11d5f6)) {
                self thread [[ level.var_6b11d5f6 ]](localclientnum);
            }
        }
    }
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x34e8175a, Offset: 0x7a8
// Size: 0x3e
function entervehicle(localclientnum, vehicle) {
    profilestart();
    if (isdefined(level.var_e583fd9b)) {
        self thread [[ level.var_e583fd9b ]](localclientnum, vehicle);
    }
    profilestop();
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x43059406, Offset: 0x7f0
// Size: 0x3e
function exitvehicle(localclientnum, vehicle) {
    profilestart();
    if (isdefined(level.var_8e36d09b)) {
        self thread [[ level.var_8e36d09b ]](localclientnum, vehicle);
    }
    profilestop();
}

// Namespace callback/callbacks
// Params 12, eflags: 0x0
// Checksum 0x27ddde32, Offset: 0x838
// Size: 0x5d6
function airsupport(*localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, *time, height) {
    pos = (y, z, type);
    switch (owner) {
    case #"v":
        owner = #"vietcong";
        break;
    case #"nva":
    case #"n":
        owner = #"nva";
        break;
    case #"j":
        owner = #"japanese";
        break;
    case #"m":
        owner = #"marines";
        break;
    case #"s":
        owner = #"specops";
        break;
    case #"r":
        owner = #"russian";
        break;
    default:
        println("<dev string:x82>");
        println("<dev string:xbf>" + owner + "<dev string:xd9>");
        owner = #"marines";
        break;
    }
    switch (teamfaction) {
    case #"x":
        teamfaction = #"axis";
        break;
    case #"l":
        teamfaction = #"allies";
        break;
    case #"r":
        teamfaction = #"none";
        break;
    default:
        println("<dev string:xde>" + teamfaction + "<dev string:xd9>");
        teamfaction = #"allies";
        break;
    }
    data = spawnstruct();
    data.team = teamfaction;
    data.owner = exittype;
    data.bombsite = pos;
    data.yaw = team;
    direction = (0, team, 0);
    data.direction = direction;
    data.flyheight = height;
    if (yaw == "a") {
        planehalfdistance = 12000;
        data.planehalfdistance = planehalfdistance;
        data.startpoint = pos + vectorscale(anglestoforward(direction), -1 * planehalfdistance);
        data.endpoint = pos + vectorscale(anglestoforward(direction), planehalfdistance);
        data.planemodel = "t5_veh_air_b52";
        data.flybysound = "null";
        data.washsound = #"veh_b52_flyby_wash";
        data.apextime = 6145;
        data.exittype = -1;
        data.flyspeed = 2000;
        data.flytime = planehalfdistance * 2 / data.flyspeed;
        planetype = "airstrike";
        return;
    }
    if (yaw == "n") {
        planehalfdistance = 24000;
        data.planehalfdistance = planehalfdistance;
        data.startpoint = pos + vectorscale(anglestoforward(direction), -1 * planehalfdistance);
        data.endpoint = pos + vectorscale(anglestoforward(direction), planehalfdistance);
        data.planemodel = airsupport::getplanemodel(owner);
        data.flybysound = "null";
        data.washsound = #"evt_us_napalm_wash";
        data.apextime = 2362;
        data.exittype = time;
        data.flyspeed = 7000;
        data.flytime = planehalfdistance * 2 / data.flyspeed;
        planetype = "napalm";
        return;
    }
    /#
        println("<dev string:x114>");
        println("<dev string:x118>");
        println(yaw);
        println("<dev string:x114>");
    #/
    return;
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x4df7c202, Offset: 0xe18
// Size: 0x84
function creating_corpse(localclientnum, player) {
    params = spawnstruct();
    params.player = player;
    if (isdefined(player)) {
        params.playername = player getplayername();
    }
    self callback(#"on_player_corpse", localclientnum, params);
}

// Namespace callback/callbacks
// Params 7, eflags: 0x0
// Checksum 0x70485f0a, Offset: 0xea8
// Size: 0x96
function callback_emp(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self.emp = bwastimejump;
    println("<dev string:x162>");
    if (bwastimejump) {
        self notify(#"emp");
        return;
    }
    self notify(#"not_emp");
}

// Namespace callback/callbacks
// Params 7, eflags: 0x0
// Checksum 0x79822342, Offset: 0xf48
// Size: 0x4a
function callback_proximity(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self.enemyinproximity = bwastimejump;
}

