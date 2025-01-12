#using script_71e26f08f03b7a7a;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\death_circle;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\mp_common\item_drop;
#using scripts\mp_common\item_world;
#using scripts\mp_common\load;
#using scripts\wz\wz_open_skyscrapers_fx;
#using scripts\wz\wz_open_skyscrapers_sound;
#using scripts\wz_common\wz_ai_zonemgr;
#using scripts\wz_common\wz_buoy_stash;
#using scripts\wz_common\wz_firing_range;
#using scripts\wz_common\wz_jukebox;

#namespace wz_open_skyscrapers;

// Namespace wz_open_skyscrapers/level_init
// Params 1, eflags: 0x40
// Checksum 0x65061c3c, Offset: 0x340
// Size: 0x33c
function event_handler[level_init] main(eventstruct) {
    callback::on_spawned(&on_player_spawned);
    callback::on_vehicle_spawned(&on_vehicle_spawned);
    level.mapcenter = (0, 0, 0);
    setmapcenter(level.mapcenter);
    wz_open_skyscrapers_fx::main();
    wz_open_skyscrapers_sound::main();
    load::main();
    level.var_cb7a9114 = 35000;
    level.var_ecf60aca = 35000;
    compass::setupminimap("");
    setdvar(#"hash_6b51c550499b0af2", 1);
    setdvar(#"hash_6383be3298a755f5", 1);
    level function_8c8f5553();
    /#
        init_devgui();
    #/
    dynents = getdynentarray("dynent_garage_button");
    foreach (dynent in dynents) {
        dynent.onuse = &function_6f0beec9;
    }
    level thread init_elevator("dynent_elevator_button");
    level thread init_elevator("dynent_elevator_button_2");
    level thread init_elevator("dynent_elevator_button_3");
    function_291568cb();
    var_4ff835bd = getdynentarray("blastdoor_button");
    foreach (blast_door_button in var_4ff835bd) {
        blast_door_button.onuse = &function_be3e6a37;
    }
    level thread function_99e4b237();
    level thread function_62e13907();
    wz_firing_range::init_targets("firing_range_target");
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 0, eflags: 0x0
// Checksum 0xced22de4, Offset: 0x688
// Size: 0x34c
function function_9a0f7d46() {
    level endon(#"game_ended");
    item_world::function_6df9665a();
    var_3f559963 = wz_ai_zonemgr::function_e5956f11("Asylum");
    var_2fad5f1a = wz_ai_zonemgr::function_e5956f11("Cemetary");
    zone_diner = wz_ai_zonemgr::function_e5956f11("Diner");
    var_8a1f1880 = wz_ai_zonemgr::function_e5956f11("BoxingGym");
    var_e94d071e = wz_ai_zonemgr::function_e5956f11("Lighthouse");
    while (!var_3f559963.is_active && !var_2fad5f1a.is_active && !zone_diner.is_active && !var_8a1f1880.is_active && !var_e94d071e.is_active) {
        var_3f559963 = wz_ai_zonemgr::function_e5956f11("Asylum");
        var_2fad5f1a = wz_ai_zonemgr::function_e5956f11("Cemetary");
        zone_diner = wz_ai_zonemgr::function_e5956f11("Diner");
        var_8a1f1880 = wz_ai_zonemgr::function_e5956f11("BoxingGym");
        var_e94d071e = wz_ai_zonemgr::function_e5956f11("Lighthouse");
        wait 1;
    }
    wait 1;
    if (!var_3f559963.is_active) {
        var_8ee5944a = getdynent("hospital_stash");
        if (isdefined(var_8ee5944a)) {
            item_world::function_c427552b(var_8ee5944a);
        }
    }
    if (!var_2fad5f1a.is_active) {
        var_1939d2fb = getdynent("zombie_stash_graveyard");
        if (isdefined(var_1939d2fb)) {
            item_world::function_c427552b(var_1939d2fb);
        }
    }
    if (!zone_diner.is_active) {
        var_98843281 = getdynent("zombie_supply_stash_diner");
        if (isdefined(var_98843281)) {
            item_world::function_c427552b(var_98843281);
        }
    }
    if (!var_8a1f1880.is_active) {
        var_8617606 = getdynent("zombie_supply_stash_boxinggym");
        if (isdefined(var_8617606)) {
            item_world::function_c427552b(var_8617606);
        }
    }
    if (!var_e94d071e.is_active) {
        var_2cdb3853 = getdynent("zombie_supply_stash_lighthouse");
        if (isdefined(var_2cdb3853)) {
            item_world::function_c427552b(var_2cdb3853);
        }
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 0, eflags: 0x0
// Checksum 0xd9ff014a, Offset: 0x9e0
// Size: 0x188
function function_62e13907() {
    var_14ce65cb = getdynentarray("wind_turbine");
    foreach (turbine in var_14ce65cb) {
        if (randomint(100) > 20) {
            function_9e7b6692(turbine, randomintrange(1, 4));
        }
    }
    level flagsys::wait_till(#"hash_507a4486c4a79f1d");
    foreach (turbine in var_14ce65cb) {
        if (randomint(100) > 20) {
            function_9e7b6692(turbine, randomintrange(1, 4));
        }
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 0, eflags: 0x0
// Checksum 0x12e2b363, Offset: 0xb70
// Size: 0x240
function function_99e4b237() {
    level flagsys::wait_till(#"item_world_initialized");
    specialitems = function_60374d7d("blast_doors_special_weapon");
    foreach (specialitem in specialitems) {
        item_world::consume_item(specialitem);
    }
    level flagsys::wait_till(#"item_world_reset");
    while (isdefined(level.var_aaa508f5) && level.var_aaa508f5) {
        waitframe(1);
    }
    var_ce80d81e = 0;
    supplystashes = getdynentarray("blast_doors_supply_stash");
    foreach (supplystash in supplystashes) {
        if (function_4e453530(supplystash)) {
            var_ce80d81e = 1;
            break;
        }
    }
    if (var_ce80d81e) {
        specialitems = function_60374d7d("blast_doors_special_weapon");
        foreach (specialitem in specialitems) {
            item_world::consume_item(specialitem);
        }
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 3, eflags: 0x0
// Checksum 0xfe305c9f, Offset: 0xdb8
// Size: 0x240
function function_be3e6a37(activator, laststate, state) {
    if (isdefined(self.target)) {
        var_d04ccb49 = getdynentarray(self.target);
        foreach (dynent in var_d04ccb49) {
            level thread item_drop::function_64de448c(dynent.origin, 256, 3);
        }
        waitframe(1);
        foreach (dynent in var_d04ccb49) {
            currentstate = function_7f51b166(dynent);
            if (currentstate != state) {
                function_9e7b6692(dynent, state);
            }
        }
        var_4ff835bd = getdynentarray("blastdoor_button");
        foreach (blast_door_button in var_4ff835bd) {
            var_3df2b135 = function_7f51b166(blast_door_button);
            if (var_3df2b135 != state) {
                function_9e7b6692(blast_door_button, state);
            }
        }
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 0, eflags: 0x0
// Checksum 0x2a1b9ea, Offset: 0x1000
// Size: 0x108
function function_291568cb() {
    wz_ai_zonemgr::function_c23585d(0, "Asylum", "spawner_boct_zombie_wz", 10, 5, 2);
    wz_ai_zonemgr::function_c23585d(0, "Cemetary", "spawner_boct_zombie_wz", 10, 5, 2);
    wz_ai_zonemgr::function_c23585d(1, "Diner", "spawner_boct_zombie_wz", 6, 3, 1);
    wz_ai_zonemgr::function_c23585d(1, "BoxingGym", "spawner_boct_zombie_wz", 6, 3, 1);
    wz_ai_zonemgr::function_c23585d(1, "Lighthouse", "spawner_boct_zombie_wz", 6, 3, 1);
    level notify(#"hash_7f7eec328c07606d");
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 1, eflags: 0x0
// Checksum 0x7f3872d2, Offset: 0x1110
// Size: 0x32e
function init_elevator(var_ad11ef89) {
    callback::on_player_corpse(&function_6ebc3e65);
    dynents = getdynentarray(var_ad11ef89);
    assert(dynents.size == 2);
    foreach (dynent in dynents) {
        dynent.onuse = &function_c8c2b6be;
        dynent.buttons = dynents;
        position = struct::get(dynent.target, "targetname");
        elevator = getent(position.target, "targetname");
        elevator.buttons = dynents;
        if (position.script_noteworthy === "start") {
            function_9e7b6692(dynent, 1);
            if (!isdefined(elevator.target)) {
                continue;
            }
            button = getent(elevator.target, "targetname");
            if (!isdefined(button)) {
                continue;
            }
            button triggerignoreteam();
            button setvisibletoall();
            button setteamfortrigger(#"none");
            button setcursorhint("HINT_NOICON");
            button sethintstring(#"hash_29965b65bca9cd7b");
            button usetriggerignoreuseholdtime();
            button callback::on_trigger(&function_7679122d);
            button.elevator = elevator;
            elevator.button = button;
            elevator.var_2d1e084c = button.origin - elevator.origin;
            elevator.var_a9f0ef27 = dynent;
            elevator.currentfloor = dynent;
            continue;
        }
        elevator.var_b25749ae = dynent;
        elevator.var_64614740 = dynent;
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 0, eflags: 0x0
// Checksum 0xe05975dd, Offset: 0x1448
// Size: 0xc0
function function_6ebc3e65() {
    waitframe(1);
    foreach (player in level.players) {
        if (player.var_9a191cc4 === 1 && player.body === self) {
            self notsolid();
            self thread function_5de1acad();
        }
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 0, eflags: 0x0
// Checksum 0xcad89eb7, Offset: 0x1510
// Size: 0x34
function function_5de1acad() {
    self endon(#"death");
    wait 3;
    self ghost();
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 0, eflags: 0x0
// Checksum 0x40ad730f, Offset: 0x1550
// Size: 0xdc
function function_1275bd81() {
    self endon(#"movedone");
    while (true) {
        vehicles = getentitiesinradius(self.origin, 1536, 12);
        foreach (vehicle in vehicles) {
            vehicle launchvehicle((0, 0, 0), vehicle.origin, 0);
        }
        wait 0.25;
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 1, eflags: 0x0
// Checksum 0xbf9a71ca, Offset: 0x1638
// Size: 0x1b8
function elevator_kill_player(t_damage) {
    self endon(#"death");
    foreach (e_player in getplayers()) {
        if (e_player istouching(t_damage) && isalive(e_player) && isdefined(e_player)) {
            if (level.inprematchperiod) {
                n_rand = randomint(3) + 1;
                point = struct::get("elevator_teleport_" + n_rand, "targetname");
                if (isdefined(point)) {
                    e_player setorigin(point.origin);
                }
                continue;
            }
            e_player.var_9a191cc4 = 1;
            e_player notsolid();
            e_player ghost();
            e_player kill(e_player.origin);
        }
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 0, eflags: 0x0
// Checksum 0xcbf043f9, Offset: 0x17f8
// Size: 0x3c
function function_d66f644d() {
    self endon(#"death");
    wait 2;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 1, eflags: 0x0
// Checksum 0x91844794, Offset: 0x1840
// Size: 0x2a8
function function_cc6ed82d(t_damage) {
    self endon(#"death");
    vehicles = getentitiesinradius(t_damage.origin, 1536, 12);
    foreach (e_vehicle in vehicles) {
        if (e_vehicle istouching(t_damage) && isalive(e_vehicle)) {
            a_players = e_vehicle getvehoccupants();
            e_vehicle kill(e_vehicle.origin);
            waitframe(1);
            foreach (player in a_players) {
                if (isalive(player) && isdefined(player)) {
                    if (level.inprematchperiod) {
                        n_rand = randomint(3) + 1;
                        point = struct::get("elevator_teleport_" + n_rand, "targetname");
                        if (isdefined(point)) {
                            player setorigin(point.origin);
                        }
                        continue;
                    }
                    player.var_9a191cc4 = 1;
                    player notsolid();
                    player ghost();
                    player kill(player.origin);
                }
            }
            e_vehicle thread function_d66f644d();
        }
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 1, eflags: 0x0
// Checksum 0x6d6ff518, Offset: 0x1af0
// Size: 0x176
function function_a27e69cf(position) {
    self endon(#"death");
    if (isdefined(self.script_noteworthy) && isdefined(position)) {
        var_d0d07c33 = self.script_noteworthy + "_player";
        var_8e268cf6 = self.script_noteworthy + "_vehicle";
        var_6769ee17 = getent(var_d0d07c33, "targetname");
        t_damage_vehicle = getent(var_8e268cf6, "targetname");
        if (isdefined(var_6769ee17) && isdefined(t_damage_vehicle)) {
            var_430402dc = distance(self.origin, position.origin);
            while (var_430402dc > 4) {
                var_430402dc = distancesquared(self.origin, position.origin);
                if (var_430402dc <= 5000) {
                    self thread function_cc6ed82d(t_damage_vehicle);
                    self thread elevator_kill_player(var_6769ee17);
                }
                waitframe(1);
            }
        }
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 1, eflags: 0x0
// Checksum 0x8b830e4, Offset: 0x1c70
// Size: 0x32c
function elevator_move(elevator) {
    position = struct::get(elevator.var_64614740.target, "targetname");
    elevator.button triggerenable(0);
    if (isdefined(elevator.script_noteworthy) && position.script_noteworthy === "start") {
        elevator thread function_a27e69cf(position);
    }
    elevator.moving = 1;
    elevator.button playsound("evt_elevator_button_bell");
    wait 0.5;
    elevator thread function_1275bd81();
    elevator playsound("evt_elevator_start");
    elevator playloopsound("evt_elevator_move", 0);
    elevator moveto(position.origin, 10, 0.5, 0.5);
    function_9e7b6692(elevator.var_64614740, 1);
    function_9e7b6692(elevator.currentfloor, 1);
    var_64614740 = elevator.currentfloor;
    elevator.currentfloor = elevator.var_64614740;
    elevator.var_64614740 = var_64614740;
    elevator waittill(#"movedone");
    elevator playsound("evt_elevator_stop");
    elevator stoploopsound(1);
    elevator.moving = 0;
    elevator.button.origin = elevator.origin + elevator.var_2d1e084c;
    if (elevator.var_64614740 == elevator.var_a9f0ef27) {
        elevator.button sethintstring(#"hash_310ad55f171e194e");
    } else {
        elevator.button sethintstring(#"hash_29965b65bca9cd7b");
    }
    function_9e7b6692(elevator.var_64614740, 0);
    elevator.button triggerenable(1);
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 1, eflags: 0x0
// Checksum 0x744f39eb, Offset: 0x1fa8
// Size: 0x84
function function_7679122d(trigger_struct) {
    trigger = self;
    activator = trigger_struct.activator;
    elevator = trigger.elevator;
    activator gestures::function_42215dfa("gestable_door_interact", undefined, 0);
    elevator_move(elevator);
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 3, eflags: 0x0
// Checksum 0xd9bfaa7e, Offset: 0x2038
// Size: 0xd4
function function_c8c2b6be(activator, laststate, state) {
    if (isdefined(self.target)) {
        position = struct::get(self.target, "targetname");
        elevator = getent(position.target, "targetname");
        if (isdefined(elevator.moving) && elevator.moving) {
            elevator waittill(#"movedone");
        }
        elevator_move(elevator);
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 3, eflags: 0x0
// Checksum 0x86793507, Offset: 0x2118
// Size: 0x9c
function function_6f0beec9(activator, laststate, state) {
    if (isdefined(self.target)) {
        var_32f9fcd6 = getdynent(self.target);
        if (!isdefined(var_32f9fcd6)) {
            return;
        }
        currentstate = function_7f51b166(var_32f9fcd6);
        if (currentstate != state) {
            function_9e7b6692(var_32f9fcd6, state);
        }
    }
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 0, eflags: 0x0
// Checksum 0xbcd0dcbf, Offset: 0x21c0
// Size: 0x4c
function on_player_spawned() {
    /#
        self thread function_acb51d6b();
    #/
    /#
        self thread function_5528ad07();
    #/
    /#
        self thread function_7fdaca5a();
    #/
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 0, eflags: 0x0
// Checksum 0xfa75232a, Offset: 0x2218
// Size: 0x4c
function on_vehicle_spawned() {
    /#
        self thread function_d5c7d7f2();
    #/
    /#
        self thread function_887896b8();
    #/
    /#
        self thread function_af672f88();
    #/
}

// Namespace wz_open_skyscrapers/wz_open_skyscrapers
// Params 0, eflags: 0x0
// Checksum 0x95cc3d0a, Offset: 0x2270
// Size: 0x2bc
function function_8c8f5553() {
    if (!getdvarint(#"hash_6383be3298a755f5", 0)) {
        return;
    }
    death_circle::function_cb0332a(90);
    origin = (-1544, -4254, 0);
    width = 112090;
    height = 115055;
    var_83135f10 = width - 40000;
    var_4b86aca9 = height - 40000;
    var_f51ace4b = width - 15000;
    var_71892712 = height - 15000;
    death_circle::function_6ffbfc9a((-1544, -4254, 0), 90000, 1, 1, 120, 240, 1);
    death_circle::function_e07f33dc(origin, var_83135f10, var_4b86aca9, 40522, 1, 1, 120, 120, 1);
    death_circle::function_e07f33dc(origin, var_f51ace4b, var_71892712, 28473, 1, 1, 90, 120, 1);
    death_circle::function_e07f33dc(origin, width, height, 12814, 2, 1, 60, 120, 2);
    death_circle::function_e07f33dc(origin, width, height, 8596, 6, 1, 45, 60, 2);
    death_circle::function_e07f33dc(origin, width, height, 4298, 10, 1, 45, 60, 3);
    death_circle::function_e07f33dc(origin, width, height, 2124, 16, 1, 45, 45, 3);
    death_circle::function_73f148f2(20, 1, 45, 45, 3);
    level thread namespace_2831d7ca::start(4, 20, array(60, 45, 20));
}

/#

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x277946af, Offset: 0x2538
    // Size: 0x1d4
    function init_devgui() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x3e>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x87>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:xea>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x14e>");
        adddebugcommand("<dev string:x181>");
        adddebugcommand("<dev string:x1e2>" + mapname + "<dev string:x1f1>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x22e>");
        level thread function_1337221();
        level thread function_202489c0();
        level thread function_8b1b1c67();
        level thread function_21333ed2();
        level thread function_dce36aa8();
        level thread function_96a16e74();
        level thread function_a361250f();
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0xcea0df0, Offset: 0x2718
    // Size: 0x1bc
    function function_202489c0() {
        var_de0a3c9b = 0;
        old_origin = (0, 0, 0);
        old_angles = (0, 0, 0);
        while (true) {
            if (isdefined(level.players[0])) {
                player = level.players[0];
                if (getdvarint(#"scr_minimap_height", 0)) {
                    if (!var_de0a3c9b) {
                        adddebugcommand("<dev string:x26b>");
                        old_origin = player.origin;
                        old_angles = player.angles;
                        origin = (0, -2696, 180538);
                        angles = (90, 90, 0);
                        player setorigin(origin);
                        player setplayerangles(angles);
                        var_de0a3c9b = 1;
                    }
                } else {
                    if (var_de0a3c9b) {
                        if (player isinmovemode("<dev string:x26b>")) {
                            adddebugcommand("<dev string:x26b>");
                        }
                        player setorigin(old_origin);
                        player setplayerangles(old_angles);
                    }
                    var_de0a3c9b = 0;
                }
            }
            waitframe(1);
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0xe35df8e0, Offset: 0x28e0
    // Size: 0x70a
    function function_dce36aa8() {
        if (!getdvarint(#"hash_59e2d7722e56c1c6", 0)) {
            return;
        }
        item_spawn_groups = struct::get_array("<dev string:x272>", "<dev string:x28d>");
        foreach (group in item_spawn_groups) {
            switch (group.scriptbundlename) {
            case #"open_skyscraper_vehicles_atv":
                var_f2d3509b = group;
                break;
            case #"open_skyscraper_vehicles_cargo_truck":
                var_6fbfab22 = group;
                break;
            case #"open_skyscraper_vehicles_cargo_truck_clearing":
                var_94ba5d46 = group;
                break;
            case #"open_skyscraper_vehicles_heli":
                var_37de1ab0 = group;
                break;
            case #"open_skyscraper_vehicles_heli_clearing":
                var_47aacc14 = group;
                break;
            case #"open_skyscraper_vehicles_zodiac":
                var_b56373f4 = group;
                break;
            case #"open_skyscraper_vehicles_zodiac_docks":
                var_d0bfea4f = group;
                break;
            case #"open_skyscraper_vehicles_zodiac_nuketown":
                var_8a88851e = group;
                break;
            case #"open_skyscraper_vehicles_zodiac_hydro_dam":
                var_3c16aa9d = group;
                break;
            default:
                break;
            }
            if (isdefined(var_f2d3509b) && isdefined(var_6fbfab22) && isdefined(var_94ba5d46) && isdefined(var_37de1ab0) && isdefined(var_47aacc14) && isdefined(var_b56373f4) && isdefined(var_d0bfea4f) && isdefined(var_8a88851e) && isdefined(var_3c16aa9d)) {
                break;
            }
        }
        var_66462c43 = [];
        var_db0a6a5e = function_60374d7d(var_f2d3509b.target);
        var_7a943bd3 = function_60374d7d(var_6fbfab22.target);
        var_f0efbfc7 = function_60374d7d(var_94ba5d46.target);
        var_f259b645 = function_60374d7d(var_37de1ab0.target);
        var_dd806022 = function_60374d7d(var_47aacc14.target);
        var_a100cb99 = function_60374d7d(var_b56373f4.target);
        var_32b647ca = function_60374d7d(var_d0bfea4f.target);
        var_32a373a4 = function_60374d7d(var_8a88851e.target);
        var_954fd69 = function_60374d7d(var_3c16aa9d.target);
        var_66462c43 = arraycombine(var_66462c43, var_db0a6a5e, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_7a943bd3, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_f0efbfc7, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_f259b645, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_dd806022, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_a100cb99, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_32b647ca, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_32a373a4, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_954fd69, 0, 0);
        level flag::wait_till("<dev string:x297>");
        while (getdvarint(#"hash_59e2d7722e56c1c6", 0)) {
            foreach (point in var_66462c43) {
                var_2cb5c9e8 = distance2d(level.players[0].origin, point.origin);
                n_radius = 0.015 * var_2cb5c9e8;
                if (n_radius > 768) {
                    n_radius = 768;
                }
                if (var_2cb5c9e8 > 768) {
                    v_color = function_4ff10f7f(point.targetname);
                    str_type = function_15979fa9(point.targetname);
                    sphere(point.origin, n_radius, v_color);
                    if (var_2cb5c9e8 < 2048) {
                        print3d(point.origin + (0, 0, 32), str_type, v_color);
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x68c93ca9, Offset: 0x2ff8
    // Size: 0x1fa
    function function_96a16e74() {
        level endon(#"hash_78e53817cafb5265");
        if (!getdvarint(#"hash_4b508e86f8bff982", 0)) {
            return;
        }
        level flag::wait_till("<dev string:x297>");
        if (isdefined(level.var_4f623545)) {
            while (getdvarint(#"hash_4b508e86f8bff982", 0)) {
                foreach (obj in level.var_4f623545) {
                    var_2cb5c9e8 = distance2d(level.players[0].origin, obj.origin);
                    n_radius = 0.015 * var_2cb5c9e8;
                    if (n_radius > 768) {
                        n_radius = 768;
                    }
                    if (var_2cb5c9e8 > 768) {
                        sphere(obj.origin, n_radius, (1, 0, 0));
                        if (var_2cb5c9e8 < 2048) {
                            print3d(obj.origin + (0, 0, 32), "<dev string:x2ab>", (1, 0, 0));
                        }
                    }
                }
                waitframe(1);
            }
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x1b86cc15, Offset: 0x3200
    // Size: 0x63e
    function function_21333ed2() {
        if (!getdvarint(#"hash_574de6ff609cc0b1", 0)) {
            return;
        }
        item_spawn_groups = struct::get_array("<dev string:x272>", "<dev string:x28d>");
        foreach (group in item_spawn_groups) {
            switch (group.scriptbundlename) {
            case #"open_skyscraper_vehicles_atv":
                var_f2d3509b = group;
                break;
            case #"open_skyscraper_vehicles_cargo_truck":
                var_6fbfab22 = group;
                break;
            case #"open_skyscraper_vehicles_cargo_truck_clearing":
                var_94ba5d46 = group;
                break;
            case #"open_skyscraper_vehicles_heli":
                var_37de1ab0 = group;
                break;
            case #"open_skyscraper_vehicles_heli_clearing":
                var_47aacc14 = group;
                break;
            case #"open_skyscraper_vehicles_zodiac":
                var_b56373f4 = group;
                break;
            case #"open_skyscraper_vehicles_zodiac_docks":
                var_d0bfea4f = group;
                break;
            case #"open_skyscraper_vehicles_zodiac_nuketown":
                var_8a88851e = group;
                break;
            default:
                break;
            }
            if (isdefined(var_f2d3509b) && isdefined(var_6fbfab22) && isdefined(var_94ba5d46) && isdefined(var_37de1ab0) && isdefined(var_47aacc14) && isdefined(var_b56373f4) && isdefined(var_d0bfea4f) && isdefined(var_8a88851e)) {
                break;
            }
        }
        var_66462c43 = [];
        var_db0a6a5e = function_60374d7d(var_f2d3509b.target);
        var_7a943bd3 = function_60374d7d(var_6fbfab22.target);
        var_f0efbfc7 = function_60374d7d(var_94ba5d46.target);
        var_f259b645 = function_60374d7d(var_37de1ab0.target);
        var_dd806022 = function_60374d7d(var_47aacc14.target);
        var_a100cb99 = function_60374d7d(var_b56373f4.target);
        var_32b647ca = function_60374d7d(var_d0bfea4f.target);
        var_32a373a4 = function_60374d7d(var_8a88851e.target);
        var_66462c43 = arraycombine(var_66462c43, var_db0a6a5e, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_7a943bd3, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_f0efbfc7, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_f259b645, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_dd806022, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_a100cb99, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_32b647ca, 0, 0);
        var_66462c43 = arraycombine(var_66462c43, var_32a373a4, 0, 0);
        level flag::wait_till("<dev string:x297>");
        player = level.players[0];
        n_index = 0;
        var_34d0402f = 0;
        while (getdvarint(#"hash_574de6ff609cc0b1", 0) && isalive(player)) {
            if (player util::up_button_pressed()) {
                if (n_index < var_66462c43.size - 1) {
                    n_index++;
                } else {
                    n_index = 0;
                }
            } else if (player util::down_button_pressed()) {
                if (n_index == 0) {
                    n_index = var_66462c43.size - 1;
                } else {
                    n_index--;
                }
            }
            if (n_index != var_34d0402f) {
                player setorigin(var_66462c43[n_index].origin);
                player setplayerangles((0, var_66462c43[n_index].angles[1], 0));
                var_34d0402f = n_index;
                wait 0.1;
            }
            waitframe(1);
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 1, eflags: 0x0
    // Checksum 0x3b426e72, Offset: 0x3848
    // Size: 0xaa
    function function_4ff10f7f(str_type) {
        switch (str_type) {
        case #"atv_spawn":
            return (0, 0, 1);
        case #"cargo_truck_spawn":
        case #"cargo_truck_clearing_spawn":
            return (1, 0, 1);
        case #"heli_spawn":
        case #"heli_clearing_spawn":
            return (1, 0, 0);
        default:
            return (1, 0.5, 0);
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x7f0e4237, Offset: 0x3900
    // Size: 0x436
    function function_d5c7d7f2() {
        if (!getdvarint(#"hash_57a9b32c8a8503f1", 0) || !self function_1f039d4a()) {
            return;
        }
        self endon(#"death");
        if (!isdefined(level.var_d10a3881)) {
            level.var_d10a3881 = [];
        }
        if (!isdefined(level.var_d10a3881[function_15979fa9(self.vehicletype)])) {
            level.var_d10a3881[function_15979fa9(self.vehicletype)] = [];
        }
        if (!isdefined(level.var_d10a3881[function_15979fa9(self.vehicletype)])) {
            level.var_d10a3881[function_15979fa9(self.vehicletype)] = [];
        } else if (!isarray(level.var_d10a3881[function_15979fa9(self.vehicletype)])) {
            level.var_d10a3881[function_15979fa9(self.vehicletype)] = array(level.var_d10a3881[function_15979fa9(self.vehicletype)]);
        }
        level.var_d10a3881[function_15979fa9(self.vehicletype)][level.var_d10a3881[function_15979fa9(self.vehicletype)].size] = self;
        v_spawn_pos = self.origin;
        level thread function_a95830a0();
        level flag::wait_till("<dev string:x2b8>");
        str_type = function_15979fa9(self.vehicletype);
        v_color = self function_ea93c2ea();
        while (getdvarint(#"hash_57a9b32c8a8503f1", 0)) {
            var_2cb5c9e8 = distance2d(level.players[0].origin, self.origin);
            n_radius = 0.015 * var_2cb5c9e8;
            if (n_radius > 768) {
                n_radius = 768;
            }
            if (var_2cb5c9e8 > 768) {
                sphere(self.origin, n_radius, v_color);
                if (var_2cb5c9e8 < 2048) {
                    print3d(self.origin + (0, 0, 32), str_type, v_color);
                }
            }
            if (getdvarint(#"hash_491fd7f96bbc8909", 0) && distance2d(v_spawn_pos, self.origin) > 768) {
                line(v_spawn_pos, self.origin, v_color);
                circle(v_spawn_pos, 64, v_color, 0, 1);
            }
            waitframe(1);
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x5491882f, Offset: 0x3d40
    // Size: 0x22e
    function function_a95830a0() {
        level notify(#"hash_79845fe0e187bb22");
        level endon(#"hash_79845fe0e187bb22");
        while (getdvarint(#"hash_57a9b32c8a8503f1", 0)) {
            n_total = 0;
            var_430cd17b = 176;
            foreach (var_10c27616 in level.var_d10a3881) {
                var_430cd17b += 24;
                n_total += var_10c27616.size;
                foreach (var_bd907136 in var_10c27616) {
                    if (isvehicle(var_bd907136)) {
                        debug2dtext((810, var_430cd17b, 0), function_15979fa9(var_10c27616[0].vehicletype) + "<dev string:x2cd>" + var_10c27616.size, var_bd907136 function_ea93c2ea());
                        break;
                    }
                }
            }
            debug2dtext((810, 176, 0), "<dev string:x2d0>" + n_total, (1, 1, 1));
            waitframe(1);
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0xb10fb203, Offset: 0x3f78
    // Size: 0x18e
    function function_1f039d4a() {
        a_str_types = array(#"vehicle_boct_mil_truck_cargo_wz_dark", #"vehicle_boct_mil_truck_cargo_wz_green", #"vehicle_boct_mil_truck_cargo_wz_tan", #"vehicle_boct_mil_boat_tactical_raft_wz_blk", #"vehicle_boct_mil_boat_tactical_raft_wz_gry", #"vehicle_boct_mil_boat_tactical_raft_wz_odg", #"veh_quad_player_wz_blk", #"hash_232abda4e81275f4", #"veh_quad_player_wz_grn", #"hash_2f8d60a5381870ee", #"veh_quad_player_wz_tan", #"vehicle_t8_mil_helicopter_light_transport_wz_grey", #"vehicle_t8_mil_helicopter_light_transport_wz_tan", #"vehicle_t8_mil_helicopter_light_transport_wz_dark", #"vehicle_t8_mil_helicopter_light_transport_wz_black");
        foreach (str_type in a_str_types) {
            if (self.vehicletype == str_type) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x22bf0819, Offset: 0x4110
    // Size: 0x112
    function function_ea93c2ea() {
        switch (self.vehicletype) {
        case #"veh_quad_player_wz_tan":
        case #"veh_quad_player_wz_blk":
        case #"hash_232abda4e81275f4":
        case #"hash_2f8d60a5381870ee":
        case #"veh_quad_player_wz_grn":
            return (0, 0, 1);
        case #"vehicle_t8_mil_helicopter_light_transport_wz_black":
        case #"vehicle_t8_mil_helicopter_light_transport_wz_tan":
        case #"vehicle_t8_mil_helicopter_light_transport_wz_grey":
        case #"vehicle_t8_mil_helicopter_light_transport_wz_dark":
            return (1, 0, 0);
        case #"vehicle_boct_mil_boat_tactical_raft_wz_blk":
        case #"vehicle_boct_mil_boat_tactical_raft_wz_gry":
        case #"vehicle_boct_mil_boat_tactical_raft_wz_odg":
            return (1, 0.5, 0);
        default:
            return (1, 0, 1);
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x6c9fdeed, Offset: 0x4230
    // Size: 0x218
    function function_887896b8() {
        if (!getdvarint(#"hash_9af4a204686e76d", 0) || !self function_1f039d4a()) {
            return;
        }
        self endon(#"death", #"hash_57887008fa0fd8ad");
        self util::delay("<dev string:x2e7>", undefined, &function_710a6890);
        level flag::wait_till("<dev string:x2b8>");
        while (getdvarint(#"hash_9af4a204686e76d", 0)) {
            waitframe(1);
            if (distance2d(level.players[0].origin, self.origin) > 1024) {
                continue;
            }
            n_depth = getwaterheight(self.origin) - self.origin[2];
            var_c7f9f3f1 = self.origin + (0, 0, n_depth);
            print3d(self.origin, "<dev string:x2f5>" + n_depth, (0, 1, 0), 1, 0.6);
            circle(var_c7f9f3f1, 16, (0, 1, 0), 0, 1);
            debugstar(self.origin, 1, (0, 1, 0));
            line(self.origin, var_c7f9f3f1, (0, 1, 0));
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x25adce2, Offset: 0x4450
    // Size: 0x180
    function function_710a6890() {
        self endon(#"death");
        level flag::wait_till("<dev string:x2b8>");
        while (getdvarint(#"hash_9af4a204686e76d", 0)) {
            waitframe(1);
            if (distance2d(level.players[0].origin, self.origin) > 1024) {
                continue;
            }
            n_depth = self depthinwater();
            var_c7f9f3f1 = self.origin + (0, 0, n_depth);
            print3d(self.origin, "<dev string:x2f5>" + n_depth, (1, 0, 0), 1, 0.6);
            circle(var_c7f9f3f1, 16, (1, 0, 0), 0, 1);
            debugstar(self.origin, 1, (1, 0, 0));
            line(self.origin, var_c7f9f3f1, (1, 0, 0));
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x20021753, Offset: 0x45d8
    // Size: 0xfe
    function function_acb51d6b() {
        if (!getdvarint(#"hash_9af4a204686e76d", 0)) {
            return;
        }
        self endon(#"death", #"disconnect");
        while (getdvarint(#"hash_9af4a204686e76d", 0)) {
            n_height = getwaterheight(self.origin) - self.origin[2];
            if (n_height > 0) {
                debug2dtext((810, 768, 0), "<dev string:x306>" + n_height, (0, 0, 1));
            }
            waitframe(1);
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x97295e73, Offset: 0x46e0
    // Size: 0x336
    function function_5528ad07() {
        if (!getdvarint(#"hash_363b1c69ef9f1237", 0)) {
            return;
        }
        self endon(#"death", #"disconnect");
        var_4d4a49d0 = util::spawn_model("<dev string:x315>");
        self thread util::delete_on_death_or_notify(var_4d4a49d0, "<dev string:x320>");
        while (getdvarint(#"hash_363b1c69ef9f1237", 0)) {
            v_eye = self geteye();
            a_trace = bullettrace(v_eye, v_eye + vectorscale(anglestoforward(self getplayerangles()), 1000000), 0, self);
            var_4d4a49d0.origin = a_trace[#"position"];
            n_depth = getwaterheight(var_4d4a49d0.origin) - var_4d4a49d0.origin[2];
            var_c7f9f3f1 = var_4d4a49d0.origin + (0, 0, n_depth);
            v_color = (1, 0, 0);
            if (n_depth > 0) {
                v_color = (0, 0, 1);
            }
            var_2cb5c9e8 = distance2d(self getorigin(), var_4d4a49d0.origin);
            n_radius = 0.015 * var_2cb5c9e8;
            if (n_radius > 768) {
                n_radius = 768;
            }
            print3d(var_4d4a49d0.origin, "<dev string:x2f5>" + n_depth, v_color, 1, 0.6);
            circle(var_c7f9f3f1, 96, (0, 1, 0), 0, 1);
            sphere(var_4d4a49d0.origin, n_radius, v_color);
            line(var_4d4a49d0.origin, var_c7f9f3f1, v_color);
            debug2dtext((810, 635, 0), "<dev string:x32b>" + n_depth, v_color);
            waitframe(1);
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0xf4a4c589, Offset: 0x4a20
    // Size: 0x298
    function function_af672f88() {
        if (!getdvarint(#"hash_184bc9c4871144d3", 0) || !self function_1f039d4a()) {
            return;
        }
        level flag::wait_till("<dev string:x2b8>");
        while (isdefined(self) && getdvarint(#"hash_184bc9c4871144d3", 0)) {
            waitframe(1);
            if (distance2d(self getorigin(), level.players[0] getorigin()) > 768) {
                continue;
            }
            var_8a8714ac = self.origin + vectorscale(anglestoforward(self.angles), self.radiusdamageradius);
            var_cde20d60 = self.origin + vectorscale(anglestoforward(self.angles), self.radiusdamageradius / 2);
            print3d(self.origin, "<dev string:x339>" + self.radiusdamagemax, (1, 0, 0));
            print3d(var_8a8714ac, "<dev string:x348>" + self.radiusdamagemin, (1, 1, 0));
            print3d(var_cde20d60, "<dev string:x357>" + self.radiusdamageradius, (1, 0.5, 0));
            sphere(self.origin, 8, (1, 0, 0));
            circle(self.origin, self.radiusdamageradius, (1, 0, 0), 0, 1);
            line(self.origin, var_8a8714ac, (1, 0.5, 0));
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x6b197010, Offset: 0x4cc0
    // Size: 0x220
    function function_7fdaca5a() {
        if (!getdvarint(#"hash_184bc9c4871144d3", 0)) {
            return;
        }
        self endon(#"death", #"disconnect");
        while (getdvarint(#"hash_184bc9c4871144d3", 0)) {
            waitframe(2);
            if (!getdvarint(#"hash_639a741f419f5790", 0)) {
                continue;
            }
            setdvar(#"hash_639a741f419f5790", 0);
            foreach (var_10c27616 in level.var_d10a3881) {
                foreach (var_9f7fd4a1 in var_10c27616) {
                    if (distance2d(self getorigin(), var_9f7fd4a1.origin) <= var_9f7fd4a1.radiusdamageradius) {
                        self val::set(#"warzonestaging", "<dev string:x367>", 1);
                        var_9f7fd4a1 dodamage(100000, var_9f7fd4a1.origin);
                    }
                }
            }
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x18c6683e, Offset: 0x4ee8
    // Size: 0xb10
    function function_8b1b1c67() {
        if (!getdvarint(#"hash_68dcd0d52e11b957", 0)) {
            return;
        }
        var_84da048b = 0;
        var_d0abd405 = 0;
        var_2e9d401a = [];
        item_spawn_groups = struct::get_array("<dev string:x272>", "<dev string:x28d>");
        foreach (group in item_spawn_groups) {
            group.debug_spawnpoints = [];
            if (isstring(group.target)) {
                group.debug_spawnpoints = function_60374d7d(group.target);
            }
        }
        var_ee8282e2 = [];
        level flag::wait_till("<dev string:x2b8>");
        level.players[0] endon(#"disconnect");
        adddebugcommand("<dev string:x26b>");
        while (getdvarint(#"hash_68dcd0d52e11b957", 0)) {
            waitframe(1);
            foreach (group in item_spawn_groups) {
                if (isdefined(group.itemlistbundle) && isdefined(group.itemlistbundle.vehiclespawner) && group.itemlistbundle.vehiclespawner || group.debug_spawnpoints.size == 0) {
                    continue;
                }
                spawn_points = arraysortclosest(group.debug_spawnpoints, level.players[0].origin, 85, 1, 4000);
                foreach (point in spawn_points) {
                    if (level.players[0] util::is_player_looking_at(point.origin, 0.8, 0)) {
                        b_failed = 0;
                        v_color = (0, 1, 0);
                        n_radius = 4;
                        var_ee8282e2 = [];
                        var_51c36871 = 360 / 8;
                        v_angles = point.angles;
                        var_2394228d = undefined;
                        var_79bbe416 = 28;
                        if (isdefined(group.itemlistbundle) && isdefined(group.itemlistbundle.supplystash) && group.itemlistbundle.supplystash) {
                            if (isdefined(point.radius)) {
                                var_79bbe416 = point.radius;
                            }
                            draw_arrow(point.origin, point.angles, v_color);
                        }
                        for (i = 0; i < 8; i++) {
                            var_ee8282e2[i] = point.origin + (0, 0, 12) + vectorscale(anglestoforward(v_angles), var_79bbe416);
                            v_angles = point.angles + (0, var_51c36871, 0);
                        }
                        var_b5e29d52 = arraysortclosest(spawn_points, point.origin, 20, 1, 32);
                        foreach (close in var_b5e29d52) {
                            if (bullettracepassed(point.origin + (0, 0, 12), close.origin, 0, level.players[0])) {
                                v_color = (0, 0, 1);
                                b_failed = 1;
                                line(close.origin, point.origin, v_color);
                                circle(point.origin, 32 / 2, v_color, 0, 1);
                                print3d(point.origin + (0, 0, 24), sqrt(distancesquared(point.origin, close.origin)), v_color, 1, 0.3);
                            }
                        }
                        foreach (v_test in var_ee8282e2) {
                            a_trace = bullettrace(point.origin + (0, 0, 12), v_test, 0, level.players[0]);
                            if (isdefined(a_trace[#"entity"])) {
                                v_color = (1, 0, 1);
                                a_trace = bullettrace(point.origin + (0, 0, 12), v_test, 0, a_trace[#"entity"]);
                            }
                            if (distancesquared(a_trace[#"position"], point.origin + (0, 0, 12)) < var_79bbe416 * var_79bbe416 - 2) {
                                v_color = (1, 0, 0);
                                b_failed = 1;
                                if (distance2d(point.origin, level.players[0] getorigin()) < 256) {
                                    debugstar(a_trace[#"position"], 1, v_color);
                                }
                            }
                        }
                        if (b_failed) {
                            var_2cb5c9e8 = distance2d(level.players[0].origin, point.origin);
                            n_radius = 0.015 * var_2cb5c9e8;
                            if (n_radius > 32) {
                                n_radius = 32;
                            }
                        }
                        sphere(point.origin, n_radius, v_color);
                        if (bullettracepassed(point.origin, level.players[0] geteye(), 0, level.players[0], var_2394228d)) {
                            circle(point.origin, var_79bbe416, v_color, 0, 1);
                            if (distance2d(point.origin, level.players[0].origin) < 512) {
                                print3d(point.origin, function_15979fa9(point.targetname), v_color, 1, 0.4);
                                if (distance2d(point.origin, level.players[0].origin) < 256 && level.players[0] util::is_player_looking_at(point.origin, 0.87, 0)) {
                                    print3d(point.origin + (0, 0, 12), point.origin, v_color, 1, 0.3);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 1, eflags: 0x0
    // Checksum 0xb596c25b, Offset: 0x5a00
    // Size: 0x1c8
    function function_ae8435d1(a_points) {
        if (a_points.size < 0) {
            return;
        }
        level.players[0] endon(#"disconnect");
        while (getdvarint(#"hash_68dcd0d52e11b957", 0)) {
            foreach (point in a_points) {
                do {
                    waitframe(1);
                } while (!level.players[0] jumpbuttonpressed() || !level.players[0] isinmovemode("<dev string:x26b>"));
                level.players[0] setorigin(point.origin + vectorscale(anglestoforward(point.angles), 160));
                level.players[0] setplayerangles(point.angles + (18, 180, 0));
                while (level.players[0] jumpbuttonpressed()) {
                    waitframe(1);
                }
            }
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 3, eflags: 0x0
    // Checksum 0x43224aad, Offset: 0x5bd0
    // Size: 0x2fc
    function draw_arrow(org, ang, opcolor) {
        forward = anglestoforward(ang);
        forwardfar = vectorscale(forward, 50);
        forwardclose = vectorscale(forward, 50 * 0.8);
        right = anglestoright(ang);
        left = anglestoright(ang) * -1;
        leftdraw = vectorscale(right, 50 * -0.2);
        rightdraw = vectorscale(right, 50 * 0.2);
        up = anglestoup(ang);
        right = vectorscale(right, 50);
        left = vectorscale(left, 50);
        up = vectorscale(up, 50);
        red = (0.9, 0.2, 0.2);
        green = (0.2, 0.9, 0.2);
        blue = (0.2, 0.2, 0.9);
        if (isdefined(opcolor)) {
            red = opcolor;
            green = opcolor;
            blue = opcolor;
        }
        line(org, org + forwardfar, red, 0.9);
        line(org + forwardfar, org + forwardclose + rightdraw, red, 0.9);
        line(org + forwardfar, org + forwardclose + leftdraw, red, 0.9);
        line(org, org + right, blue, 0.9);
        line(org, org + left, blue, 0.9);
        line(org, org + up, green, 0.9);
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 1, eflags: 0x0
    // Checksum 0x17fe8b30, Offset: 0x5ed8
    // Size: 0x1f6
    function function_3be92bb0(item_spawn_groups) {
        n_total = 0;
        foreach (group in item_spawn_groups) {
            n_total += group.debug_spawnpoints.size;
        }
        while (getdvarint(#"hash_4701ef1aeafb2f3", 0)) {
            var_430cd17b = 50;
            foreach (group in item_spawn_groups) {
                if (isstring(group.target)) {
                    var_430cd17b += 24;
                    debug2dtext((1300, var_430cd17b, 0), group.target + "<dev string:x2cd>" + group.debug_spawnpoints.size, (1, 1, 1), 1, (0, 0, 0), 0.75);
                }
            }
            debug2dtext((1300, 50, 0), "<dev string:x372>" + n_total, (1, 1, 1));
            waitframe(1);
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 7, eflags: 0x0
    // Checksum 0x67ae7844, Offset: 0x60d8
    // Size: 0x5d6
    function function_4592970c(item_spawn_groups, group, point, var_f17060e6, var_cd1c9299, n_z, n_dist) {
        b_failed = 0;
        b_close = 0;
        v_color = (0, 1, 0);
        var_ee8282e2 = [];
        var_51c36871 = 360 / var_f17060e6;
        v_angles = point.angles;
        var_2394228d = undefined;
        if (isdefined(group.itemlistbundle) && isdefined(group.itemlistbundle.vehiclespawner) && group.itemlistbundle.vehiclespawner) {
            return 1;
        }
        if (isdefined(group.itemlistbundle) && isdefined(group.itemlistbundle.supplystash) && group.itemlistbundle.supplystash) {
            if (isdefined(point.radius)) {
                var_cd1c9299 = point.radius;
            }
        }
        for (i = 0; i < var_f17060e6; i++) {
            var_ee8282e2[i] = point.origin + (0, 0, n_z) + vectorscale(anglestoforward(v_angles), var_cd1c9299);
            v_angles = point.angles + (0, var_51c36871, 0);
        }
        var_ee8282e2[i + 1] = point.origin + (0, 0, n_z) + vectorscale(anglestoup(point.angles), var_cd1c9299);
        foreach (group in item_spawn_groups) {
            if (isarray(group.debug_spawnpoints)) {
                var_b5e29d52 = arraysortclosest(group.debug_spawnpoints, point.origin, 20, 1, n_dist);
                foreach (close in var_b5e29d52) {
                    if (bullettracepassed(point.origin + (0, 0, n_z), close.origin, 0, level.players[0])) {
                        print("<dev string:x37a>" + function_15979fa9(point.targetname) + "<dev string:x38d>" + point.origin + "<dev string:x392>" + close.origin + "<dev string:x3b2>");
                        b_close = 1;
                    }
                }
            }
        }
        foreach (v_test in var_ee8282e2) {
            a_trace = bullettrace(point.origin + (0, 0, n_z), v_test, 0, level.players[0]);
            if (isvehicle(a_trace[#"entity"])) {
                var_2394228d = a_trace[#"entity"];
                a_trace = bullettrace(point.origin + (0, 0, n_z), v_test, 0, var_2394228d);
            }
            if (distancesquared(a_trace[#"position"], point.origin + (0, 0, n_z)) < var_cd1c9299 * var_cd1c9299 - 2) {
                b_failed = 1;
            }
        }
        if (b_failed) {
            print("<dev string:x37a>" + function_15979fa9(point.targetname) + "<dev string:x38d>" + point.origin + "<dev string:x3b4>" + "<dev string:x3b2>");
            return 0;
        } else if (b_close) {
            return 0;
        }
        return 1;
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x10f58875, Offset: 0x66b8
    // Size: 0x352
    function function_1337221() {
        var_5b8f35e5 = 1;
        tracepoint = undefined;
        while (true) {
            waitframe(1);
            if (getdvarint(#"hash_5fd194403e0d175e", 0) || getdvarint(#"hash_27e2616ae4b57202", 1) != var_5b8f35e5) {
                player = level.players[0];
                weapon = player getcurrentweapon();
                if (weapon.firetype == "<dev string:x3d0>") {
                    continue;
                }
                level notify(#"hash_7e565f1e80f93ecd");
                if (getdvarint(#"hash_5fd194403e0d175e", 0) || !isdefined(tracepoint)) {
                    players = getplayers();
                    if (players.size <= 0) {
                        continue;
                    }
                    player = players[0];
                    direction = player getplayerangles();
                    direction_vec = anglestoforward(direction);
                    eye = player geteye();
                    eye = (eye[0], eye[1], eye[2] + 20);
                    trace = bullettrace(eye, eye + vectorscale(direction_vec, 100000), 1, player);
                    tracepoint = trace[#"position"];
                }
                setdvar(#"hash_5fd194403e0d175e", 0);
                switch (getdvarint(#"hash_27e2616ae4b57202", 1)) {
                case 1:
                    thread function_aae07832(tracepoint, weapon, (0, 1, 0));
                    break;
                case 2:
                    thread function_aae07832(tracepoint, weapon, (0, 1, 0), 0);
                    break;
                case 3:
                    thread function_d2d1ffa7(tracepoint, weapon);
                    break;
                }
                var_5b8f35e5 = getdvarint(#"hash_27e2616ae4b57202", 1);
            }
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 2, eflags: 0x0
    // Checksum 0x4a0d2124, Offset: 0x6a18
    // Size: 0x2a2
    function function_d2d1ffa7(tracepoint, weapon) {
        var_5d42a66a = 1.31908;
        var_5fafa417 = 0.7;
        distance = 0;
        var_bf3e4727 = 3000;
        var_dec3bbba = weapon.muzzlevelocity;
        base_damage = weapon.damagevalues[0];
        var_8d66a859 = weapon.var_e9b578bc;
        var_f7a395b1 = weapon.var_1b5cd615;
        var_74dc8698 = weapon.mass;
        var_6f0960d3 = var_8d66a859 / 2 * var_8d66a859 / 2 * 3.14159 * 1e-06;
        vel = var_dec3bbba * var_5fafa417;
        thread function_cbcf5888(tracepoint, distance * 39.3701, int(base_damage), (0, 1, 0));
        i = 0;
        while (true) {
            new_vel = vel - vel * vel * 0.5 * var_5d42a66a * var_6f0960d3 * var_f7a395b1 / var_74dc8698 * 6.47989e-05 * 16 / 1000;
            distance += (vel + new_vel) / 2 * 16 / 1000;
            vel = new_vel;
            var_acd09b9c = vel / var_dec3bbba * var_5fafa417;
            damage = base_damage * var_acd09b9c;
            i++;
            if (int(damage) < var_bf3e4727) {
                thread function_cbcf5888(tracepoint, distance * 39.3701, int(damage), (0, 1, 0));
                var_bf3e4727 = int(damage);
                if (i > 25) {
                    break;
                }
            }
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 4, eflags: 0x0
    // Checksum 0xfda78553, Offset: 0x6cc8
    // Size: 0x17e
    function function_aae07832(tracepoint, weapon, color, mp) {
        if (!isdefined(mp)) {
            mp = 1;
        }
        var_e33d5bcc = weapon.damagevalues;
        var_6a48cf98 = weapon.var_2fa81c78;
        for (i = 0; i < var_e33d5bcc.size; i++) {
            if (var_e33d5bcc[i] == 0) {
                arrayremoveindex(var_e33d5bcc, i);
                arrayremoveindex(var_6a48cf98, i);
                i--;
            }
        }
        thread function_cbcf5888(tracepoint, 0, var_e33d5bcc[0], color);
        for (i = 1; i < var_e33d5bcc.size; i++) {
            if (mp == 0) {
                var_6a48cf98[i - 1] = var_6a48cf98[i - 1] * 1.5;
            }
            thread function_cbcf5888(tracepoint, var_6a48cf98[i - 1], var_e33d5bcc[i], color);
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 4, eflags: 0x0
    // Checksum 0xf72bc059, Offset: 0x6e50
    // Size: 0x34e
    function function_cbcf5888(tracepoint, radius, var_8ec7c4a9, color) {
        self endon(#"hash_7e565f1e80f93ecd");
        while (!getdvarint(#"hash_5fd194403e0d175e", 0)) {
            if (radius > 1000) {
                scale = radius / 500;
            } else {
                scale = 2;
            }
            circle(tracepoint, radius, color, 0, 1);
            var_4b33334f = tracepoint + (radius, 0, 0);
            print3d(var_4b33334f, var_8ec7c4a9, (1, 1, 1), 1, scale, 3);
            var_4b33334f = tracepoint + (radius, 0, -10 * scale);
            print3d(var_4b33334f, int(radius), (1, 0, 0), 1, scale * 0.25, 3);
            var_4b33334f = tracepoint - (radius, 0, 0);
            print3d(var_4b33334f, var_8ec7c4a9, (1, 1, 1), 1, scale, 3);
            var_4b33334f = tracepoint - (radius, 0, 10 * scale);
            print3d(var_4b33334f, int(radius), (1, 0, 0), 1, scale * 0.25, 3);
            var_4b33334f = tracepoint + (0, radius, 0);
            print3d(var_4b33334f, var_8ec7c4a9, (1, 1, 1), 1, scale, 3);
            var_4b33334f = tracepoint + (0, radius, -10 * scale);
            print3d(var_4b33334f, int(radius), (1, 0, 0), 1, scale * 0.25, 3);
            var_4b33334f = tracepoint - (0, radius, 0);
            print3d(var_4b33334f, var_8ec7c4a9, (1, 1, 1), 1, scale, 3);
            var_4b33334f = tracepoint - (0, radius, 10 * scale);
            print3d(var_4b33334f, int(radius), (1, 0, 0), 1, scale * 0.25, 3);
            waitframe(1);
        }
    }

    // Namespace wz_open_skyscrapers/wz_open_skyscrapers
    // Params 0, eflags: 0x0
    // Checksum 0x6736f405, Offset: 0x71a8
    // Size: 0x1a6
    function function_a361250f() {
        /#
            if (!getdvarint(#"hash_270a21a654a1a79f", 0)) {
                return;
            }
            level waittill(#"all_players_spawned");
            if (!isdefined(level.totalspawnpoints)) {
                return;
            }
            player = util::gethostplayer();
            n_index = 0;
            var_34d0402f = 0;
            wait 3;
            while (true) {
                if (player util::up_button_pressed()) {
                    if (n_index < level.totalspawnpoints.size - 1) {
                        n_index++;
                    } else {
                        n_index = 0;
                    }
                } else if (player util::down_button_pressed()) {
                    if (n_index == 0) {
                        n_index = level.totalspawnpoints.size - 1;
                    } else {
                        n_index--;
                    }
                }
                if (n_index != var_34d0402f) {
                    player setorigin(level.totalspawnpoints[n_index].origin);
                    player setplayerangles((0, level.totalspawnpoints[n_index].angles[1], 0));
                    var_34d0402f = n_index;
                    wait 0.1;
                }
                waitframe(1);
            }
        #/
    }

#/
