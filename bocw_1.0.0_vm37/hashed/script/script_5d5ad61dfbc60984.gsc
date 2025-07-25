#using script_335d0650ed05d36d;
#using script_b9a55edd207e4ca;
#using scripts\core_common\array_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\vehicle_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_utils;

#namespace namespace_3f3933bc;

// Namespace namespace_3f3933bc/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x69095ac4, Offset: 0x300
// Size: 0x1fc
function event_handler[gametype_init] main(*eventstruct) {
    namespace_2938acdc::init();
    function_2c1beb43();
    spawning::addsupportedspawnpointtype("ctf");
    level.var_d98635d9 = [];
    level.planttime = getgametypesetting(#"planttime");
    level.defusetime = getgametypesetting(#"defusetime");
    level.bombtimer = getgametypesetting(#"bombtimer");
    level.missileoffset = (-175, 0, 40);
    setdvar(#"originoffset_x", -175);
    setdvar(#"originoffset_y", 0);
    setdvar(#"originoffset_z", 40);
    setdvar(#"anglesoffset_x", 78);
    setdvar(#"anglesoffset_y", 0);
    setdvar(#"anglesoffset_z", 0);
    setdvar(#"hash_75bbabbef2106dda", 0.19);
    /#
        thread function_13bb0660();
    #/
}

/#

    // Namespace namespace_3f3933bc/namespace_3f3933bc
    // Params 1, eflags: 0x0
    // Checksum 0xbd2ad397, Offset: 0x508
    // Size: 0x174
    function function_59ce3baf(points) {
        println("<dev string:x38>");
        foreach (point in points) {
            println("<dev string:x8a>" + point.origin[0] + "<dev string:x8f>" + point.origin[1] + "<dev string:x8f>" + point.origin[2] + "<dev string:x95>" + point.angles[0] + "<dev string:x8f>" + point.angles[1] + "<dev string:x8f>" + point.angles[2] + "<dev string:x9e>");
        }
        println("<dev string:xa3>");
    }

    // Namespace namespace_3f3933bc/namespace_3f3933bc
    // Params 0, eflags: 0x0
    // Checksum 0xda1a51b0, Offset: 0x688
    // Size: 0x132
    function function_13bb0660() {
        var_45724e62 = [];
        jumppressed = 0;
        while (!isdefined(level.players) || level.players.size == 0) {
            waitframe(1);
        }
        me = level.players[0];
        while (true) {
            if (me jumpbuttonpressed() && !jumppressed) {
                jumppressed = 1;
                point = spawnstruct();
                point.origin = me.origin;
                point.angles = me.angles;
                var_45724e62[var_45724e62.size] = point;
                function_59ce3baf(var_45724e62);
            } else if (!me jumpbuttonpressed() && jumppressed) {
                jumppressed = 0;
            }
            waitframe(1);
        }
    }

#/

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 0, eflags: 0x0
// Checksum 0x8020c1e4, Offset: 0x7c8
// Size: 0x1ca
function function_4427fb0e() {
    while (true) {
        var_38ae3e91 = (getdvarfloat(#"originoffset_x", 0), getdvarfloat(#"originoffset_y", 0), getdvarfloat(#"originoffset_z", 0));
        currentangles = (getdvarfloat(#"anglesoffset_x", 0), getdvarfloat(#"anglesoffset_y", 0), getdvarfloat(#"anglesoffset_z", 0));
        foreach (var_8a15325a in level.var_d98635d9) {
            missile = var_8a15325a.var_974e7341;
            missile setscale(getdvarfloat(#"hash_75bbabbef2106dda", 0.12));
            missile linktoupdateoffset(var_38ae3e91, currentangles);
        }
        waitframe(1);
    }
}

// Namespace namespace_3f3933bc/gametype_start
// Params 1, eflags: 0x40
// Checksum 0xf8198d4f, Offset: 0x9a0
// Size: 0x3c
function event_handler[gametype_start] startgametype(*eventstruct) {
    function_ba34436e();
    function_38411346();
    function_e23fea8c();
}

// Namespace namespace_3f3933bc/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0x384a772d, Offset: 0x9e8
// Size: 0x1c
function event_handler[event_cc819519] level_finalizeinit(*eventstruct) {
    level.alwaysusestartspawns = 1;
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 0, eflags: 0x0
// Checksum 0x450345dc, Offset: 0xa10
// Size: 0xa0
function function_ba34436e() {
    var_5f5158cd = struct::get_array("icbm_truck_spawn", "targetname");
    if (isdefined(var_5f5158cd) || var_5f5158cd.size == 0) {
        var_5f5158cd = level.var_9fa97bd9;
    }
    if (isdefined(var_5f5158cd)) {
        for (index = 0; index < var_5f5158cd.size; index++) {
            level.var_d98635d9[index] = function_d33f46a4(var_5f5158cd[index], index);
        }
    }
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 3, eflags: 0x0
// Checksum 0xd603e14a, Offset: 0xab8
// Size: 0x94
function function_def22e6(vehiclename, vehicleorigin, vehicleangles) {
    if (!isdefined(level.var_ed091a74)) {
        level.var_ed091a74 = [];
    }
    var_f673e666 = spawnstruct();
    var_f673e666.def = vehiclename;
    var_f673e666.origin = vehicleorigin;
    var_f673e666.angles = vehicleangles;
    level.var_ed091a74[level.var_ed091a74.size] = var_f673e666;
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 0, eflags: 0x0
// Checksum 0xb3dd4c2f, Offset: 0xb58
// Size: 0xc0
function function_38411346() {
    foreach (spawnpoint in level.var_ed091a74) {
        vehicle = spawnvehicle(spawnpoint.def, spawnpoint.origin, spawnpoint.angles);
        vehicle makeusable();
    }
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 1, eflags: 0x0
// Checksum 0x3cec80c6, Offset: 0xc20
// Size: 0x6c
function function_9e4ca5a0(vehicle) {
    vehicle vehicle::toggle_tread_fx(0);
    vehicle vehicle::toggle_exhaust_fx(0);
    vehicle vehicle::toggle_sounds(0);
    vehicle vehicle::lights_off();
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 8, eflags: 0x0
// Checksum 0x799ec171, Offset: 0xc98
// Size: 0x23c
function function_e63cb1e4(*einflictor, *eattacker, *idamage, *smeansofdeath, *weapon, *vdir, *shitloc, *psoffsettime) {
    level endon(#"game_ended");
    function_9e4ca5a0(self);
    objective_delete(self.var_b09e50c3);
    gameobjects::release_obj_id(self.var_b09e50c3);
    self.var_b09e50c3 = undefined;
    if (isdefined(self.var_31cac59e)) {
        self.var_31cac59e gameobjects::disable_object(1, 1, 0, 1);
        self.var_31cac59e = undefined;
    } else if (isdefined(self.var_643933de)) {
        self.var_643933de gameobjects::disable_object(1, 1, 0, 1);
        self.var_643933de = undefined;
    }
    arrayremovevalue(level.var_d98635d9, self);
    arrayremovevalue(level.var_d98635d9, undefined, 0);
    var_930c4da9 = 1;
    if (level.var_d98635d9.size != 0) {
        foreach (truck in level.var_d98635d9) {
            if (isdefined(truck.var_31cac59e)) {
                var_930c4da9 = 0;
                break;
            }
        }
    }
    if (var_930c4da9 == 1) {
        globallogic::function_a3e3bd39(game.defenders, 1);
    }
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 12, eflags: 0x0
// Checksum 0x1c42cd67, Offset: 0xee0
// Size: 0x7a
function function_67d3750a(*einflictor, *eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *iboneindex, *imodelindex) {
    return int(imodelindex);
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 0, eflags: 0x0
// Checksum 0x537ab015, Offset: 0xf68
// Size: 0x198
function function_bbf9ef52() {
    level endon(#"game_ended");
    waitresult = self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    playfx("killstreaks/fx9_napalm_bomb_exp", self.origin);
    radiusdamage(self.origin, 1000, 1000, 1000);
    if (isdefined(self.truck)) {
        self.truck dodamage(10000, self.origin);
    }
    self delete();
    foreach (player in level.players) {
        if (player.team == game.attackers) {
            player iprintlnbold("Missile Destroyed! Protect them!");
            continue;
        }
        player iprintlnbold("Missile Destroyed! Keep fighting!");
    }
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 2, eflags: 0x0
// Checksum 0xdd9ff0d9, Offset: 0x1108
// Size: 0x218
function function_d33f46a4(spawnpoint, index) {
    vehicle = spawnvehicle("veh_t9_mil_truck_hemtt_cargo_wz", spawnpoint.origin, spawnpoint.angles);
    vehicle makeusable();
    vehicle.var_b09e50c3 = gameobjects::get_next_obj_id();
    objective_add(vehicle.var_b09e50c3, "active", vehicle, #"hash_3f89a8c368d3848a");
    function_c939fac4(vehicle.var_b09e50c3, game.defenders);
    vehicle.overridevehiclekilled = &function_e63cb1e4;
    missile = spawn("script_model", spawnpoint.origin);
    missile setmodel("p8_nt4_missile_soviet_full");
    missile setscale(getdvarfloat(#"hash_75bbabbef2106dda", 0.19));
    vehicle.var_974e7341 = missile;
    missile.takedamage = 1;
    missile.health = 100;
    missile.var_86a21346 = &function_67d3750a;
    missile linkto(vehicle, "tag_interior_d0", level.missileoffset, (78, 0, 0));
    missile.var_f990f05b = 78;
    missile.truck = vehicle;
    missile thread function_bbf9ef52();
    thread function_f4ad14e2(vehicle, index);
    return vehicle;
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 2, eflags: 0x0
// Checksum 0x915a4428, Offset: 0x1328
// Size: 0x2a2
function function_f4ad14e2(vehicle, index) {
    level endon(#"game_ended");
    vehicle endon(#"death");
    wait 10;
    upangle = vectorscale(vectornormalize(anglestoup(vehicle.angles)), 5);
    var_a5435776 = spawn("trigger_radius_use", vehicle.origin + upangle, 0, 128, 200);
    var_a5435776 setcursorhint("HINT_INTERACTIVE_PROMPT");
    var_31b5f1bc = gameobjects::create_use_object(game.attackers, var_a5435776, [], undefined, #"hash_7c8dfdab6fd04459" + index, 1, 1, 1);
    var_31b5f1bc gameobjects::set_visible(#"group_all");
    var_31b5f1bc gameobjects::allow_use(#"group_friendly");
    var_31b5f1bc gameobjects::set_use_time(level.planttime);
    var_31b5f1bc gameobjects::set_use_text(#"hash_f8bea24436ad636");
    var_31b5f1bc gameobjects::set_use_hint_text(#"hash_6b32950ab833923e");
    var_31b5f1bc.useweapon = getweapon(#"briefcase_bomb");
    var_31b5f1bc.vehicle = vehicle;
    var_31b5f1bc.onbeginuse = &function_52c4c9b7;
    var_31b5f1bc.onuseclear = &onuseclear;
    var_31b5f1bc.onuseupdate = &onuseupdate;
    var_31b5f1bc.onenduse = &function_8b7fb0f0;
    var_31b5f1bc.onuse = &function_9aad61da;
    var_31b5f1bc thread function_4be0e7c4(vehicle, var_31b5f1bc);
    vehicle.var_31cac59e = var_31b5f1bc;
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 2, eflags: 0x0
// Checksum 0xf4203c60, Offset: 0x15d8
// Size: 0x12c
function function_4be0e7c4(vehicle, var_d282b6f0) {
    level endon(#"game_ended", #"missle_active");
    vehicle endon(#"death");
    while (isdefined(var_d282b6f0)) {
        vehicle waittill(#"enter_vehicle");
        var_d282b6f0 gameobjects::set_visible(#"group_none");
        var_d282b6f0.interrupted = 1;
        var_d282b6f0.trigger triggerenable(0);
        while (isdefined(var_d282b6f0) && isdefined(var_d282b6f0.interrupted)) {
            vehicle waittill(#"exit_vehicle");
            if (vehicle getvehoccupants().size == 0) {
                thread function_706c8105(vehicle, var_d282b6f0);
            }
        }
    }
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 4, eflags: 0x0
// Checksum 0xbe81454d, Offset: 0x1710
// Size: 0x132
function function_bc2f89f7(truck, endtime, var_3ff0d499, var_172fbf6f) {
    truck endon(#"death");
    totaltime = endtime - gettime();
    missile = truck.var_974e7341;
    var_d223b230 = (var_3ff0d499 - missile.var_f990f05b) / totaltime;
    lasttime = gettime();
    truck.var_9a2087f6 = 0;
    while (gettime() < endtime) {
        framedelta = gettime() - lasttime;
        missile.var_f990f05b = framedelta * var_d223b230 + missile.var_f990f05b;
        angles = (missile.var_f990f05b, 0, 0);
        missile linktoupdateoffset(level.missileoffset, angles);
        lasttime = gettime();
        waitframe(1);
    }
    if (isdefined(var_172fbf6f)) {
        [[ var_172fbf6f ]](truck);
    }
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 2, eflags: 0x0
// Checksum 0x3b729500, Offset: 0x1850
// Size: 0x136
function function_706c8105(vehicle, var_d282b6f0) {
    level endon(#"game_ended");
    vehicle endon(#"death", #"enter_vehicle");
    while (vehicle.vehspeed != 0) {
        waitframe(1);
    }
    var_e07c7e8 = physicstrace(vehicle.origin, vehicle.origin + (0, 0, 10000), (0, 0, 0), (0, 0, 0), vehicle, 1);
    if (var_e07c7e8[#"fraction"] < 1) {
        return;
    }
    var_d282b6f0 gameobjects::set_visible(#"group_all");
    var_d282b6f0.interrupted = undefined;
    var_d282b6f0.trigger triggerenable(1);
    var_d282b6f0.trigger.origin = vehicle.origin;
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 1, eflags: 0x0
// Checksum 0xc0e9ea94, Offset: 0x1990
// Size: 0x4c
function function_52c4c9b7(player) {
    player.isplanting = 1;
    player thread setbomboverheatingafterweaponchange(self, 0, 0);
    objective_setplayerusing(self.objectiveid, player);
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 3, eflags: 0x0
// Checksum 0xd6e8d8e9, Offset: 0x19e8
// Size: 0x2e
function function_8b7fb0f0(*team, player, result) {
    player.isplanting = 0;
    if (result) {
    }
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 1, eflags: 0x0
// Checksum 0x6565c79e, Offset: 0x1a20
// Size: 0xda
function function_9aad61da(*player) {
    thread function_bc2f89f7(self.vehicle, gettime() + int(20 * 1000), 0, &function_bad0ccc5);
    self.vehicle makeunusable();
    objective_setstate(self.vehicle.var_b09e50c3, "invisible");
    self gameobjects::set_flags(1);
    self gameobjects::clear_progress();
    self.onuse = &function_a0595047;
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 1, eflags: 0x0
// Checksum 0x81ade89a, Offset: 0x1b08
// Size: 0x234
function function_a0595047(player) {
    if (isdefined(self) && isdefined(self.vehicle)) {
        if (self.vehicle.var_9a2087f6 === 1) {
            firemissile(self.vehicle);
            function_71db2f7c(self.vehicle, self);
            player setweaponoverheating(1, 100, self.useweapon);
            level.var_3653c98 = int(level.timelimit) * int(60 * 1000) - gettime();
            level.timelimitoverride = 1;
            setgameendtime(gettime() + int(level.bombtimer * 1000));
            thread bombtimerwait();
            self gameobjects::clear_progress();
            self gameobjects::allow_use(#"group_enemy");
            self.onbeginuse = &function_a8c87bae;
            self.onenduse = &function_46031620;
            self.onuse = &onusedefuseobject;
            return;
        }
        self.vehicle.var_9a2087f6 = 0;
        self gameobjects::allow_use(#"group_none");
        function_bc2f89f7(self.vehicle, gettime() + int(10 * 1000), 78, &function_7b550339);
    }
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 1, eflags: 0x0
// Checksum 0x7389911f, Offset: 0x1d48
// Size: 0x3c
function function_bad0ccc5(truck) {
    truck.var_9a2087f6 = 1;
    truck.var_31cac59e gameobjects::set_flags(2);
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 1, eflags: 0x0
// Checksum 0x5088ebfc, Offset: 0x1d90
// Size: 0xd2
function function_7b550339(truck) {
    truck.var_31cac59e gameobjects::set_visible(#"group_all");
    truck.var_31cac59e gameobjects::allow_use(#"group_friendly");
    truck.var_31cac59e gameobjects::set_flags(0);
    truck makeusable();
    objective_setstate(truck.var_b09e50c3, "active");
    truck.var_31cac59e.onuse = &function_9aad61da;
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 3, eflags: 0x0
// Checksum 0xf5a7b6cd, Offset: 0x1e70
// Size: 0x54
function onuseupdate(*team, progress, *change) {
    objective_setprogress(self.objectiveid, math::clamp(change, 0, 1));
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 0, eflags: 0x0
// Checksum 0x5d3c90, Offset: 0x1ed0
// Size: 0x1c
function onuseclear() {
    objective_setprogress(self.objectiveid, 0);
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 1, eflags: 0x0
// Checksum 0x58aa0e93, Offset: 0x1ef8
// Size: 0x54
function function_87e3d154(*vehicle) {
    thread function_bc2f89f7(self.vehicle, gettime() + int(10 * 1000), 0, &firemissile);
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 1, eflags: 0x0
// Checksum 0x4b6e9f46, Offset: 0x1f58
// Size: 0x1d0
function firemissile(vehicle) {
    missile = vehicle.var_974e7341;
    missile unlink();
    lasttime = gettime();
    fxorg = spawn("script_model", (0, 0, 0));
    fxorg setmodel(#"tag_origin");
    fxorg linkto(missile, undefined, (0, 0, 0), (90, 0, 0));
    playfxontag("_t7/dlc1/castle/fx_rocket_exhaust_takeoff", fxorg, "tag_origin");
    missile moveto(missile.origin + (0, 0, 60000), 60, 10);
    foreach (player in level.players) {
        if (player.team == game.attackers) {
            player iprintlnbold("Nuclear Launch Detected! Defend the launch truck!");
            continue;
        }
        player iprintlnbold("Nuclear Launch Detected! Destroy the launch truck!");
    }
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 3, eflags: 0x0
// Checksum 0x6a4d47ef, Offset: 0x2130
// Size: 0xbc
function setbomboverheatingafterweaponchange(useobject, overheated, heat) {
    self endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
    waitresult = self waittill(#"weapon_change");
    if (waitresult.weapon == useobject.useweapon) {
        self setweaponoverheating(overheated, heat, waitresult.weapon);
    }
}

// Namespace namespace_3f3933bc/enter_vehicle
// Params 1, eflags: 0x40
// Checksum 0xc8c1f95c, Offset: 0x21f8
// Size: 0x94
function event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    vehicle = eventstruct.vehicle;
    if (!isdefined(vehicle.scriptvehicletype) || vehicle.scriptvehicletype != "player_hemtt") {
        return;
    }
    if (vehicle.var_b09e50c3) {
        objective_setstate(vehicle.var_b09e50c3, "invisible");
    }
}

// Namespace namespace_3f3933bc/exit_vehicle
// Params 1, eflags: 0x40
// Checksum 0xe12da6d0, Offset: 0x2298
// Size: 0x94
function event_handler[exit_vehicle] codecallback_vehicleexit(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    vehicle = eventstruct.vehicle;
    if (!isdefined(vehicle.scriptvehicletype) || vehicle.scriptvehicletype != "player_hemtt") {
        return;
    }
    if (vehicle.var_b09e50c3) {
        objective_setstate(vehicle.var_b09e50c3, "active");
    }
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 0, eflags: 0x0
// Checksum 0x356142ce, Offset: 0x2338
// Size: 0x54
function bombtimerwait() {
    level endon(#"game_ended", #"bomb_defused");
    wait level.bombtimer;
    globallogic::function_a3e3bd39(game.attackers, 1);
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 2, eflags: 0x0
// Checksum 0xd9d21cf8, Offset: 0x2398
// Size: 0x38e
function function_71db2f7c(vehicle, *var_31cac59e) {
    function_9e4ca5a0(var_31cac59e);
    objective_delete(var_31cac59e.var_b09e50c3);
    gameobjects::release_obj_id(var_31cac59e.var_b09e50c3);
    var_31cac59e.var_b09e50c3 = undefined;
    var_31cac59e.var_31cac59e = undefined;
    level notify(#"missle_active");
    foreach (truck in level.var_d98635d9) {
        if (isdefined(truck.var_31cac59e)) {
            truck.var_31cac59e gameobjects::set_visible(#"group_none");
            truck.var_31cac59e gameobjects::allow_use(#"group_none");
        }
    }
    upangle = vectorscale(vectornormalize(anglestoup(var_31cac59e.angles)), 5);
    defusetrigger = spawn("trigger_radius_use", var_31cac59e.origin + upangle, 0, 128, 200);
    defusetrigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    defuseobject = gameobjects::create_use_object(game.attackers, defusetrigger, [], undefined, #"hash_12ac522cdf799e82", 1, 1, 1);
    defuseobject gameobjects::set_visible(#"group_all");
    defuseobject gameobjects::allow_use(#"group_enemy");
    defuseobject gameobjects::set_use_time(level.defusetime);
    defuseobject gameobjects::set_use_text(#"mp/defusing_explosive");
    defuseobject gameobjects::set_use_hint_text(#"hash_754b795109a2bbba");
    defuseobject.useweapon = getweapon(#"briefcase_bomb_defuse");
    defuseobject.vehicle = var_31cac59e;
    defuseobject.onbeginuse = &function_a8c87bae;
    defuseobject.onuseclear = &onuseclear;
    defuseobject.onuseupdate = &onuseupdate;
    defuseobject.onenduse = &function_46031620;
    defuseobject.onuse = &onusedefuseobject;
    var_31cac59e.var_643933de = defuseobject;
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 1, eflags: 0x0
// Checksum 0x79a5ca3b, Offset: 0x2730
// Size: 0x4c
function function_a8c87bae(player) {
    player.isdefusing = 1;
    player thread setbomboverheatingafterweaponchange(self, 0, 0);
    objective_setplayerusing(self.objectiveid, player);
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 3, eflags: 0x0
// Checksum 0xc07e7ffd, Offset: 0x2788
// Size: 0x2e
function function_46031620(*team, player, result) {
    player.isdefusing = 0;
    if (result) {
    }
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 1, eflags: 0x0
// Checksum 0x848566c7, Offset: 0x27c0
// Size: 0x1cc
function onusedefuseobject(player) {
    level notify(#"bomb_defused");
    var_611dc78e = 1;
    foreach (truck in level.var_d98635d9) {
        if (isdefined(truck.var_31cac59e)) {
            truck.var_31cac59e gameobjects::set_visible(#"group_all");
            truck.var_31cac59e gameobjects::allow_use(#"group_friendly");
            thread function_4be0e7c4(truck, truck.var_31cac59e);
            var_611dc78e = 0;
        }
    }
    player setweaponoverheating(1, 100, self.useweapon);
    level.timelimitoverride = 1;
    setgameendtime(gettime() + level.var_3653c98);
    self gameobjects::disable_object(1, 1, 0, 1);
    if (var_611dc78e == 1) {
        globallogic::function_a3e3bd39(game.defenders, 1);
    }
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 2, eflags: 0x0
// Checksum 0x4291fb93, Offset: 0x2998
// Size: 0x60
function function_9e90b881(origin, angles) {
    var_8a15325a = spawnstruct();
    var_8a15325a.origin = origin;
    var_8a15325a.angles = angles;
    level.var_9fa97bd9[level.var_9fa97bd9.size] = var_8a15325a;
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 0, eflags: 0x0
// Checksum 0x37b09ce4, Offset: 0x2a00
// Size: 0x17c
function function_2c1beb43() {
    level.var_9fa97bd9 = [];
    function_9e90b881((-19900, -49089, 2997), (0, -90, 0));
    function_9e90b881((-20400, -49089, 2997), (0, -90, 0));
    function_9e90b881((-20900, -49089, 2997), (0, -90, 0));
    function_def22e6("vehicle_t9_mil_ru_heli_gunship_hind_wz", (50465.9, 19295.1, 1800), (0, -176.501, 0));
    function_def22e6("vehicle_t9_mil_ru_heli_gunship_hind_wz", (47928, 19284.9, 1800), (0, -169.711, 0));
    function_def22e6("vehicle_t9_mil_ru_heli_gunship_hind_wz", (49064.3, 19295.3, 1800), (0, -174.644, 0));
    function_def22e6("vehicle_t9_mil_ru_heli_gunship_hind_wz", (46682.5, 20315.4, 1820), (0, -88.9069, 0));
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 2, eflags: 0x0
// Checksum 0xefded999, Offset: 0x2b88
// Size: 0x98
function function_329ef588(origin, angles) {
    if (!isdefined(level.var_c25f98d5)) {
        level.var_c25f98d5 = [];
    }
    spawnpoint = spawnstruct();
    spawnpoint.origin = origin;
    spawnpoint.angles = angles;
    spawnpoint._human_were = 1;
    spawnpoint.ctf = 1;
    level.var_c25f98d5[level.var_c25f98d5.size] = spawnpoint;
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 2, eflags: 0x0
// Checksum 0x10d85235, Offset: 0x2c28
// Size: 0x98
function function_307d5f67(origin, angles) {
    if (!isdefined(level.var_75ef9e74)) {
        level.var_75ef9e74 = [];
    }
    spawnpoint = spawnstruct();
    spawnpoint.origin = origin;
    spawnpoint.angles = angles;
    spawnpoint.ctf = 1;
    spawnpoint._human_were = 1;
    level.var_75ef9e74[level.var_75ef9e74.size] = spawnpoint;
}

// Namespace namespace_3f3933bc/namespace_3f3933bc
// Params 0, eflags: 0x0
// Checksum 0x25a7bb0b, Offset: 0x2cc8
// Size: 0x66c
function function_e23fea8c() {
    clearspawnpoints("start_spawn");
    clearspawnpoints("auto_normal");
    function_329ef588((-20369, -49973.1, 3005.61), (0, 90, 0));
    function_329ef588((-20184.4, -49973, 3000.3), (0, 90, 0));
    function_329ef588((-20005.4, -49972.8, 3005.38), (0, 90, 0));
    function_329ef588((-20007.5, -50163, 3004.4), (0, 90, 0));
    function_329ef588((-20194.4, -50159.2, 2999.52), (0, 90, 0));
    function_329ef588((-20377.2, -50153, 3005.02), (0, 90, 0));
    function_329ef588((-20600, -50133.3, 3005.27), (0, 90, 0));
    function_329ef588((-20795.5, -50078.6, 3005.02), (0, 90, 0));
    function_329ef588((-21011.3, -50065.3, 3009.65), (0, 90, 0));
    function_329ef588((-21126.7, -50065.4, 3004.52), (0, 90, 0));
    function_329ef588((-21126.9, -49944, 3000.57), (0, 90, 0));
    function_307d5f67((48922.5, 20576.5, 1431.09), (0, -91.225, 0));
    function_307d5f67((48802.2, 20554.8, 1430.85), (0, -81.1176, 0));
    function_307d5f67((48778, 20661.9, 1421.31), (0, -81.1176, 0));
    function_307d5f67((48938.2, 20664.9, 1425.74), (0, -81.1176, 0));
    function_307d5f67((48942.4, 20806.1, 1425.23), (0, -87.616, 0));
    function_307d5f67((48799, 20796.7, 1425.73), (0, -85.8691, 0));
    function_307d5f67((48790.9, 20942.2, 1425.73), (0, -85.8691, 0));
    function_307d5f67((48931.2, 20949.9, 1420.77), (0, -85.8691, 0));
    function_307d5f67((48928.4, 21055.9, 1420.77), (0, -85.8691, 0));
    function_307d5f67((48795.6, 21024.7, 1430.16), (0, -85.8691, 0));
    function_307d5f67((48791.5, 21129.8, 1421.04), (0, -85.8691, 0));
    function_307d5f67((48925.6, 21132.2, 1425.48), (0, -85.8691, 0));
    function_307d5f67((48928.9, 21259.5, 1425.23), (0, -87.8577, 0));
    function_307d5f67((48806.6, 21263.3, 1421.31), (0, -87.8577, 0));
    addspawnpoints(#"allies", level.var_c25f98d5, "start_spawn");
    addspawnpoints(#"axis", level.var_75ef9e74, "start_spawn");
    addspawnpoints(#"allies", level.var_c25f98d5, "auto_normal");
    addspawnpoints(#"axis", level.var_75ef9e74, "auto_normal");
}

