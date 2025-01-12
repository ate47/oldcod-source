#using scripts\abilities\gadgets\gadget_vision_pulse;
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
// Params 0, eflags: 0x2
// Checksum 0x19c23e1, Offset: 0x110
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"callback", &__init__, undefined, undefined);
}

// Namespace callback/callbacks
// Params 0, eflags: 0x0
// Checksum 0xc0eee135, Offset: 0x158
// Size: 0x1c
function __init__() {
    level thread set_default_callbacks();
}

// Namespace callback/callbacks
// Params 0, eflags: 0x0
// Checksum 0x6251f314, Offset: 0x180
// Size: 0xf6
function set_default_callbacks() {
    level.callbackplayerspawned = &playerspawned;
    level.callbackplayerlaststand = &playerlaststand;
    level.var_9db431b2 = &function_e8400e6b;
    level.callbacklocalclientconnect = &localclientconnect;
    level.callbackcreatingcorpse = &creating_corpse;
    level.callbackentityspawned = &entityspawned;
    level.callbackairsupport = &airsupport;
    level.callbackplayaifootstep = &footsteps::playaifootstep;
    level._custom_weapon_cb_func = &spawned_weapon_type;
    level.gadgetvisionpulse_reveal_func = &gadget_vision_pulse::gadget_visionpulse_reveal;
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0x6550d1f8, Offset: 0x280
// Size: 0x7c
function localclientconnect(localclientnum) {
    println("<dev string:x30>" + localclientnum);
    if (isdefined(level.charactercustomizationsetup)) {
        [[ level.charactercustomizationsetup ]](localclientnum);
    }
    callback(#"on_localclient_connect", localclientnum);
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0xa5249145, Offset: 0x308
// Size: 0x2c
function function_e8400e6b(localclientnum) {
    self callback(#"hash_781399e15b138a4e", localclientnum);
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0x9004457c, Offset: 0x340
// Size: 0x44
function playerlaststand(localclientnum) {
    self endon(#"death");
    callback(#"on_player_laststand", localclientnum);
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0xc9e5b7a9, Offset: 0x390
// Size: 0x124
function playerspawned(localclientnum) {
    self endon(#"death");
    self notify(#"playerspawned_callback");
    self endon(#"playerspawned_callback");
    if (isdefined(level.infraredvisionset)) {
        function_9f7f716e(localclientnum, level.infraredvisionset);
    }
    if (isdefined(level._playerspawned_override)) {
        self thread [[ level._playerspawned_override ]](localclientnum);
        return;
    }
    println("<dev string:x5d>");
    if (self function_60dbc438()) {
        level notify(#"localplayer_spawned");
        callback(#"on_localplayer_spawned", localclientnum);
    }
    callback(#"on_player_spawned", localclientnum);
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0x4c7acef9, Offset: 0x4c0
// Size: 0x288
function entityspawned(localclientnum) {
    self endon(#"death");
    if (self isplayer()) {
        if (isdefined(level._clientfaceanimonplayerspawned)) {
            self thread [[ level._clientfaceanimonplayerspawned ]](localclientnum);
        }
    }
    if (isdefined(level._entityspawned_override)) {
        self thread [[ level._entityspawned_override ]](localclientnum);
        return;
    }
    if (!isdefined(self.type)) {
        println("<dev string:x6c>");
        return;
    }
    if (self.type == "missile") {
        if (isdefined(level._custom_weapon_cb_func)) {
            self thread [[ level._custom_weapon_cb_func ]](localclientnum);
        }
    } else if (self.type == "vehicle" || self.type == "helicopter" || self.type == "plane") {
        if (isdefined(level._customvehiclecbfunc)) {
            self thread [[ level._customvehiclecbfunc ]](localclientnum);
        }
        self thread vehicle::field_toggle_exhaustfx_handler(localclientnum, undefined, 0, 1);
        self thread vehicle::field_toggle_lights_handler(localclientnum, undefined, 0, 1);
        if (self.type == "plane" || self.type == "helicopter") {
            self thread vehicle::aircraft_dustkick();
        } else {
            self thread vehicle::vehicle_rumble(localclientnum);
        }
        if (self.type == "helicopter") {
            self thread helicopter::startfx_loop(localclientnum);
        }
    } else if (self.type == "scriptmover") {
        if (isdefined(level.var_3535fd1e)) {
            self thread [[ level.var_3535fd1e ]](localclientnum);
        }
    }
    if (self.type == "actor") {
        if (isdefined(level._customactorcbfunc)) {
            self thread [[ level._customactorcbfunc ]](localclientnum);
        }
    }
}

// Namespace callback/callbacks
// Params 12, eflags: 0x0
// Checksum 0xc76ca653, Offset: 0x750
// Size: 0x636
function airsupport(localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height) {
    pos = (x, y, z);
    switch (teamfaction) {
    case #"v":
        teamfaction = #"vietcong";
        break;
    case #"nva":
    case #"n":
        teamfaction = #"nva";
        break;
    case #"j":
        teamfaction = #"japanese";
        break;
    case #"m":
        teamfaction = #"marines";
        break;
    case #"s":
        teamfaction = #"specops";
        break;
    case #"r":
        teamfaction = #"russian";
        break;
    default:
        println("<dev string:x83>");
        println("<dev string:xbd>" + teamfaction + "<dev string:xd4>");
        teamfaction = #"marines";
        break;
    }
    switch (team) {
    case #"x":
        team = #"axis";
        break;
    case #"l":
        team = #"allies";
        break;
    case #"r":
        team = #"free";
        break;
    default:
        println("<dev string:xd6>" + team + "<dev string:xd4>");
        team = #"allies";
        break;
    }
    data = spawnstruct();
    data.team = team;
    data.owner = owner;
    data.bombsite = pos;
    data.yaw = yaw;
    direction = (0, yaw, 0);
    data.direction = direction;
    data.flyheight = height;
    if (type == "a") {
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
    if (type == "n") {
        planehalfdistance = 24000;
        data.planehalfdistance = planehalfdistance;
        data.startpoint = pos + vectorscale(anglestoforward(direction), -1 * planehalfdistance);
        data.endpoint = pos + vectorscale(anglestoforward(direction), planehalfdistance);
        data.planemodel = airsupport::getplanemodel(teamfaction);
        data.flybysound = "null";
        data.washsound = #"evt_us_napalm_wash";
        data.apextime = 2362;
        data.exittype = exittype;
        data.flyspeed = 7000;
        data.flytime = planehalfdistance * 2 / data.flyspeed;
        planetype = "napalm";
        return;
    }
    /#
        println("<dev string:x109>");
        println("<dev string:x10a>");
        println(type);
        println("<dev string:x109>");
    #/
    return;
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0xae7ae08a, Offset: 0xd90
// Size: 0x7c
function creating_corpse(localclientnum, player) {
    params = spawnstruct();
    params.player = player;
    params.playername = player.name;
    self callback(#"on_player_corpse", localclientnum, params);
}

// Namespace callback/callbacks
// Params 7, eflags: 0x0
// Checksum 0xd97d7a0b, Offset: 0xe18
// Size: 0x96
function callback_stunned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.stunned = newval;
    println("<dev string:x151>");
    if (newval) {
        self notify(#"stunned");
        return;
    }
    self notify(#"not_stunned");
}

// Namespace callback/callbacks
// Params 7, eflags: 0x0
// Checksum 0xc21c5609, Offset: 0xeb8
// Size: 0x96
function callback_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.emp = newval;
    println("<dev string:x162>");
    if (newval) {
        self notify(#"emp");
        return;
    }
    self notify(#"not_emp");
}

// Namespace callback/callbacks
// Params 7, eflags: 0x0
// Checksum 0xc961f1e0, Offset: 0xf58
// Size: 0x4a
function callback_proximity(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.enemyinproximity = newval;
}

