#using script_1cc417743d7c262d;
#using script_7f6cd71c43c45c57;
#using scripts\abilities\ability_player;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\draft;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;

#namespace supplypod;

// Namespace supplypod/supplypod
// Params 0, eflags: 0x6
// Checksum 0xcc47ac7, Offset: 0x2d0
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"supplypod", &function_70a657d8, undefined, &finalize, #"killstreaks");
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x5 linked
// Checksum 0x5dc24c55, Offset: 0x330
// Size: 0x1bc
function private function_70a657d8() {
    if (!isdefined(game.var_6ccfdacd)) {
        game.var_6ccfdacd = 0;
    }
    level.var_934fb97 = spawnstruct();
    level.var_934fb97.var_27fce4c0 = [];
    level.var_934fb97.var_d741a6a4 = [];
    level.var_934fb97.bundle = getscriptbundle("killstreak_supplypod");
    level.var_934fb97.weapon = getweapon("gadget_supplypod");
    level.var_934fb97.var_ff101fac = getweapon(#"supplypod_catch");
    level.var_dc8edcba = &function_827486aa;
    level.var_49ef5263 = &function_49ef5263;
    level.hintobjectivehint_updat = &hintobjectivehint_updat;
    setupcallbacks();
    setupclientfields();
    deployable::register_deployable(level.var_934fb97.weapon, &function_1f8cd247);
    globallogic_score::register_kill_callback(getweapon(#"gadget_supplypod"), &function_92856c6);
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0xcf20871f, Offset: 0x4f8
// Size: 0x40
function finalize() {
    if (isdefined(level.var_1b900c1d)) {
        [[ level.var_1b900c1d ]](level.var_934fb97.weapon, &function_bff5c062);
    }
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x0
// Checksum 0x732972b0, Offset: 0x540
// Size: 0xb4
function function_127fb8f3(supplypod, *attackingplayer) {
    attackingplayer.gameobject gameobjects::allow_use(#"hash_161f03feaadc9b8f");
    if (isdefined(level.var_86e3d17a)) {
        _station_up_to_detention_center_triggers = [[ level.var_86e3d17a ]]();
        if ((isdefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) > 0) {
            attackingplayer notify(#"cancel_timeout");
            attackingplayer thread weaponobjects::weapon_object_timeout(attackingplayer.var_2d045452, _station_up_to_detention_center_triggers);
        }
    }
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x1 linked
// Checksum 0x491b127c, Offset: 0x600
// Size: 0x40c
function function_bff5c062(supplypod, attackingplayer) {
    if (!isdefined(supplypod.gameobject)) {
        return;
    }
    original_owner = supplypod.owner;
    supplypod.owner weaponobjects::hackerremoveweapon(supplypod);
    supplypod.owner function_890b2784();
    supplypod.owner = attackingplayer;
    supplypod setowner(attackingplayer);
    supplypod setteam(attackingplayer getteam());
    supplypod.team = attackingplayer getteam();
    supplypod.gameobject gameobjects::set_owner_team(attackingplayer.team);
    supplypod.gameobject gameobjects::set_visible(#"hash_150a20fa4efc5c7a");
    supplypod.gameobject gameobjects::allow_use(#"hash_150a20fa4efc5c7a");
    supplypod notify(#"hash_523ddcbd662010e5");
    supplypod notify(#"hacked");
    if (isdefined(supplypod.var_2d045452)) {
        supplypod.var_2d045452 notify(#"hacked");
    }
    supplypod thread watchfordamage();
    supplypod thread watchfordeath();
    var_a87deb22 = 1;
    if (!level.teambased) {
        supplypod.gameobject.trigger setteamfortrigger(supplypod.team);
    }
    if (isdefined(level.var_f1edf93f) && isdefined(supplypod.var_2d045452)) {
        _station_up_to_detention_center_triggers = [[ level.var_f1edf93f ]]();
        if (isdefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) {
            supplypod.var_2d045452 notify(#"cancel_timeout");
            if (isdefined(original_owner)) {
                watcher = original_owner weaponobjects::getweaponobjectwatcherbyweapon(supplypod.var_2d045452.weapon);
                if (isdefined(watcher)) {
                    supplypod.var_2d045452 thread weaponobjects::function_6d8aa6a0(attackingplayer, watcher);
                    supplypod.var_2d045452 thread weaponobjects::weapon_object_timeout(watcher, _station_up_to_detention_center_triggers);
                    var_a87deb22 = 0;
                }
            }
        }
    }
    if (isdefined(level.var_fc1bbaef)) {
        [[ level.var_fc1bbaef ]](supplypod);
    }
    level.var_934fb97.supplypods[supplypod.objectiveid] = supplypod;
    if (!isdefined(level.var_934fb97.var_27fce4c0[attackingplayer.clientid])) {
        level.var_934fb97.var_27fce4c0[attackingplayer.clientid] = [];
    }
    var_a7edcaed = level.var_934fb97.var_27fce4c0.size + 1;
    array::push(level.var_934fb97.var_27fce4c0[attackingplayer.clientid], supplypod, var_a7edcaed);
    if (var_a87deb22) {
        supplypod thread function_827486aa(0);
    }
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x1 linked
// Checksum 0x165a975d, Offset: 0xa18
// Size: 0x1c8
function function_29de6f1f(weapon, meansofdeath = undefined) {
    baseweapon = weapons::getbaseweapon(weapon);
    var_62c1bfaa = weapon.inventorytype == "ability" && weapon.offhandslot == "Special";
    islethalgrenade = weapon.inventorytype == "offhand" && weapon.offhandslot == "Lethal grenade";
    istacticalgrenade = weapon.inventorytype == "offhand" && weapon.offhandslot == "Tactical grenade";
    iskillstreak = isdefined(killstreaks::get_from_weapon(weapon));
    ismelee = isdefined(meansofdeath) && (meansofdeath == #"mod_melee" || meansofdeath == #"mod_melee_weapon_butt");
    var_4ea2a976 = weapon.name == "launcher_standard_t9" || weapon.name == "sig_buckler_dw";
    if (var_62c1bfaa || islethalgrenade || istacticalgrenade || iskillstreak || ismelee || var_4ea2a976) {
        return false;
    }
    return true;
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0xd0632e7, Offset: 0xbe8
// Size: 0x28
function function_49ef5263() {
    if (self function_e8e1d88e() > 0) {
        return true;
    }
    return false;
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x1 linked
// Checksum 0xbbb71f5e, Offset: 0xc18
// Size: 0x15c
function hintobjectivehint_updat(weapon) {
    if (!isdefined(self) || !isplayer(self) || !self function_49ef5263() || !isdefined(weapon) || weapon.name != "launcher_standard_t8") {
        return;
    }
    scoreevents::processscoreevent(#"golden_kill_bonus", self, undefined, level.var_934fb97.weapon);
    if (isdefined(self.var_bfeea3dd) && isalive(self.var_bfeea3dd) && self != self.var_bfeea3dd && self.team == self.var_bfeea3dd.team) {
        scoreevents::processscoreevent(#"hash_131b23d720fc82c3", self.var_bfeea3dd, undefined, level.var_934fb97.weapon);
    }
    self playlocalsound(#"hash_6c2a2fee191330a0");
}

// Namespace supplypod/supplypod
// Params 5, eflags: 0x1 linked
// Checksum 0x290db87f, Offset: 0xd80
// Size: 0x14c
function function_92856c6(attacker, *victim, weapon, attackerweapon, meansofdeath) {
    if (!isdefined(victim) || !isdefined(weapon) || !isdefined(meansofdeath)) {
        return false;
    }
    if (!function_29de6f1f(attackerweapon, meansofdeath)) {
        return false;
    }
    if (victim function_49ef5263()) {
        if (isdefined(victim.var_bfeea3dd) && isalive(victim.var_bfeea3dd) && victim != victim.var_bfeea3dd && victim.team == victim.var_bfeea3dd.team) {
            scoreevents::processscoreevent(#"hash_131b23d720fc82c3", victim.var_bfeea3dd, undefined, level.var_934fb97.weapon);
        }
        victim playlocalsound(#"hash_6c2a2fee191330a0");
        return true;
    }
    return false;
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x1 linked
// Checksum 0xf019d917, Offset: 0xed8
// Size: 0xaa
function function_f579e72b(watcher) {
    watcher.watchforfire = 1;
    watcher.onspawn = &supplypod_spawned;
    watcher.timeout = float(level.var_934fb97.bundle.ksduration) / 1000;
    watcher.ontimeout = &function_7c0d095c;
    watcher.var_994b472b = &function_f7d9ebce;
    watcher.var_10efd558 = "switched_field_upgrade";
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x1 linked
// Checksum 0xdf2e517a, Offset: 0xf90
// Size: 0x4c
function function_f7d9ebce(*player) {
    if (!isdefined(self.supplypod)) {
        return;
    }
    self.supplypod.var_8d834202 = 1;
    self.supplypod thread function_827486aa(0);
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0x90f00b5d, Offset: 0xfe8
// Size: 0x2c
function function_7c0d095c() {
    if (!isdefined(self.supplypod)) {
        return;
    }
    self.supplypod thread function_827486aa(0);
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x1 linked
// Checksum 0x7b7055f1, Offset: 0x1020
// Size: 0x1d6
function supplypod_spawned(watcher, owner) {
    self endon(#"death");
    self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
    self hide();
    self.canthack = 1;
    self.ignoreemp = 1;
    self.delete_on_death = 1;
    if (!is_true(self.previouslyhacked)) {
        if (isdefined(owner)) {
            owner stats::function_e24eec31(self.weapon, #"used", 1);
            owner notify(#"supplypod");
        }
        self waittilltimeout(0.05, #"stationary");
        if (!owner deployable::function_f8fe102f()) {
            owner setriotshieldfailhint();
            self deletedelay();
            return;
        }
        self deployable::function_dd266e08(owner);
        self.var_3823265d = owner.var_3823265d;
        owner.var_3823265d = undefined;
        owner function_63c23d02(watcher, self);
        supplypod = self.supplypod;
        supplypod util::make_sentient();
        supplypod.var_48d842c3 = 1;
        supplypod.var_515d6dda = 1;
    }
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0x1bd8f744, Offset: 0x1200
// Size: 0x84
function playdeathfx() {
    if (isdefined(level.var_934fb97.bundle.ksexplosionfx)) {
        playfx(level.var_934fb97.bundle.ksexplosionfx, self.origin);
        self playsound(level.var_934fb97.bundle.var_b3756378);
    }
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0xfcbe0abd, Offset: 0x1290
// Size: 0x64
function function_263be969() {
    if (isdefined(level._equipment_fizzleout_fx)) {
        playfx(level._equipment_fizzleout_fx, self.origin);
        self playsound(level.var_934fb97.bundle.var_b3756378);
    }
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x1 linked
// Checksum 0x2000dca4, Offset: 0x1300
// Size: 0xcc
function function_d7cd849c(var_cb0f3959, *team) {
    if (!isdefined(team)) {
        return;
    }
    if (!isdefined(level.var_934fb97.var_d741a6a4[team])) {
        level.var_934fb97.var_d741a6a4[team] = 0;
    }
    var_ad7969ca = level.var_934fb97.var_d741a6a4[team];
    if (var_ad7969ca != 0 && gettime() < int(5 * 1000) + var_ad7969ca) {
        return;
    }
    level.var_934fb97.var_d741a6a4[team] = gettime();
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0x2a0acba1, Offset: 0x13d8
// Size: 0x34
function setupclientfields() {
    clientfield::register("scriptmover", "supplypod_placed", 1, 1, "int");
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x5 linked
// Checksum 0xc8056366, Offset: 0x1418
// Size: 0x8c
function private setupcallbacks() {
    ability_player::register_gadget_activation_callbacks(35, &supplypod_on, &supplypod_off);
    callback::on_spawned(&on_player_spawned);
    weaponobjects::function_e6400478(#"gadget_supplypod", &function_f579e72b, 1);
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0x47004b64, Offset: 0x14b0
// Size: 0x1c4
function on_player_spawned() {
    player = self;
    player.var_2383a10c = [];
    self function_46d74bb7(0);
    changedteam = isdefined(player.var_29fdd9dd) && player.team != player.var_29fdd9dd;
    if ((isdefined(player.var_228b6835) ? player.var_228b6835 : 0) || changedteam || (isdefined(level.var_934fb97.bundle.var_18ede0bb) ? level.var_934fb97.bundle.var_18ede0bb : 0)) {
        player.var_17d74a5c = undefined;
        player.var_29fdd9dd = undefined;
        player.var_48107b1c = undefined;
        player function_a0814839(0);
    }
    if (isdefined(player.var_17d74a5c)) {
        if (isdefined(player.var_57de9100)) {
            player.var_57de9100.trigger setinvisibletoplayer(player);
        }
        player thread function_18f999b5(float(player.var_17d74a5c) / 1000);
        player.var_17d74a5c += gettime();
        player function_3ea286();
    }
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x1 linked
// Checksum 0x671f4ac3, Offset: 0x1680
// Size: 0x294
function function_46d74bb7(var_70150641) {
    if (isdefined(var_70150641) ? var_70150641 : 0) {
        players = getplayers(self.team);
    } else {
        players = getplayers();
    }
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        assert(isdefined(player.clientid));
        if (!isdefined(player.clientid)) {
            continue;
        }
        pods = level.var_934fb97.var_27fce4c0[player.clientid];
        if (isdefined(pods)) {
            foreach (pod in pods) {
                if (!isdefined(pod)) {
                    continue;
                }
                if (isdefined(pod.gameobject)) {
                    gameobject = pod.gameobject;
                    if (!(isdefined(level.var_934fb97.bundle.var_82fccdb8) ? level.var_934fb97.bundle.var_82fccdb8 : 0) && isdefined(self.var_2383a10c[gameobject.entnum]) && self.var_2383a10c[gameobject.entnum] >= level.var_934fb97.bundle.var_186e07b5) {
                        continue;
                    }
                    pod.gameobject.trigger setvisibletoplayer(self);
                }
            }
        }
    }
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x1 linked
// Checksum 0x8402c34b, Offset: 0x1920
// Size: 0x66
function supplypod_on(*slot, playerweapon) {
    assert(isplayer(self));
    self notify(#"start_killstreak", {#weapon:playerweapon});
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x1 linked
// Checksum 0x49d1feef, Offset: 0x1990
// Size: 0x14
function supplypod_off(*slot, *weapon) {
    
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0x9f10954, Offset: 0x19b0
// Size: 0x12
function getobjectiveid() {
    return gameobjects::get_next_obj_id();
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x1 linked
// Checksum 0x424a9888, Offset: 0x19d0
// Size: 0x44
function deleteobjective(objectiveid) {
    if (isdefined(objectiveid)) {
        objective_delete(objectiveid);
        gameobjects::release_obj_id(objectiveid);
    }
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0x13d79f88, Offset: 0x1a20
// Size: 0xcc
function function_890b2784() {
    indextoremove = undefined;
    for (index = 0; index < level.var_934fb97.var_27fce4c0[self.clientid].size; index++) {
        if (level.var_934fb97.var_27fce4c0[self.clientid][index] == self) {
            indextoremove = index;
        }
    }
    if (isdefined(indextoremove)) {
        level.var_934fb97.var_27fce4c0[self.clientid] = array::remove_index(level.var_934fb97.var_27fce4c0[self.clientid], indextoremove, 0);
    }
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x1 linked
// Checksum 0x49261f89, Offset: 0x1af8
// Size: 0x206
function function_827486aa(var_d3213f00, var_7497ba51 = 1) {
    self notify(#"hash_523ddcbd662010e5");
    self.var_ab0875aa = 1;
    if (isdefined(self.var_83d9bfb5) && self.var_83d9bfb5) {
        return;
    }
    deleteobjective(self.objectiveid);
    deleteobjective(self.var_134eefb9);
    self.var_83d9bfb5 = 1;
    level.var_934fb97.supplypods[self.objectiveid] = undefined;
    self clientfield::set("enemyequip", 0);
    if (isdefined(self.gameobject)) {
        self.gameobject thread gameobjects::destroy_object(1, 1);
    }
    self function_890b2784();
    if (isdefined(self.owner)) {
        if (game.state == "playing") {
            if (is_true(var_d3213f00)) {
                self.owner globallogic_score::function_5829abe3(self.var_846acfcf, self.var_d02ddb8e, level.var_934fb97.weapon);
            }
        }
    }
    if (var_7497ba51 && !var_d3213f00) {
        wait (isdefined(level.var_934fb97.bundle.var_fd663ee0) ? level.var_934fb97.bundle.var_fd663ee0 : 0) / 1000;
    }
    profilestart();
    function_9d4aabb9(var_d3213f00);
    profilestop();
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x1 linked
// Checksum 0x5a9a8bf0, Offset: 0x1d08
// Size: 0x3bc
function function_9d4aabb9(var_d3213f00) {
    if (!isdefined(self)) {
        return;
    }
    player = self.owner;
    if (isdefined(self.var_846acfcf) && isdefined(player) && self.var_846acfcf != player) {
        self battlechatter::function_d2600afc(self.var_846acfcf, player, level.var_934fb97.weapon, self.var_d02ddb8e);
    }
    if (game.state == "playing") {
        if (self.health <= 0) {
            if (isdefined(level.var_934fb97.bundle.var_b3756378)) {
                self playsound(level.var_934fb97.bundle.var_b3756378);
            }
        }
        if (is_true(var_d3213f00)) {
            if (isdefined(player)) {
                var_f3ab6571 = self.owner weaponobjects::function_8481fc06(level.var_934fb97.weapon) > 1;
                self.owner thread globallogic_audio::function_6daffa93(level.var_934fb97.weapon, var_f3ab6571);
            }
            function_d7cd849c(level.var_934fb97.bundle.var_2ee73347, self.team);
            function_d7cd849c(level.var_934fb97.bundle.var_79efc1, util::getotherteam(self.team));
        } else {
            function_d7cd849c(level.var_934fb97.bundle.var_10c9ba2d, self.team);
            function_d7cd849c(level.var_934fb97.bundle.var_f29e64de, util::getotherteam(self.team));
        }
    }
    if (self.var_8d834202 === 1) {
        function_263be969();
    } else {
        playdeathfx();
    }
    if (isdefined(level.var_934fb97.bundle.var_bb6c29b4) && isdefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle")) {
        playfx(level.var_934fb97.bundle.var_bb6c29b4, self.origin);
    }
    deployable::function_81598103(self);
    if (isdefined(self.var_2d045452)) {
        self.var_2d045452 delete();
    }
    self stoploopsound();
    self notify(#"supplypod_removed");
    self deletedelay();
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x5 linked
// Checksum 0xcfa644d2, Offset: 0x20d0
// Size: 0x158
function private function_5761966a(supplypod) {
    player = self;
    player endon(#"disconnect");
    level endon(#"game_ended");
    supplypod endon(#"supplypod_removed");
    if (!isdefined(supplypod.var_7b7607df[player.clientid])) {
        return;
    }
    objective_setvisibletoplayer(supplypod.var_134eefb9, player);
    while (isdefined(supplypod.var_7b7607df[player.clientid]) && supplypod.var_7b7607df[player.clientid] > gettime()) {
        timeremaining = float(supplypod.var_7b7607df[player.clientid] - gettime()) / 1000;
        if (timeremaining > 0) {
            wait timeremaining;
        }
    }
    objective_setinvisibletoplayer(supplypod.var_134eefb9, player);
    supplypod.var_7b7607df[player.clientid] = undefined;
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x5 linked
// Checksum 0x69f593fc, Offset: 0x2230
// Size: 0x44
function private function_3c4843e3(supplypod, timetoadd) {
    supplypod.var_7b7607df[self.clientid] = gettime() + int(timetoadd * 1000);
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0xb6a687aa, Offset: 0x2280
// Size: 0x15c
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
    } else {
        killstreaks::function_e729ccee(waitresult.attacker, waitresult.weapon);
    }
    self thread function_827486aa(var_b08a3652);
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0xde1fec99, Offset: 0x23e8
// Size: 0x288
function watchfordamage() {
    self endon(#"death");
    level endon(#"game_ended");
    self endon(#"hash_523ddcbd662010e5");
    supplypod = self;
    supplypod endon(#"death");
    supplypod.health = level.var_934fb97.bundle.kshealth;
    startinghealth = supplypod.health;
    while (true) {
        waitresult = self waittill(#"damage");
        if ((isdefined(level.var_934fb97.bundle.var_4f845dc4) ? level.var_934fb97.bundle.var_4f845dc4 : 0) && isdefined(waitresult.attacker) && isplayer(waitresult.attacker)) {
            var_fd03ecd9 = supplypod.health / startinghealth;
            objective_setprogress(supplypod.var_134eefb9, var_fd03ecd9);
            var_adb78fe4 = isdefined(supplypod.var_7b7607df[waitresult.attacker.clientid]);
            waitresult.attacker function_3c4843e3(supplypod, level.var_934fb97.bundle.var_c14832cd);
            if (!var_adb78fe4) {
                waitresult.attacker thread function_5761966a(supplypod);
            }
        }
        if (isdefined(waitresult.attacker) && waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker)) {
            waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
        }
    }
}

// Namespace supplypod/supplypod
// Params 12, eflags: 0x1 linked
// Checksum 0x732f59d4, Offset: 0x2678
// Size: 0x102
function function_8d362deb(*einflictor, attacker, idamage, idflags, smeansofdeath, weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *iboneindex, *imodelindex) {
    bundle = level.var_934fb97.bundle;
    chargelevel = 0;
    weapon_damage = killstreak_bundles::get_weapon_damage("killstreak_supplypod", bundle.kshealth, vdir, imodelindex, iboneindex, shitloc, psoffsettime, chargelevel);
    if (!isdefined(weapon_damage)) {
        weapon_damage = killstreaks::get_old_damage(vdir, imodelindex, iboneindex, shitloc, 1);
    }
    return int(weapon_damage);
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0xdf8f7cf0, Offset: 0x2788
// Size: 0x92
function function_438ca4e0() {
    supplypod = self;
    supplypod endon(#"supplypod_removed", #"death");
    level waittill(#"game_ended");
    if (!isdefined(self)) {
        return;
    }
    supplypod.var_8d834202 = 1;
    self thread function_827486aa(0, 0);
    supplypod.var_648955e6 = 1;
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0x76fe7af6, Offset: 0x2828
// Size: 0x38
function function_fec0924() {
    currentid = game.var_6ccfdacd;
    game.var_6ccfdacd += 1;
    return currentid;
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x1 linked
// Checksum 0x55c535b4, Offset: 0x2868
// Size: 0x9f4
function function_9abdee8c(*watcher, object) {
    player = self;
    if (isdefined(level.var_934fb97.var_27fce4c0[player.clientid]) && level.var_934fb97.var_27fce4c0[player.clientid].size >= (isdefined(level.var_934fb97.bundle.var_cbe1e532) ? level.var_934fb97.bundle.var_cbe1e532 : 1)) {
        obj = level.var_934fb97.var_27fce4c0[player.clientid][0];
        if (isdefined(obj)) {
            obj.var_8d834202 = 1;
            obj thread function_827486aa(0);
        } else {
            level.var_934fb97.var_27fce4c0[self.clientid] = undefined;
        }
    }
    slot = player gadgetgetslot(level.var_934fb97.weapon);
    player gadgetpowerreset(slot);
    player gadgetpowerset(slot, 0);
    supplypod = spawn("script_model", object.origin);
    supplypod setmodel(level.var_934fb97.weapon.var_22082a57);
    object.supplypod = supplypod;
    supplypod.var_2d045452 = object;
    supplypod function_41b29ff0("wpn_t9_eqp_supply_pod_destructible");
    supplypod useanimtree("generic");
    supplypod.owner = player;
    supplypod.clientid = supplypod.owner.clientid;
    supplypod.angles = player.angles;
    supplypod clientfield::set("supplypod_placed", 1);
    supplypod setteam(player getteam());
    supplypod.var_86a21346 = &function_8d362deb;
    supplypod solid();
    supplypod show();
    supplypod.victimsoundmod = "vehicle";
    supplypod.weapon = level.var_934fb97.weapon;
    supplypod setweapon(supplypod.weapon);
    supplypod.var_57022ab8 = isdefined(level.var_934fb97.bundle.var_5a0d87e0) ? level.var_934fb97.bundle.var_5a0d87e0 : 20;
    supplypod.usecount = 0;
    supplypod.objectiveid = getobjectiveid();
    level.var_934fb97.supplypods[supplypod.objectiveid] = supplypod;
    if (!isdefined(level.var_934fb97.var_27fce4c0[player.clientid])) {
        level.var_934fb97.var_27fce4c0[player.clientid] = [];
    }
    var_a7edcaed = level.var_934fb97.var_27fce4c0.size + 1;
    array::push(level.var_934fb97.var_27fce4c0[player.clientid], supplypod, var_a7edcaed);
    supplypod setcandamage(1);
    supplypod clientfield::set("enemyequip", 1);
    supplypod.var_99d2556b = gettime();
    supplypod.uniqueid = function_fec0924();
    function_d7cd849c(level.var_934fb97.bundle.var_69b1ff7, player getteam());
    function_d7cd849c(level.var_934fb97.bundle.var_4f37dfe9, util::getotherteam(player getteam()));
    if (isdefined(level.var_934fb97.bundle.var_a0db3d4d)) {
        supplypod playloopsound(level.var_934fb97.bundle.var_a0db3d4d);
    }
    if (isdefined(level.var_934fb97.bundle.var_4f845dc4) ? level.var_934fb97.bundle.var_4f845dc4 : 0) {
        supplypod.var_134eefb9 = getobjectiveid();
        supplypod.var_7b7607df = [];
        objective_add(supplypod.var_134eefb9, "active", supplypod.origin, level.var_934fb97.bundle.var_ce75f65c);
        objective_setprogress(supplypod.var_134eefb9, 1);
        objective_setinvisibletoall(supplypod.var_134eefb9);
    }
    triggerradius = level.var_934fb97.bundle.var_366f43e9;
    triggerheight = level.var_934fb97.bundle.var_2f1567fb;
    var_b1a6d849 = level.var_934fb97.bundle.var_2d890f85;
    upangle = vectorscale(vectornormalize(anglestoup(supplypod.angles)), 5);
    var_40989bda = supplypod.origin + upangle;
    usetrigger = spawn("trigger_radius_use", var_40989bda, 0, triggerradius, triggerheight);
    usetrigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    usetrigger function_49462027(1, 1 | 4096 | 2 | 2097152 | 2048);
    supplypod.gameobject = gameobjects::create_use_object(#"any", usetrigger, [], undefined, level.var_934fb97.bundle.var_9333131b, 1, 1);
    supplypod.gameobject gameobjects::set_visible(#"hash_5ccfd7bbbf07c770");
    supplypod.gameobject gameobjects::allow_use(#"hash_5ccfd7bbbf07c770");
    supplypod.gameobject gameobjects::set_use_time(var_b1a6d849);
    supplypod.gameobject.onbeginuse = &function_8c8fb7b5;
    supplypod.gameobject.onenduse = &function_a1434496;
    supplypod.gameobject.canuseobject = &canuseobject;
    supplypod.gameobject.var_5ecd70 = supplypod;
    supplypod.gameobject.var_33d50507 = 1;
    supplypod.gameobject.dontlinkplayertotrigger = 1;
    supplypod.gameobject.keepweapon = 1;
    supplypod.gameobject.requireslos = 1;
    supplypod.gameobject.var_d647eb08 = 1;
    player deployable::function_6ec9ee30(supplypod, level.var_934fb97.weapon);
    supplypod.gameobject function_1446053f(player);
    supplypod thread function_438ca4e0();
    supplypod thread watchfordamage();
    supplypod thread watchfordeath();
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x1 linked
// Checksum 0x7baca103, Offset: 0x3268
// Size: 0xac
function function_1446053f(player) {
    self endon(#"death");
    player endon(#"death");
    wait 0.2;
    while (player isusingoffhand()) {
        waitframe(1);
    }
    if (isdefined(self) && isdefined(player) && self canuseobject(player)) {
        self function_a1434496(undefined, player, 1);
    }
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x5 linked
// Checksum 0x50b8e2ce, Offset: 0x3320
// Size: 0xc
function private function_8c8fb7b5(*player) {
    
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x5 linked
// Checksum 0x57877a25, Offset: 0x3338
// Size: 0x14
function private function_a143899c(*player, *waittime) {
    
}

// Namespace supplypod/supplypod
// Params 3, eflags: 0x5 linked
// Checksum 0x47695a9b, Offset: 0x3358
// Size: 0x3f4
function private function_a1434496(*team, player, result) {
    supplypod = self.var_5ecd70;
    if (!isdefined(supplypod)) {
        return;
    }
    supplypod.isdisabled = 0;
    if (is_true(result)) {
        supplypod.usecount++;
        if (!isdefined(player.var_2383a10c[self.entnum])) {
            player.var_2383a10c[self.entnum] = 0;
        }
        player.var_2383a10c[self.entnum]++;
        if (isdefined(player) && isplayer(player)) {
            if (supplypod.owner != player && supplypod.owner.team == player.team) {
                scoreevents::processscoreevent(#"hash_69dbfbd660f8c53e", supplypod.owner, undefined, level.var_934fb97.weapon);
            }
            supplypod.owner battlechatter::function_fc82b10(level.var_934fb97.weapon, self.origin, self);
        }
        thread function_a143899c(player, 1.5);
        player thread gestures::function_f3e2696f(supplypod, level.var_934fb97.var_ff101fac, undefined, 0.5);
        player function_bcf0dd99();
        if (!(isdefined(level.var_934fb97.bundle.var_82fccdb8) ? level.var_934fb97.bundle.var_82fccdb8 : 0) && player.var_2383a10c[self.entnum] >= level.var_934fb97.bundle.var_186e07b5) {
            self.trigger setinvisibletoplayer(player);
        }
        player.var_57de9100 = self;
        player.var_29fdd9dd = self.team;
        player.var_bfeea3dd = supplypod.owner;
        player notify(#"hash_69dbfbd660f8c53e");
        if (!(isdefined(level.var_934fb97.bundle.var_18ede0bb) ? level.var_934fb97.bundle.var_18ede0bb : 0)) {
            self.trigger setinvisibletoplayer(player);
            duration = isdefined(level.var_934fb97.bundle.var_84471829) ? level.var_934fb97.bundle.var_84471829 : 30;
            player.var_17d74a5c = gettime() + int(duration * 1000);
            player thread function_18f999b5(duration);
        } else {
            player.var_48107b1c = 1;
        }
        if (supplypod.usecount == supplypod.var_57022ab8) {
            supplypod.var_8d834202 = 1;
            supplypod thread function_827486aa(0);
        }
        return;
    }
    thread function_a143899c(player, 0);
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x1 linked
// Checksum 0xf683c5da, Offset: 0x3758
// Size: 0x142
function canuseobject(user) {
    primary_weapons = user getweaponslistprimaries();
    foreach (weapon in primary_weapons) {
        if (user getfractionmaxammo(weapon) < 1) {
            return true;
        }
    }
    var_25f23a32 = isdefined(getgametypesetting(#"hash_1c0040943c216593")) ? getgametypesetting(#"hash_1c0040943c216593") : 0;
    if (user function_e8e1d88e() < var_25f23a32) {
        return true;
    }
    return false;
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x1 linked
// Checksum 0x3d9356a2, Offset: 0x38a8
// Size: 0x12c
function function_18f999b5(waittime) {
    self notify(#"hash_10cd6a20d4e45365");
    self endon(#"hash_10cd6a20d4e45365", #"disconnect");
    result = self waittilltimeout(waittime, #"death");
    if (result._notify == #"timeout") {
        self function_46d74bb7(1);
    } else if (isdefined(level.var_934fb97.bundle.var_98da26d) ? level.var_934fb97.bundle.var_98da26d : 0) {
        self.var_17d74a5c -= gettime();
    } else {
        self.var_17d74a5c = undefined;
        self.var_bfeea3dd = undefined;
    }
    self function_a0814839(0);
}

// Namespace supplypod/supplypod
// Params 3, eflags: 0x1 linked
// Checksum 0x8e93dee8, Offset: 0x39e0
// Size: 0x228
function function_1f8cd247(origin, *angles, player) {
    if (!isdefined(player.var_3823265d)) {
        player.var_3823265d = spawnstruct();
    }
    var_1898acdc = isdefined(level.var_934fb97.bundle.var_bdc8276) ? level.var_934fb97.bundle.var_bdc8276 : 0;
    testdistance = var_1898acdc * var_1898acdc;
    ids = getarraykeys(level.var_934fb97.var_27fce4c0);
    foreach (id in ids) {
        if (id == player.clientid) {
            continue;
        }
        pods = level.var_934fb97.var_27fce4c0[id];
        foreach (pod in pods) {
            if (!isdefined(pod)) {
                continue;
            }
            distsqr = distancesquared(angles, pod.origin);
            if (distsqr <= testdistance) {
                return false;
            }
        }
    }
    return true;
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x1 linked
// Checksum 0xc01dd0f9, Offset: 0x3c10
// Size: 0xde
function function_63c23d02(watcher, supplypod) {
    supplypod setvisibletoall();
    if (isdefined(supplypod.othermodel)) {
        supplypod.othermodel setinvisibletoall();
    }
    if (isdefined(supplypod.var_3823265d)) {
        self function_9abdee8c(watcher, supplypod);
        playsoundatposition(#"hash_66e85d590b4f4b8", supplypod.origin);
    }
    if (isdefined(level.var_84bf013e)) {
        self notify(#"supplypod_placed", {#pod:supplypod});
    }
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0x484ad910, Offset: 0x3cf8
// Size: 0x8c
function oncancelplacement(*supplypod) {
    slot = self gadgetgetslot(level.var_934fb97.weapon);
    self gadgetdeactivate(slot, level.var_934fb97.weapon, 0);
    self gadgetpowerset(slot, 100);
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x1 linked
// Checksum 0x6cecd1a6, Offset: 0x3d90
// Size: 0xb4
function function_452147b1(weapon, weaponindex) {
    player = self;
    level endon(#"game_ended");
    player notify("on_death_ammon_backup" + weaponindex);
    player endon("on_death_ammon_backup" + weaponindex, #"disconnect");
    player waittill(#"death");
    player.pers["pod_ammo" + weaponindex] = player getweaponammostock(weapon);
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x1 linked
// Checksum 0x24ba6472, Offset: 0x3e50
// Size: 0x196
function function_5bc9564e(weapon) {
    player = self;
    level endon(#"game_ended");
    player notify(#"hash_620e9c8ce0a79cf7");
    player endon(#"hash_620e9c8ce0a79cf7", #"disconnect");
    while (isdefined(player.pod_ammo) && player.pod_ammo.size > 0) {
        weapon = player getcurrentweapon();
        var_2f9ea2b9 = weapons::getbaseweapon(weapon);
        baseweaponindex = getbaseweaponitemindex(var_2f9ea2b9);
        if (is_true(player.pod_ammo[baseweaponindex])) {
            curammo = player getweaponammostock(weapon);
            if (curammo == 0) {
                player setweaponammostock(weapon, int(player.pod_ammo[baseweaponindex]));
                player.pod_ammo[baseweaponindex] = undefined;
                player thread function_452147b1(weapon, baseweaponindex);
            }
        }
        waitframe(1);
    }
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0x30639929, Offset: 0x3ff0
// Size: 0x154
function function_740ec27e() {
    player = self;
    primary_weapons = player getweaponslistprimaries();
    foreach (weapon in primary_weapons) {
        var_2f9ea2b9 = weapons::getbaseweapon(weapon);
        baseweaponindex = getbaseweaponitemindex(var_2f9ea2b9);
        player.pod_ammo[baseweaponindex] = (isdefined(getgametypesetting(#"hash_1441f7ad44e1cfd4")) ? getgametypesetting(#"hash_1441f7ad44e1cfd4") : 0) * weapon.clipsize;
    }
    player thread function_5bc9564e();
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x1 linked
// Checksum 0xb0e7e3f8, Offset: 0x4150
// Size: 0x15c
function function_bcf0dd99() {
    player = self;
    primary_weapons = player getweaponslistprimaries();
    foreach (weapon in primary_weapons) {
        curammo = player getweaponammostock(weapon);
        bonusammo = (isdefined(getgametypesetting(#"hash_1441f7ad44e1cfd4")) ? getgametypesetting(#"hash_1441f7ad44e1cfd4") : 0) * weapon.clipsize;
        player setweaponammostock(weapon, int(curammo + bonusammo));
    }
    player function_3ea286();
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0x23638d28, Offset: 0x42b8
// Size: 0x18c
function function_b8a25634(owner) {
    player = self;
    cooldowns[0] = level.var_934fb97.bundle.var_b9443d6b;
    cooldowns[1] = level.var_934fb97.bundle.var_ea340924;
    cooldowns[2] = level.var_934fb97.bundle.var_ff3d4d40;
    for (slot = 0; slot < 3; slot++) {
        if (!isdefined(cooldowns[slot])) {
            continue;
        }
        if (!isdefined(player._gadgets_player[slot])) {
            continue;
        }
        cooldown = cooldowns[slot] * (isdefined(player._gadgets_player[slot].var_e4d4fa7e) ? player._gadgets_player[slot].var_e4d4fa7e : 0);
        if (is_true(owner)) {
            cooldown *= isdefined(level.var_934fb97.bundle.var_44a195ff) ? level.var_934fb97.bundle.var_44a195ff : 0;
        }
        player gadgetpowerchange(slot, cooldown);
    }
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0xad439a55, Offset: 0x4450
// Size: 0x204
function function_de737a35() {
    player = self;
    for (weapon = player getcurrentweapon(); weapon == level.weaponnone; weapon = player getcurrentweapon()) {
        waitframe(1);
    }
    slot = player gadgetgetslot(weapon);
    if (slot == 2 || weapon == getweapon(#"sig_buckler_turret")) {
        if (isdefined(weapon.var_7a93ed37)) {
            player gadgetpowerchange(slot, weapon.var_7a93ed37);
        }
        if (isdefined(weapon.var_60563796)) {
            if (weapon == getweapon(#"sig_buckler_turret") || weapon == getweapon(#"sig_buckler_dw")) {
                stockammo = player getweaponammoclip(weapon);
                player setweaponammoclip(weapon, stockammo + int(weapon.var_60563796));
                return;
            }
            stockammo = player getweaponammostock(weapon);
            player setweaponammostock(weapon, stockammo + int(weapon.var_60563796));
        }
    }
}

