#using scripts\abilities\ability_player;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;

#namespace spawn_beacon;

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xbdf9640f, Offset: 0x1d0
// Size: 0x1fc
function init_shared() {
    level.var_549a5ec3 = undefined;
    level.var_a21e13d4 = undefined;
    level.var_a85d8948 = undefined;
    level.var_70565793 = undefined;
    if (!isdefined(game.spawnbeaconid)) {
        game.spawnbeaconid = 0;
    }
    if (!isdefined(level.spawnbeaconsettings)) {
        level.spawnbeaconsettings = spawnstruct();
    }
    level.spawnbeaconsettings.userspawnbeacons = [];
    level.spawnbeaconsettings.availablespawnlists = [];
    level.spawnbeaconsettings.var_d00173bf = [];
    level.spawnbeaconsettings.var_cfc1135f = [];
    level.spawnbeaconsettings.settingsbundle = getscriptbundle("default_spawnbeacon_settings");
    level.spawnbeaconsettings.beaconweapon = getweapon(#"gadget_spawnbeacon");
    level.spawnbeaconsettings.var_e4c9353e = [];
    level.spawnbeaconsettings.beacons = [];
    level.spawnbeaconsettings.maxpower = 100;
    level.spawnbeaconsettings.var_6ad2c545 = (0, 0, 5);
    level.spawnbeaconsettings.var_d7242669 = 100;
    /#
        level.spawnbeaconsettings.var_18176b84 = [];
    #/
    setupcallbacks();
    setupclientfields();
    deployable::register_deployable(getweapon("gadget_spawnbeacon"), &function_6a26da93, undefined);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xbbc5fa6e, Offset: 0x3d8
// Size: 0x42
function function_ed3e6cdd() {
    if (!isdefined(level.spawnbeaconsettings)) {
        level.spawnbeaconsettings = spawnstruct();
    }
    level.spawnbeaconsettings.var_6c58ea3 = 1;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xe301cb84, Offset: 0x428
// Size: 0x42
function function_565069d4() {
    if (!isdefined(level.spawnbeaconsettings)) {
        level.spawnbeaconsettings = spawnstruct();
    }
    level.spawnbeaconsettings.var_565069d4 = 1;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x2d4c51fb, Offset: 0x478
// Size: 0x4a
function function_fbd7282a(var_a43f25fa) {
    if (!isdefined(level.spawnbeaconsettings)) {
        level.spawnbeaconsettings = spawnstruct();
    }
    level.spawnbeaconsettings.var_c59fd2a7 = var_a43f25fa;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x9b29a157, Offset: 0x4d0
// Size: 0xa0
function function_fcf5ee73(team) {
    foreach (spawnbeacon in level.spawnbeaconsettings.beacons) {
        if (!isdefined(spawnbeacon)) {
            continue;
        }
        if (team == spawnbeacon.team) {
            return true;
        }
    }
    return false;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x3ad963b0, Offset: 0x578
// Size: 0x72
function function_92b915b1(watcher) {
    watcher.watchforfire = 1;
    watcher.onspawn = &beacon_spawned;
    watcher.ontimeout = &function_c593591e;
    watcher.var_46869d39 = &function_64d08af8;
    watcher.deleteonplayerspawn = 0;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x2d5279d7, Offset: 0x5f8
// Size: 0x3c
function function_64d08af8(player) {
    if (isdefined(self) && isdefined(self.spawnbeacon)) {
        self.spawnbeacon thread function_bbb85eca(0);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x6238091, Offset: 0x640
// Size: 0x34
function function_c593591e() {
    if (isdefined(self) && isdefined(self.spawnbeacon)) {
        self.spawnbeacon thread function_bbb85eca(0);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x47023a38, Offset: 0x680
// Size: 0x284
function function_cf44e975(time) {
    self endon(#"death", #"end_timer");
    if (time == 0) {
        return;
    }
    if (isdefined(level.spawnbeaconsettings.var_565069d4) ? level.spawnbeaconsettings.var_565069d4 : 0) {
        return;
    }
    if (isdefined(level.var_bf737a5b)) {
        time = level.var_bf737a5b;
    }
    if (time > (isdefined(level.spawnbeaconsettings.settingsbundle.var_c5364ce9) ? level.spawnbeaconsettings.settingsbundle.var_c5364ce9 : 0)) {
        wait time - (isdefined(level.spawnbeaconsettings.settingsbundle.var_c5364ce9) ? level.spawnbeaconsettings.settingsbundle.var_c5364ce9 : 0);
    }
    if (!isdefined(self)) {
        return;
    } else if (isdefined(level.var_a2c2995e)) {
        self [[ level.var_a2c2995e ]]();
    }
    remainingtime = isdefined(level.spawnbeaconsettings.settingsbundle.var_c5364ce9) ? level.spawnbeaconsettings.settingsbundle.var_c5364ce9 : time > (isdefined(level.spawnbeaconsettings.settingsbundle.var_c5364ce9) ? level.spawnbeaconsettings.settingsbundle.var_c5364ce9 : 0) ? 0 : time;
    wait remainingtime;
    while (isdefined(level.spawnbeaconsettings.var_6c58ea3) && level.spawnbeaconsettings.var_6c58ea3 && isdefined(self) && isdefined(self.owner) && !isalive(self.owner)) {
        wait 0.5;
    }
    if (!isdefined(self)) {
        return;
    }
    self thread function_bbb85eca(0);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 2, eflags: 0x0
// Checksum 0x90982597, Offset: 0x910
// Size: 0x1fc
function beacon_spawned(watcher, owner) {
    self endon(#"death");
    self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
    self hide();
    if (isdefined(self.previouslyhacked) && self.previouslyhacked) {
        return;
    }
    waitframe(1);
    owner notify(#"hash_31be1f8b27209ad0", {#player:owner, #beacon:self});
    if (!owner deployable::location_valid()) {
        owner deployable::function_76d9b29b(level.spawnbeaconsettings.beaconweapon);
        self delete();
        return;
    }
    if (isdefined(owner)) {
        owner stats::function_4f10b697(self.weapon, #"used", 1);
    }
    self deployable::function_c334d8f9(owner);
    self.var_8ddac514 = owner.var_8ddac514;
    owner.var_8ddac514 = undefined;
    owner onplacespawnbeacon(self);
    owner clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 1);
    owner.var_9dc60ff3 = 1;
    spawnbeacon = self.spawnbeacon;
    spawnbeacon setanim(#"o_spawn_beacon_deploy", 1);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 3, eflags: 0x0
// Checksum 0xd8889767, Offset: 0xb18
// Size: 0x116
function function_a6b3743(soundbank, team, excludeplayer) {
    if (!isdefined(soundbank)) {
        return;
    }
    if (!isdefined(level.spawnbeaconsettings.var_cfc1135f[soundbank])) {
        level.spawnbeaconsettings.var_cfc1135f[soundbank] = 0;
    }
    var_832d4d43 = level.spawnbeaconsettings.var_cfc1135f[soundbank];
    if (var_832d4d43 != 0 && gettime() < int(5 * 1000) + var_832d4d43) {
        return;
    }
    var_9b3a3e20 = [];
    var_9b3a3e20[0] = excludeplayer;
    killstreaks::leader_dialog(soundbank, team, var_9b3a3e20, "spawnbeacon");
    level.spawnbeaconsettings.var_cfc1135f[soundbank] = gettime();
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x1dce4880, Offset: 0xc38
// Size: 0x94
function setupclientfields() {
    clientfield::register("scriptmover", "spawnbeacon_placed", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.spawnbeacon.cooldownPenalty", 1, 6, "int");
    clientfield::register("clientuimodel", "hudItems.spawnbeacon.active", 1, 1, "int");
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x4d5d9b45, Offset: 0xcd8
// Size: 0x54
function function_c18d3278() {
    player = self;
    if (isdefined(player.var_9dc60ff3) && player.var_9dc60ff3) {
        player clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 1);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x4
// Checksum 0x97f350b7, Offset: 0xd38
// Size: 0xcc
function private setupcallbacks() {
    ability_player::register_gadget_activation_callbacks(26, &gadget_spawnbeacon_on, &gadget_spawnbeacon_off);
    callback::on_player_killed_with_params(&on_player_killed);
    callback::on_spawned(&on_player_spawned);
    callback::on_loadout(&on_loadout);
    weaponobjects::function_f298eae6(#"gadget_spawnbeacon", &function_92b915b1, 1);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x4
// Checksum 0xcda76dfc, Offset: 0xe10
// Size: 0x4c
function private function_a765d258(slot) {
    wait 0.1;
    self function_1d590050(slot, 1);
    self gadgetpowerset(slot, 0);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x92d9f4c8, Offset: 0xe68
// Size: 0x14c
function function_7b9e60f3() {
    if (!self hasweapon(level.spawnbeaconsettings.beaconweapon)) {
        self clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 0);
        self.var_9dc60ff3 = 0;
        return;
    }
    if (!isdefined(self.pers[#"hash_677f229433c8735b"])) {
        self.pers[#"hash_677f229433c8735b"] = 0;
    }
    if (getdvarint(#"hash_da55c6d97d1dc52", 1) && (isdefined(level.var_f4bde2aa) ? level.var_f4bde2aa : 0) && self.pers[#"hash_677f229433c8735b"] >= 1) {
        var_345fb68e = self gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
        self thread function_a765d258(var_345fb68e);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xec148aba, Offset: 0xfc0
// Size: 0x1c
function on_loadout() {
    self function_7b9e60f3();
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xc9c6f956, Offset: 0xfe8
// Size: 0x48
function on_player_spawned() {
    player = self;
    player function_c18d3278();
    if (isdefined(level.var_549a5ec3)) {
        self [[ level.var_549a5ec3 ]]();
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x5346469d, Offset: 0x1038
// Size: 0x196
function function_32b31739() {
    spawnbeacon = self;
    spawnbeacon.threatlevel = 0;
    foreach (player in level.players) {
        if (player getteam() == spawnbeacon.team) {
            continue;
        }
        foreach (var_aec06347 in level.spawnbeaconsettings.var_e4c9353e) {
            distance = distancesquared(spawnbeacon.origin, player.origin);
            if (distance <= var_aec06347.zonemax && distance > var_aec06347.zonemin) {
                spawnbeacon.threatlevel += var_aec06347.points;
            }
        }
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x595c8631, Offset: 0x11d8
// Size: 0x19e
function updatethreat() {
    level endon(#"game_ended");
    spawnbeacon = self;
    spawnbeacon endon(#"beacon_removed");
    while (isdefined(spawnbeacon)) {
        if (isdefined(spawnbeacon.isdisabled) && spawnbeacon.isdisabled) {
            spawnbeacon waittill(#"beacon_enabled");
        }
        spawnbeacon function_32b31739();
        if (spawnbeacon.threatlevel >= (isdefined(level.spawnbeaconsettings.settingsbundle.var_8dabcf22) ? level.spawnbeaconsettings.settingsbundle.var_8dabcf22 : 0)) {
            objective_setgamemodeflags(spawnbeacon.objectiveid, 2);
        } else if (spawnbeacon.threatlevel >= (isdefined(level.spawnbeaconsettings.settingsbundle.var_40312c9) ? level.spawnbeaconsettings.settingsbundle.var_40312c9 : 0)) {
            objective_setgamemodeflags(spawnbeacon.objectiveid, 1);
        } else {
            objective_setgamemodeflags(spawnbeacon.objectiveid, 0);
        }
        wait 1;
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x155e6ac6, Offset: 0x1380
// Size: 0x92
function getnewspawnbeaconspawnlist() {
    if (!sessionmodeiscampaigngame()) {
        assert(level.spawnbeaconsettings.availablespawnlists.size > 0);
        spawnlist = array::pop(level.spawnbeaconsettings.availablespawnlists);
        assert(isdefined(spawnlist));
        return spawnlist;
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0xee4f8bda, Offset: 0x1420
// Size: 0x74
function freespawnbeaconspawnlist(spawnlistname) {
    if (isdefined(spawnlistname)) {
        assert(!array::contains(level.spawnbeaconsettings.availablespawnlists, spawnlistname));
        array::push(level.spawnbeaconsettings.availablespawnlists, spawnlistname);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 2, eflags: 0x0
// Checksum 0xa4bf3036, Offset: 0x14a0
// Size: 0x66
function gadget_spawnbeacon_on(slot, playerweapon) {
    assert(isplayer(self));
    self notify(#"start_killstreak", {#weapon:playerweapon});
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 2, eflags: 0x0
// Checksum 0x67b42933, Offset: 0x1510
// Size: 0x1e
function gadget_spawnbeacon_off(slot, weapon) {
    self.var_fa6f762 = 0;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0xd482d5c, Offset: 0x1538
// Size: 0xac
function on_player_killed(s_params) {
    if (isdefined(self.spawnbeaconbuildprogressobjid)) {
        deleteobjective(self.spawnbeaconbuildprogressobjid);
        self.spawnbeaconbuildprogressobjid = undefined;
    }
    if (isdefined(self.var_fa6f762) && self.var_fa6f762 && isdefined(s_params.eattacker)) {
        killstreaks::processscoreevent(#"forward_spawn_stopped_activation", s_params.eattacker, undefined, level.spawnbeaconsettings.beaconweapon);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x9ca03924, Offset: 0x15f0
// Size: 0x12
function getobjectiveid() {
    return gameobjects::get_next_obj_id();
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x42274c99, Offset: 0x1610
// Size: 0x44
function deleteobjective(objectiveid) {
    if (isdefined(objectiveid)) {
        objective_delete(objectiveid);
        gameobjects::release_obj_id(objectiveid);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x4034c35a, Offset: 0x1660
// Size: 0x18c
function function_4176f0b7() {
    spawnbeacon = self;
    player = spawnbeacon.owner;
    if (!isdefined(player)) {
        return;
    }
    if (!player hasweapon(level.spawnbeaconsettings.beaconweapon)) {
        return;
    }
    var_345fb68e = player gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
    currentpower = player gadgetpowerget(var_345fb68e) / 100;
    penalty = (isdefined(level.spawnbeaconsettings.settingsbundle.var_de4da38d) ? level.spawnbeaconsettings.settingsbundle.var_de4da38d : 0) - (isdefined(level.spawnbeaconsettings.settingsbundle.var_de4da38d) ? level.spawnbeaconsettings.settingsbundle.var_de4da38d : 0) * currentpower;
    player.var_2d0fa10 = int(penalty);
    player clientfield::set_player_uimodel("hudItems.spawnbeacon.cooldownPenalty", player.var_2d0fa10);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x4
// Checksum 0x3b92fbe8, Offset: 0x17f8
// Size: 0x13c
function private function_a5975cae() {
    spawnbeacon = self;
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_63bb0fa4) ? level.spawnbeaconsettings.settingsbundle.var_63bb0fa4 : 0) {
        spawnbeacon function_4176f0b7();
    }
    function_a6b3743(level.spawnbeaconsettings.settingsbundle.var_1ca489a3, spawnbeacon.team, undefined);
    function_a6b3743(level.spawnbeaconsettings.settingsbundle.var_ae0dc5f6, util::getotherteam(spawnbeacon.team), spawnbeacon.var_bdebe64e);
    spawnbeacon.owner globallogic_score::function_a63adb85(spawnbeacon.var_bdebe64e, spawnbeacon.var_d29261ce, level.spawnbeaconsettings.beaconweapon);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0xa3bba282, Offset: 0x1940
// Size: 0x99c
function function_bbb85eca(var_757a988f) {
    self notify(#"hash_523ddcbd662010e5");
    self function_40d42886();
    self.var_7bee2c23 = 1;
    spawnbeacon = self;
    attacker = var_757a988f ? self.var_bdebe64e : self.owner;
    spawnbeacon dodamage(spawnbeacon.health + 10000, spawnbeacon.origin, attacker, undefined, undefined, "MOD_EXPLOSIVE");
    if (target_istarget(spawnbeacon)) {
        target_remove(spawnbeacon);
    }
    player = self.owner;
    if (isdefined(self.beacondisabled) && self.beacondisabled) {
        return;
    }
    if (isdefined(level.var_b31e16d4) && isdefined(spawnbeacon.var_bdebe64e) && spawnbeacon.var_bdebe64e != player) {
        self [[ level.var_b31e16d4 ]](spawnbeacon.var_bdebe64e, player, level.spawnbeaconsettings.beaconweapon, spawnbeacon.var_d29261ce);
    }
    if (game.state == "playing") {
        if (spawnbeacon.health <= 0) {
            if (isdefined(level.spawnbeaconsettings.settingsbundle.var_5be3e16b)) {
                spawnbeacon playsound(level.spawnbeaconsettings.settingsbundle.var_5be3e16b);
            }
        } else if (isdefined(level.spawnbeaconsettings.settingsbundle.var_b24bd80)) {
            spawnbeacon playsound(level.spawnbeaconsettings.settingsbundle.var_b24bd80);
        }
        if (isdefined(var_757a988f) && var_757a988f) {
            self function_a5975cae();
        } else {
            function_a6b3743(level.spawnbeaconsettings.settingsbundle.var_2d7cb8da, self.team, undefined);
            function_a6b3743(level.spawnbeaconsettings.settingsbundle.var_4e1372fb, util::getotherteam(self.team), undefined);
        }
    }
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_f2279079)) {
        playfx(level.spawnbeaconsettings.settingsbundle.var_f2279079, spawnbeacon.origin);
    }
    if ((isdefined(self.var_6a755c00) ? self.var_6a755c00 : 0) || isdefined(player) && isdefined(player.var_f88ec194) && player hasweapon(getweapon(#"hash_7ab3f9a730359659"), 1)) {
        if (isdefined(self.objectiveid)) {
            gameobjects::release_obj_id(self.objectiveid);
        }
    } else {
        profilestart();
        if (isdefined(level.var_a21e13d4)) {
            self [[ level.var_a21e13d4 ]]();
        }
        /#
            array::push_front(level.spawnbeaconsettings.var_18176b84, self.objectiveid);
        #/
        deleteobjective(self.objectiveid);
        self.beacondisabled = 1;
        level.spawnbeaconsettings.beacons[self.objectiveid] = undefined;
        freespawnbeaconspawnlist(self.spawnlist);
        profilestop();
    }
    if (isdefined(self.spawns)) {
        var_6fc3799e = [];
        for (index = 0; index < level.spawnpoints.size; index++) {
            foreach (spawnpoint in self.spawns) {
                if (spawnpoint == level.spawnpoints[index]) {
                    array::add(var_6fc3799e, index);
                }
            }
        }
        for (index = var_6fc3799e.size - 1; index >= 0; index--) {
            level.spawnpoints = array::remove_index(level.spawnpoints, var_6fc3799e[index]);
        }
    }
    self clientfield::set("enemyequip", 0);
    if (isdefined(self.var_a13cd40b)) {
        foreach (gameobject in self.var_a13cd40b) {
            gameobject gameobjects::destroy_object(1, 1);
        }
    }
    indextoremove = undefined;
    if (isdefined(self.owner)) {
        for (index = 0; index < level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid].size; index++) {
            if (level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid][index] == self) {
                indextoremove = index;
            }
        }
    }
    if (isdefined(indextoremove)) {
        level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid] = array::remove_index(level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid], indextoremove, 0);
    }
    self stoploopsound();
    self notify(#"beacon_removed");
    self callback::remove_callback(#"on_end_game", &function_92d9c4be);
    if (isdefined(player)) {
        player notify(#"beacon_removed");
        player clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 0);
        player.var_9dc60ff3 = 0;
        player thread function_71cd592b();
    }
    if (isdefined(self.var_d37785ca)) {
        self.var_d37785ca delete();
    }
    deployable::function_2cefe05a(self);
    var_e313ea4a = self gettagorigin("tag_base_d0");
    var_7787e02c = self gettagangles("tag_base_d0");
    var_82a3f7eb = anglestoforward(var_7787e02c);
    var_992de64b = anglestoup(var_7787e02c);
    playfx(#"hash_695b2e7e4b63a645", var_e313ea4a, var_82a3f7eb, var_992de64b);
    if (!(isdefined(spawnbeacon.var_3e80873b) ? spawnbeacon.var_3e80873b : 0) && (isdefined(level.var_f4bde2aa) ? level.var_f4bde2aa : 0) && isdefined(player)) {
        player.pers[#"lives"]--;
    }
    self delete();
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x4844a576, Offset: 0x22e8
// Size: 0x54
function function_71cd592b() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    wait 5;
    self globallogic_score::function_8fe8d71e(#"hash_3202a744d141627b");
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x99601a78, Offset: 0x2348
// Size: 0x3f0
function getspawnbeaconspawns(origin) {
    spawnstoadd = [];
    collectionradiusmax = (isdefined(level.spawnbeaconsettings.settingsbundle.collectionradiusmax) ? level.spawnbeaconsettings.settingsbundle.collectionradiusmax : 0) * (isdefined(level.spawnbeaconsettings.settingsbundle.collectionradiusmax) ? level.spawnbeaconsettings.settingsbundle.collectionradiusmax : 0);
    collectionradiusmin = (isdefined(level.spawnbeaconsettings.settingsbundle.collectionradiusmin) ? level.spawnbeaconsettings.settingsbundle.collectionradiusmin : 0) * (isdefined(level.spawnbeaconsettings.settingsbundle.collectionradiusmin) ? level.spawnbeaconsettings.settingsbundle.collectionradiusmin : 0);
    var_d4727c22 = isdefined(level.spawnbeaconsettings.settingsbundle.var_1c32e878) ? level.spawnbeaconsettings.settingsbundle.var_1c32e878 : 0;
    if (!isdefined(level.allspawnpoints)) {
        return spawnstoadd;
    }
    foreach (spawnpoint in level.allspawnpoints) {
        if (isdefined(spawnpoint.ct) ? spawnpoint.ct : 0) {
            continue;
        }
        if (var_d4727c22 > 0 && abs(spawnpoint.origin[2] - origin[2]) > var_d4727c22) {
            continue;
        }
        distsqr = distancesquared(origin, spawnpoint.origin);
        if (distsqr > collectionradiusmax) {
            continue;
        }
        if (distsqr < collectionradiusmin) {
            continue;
        }
        var_cb7be65e = 0;
        foreach (protectedzone in level.spawnbeaconsettings.var_d00173bf) {
            if (protectedzone istouching(spawnpoint.origin, (45, 45, 72))) {
                var_cb7be65e = 1;
                break;
            }
        }
        if (var_cb7be65e) {
            continue;
        }
        if (!isdefined(spawnpoint.enabled)) {
            spawnpoint.enabled = -1;
        }
        if (!isdefined(spawnstoadd)) {
            spawnstoadd = [];
        } else if (!isarray(spawnstoadd)) {
            spawnstoadd = array(spawnstoadd);
        }
        spawnstoadd[spawnstoadd.size] = spawnpoint;
    }
    return spawnstoadd;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 2, eflags: 0x0
// Checksum 0xaf98cadc, Offset: 0x2740
// Size: 0x224
function createspawngroupforspawnbeacon(associatedspawnbeacon, spawnstoadd) {
    assert(isdefined(spawnstoadd));
    assert(isdefined(associatedspawnbeacon));
    if (spawnstoadd.size == 0) {
        return false;
    }
    team = associatedspawnbeacon.team;
    enemyteam = util::getotherteam(team);
    var_333c45f2 = level.teambased && isdefined(game.switchedsides) && game.switchedsides && level.spawnsystem.var_65fd4eef;
    if (var_333c45f2) {
        enemyteam = team;
        team = enemyteam;
    }
    associatedspawnbeacon.spawnlist = getnewspawnbeaconspawnlist();
    assert(isdefined(associatedspawnbeacon.spawnlist));
    assert(isdefined(team));
    addspawnpoints(team, spawnstoadd, associatedspawnbeacon.spawnlist);
    addspawnpoints(enemyteam, spawnstoadd, associatedspawnbeacon.spawnlist);
    associatedspawnbeacon.spawns = spawnstoadd;
    foreach (spawnpoint in associatedspawnbeacon.spawns) {
        array::add(level.spawnpoints, spawnpoint, 0);
    }
    return true;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xc26bd89a, Offset: 0x2970
// Size: 0x200
function function_675eb676() {
    spawnbeacon = self;
    spawnbeacon endon(#"beacon_removed");
    level endon(#"game_ended");
    spawnbeacon.isdisabled = 1;
    spawnbeacon notify(#"beacon_disabled");
    objective_setgamemodeflags(spawnbeacon.objectiveid, 3);
    var_a7d57275 = isdefined(level.spawnbeaconsettings.settingsbundle.var_6973ed18) ? level.spawnbeaconsettings.settingsbundle.var_6973ed18 : 0;
    var_583cd58c = "";
    if (spawnbeacon.team == #"allies") {
        var_583cd58c = "A";
    } else {
        var_583cd58c = "B";
    }
    function_a6b3743(level.spawnbeaconsettings.settingsbundle.var_786a0ed4, spawnbeacon.team, undefined);
    function_a6b3743(level.spawnbeaconsettings.settingsbundle.var_551990e9, util::getotherteam(spawnbeacon.team), undefined);
    setbombtimer(var_583cd58c, gettime() + int(var_a7d57275 * 1000));
    wait var_a7d57275;
    spawnbeacon.isdisabled = 0;
    spawnbeacon notify(#"beacon_enabled");
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xcf9cf4, Offset: 0x2b78
// Size: 0x13c
function watchfordeath() {
    level endon(#"game_ended");
    self.owner endon(#"disconnect", #"joined_team", #"changed_specialist");
    self endon(#"hash_523ddcbd662010e5");
    waitresult = self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    var_f57edff2 = 1;
    self.var_bdebe64e = waitresult.attacker;
    self.var_d29261ce = waitresult.weapon;
    if (isdefined(waitresult.attacker) && isdefined(self) && isdefined(self.owner) && waitresult.attacker.team == self.owner.team) {
        var_f57edff2 = 0;
    }
    self thread function_bbb85eca(var_f57edff2);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xa4089556, Offset: 0x2cc0
// Size: 0x180
function watchfordamage() {
    self endon(#"death");
    level endon(#"game_ended");
    self endon(#"hash_523ddcbd662010e5");
    spawnbeacon = self;
    spawnbeacon endon(#"death");
    spawnbeacon.health = level.spawnbeaconsettings.settingsbundle.health;
    if (isdefined(level.var_1df63c88)) {
        spawnbeacon.health = level.var_1df63c88;
    }
    spawnbeacon.maxhealth = spawnbeacon.health;
    while (true) {
        waitresult = self waittill(#"damage");
        if (isdefined(waitresult.attacker) && waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker)) {
            waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
        }
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 12, eflags: 0x0
// Checksum 0x47850b1e, Offset: 0x2e48
// Size: 0x112
function function_bb79329c(einflictor, attacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex) {
    bundle = level.spawnbeaconsettings.settingsbundle;
    chargelevel = 0;
    weapon_damage = killstreak_bundles::function_9c163c89(bundle, bundle.health, attacker, weapon, smeansofdeath, idamage, idflags, chargelevel);
    if (!isdefined(weapon_damage)) {
        weapon_damage = killstreaks::get_old_damage(attacker, weapon, smeansofdeath, idamage, 1);
    }
    return int(weapon_damage);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xb0a6528c, Offset: 0x2f68
// Size: 0x34
function function_92d9c4be() {
    spawnbeacon = self;
    spawnbeacon.var_c7ef0038 = 1;
    spawnbeacon function_40d42886();
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xbec3bcd5, Offset: 0x2fa8
// Size: 0x36
function function_7586d886() {
    currentid = game.spawnbeaconid;
    game.spawnbeaconid += 1;
    return currentid;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x259894b9, Offset: 0x2fe8
// Size: 0x4c
function function_b0d945a1() {
    self endon(#"death");
    self waittill(#"game_ended");
    if (!isdefined(self)) {
        return;
    }
    self function_bbb85eca(0);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 2, eflags: 0x0
// Checksum 0x1ba3002a, Offset: 0x3040
// Size: 0x938
function function_f85e8528(var_3713c5b, spawns) {
    player = self;
    if (isdefined(level.spawnbeaconsettings.userspawnbeacons[player.clientid]) && level.spawnbeaconsettings.userspawnbeacons[player.clientid].size >= (isdefined(level.spawnbeaconsettings.settingsbundle.var_beeb23f2) ? level.spawnbeaconsettings.settingsbundle.var_beeb23f2 : 1)) {
        beacontoremove = level.spawnbeaconsettings.userspawnbeacons[player.clientid][0];
        if (isdefined(beacontoremove)) {
            beacontoremove thread function_bbb85eca(0);
        } else {
            level.spawnbeaconsettings.userspawnbeacons[self.clientid] = undefined;
        }
    }
    slot = player gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
    player gadgetpowerreset(slot);
    player gadgetpowerset(slot, 0);
    var_345fb68e = player gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
    player function_6a67b266(var_345fb68e, 0);
    placedspawnbeacon = spawn("script_model", var_3713c5b.origin);
    placedspawnbeacon setmodel(level.spawnbeaconsettings.beaconweapon.worldmodel);
    var_3713c5b.spawnbeacon = placedspawnbeacon;
    placedspawnbeacon.var_d37785ca = var_3713c5b;
    placedspawnbeacon function_1f5068be(#"hash_77200d1bb519ba08");
    placedspawnbeacon useanimtree("generic");
    target_set(placedspawnbeacon, (0, 0, 32));
    placedspawnbeacon.owner = player;
    placedspawnbeacon clientfield::set("spawnbeacon_placed", 1);
    placedspawnbeacon setteam(player getteam());
    placedspawnbeacon.var_6b0336c0 = &function_bb79329c;
    placedspawnbeacon solid();
    placedspawnbeacon show();
    if (isdefined(level.var_f4bde2aa) ? level.var_f4bde2aa : 0) {
        player.pers[#"lives"]++;
    }
    placedspawnbeacon setweapon(level.spawnbeaconsettings.beaconweapon);
    placedspawnbeacon.weapon = level.spawnbeaconsettings.beaconweapon;
    placedspawnbeacon.objectiveid = getobjectiveid();
    objective_add(placedspawnbeacon.objectiveid, "active", placedspawnbeacon.origin, level.spawnbeaconsettings.settingsbundle.mainobjective);
    objective_setteam(placedspawnbeacon.objectiveid, placedspawnbeacon.team);
    function_c3a2445a(placedspawnbeacon.objectiveid, player getteam(), 1);
    objective_setprogress(placedspawnbeacon.objectiveid, 1);
    createspawngroupforspawnbeacon(placedspawnbeacon, spawns);
    level.spawnbeaconsettings.beacons[placedspawnbeacon.objectiveid] = placedspawnbeacon;
    if (!isdefined(level.spawnbeaconsettings.userspawnbeacons[player.clientid])) {
        level.spawnbeaconsettings.userspawnbeacons[player.clientid] = [];
    }
    var_d8817fe = level.spawnbeaconsettings.userspawnbeacons.size + 1;
    array::push(level.spawnbeaconsettings.userspawnbeacons[player.clientid], placedspawnbeacon, var_d8817fe);
    if (isdefined(level.spawnbeaconsettings.settingsbundle.canbedamaged) ? level.spawnbeaconsettings.settingsbundle.canbedamaged : 0) {
        placedspawnbeacon setcandamage(1);
    }
    placedspawnbeacon clientfield::set("enemyequip", 1);
    placedspawnbeacon.var_2fd0d55c = gettime();
    placedspawnbeacon.threatlevel = 0;
    placedspawnbeacon.spawncount = 0;
    placedspawnbeacon.uniqueid = function_7586d886();
    function_a6b3743(level.spawnbeaconsettings.settingsbundle.var_531ebf8a, player getteam(), player);
    function_a6b3743(level.spawnbeaconsettings.settingsbundle.var_29a9aee1, util::getotherteam(player getteam()), undefined);
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_6558c1e7)) {
        placedspawnbeacon playloopsound(level.spawnbeaconsettings.settingsbundle.var_6558c1e7);
    }
    if (isdefined(level.var_a85d8948)) {
        self [[ level.var_a85d8948 ]](placedspawnbeacon);
    }
    placedspawnbeacon thread updatethreat();
    placedspawnbeacon thread watchfordamage();
    placedspawnbeacon thread watchfordeath();
    placedspawnbeacon thread function_cf44e975(isdefined(level.spawnbeaconsettings.settingsbundle.timeout) ? level.spawnbeaconsettings.settingsbundle.timeout : 0);
    placedspawnbeacon thread function_b0d945a1();
    placedspawnbeacon callback::function_1dea870d(#"on_end_game", &function_92d9c4be);
    player deployable::function_c0980d61(placedspawnbeacon, level.spawnbeaconsettings.beaconweapon);
    if (!isdefined(player.pers[#"hash_677f229433c8735b"])) {
        player.pers[#"hash_677f229433c8735b"] = 0;
    }
    player.pers[#"hash_677f229433c8735b"]++;
    if (getdvarint(#"hash_da55c6d97d1dc52", 1) && (isdefined(level.var_f4bde2aa) ? level.var_f4bde2aa : 0)) {
        player function_1d590050(slot, 1);
    }
    player notify(#"beacon_added");
}

/#

    // Namespace spawn_beacon/spawnbeacon_shared
    // Params 2, eflags: 0x0
    // Checksum 0xf437231, Offset: 0x3980
    // Size: 0x34
    function function_28145200(var_30b50f38, jammer) {
        println("<dev string:x30>");
    }

#/

// Namespace spawn_beacon/spawnbeacon_shared
// Params 3, eflags: 0x0
// Checksum 0xe5f349c1, Offset: 0x39c0
// Size: 0x88
function function_6a26da93(origin, angles, player) {
    if (!isdefined(player.var_8ddac514)) {
        player.var_8ddac514 = spawnstruct();
    }
    player.var_8ddac514.spawns = [];
    if (isdefined(level.var_70565793)) {
        return [[ level.var_70565793 ]](origin, angles, player);
    }
    return 1;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0xf3e79436, Offset: 0x3a50
// Size: 0xa4
function onplacespawnbeacon(spawnbeacon) {
    spawnbeacon setvisibletoall();
    if (isdefined(spawnbeacon.othermodel)) {
        spawnbeacon.othermodel setinvisibletoall();
    }
    if (isdefined(spawnbeacon.var_8ddac514) && isdefined(spawnbeacon.var_8ddac514.spawns)) {
        self function_f85e8528(spawnbeacon, spawnbeacon.var_8ddac514.spawns);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x633763d8, Offset: 0x3b00
// Size: 0x8c
function oncancelplacement(spawnbeacon) {
    var_345fb68e = self gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
    self gadgetdeactivate(var_345fb68e, level.spawnbeaconsettings.beaconweapon, 0);
    self gadgetpowerset(var_345fb68e, 100);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x2fb5a3d1, Offset: 0x3b98
// Size: 0x84
function function_bdba0753(player) {
    spawnbeacon = self;
    player endon(#"disconnect");
    spawnbeacon endon(#"death");
    player waittill(#"joined_team");
    if (isdefined(spawnbeacon)) {
        spawnbeacon thread function_bbb85eca(0);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x830a3603, Offset: 0x3c28
// Size: 0x5c
function function_2bceac9c() {
    player = self;
    if (!isdefined(level.spawnbeaconsettings) || !isdefined(level.spawnbeaconsettings.userspawnbeacons)) {
        return undefined;
    }
    return level.spawnbeaconsettings.userspawnbeacons[player.clientid];
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3c90
// Size: 0x4
function function_40d42886() {
    
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3ca0
// Size: 0x4
function function_9181f402() {
    
}

