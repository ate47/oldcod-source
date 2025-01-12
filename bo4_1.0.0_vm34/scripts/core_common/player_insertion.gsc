#using script_429c7c5a289f2b25;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\airsupport;
#using scripts\mp_common\gametypes\globallogic_audio;

#namespace player_insertion;

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x2
// Checksum 0x34cb4cc4, Offset: 0x3c0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"player_insertion", &__init__, undefined, undefined);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x838461a0, Offset: 0x408
// Size: 0x2a4
function __init__() {
    var_5823dc5c = struct::get_array("infil_spawn", "targetname");
    /#
        if (var_5823dc5c.size == 0) {
            var_5823dc5c = struct::get_array("<dev string:x30>", "<dev string:x3f>");
        }
    #/
    level.insertion = {#allowed:1, #spawnpoints:var_5823dc5c};
    callback::on_finalize_initialization(&on_finalize_initialization);
    clientfield::register("vehicle", "infiltration_transport", 1, 1, "int");
    clientfield::register("vehicle", "infiltration_landing_gear", 1, 1, "int");
    clientfield::register("toplayer", "infiltration_final_warning", 1, 1, "int");
    clientfield::register("toplayer", "infiltration_rumble", 1, 1, "int");
    clientfield::register("toplayer", "infiltration_vehicle", 1, 1, "int");
    clientfield::register("scriptmover", "infiltration_camera", 1, 2, "int");
    clientfield::register("scriptmover", "infiltration_jump_point", 1, 1, "int");
    clientfield::register("scriptmover", "infiltration_force_drop_point", 1, 1, "int");
    clientfield::register("toplayer", "heatblurpostfx", 1, 1, "int");
    level.wingsuit_hud = wz_wingsuit_hud::register("wz_wingsuit_hud");
    /#
        level thread function_b1f68ddb();
    #/
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x4
// Checksum 0xc0a8f06e, Offset: 0x6b8
// Size: 0x5f2
function private on_finalize_initialization() {
    var_9665e422 = getentarray("map_corner", "targetname");
    if (var_9665e422.size == 0) {
        return;
    }
    mins = (-100000, -100000, 0);
    maxs = (100000, 100000, 0);
    mapcenter = (0, 0, 0);
    o_a = var_9665e422[0].origin;
    o_b = var_9665e422[1].origin;
    mins = (min(o_a[0], o_b[0]), min(o_a[1], o_b[1]), -100000);
    maxs = (max(o_a[0], o_b[0]), max(o_a[1], o_b[1]), 100000);
    mapcenter = math::find_box_center(mins, maxs);
    mapwidth = function_b64da31b();
    var_71ea9bf3 = randomint(360);
    var_f8d8943e = (0, var_71ea9bf3, 0);
    direction = anglestoforward(var_f8d8943e);
    vectornormalize(direction);
    var_98b3f743 = function_5b4cc9d1();
    height = function_f7593b91();
    fly_over_point = mapcenter + (randomfloatrange(var_98b3f743[0] * -1, var_98b3f743[0]), randomfloatrange(var_98b3f743[1] * -1, var_98b3f743[1]), 0);
    fly_over_point = (fly_over_point[0], fly_over_point[1], height);
    var_fafad74b = length(var_98b3f743);
    var_773c2dfa = fly_over_point + direction * -100000;
    var_29af7d4b = fly_over_point + direction * 100000;
    result = function_55084421(var_773c2dfa, var_29af7d4b, mins, maxs);
    var_773c2dfa = result.start;
    var_29af7d4b = result.end;
    var_d26004f3 = 2640;
    var_56329911 = 10 * var_d26004f3;
    startpoint = var_773c2dfa - var_56329911 * direction;
    endpoint = var_29af7d4b + 100000 * direction;
    /#
        debug_sphere(var_773c2dfa, 75, (0, 0, 1));
        debug_sphere(var_29af7d4b, 75, (0, 0, 1));
        debug_sphere(startpoint, 75, (1, 0, 0));
        debug_sphere(endpoint, 75, (1, 0, 0));
        if (isdefined(level.insertion.debug) && level.insertion.debug == 1) {
            var_79d41d6e = var_773c2dfa + 11000 * direction;
            var_d29e052b = var_29af7d4b + -15000 * direction;
            debug_sphere(var_79d41d6e, 75, (0, 1, 0));
            debug_sphere(var_d29e052b, 75, (0, 1, 0));
        }
        debug_line(startpoint, endpoint, (1, 0, 0));
    #/
    var_b9324162 = 11000 + var_56329911;
    var_4e5c02d9 = distance(startpoint, var_29af7d4b) + -15000;
    level thread function_1940ab4b(startpoint, var_f8d8943e, var_b9324162, var_4e5c02d9);
    level.insertion.start_point = startpoint;
    level.insertion.end_point = endpoint;
    level.insertion.var_98362fe6 = var_f8d8943e;
    level.insertion.var_9319bc0e = var_b9324162;
    level.insertion.var_2eec357f = var_4e5c02d9;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x4
// Checksum 0xdd49f549, Offset: 0xcb8
// Size: 0x84
function private function_b4bb392a() {
    self val::set(#"player_insertion", "freezecontrols", 1);
    self val::set(#"hash_37b74f87edd2df20", "show_hud", 0);
    self val::set(#"hash_ce6d3e6ece6e18d", "show_weapon_hud", 0);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x4
// Checksum 0x3b0367e4, Offset: 0xd48
// Size: 0x7c
function private function_a7053fb() {
    self val::reset(#"player_insertion", "freezecontrols");
    self val::reset(#"hash_37b74f87edd2df20", "show_hud");
    self val::reset(#"hash_ce6d3e6ece6e18d", "show_weapon_hud");
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0x335a2645, Offset: 0xdd0
// Size: 0xa8
function private function_1d44cef5(activeplayers) {
    foreach (player in activeplayers) {
        if (!isdefined(player) || !isalive(player)) {
            continue;
        }
        player function_b4bb392a();
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xdea4607b, Offset: 0xe80
// Size: 0x214
function function_23ed850a() {
    /#
        if (getdvarint(#"scr_disable_infiltration", 0)) {
            return;
        }
    #/
    if (!(isdefined(level.insertion.allowed) && level.insertion.allowed)) {
        return;
    }
    level flagsys::clear(#"insertion_teleport_completed");
    level flagsys::clear(#"insertion_presentation_completed");
    level flagsys::clear(#"hash_287397edba8966f9");
    level flagsys::clear(#"hash_224cb97b8f682317");
    level thread function_7d075531(2, 2, 5);
    wait 2 + 0.1;
    activeplayers = util::get_active_players();
    level thread globallogic_audio::function_18cbfc40("spawnFull");
    level thread function_a7d963d9();
    level function_c34a44c1(activeplayers);
    level flagsys::set(#"insertion_teleport_completed");
    level flagsys::wait_till_timeout(2 + 5 + 0.5, #"insertion_presentation_completed");
}

// Namespace player_insertion/player_insertion
// Params 4, eflags: 0x0
// Checksum 0xbc74be6e, Offset: 0x10a0
// Size: 0xa78
function function_b4ebde84(activeplayers, startorigin, endorigin, var_f8d8943e) {
    self notify("1999ab3b5d227a9e");
    self endon("1999ab3b5d227a9e");
    level.insertion.cameraent = [];
    foreach (i, plane in level.insertion.var_e576c0d6) {
        if (isdefined(level.insertion.cameraent[i])) {
            level.insertion.cameraent[i] delete();
        }
        level.insertion.cameraent[i] = spawn("script_model", startorigin);
        level.insertion.cameraent[i].origin = startorigin + rotatepoint((8000, 0, 100), var_f8d8943e);
        level.insertion.cameraent[i].angles = (20, var_f8d8943e[1], var_f8d8943e[2]);
        level.insertion.cameraent[i] clientfield::set("infiltration_camera", 1);
        level.insertion.cameraent[i] setinvisibletoall();
    }
    foreach (player in activeplayers) {
        foreach (i, plane in level.insertion.var_e576c0d6) {
            if (player islinkedto(plane)) {
                level.insertion.cameraent[i] setvisibletoplayer(player);
            }
        }
        player show_postfx();
    }
    offset = (50000, 0, 0);
    foreach (i, plane in level.insertion.var_e576c0d6) {
        level.insertion.cameraent[i] moveto(level.insertion.cameraent[i].origin + rotatepoint(offset, var_f8d8943e), 50, 0, 0);
    }
    wait 3.75;
    foreach (player in activeplayers) {
        if (!isdefined(player)) {
            continue;
        }
        player playrumbleonentity(#"infiltration_rumble");
    }
    wait 1;
    foreach (player in activeplayers) {
        if (!isdefined(player)) {
            continue;
        }
        player playrumbleonentity(#"hash_233b436a07cd091a");
    }
    wait 0.2;
    foreach (player in activeplayers) {
        if (!isdefined(player)) {
            continue;
        }
        player playrumbleonentity(#"infiltration_rumble");
    }
    wait 2;
    foreach (player in activeplayers) {
        if (!isdefined(player)) {
            continue;
        }
        player playrumbleonentity(#"hash_62ba49f452a20378");
    }
    wait 2;
    foreach (i, plane in level.insertion.var_e576c0d6) {
        var_12014ee6 = plane.origin + (0, 0, 250);
        flightdirection = anglestoforward(var_f8d8943e);
        targetpos = var_12014ee6 + flightdirection * 150 * 17.6 * 4;
        level.insertion.cameraent[i] moveto(targetpos, 4, 1, 0);
        level.insertion.cameraent[i] rotateto((var_f8d8943e[0] + 15, var_f8d8943e[1], var_f8d8943e[2]), 4, 1, 1);
    }
    wait 4;
    foreach (i, plane in level.insertion.var_e576c0d6) {
        finaltargetpos = endorigin + rotatepoint((0, 0, 250), var_f8d8943e);
        timetotarget = distance(finaltargetpos, targetpos) / 2640;
        level.insertion.cameraent[i] moveto(finaltargetpos, timetotarget);
    }
    level flagsys::wait_till_timeout(0.5, #"insertion_presentation_completed");
    foreach (player in activeplayers) {
        if (!isdefined(player)) {
            continue;
        }
        player setplayerangles((var_f8d8943e[0] + 15, var_f8d8943e[1], var_f8d8943e[2]));
    }
    waitframe(1);
    foreach (i, plane in level.insertion.var_e576c0d6) {
        level.insertion.cameraent[i] clientfield::set("infiltration_camera", 2);
    }
    foreach (player in activeplayers) {
        if (!isdefined(player) || !isalive(player)) {
            continue;
        }
        player function_a7053fb();
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xc54f9ff6, Offset: 0x1b20
// Size: 0x17c
function function_9aa959c3() {
    if (getdvarint(#"scr_disable_infiltration", 0)) {
        return;
    }
    droporigin = airsupport::getrandommappoint(0, 0, 0.9, 0.9);
    if (isdefined(level.deathcircle)) {
        length = randomfloat(level.deathcircle.radius);
        random_yaw = randomintrange(0, 359);
        angles = (0, random_yaw, 0);
        forward = anglestoforward(angles);
        droporigin = level.deathcircle.origin + forward * length;
    }
    dropheight = isdefined(level.var_cb7a9114) ? level.var_cb7a9114 : 35000;
    self setorigin(droporigin + (0, 0, dropheight));
    self forcefreefall(1, (0, 0, 0));
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x0
// Checksum 0xbd494002, Offset: 0x1ca8
// Size: 0x1cc
function function_55568b45(plane, var_f8d8943e) {
    self stopanimscripted();
    self unlink();
    self setstance("stand");
    self function_d57fd073(plane, undefined, 0, 180, 180, 85, 85);
    self.health = self.spawnhealth;
    viewangles = (0, var_f8d8943e[1], 0);
    self cameraactivate(1);
    self setclientthirdperson(1);
    self setplayerangles(viewangles);
    self dontinterpolate();
    self ghost();
    self notsolid();
    self val::set(#"player_insertion", "disable_oob", 1);
    self clientfield::set_to_player("infiltration_vehicle", 1);
    level thread function_fe1e83b4(self);
    self thread function_fa214aa9(plane);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x4
// Checksum 0xb976cc8, Offset: 0x1e80
// Size: 0x76
function private function_f7593b91() {
    height = 0;
    /#
        height = getdvarint(#"hash_37d751a610a5c2fc", 0);
    #/
    if (height == 0) {
        height = isdefined(level.var_cb7a9114) ? level.var_cb7a9114 : 35000;
    }
    return height;
}

/#

    // Namespace player_insertion/player_insertion
    // Params 3, eflags: 0x0
    // Checksum 0xab24a5ab, Offset: 0x1f00
    // Size: 0x2ba
    function function_cff9f807(original_origin, var_5299593c, refly) {
        self notify("<invalid>");
        self endon("<invalid>");
        self endon(#"disconnect");
        origin = self.origin;
        origin = (original_origin[0], original_origin[1], function_f7593b91());
        self setorigin(origin);
        var_558b9aee = 0;
        var_558b9aee = getdvarint(#"hash_380d8ae5bfc8f45b", 1);
        switch (var_558b9aee) {
        case 0:
        default:
            var_71ea9bf3 = 0;
            break;
        case 1:
            var_71ea9bf3 = var_5299593c;
            break;
        case 2:
            var_71ea9bf3 = randomint(360);
            break;
        }
        var_f8d8943e = (0, var_71ea9bf3, 0);
        self setplayerangles(var_f8d8943e);
        direction = anglestoforward(var_f8d8943e);
        vectornormalize(direction);
        velocity = function_f6ff0b73(direction * 2640);
        self forcefreefall(1, velocity);
        if (refly >= 2) {
            while (true) {
                waitframe(1);
                if (self isonground() || self.origin[2] < -5000) {
                    while (self isonground() && self.origin[2] > -5000) {
                        waitframe(1);
                    }
                    self thread function_cff9f807(original_origin, var_5299593c, refly);
                    return;
                }
            }
        }
    }

#/

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0x17bf2d1a, Offset: 0x21c8
// Size: 0xd00
function private function_c34a44c1(players) {
    /#
        refly = getdvarint(#"hash_1632f4021ab7a921", 0);
        if (refly) {
            while (true) {
                players = getplayers();
                foreach (player in players) {
                    player thread function_cff9f807(player.origin, player.angles[1], refly);
                }
                return;
            }
        }
    #/
    function_1d44cef5(players);
    vehiclespawners = [];
    vehiclespawners[#"c130_spawner"] = getent("c130_spawner", "targetname");
    vehiclespawners[#"chinook_spawner"] = getent("chinook_spawner", "targetname");
    vehiclespawners[#"gunship_spawner"] = getent("gunship_spawner", "targetname");
    vehiclespawners[#"heli_infil_spawner"] = getent("heli_infil_spawner", "targetname");
    if (vehiclespawners.size == 0) {
        return 0;
    }
    foreach (player in players) {
        if (isdefined(player)) {
            player setclientuivisibilityflag("weapon_hud_visible", 0);
        }
    }
    spawner::global_spawn_throttle(1);
    if (true) {
        var_c6a814aa = vehiclespawners[#"chinook_spawner"];
    } else {
        var_c6a814aa = vehiclespawners[#"c130_spawner"];
    }
    startpoint = level.insertion.start_point;
    endpoint = level.insertion.end_point;
    var_f8d8943e = level.insertion.var_98362fe6;
    var_9319bc0e = level.insertion.var_9319bc0e;
    var_2eec357f = level.insertion.var_2eec357f;
    level.insertion.leadplane = var_c6a814aa spawnfromspawner("insertion_plane", 1, 1);
    level.insertion.leadplane.takedamage = 0;
    level.insertion.leadplane.origin = startpoint;
    level.insertion.leadplane.angles = var_f8d8943e;
    level.insertion.leadplane.passengercount = 0;
    level.insertion.var_e576c0d6 = [];
    if (!isdefined(level.insertion.var_e576c0d6)) {
        level.insertion.var_e576c0d6 = [];
    } else if (!isarray(level.insertion.var_e576c0d6)) {
        level.insertion.var_e576c0d6 = array(level.insertion.var_e576c0d6);
    }
    level.insertion.var_e576c0d6[level.insertion.var_e576c0d6.size] = level.insertion.leadplane;
    if (true) {
        level.insertion.var_24d191fa = [];
        level thread function_7d5c1aac(startpoint, endpoint, var_f8d8943e, vehiclespawners);
        level thread function_dc35ee11(startpoint, endpoint, var_f8d8943e, vehiclespawners);
        s_formation = function_a7c80813();
        for (i = 0; i < s_formation.var_5d1d7e47; i++) {
            spawner::global_spawn_throttle(1);
            rotatedstart = startpoint + rotatepoint(s_formation.var_a1ad20a[i], var_f8d8943e);
            var_7d7aa487 = vehiclespawners[s_formation.var_e4bcca4c[i]];
            vehicle = var_7d7aa487 spawnfromspawner("insertion_secondary");
            if (isdefined(vehicle)) {
                vehicle.takedamage = 0;
                vehicle.origin = rotatedstart;
                vehicle.angles = var_f8d8943e;
                vehicle.startorigin = rotatedstart;
                if (!isdefined(level.insertion.var_24d191fa)) {
                    level.insertion.var_24d191fa = [];
                } else if (!isarray(level.insertion.var_24d191fa)) {
                    level.insertion.var_24d191fa = array(level.insertion.var_24d191fa);
                }
                level.insertion.var_24d191fa[level.insertion.var_24d191fa.size] = vehicle;
                if (s_formation.var_e4bcca4c[i] == "chinook_spawner") {
                    if (!isdefined(level.insertion.var_e576c0d6)) {
                        level.insertion.var_e576c0d6 = [];
                    } else if (!isarray(level.insertion.var_e576c0d6)) {
                        level.insertion.var_e576c0d6 = array(level.insertion.var_e576c0d6);
                    }
                    level.insertion.var_e576c0d6[level.insertion.var_e576c0d6.size] = vehicle;
                }
                if (i == s_formation.var_bec669df) {
                    level.insertion.var_f334c1ff = vehicle;
                    vehicle.forwardoffset = s_formation.var_a1ad20a[i][0];
                }
            }
        }
        if (!isdefined(level.insertion.var_f334c1ff)) {
            level.insertion.var_f334c1ff = level.insertion.leadplane;
            level.insertion.var_f334c1ff.startorigin = startpoint;
            level.insertion.var_f334c1ff.endorigin = endpoint;
            level.insertion.var_f334c1ff.forwardoffset = 0;
        }
        for (i = 0; i < s_formation.var_5d1d7e47; i++) {
            rotatedend = endpoint + rotatepoint(s_formation.var_a1ad20a[i], var_f8d8943e);
            level.insertion.var_24d191fa[i].endorigin = rotatedend;
            level.insertion.var_24d191fa[i] setneargoalnotifydist(512);
            level.insertion.var_24d191fa[i] thread function_74ad4ad7(level.insertion.var_24d191fa[i].startorigin, rotatedend, var_f8d8943e, s_formation.hoverparams[i], s_formation.var_128027c5[i]);
        }
    } else {
        level.insertion.var_f334c1ff = level.insertion.leadplane;
        level.insertion.var_f334c1ff.startorigin = startpoint;
        level.insertion.var_f334c1ff.endorigin = endpoint;
        level.insertion.var_f334c1ff.forwardoffset = 0;
    }
    level.insertion.leadplane setneargoalnotifydist(512);
    var_c2f2d38d = (0, 16, 16);
    level.insertion.leadplane thread function_74ad4ad7(startpoint, endpoint, var_f8d8943e, var_c2f2d38d, 2);
    foreach (player in players) {
        if (isdefined(player) && isalive(player)) {
            level.insertion.leadplane.passengercount++;
            teammask = getteammask(player.team);
            for (teamindex = 0; teammask > 1; teamindex++) {
                teammask >>= 1;
            }
            planeindex = teamindex % level.insertion.var_e576c0d6.size;
            player function_55568b45(level.insertion.var_e576c0d6[planeindex], var_f8d8943e);
        }
    }
    level thread function_fc8393d8(level.insertion.leadplane, startpoint, endpoint, var_2eec357f);
    level thread function_1cdd7a8c(level.insertion.var_f334c1ff, level.insertion.var_f334c1ff.startorigin, level.insertion.var_f334c1ff.endorigin, var_9319bc0e + level.insertion.var_f334c1ff.forwardoffset);
    level thread function_b4ebde84(players, startpoint, endpoint, var_f8d8943e);
    function_1d44cef5(players);
    return 1;
}

// Namespace player_insertion/player_insertion
// Params 4, eflags: 0x0
// Checksum 0x689d30d1, Offset: 0x2ed0
// Size: 0x14c
function function_1940ab4b(start_point, var_f8d8943e, var_9319bc0e, var_4e5c02d9) {
    direction = anglestoforward(var_f8d8943e);
    level.insertion.var_dbba4a4c = spawn("script_model", start_point + direction * var_9319bc0e);
    level.insertion.var_dbba4a4c.angles = var_f8d8943e;
    level.insertion.var_8b0f91db = spawn("script_model", start_point + direction * var_4e5c02d9);
    level.insertion.var_8b0f91db.angles = var_f8d8943e;
    waitframe(1);
    level.insertion.var_dbba4a4c clientfield::set("infiltration_jump_point", 1);
    level.insertion.var_8b0f91db clientfield::set("infiltration_force_drop_point", 1);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x8000da31, Offset: 0x3028
// Size: 0xad2
function function_a7c80813() {
    a_formations = [];
    s_formation = {#var_5d1d7e47:5, #var_e4bcca4c:array("gunship_spawner", "gunship_spawner", "gunship_spawner", "gunship_spawner", "chinook_spawner"), #var_a1ad20a:array((2750, -550, 0), (2000, -1200, 0), (1500, 750, 0), (500, 1500, 0), (-900, -700, 0)), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192), (0, 24, 128)), #var_128027c5:array(2, 2, 2, 2, 2), #var_bec669df:4, #alignment:"left"};
    if (!isdefined(a_formations)) {
        a_formations = [];
    } else if (!isarray(a_formations)) {
        a_formations = array(a_formations);
    }
    a_formations[a_formations.size] = s_formation;
    s_formation = {#var_5d1d7e47:5, #var_e4bcca4c:array("gunship_spawner", "gunship_spawner", "gunship_spawner", "gunship_spawner", "chinook_spawner"), #var_a1ad20a:array((2750, 550, 0), (2000, 1200, 0), (1500, -750, 0), (500, -1500, 0), (-900, 700, 0)), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192), (0, 24, 128)), #var_128027c5:array(2, 2, 2, 2, 2), #var_bec669df:4, #alignment:"right"};
    if (!isdefined(a_formations)) {
        a_formations = [];
    } else if (!isarray(a_formations)) {
        a_formations = array(a_formations);
    }
    a_formations[a_formations.size] = s_formation;
    s_formation = {#var_5d1d7e47:5, #var_e4bcca4c:array("gunship_spawner", "gunship_spawner", "gunship_spawner", "gunship_spawner", "chinook_spawner"), #var_a1ad20a:array((2750, -900, 0), (2000, 100, 0), (1250, 1100, 0), (500, 2100, 0), (-900, -700, 0)), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192), (0, 24, 128)), #var_128027c5:array(2, 2, 2, 2, 2), #var_bec669df:4, #alignment:"left"};
    if (!isdefined(a_formations)) {
        a_formations = [];
    } else if (!isarray(a_formations)) {
        a_formations = array(a_formations);
    }
    a_formations[a_formations.size] = s_formation;
    s_formation = {#var_5d1d7e47:5, #var_e4bcca4c:array("gunship_spawner", "gunship_spawner", "gunship_spawner", "gunship_spawner", "chinook_spawner"), #var_a1ad20a:array((2750, 900, 0), (2000, -100, 0), (1500, -1100, 0), (500, -2100, 0), (-900, 700, 0)), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192), (0, 24, 128)), #var_128027c5:array(2, 2, 2, 2, 2), #var_bec669df:4, #alignment:"right"};
    if (!isdefined(a_formations)) {
        a_formations = [];
    } else if (!isarray(a_formations)) {
        a_formations = array(a_formations);
    }
    a_formations[a_formations.size] = s_formation;
    /#
        index = getdvarint(#"hash_5293cadde39a7ceb", -1);
        if (index > -1) {
            if (isdefined(a_formations[index])) {
                return a_formations[index];
            }
        }
    #/
    var_a1ad20a[#"left"] = array((1200, -2300, 0), (-200, -2300, 0), (-1600, -2300, 0), (-3000, -2300, 0));
    var_a1ad20a[#"right"] = array((1200, 2300, 0), (-200, 2300, 0), (-1600, 2300, 0), (-3000, 2300, 0));
    var_623b0c3d = {#var_5d1d7e47:4, #var_e4bcca4c:array("gunship_spawner", "gunship_spawner", "gunship_spawner", "gunship_spawner"), #hoverparams:array((192, 192, 192), (192, 192, 192), (192, 192, 192), (192, 192, 192)), #var_128027c5:array(2, 2, 2, 2)};
    s_formation = array::random(a_formations);
    s_formation.var_5d1d7e47 += var_623b0c3d.var_5d1d7e47;
    s_formation.var_e4bcca4c = arraycombine(s_formation.var_e4bcca4c, var_623b0c3d.var_e4bcca4c, 1, 0);
    s_formation.var_a1ad20a = arraycombine(s_formation.var_a1ad20a, var_a1ad20a[s_formation.alignment], 1, 0);
    s_formation.hoverparams = arraycombine(s_formation.hoverparams, var_623b0c3d.hoverparams, 1, 0);
    s_formation.var_128027c5 = arraycombine(s_formation.var_128027c5, var_623b0c3d.var_128027c5, 1, 0);
    return s_formation;
}

// Namespace player_insertion/player_insertion
// Params 4, eflags: 0x0
// Checksum 0xa8d9f14b, Offset: 0x3b08
// Size: 0x1e4
function function_7d5c1aac(startpoint, endpoint, var_f8d8943e, vehiclespawners) {
    offset = (500, -50, 600);
    goaloffset = (0, 0, -400);
    rotatedstart = startpoint + rotatepoint(offset, var_f8d8943e);
    var_932437df = vehiclespawners[#"heli_infil_spawner"];
    level.var_3efe7312 = var_932437df spawnfromspawner("insertion_presentation");
    level.var_3efe7312.origin = rotatedstart;
    level.var_3efe7312.angles = var_f8d8943e;
    level.var_3efe7312.startorigin = rotatedstart;
    rotatedend = endpoint + rotatepoint(goaloffset, var_f8d8943e);
    level.var_3efe7312.endorigin = rotatedend;
    wait 0.5;
    level.var_3efe7312 setrotorspeed(1);
    level.var_3efe7312 setspeedimmediate(175);
    level.var_3efe7312 setneargoalnotifydist(512);
    level.var_3efe7312 vehlookat(rotatedend);
    level.var_3efe7312 function_3c8dce03(rotatedend, 0, 0);
}

// Namespace player_insertion/player_insertion
// Params 4, eflags: 0x0
// Checksum 0x146c9cfa, Offset: 0x3cf8
// Size: 0x34e
function function_dc35ee11(startpoint, endpoint, var_f8d8943e, vehiclespawners) {
    offset = array((500, -100, 800), (500, 100, 800));
    goaloffset = array((0, 60000, -10000), (0, -60000, -10000));
    var_6b44e083 = array("heli_infil_spawner", "heli_infil_spawner");
    level.var_1c39adf3 = [];
    for (i = 0; i < 2; i++) {
        waitframe(1);
        rotatedstart = startpoint + rotatepoint(offset[i], var_f8d8943e);
        var_932437df = vehiclespawners[var_6b44e083[i]];
        vehicle = var_932437df spawnfromspawner("insertion_presentation");
        vehicle.origin = rotatedstart;
        vehicle.angles = var_f8d8943e;
        vehicle.startorigin = rotatedstart;
        if (!isdefined(level.var_1c39adf3)) {
            level.var_1c39adf3 = [];
        } else if (!isarray(level.var_1c39adf3)) {
            level.var_1c39adf3 = array(level.var_1c39adf3);
        }
        level.var_1c39adf3[level.var_1c39adf3.size] = vehicle;
        waitframe(1);
    }
    for (i = 0; i < 2; i++) {
        rotatedend = endpoint + rotatepoint(goaloffset[i], var_f8d8943e);
        level.var_1c39adf3[i].endorigin = rotatedend;
        level.var_1c39adf3[i] setrotorspeed(1);
        level.var_1c39adf3[i] setspeedimmediate(2);
        level.var_1c39adf3[i] setneargoalnotifydist(512);
        level.var_1c39adf3[i] thread function_a378f489(level.var_1c39adf3[i].startorigin, rotatedend, var_f8d8943e, goaloffset[i][1], i);
    }
}

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x0
// Checksum 0xe5ce0937, Offset: 0x4050
// Size: 0x33c
function function_a378f489(startorigin, endorigin, var_f8d8943e, goal, index) {
    self endon(#"death");
    dist = distance2d(endorigin, startorigin) / 3;
    offset = (dist / 2, math::sign(goal) * 1000, -1000);
    firstgoal = startorigin + rotatepoint(offset, var_f8d8943e);
    offset = (dist / 2, math::sign(goal) * 1000, -1000);
    var_5c4c6228 = firstgoal + rotatepoint(offset, var_f8d8943e);
    /#
        if (getdvarint(#"hash_5bbd3d044e1ec1b8", 0)) {
            self thread function_6d91ef46(firstgoal, var_5c4c6228, endorigin, index);
        }
    #/
    wait 0.25;
    self setrotorspeed(1);
    self setspeedimmediate(2);
    self vehlookat(firstgoal);
    self function_3c8dce03(firstgoal, 0, 0);
    if (index > 0) {
        wait 0.75;
    }
    self setspeedimmediate(120);
    self thread function_2ad6570b();
    self waittill(#"goal", #"near_goal");
    self vehlookat(var_5c4c6228);
    self function_3c8dce03(var_5c4c6228, 0, 0);
    self waittill(#"goal", #"near_goal");
    self vehlookat(endorigin);
    self function_3c8dce03(endorigin, 0, 0);
    self setspeed(250);
    self waittill(#"goal", #"near_goal");
    self delete();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xe99549d3, Offset: 0x4398
// Size: 0x3c
function function_2ad6570b() {
    wait 4;
    level notify(#"formation_start");
    self setspeed(150);
}

/#

    // Namespace player_insertion/player_insertion
    // Params 4, eflags: 0x0
    // Checksum 0x5398263, Offset: 0x43e0
    // Size: 0x126
    function function_6d91ef46(firstgoal, var_5c4c6228, endorigin, index) {
        self endon(#"death");
        while (getdvarint(#"hash_5bbd3d044e1ec1b8", 0)) {
            color = index < 0 ? (0, 0, 1) : (1, 0, 0);
            sphere(firstgoal, 700, color);
            sphere(var_5c4c6228, 700, color);
            sphere(endorigin, 700, color);
            line(firstgoal, var_5c4c6228, color);
            line(var_5c4c6228, endorigin, color);
            waitframe(1);
        }
    }

#/

// Namespace player_insertion/player_insertion
// Params 5, eflags: 0x0
// Checksum 0xc39c1124, Offset: 0x4510
// Size: 0x244
function function_74ad4ad7(startorigin, endorigin, var_f8d8943e, offsetvec, var_148a6679) {
    self endon(#"death");
    self setspeedimmediate(5);
    self setrotorspeed(1);
    self function_3c8dce03(endorigin, 0, 0);
    level waittill(#"formation_start");
    self setspeedimmediate(150);
    if (true) {
        direction = anglestoforward(var_f8d8943e);
        distance = distance(endorigin, startorigin);
        var_9a39e9cd = int(distance) / 5000;
        remainingdist = int(distance) % 5000;
        for (i = 1; i <= var_9a39e9cd; i++) {
            self pathvariableoffset(offsetvec * (var_9a39e9cd - i + 1), var_148a6679);
            self function_3704ae85(startorigin, distance, i * 5000 / distance);
        }
        if (remainingdist > 0) {
            self pathvariableoffset(offsetvec, var_148a6679);
        }
    }
    self waittill(#"goal", #"near_goal");
    self delete();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xed4c371e, Offset: 0x4760
// Size: 0x70
function function_af3c10c2() {
    var_9665e422 = getentarray("map_corner", "targetname");
    if (var_9665e422.size) {
        return math::find_box_center(var_9665e422[0].origin, var_9665e422[1].origin);
    }
    return (0, 0, 0);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x59fa8da5, Offset: 0x47d8
// Size: 0x118
function function_b64da31b() {
    var_9665e422 = getentarray("map_corner", "targetname");
    if (var_9665e422.size) {
        x = abs(var_9665e422[0].origin[0] - var_9665e422[1].origin[0]);
        y = abs(var_9665e422[0].origin[1] - var_9665e422[1].origin[1]);
        max_width = max(x, y);
        max_width *= 0.75;
        return math::clamp(max_width, 10000, max_width);
    }
    return 10000;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xa98dabea, Offset: 0x48f8
// Size: 0xe8
function function_5b4cc9d1() {
    var_9665e422 = getentarray("map_corner", "targetname");
    if (var_9665e422.size) {
        x = abs(var_9665e422[0].origin[0] - var_9665e422[1].origin[0]);
        y = abs(var_9665e422[0].origin[1] - var_9665e422[1].origin[1]);
        return (x * 0.2, y * 0.2, 0);
    }
    return (0, 0, 0);
}

/#

    // Namespace player_insertion/player_insertion
    // Params 0, eflags: 0x4
    // Checksum 0x60368f78, Offset: 0x49e8
    // Size: 0x64
    function private function_6bb23905() {
        time = getdvarfloat(#"hash_102dc944a54c88d9", 0);
        if (time) {
            wait time;
            level flagsys::set(#"hash_224cb97b8f682317");
        }
    }

#/

// Namespace player_insertion/player_insertion
// Params 3, eflags: 0x0
// Checksum 0x19f86bc7, Offset: 0x4a58
// Size: 0x7c
function function_3704ae85(startpoint, total_distance, delta_t) {
    while (true) {
        current_distance = distance(startpoint, self.origin);
        current_t = current_distance / total_distance;
        if (current_t > delta_t) {
            return;
        }
        waitframe(1);
    }
}

// Namespace player_insertion/player_insertion
// Params 4, eflags: 0x4
// Checksum 0x6616aff7, Offset: 0x4ae0
// Size: 0x524
function private function_fc8393d8(plane, startpoint, endpoint, var_fb8b9bb7) {
    self notify("3ca05682739710a7");
    self endon("3ca05682739710a7");
    plane endon(#"death");
    foreach (vehicle in level.insertion.var_e576c0d6) {
        vehicle clientfield::set("infiltration_landing_gear", 1);
        vehicle setrotorspeed(1);
    }
    var_76d177e5 = 5 * 2640;
    total_distance = distance(startpoint, endpoint);
    assert(total_distance > var_fb8b9bb7);
    assert(var_fb8b9bb7 - var_76d177e5 > 0);
    assert(total_distance > var_fb8b9bb7 - var_76d177e5);
    var_bc3b3808 = (var_fb8b9bb7 - var_76d177e5) / total_distance;
    end_t = var_fb8b9bb7 / total_distance;
    /#
        level thread function_6bb23905();
    #/
    plane function_3704ae85(startpoint, total_distance, var_bc3b3808);
    /#
        debug_sphere(plane.origin, 75, (0, 1, 1));
    #/
    activeplayers = util::get_active_players();
    foreach (player in activeplayers) {
        if (!isdefined(player) || isdefined(player.var_66961c6f) && player.var_66961c6f) {
            continue;
        }
        player clientfield::set_to_player("infiltration_final_warning", 1);
    }
    plane function_3704ae85(startpoint, total_distance, end_t);
    /#
        debug_sphere(plane.origin, 75, (0, 1, 1));
    #/
    level flagsys::set(#"hash_224cb97b8f682317");
    wait 1;
    foreach (vehicle in level.insertion.var_e576c0d6) {
        vehicle clientfield::set("infiltration_transport", 0);
    }
    foreach (i, plane in level.insertion.var_e576c0d6) {
        if (isdefined(level.insertion.cameraent[i])) {
            level.insertion.cameraent[i] delete();
        }
    }
    if (isdefined(level.insertion.var_dbba4a4c)) {
        level.insertion.var_dbba4a4c delete();
    }
    if (isdefined(level.insertion.var_8b0f91db)) {
        level.insertion.var_8b0f91db delete();
    }
}

// Namespace player_insertion/player_insertion
// Params 4, eflags: 0x4
// Checksum 0x24301181, Offset: 0x5010
// Size: 0x224
function private function_1cdd7a8c(plane, startpoint, endpoint, var_2c652c9d) {
    self notify("4df493e75a83f223");
    self endon("4df493e75a83f223");
    plane endon(#"death");
    var_ee01ce68 = 0.6 * 2640;
    total_distance = distance(startpoint, endpoint);
    assert(total_distance > var_2c652c9d);
    assert(var_2c652c9d - var_ee01ce68 > 0);
    assert(total_distance > var_2c652c9d - var_ee01ce68);
    cargo_t = (var_2c652c9d - var_ee01ce68) / total_distance;
    start_t = var_2c652c9d / total_distance;
    plane function_3704ae85(startpoint, total_distance, cargo_t);
    /#
        debug_sphere(plane.origin, 75, (0, 1, 1));
    #/
    level thread function_403181ea();
    voiceevent("warBoostInfiltration");
    plane function_3704ae85(startpoint, total_distance, start_t);
    /#
        debug_sphere(plane.origin, 75, (0, 1, 1));
    #/
    level flagsys::set(#"hash_287397edba8966f9");
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x970171e4, Offset: 0x5240
// Size: 0x130
function function_403181ea() {
    foreach (player in getplayers()) {
        if (isdefined(player)) {
            player.var_66961c6f = 0;
        }
    }
    foreach (vehicle in level.insertion.var_e576c0d6) {
        vehicle clientfield::set("infiltration_transport", 1);
        wait randomfloatrange(0.5, 1);
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x38d5fb44, Offset: 0x5378
// Size: 0xac
function function_b0694b99() {
    if (!level flagsys::get(#"hash_287397edba8966f9")) {
        var_3e09375c = [#"hash_287397edba8966f9", #"hash_224cb97b8f682317"];
        level flagsys::wait_till_any(var_3e09375c);
    }
    if (!level flagsys::get(#"hash_224cb97b8f682317")) {
        wait randomfloatrange(1, 30);
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x940dbac1, Offset: 0x5430
// Size: 0x180
function function_cd931897() {
    if (isbot(self)) {
        self function_b0694b99();
        return;
    }
    while (true) {
        waitframe(1);
        if (level flagsys::get(#"hash_287397edba8966f9") && isdefined(level.insertionpassenger) && isdefined(level.var_b9dc7c68) && isdefined(level.var_baf14e0) && isdefined(level.var_2fd944bd) && !level.insertionpassenger [[ level.var_baf14e0 ]](self)) {
            level.insertionpassenger [[ level.var_b9dc7c68 ]](self, 0);
            level.insertionpassenger [[ level.var_2fd944bd ]](self, level.insertion.leadplane.passengercount);
        }
        if (level flagsys::get(#"hash_224cb97b8f682317") || level flagsys::get(#"hash_287397edba8966f9") && self usebuttonpressed()) {
            return;
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x1e4e6eca, Offset: 0x55b8
// Size: 0xbc
function function_fea46e3d(plane) {
    if (isplayer(self) && isdefined(plane)) {
        self match_record::function_de67a991(#"hash_1657e02fb5073e4a", plane.origin);
        self match_record::set_player_stat(#"hash_16618233fdac5c29", gettime());
        self match_record::set_player_stat(#"hash_63b95d780b2bd355", level flagsys::get(#"hash_224cb97b8f682317"));
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0xcd1b0c84, Offset: 0x5680
// Size: 0x1cc
function function_fe1e83b4(var_adb3d9cd) {
    if (isdefined(level.insertion.leadplane)) {
        level.insertion.leadplane endon(#"death");
    }
    waitresult = var_adb3d9cd waittill(#"disconnect", #"player_jumped");
    if (isdefined(level.insertion.leadplane)) {
        level.insertion.leadplane.passengercount--;
        if (isdefined(level.insertionpassenger) && isdefined(level.var_baf14e0) && isdefined(level.var_2fd944bd)) {
            foreach (player in getplayers()) {
                if (player === var_adb3d9cd && waitresult._notify == #"disconnect") {
                    continue;
                }
                if (level.insertionpassenger [[ level.var_baf14e0 ]](player)) {
                    level.insertionpassenger [[ level.var_2fd944bd ]](player, level.insertion.leadplane.passengercount);
                }
            }
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0xbab7a68c, Offset: 0x5858
// Size: 0x1d4
function function_fa214aa9(aircraft) {
    self notify("4654d42114641495");
    self endon("4654d42114641495");
    self endon(#"disconnect");
    self endon(#"death");
    self function_cd931897();
    self function_fea46e3d(aircraft);
    self startcameratween(0.5);
    util::wait_network_frame();
    self cameraactivate(0);
    self setclientthirdperson(0);
    self show();
    self solid();
    self val::set(#"player_insertion", "disable_oob", 0);
    self clientfield::set_to_player("infiltration_vehicle", 0);
    if (isdefined(level.insertionpassenger) && isdefined(level.var_38dff31c)) {
        level.insertionpassenger [[ level.var_38dff31c ]](self);
    }
    self thread player_freefall(aircraft);
    self hide_postfx();
    self stoprumble(#"hash_233b436a07cd091a");
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x39c6bb19, Offset: 0x5a38
// Size: 0x58
function function_f6ff0b73(velocity) {
    speed = 1584;
    var_91e36ef3 = (10, self.angles[1], 0);
    return anglestoforward(var_91e36ef3) * speed;
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x2c0a19d9, Offset: 0x5a98
// Size: 0x184
function player_freefall(aircraft) {
    self notify("37be5b070dc033b4");
    self endon("37be5b070dc033b4");
    self endon(#"disconnect");
    self notify(#"player_jumped");
    lateraloffset = (0, 0, 0);
    if (isdefined(aircraft)) {
        var_778d0ebd = anglestoright(aircraft.angles);
        lateraloffset = var_778d0ebd * randomfloatrange(-512, 512);
    }
    self unlink();
    self setorigin(self.origin - (0, 0, 512) + lateraloffset);
    velocity = function_f6ff0b73(aircraft getvelocity());
    self forcefreefall(1, velocity);
    self.var_66961c6f = 1;
    self hud_message::clearlowermessage();
    self thread function_d060ba13();
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x28de9a10, Offset: 0x5c28
// Size: 0x64
function function_c8154ad() {
    if (isplayer(self)) {
        self match_record::function_de67a991(#"hash_7d9d379ecba10793", self.origin);
        self match_record::set_player_stat(#"hash_1469faf3180d8b7a", gettime());
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x88431090, Offset: 0x5c98
// Size: 0x58
function function_9513d1b1() {
    self waittill(#"hash_3c5c9df8543f9398", #"disconnect", #"death");
    if (isdefined(self)) {
        [[ level.wingsuit_hud ]]->close(self);
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x55dddef0, Offset: 0x5cf8
// Size: 0xbc
function function_d060ba13() {
    self endon(#"disconnect", #"death");
    [[ level.wingsuit_hud ]]->open(self);
    self thread function_9513d1b1();
    while (self isinfreefall()) {
        waitframe(1);
    }
    self function_c8154ad();
    self notify(#"hash_3c5c9df8543f9398");
    self setclientuivisibilityflag("weapon_hud_visible", 1);
}

// Namespace player_insertion/player_insertion
// Params 3, eflags: 0x4
// Checksum 0x9ac65b88, Offset: 0x5dc0
// Size: 0x394
function private function_7d075531(fadeouttime, blacktime, fadeintime) {
    activeplayers = util::get_active_players();
    if (isdefined(lui::get_luimenu("FullScreenBlack"))) {
        lui_menu = lui::get_luimenu("FullScreenBlack");
    } else {
        level flagsys::set(#"insertion_presentation_completed");
        return;
    }
    foreach (player in activeplayers) {
        if (isdefined(player)) {
            [[ lui_menu ]]->open(player);
            [[ lui_menu ]]->set_startalpha(player, 0);
            [[ lui_menu ]]->set_endalpha(player, 1);
            [[ lui_menu ]]->set_fadeovertime(player, int(fadeouttime * 1000));
        }
    }
    wait fadeouttime + blacktime;
    level flagsys::wait_till_timeout(2, #"insertion_teleport_completed");
    foreach (player in activeplayers) {
        player playrumbleonentity(#"infiltration_rumble");
    }
    foreach (player in activeplayers) {
        if (isdefined(player)) {
            [[ lui_menu ]]->open(player);
            [[ lui_menu ]]->set_startalpha(player, 1);
            [[ lui_menu ]]->set_endalpha(player, 0);
            [[ lui_menu ]]->set_fadeovertime(player, int(fadeintime * 1000));
        }
    }
    wait fadeintime;
    foreach (player in activeplayers) {
        if (isdefined(player)) {
            [[ lui_menu ]]->close(player);
        }
    }
    level flagsys::set(#"insertion_presentation_completed");
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0x2746d9c3, Offset: 0x6160
// Size: 0x88
function private function_b7c1684c(players) {
    foreach (player in players) {
        if (!isbot(player)) {
            return player;
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x58cbc414, Offset: 0x61f0
// Size: 0x52
function function_9d75b2d0() {
    if (level flagsys::get(#"hash_287397edba8966f9") && !level flagsys::get(#"hash_224cb97b8f682317")) {
        return true;
    }
    return false;
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x4
// Checksum 0xa5ec0aa2, Offset: 0x6250
// Size: 0xda
function private function_a7d963d9() {
    a_start_buttons = getentarray("game_start_button", "script_noteworthy");
    array::delete_all(a_start_buttons);
    if (isdefined(level.var_4f623545)) {
        foreach (object in level.var_4f623545) {
            object gameobjects::destroy_object(1);
        }
        level.var_4f623545 = undefined;
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xfa63b487, Offset: 0x6338
// Size: 0x24
function show_postfx() {
    self clientfield::set_to_player("heatblurpostfx", 1);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x97e21b52, Offset: 0x6368
// Size: 0x24
function hide_postfx() {
    self clientfield::set_to_player("heatblurpostfx", 0);
}

/#

    // Namespace player_insertion/player_insertion
    // Params 5, eflags: 0x4
    // Checksum 0x6ca3c807, Offset: 0x6398
    // Size: 0x134
    function private debug_sphere(origin, radius, color, alpha, time) {
        if (!isdefined(alpha)) {
            alpha = 1;
        }
        if (!isdefined(time)) {
            time = 2000;
        }
        level.insertion.debug = getdvarint(#"hash_4eb38a8b164a9640", 0);
        if (isdefined(level.insertion.debug) && level.insertion.debug == 1) {
            if (!isdefined(color)) {
                color = (1, 1, 1);
            }
            sides = int(10 * (1 + int(radius / 100)));
            sphere(origin, radius, color, alpha, 1, sides, time);
        }
    }

    // Namespace player_insertion/player_insertion
    // Params 5, eflags: 0x0
    // Checksum 0x16c1136e, Offset: 0x64d8
    // Size: 0x104
    function debug_line(from, to, color, time, depthtest) {
        if (!isdefined(time)) {
            time = 2000;
        }
        if (!isdefined(depthtest)) {
            depthtest = 1;
        }
        level.insertion.debug = getdvarint(#"hash_4eb38a8b164a9640", 0);
        if (isdefined(level.insertion.debug) && level.insertion.debug == 1) {
            if (distancesquared(from, to) < 0.01) {
                return;
            }
            line(from, to, color, 1, depthtest, time);
        }
    }

    // Namespace player_insertion/player_insertion
    // Params 0, eflags: 0x4
    // Checksum 0xe93cd3b3, Offset: 0x65e8
    // Size: 0x190
    function private function_b1f68ddb() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x5b>" + mapname + "<dev string:x69>");
        waitframe(1);
        adddebugcommand("<dev string:x5b>" + mapname + "<dev string:xb9>");
        waitframe(1);
        adddebugcommand("<dev string:x5b>" + mapname + "<dev string:x105>");
        while (true) {
            waitframe(1);
            string = getdvarstring(#"hash_683dafe2da41b42e", "<dev string:x15b>");
            start_insertion = 0;
            switch (string) {
            case #"start_insertion":
                start_insertion = 1;
                break;
            default:
                break;
            }
            if (start_insertion) {
                level function_23ed850a();
            }
            setdvar(#"hash_683dafe2da41b42e", "<dev string:x15b>");
        }
    }

#/
