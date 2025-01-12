#using script_204174a1886a3804;
#using script_255cce8e576b66e;
#using script_335d0650ed05d36d;
#using script_3d703ef87a841fe4;
#using script_45fdb6cec5580007;
#using script_5495f0bb06045dc7;
#using script_55c2d94254efcd82;
#using script_5dda2f8ad39ce695;
#using script_61a71b9d957cbef4;
#using script_c8d806d2487b617;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\player\player_free_fall;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\player\player_reinsertion;
#using scripts\core_common\struct;
#using scripts\core_common\values_shared;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\player\player_loadout;
#using scripts\wz_common\hud;
#using scripts\wz_common\player;
#using scripts\wz_common\vehicle;
#using scripts\wz_common\wz_ignore_systems;
#using scripts\wz_common\wz_loadouts;
#using scripts\wz_common\wz_rat;

#namespace incursion;

// Namespace incursion/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xb795c427, Offset: 0x208
// Size: 0x1ec
function event_handler[gametype_init] main(*eventstruct) {
    namespace_17baa64d::init();
    spawning::addsupportedspawnpointtype("tdm");
    callback::on_game_playing(&start_warzone);
    callback::on_spawned(&on_player_spawned);
    callback::on_disconnect(&on_player_disconnect);
    callback::add_callback(#"hash_1002f619f2d58b36", &function_ba5141a9);
    level.onstartgametype = &on_start_game_type;
    level.onroundswitch = &on_round_switch;
    level.givecustomloadout = &give_custom_loadout;
    level.var_c4dc9178 = &function_f81c3cc9;
    level.var_5c14d2e6 = &function_b82fbeb8;
    level.var_8485ede4 = incursion_infiltrationtitlecards::register();
    level.var_fa15aec0 = [];
    level.var_331fe94b = &function_e4c15209;
    function_5312ef7e();
    namespace_85b8212e::function_dd83b835();
    if (!is_true(level.var_d0252074)) {
        callback::on_player_killed(&function_7d709aa4);
        player_reinsertion::function_b5ee47fa(&function_807b902);
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x4
// Checksum 0xc6f72ebd, Offset: 0x400
// Size: 0x2c
function private function_ba5141a9(*var_9bbce2cd) {
    level.numlives = 1;
    level.var_c2cc011f = 1;
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0xed05a706, Offset: 0x438
// Size: 0xc4
function function_b82fbeb8() {
    assert(isplayer(self));
    if (!isplayer(self) || !isalive(self)) {
        return;
    }
    if (item_world::function_1b11e73c()) {
        while (isdefined(self) && !isdefined(self.inventory)) {
            waitframe(1);
        }
        if (!isdefined(self)) {
            return;
        }
        namespace_ba4f7a20::function_e97afe1(self, 0, &function_75256bef);
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0x9eede391, Offset: 0x508
// Size: 0x4c
function function_75256bef(*itemname) {
    if (is_true(self.var_8f9dd238)) {
        return true;
    }
    return randomfloatrange(0, 1) < 0.5;
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0x959b4bd8, Offset: 0x560
// Size: 0x34
function on_start_game_type() {
    namespace_17baa64d::on_start_game_type();
    setdvar(#"hash_2b903fa2368b18c9", 0);
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0x24eec552, Offset: 0x5a0
// Size: 0x4c
function start_warzone() {
    level thread function_4523532a();
    level thread function_fbb2b180();
    wait 11;
    namespace_84ec8f9b::start();
}

// Namespace incursion/incursion
// Params 0, eflags: 0x4
// Checksum 0x17654be5, Offset: 0x5f8
// Size: 0xe4
function private function_fbb2b180() {
    function_3ca3c6e4();
    resetglass();
    if (isdefined(level.var_82eb1dab)) {
        foreach (deathmodel in level.var_82eb1dab) {
            deathmodel delete();
        }
        level.var_82eb1dab = undefined;
    }
    level flag::set(#"hash_507a4486c4a79f1d");
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0xef2baedf, Offset: 0x6e8
// Size: 0xd4
function on_player_spawned() {
    if (isdefined(self.var_b7cc4567)) {
        self.var_b7cc4567 = undefined;
        waitframe(1);
        self player_free_fall::function_7705a7fc(0);
    }
    if (game.state == "pregame") {
        /#
            if (getdvarint(#"scr_disable_infiltration", 0)) {
                return;
            }
        #/
        level function_e20a4f1f(self.squad);
        level function_62251c0(self.squad);
        level function_828e89e7(self.squad);
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0x7508c4b4, Offset: 0x7c8
// Size: 0xf0
function function_e4c15209(var_4c542e39) {
    players = getplayers(var_4c542e39);
    if (players.size >= level.var_704bcca1) {
        return var_4c542e39;
    }
    foreach (team in level.teams) {
        players = getplayers(team);
        if (players.size < level.var_704bcca1) {
            return team;
        }
    }
    return var_4c542e39;
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0xaf4c8b2d, Offset: 0x8c0
// Size: 0x84
function on_player_disconnect() {
    if (game.state == "pregame") {
        /#
            if (getdvarint(#"scr_disable_infiltration", 0)) {
                return;
            }
        #/
        level function_62251c0(self.squad);
        level function_828e89e7(self.squad);
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0x939fe90a, Offset: 0x950
// Size: 0x24
function on_spawn_player(predictedspawn) {
    namespace_17baa64d::on_spawn_player(predictedspawn);
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0x9b6cd6c1, Offset: 0x980
// Size: 0x24
function on_round_switch() {
    gametype::on_round_switch();
    globallogic_score::function_9779ac61();
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0x650f982c, Offset: 0x9b0
// Size: 0x340
function give_custom_loadout(takeoldweapon = 0) {
    self loadout::init_player(!takeoldweapon);
    if (takeoldweapon) {
        oldweapon = self getcurrentweapon();
        weapons = self getweaponslist();
        foreach (weapon in weapons) {
            self takeweapon(weapon);
        }
    }
    nullprimary = getweapon(#"null_offhand_primary");
    self giveweapon(nullprimary);
    self setweaponammoclip(nullprimary, 0);
    self switchtooffhand(nullprimary);
    if (self.firstspawn !== 0) {
        hud::function_2f66bc37();
    }
    healthgadget = getweapon(#"hash_5a7fd1af4a1d5c9");
    self giveweapon(healthgadget);
    self setweaponammoclip(healthgadget, 0);
    self switchtooffhand(healthgadget);
    level.var_ef61b4b5 = healthgadget;
    var_fb6490c8 = self gadgetgetslot(healthgadget);
    self gadgetpowerset(var_fb6490c8, 0);
    bare_hands = getweapon(#"bare_hands");
    self giveweapon(bare_hands);
    self function_c9a111a(bare_hands);
    self switchtoweapon(bare_hands, 1);
    if (self.firstspawn !== 0) {
        self setspawnweapon(bare_hands);
    }
    self.specialty = self getloadoutperks(0);
    self loadout::register_perks();
    self thread give_default_class();
    return bare_hands;
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0xf86fd520, Offset: 0xcf8
// Size: 0x74
function give_default_class() {
    self endon(#"death");
    waitframe(1);
    item_world::function_1b11e73c();
    while (isdefined(self) && !isdefined(self.inventory)) {
        waitframe(1);
    }
    if (!isdefined(self)) {
        return;
    }
    item_inventory::reset_inventory(0);
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0x9d095896, Offset: 0xd78
// Size: 0x138
function function_f81c3cc9(player) {
    if (!is_true(level.droppedtagrespawn)) {
        return;
    }
    victim = self.victim;
    if (player.pers[#"team"] == self.victimteam) {
        player.pers[#"rescues"]++;
        player.rescues = player.pers[#"rescues"];
        if (isdefined(victim)) {
            if (!level.gameended) {
                victim.pers[#"lives"] = 1;
                victim.var_b7cc4567 = {#origin:player.origin + (0, 0, 10000), #angles:player.angles};
                victim thread [[ level.spawnclient ]]();
                victim notify(#"force_spawn");
            }
        }
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0xe90b8d6d, Offset: 0xeb8
// Size: 0x9a
function function_b23c406e(infiltration) {
    switch (infiltration) {
    case 0:
        return #"hash_41af72ac3698f06f";
    case 2:
        return #"hash_386af01523f194e5";
    case 1:
        return #"hash_55a524ad199904e9";
    case 3:
        return #"hash_55e75da288d110d4";
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0x8117eb6b, Offset: 0xf60
// Size: 0x9a
function function_b3d1fd4(infiltration) {
    switch (infiltration) {
    case 0:
        return #"hash_5b1f56f3d27d25f0";
    case 2:
        return #"hash_c5a40437efffe76";
    case 1:
        return #"hash_37b2af92df0bfd42";
    case 3:
        return #"hash_3eb38ea38a92fe35";
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0x3e58ec1a, Offset: 0x1008
// Size: 0x9a
function function_7efb29aa(infiltration) {
    switch (infiltration) {
    case 0:
        return #"hash_249ee0339eddec66";
    case 2:
        return #"hash_88bd3835c23cdbc";
    case 1:
        return #"hash_30029804cf01e828";
    case 3:
        return #"hash_79efd6a9d00cac13";
    }
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0x8b009c89, Offset: 0x10b0
// Size: 0x64
function function_5312ef7e() {
    level.var_13d23077 = [];
    function_dad9c195(level.var_13d23077, #"hash_56ea488ae4a48dec");
    function_dad9c195(level.var_13d23077, #"hash_31a357d358802d18");
}

// Namespace incursion/incursion
// Params 2, eflags: 0x0
// Checksum 0x485805f0, Offset: 0x1120
// Size: 0x48
function function_dad9c195(&var_13d23077, spawngroup) {
    spawns = struct::get_array(spawngroup, "script_noteworthy");
    var_13d23077[spawngroup] = spawns;
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0xcb412e83, Offset: 0x1170
// Size: 0x98
function get_spawn(spawngroup) {
    spawns = level.var_13d23077[spawngroup];
    if (!isdefined(spawns) || spawns.size <= 0) {
        return undefined;
    }
    i = randomint(spawns.size);
    spawn = spawns[i];
    arrayremoveindex(spawns, i);
    return spawn;
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0xfaab2677, Offset: 0x1210
// Size: 0x34
function function_e20a4f1f(squad) {
    if (!isdefined(level.var_fa15aec0[squad])) {
        level.var_fa15aec0[squad] = 4;
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0x62e5c864, Offset: 0x1250
// Size: 0x168
function function_828e89e7(squad) {
    players = function_c65231e2(squad);
    var_b90c93b9 = level.var_8485ede4;
    foreach (player in players) {
        if (![[ var_b90c93b9 ]]->function_7bfd10e6(player)) {
            [[ var_b90c93b9 ]]->open(player);
        }
        infiltration = level.var_fa15aec0[squad];
        state = is_true(player.squadleader) && infiltration == 4 ? #"hash_1c7fa28cf1485078" : #"defaultstate";
        [[ var_b90c93b9 ]]->set_state(player, state);
        [[ var_b90c93b9 ]]->function_ee0c7ef6(player, infiltration);
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0xf52a434e, Offset: 0x13c0
// Size: 0xee
function function_62251c0(squad) {
    players = function_c65231e2(squad);
    foreach (i, player in players) {
        if (i == 0) {
            if (!is_true(player.squadleader)) {
                player.squadleader = 1;
                player thread function_e3560996();
            }
            continue;
        }
        player.squadleader = 0;
    }
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0x92900316, Offset: 0x14b8
// Size: 0x112
function function_e3560996() {
    level endon(#"hash_50a292a3a57f0d7e");
    self endon(#"disconnect");
    while (is_true(self.squadleader) && game.state == "pregame") {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        if (menu == "Incursion_InfiltrationTitleCards" && response == "incursion_selected") {
            level.var_fa15aec0[self.squad] = waitresult.intpayload;
            function_828e89e7(self.squad);
            return;
        }
    }
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0xdb52eb4f, Offset: 0x15d8
// Size: 0x148
function function_4523532a() {
    /#
        if (getdvarint(#"scr_disable_infiltration", 0)) {
            return;
        }
    #/
    level notify(#"hash_50a292a3a57f0d7e");
    foreach (squad, struct in level.squads) {
        if (isdefined(level.var_fa15aec0[squad])) {
            if (level.var_fa15aec0[squad] == 4) {
                level.var_fa15aec0[squad] = randomint(4);
                function_828e89e7(squad);
            }
            level thread function_730df07c(squad, level.var_fa15aec0[squad]);
        }
    }
}

// Namespace incursion/incursion
// Params 2, eflags: 0x0
// Checksum 0x5a8a03d7, Offset: 0x1728
// Size: 0x31c
function function_730df07c(squad, infiltration) {
    level endon(#"game_ended");
    if (!isdefined(infiltration)) {
        return;
    }
    success = function_3e9a71a5(squad, infiltration);
    var_b90c93b9 = level.var_8485ede4;
    players = function_c65231e2(squad);
    foreach (player in players) {
        player.var_8f9dd238 = success;
        player val::set("infiltration", "freezecontrols", 1);
        player val::set("infiltration", "disablegadgets", 1);
    }
    function_42d494cb(squad, var_b90c93b9, function_b23c406e(infiltration));
    wait 5;
    if (success) {
        function_42d494cb(squad, var_b90c93b9, function_b3d1fd4(infiltration));
        level thread function_8ffe3d31(squad, infiltration);
    } else {
        function_42d494cb(squad, var_b90c93b9, function_7efb29aa(infiltration));
        level thread function_23f3ff61(squad, infiltration);
    }
    wait 5;
    players = function_c65231e2(squad);
    foreach (player in players) {
        player val::reset("infiltration", "freezecontrols");
        player val::reset("infiltration", "disablegadgets");
    }
    level notify(#"hash_568c55fc1807ad2d");
    wait 0.75;
    function_8ce6ba12(squad, var_b90c93b9);
}

// Namespace incursion/incursion
// Params 3, eflags: 0x0
// Checksum 0x712f6332, Offset: 0x1a50
// Size: 0xe4
function function_42d494cb(squad, var_b90c93b9, var_9ca67c82) {
    players = function_c65231e2(squad);
    foreach (player in players) {
        if (![[ var_b90c93b9 ]]->function_7bfd10e6(player)) {
            [[ var_b90c93b9 ]]->open(player);
        }
        [[ var_b90c93b9 ]]->set_state(player, var_9ca67c82);
    }
}

// Namespace incursion/incursion
// Params 2, eflags: 0x0
// Checksum 0x14ab197e, Offset: 0x1b40
// Size: 0xb4
function function_8ce6ba12(squad, var_b90c93b9) {
    players = function_c65231e2(squad);
    foreach (player in players) {
        [[ var_b90c93b9 ]]->close(player);
    }
}

// Namespace incursion/incursion
// Params 2, eflags: 0x0
// Checksum 0x6f5acdb5, Offset: 0x1c00
// Size: 0x7e
function function_3e9a71a5(*squad, infiltration) {
    /#
        var_a8c87bd7 = getdvarint(#"hash_73d0c6784954d9c0");
        if (isdefined(var_a8c87bd7)) {
            return (var_a8c87bd7 > 0);
        }
    #/
    if (infiltration == 0) {
        return false;
    }
    return randomint(2) > 0;
}

// Namespace incursion/incursion
// Params 2, eflags: 0x0
// Checksum 0x4c03c164, Offset: 0x1c88
// Size: 0x112
function function_8ffe3d31(squad, infiltration) {
    switch (infiltration) {
    case 0:
        function_1d9b7d2a(squad, #"hash_31a357d358802d18", #"hash_415a27cf4ad41b04");
        break;
    case 2:
        function_624c5adf(squad, #"hash_31a357d358802d18", #"vehicle_t9_mil_ru_truck_light_player");
        break;
    case 1:
        function_1dc08ddc(squad);
        break;
    case 3:
        function_729888f3(squad, #"hash_31a357d358802d18");
        break;
    }
}

// Namespace incursion/incursion
// Params 2, eflags: 0x0
// Checksum 0x31b54a88, Offset: 0x1da8
// Size: 0x122
function function_23f3ff61(squad, infiltration) {
    switch (infiltration) {
    case 0:
        function_1d9b7d2a(squad, #"hash_31a357d358802d18", #"hash_415a27cf4ad41b04");
        break;
    case 2:
        function_1d9b7d2a(squad, #"hash_31a357d358802d18", #"hash_464b294088a7b2d9");
        break;
    case 1:
        function_427773fd(squad);
        break;
    case 3:
        function_1d9b7d2a(squad, #"hash_31a357d358802d18", #"veh_t8_mil_helicopter_light_debris_fuselage");
        break;
    }
}

// Namespace incursion/incursion
// Params 3, eflags: 0x0
// Checksum 0xb5c15b96, Offset: 0x1ed8
// Size: 0x2b8
function function_624c5adf(squad, spawngroup, vehicletype) {
    level endon(#"game_ended");
    spawn = get_spawn(spawngroup);
    if (!isdefined(spawn)) {
        return;
    }
    vehicle = spawnvehicle(vehicletype, spawn.origin, spawn.angles);
    if (!isdefined(vehicle)) {
        players = getplayers(squad);
        function_49368c92(players, spawn);
        return;
    }
    vehicle makeusable();
    maxs = vehicle getmaxs();
    var_88e8de80 = 5 + maxs[2];
    radius = maxs[1] / 2;
    wait 0.5;
    players = function_c65231e2(squad);
    foreach (i, player in players) {
        seat = function_bb01a0be(vehicle);
        if (isdefined(seat)) {
            vehicle usevehicle(player, seat);
            continue;
        }
        offset = (radius * cos(90 * i), radius * sin(90 * i), var_88e8de80);
        player setplayerangles(vehicle.angles);
        player setorigin(vehicle.origin + offset);
        player dontinterpolate();
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0x8a33e146, Offset: 0x2198
// Size: 0xa2
function function_bb01a0be(vehicle) {
    for (i = 0; i < 11; i++) {
        if (vehicle function_dcef0ba1(i)) {
            var_3693c73b = vehicle function_defc91b2(i);
            if (isdefined(var_3693c73b) && var_3693c73b >= 0 && !vehicle isvehicleseatoccupied(i)) {
                return i;
            }
        }
    }
    return undefined;
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0xd3e55914, Offset: 0x2248
// Size: 0x2a8
function function_1dc08ddc(squad) {
    origin = function_c8833cbc(15000);
    level waittill(#"hash_568c55fc1807ad2d");
    players = function_c65231e2(squad);
    if (players.size <= 0) {
        return;
    }
    var_b8d8f174 = randomint(360);
    fwd = (cos(var_b8d8f174), sin(var_b8d8f174), -1);
    var_7d48f39e = vectortoangles(fwd);
    right = anglestoright(var_7d48f39e);
    up = anglestoup(var_7d48f39e);
    var_79c532f9 = 600 / players.size;
    foreach (i, player in players) {
        dist = i * var_79c532f9 + randomintrange(30, 60);
        var_64e61448 = up * randomintrange(-60, 60);
        rightoffset = right * randomintrange(-120, 120);
        offset = fwd * dist + var_64e61448 + rightoffset;
        player setorigin(origin + offset);
        player setplayerangles(fwd);
        player dontinterpolate();
        player player_free_fall::function_7705a7fc(0, fwd);
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0xb9a97a0b, Offset: 0x24f8
// Size: 0x2a8
function function_427773fd(squad) {
    players = function_c65231e2(squad);
    function_d2b0fea8(players);
    origin = function_c8833cbc(8000);
    level waittill(#"hash_568c55fc1807ad2d");
    players = function_c65231e2(squad);
    if (players.size <= 0) {
        return;
    }
    yawoffset = 360 / players.size;
    foreach (i, player in players) {
        radius = randomintrange(500, 700);
        zoffset = randomintrange(-150, 150);
        yaw = i * yawoffset + randomintrange(-20, 20);
        offset = (radius * cos(yaw), radius * sin(yaw), zoffset);
        player setorigin(origin + offset);
        var_b8d8f174 = randomint(360);
        fwd = (cos(var_b8d8f174), sin(var_b8d8f174), -1);
        player setplayerangles(fwd);
        player dontinterpolate();
        player player_free_fall::function_7705a7fc(0, fwd);
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0x1da62d00, Offset: 0x27a8
// Size: 0x2ea
function function_c8833cbc(height) {
    origin = (0, 0, 0);
    if (isstruct(level.territory) && isarray(level.territory.bounds) && level.territory.bounds.size > 0) {
        absmins = [];
        absmaxs = [];
        foreach (bound in level.territory.bounds) {
            var_f3ba0cb3 = bound.origin + bound.mins;
            var_cd8bd6d = bound.origin + bound.maxs;
            for (i = 0; i < 3; i++) {
                if (!isdefined(absmins[i])) {
                    absmins[i] = var_f3ba0cb3[i];
                }
                if (!isdefined(absmaxs[i])) {
                    absmaxs[i] = var_cd8bd6d[i];
                }
                absmins[i] = min(absmins[i], var_f3ba0cb3[i]);
                absmaxs[i] = max(absmaxs[i], var_cd8bd6d[i]);
            }
        }
        x = randomfloatrange(0.9 * absmins[0], 0.9 * absmaxs[0]);
        y = randomfloatrange(0.9 * absmins[1], 0.9 * absmaxs[1]);
        origin = (x, y, 0);
    }
    trace = groundtrace(origin + (0, 0, 20000), origin + (0, 0, -10000), 0, undefined);
    return trace[#"position"] + (0, 0, height);
}

// Namespace incursion/incursion
// Params 3, eflags: 0x0
// Checksum 0xe7656478, Offset: 0x2aa0
// Size: 0xe6
function function_1d9b7d2a(squad, spawngroup, model) {
    spawn = get_spawn(spawngroup);
    if (!isdefined(spawn)) {
        return;
    }
    players = function_c65231e2(squad);
    function_49368c92(players, spawn);
    function_d2b0fea8(players);
    var_de8fc52 = spawn("script_model", spawn.origin);
    var_de8fc52 setmodel(model);
    var_de8fc52.angles = spawn.angles;
}

// Namespace incursion/incursion
// Params 2, eflags: 0x0
// Checksum 0x6d07d59b, Offset: 0x2b90
// Size: 0x74
function function_729888f3(squad, spawngroup) {
    spawn = get_spawn(spawngroup);
    if (!isdefined(spawn)) {
        return;
    }
    players = function_c65231e2(squad);
    function_49368c92(players, spawn);
}

// Namespace incursion/incursion
// Params 2, eflags: 0x0
// Checksum 0x280c0f0d, Offset: 0x2c10
// Size: 0x120
function function_49368c92(players, spawn) {
    spawnpoints = struct::get_array(spawn.targetname, "target");
    foreach (i, player in players) {
        spawnpoint = spawnpoints[i];
        if (!isdefined(spawnpoint)) {
            return;
        }
        player setorigin(spawnpoint.origin);
        player setplayerangles(spawnpoint.angles);
        player dontinterpolate();
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0x471f585f, Offset: 0x2d38
// Size: 0xb0
function function_d2b0fea8(players) {
    foreach (player in players) {
        player dodamage(randomintrange(50, 75), player.origin);
    }
}

// Namespace incursion/incursion
// Params 1, eflags: 0x0
// Checksum 0xf04aab4f, Offset: 0x2df0
// Size: 0xe4
function function_7d709aa4(*params) {
    self.var_26074a5b = undefined;
    if (level.numlives > 0) {
        return;
    }
    if (!isdefined(self.reinsertionvehicle)) {
        vehicle = spawnvehicle(#"hash_3effd1dd89ee3d36", (0, 0, 0), (0, 0, 0));
        if (isdefined(vehicle)) {
            vehicle.targetname = "reinsertionvehicle";
            vehicle ghost();
            vehicle notsolid();
            self.reinsertionvehicle = vehicle;
        }
    }
    self thread function_855ba783();
    self thread function_c3144b08();
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0x6efe0cf4, Offset: 0x2ee0
// Size: 0x62
function function_855ba783() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self waittill(#"spawned");
    if (self.currentspectatingclient > -1) {
        self.var_26074a5b = self.currentspectatingclient;
    }
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0x116bd2b, Offset: 0x2f50
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

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0xd3450193, Offset: 0x3018
// Size: 0x43c
function function_807b902() {
    if (!isdefined(level.inprematchperiod) || level.inprematchperiod) {
        return;
    }
    player = self function_70f1d702();
    origin = undefined;
    fwd = undefined;
    if (isdefined(player)) {
        origin = player.origin;
        fwd = anglestoforward(player.angles);
    } else if (isstruct(level.var_9bbce2cd) && isarray(level.var_9bbce2cd.stages) && level.var_9bbce2cd.stages.size > 0) {
        i = level.var_9bbce2cd.stages.size - 1;
        minradius = level.var_9bbce2cd.stages[i].radius + 500;
        maxradius = level.var_9bbce2cd.var_91017512 * level.var_9bbce2cd.var_8a0314b0;
        if (minradius < maxradius) {
            tries = 0;
            var_b16c122 = level.var_9bbce2cd.var_b16c122;
            absmins = level.var_9bbce2cd.bounds.absmins + level.var_9bbce2cd.bounds.buffer;
            absmaxs = level.var_9bbce2cd.bounds.absmaxs - level.var_9bbce2cd.bounds.buffer;
            while (tries < 20) {
                angle = randomint(360);
                radius = randomfloatrange(minradius, maxradius);
                origin = var_b16c122 + radius * (cos(angle), sin(angle), 0);
                if (origin[0] > absmins[0] && origin[0] < absmaxs[0] && origin[1] > absmins[1] && origin[1] < absmaxs[1]) {
                    fwd = anglestoforward((0, randomfloat(360), 0));
                    break;
                }
            }
        }
    }
    if (!isdefined(origin) && !isdefined(fwd)) {
        origin = self.origin;
        fwd = anglestoforward(self.angles);
    }
    trace = groundtrace(origin + (0, 0, 20000), origin + (0, 0, -10000), 0, undefined);
    var_9f4f9dea = trace[#"position"];
    fwd = anglestoforward((0, randomfloat(360), 0));
    var_6b4313e9 = var_9f4f9dea + fwd * 1500;
    self function_b74c009d(var_9f4f9dea, var_6b4313e9);
}

// Namespace incursion/incursion
// Params 0, eflags: 0x0
// Checksum 0x705cf92c, Offset: 0x3460
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

// Namespace incursion/incursion
// Params 2, eflags: 0x0
// Checksum 0x4b259b1b, Offset: 0x35c0
// Size: 0x18c
function function_b74c009d(groundpoint, var_6b4313e9) {
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
    zoffset = getdvarint(#"hash_1e5142ed6dd5c6a0", randomintrange(15000, 15100));
    origin = groundpoint + (xoffset, yoffset, zoffset);
    self thread function_2613549d(origin, var_6b4313e9);
}

// Namespace incursion/incursion
// Params 2, eflags: 0x0
// Checksum 0xbd2405d7, Offset: 0x3758
// Size: 0x25c
function function_2613549d(origin, var_6b4313e9) {
    level endon(#"game_ended");
    self endon(#"disconnect", #"end_respawn");
    self setorigin(origin);
    fwd = var_6b4313e9 - origin;
    var_7d48f39e = vectortoangles(fwd);
    launchvelocity = fwd;
    vehicle = self.reinsertionvehicle;
    self.reinsertionvehicle = undefined;
    if (isdefined(vehicle)) {
        vehicle.origin = origin;
        vehicle.angles = var_7d48f39e;
        self ghost();
        self notsolid();
        self dontinterpolate();
        self setclientthirdperson(1);
        self function_648c1f6(vehicle, undefined, 0, 180, 180, 180, 180, 0);
        self setplayerangles(var_7d48f39e);
        wait 0;
        self setclientthirdperson(0);
        self startcameratween(0);
        self show();
        self solid();
        self unlink();
        launchvelocity = anglestoforward(self getplayerangles());
        vehicle deletedelay();
    }
    self player_insertion::start_freefall(launchvelocity, 1);
}

