#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using script_5495f0bb06045dc7;
#using script_69514c4c056c768;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\location;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\territory;
#using scripts\core_common\territory_util;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\callbacks;
#using scripts\mp_common\laststand;
#using scripts\mp_common\player\player_loadout;
#using scripts\wz_common\hud;
#using scripts\wz_common\spawn;
#using scripts\wz_common\wz_loadouts;

#namespace namespace_2938acdc;

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0x37da672b, Offset: 0x258
// Size: 0x1f4
function init() {
    level.var_db91e97c = 1;
    function_28e27688();
    death_circle::function_c156630d();
    namespace_17baa64d::init();
    if (!is_true(getdvarint(#"hash_613aa8df1f03f054", 1))) {
        level.givecustomloadout = &give_custom_loadout;
    }
    spawning::function_32b97d1b(&spawning::function_90dee50d);
    spawning::function_adbbb58a(&spawning::function_c24e290c);
    callback::on_start_gametype(&function_3b948dcf);
    callback::function_c11071a8(&function_c11071a8);
    callback::add_callback(#"hash_740a58650e79dbfd", &function_c3623479);
    level.var_61d4f517 = getgametypesetting(#"hash_3513cf8b4287cdd7");
    level.var_5c49de55 = getgametypesetting(#"hash_6eef7868c4f5ddbc");
    if (is_true(level.var_5c49de55)) {
        clientfield::register_clientuimodel("squad_wipe_tokens.count", 1, 4, "int");
        callback::on_connect(&on_player_connect);
    }
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x4
// Checksum 0x55692db1, Offset: 0x458
// Size: 0x34
function private on_player_connect() {
    self clientfield::set_player_uimodel("squad_wipe_tokens.count", game.var_5c49de55[self.team]);
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 1, eflags: 0x0
// Checksum 0x5e2f49f8, Offset: 0x498
// Size: 0xa8
function function_b8da6142(player) {
    if (!is_true(level.var_61d4f517)) {
        return 0;
    }
    if (!isdefined(level.var_5f536694)) {
        level.var_5f536694 = [];
    }
    if (level.var_5f536694[player.squad] === gettime()) {
        return 1;
    }
    forcespawn = !player laststand_mp::function_c0ec19cd();
    if (forcespawn) {
        level.var_5f536694[player.squad] = gettime();
    }
    return forcespawn;
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 1, eflags: 0x0
// Checksum 0xdd0b5789, Offset: 0x548
// Size: 0x28
function function_e1ca24fe(players) {
    arrayremovevalue(players, undefined, 0);
    return players;
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0xd888d8a7, Offset: 0x578
// Size: 0x358
function function_c11071a8() {
    wait math::clamp(level.prematchperiod - 2, 0, level.prematchperiod);
    players = getplayers();
    if (is_true(getgametypesetting("allowPlayerMovementPrematch"))) {
        level thread function_38b14e59(players, 2, 3, 2, 0);
    }
    wait 2;
    players = function_e1ca24fe(players);
    foreach (player in players) {
        player val::set(#"hash_4a7df1f1aa746fdc", "freezecontrols", 1);
        player val::set(#"hash_4a7df1f1aa746fdc", "disablegadgets", 1);
        if (isdefined(player.startspawn)) {
            if (isdefined(player.startspawn.origin)) {
                player setorigin(player.startspawn.origin);
            }
            if (isdefined(player.startspawn.angles)) {
                player setplayerangles(player.startspawn.angles);
            }
        }
    }
    wait 3 + 2 / 3;
    players = function_e1ca24fe(players);
    foreach (player in players) {
        if (!isalive(player)) {
            continue;
        }
        player val::reset(#"hash_4a7df1f1aa746fdc", "freezecontrols");
        player val::reset(#"hash_4a7df1f1aa746fdc", "disablegadgets");
    }
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 5, eflags: 0x0
// Checksum 0xef0538e4, Offset: 0x8d8
// Size: 0x344
function function_38b14e59(players, fadeouttime, blacktime, fadeintime, rumble) {
    if (isdefined(lui::get_luimenu("FullScreenBlack"))) {
        lui_menu = lui::get_luimenu("FullScreenBlack");
    }
    players = function_e1ca24fe(players);
    foreach (player in players) {
        if (isdefined(player)) {
            if (![[ lui_menu ]]->function_7bfd10e6(player)) {
                [[ lui_menu ]]->open(player);
            }
            [[ lui_menu ]]->set_startalpha(player, 0);
            [[ lui_menu ]]->set_endalpha(player, 1);
            [[ lui_menu ]]->set_fadeovertime(player, int(fadeouttime * 1000));
        }
    }
    wait fadeouttime + blacktime;
    players = function_e1ca24fe(players);
    foreach (player in players) {
        player thread item_inventory::reset_inventory();
        if (rumble) {
            player playrumbleonentity(#"infiltration_rumble");
        }
        if (![[ lui_menu ]]->function_7bfd10e6(player)) {
            [[ lui_menu ]]->open(player);
        }
        [[ lui_menu ]]->set_startalpha(player, 1);
        [[ lui_menu ]]->set_endalpha(player, 0);
        [[ lui_menu ]]->set_fadeovertime(player, int(fadeintime * 1000));
    }
    wait fadeintime;
    players = function_e1ca24fe(players);
    foreach (player in players) {
        [[ lui_menu ]]->close(player);
    }
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0xc989bca4, Offset: 0xc28
// Size: 0xac
function function_3b948dcf() {
    if (!level.deathcircle.enabled) {
        return;
    }
    waitframe(1);
    level.var_35d74f0a = location::function_2e7ce8a0();
    deathcircle = death_circle::function_a8749d88(level.var_35d74f0a.origin, level.var_35d74f0a.radius, 5, 1);
    level thread death_circle::function_dc15ad60(deathcircle);
    function_aef30871(level.var_35d74f0a);
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 1, eflags: 0x0
// Checksum 0x77b97b38, Offset: 0xce0
// Size: 0x2f0
function function_aef30871(location) {
    if (isdefined(level.var_7767cea8)) {
        var_a144f484 = [];
        foreach (dest in level.var_7767cea8) {
            distance = distance2d(dest.origin, location.origin);
            if (distance < location.radius) {
                if (!isdefined(var_a144f484)) {
                    var_a144f484 = [];
                } else if (!isarray(var_a144f484)) {
                    var_a144f484 = array(var_a144f484);
                }
                var_a144f484[var_a144f484.size] = dest;
            }
        }
        if (var_a144f484.size == 0) {
            var_56c7ce59 = undefined;
            closest_distance = 999999999;
            foreach (dest in level.var_7767cea8) {
                distance = distance2d(dest.origin, location.origin);
                if (distance < closest_distance) {
                    closest_distance = distance;
                    var_56c7ce59 = dest;
                }
            }
            if (!isdefined(var_a144f484)) {
                var_a144f484 = [];
            } else if (!isarray(var_a144f484)) {
                var_a144f484 = array(var_a144f484);
            }
            var_a144f484[var_a144f484.size] = var_56c7ce59;
        }
        foreach (dest in level.var_7767cea8) {
            if (!function_844e7af4(dest, var_a144f484)) {
                spawn::function_3b1d0553(dest);
            }
        }
        level.var_7767cea8 = var_a144f484;
    }
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 2, eflags: 0x0
// Checksum 0x63b2a062, Offset: 0xfd8
// Size: 0xa0
function function_844e7af4(dest, destinations) {
    foreach (var_57701f4a in destinations) {
        if (var_57701f4a.target == dest.target) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0x41f4245a, Offset: 0x1080
// Size: 0x2c
function function_28e27688() {
    location::function_18dac968((-2800, -17300, 1370), 0, 0, 10000);
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 1, eflags: 0x0
// Checksum 0xa5f1713a, Offset: 0x10b8
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
    healthgadget = getweapon(#"gadget_health_regen");
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
    self thread function_fd19a11c();
    return bare_hands;
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0x37f45eca, Offset: 0x1400
// Size: 0x27c
function function_fd19a11c() {
    self endon(#"death");
    waitframe(1);
    while (!isdefined(self.inventory)) {
        waitframe(1);
    }
    item_inventory::reset_inventory(0);
    var_3401351 = randomintrangeinclusive(1, 5);
    switch (var_3401351) {
    case 1:
        function_6541c917();
        break;
    case 2:
        function_ae5cdb4c();
        break;
    case 3:
        function_a0a43fdb();
        break;
    case 4:
        function_343266f9();
        break;
    case 5:
        function_2e725b79();
        break;
    }
    give_max_ammo();
    var_67fe8973 = [];
    var_67fe8973[var_67fe8973.size] = 126;
    var_67fe8973[var_67fe8973.size] = 128;
    var_67fe8973[var_67fe8973.size] = 134;
    var_67fe8973[var_67fe8973.size] = 125;
    give_killstreaks(var_67fe8973);
    actionslot3 = getdvarint(#"hash_449fa75f87a4b5b4", 0) < 0 ? "flourish_callouts" : "ping_callouts";
    self setactionslot(3, actionslot3);
    actionslot4 = getdvarint(#"hash_23270ec9008cb656", 0) < 0 ? "scorestreak_wheel" : "sprays_boasts";
    self setactionslot(4, actionslot4);
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 1, eflags: 0x0
// Checksum 0xec905e52, Offset: 0x1688
// Size: 0x4d4
function give_killstreaks(var_67fe8973) {
    self loadout::clear_killstreaks();
    if (!level.loadoutkillstreaksenabled) {
        return;
    }
    classnum = self.class_num_for_global_weapons;
    sortedkillstreaks = [];
    currentkillstreak = 0;
    for (killstreaknum = 0; killstreaknum < var_67fe8973.size; killstreaknum++) {
        killstreakindex = var_67fe8973[killstreaknum];
        if (isdefined(killstreakindex) && killstreakindex > 0) {
            assert(isdefined(level.tbl_killstreakdata[killstreakindex]), "<dev string:x38>" + killstreakindex + "<dev string:x49>");
            if (isdefined(level.tbl_killstreakdata[killstreakindex])) {
                self.killstreak[currentkillstreak] = level.tbl_killstreakdata[killstreakindex];
                if (is_true(level.usingmomentum)) {
                    killstreaktype = killstreaks::get_by_menu_name(self.killstreak[currentkillstreak]);
                    if (isdefined(killstreaktype)) {
                        weapon = killstreaks::get_killstreak_weapon(killstreaktype);
                        self giveweapon(weapon);
                        if (is_true(level.usingscorestreaks)) {
                            if (weapon.iscarriedkillstreak) {
                                if (!isdefined(self.pers[#"held_killstreak_ammo_count"][weapon])) {
                                    self.pers[#"held_killstreak_ammo_count"][weapon] = 0;
                                }
                                if (!isdefined(self.pers[#"held_killstreak_clip_count"][weapon])) {
                                    self.pers[#"held_killstreak_clip_count"][weapon] = 0;
                                }
                                if (self.pers[#"held_killstreak_ammo_count"][weapon] > 0) {
                                    self killstreaks::function_fa6e0467(weapon);
                                } else {
                                    self loadout::function_3ba6ee5d(weapon, 0);
                                }
                            } else {
                                quantity = 0;
                                if (isdefined(self.pers[#"killstreak_quantity"]) && isdefined(self.pers[#"killstreak_quantity"][weapon])) {
                                    quantity = self.pers[#"killstreak_quantity"][weapon];
                                }
                                self setweaponammoclip(weapon, quantity);
                            }
                        }
                        sortdata = spawnstruct();
                        sortdata.cost = self function_dceb5542(level.killstreaks[killstreaktype].itemindex);
                        sortdata.weapon = weapon;
                        sortindex = 0;
                        for (sortindex = 0; sortindex < sortedkillstreaks.size; sortindex++) {
                            if (sortedkillstreaks[sortindex].cost > sortdata.cost) {
                                break;
                            }
                        }
                        for (i = sortedkillstreaks.size; i > sortindex; i--) {
                            sortedkillstreaks[i] = sortedkillstreaks[i - 1];
                        }
                        sortedkillstreaks[sortindex] = sortdata;
                    }
                }
                currentkillstreak++;
            }
        }
    }
    var_2e1bd530 = [];
    var_2e1bd530[0] = 3;
    var_2e1bd530[1] = 1;
    var_2e1bd530[2] = 0;
    if (isdefined(level.usingmomentum) && level.usingmomentum) {
        for (sortindex = 0; sortindex < sortedkillstreaks.size && sortindex < var_2e1bd530.size; sortindex++) {
            if (sortedkillstreaks[sortindex].weapon != level.weaponnone) {
                self setkillstreakweapon(var_2e1bd530[sortindex], sortedkillstreaks[sortindex].weapon);
            }
        }
    }
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0x31fea5de, Offset: 0x1b68
// Size: 0xa4
function function_6541c917() {
    wz_loadouts::give_weapon(#"pistol_standard_t8_item");
    wz_loadouts::give_weapon(#"smg_standard_t8_item", array(#"tritium_wz_item"));
    wz_loadouts::give_item(#"frag_grenade_wz_item");
    wz_loadouts::give_item(#"hash_1e9bf9999d767989");
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0xc20be9d1, Offset: 0x1c18
// Size: 0xa4
function function_ae5cdb4c() {
    wz_loadouts::give_weapon(#"pistol_standard_t8_item");
    wz_loadouts::give_weapon(#"ar_accurate_t8_item", array(#"reflex_wz_item"));
    wz_loadouts::give_item(#"frag_grenade_wz_item");
    wz_loadouts::give_item(#"hash_1e9bf9999d767989");
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0x830b6e7c, Offset: 0x1cc8
// Size: 0xa4
function function_a0a43fdb() {
    wz_loadouts::give_weapon(#"pistol_standard_t8_item");
    wz_loadouts::give_weapon(#"lmg_standard_t8_item", array(#"reflex_wz_item"));
    wz_loadouts::give_item(#"frag_grenade_wz_item");
    wz_loadouts::give_item(#"hash_1e9bf9999d767989");
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0x8af9bbb, Offset: 0x1d78
// Size: 0x84
function function_343266f9() {
    wz_loadouts::give_weapon(#"pistol_standard_t8_item");
    wz_loadouts::give_weapon(#"tr_powersemi_t8_item");
    wz_loadouts::give_item(#"frag_grenade_wz_item");
    wz_loadouts::give_item(#"hash_1e9bf9999d767989");
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0xa25b8c07, Offset: 0x1e08
// Size: 0xa4
function function_2e725b79() {
    wz_loadouts::give_weapon(#"pistol_standard_t8_item");
    wz_loadouts::give_weapon(#"sniper_powerbolt_t8_item", array(#"sniperscope_wz_item"));
    wz_loadouts::give_item(#"frag_grenade_wz_item");
    wz_loadouts::give_item(#"hash_1e9bf9999d767989");
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0x31699474, Offset: 0x1eb8
// Size: 0xf4
function give_max_ammo() {
    wz_loadouts::give_item(#"ammo_small_caliber_item_t9", 4);
    wz_loadouts::give_item(#"ammo_ar_item_t9", 4);
    wz_loadouts::give_item(#"ammo_large_caliber_item_t9", 4);
    wz_loadouts::give_item(#"ammo_sniper_item_t9", 4);
    wz_loadouts::give_item(#"ammo_shotgun_item_t9", 4);
    wz_loadouts::give_item(#"ammo_special_item_t9", 4);
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0x2b79d1ca, Offset: 0x1fb8
// Size: 0x15a
function function_cb5befb2() {
    circlespawns = [];
    spawns = spawning::function_4fe2525a();
    circleorigin = level.var_35d74f0a.origin;
    circleradius = level.var_35d74f0a.radius;
    foreach (spawn in spawns) {
        distance = distance2d(spawn.origin, circleorigin);
        if (distance > circleradius) {
            continue;
        }
        if (!isdefined(circlespawns)) {
            circlespawns = [];
        } else if (!isarray(circlespawns)) {
            circlespawns = array(circlespawns);
        }
        circlespawns[circlespawns.size] = spawn;
    }
    return circlespawns;
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 2, eflags: 0x0
// Checksum 0xee8703cb, Offset: 0x2120
// Size: 0x1d8
function function_11fa5782(vehicletype, droppoint) {
    if (vehicletype != #"hash_6595f5efe62a4ec") {
        return;
    }
    if (!isdefined(level.var_5a6cc4da)) {
        level.var_5a6cc4da = array::randomize(struct::get_array("vehicle_drop_heli", "targetname"));
        level.var_1059a6b4 = 0;
    }
    droppoint = level.var_5a6cc4da[level.var_1059a6b4];
    if (!isdefined(droppoint)) {
        return;
    }
    ground_pos = bullettrace(droppoint.origin + (0, 0, 128), droppoint.origin - (0, 0, 128), 0, undefined, 1);
    level.var_1059a6b4 = (level.var_1059a6b4 + 1) % level.var_5a6cc4da.size;
    var_d5552131 = spawnvehicle(vehicletype, ground_pos[#"position"] + (0, 0, 120), droppoint.angles);
    if (!isdefined(var_d5552131)) {
        return;
    }
    var_d5552131 makeusable();
    if (is_true(var_d5552131.isphysicsvehicle)) {
        var_d5552131 setbrake(1);
    }
    level thread function_c3623479(var_d5552131);
    return var_d5552131;
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0x5887a3ae, Offset: 0x2300
// Size: 0xac
function function_4212369d() {
    level.var_11fa5782 = &function_11fa5782;
    level thread namespace_3d2704b3::function_add63876(array(#"vehicle_t9_mil_fav_light", #"hash_28d512b739c9d9c1", #"hash_6595f5efe62a4ec"), 2147483647, 60, 90, 180, 2, 15, struct::get_array("vehicle_drop", "targetname"), 6000);
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0x78f8a9bf, Offset: 0x23b8
// Size: 0x3c
function function_20d09030() {
    level thread namespace_3d2704b3::function_7fc18ad5(#"hash_27bac84003da7795", 2147483647, 80, 90, 180);
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 1, eflags: 0x0
// Checksum 0x23762c34, Offset: 0x2400
// Size: 0x174
function function_c3623479(vehicle) {
    if (!isdefined(vehicle)) {
        return;
    }
    switch (vehicle.vehicletype) {
    case #"hash_6595f5efe62a4ec":
        objectivetype = "heli_drop";
        break;
    case #"hash_28d512b739c9d9c1":
        objectivetype = "tank_drop";
        break;
    case #"vehicle_t9_mil_fav_light":
        objectivetype = "fav_drop";
        break;
    default:
        objectivetype = "tank_drop";
        break;
    }
    vehicle.objid = gameobjects::get_next_obj_id();
    objective_add(vehicle.objid, "active", vehicle, objectivetype, vehicle);
    objective_setvisibletoall(vehicle.objid);
    vehicle thread function_e63bcc08();
    vehicle waittill(#"death");
    gameobjects::release_obj_id(vehicle.objid);
    wait 30;
    if (isdefined(vehicle)) {
        vehicle delete();
    }
}

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0x36ced82b, Offset: 0x2580
// Size: 0xe8
function function_e63bcc08() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"enter_vehicle", #"exit_vehicle", #"change_seat");
        player = waitresult.player;
        owner = self getvehoccupants()[0];
        if (isdefined(owner)) {
            objective_setinvisibletoall(self.objid);
            continue;
        }
        objective_setvisibletoall(self.objid);
    }
}

