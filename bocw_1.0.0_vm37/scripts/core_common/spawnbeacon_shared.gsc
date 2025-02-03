#using script_4721de209091b1a6;
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
// Checksum 0x2c358f1d, Offset: 0x240
// Size: 0x26c
function init_shared() {
    level.var_9fa5aeb4 = undefined;
    level.var_34c482f2 = undefined;
    level.var_4b1d905b = undefined;
    level.var_ae2fe442 = undefined;
    if (!isdefined(game.spawnbeaconid)) {
        game.spawnbeaconid = 0;
    }
    if (!isdefined(level.spawnbeaconsettings)) {
        level.spawnbeaconsettings = spawnstruct();
    }
    level.spawnbeaconsettings.userspawnbeacons = [];
    level.spawnbeaconsettings.availablespawnlists = [];
    level.spawnbeaconsettings.objectivezones = [];
    level.spawnbeaconsettings.audiothrottletracker = [];
    if (getgametypesetting(#"competitivesettings") === 1) {
        level.spawnbeaconsettings.settingsbundle = getscriptbundle("spawnbeacon_custom_settings_comp");
    } else {
        level.spawnbeaconsettings.settingsbundle = getscriptbundle("default_spawnbeacon_settings");
    }
    level.spawnbeaconsettings.beaconweapon = getweapon(#"gadget_spawnbeacon");
    level.spawnbeaconsettings.var_613ff100 = [];
    level.spawnbeaconsettings.beacons = [];
    level.spawnbeaconsettings.maxpower = 100;
    level.spawnbeaconsettings.var_b851d15e = (0, 0, 5);
    level.spawnbeaconsettings.var_247a8b = 100;
    /#
        level.spawnbeaconsettings.var_e7571ff1 = [];
    #/
    setupcallbacks();
    setupclientfields();
    callback::on_finalize_initialization(&function_1c601b99);
    deployable::register_deployable(getweapon("gadget_spawnbeacon"), &function_9aafb7bb, undefined);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xbc804b6d, Offset: 0x4b8
// Size: 0x40
function function_1c601b99() {
    if (isdefined(level.var_1b900c1d)) {
        [[ level.var_1b900c1d ]](level.spawnbeaconsettings.beaconweapon, &function_bff5c062);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 2, eflags: 0x0
// Checksum 0x9bf42aa4, Offset: 0x500
// Size: 0x54
function function_bff5c062(spawnbeacon, *attackingplayer) {
    attackingplayer.var_d02ddb8e = getweapon(#"gadget_icepick");
    attackingplayer thread destroyspawnbeacon(1);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xe19fec47, Offset: 0x560
// Size: 0x42
function function_ee74520a() {
    if (!isdefined(level.spawnbeaconsettings)) {
        level.spawnbeaconsettings = spawnstruct();
    }
    level.spawnbeaconsettings.var_9d48e929 = 1;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xf8cf2b61, Offset: 0x5b0
// Size: 0x42
function function_7262646d() {
    if (!isdefined(level.spawnbeaconsettings)) {
        level.spawnbeaconsettings = spawnstruct();
    }
    level.spawnbeaconsettings.var_7262646d = 1;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x340276c, Offset: 0x600
// Size: 0x4a
function function_5e54a568(var_b71a2a66) {
    if (!isdefined(level.spawnbeaconsettings)) {
        level.spawnbeaconsettings = spawnstruct();
    }
    level.spawnbeaconsettings.var_3c919ca8 = var_b71a2a66;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x481a096d, Offset: 0x658
// Size: 0xac
function function_6b437265(team) {
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
// Checksum 0xbd6643cb, Offset: 0x710
// Size: 0x62
function function_cfabb62c(watcher) {
    watcher.watchforfire = 1;
    watcher.onspawn = &beacon_spawned;
    watcher.ontimeout = &function_13ac856e;
    watcher.var_994b472b = &function_f9d3fff8;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x7aa81c8c, Offset: 0x780
// Size: 0x3c
function function_f9d3fff8(*player) {
    if (isdefined(self) && isdefined(self.spawnbeacon)) {
        self.spawnbeacon thread destroyspawnbeacon(0);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xc78de063, Offset: 0x7c8
// Size: 0x34
function function_13ac856e() {
    if (isdefined(self) && isdefined(self.spawnbeacon)) {
        self.spawnbeacon thread destroyspawnbeacon(0);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x131536c2, Offset: 0x808
// Size: 0x27c
function function_f8930fa1(time) {
    self endon(#"death", #"end_timer");
    if (time == 0) {
        return;
    }
    if (isdefined(level.spawnbeaconsettings.var_7262646d) ? level.spawnbeaconsettings.var_7262646d : 0) {
        return;
    }
    if (isdefined(level.var_7a0aaea2)) {
        time = level.var_7a0aaea2;
    }
    if (time > (isdefined(level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4) ? level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4 : 0)) {
        wait time - (isdefined(level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4) ? level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4 : 0);
    }
    if (!isdefined(self)) {
        return;
    } else if (isdefined(level.var_a1ca927c)) {
        self [[ level.var_a1ca927c ]]();
    }
    remainingtime = isdefined(level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4) ? level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4 : time > (isdefined(level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4) ? level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4 : 0) ? 0 : time;
    wait remainingtime;
    while (is_true(level.spawnbeaconsettings.var_9d48e929) && isdefined(self) && isdefined(self.owner) && !isalive(self.owner)) {
        wait 0.5;
    }
    if (!isdefined(self)) {
        return;
    }
    self thread destroyspawnbeacon(0);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 2, eflags: 0x0
// Checksum 0xd119ba52, Offset: 0xa90
// Size: 0x284
function beacon_spawned(watcher, owner) {
    self endon(#"death");
    self.canthack = 1;
    self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
    self hide();
    if (is_true(self.previouslyhacked)) {
        return;
    }
    if (isdefined(level.var_14151f16)) {
        [[ level.var_14151f16 ]](self, 0);
    }
    waitframe(1);
    if (!isdefined(owner)) {
        self delete();
        return;
    }
    owner notify(#"hash_31be1f8b27209ad0", {#player:owner, #beacon:self});
    level notify(#"hash_31be1f8b27209ad0", {#player:owner, #beacon:self});
    if (!owner deployable::location_valid()) {
        owner deployable::function_416f03e6(level.spawnbeaconsettings.beaconweapon);
        self delete();
        return;
    }
    if (isdefined(owner)) {
        owner stats::function_e24eec31(self.weapon, #"used", 1);
    }
    self deployable::function_dd266e08(owner);
    self.var_9bab32d9 = owner.var_9bab32d9;
    owner.var_9bab32d9 = undefined;
    owner onplacespawnbeacon(self);
    owner clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 1);
    owner.var_9698a18d = 1;
    spawnbeacon = self.spawnbeacon;
    spawnbeacon setanim(#"o_spawn_beacon_deploy", 1);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 3, eflags: 0x0
// Checksum 0x4b43f7ae, Offset: 0xd20
// Size: 0xf4
function playcommanderaudio(soundbank, team, excludeplayer) {
    if (!isdefined(soundbank)) {
        return;
    }
    if (!isdefined(level.spawnbeaconsettings.audiothrottletracker[soundbank])) {
        level.spawnbeaconsettings.audiothrottletracker[soundbank] = 0;
    }
    lasttimeplayed = level.spawnbeaconsettings.audiothrottletracker[soundbank];
    if (lasttimeplayed != 0 && gettime() < int(5 * 1000) + lasttimeplayed) {
        return;
    }
    namespace_f9b02f80::function_b4319f8e(soundbank, team, excludeplayer, "spawnbeacon");
    level.spawnbeaconsettings.audiothrottletracker[soundbank] = gettime();
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x2763e4ad, Offset: 0xe20
// Size: 0x5c
function setupclientfields() {
    clientfield::register("scriptmover", "spawnbeacon_placed", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.spawnbeacon.active", 1, 1, "int");
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x3495ae60, Offset: 0xe88
// Size: 0x4c
function function_45a43bd6() {
    player = self;
    if (is_true(player.var_9698a18d)) {
        player clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 1);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x4
// Checksum 0x763210d6, Offset: 0xee0
// Size: 0xcc
function private setupcallbacks() {
    ability_player::register_gadget_activation_callbacks(26, &gadget_spawnbeacon_on, &gadget_spawnbeacon_off);
    callback::on_player_killed(&on_player_killed);
    callback::on_spawned(&on_player_spawned);
    callback::on_loadout(&on_loadout);
    weaponobjects::function_e6400478(#"gadget_spawnbeacon", &function_cfabb62c, 1);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x4
// Checksum 0xe7f72fd2, Offset: 0xfb8
// Size: 0x54
function private function_9ede386f(slot) {
    wait 0.1;
    if (!isdefined(self)) {
        return;
    }
    self function_19ed70ca(slot, 1);
    self gadgetpowerset(slot, 0);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xade13dd1, Offset: 0x1018
// Size: 0x154
function function_8892377a() {
    if (!self hasweapon(level.spawnbeaconsettings.beaconweapon)) {
        self clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 0);
        self.var_9698a18d = 0;
        self.var_583f6cce = undefined;
        return;
    }
    if (!isdefined(self.pers[#"hash_677f229433c8735b"])) {
        self.pers[#"hash_677f229433c8735b"] = 0;
    }
    if (getdvarint(#"hash_da55c6d97d1dc52", 1) && (isdefined(level.var_6cd68fbe) ? level.var_6cd68fbe : 0) && self.pers[#"hash_677f229433c8735b"] >= 1) {
        spawnbeaconslot = self gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
        self thread function_9ede386f(spawnbeaconslot);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xfa35a4c2, Offset: 0x1178
// Size: 0x1c
function on_loadout() {
    self function_8892377a();
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x4ce90b96, Offset: 0x11a0
// Size: 0x48
function on_player_spawned() {
    player = self;
    player function_45a43bd6();
    if (isdefined(level.var_9fa5aeb4)) {
        self [[ level.var_9fa5aeb4 ]]();
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xfa8b2e86, Offset: 0x11f0
// Size: 0x196
function function_41a037e6() {
    spawnbeacon = self;
    spawnbeacon.threatlevel = 0;
    foreach (player in level.players) {
        if (player getteam() == spawnbeacon.team) {
            continue;
        }
        foreach (var_25d50c8b in level.spawnbeaconsettings.var_613ff100) {
            distance = distancesquared(spawnbeacon.origin, player.origin);
            if (distance <= var_25d50c8b.zonemax && distance > var_25d50c8b.zonemin) {
                spawnbeacon.threatlevel += var_25d50c8b.points;
            }
        }
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x64cbfc08, Offset: 0x1390
// Size: 0x196
function updatethreat() {
    level endon(#"game_ended");
    spawnbeacon = self;
    spawnbeacon endon(#"beacon_removed");
    while (isdefined(spawnbeacon)) {
        if (isdefined(spawnbeacon.isdisabled) && spawnbeacon.isdisabled) {
            spawnbeacon waittill(#"beacon_enabled");
        }
        spawnbeacon function_41a037e6();
        if (spawnbeacon.threatlevel >= (isdefined(level.spawnbeaconsettings.settingsbundle.var_ba2632d3) ? level.spawnbeaconsettings.settingsbundle.var_ba2632d3 : 0)) {
            objective_setgamemodeflags(spawnbeacon.objectiveid, 2);
        } else if (spawnbeacon.threatlevel >= (isdefined(level.spawnbeaconsettings.settingsbundle.var_332c5109) ? level.spawnbeaconsettings.settingsbundle.var_332c5109 : 0)) {
            objective_setgamemodeflags(spawnbeacon.objectiveid, 1);
        } else {
            objective_setgamemodeflags(spawnbeacon.objectiveid, 0);
        }
        wait 1;
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xd70e94c2, Offset: 0x1530
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
// Checksum 0xdd610247, Offset: 0x15d0
// Size: 0x74
function freespawnbeaconspawnlist(spawnlistname) {
    if (isdefined(spawnlistname)) {
        assert(!array::contains(level.spawnbeaconsettings.availablespawnlists, spawnlistname));
        array::push(level.spawnbeaconsettings.availablespawnlists, spawnlistname);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 2, eflags: 0x0
// Checksum 0x600f8465, Offset: 0x1650
// Size: 0x66
function gadget_spawnbeacon_on(*slot, playerweapon) {
    assert(isplayer(self));
    self notify(#"start_killstreak", {#weapon:playerweapon});
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 2, eflags: 0x0
// Checksum 0x226d9460, Offset: 0x16c0
// Size: 0x1e
function gadget_spawnbeacon_off(*slot, *weapon) {
    self.isbuildingspawnbeacon = 0;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x725672ae, Offset: 0x16e8
// Size: 0xac
function on_player_killed(s_params) {
    if (isdefined(self.spawnbeaconbuildprogressobjid)) {
        deleteobjective(self.spawnbeaconbuildprogressobjid);
        self.spawnbeaconbuildprogressobjid = undefined;
    }
    if (isdefined(self.isbuildingspawnbeacon) && self.isbuildingspawnbeacon && isdefined(s_params.eattacker)) {
        killstreaks::processscoreevent(#"forward_spawn_stopped_activation", s_params.eattacker, undefined, level.spawnbeaconsettings.beaconweapon);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x4f858ca7, Offset: 0x17a0
// Size: 0x12
function getobjectiveid() {
    return gameobjects::get_next_obj_id();
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x4c0cb6fa, Offset: 0x17c0
// Size: 0x44
function deleteobjective(objectiveid) {
    if (isdefined(objectiveid)) {
        objective_delete(objectiveid);
        gameobjects::release_obj_id(objectiveid);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x33168665, Offset: 0x1810
// Size: 0x15a
function calculatecooldownpenalty() {
    spawnbeacon = self;
    player = spawnbeacon.owner;
    if (!isdefined(player)) {
        return;
    }
    if (!player hasweapon(level.spawnbeaconsettings.beaconweapon)) {
        return;
    }
    spawnbeaconslot = player gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
    currentpower = player gadgetpowerget(spawnbeaconslot) / 100;
    penalty = (isdefined(level.spawnbeaconsettings.settingsbundle.var_da5fcc2d) ? level.spawnbeaconsettings.settingsbundle.var_da5fcc2d : 0) - (isdefined(level.spawnbeaconsettings.settingsbundle.var_da5fcc2d) ? level.spawnbeaconsettings.settingsbundle.var_da5fcc2d : 0) * currentpower;
    player.spawnbeaconcooldownpenalty = int(penalty);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x4
// Checksum 0xea1cd91f, Offset: 0x1978
// Size: 0x1bc
function private function_e46fd633() {
    spawnbeacon = self;
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_d2110d43) ? level.spawnbeaconsettings.settingsbundle.var_d2110d43 : 0) {
        spawnbeacon calculatecooldownpenalty();
    }
    var_b80d3663 = isdefined(spawnbeacon.var_d02ddb8e) && spawnbeacon.var_d02ddb8e.name === "gadget_icepick";
    if (isdefined(self.owner) && !var_b80d3663) {
        var_9a5be956 = self.owner;
        self.owner thread namespace_f9b02f80::play_taacom_dialog("spawnBeaconDestroyedFriendly");
    }
    playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_79efc1, util::getotherteam(spawnbeacon.team), spawnbeacon.var_846acfcf);
    if (!var_b80d3663) {
        playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_2ee73347, spawnbeacon.team, var_9a5be956);
        spawnbeacon.owner globallogic_score::function_5829abe3(spawnbeacon.var_846acfcf, spawnbeacon.var_d02ddb8e, level.spawnbeaconsettings.beaconweapon);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0xdea93609, Offset: 0x1b40
// Size: 0x964
function destroyspawnbeacon(destroyedbyenemy) {
    self notify(#"hash_523ddcbd662010e5");
    self function_68a6ec15();
    self.var_ab0875aa = 1;
    spawnbeacon = self;
    attacker = destroyedbyenemy ? self.var_846acfcf : self.owner;
    spawnbeacon dodamage(spawnbeacon.health + 10000, spawnbeacon.origin, attacker, undefined, undefined, "MOD_EXPLOSIVE");
    if (target_istarget(spawnbeacon)) {
        target_remove(spawnbeacon);
    }
    player = self.owner;
    if (isdefined(self.beacondisabled) && self.beacondisabled) {
        return;
    }
    if (game.state == #"playing") {
        if (spawnbeacon.health <= 0) {
            if (isdefined(level.spawnbeaconsettings.settingsbundle.var_b3756378)) {
                spawnbeacon playsound(level.spawnbeaconsettings.settingsbundle.var_b3756378);
            }
        } else if (isdefined(level.spawnbeaconsettings.settingsbundle.var_b4ecfeb2)) {
            spawnbeacon playsound(level.spawnbeaconsettings.settingsbundle.var_b4ecfeb2);
        }
        if (is_true(destroyedbyenemy)) {
            self function_e46fd633();
        } else {
            if (isdefined(self.owner)) {
                var_9a5be956 = self.owner;
                self.owner thread namespace_f9b02f80::play_taacom_dialog("spawnBeaconOfflineFriendly");
            }
            playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_10c9ba2d, self.team, var_9a5be956);
            playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_f29e64de, util::getotherteam(self.team), undefined);
        }
    }
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_35fbc280)) {
        playfx(level.spawnbeaconsettings.settingsbundle.var_35fbc280, spawnbeacon.origin);
    }
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_bb6c29b4) && isdefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle")) {
        playfx(level.spawnbeaconsettings.settingsbundle.var_bb6c29b4, spawnbeacon.origin);
    }
    if ((isdefined(self.var_ca3a0f16) ? self.var_ca3a0f16 : 0) || isdefined(player) && isdefined(player.var_c4a4cb7d) && player hasweapon(getweapon(#"hash_7ab3f9a730359659"), 1)) {
        if (isdefined(self.objectiveid)) {
            gameobjects::release_obj_id(self.objectiveid);
        }
    } else {
        profilestart();
        if (isdefined(level.var_34c482f2)) {
            self [[ level.var_34c482f2 ]](attacker, self.var_d02ddb8e);
        }
        /#
            array::push_front(level.spawnbeaconsettings.var_e7571ff1, self.objectiveid);
        #/
        if (isdefined(self.objectiveid)) {
            deleteobjective(self.objectiveid);
            level.spawnbeaconsettings.beacons[self.objectiveid] = undefined;
        }
        self.beacondisabled = 1;
        freespawnbeaconspawnlist(self.spawnlist);
        profilestop();
    }
    self clientfield::set("enemyequip", 0);
    if (isdefined(self.var_d7cf6658)) {
        foreach (gameobject in self.var_d7cf6658) {
            gameobject gameobjects::destroy_object(1, 1);
        }
    }
    if (isdefined(self.owner)) {
        var_c2ca0930 = getarraykeys(level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid]);
        foreach (var_2f55edb in var_c2ca0930) {
            if (level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid][var_2f55edb] == self) {
                indextoremove = var_2f55edb;
            }
        }
    }
    if (isdefined(indextoremove)) {
        level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid] = array::remove_index(level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid], indextoremove, 0);
    }
    self stoploopsound();
    self notify(#"beacon_removed");
    self callback::remove_callback(#"on_end_game", &function_438ca4e0);
    if (isdefined(player)) {
        player notify(#"beacon_removed");
        player clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 0);
        player.var_9698a18d = 0;
        player.var_583f6cce = undefined;
    }
    if (isdefined(self.var_2d045452)) {
        self.var_2d045452 delete();
    }
    deployable::function_81598103(self);
    var_b0e81be9 = self gettagorigin("tag_base_d0");
    if (!isdefined(var_b0e81be9)) {
        var_b0e81be9 = self.origin;
    }
    var_505e3308 = self gettagangles("tag_base_d0");
    if (!isdefined(var_505e3308)) {
        var_505e3308 = self.angles;
    }
    var_8fec56c4 = anglestoforward(var_505e3308);
    var_61753233 = anglestoup(var_505e3308);
    playfx(#"hash_695b2e7e4b63a645", var_b0e81be9, var_8fec56c4, var_61753233);
    if (!(isdefined(spawnbeacon.var_4fc7245b) ? spawnbeacon.var_4fc7245b : 0) && (isdefined(level.var_6cd68fbe) ? level.var_6cd68fbe : 0) && isdefined(player)) {
        player.pers[#"lives"]--;
    }
    self delete();
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x6c432967, Offset: 0x24b0
// Size: 0x1e
function getspawnbeaconspawns(*origin) {
    spawnstoadd = [];
    return spawnstoadd;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 2, eflags: 0x0
// Checksum 0xaff431ee, Offset: 0x24d8
// Size: 0x19e
function createspawngroupforspawnbeacon(associatedspawnbeacon, spawnstoadd) {
    assert(isdefined(spawnstoadd));
    assert(isdefined(associatedspawnbeacon));
    if (spawnstoadd.size == 0) {
        return false;
    }
    team = associatedspawnbeacon.team;
    enemyteam = util::getotherteam(team);
    var_5b29525a = level.teambased && isdefined(game.switchedsides) && game.switchedsides && level.spawnsystem.var_3709dc53;
    associatedspawnbeacon.spawnlist = getnewspawnbeaconspawnlist();
    assert(isdefined(associatedspawnbeacon.spawnlist));
    if (level.teambased) {
        if (var_5b29525a) {
            enemyteam = team;
            team = enemyteam;
        }
        assert(isdefined(team));
        addspawnpoints(team, spawnstoadd, associatedspawnbeacon.spawnlist);
        addspawnpoints(enemyteam, spawnstoadd, associatedspawnbeacon.spawnlist);
    }
    associatedspawnbeacon.spawns = spawnstoadd;
    return true;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x4d36d7a4, Offset: 0x2680
// Size: 0x1e8
function function_425d8006() {
    spawnbeacon = self;
    spawnbeacon endon(#"beacon_removed");
    level endon(#"game_ended");
    spawnbeacon.isdisabled = 1;
    spawnbeacon notify(#"beacon_disabled");
    objective_setgamemodeflags(spawnbeacon.objectiveid, 3);
    var_d7760961 = isdefined(level.spawnbeaconsettings.settingsbundle.var_26f4f5f0) ? level.spawnbeaconsettings.settingsbundle.var_26f4f5f0 : 0;
    var_f1c32a14 = "";
    if (spawnbeacon.team == #"allies") {
        var_f1c32a14 = "A";
    } else {
        var_f1c32a14 = "B";
    }
    playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_1068819a, spawnbeacon.team, undefined);
    playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_c5d0582b, util::getotherteam(spawnbeacon.team), undefined);
    setbombtimer(var_f1c32a14, gettime() + int(var_d7760961 * 1000));
    wait var_d7760961;
    spawnbeacon.isdisabled = 0;
    spawnbeacon notify(#"beacon_enabled");
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0xbf9251d, Offset: 0x2870
// Size: 0x134
function watchfordeath() {
    level endon(#"game_ended");
    self.owner endon(#"disconnect", #"joined_team", #"changed_specialist");
    self endon(#"hash_523ddcbd662010e5");
    waitresult = self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    var_b08a3652 = 1;
    self.var_846acfcf = waitresult.attacker;
    self.var_d02ddb8e = waitresult.weapon;
    if (isdefined(waitresult.attacker) && isdefined(self) && isdefined(self.owner) && waitresult.attacker.team == self.owner.team) {
        var_b08a3652 = 0;
    }
    self thread destroyspawnbeacon(var_b08a3652);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x748fbf24, Offset: 0x29b0
// Size: 0x168
function watchfordamage() {
    self endon(#"death");
    level endon(#"game_ended");
    self endon(#"hash_523ddcbd662010e5");
    spawnbeacon = self;
    spawnbeacon endon(#"death");
    spawnbeacon.health = level.spawnbeaconsettings.settingsbundle.health;
    if (isdefined(level.var_b8701e49)) {
        spawnbeacon.health = level.var_b8701e49;
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
// Checksum 0xb34f2915, Offset: 0x2b20
// Size: 0x102
function function_40c032a1(*einflictor, attacker, idamage, idflags, smeansofdeath, weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *iboneindex, *imodelindex) {
    bundle = level.spawnbeaconsettings.settingsbundle;
    chargelevel = 0;
    weapon_damage = killstreak_bundles::function_dd7587e4(bundle, bundle.health, vdir, imodelindex, iboneindex, shitloc, psoffsettime, chargelevel);
    if (!isdefined(weapon_damage)) {
        weapon_damage = killstreaks::get_old_damage(vdir, imodelindex, iboneindex, shitloc, 1);
    }
    return int(weapon_damage);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x35904873, Offset: 0x2c30
// Size: 0x34
function function_438ca4e0() {
    spawnbeacon = self;
    spawnbeacon.var_648955e6 = 1;
    spawnbeacon function_68a6ec15();
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x76c75615, Offset: 0x2c70
// Size: 0x38
function function_9c87725b() {
    currentid = game.spawnbeaconid;
    game.spawnbeaconid += 1;
    return currentid;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x94ad0aac, Offset: 0x2cb0
// Size: 0x4c
function function_639cb9da() {
    self endon(#"death");
    self waittill(#"game_ended");
    if (!isdefined(self)) {
        return;
    }
    self destroyspawnbeacon(0);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x9c5e2975, Offset: 0x2d08
// Size: 0xcc
function function_b3608e1(spawnbeacon) {
    spawnbeacon.objectiveid = getobjectiveid();
    objective_add(spawnbeacon.objectiveid, "active", spawnbeacon.origin, level.spawnbeaconsettings.settingsbundle.mainobjective);
    objective_setteam(spawnbeacon.objectiveid, spawnbeacon.team);
    function_29ef32ee(spawnbeacon.objectiveid, spawnbeacon.owner.team);
    objective_setprogress(spawnbeacon.objectiveid, 1);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 2, eflags: 0x0
// Checksum 0x5d18074a, Offset: 0x2de0
// Size: 0x840
function retreatedstartmelee(var_a820f9, spawns) {
    player = self;
    if (isdefined(level.spawnbeaconsettings.userspawnbeacons[player.clientid]) && level.spawnbeaconsettings.userspawnbeacons[player.clientid].size >= (isdefined(level.spawnbeaconsettings.settingsbundle.var_e3d3bd15) ? level.spawnbeaconsettings.settingsbundle.var_e3d3bd15 : 1)) {
        beacontoremove = level.spawnbeaconsettings.userspawnbeacons[player.clientid][0];
        if (isdefined(beacontoremove)) {
            beacontoremove thread destroyspawnbeacon(0);
        } else {
            level.spawnbeaconsettings.userspawnbeacons[self.clientid] = undefined;
        }
    }
    slot = player gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
    player gadgetpowerreset(slot);
    player gadgetpowerset(slot, 0);
    spawnbeaconslot = player gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
    player function_69b5c53c(spawnbeaconslot, 0);
    placedspawnbeacon = spawn("script_model", var_a820f9.origin);
    placedspawnbeacon setmodel(level.spawnbeaconsettings.beaconweapon.worldmodel);
    var_a820f9.spawnbeacon = placedspawnbeacon;
    placedspawnbeacon.var_2d045452 = var_a820f9;
    placedspawnbeacon function_41b29ff0(#"hash_77200d1bb519ba08");
    placedspawnbeacon useanimtree("generic");
    target_set(placedspawnbeacon, (0, 0, 32));
    placedspawnbeacon.owner = player;
    placedspawnbeacon clientfield::set("spawnbeacon_placed", 1);
    placedspawnbeacon setteam(player getteam());
    placedspawnbeacon.var_86a21346 = &function_40c032a1;
    placedspawnbeacon solid();
    placedspawnbeacon show();
    placedspawnbeacon.victimsoundmod = "vehicle";
    if (isdefined(level.var_6cd68fbe) ? level.var_6cd68fbe : 0) {
        player.pers[#"lives"]++;
    }
    placedspawnbeacon setweapon(level.spawnbeaconsettings.beaconweapon);
    placedspawnbeacon.weapon = level.spawnbeaconsettings.beaconweapon;
    function_b3608e1(placedspawnbeacon);
    createspawngroupforspawnbeacon(placedspawnbeacon, spawns);
    level.spawnbeaconsettings.beacons[placedspawnbeacon.objectiveid] = placedspawnbeacon;
    if (!isdefined(level.spawnbeaconsettings.userspawnbeacons[player.clientid])) {
        level.spawnbeaconsettings.userspawnbeacons[player.clientid] = [];
    }
    var_a7edcaed = level.spawnbeaconsettings.userspawnbeacons.size + 1;
    array::push(level.spawnbeaconsettings.userspawnbeacons[player.clientid], placedspawnbeacon, var_a7edcaed);
    if (isdefined(level.spawnbeaconsettings.settingsbundle.canbedamaged) ? level.spawnbeaconsettings.settingsbundle.canbedamaged : 0) {
        placedspawnbeacon setcandamage(1);
    }
    placedspawnbeacon clientfield::set("enemyequip", 1);
    placedspawnbeacon.builttime = gettime();
    placedspawnbeacon.threatlevel = 0;
    placedspawnbeacon.spawncount = 0;
    placedspawnbeacon.uniqueid = function_9c87725b();
    playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_69b1ff7, player getteam(), player);
    playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_4f37dfe9, util::getotherteam(player getteam()), undefined);
    if (isdefined(level.spawnbeaconsettings.settingsbundle.var_a0db3d4d)) {
        placedspawnbeacon playloopsound(level.spawnbeaconsettings.settingsbundle.var_a0db3d4d);
    }
    if (isdefined(level.var_4b1d905b)) {
        self [[ level.var_4b1d905b ]](placedspawnbeacon);
    }
    placedspawnbeacon thread updatethreat();
    placedspawnbeacon thread watchfordamage();
    placedspawnbeacon thread watchfordeath();
    placedspawnbeacon thread function_f8930fa1(isdefined(level.spawnbeaconsettings.settingsbundle.timeout) ? level.spawnbeaconsettings.settingsbundle.timeout : 0);
    placedspawnbeacon thread function_639cb9da();
    placedspawnbeacon callback::function_d8abfc3d(#"on_end_game", &function_438ca4e0);
    player deployable::function_6ec9ee30(placedspawnbeacon, level.spawnbeaconsettings.beaconweapon);
    if (!isdefined(player.pers[#"hash_677f229433c8735b"])) {
        player.pers[#"hash_677f229433c8735b"] = 0;
    }
    player.pers[#"hash_677f229433c8735b"]++;
    if (getdvarint(#"hash_da55c6d97d1dc52", 1) && (isdefined(level.var_6cd68fbe) ? level.var_6cd68fbe : 0)) {
        player function_19ed70ca(slot, 1);
    }
    player.var_583f6cce = placedspawnbeacon;
    player notify(#"beacon_added");
}

/#

    // Namespace spawn_beacon/spawnbeacon_shared
    // Params 2, eflags: 0x0
    // Checksum 0x564c6c19, Offset: 0x3628
    // Size: 0x34
    function function_264da546(*var_cd3712d2, *jammer) {
        println("<dev string:x38>");
    }

#/

// Namespace spawn_beacon/spawnbeacon_shared
// Params 3, eflags: 0x0
// Checksum 0x6c9d7627, Offset: 0x3668
// Size: 0x80
function function_9aafb7bb(origin, angles, player) {
    if (!isdefined(player.var_9bab32d9)) {
        player.var_9bab32d9 = spawnstruct();
    }
    player.var_9bab32d9.spawns = [];
    if (isdefined(level.var_ae2fe442)) {
        return [[ level.var_ae2fe442 ]](origin, angles, player);
    }
    return 1;
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x35af7183, Offset: 0x36f0
// Size: 0xa4
function onplacespawnbeacon(spawnbeacon) {
    spawnbeacon setvisibletoall();
    if (isdefined(spawnbeacon.othermodel)) {
        spawnbeacon.othermodel setinvisibletoall();
    }
    if (isdefined(spawnbeacon.var_9bab32d9) && isdefined(spawnbeacon.var_9bab32d9.spawns)) {
        self retreatedstartmelee(spawnbeacon, spawnbeacon.var_9bab32d9.spawns);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0xd52c0b3d, Offset: 0x37a0
// Size: 0x8c
function oncancelplacement(*spawnbeacon) {
    spawnbeaconslot = self gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
    self gadgetdeactivate(spawnbeaconslot, level.spawnbeaconsettings.beaconweapon, 0);
    self gadgetpowerset(spawnbeaconslot, 100);
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 1, eflags: 0x0
// Checksum 0x48722821, Offset: 0x3838
// Size: 0x84
function function_d82c03d4(player) {
    spawnbeacon = self;
    player endon(#"disconnect");
    spawnbeacon endon(#"death");
    player waittill(#"joined_team");
    if (isdefined(spawnbeacon)) {
        spawnbeacon thread destroyspawnbeacon(0);
    }
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x1c817e5e, Offset: 0x38c8
// Size: 0x5c
function function_e9fea0ea() {
    player = self;
    if (!isdefined(level.spawnbeaconsettings) || !isdefined(level.spawnbeaconsettings.userspawnbeacons)) {
        return undefined;
    }
    return level.spawnbeaconsettings.userspawnbeacons[player.clientid];
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3930
// Size: 0x4
function function_68a6ec15() {
    
}

// Namespace spawn_beacon/spawnbeacon_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3940
// Size: 0x4
function function_d32596e5() {
    
}

