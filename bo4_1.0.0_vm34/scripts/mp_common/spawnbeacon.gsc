#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawnbeacon_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\draft;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\userspawnselection;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;

#namespace spawn_beacon;

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x2
// Checksum 0xc47a562a, Offset: 0x1a8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"spawn_beacon", &__init__, undefined, #"killstreaks");
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x0
// Checksum 0x7b9b05c2, Offset: 0x1f8
// Size: 0x214
function __init__() {
    init_shared();
    level.var_549a5ec3 = &function_165f60e7;
    level.var_a21e13d4 = &function_4d7b6a21;
    level.var_a85d8948 = &function_2c716fbf;
    level.var_70565793 = &function_6e78d3ec;
    level.var_a2c2995e = &function_f0c61b67;
    globallogic_score::register_kill_callback(level.spawnbeaconsettings.beaconweapon, &function_1c1859d2);
    globallogic_score::function_55e3f7c(level.spawnbeaconsettings.beaconweapon, &function_1c1859d2);
    globallogic_score::function_bddb28c1(level.spawnbeaconsettings.beaconweapon, &function_3e71185b);
    globallogic_score::function_27915f9b(level.spawnbeaconsettings.beaconweapon, &function_ded96459);
    globallogic_score::function_b2769662(level.spawnbeaconsettings.beaconweapon, &function_922a2964);
    deployable::register_deployable(getweapon(#"hash_7ab3f9a730359659"), &function_6a26da93, undefined);
    weaponobjects::function_f298eae6(#"hash_7ab3f9a730359659", &function_9b287b6b, 1);
    function_74c9f5d6();
    function_7e4e8694();
}

// Namespace spawn_beacon/spawnbeacon
// Params 5, eflags: 0x0
// Checksum 0xf5f5cf95, Offset: 0x418
// Size: 0x9c
function function_1c1859d2(attacker, victim, weapon, attackerweapon, meansofdeath) {
    if (!isdefined(attacker) || !isdefined(attacker.var_e9185453) || !isdefined(attacker.var_d4a0a59) || attacker.var_d4a0a59 + 5000 < gettime()) {
        return false;
    }
    if (attacker == attacker.var_e9185453) {
        return true;
    }
    return false;
}

// Namespace spawn_beacon/spawnbeacon
// Params 6, eflags: 0x0
// Checksum 0x110b34af, Offset: 0x4c0
// Size: 0xe4
function function_ded96459(attacker, victim, var_9fa2f6e, killtime, weapon, spawnbeaconweapon) {
    if (!isdefined(attacker) || !isdefined(spawnbeaconweapon) || !isdefined(killtime) || !isdefined(attacker.var_e9185453)) {
        return;
    }
    if (attacker != attacker.var_e9185453 && (isdefined(attacker.var_d4a0a59) ? attacker.var_d4a0a59 : 0) + 5000 > killtime) {
        scoreevents::processscoreevent(#"hash_62131f4647f7c61a", attacker.var_e9185453, undefined, spawnbeaconweapon);
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 4, eflags: 0x0
// Checksum 0x6015775e, Offset: 0x5b0
// Size: 0xcc
function function_922a2964(attacker, victim, spawnbeaconweapon, var_11bc37c7) {
    if (!isdefined(attacker) || !isdefined(spawnbeaconweapon) || !isdefined(attacker.var_e9185453)) {
        return;
    }
    if (attacker != attacker.var_e9185453 && (isdefined(attacker.var_d4a0a59) ? attacker.var_d4a0a59 : 0) + 5000 > gettime()) {
        scoreevents::processscoreevent(#"hash_17705bbdbf8cf23a", attacker.var_e9185453, undefined, spawnbeaconweapon);
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 5, eflags: 0x0
// Checksum 0x1b13c593, Offset: 0x688
// Size: 0xdc
function function_3e71185b(attacker, var_13c56510, killtime, capturedobjective, spawnbeaconweapon) {
    if (!isdefined(attacker) || !isdefined(spawnbeaconweapon) || !isdefined(killtime) || !isdefined(attacker.var_e9185453)) {
        return;
    }
    if (attacker != attacker.var_e9185453 && (isdefined(attacker.var_d4a0a59) ? attacker.var_d4a0a59 : 0) + 5000 > killtime) {
        scoreevents::processscoreevent(#"hash_5ce122c3419f6a58", attacker.var_e9185453, undefined, spawnbeaconweapon);
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x0
// Checksum 0x8eabde27, Offset: 0x770
// Size: 0xc4
function function_f0c61b67() {
    if ((isdefined(level.spawnbeaconsettings.settingsbundle.var_82ec16dd) ? level.spawnbeaconsettings.settingsbundle.var_82ec16dd : 0) && isdefined(self.var_a13cd40b) && isarray(self.var_a13cd40b) && isdefined(self.var_a13cd40b[#"friendly"].trigger)) {
        self.var_a13cd40b[#"friendly"].trigger triggerenable(0);
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 1, eflags: 0x0
// Checksum 0x74b80320, Offset: 0x840
// Size: 0x34
function function_8ebadd52(zone) {
    array::add(level.spawnbeaconsettings.var_d00173bf, zone);
}

// Namespace spawn_beacon/spawnbeacon
// Params 1, eflags: 0x0
// Checksum 0x70bcdc59, Offset: 0x880
// Size: 0x34
function function_931025c3(zone) {
    arrayremovevalue(level.spawnbeaconsettings.var_d00173bf, zone);
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x4
// Checksum 0xab933059, Offset: 0x8c0
// Size: 0xce
function private function_7e4e8694() {
    for (spawnlistidx = 0; spawnlistidx < (isdefined(level.spawnbeaconsettings.settingsbundle.var_ba5fd9cf) ? level.spawnbeaconsettings.settingsbundle.var_ba5fd9cf : 0); spawnlistidx++) {
        array::add(level.spawnbeaconsettings.availablespawnlists, (isdefined(level.spawnbeaconsettings.settingsbundle.var_2dd42b70) ? level.spawnbeaconsettings.settingsbundle.var_2dd42b70 : "") + spawnlistidx);
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x4
// Checksum 0xff4dadb8, Offset: 0x998
// Size: 0x204
function private function_74c9f5d6() {
    level.spawnbeaconsettings.var_e4c9353e = [];
    var_1962daac = spawnstruct();
    var_136dad07 = isdefined(level.spawnbeaconsettings.settingsbundle.var_a6d41e4e) ? level.spawnbeaconsettings.settingsbundle.var_a6d41e4e : 0;
    var_1962daac.zonemax = var_136dad07 * var_136dad07;
    var_1962daac.points = isdefined(level.spawnbeaconsettings.settingsbundle.var_e720f38a) ? level.spawnbeaconsettings.settingsbundle.var_e720f38a : 0;
    var_1962daac.zonemin = 0;
    array::add(level.spawnbeaconsettings.var_e4c9353e, var_1962daac);
    var_8b6a49e7 = spawnstruct();
    var_136dad07 = isdefined(level.spawnbeaconsettings.settingsbundle.var_66926561) ? level.spawnbeaconsettings.settingsbundle.var_66926561 : 0;
    var_8b6a49e7.zonemax = var_136dad07 * var_136dad07;
    var_8b6a49e7.points = isdefined(level.spawnbeaconsettings.settingsbundle.var_c7c6bb57) ? level.spawnbeaconsettings.settingsbundle.var_c7c6bb57 : 0;
    var_8b6a49e7.zonemin = var_1962daac.zonemax;
    array::add(level.spawnbeaconsettings.var_e4c9353e, var_8b6a49e7);
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x0
// Checksum 0xacfa71ba, Offset: 0xba8
// Size: 0x86
function function_165f60e7() {
    player = self;
    spawnbeacon = player userspawnselection::function_cfd342bb();
    if (isdefined(spawnbeacon)) {
        player thread function_a55ab915(spawnbeacon, isdefined(player.var_b3f9ddd4) && player.var_b3f9ddd4 || isdefined(self.suicide) && self.suicide);
    }
    return false;
}

// Namespace spawn_beacon/spawnbeacon
// Params 2, eflags: 0x0
// Checksum 0x81ac289a, Offset: 0xc38
// Size: 0x48c
function function_a55ab915(spawnbeacon, var_c59eb3fc) {
    if (!isdefined(spawnbeacon)) {
        return;
    }
    player = self;
    spawnbeacon.health -= isdefined(level.spawnbeaconsettings.settingsbundle.var_ba9c6476) ? level.spawnbeaconsettings.settingsbundle.var_ba9c6476 : 0;
    spawnbeacon.spawncount++;
    if (isdefined(spawnbeacon.owner) && player != spawnbeacon.owner) {
        spawnbeacon.owner luinotifyevent(#"spawn_beacon_used");
    }
    if (isdefined(spawnbeacon.owner) && isdefined(self) && !var_c59eb3fc) {
        if (spawnbeacon.owner == player) {
            player thread scoreevents::function_4b1ed963(0.5, "spawn_beacon_insertion", spawnbeacon.owner, player, level.spawnbeaconsettings.beaconweapon);
        } else {
            scoreevents::processscoreevent(#"spawn_beacon_insertion", spawnbeacon.owner, player, level.spawnbeaconsettings.beaconweapon);
        }
        player.var_d4a0a59 = gettime();
        player.var_e9185453 = spawnbeacon.owner;
        var_5bc3670c = player match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
        if (isdefined(var_5bc3670c)) {
            player match_record::set_stat(#"lives", var_5bc3670c, #"hash_674598aa9fe3d19a", 1);
        }
    }
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_921620b4) && isdefined(spawnbeacon)) {
        var_c94beedb = isdefined(level.spawnbeaconsettings.settingsbundle.var_9e4e97e0) ? level.spawnbeaconsettings.settingsbundle.var_9e4e97e0 : 0 ? undefined : player;
        if (!isdefined(var_c94beedb)) {
            var_c94beedb = undefined;
        }
        spawnbeacon playsoundtoteam(level.spawnbeaconsettings.settingsbundle.var_921620b4, player getteam(), var_c94beedb);
    }
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_1d75705f)) {
        spawnbeacon playsoundtoteam(level.spawnbeaconsettings.settingsbundle.var_1d75705f, util::getotherteam(player getteam()));
    }
    if (spawnbeacon.threatlevel >= (isdefined(level.spawnbeaconsettings.settingsbundle.var_8dabcf22) ? level.spawnbeaconsettings.settingsbundle.var_8dabcf22 : 0)) {
        player globallogic_audio::play_taacom_dialog("spawnBeaconSpawnDanger");
    } else {
        player globallogic_audio::play_taacom_dialog("spawnBeaconSpawn");
    }
    if (spawnbeacon.health <= 0) {
        spawnbeacon function_bbb85eca(0);
    }
    if ((isdefined(level.spawnbeaconsettings.var_c59fd2a7) ? level.spawnbeaconsettings.var_c59fd2a7 : 0) && isdefined(spawnbeacon)) {
        spawnbeacon.var_3e80873b = 1;
        spawnbeacon thread function_bbb85eca(0);
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x0
// Checksum 0xffdeb5c2, Offset: 0x10d0
// Size: 0xf4
function function_4d7b6a21() {
    spawnbeacon = self;
    if (isdefined(spawnbeacon.var_6c966b05)) {
        self influencers::remove_influencer(spawnbeacon.var_6c966b05);
        self.spawn_influencer_enemy_carrier = undefined;
    }
    if (isdefined(spawnbeacon.var_c1221be)) {
        foreach (var_99db5066 in spawnbeacon.var_c1221be) {
            self influencers::remove_influencer(var_99db5066);
        }
    }
    userspawnselection::removespawnbeacon(self.objectiveid);
}

// Namespace spawn_beacon/spawnbeacon
// Params 5, eflags: 0x0
// Checksum 0xf7fd1d27, Offset: 0x11d0
// Size: 0x352
function function_6e78d3ec(origin, angles, player, var_29814ba8, var_b7bc1e41) {
    player.var_8ddac514.spawns = getspawnbeaconspawns(origin);
    if (player.var_8ddac514.spawns.size == 0) {
        player sethintstring(level.spawnbeaconsettings.settingsbundle.var_76b0005d);
        return false;
    }
    foreach (protectedzone in level.spawnbeaconsettings.var_d00173bf) {
        if (protectedzone istouching(origin, (16, 16, 70))) {
            return false;
        }
    }
    var_4d2c01a3 = isdefined(level.spawnbeaconsettings.settingsbundle.var_13030e07) ? level.spawnbeaconsettings.settingsbundle.var_13030e07 : 0;
    testdistance = var_4d2c01a3 * var_4d2c01a3;
    var_72de6a50 = getarraykeys(level.spawnbeaconsettings.userspawnbeacons);
    foreach (var_b26b1ab8 in var_72de6a50) {
        if (var_b26b1ab8 == player.clientid) {
            continue;
        }
        var_7244a8f9 = level.spawnbeaconsettings.userspawnbeacons[var_b26b1ab8];
        for (i = 0; i < var_7244a8f9.size; i++) {
            if (!isdefined(var_7244a8f9[i])) {
                level.spawnbeaconsettings.userspawnbeacons[var_b26b1ab8] = array::remove_index(var_7244a8f9, i, 0);
                continue;
            }
            distsqr = distancesquared(origin, var_7244a8f9[i].origin);
            if (distsqr <= testdistance) {
                player sethintstring(level.spawnbeaconsettings.settingsbundle.var_7a125d6c);
                return false;
            }
        }
    }
    return true;
}

// Namespace spawn_beacon/spawnbeacon
// Params 1, eflags: 0x4
// Checksum 0x535e9ccf, Offset: 0x1530
// Size: 0x528
function private function_2c716fbf(placedspawnbeacon) {
    player = self;
    placedspawnbeacon util::make_sentient();
    userspawnselection::registeravailablespawnbeacon(placedspawnbeacon.objectiveid, placedspawnbeacon);
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_d4dfc6c5) ? level.spawnbeaconsettings.settingsbundle.var_d4dfc6c5 : 0) {
        function_e4cac74c(placedspawnbeacon, level.spawnbeaconsettings.settingsbundle.var_51ca67fc, player getteam(), #"enemy", #"hash_10169ccdcca54ccf", &function_7ae62294, &function_dbf5b75d, &function_67f77beb);
        placedspawnbeacon.var_a13cd40b[#"enemy"] gameobjects::set_use_time(isdefined(level.spawnbeaconsettings.settingsbundle.var_91289434) ? level.spawnbeaconsettings.settingsbundle.var_91289434 : 0);
    }
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_82ec16dd) ? level.spawnbeaconsettings.settingsbundle.var_82ec16dd : 0) {
        function_e4cac74c(placedspawnbeacon, level.spawnbeaconsettings.settingsbundle.var_ba1ab78e, player getteam(), #"friendly", #"hash_f91a28adadc5409", &function_6da7faba, &function_97822ae6, &function_67f77beb);
        player clientclaimtrigger(placedspawnbeacon.var_a13cd40b[#"friendly"].trigger);
        placedspawnbeacon.var_a13cd40b[#"friendly"] gameobjects::set_use_time(isdefined(level.spawnbeaconsettings.settingsbundle.pickuptime) ? level.spawnbeaconsettings.settingsbundle.pickuptime : 0);
    }
    placedspawnbeacon.var_6c966b05 = placedspawnbeacon influencers::create_influencer("activeSpawnBeacon", placedspawnbeacon.origin, util::getteammask(player getteam()));
    if (isdefined(placedspawnbeacon.var_6c966b05) && placedspawnbeacon.var_6c966b05 != -1 && isdefined(placedspawnbeacon.spawnlist)) {
        function_7f1df6a1(placedspawnbeacon.var_6c966b05, placedspawnbeacon.spawnlist);
        placedspawnbeacon.var_b046b5aa = placedspawnbeacon.spawns;
        placedspawnbeacon.var_b046b5aa = function_5f0081e1(placedspawnbeacon.var_b046b5aa, placedspawnbeacon);
        placedspawnbeacon.var_c1221be = [];
        foreach (spawn in placedspawnbeacon.var_b046b5aa) {
            influencer = placedspawnbeacon influencers::create_influencer("spawnVisibleToBeacon", spawn.origin, util::getteammask(player getteam()));
            if (isdefined(influencer) && influencer != -1) {
                function_7f1df6a1(influencer, placedspawnbeacon.spawnlist);
                array::add(placedspawnbeacon.var_c1221be, influencer);
            }
        }
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 2, eflags: 0x4
// Checksum 0xad7fdfab, Offset: 0x1a60
// Size: 0xfc
function private function_5f0081e1(&spawnlist, spawnbeacon) {
    var_6fc3799e = [];
    for (index = 0; index < spawnlist.size; index++) {
        if (!sighttracepassed(spawnlist[index].origin + (0, 0, 72), spawnbeacon.origin + (0, 0, 70), 0, spawnbeacon)) {
            array::add(var_6fc3799e, index);
        }
    }
    for (index = var_6fc3799e.size - 1; index >= 0; index--) {
        spawnlist = array::remove_index(spawnlist, var_6fc3799e[index]);
    }
    return spawnlist;
}

// Namespace spawn_beacon/spawnbeacon
// Params 8, eflags: 0x0
// Checksum 0x469c01a7, Offset: 0x1b68
// Size: 0x302
function function_e4cac74c(beacon, objective, team, var_7820f366, hinttext, onusefunc, var_aaa7e5c0, var_95eb7728) {
    upangle = vectorscale(vectornormalize(anglestoup(beacon.angles)), 5);
    var_8e2c7d48 = beacon.origin + upangle;
    usetrigger = spawn("trigger_radius_use", var_8e2c7d48, 0, isdefined(level.spawnbeaconsettings.settingsbundle.var_a24bbcdb) ? level.spawnbeaconsettings.settingsbundle.var_a24bbcdb : 0, isdefined(level.spawnbeaconsettings.settingsbundle.var_7ba9f65c) ? level.spawnbeaconsettings.settingsbundle.var_7ba9f65c : 0);
    usetrigger triggerignoreteam();
    usetrigger setvisibletoall();
    usetrigger setteamfortrigger(#"none");
    usetrigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    if (!isdefined(beacon.var_a13cd40b)) {
        beacon.var_a13cd40b = [];
    }
    beacon.var_a13cd40b[var_7820f366] = gameobjects::create_use_object(team, usetrigger, [], undefined, objective, 1);
    beacon.var_a13cd40b[var_7820f366] gameobjects::set_use_hint_text(hinttext);
    beacon.var_a13cd40b[var_7820f366] gameobjects::set_visible_team(var_7820f366);
    beacon.var_a13cd40b[var_7820f366] gameobjects::allow_use(var_7820f366);
    beacon.var_a13cd40b[var_7820f366].onuse = onusefunc;
    beacon.var_a13cd40b[var_7820f366].onbeginuse = var_aaa7e5c0;
    beacon.var_a13cd40b[var_7820f366].onenduse = var_95eb7728;
    beacon.var_a13cd40b[var_7820f366].var_c477841c = beacon;
}

// Namespace spawn_beacon/spawnbeacon
// Params 1, eflags: 0x4
// Checksum 0x968e2330, Offset: 0x1e78
// Size: 0x55a
function private function_6da7faba(player) {
    spawnbeacon = self.var_c477841c;
    spawnbeacon.alivetime = (isdefined(spawnbeacon.alivetime) ? spawnbeacon.alivetime : 0) + float(gettime() - (isdefined(spawnbeacon.var_87c984a5) ? spawnbeacon.var_87c984a5 : spawnbeacon.birthtime)) / 1000;
    remainingtime = (isdefined(level.spawnbeaconsettings.settingsbundle.timeout) ? level.spawnbeaconsettings.settingsbundle.timeout : 0) - spawnbeacon.alivetime;
    if (remainingtime <= (isdefined(level.spawnbeaconsettings.settingsbundle.var_c5364ce9) ? level.spawnbeaconsettings.settingsbundle.var_c5364ce9 : 0)) {
        return;
    }
    freespawnbeaconspawnlist(spawnbeacon.spawnlist);
    if (isdefined(spawnbeacon.spawns)) {
        var_6fc3799e = [];
        for (index = 0; index < level.spawnpoints.size; index++) {
            foreach (spawnpoint in spawnbeacon.spawns) {
                if (spawnpoint == level.spawnpoints[index]) {
                    array::add(var_6fc3799e, index);
                }
            }
        }
        for (index = var_6fc3799e.size - 1; index >= 0; index--) {
            level.spawnpoints = array::remove_index(level.spawnpoints, var_6fc3799e[index]);
        }
    }
    spawnbeacon notify(#"end_timer");
    spawnbeacon.remainingtime = remainingtime;
    spawnbeacon clientfield::set("enemyequip", 0);
    spawnbeacon.isdisabled = 1;
    spawnbeacon setinvisibletoall();
    spawnbeacon.origin = (6000, 6000, 6000);
    if (isdefined(spawnbeacon.var_a13cd40b)) {
        foreach (gameobject in spawnbeacon.var_a13cd40b) {
            gameobject.trigger triggerenable(0);
            gameobject.trigger.origin = spawnbeacon.origin;
        }
    }
    level.spawnbeaconsettings.beacons[spawnbeacon.objectiveid] = undefined;
    userspawnselection::removespawnbeacon(spawnbeacon.objectiveid);
    objective_delete(spawnbeacon.objectiveid);
    heldweapon = getweapon(#"hash_7ab3f9a730359659");
    spawnbeacon.owner giveweapon(heldweapon);
    spawnbeacon.owner switchtoweapon(heldweapon, 1);
    spawnbeacon.owner disableweaponcycling();
    spawnbeacon.owner disableoffhandweapons();
    spawnbeacon.owner setblockweaponpickup(heldweapon, 1);
    spawnbeacon.owner disableoffhandspecial();
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_c51687a1)) {
        player playsound(level.spawnbeaconsettings.settingsbundle.var_c51687a1);
    }
    spawnbeacon.owner.var_f88ec194 = self;
    spawnbeacon.var_6a755c00 = 1;
}

// Namespace spawn_beacon/spawnbeacon
// Params 2, eflags: 0x0
// Checksum 0xbd3c2ed7, Offset: 0x23e0
// Size: 0x59c
function function_e144d848(watcher, owner) {
    if (!isdefined(owner) || !isdefined(owner.var_f88ec194)) {
        return;
    }
    spawnbeacon = owner.var_f88ec194.var_c477841c;
    spawnbeacon endon(#"death");
    spawnbeacon thread weaponobjects::onspawnuseweaponobject(watcher, owner);
    spawnbeacon.var_6a755c00 = 0;
    if (!(isdefined(owner.var_f88ec194.previouslyhacked) && owner.var_f88ec194.previouslyhacked)) {
        if (isdefined(owner)) {
            owner stats::function_4f10b697(spawnbeacon.weapon, #"used", 1);
        }
        spawnbeacon.var_87c984a5 = gettime();
        waitresult = spawnbeacon waittilltimeout(0.05, #"stationary");
        spawnbeacon deployable::function_c334d8f9(owner);
        spawnbeacon.isdisabled = 0;
        spawnbeacon notify(#"beacon_enabled");
        userspawnselection::registeravailablespawnbeacon(spawnbeacon.objectiveid, spawnbeacon);
        spawnbeacon.var_8ddac514 = owner.var_8ddac514;
        owner.var_8ddac514 = undefined;
        if (isdefined(spawnbeacon.var_8ddac514) && isdefined(spawnbeacon.var_8ddac514.spawns)) {
            createspawngroupforspawnbeacon(spawnbeacon, spawnbeacon.var_8ddac514.spawns);
        }
        owner takeweapon(getweapon(#"hash_7ab3f9a730359659"));
        owner enableweaponcycling();
        owner enableoffhandweapons();
        owner enableoffhandspecial();
        spawnbeacon setvisibletoall();
        if (isdefined(spawnbeacon.othermodel)) {
            spawnbeacon.othermodel setinvisibletoall();
        }
        objective_add(spawnbeacon.objectiveid, "active", spawnbeacon.origin, level.spawnbeaconsettings.settingsbundle.mainobjective);
        objective_setteam(spawnbeacon.objectiveid, spawnbeacon.team);
        function_c3a2445a(spawnbeacon.objectiveid, owner getteam(), 1);
        objective_setprogress(spawnbeacon.objectiveid, 1);
        level.spawnbeaconsettings.beacons[spawnbeacon.objectiveid] = spawnbeacon;
        if (spawnbeacon.var_6c966b05 != -1 && isdefined(spawnbeacon.var_6c966b05) && isdefined(spawnbeacon.spawnlist)) {
            function_7f1df6a1(spawnbeacon.var_6c966b05, spawnbeacon.spawnlist);
        }
        owner clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 1);
        spawnbeacon clientfield::set("enemyequip", 1);
        owner.var_9dc60ff3 = 1;
        spawnbeacon setanim(#"o_spawn_beacon_deploy", 1);
        upangle = vectorscale(vectornormalize(anglestoup(spawnbeacon.angles)), 5);
        if (isdefined(spawnbeacon.var_a13cd40b)) {
            foreach (gameobject in spawnbeacon.var_a13cd40b) {
                gameobject.trigger triggerenable(1);
                gameobject.trigger.origin = spawnbeacon.origin + upangle;
            }
        }
        spawnbeacon function_cf44e975(spawnbeacon.remainingtime);
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 1, eflags: 0x0
// Checksum 0xc1c8bfbf, Offset: 0x2988
// Size: 0x5a
function function_9b287b6b(watcher) {
    watcher.watchforfire = 1;
    watcher.onspawn = &function_e144d848;
    watcher.ontimeout = &function_c593591e;
    watcher.deleteonplayerspawn = 0;
}

// Namespace spawn_beacon/spawnbeacon
// Params 1, eflags: 0x4
// Checksum 0x797bf89a, Offset: 0x29f0
// Size: 0x5c
function private function_ad4e6dd8(player) {
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_ab4030aa)) {
        player playloopsound(level.spawnbeaconsettings.settingsbundle.var_ab4030aa);
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 1, eflags: 0x4
// Checksum 0x196722d, Offset: 0x2a58
// Size: 0x24
function private function_97822ae6(player) {
    function_ad4e6dd8(player);
}

// Namespace spawn_beacon/spawnbeacon
// Params 1, eflags: 0x4
// Checksum 0xf317a318, Offset: 0x2a88
// Size: 0xbe
function private function_dbf5b75d(player) {
    function_ad4e6dd8(player);
    playerteam = player getteam();
    function_a6b3743(level.spawnbeaconsettings.settingsbundle.var_890b1c8, util::getotherteam(playerteam), undefined);
    objective_setgamemodeflags(self.var_c477841c.objectiveid, 4);
    self.var_c477841c.isdisabled = 1;
}

// Namespace spawn_beacon/spawnbeacon
// Params 1, eflags: 0x4
// Checksum 0x95d86d0f, Offset: 0x2b50
// Size: 0xac
function private function_7ae62294(player) {
    spawnbeacon = self.var_c477841c;
    spawnbeacon.var_f57edff2 = 1;
    spawnbeacon.var_bdebe64e = player;
    spawnbeacon thread function_bbb85eca(1);
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_c51687a1)) {
        player playsound(level.spawnbeaconsettings.settingsbundle.var_c51687a1);
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 3, eflags: 0x4
// Checksum 0x5798b258, Offset: 0x2c08
// Size: 0xe4
function private function_67f77beb(team, player, result) {
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_ab4030aa)) {
        player stoploopsound();
    }
    if (self.team == player.team) {
        self.var_c477841c.owner clientclaimtrigger(self.trigger);
    }
    self.var_c477841c.isdisabled = 0;
    objective_setgamemodeflags(self.var_c477841c.objectiveid, 0);
    self.var_c477841c notify(#"beacon_enabled");
}

// Namespace spawn_beacon/spawnbeacon
// Params 3, eflags: 0x0
// Checksum 0x971f3d4, Offset: 0x2cf8
// Size: 0x364
function function_6a26da93(origin, angles, player) {
    if (!isdefined(player.var_8ddac514)) {
        player.var_8ddac514 = spawnstruct();
    }
    player.var_8ddac514.spawns = getspawnbeaconspawns(origin);
    if (player.var_8ddac514.spawns.size == 0) {
        player sethintstring(level.spawnbeaconsettings.settingsbundle.var_76b0005d);
        return false;
    }
    foreach (protectedzone in level.spawnbeaconsettings.var_d00173bf) {
        if (protectedzone istouching(origin, (16, 16, 70))) {
            return false;
        }
    }
    var_4d2c01a3 = isdefined(level.spawnbeaconsettings.settingsbundle.var_13030e07) ? level.spawnbeaconsettings.settingsbundle.var_13030e07 : 0;
    testdistance = var_4d2c01a3 * var_4d2c01a3;
    var_72de6a50 = getarraykeys(level.spawnbeaconsettings.userspawnbeacons);
    foreach (var_b26b1ab8 in var_72de6a50) {
        if (var_b26b1ab8 == player.clientid) {
            continue;
        }
        var_7244a8f9 = level.spawnbeaconsettings.userspawnbeacons[var_b26b1ab8];
        foreach (beacon in var_7244a8f9) {
            if (!isdefined(beacon)) {
                continue;
            }
            distsqr = distancesquared(origin, beacon.origin);
            if (distsqr <= testdistance) {
                player sethintstring(level.spawnbeaconsettings.settingsbundle.var_7a125d6c);
                return false;
            }
        }
    }
    return true;
}

