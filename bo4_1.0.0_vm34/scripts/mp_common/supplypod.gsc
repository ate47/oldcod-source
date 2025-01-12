#using scripts\abilities\ability_player;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\draft;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;

#namespace supplypod;

// Namespace supplypod/supplypod
// Params 0, eflags: 0x2
// Checksum 0x23066e1, Offset: 0x2e0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"supplypod", &__init__, undefined, #"killstreaks");
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0xaaedf5a3, Offset: 0x330
// Size: 0x1bc
function __init__() {
    if (!isdefined(game.var_c954b47e)) {
        game.var_c954b47e = 0;
    }
    level.var_a7a737ae = spawnstruct();
    level.var_a7a737ae.var_20d0150d = [];
    level.var_a7a737ae.var_cfc1135f = [];
    level.var_a7a737ae.bundle = getscriptbundle("killstreak_supplypod");
    level.var_a7a737ae.weapon = getweapon("gadget_supplypod");
    level.var_a7a737ae.var_422ca8ee = getweapon(#"supplypod_catch");
    if (!isdefined(level.killstreakbundle)) {
        level.killstreakbundle = [];
    }
    level.killstreakbundle[#"killstreak_supplypod"] = level.var_a7a737ae.bundle;
    setupcallbacks();
    setupclientfields();
    deployable::register_deployable(level.var_a7a737ae.weapon, &function_4387fa50);
    globallogic_score::register_kill_callback(getweapon(#"gadget_supplypod"), &function_6868eb4a);
}

// Namespace supplypod/supplypod
// Params 5, eflags: 0x0
// Checksum 0x20353054, Offset: 0x4f8
// Size: 0x2c4
function function_6868eb4a(attacker, victim, weapon, attackerweapon, meansofdeath) {
    if (!isdefined(attacker) || !isdefined(weapon) || !isdefined(meansofdeath)) {
        return false;
    }
    baseweapon = weapons::getbaseweapon(attackerweapon);
    var_4a20e931 = isdefined(baseweapon.issignatureweapon) && baseweapon.issignatureweapon || isdefined(baseweapon.var_ee15463f) && baseweapon.var_ee15463f;
    iskillstreak = isdefined(level.iskillstreakweapon) && [[ level.iskillstreakweapon ]](attackerweapon);
    iskillstreak = isdefined(level.iskillstreakweapon) && isdefined(attackerweapon.statname) && (iskillstreak ? iskillstreak : [[ level.iskillstreakweapon ]](getweapon(attackerweapon.statname)));
    ismelee = meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_WEAPON_BUTT";
    var_7ce83186 = attackerweapon.name == "launcher_standard_t8" || attackerweapon.name == "sig_buckler_dw";
    if (var_4a20e931 || iskillstreak || var_7ce83186 || ismelee) {
        return false;
    }
    if (isdefined(attacker.var_2d83397d) && attacker.var_2d83397d || isdefined(attacker.var_1be066c6) && attacker.var_1be066c6 > gettime()) {
        if (isdefined(attacker.var_72f2c26) && isalive(attacker.var_72f2c26) && attacker != attacker.var_72f2c26) {
            scoreevents::processscoreevent(#"hash_131b23d720fc82c3", attacker.var_72f2c26, undefined, level.var_a7a737ae.weapon);
        }
        attacker playlocalsound(#"hash_6c2a2fee191330a0");
        return true;
    }
    return false;
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0xa9a8fdf4, Offset: 0x7c8
// Size: 0xb2
function function_869f5fd3(watcher) {
    watcher.watchforfire = 1;
    watcher.onspawn = &supplypod_spawned;
    watcher.timeout = float(level.var_a7a737ae.bundle.ksduration) / 1000;
    watcher.ontimeout = &function_2be735a1;
    watcher.var_46869d39 = &function_c9d78a9;
    watcher.deleteonplayerspawn = 0;
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0x7825491, Offset: 0x888
// Size: 0x34
function function_c9d78a9(player) {
    if (!isdefined(self.supplypod)) {
        return;
    }
    self.supplypod thread function_2e234595(0);
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0xe8f0af2f, Offset: 0x8c8
// Size: 0x2c
function function_2be735a1() {
    if (!isdefined(self.supplypod)) {
        return;
    }
    self.supplypod thread function_2e234595(0);
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x0
// Checksum 0x4515d9ff, Offset: 0x900
// Size: 0x1cc
function supplypod_spawned(watcher, owner) {
    self endon(#"death");
    self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
    self hide();
    if (!(isdefined(self.previouslyhacked) && self.previouslyhacked)) {
        if (isdefined(owner)) {
            owner stats::function_4f10b697(self.weapon, #"used", 1);
            owner notify(#"supplypod");
        }
        self waittilltimeout(0.05, #"stationary");
        if (!owner deployable::location_valid()) {
            owner setriotshieldfailhint();
            self delete();
            return;
        }
        self deployable::function_c334d8f9(owner);
        self.var_85023070 = owner.var_85023070;
        owner.var_85023070 = undefined;
        owner function_6f24a373(self);
        supplypod = self.supplypod;
        supplypod util::make_sentient();
        if (supplypod oob::istouchinganyoobtrigger()) {
            supplypod thread function_2e234595(0, 0);
        }
    }
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x0
// Checksum 0x5a3fbc41, Offset: 0xad8
// Size: 0xce
function function_a6b3743(soundbank, team) {
    if (!isdefined(soundbank)) {
        return;
    }
    if (!isdefined(level.var_a7a737ae.var_cfc1135f[soundbank])) {
        level.var_a7a737ae.var_cfc1135f[soundbank] = 0;
    }
    var_832d4d43 = level.var_a7a737ae.var_cfc1135f[soundbank];
    if (var_832d4d43 != 0 && gettime() < int(5 * 1000) + var_832d4d43) {
        return;
    }
    level.var_a7a737ae.var_cfc1135f[soundbank] = gettime();
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0x11d6ad44, Offset: 0xbb0
// Size: 0x64
function setupclientfields() {
    clientfield::register("scriptmover", "supplypod_placed", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.goldenBullet", 1, 1, "int");
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x4
// Checksum 0xc9fd8d5d, Offset: 0xc20
// Size: 0xac
function private setupcallbacks() {
    ability_player::register_gadget_activation_callbacks(35, &supplypod_on, &supplypod_off);
    callback::on_player_killed_with_params(&on_player_killed);
    callback::on_spawned(&on_player_spawned);
    weaponobjects::function_f298eae6(#"gadget_supplypod", &function_869f5fd3, 1);
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0x8f34aced, Offset: 0xcd8
// Size: 0x4c
function function_38c7844d() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    waitresult = self waittill(#"loadout_given");
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0x6491d443, Offset: 0xd30
// Size: 0x23c
function on_player_spawned() {
    player = self;
    if (level.inprematchperiod && draft::is_draft_this_round()) {
        player thread function_38c7844d();
    }
    self function_994cc651(0);
    changedteam = isdefined(player.var_93245782) && player.team != player.var_93245782;
    if ((isdefined(player.var_a825d3c2) ? player.var_a825d3c2 : 0) || changedteam || (isdefined(level.var_a7a737ae.bundle.var_f32f43dd) ? level.var_a7a737ae.bundle.var_f32f43dd : 0)) {
        player.var_1be066c6 = undefined;
        player.var_e4be405a = undefined;
        player.var_93245782 = undefined;
        player.var_2d83397d = undefined;
        player clientfield::set_player_uimodel("hudItems.goldenBullet", 0);
    }
    if (isdefined(player.var_1be066c6)) {
        if (isdefined(player.var_e4be405a)) {
            player.var_e4be405a gameobjects::hide_waypoint(player);
            player.var_e4be405a.trigger setinvisibletoplayer(player);
        }
        player thread function_5fbdb1bd(float(player.var_1be066c6) / 1000);
        player.var_1be066c6 += gettime();
        player clientfield::set_player_uimodel("hudItems.goldenBullet", 1);
    }
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0x281208, Offset: 0xf78
// Size: 0x25c
function function_994cc651(var_348ba22c) {
    if (isdefined(var_348ba22c) ? var_348ba22c : 0) {
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
        pods = level.var_a7a737ae.var_20d0150d[player.clientid];
        if (isdefined(pods)) {
            foreach (pod in pods) {
                if (isdefined(pod.gameobject)) {
                    var_91bc46fd = pod getteam();
                    if (var_91bc46fd == self.team) {
                        pod.gameobject gameobjects::show_waypoint(self);
                        pod.gameobject.trigger setvisibletoplayer(self);
                        continue;
                    }
                    pod.gameobject gameobjects::hide_waypoint(self);
                    pod.gameobject.trigger setinvisibletoplayer(self);
                }
            }
        }
    }
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x0
// Checksum 0xd77fda7a, Offset: 0x11e0
// Size: 0x66
function supplypod_on(slot, playerweapon) {
    assert(isplayer(self));
    self notify(#"start_killstreak", {#weapon:playerweapon});
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x0
// Checksum 0x7831b7d2, Offset: 0x1250
// Size: 0x14
function supplypod_off(slot, weapon) {
    
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0x482f3081, Offset: 0x1270
// Size: 0xc
function on_player_killed(s_params) {
    
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0x646372e9, Offset: 0x1288
// Size: 0x12
function getobjectiveid() {
    return gameobjects::get_next_obj_id();
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0xc63b07e8, Offset: 0x12a8
// Size: 0x44
function deleteobjective(objectiveid) {
    if (isdefined(objectiveid)) {
        objective_delete(objectiveid);
        gameobjects::release_obj_id(objectiveid);
    }
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x0
// Checksum 0x72e76edf, Offset: 0x12f8
// Size: 0x2b6
function function_2e234595(var_757a988f, var_1eaa86e1 = 1) {
    self notify(#"hash_523ddcbd662010e5");
    self.var_7bee2c23 = 1;
    if (isdefined(self.var_3d4a6d75) && self.var_3d4a6d75) {
        return;
    }
    deleteobjective(self.objectiveid);
    deleteobjective(self.var_f91c18c3);
    self.var_3d4a6d75 = 1;
    level.var_a7a737ae.supplypods[self.objectiveid] = undefined;
    self clientfield::set("enemyequip", 0);
    if (isdefined(self.gameobject)) {
        self.gameobject thread gameobjects::destroy_object(1, 1);
    }
    indextoremove = undefined;
    for (index = 0; index < level.var_a7a737ae.var_20d0150d[self.clientid].size; index++) {
        if (level.var_a7a737ae.var_20d0150d[self.clientid][index] == self) {
            indextoremove = index;
        }
    }
    if (isdefined(indextoremove)) {
        level.var_a7a737ae.var_20d0150d[self.clientid] = array::remove_index(level.var_a7a737ae.var_20d0150d[self.clientid], indextoremove, 0);
    }
    if (isdefined(self.owner)) {
        if (game.state == "playing") {
            if (isdefined(var_757a988f) && var_757a988f) {
                self.owner globallogic_score::function_a63adb85(self.var_bdebe64e, self.var_d29261ce, level.var_a7a737ae.weapon);
            }
        }
    }
    if (var_1eaa86e1 && !var_757a988f) {
        wait (isdefined(level.var_a7a737ae.bundle.var_e46380a1) ? level.var_a7a737ae.bundle.var_e46380a1 : 0) / 1000;
    }
    profilestart();
    function_cdb5de18(var_757a988f);
    profilestop();
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0x5f266d04, Offset: 0x15b8
// Size: 0x374
function function_cdb5de18(var_757a988f) {
    if (!isdefined(self)) {
        return;
    }
    player = self.owner;
    if (isdefined(level.var_b31e16d4) && isdefined(self.var_bdebe64e) && isdefined(player) && self.var_bdebe64e != player) {
        self [[ level.var_b31e16d4 ]](self.var_bdebe64e, player, level.var_a7a737ae.weapon, self.var_d29261ce);
    }
    if (game.state == "playing") {
        if (self.health <= 0) {
            if (isdefined(level.var_a7a737ae.bundle.var_5be3e16b)) {
                self playsound(level.var_a7a737ae.bundle.var_5be3e16b);
            }
        }
        if (isdefined(var_757a988f) && var_757a988f) {
            if (isdefined(player)) {
                if (level.var_a7a737ae.var_20d0150d[player.clientid].size > 1) {
                    player thread globallogic_audio::play_taacom_dialog("supplyPodWeaponDestroyedFriendlyMultiple");
                } else {
                    player thread globallogic_audio::play_taacom_dialog("supplyPodWeaponDestroyedFriendly");
                }
            }
            function_a6b3743(level.var_a7a737ae.bundle.var_1ca489a3, self.team);
            function_a6b3743(level.var_a7a737ae.bundle.var_ae0dc5f6, util::getotherteam(self.team));
        } else {
            function_a6b3743(level.var_a7a737ae.bundle.var_2d7cb8da, self.team);
            function_a6b3743(level.var_a7a737ae.bundle.var_4e1372fb, util::getotherteam(self.team));
        }
    }
    if (isdefined(level.var_a7a737ae.bundle.ksexplosionfx)) {
        playfx(level.var_a7a737ae.bundle.ksexplosionfx, self.origin);
        self playsound(level.var_a7a737ae.bundle.var_5be3e16b);
    }
    deployable::function_2cefe05a(self);
    if (isdefined(self.var_d37785ca)) {
        self.var_d37785ca delete();
    }
    self stoploopsound();
    self notify(#"supplypod_removed");
    self delete();
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x4
// Checksum 0x9e207a98, Offset: 0x1938
// Size: 0x174
function private function_3a246c4b(supplypod) {
    player = self;
    player endon(#"disconnect");
    level endon(#"game_ended");
    supplypod endon(#"supplypod_removed");
    if (!isdefined(supplypod.var_bb0a4eae[player.clientid])) {
        return;
    }
    objective_setvisibletoplayer(supplypod.var_f91c18c3, player);
    while (isdefined(supplypod.var_bb0a4eae[player.clientid]) && supplypod.var_bb0a4eae[player.clientid] > gettime()) {
        timeremaining = float(supplypod.var_bb0a4eae[player.clientid] - gettime()) / 1000;
        if (timeremaining > 0) {
            wait timeremaining;
        }
    }
    objective_setinvisibletoplayer(supplypod.var_f91c18c3, player);
    supplypod.var_bb0a4eae[player.clientid] = undefined;
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x4
// Checksum 0x29dfef00, Offset: 0x1ab8
// Size: 0x4a
function private function_8ce9322a(supplypod, timetoadd) {
    supplypod.var_bb0a4eae[self.clientid] = gettime() + int(timetoadd * 1000);
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0xe2c6087a, Offset: 0x1b10
// Size: 0xa4
function function_3b9cb8d9(player) {
    level endon(#"game_ended");
    self endon(#"hash_523ddcbd662010e5");
    waitresult = player waittill(#"disconnect", #"joined_team", #"changed_specialist");
    if (!isdefined(self)) {
        return;
    }
    var_f57edff2 = 0;
    self thread function_2e234595(var_f57edff2);
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0x4099e1e7, Offset: 0x1bc0
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
    self thread function_2e234595(var_f57edff2);
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0xfaf2f091, Offset: 0x1d08
// Size: 0x298
function watchfordamage() {
    self endon(#"death");
    level endon(#"game_ended");
    self endon(#"hash_523ddcbd662010e5");
    supplypod = self;
    supplypod endon(#"death");
    supplypod.health = level.var_a7a737ae.bundle.kshealth;
    startinghealth = supplypod.health;
    while (true) {
        waitresult = self waittill(#"damage");
        if ((isdefined(level.var_a7a737ae.bundle.var_87454d2f) ? level.var_a7a737ae.bundle.var_87454d2f : 0) && isdefined(waitresult.attacker) && isplayer(waitresult.attacker)) {
            var_9afd284c = supplypod.health / startinghealth;
            objective_setprogress(supplypod.var_f91c18c3, var_9afd284c);
            var_385b07f0 = isdefined(supplypod.var_bb0a4eae[waitresult.attacker.clientid]);
            waitresult.attacker function_8ce9322a(supplypod, level.var_a7a737ae.bundle.var_689a7f25);
            if (!var_385b07f0) {
                waitresult.attacker thread function_3a246c4b(supplypod);
            }
        }
        if (isdefined(waitresult.attacker) && waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker)) {
            waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
        }
    }
}

// Namespace supplypod/supplypod
// Params 12, eflags: 0x0
// Checksum 0xd9cf9400, Offset: 0x1fa8
// Size: 0x11a
function function_e3d312fb(einflictor, attacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex) {
    bundle = level.var_a7a737ae.bundle;
    chargelevel = 0;
    weapon_damage = killstreak_bundles::get_weapon_damage("killstreak_supplypod", bundle.kshealth, attacker, weapon, smeansofdeath, idamage, idflags, chargelevel);
    if (!isdefined(weapon_damage)) {
        weapon_damage = killstreaks::get_old_damage(attacker, weapon, smeansofdeath, idamage, 1);
    }
    return int(weapon_damage);
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0xb35b6337, Offset: 0x20d0
// Size: 0x82
function function_92d9c4be() {
    supplypod = self;
    supplypod endon(#"supplypod_removed", #"death");
    level waittill(#"game_ended");
    if (!isdefined(self)) {
        return;
    }
    self thread function_2e234595(0, 0);
    supplypod.var_c7ef0038 = 1;
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0x10ee1e42, Offset: 0x2160
// Size: 0x36
function function_a07bae59() {
    currentid = game.var_c954b47e;
    game.var_c954b47e += 1;
    return currentid;
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0x98ea61b4, Offset: 0x21a0
// Size: 0xa34
function function_800afe5(object) {
    player = self;
    if (isdefined(level.var_a7a737ae.var_20d0150d[player.clientid]) && level.var_a7a737ae.var_20d0150d[player.clientid].size >= (isdefined(level.var_a7a737ae.bundle.var_d802db24) ? level.var_a7a737ae.bundle.var_d802db24 : 1)) {
        obj = level.var_a7a737ae.var_20d0150d[player.clientid][0];
        if (isdefined(obj)) {
            obj thread function_2e234595(0);
        } else {
            level.var_a7a737ae.var_20d0150d[self.clientid] = undefined;
        }
    }
    slot = player gadgetgetslot(level.var_a7a737ae.weapon);
    player gadgetpowerreset(slot);
    player gadgetpowerset(slot, 0);
    supplypod = spawn("script_model", object.origin);
    supplypod setmodel(level.var_a7a737ae.weapon.var_bb65ee6b);
    object.supplypod = supplypod;
    supplypod.var_d37785ca = object;
    supplypod useanimtree("generic");
    supplypod.owner = player;
    supplypod.clientid = supplypod.owner.clientid;
    supplypod.angles = player.angles;
    supplypod clientfield::set("supplypod_placed", 1);
    supplypod setteam(player getteam());
    supplypod.var_6b0336c0 = &function_e3d312fb;
    supplypod solid();
    supplypod show();
    supplypod.weapon = level.var_a7a737ae.weapon;
    supplypod.maxusecount = isdefined(level.var_a7a737ae.bundle.var_ca7373f6) ? level.var_a7a737ae.bundle.var_ca7373f6 : 20;
    supplypod.usecount = 0;
    supplypod.objectiveid = getobjectiveid();
    level.var_a7a737ae.supplypods[supplypod.objectiveid] = supplypod;
    if (!isdefined(level.var_a7a737ae.var_20d0150d[player.clientid])) {
        level.var_a7a737ae.var_20d0150d[player.clientid] = [];
    }
    var_d8817fe = level.var_a7a737ae.var_20d0150d.size + 1;
    array::push(level.var_a7a737ae.var_20d0150d[player.clientid], supplypod, var_d8817fe);
    supplypod setcandamage(1);
    supplypod clientfield::set("enemyequip", 1);
    supplypod.var_2fd0d55c = gettime();
    supplypod.uniqueid = function_a07bae59();
    function_a6b3743(level.var_a7a737ae.bundle.var_531ebf8a, player getteam());
    function_a6b3743(level.var_a7a737ae.bundle.var_29a9aee1, util::getotherteam(player getteam()));
    if (isdefined(level.var_a7a737ae.bundle.var_6558c1e7)) {
        supplypod playloopsound(level.var_a7a737ae.bundle.var_6558c1e7);
    }
    if (isdefined(level.var_a7a737ae.bundle.var_87454d2f) ? level.var_a7a737ae.bundle.var_87454d2f : 0) {
        supplypod.var_f91c18c3 = getobjectiveid();
        supplypod.var_bb0a4eae = [];
        objective_add(supplypod.var_f91c18c3, "active", supplypod.origin, level.var_a7a737ae.bundle.var_e20b7080);
        objective_setprogress(supplypod.var_f91c18c3, 1);
        function_eeba3a5c(supplypod.var_f91c18c3, 1);
        objective_setinvisibletoall(supplypod.var_f91c18c3);
    }
    triggerradius = level.var_a7a737ae.bundle.var_974fc8ab;
    triggerheight = level.var_a7a737ae.bundle.var_72f4ceec;
    var_241a3223 = level.var_a7a737ae.bundle.var_3866f351;
    upangle = vectorscale(vectornormalize(anglestoup(supplypod.angles)), 5);
    var_8e2c7d48 = supplypod.origin + upangle;
    usetrigger = spawn("trigger_radius_use", var_8e2c7d48, 0, triggerradius, triggerheight);
    usetrigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    usetrigger function_29191d9f(1, 1 | 4096 | 2 | 8388608 | 2048);
    supplypod.gameobject = gameobjects::create_use_object(player getteam(), usetrigger, [], undefined, level.var_a7a737ae.bundle.var_77717149, 1, 1);
    supplypod.gameobject gameobjects::set_visible_team(#"friendly");
    supplypod.gameobject gameobjects::allow_use(#"friendly");
    supplypod.gameobject gameobjects::set_use_time(var_241a3223);
    supplypod.gameobject.onbeginuse = &function_27e3582f;
    supplypod.gameobject.onenduse = &function_fa8b1ae7;
    supplypod.gameobject.var_c477841c = supplypod;
    supplypod.gameobject.var_7460107b = 1;
    supplypod.gameobject.dontlinkplayertotrigger = 1;
    supplypod.gameobject.keepweapon = 1;
    supplypod.gameobject.requireslos = 1;
    supplypod.gameobject.var_d1de9af = 1;
    player deployable::function_c0980d61(supplypod, level.var_a7a737ae.weapon);
    supplypod.gameobject function_a8873b36(player);
    supplypod thread function_69addc90(player);
    supplypod thread function_92d9c4be();
    supplypod thread watchfordamage();
    supplypod thread watchfordeath();
    supplypod thread function_3b9cb8d9(player);
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0xe8e58834, Offset: 0x2be0
// Size: 0x6c
function function_a8873b36(player) {
    self endon(#"death");
    player endon(#"death");
    wait 0.2;
    if (isdefined(self) && isdefined(player)) {
        self function_fa8b1ae7(undefined, player, 1);
    }
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x4
// Checksum 0x4cb982ce, Offset: 0x2c58
// Size: 0xc
function private function_27e3582f(player) {
    
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x4
// Checksum 0x95288d6f, Offset: 0x2c70
// Size: 0x14
function private function_64e0b539(player, waittime) {
    
}

// Namespace supplypod/supplypod
// Params 3, eflags: 0x4
// Checksum 0xe88a1298, Offset: 0x2c90
// Size: 0x484
function private function_fa8b1ae7(team, player, result) {
    supplypod = self.var_c477841c;
    if (!isdefined(supplypod)) {
        return;
    }
    supplypod.isdisabled = 0;
    if (isdefined(result) && result) {
        supplypod.usecount++;
        if (isdefined(player) && isplayer(player)) {
            if (supplypod.owner != player) {
                scoreevents::processscoreevent(#"hash_69dbfbd660f8c53e", supplypod.owner, undefined, level.var_a7a737ae.weapon);
                relativepos = vectornormalize(player.origin - supplypod.owner.origin);
                dir = anglestoforward(supplypod.owner getplayerangles());
                dotproduct = vectordot(dir, relativepos);
                if (isdefined(level.playgadgetsuccess) && supplypod.usecount >= 1 && !isdefined(self.var_10e5a554) && dotproduct > 0 && sighttracepassed(supplypod.owner geteye(), self.origin, 1, supplypod.owner, self)) {
                    self.var_10e5a554 = 1;
                    supplypod.owner [[ level.playgadgetsuccess ]](level.var_a7a737ae.weapon, undefined, undefined, player);
                }
            }
            supplypod.owner battlechatter::function_b505bc94(level.var_a7a737ae.weapon, undefined, self.origin, self);
        }
        thread function_64e0b539(player, 1.5);
        player thread function_8c7cb2b8(supplypod);
        player function_1ce4aea6();
        self gameobjects::hide_waypoint(player);
        self.trigger setinvisibletoplayer(player);
        player.var_e4be405a = self;
        player.var_93245782 = self.team;
        player.var_72f2c26 = supplypod.owner;
        player notify(#"hash_69dbfbd660f8c53e");
        if (!(isdefined(level.var_a7a737ae.bundle.var_f32f43dd) ? level.var_a7a737ae.bundle.var_f32f43dd : 0)) {
            duration = isdefined(level.var_a7a737ae.bundle.var_f96a293c) ? level.var_a7a737ae.bundle.var_f96a293c : 30;
            player.var_1be066c6 = gettime() + int(duration * 1000);
            player thread function_5fbdb1bd(duration);
        } else {
            player.var_2d83397d = 1;
        }
        if (supplypod.usecount == supplypod.maxusecount) {
            supplypod thread function_2e234595(0);
        }
        return;
    }
    thread function_64e0b539(player, 0);
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0xcb98ea32, Offset: 0x3120
// Size: 0x12c
function function_5fbdb1bd(waittime) {
    self notify(#"hash_10cd6a20d4e45365");
    self endon(#"hash_10cd6a20d4e45365", #"disconnect");
    result = self waittilltimeout(waittime, #"death");
    if (result._notify == #"timeout") {
        self function_994cc651(1);
    } else if (isdefined(level.var_a7a737ae.bundle.var_5175ef17) ? level.var_a7a737ae.bundle.var_5175ef17 : 0) {
        self.var_1be066c6 -= gettime();
    } else {
        self.var_1be066c6 = undefined;
        self.var_72f2c26 = undefined;
    }
    self clientfield::set_player_uimodel("hudItems.goldenBullet", 0);
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0xcfbbdad3, Offset: 0x3258
// Size: 0xcc
function function_8c7cb2b8(supplypod) {
    playfxontag("weapon/fx8_equip_supplypod_canister_launch", supplypod, "tag_canister_smoke");
    beamlaunch(supplypod, self, "tag_origin_animate", "j_wrist_le", level.var_a7a737ae.weapon);
    gesture = level.var_a7a737ae.var_422ca8ee;
    self giveandfireoffhand(gesture);
    playsoundatposition(#"hash_f70797817dfefdb", supplypod.origin);
}

// Namespace supplypod/supplypod
// Params 3, eflags: 0x0
// Checksum 0xa9e6de6e, Offset: 0x3330
// Size: 0x20c
function function_4387fa50(origin, angles, player) {
    if (!isdefined(player.var_85023070)) {
        player.var_85023070 = spawnstruct();
    }
    var_bacec60c = isdefined(level.var_a7a737ae.bundle.var_984ab558) ? level.var_a7a737ae.bundle.var_984ab558 : 0;
    testdistance = var_bacec60c * var_bacec60c;
    ids = getarraykeys(level.var_a7a737ae.var_20d0150d);
    foreach (id in ids) {
        if (id == player.clientid) {
            continue;
        }
        pods = level.var_a7a737ae.var_20d0150d[id];
        foreach (pod in pods) {
            distsqr = distancesquared(origin, pod.origin);
            if (distsqr <= testdistance) {
                return false;
            }
        }
    }
    return true;
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0x44682d3b, Offset: 0x3548
// Size: 0x9c
function function_6f24a373(supplypod) {
    supplypod setvisibletoall();
    if (isdefined(supplypod.othermodel)) {
        supplypod.othermodel setinvisibletoall();
    }
    if (isdefined(supplypod.var_85023070)) {
        self function_800afe5(supplypod);
        playsoundatposition(#"hash_66e85d590b4f4b8", supplypod.origin);
    }
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0x66558967, Offset: 0x35f0
// Size: 0x8c
function oncancelplacement(supplypod) {
    slot = self gadgetgetslot(level.var_a7a737ae.weapon);
    self gadgetdeactivate(slot, level.var_a7a737ae.weapon, 0);
    self gadgetpowerset(slot, 100);
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0x52da0c3b, Offset: 0x3688
// Size: 0x4c
function onshutdown(supplypod) {
    if (isdefined(supplypod.var_7bee2c23) ? supplypod.var_7bee2c23 : 0) {
        return;
    }
    supplypod thread function_2e234595(0);
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0xf27e46d1, Offset: 0x36e0
// Size: 0x8c
function function_69addc90(player) {
    supplypod = self;
    player endon(#"disconnect");
    supplypod endon(#"death");
    player waittill(#"joined_team", #"changed_specialist");
    supplypod thread function_2e234595(0);
}

// Namespace supplypod/supplypod
// Params 2, eflags: 0x0
// Checksum 0x97451d9, Offset: 0x3778
// Size: 0xb6
function function_4393ee24(weapon, weaponindex) {
    player = self;
    level endon(#"game_ended");
    player notify("on_death_ammon_backup" + weaponindex);
    player endon("on_death_ammon_backup" + weaponindex, #"disconnect");
    player waittill(#"death");
    player.pers["pod_ammo" + weaponindex] = player getweaponammostock(weapon);
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0x3805afb4, Offset: 0x3838
// Size: 0x1b6
function function_db9023ee(weapon) {
    player = self;
    level endon(#"game_ended");
    player notify(#"hash_620e9c8ce0a79cf7");
    player endon(#"hash_620e9c8ce0a79cf7", #"disconnect");
    while (isdefined(player.pod_ammo) && player.pod_ammo.size > 0) {
        weapon = player getcurrentweapon();
        var_8e6b7ed0 = weapons::getbaseweapon(weapon);
        baseweaponindex = getbaseweaponitemindex(var_8e6b7ed0);
        if (isdefined(player.pod_ammo[baseweaponindex]) && player.pod_ammo[baseweaponindex]) {
            curammo = player getweaponammostock(weapon);
            if (curammo == 0) {
                player setweaponammostock(weapon, int(player.pod_ammo[baseweaponindex]));
                player.pod_ammo[baseweaponindex] = undefined;
                player thread function_4393ee24(weapon, baseweaponindex);
            }
        }
        waitframe(1);
    }
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0xbc0d5c28, Offset: 0x39f8
// Size: 0x13c
function function_bd199ac4() {
    player = self;
    primary_weapons = player getweaponslistprimaries();
    foreach (weapon in primary_weapons) {
        var_8e6b7ed0 = weapons::getbaseweapon(weapon);
        baseweaponindex = getbaseweaponitemindex(var_8e6b7ed0);
        player.pod_ammo[baseweaponindex] = (isdefined(level.var_a7a737ae.bundle.var_7b95813e) ? level.var_a7a737ae.bundle.var_7b95813e : 0) * weapon.clipsize;
    }
    player thread function_db9023ee();
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0x5a17deb4, Offset: 0x3b40
// Size: 0x164
function function_1ce4aea6() {
    player = self;
    primary_weapons = player getweaponslistprimaries();
    foreach (weapon in primary_weapons) {
        curammo = player getweaponammostock(weapon);
        bonusammo = (isdefined(level.var_a7a737ae.bundle.var_7b95813e) ? level.var_a7a737ae.bundle.var_7b95813e : 0) * weapon.clipsize;
        player setweaponammostock(weapon, int(curammo + bonusammo));
    }
    player clientfield::set_player_uimodel("hudItems.goldenBullet", 1);
}

// Namespace supplypod/supplypod
// Params 1, eflags: 0x0
// Checksum 0xcb72ceba, Offset: 0x3cb0
// Size: 0x1a6
function function_ac0564b1(owner) {
    player = self;
    cooldowns[0] = level.var_a7a737ae.bundle.var_8253b0e5;
    cooldowns[1] = level.var_a7a737ae.bundle.var_fbff0699;
    cooldowns[2] = level.var_a7a737ae.bundle.var_b09ff4ab;
    for (slot = 0; slot < 3; slot++) {
        if (!isdefined(cooldowns[slot])) {
            continue;
        }
        if (!isdefined(player._gadgets_player[slot])) {
            continue;
        }
        cooldown = cooldowns[slot] * (isdefined(player._gadgets_player[slot].var_86024936) ? player._gadgets_player[slot].var_86024936 : 0);
        if (isdefined(owner) && owner) {
            cooldown *= isdefined(level.var_a7a737ae.bundle.var_6fe67e73) ? level.var_a7a737ae.bundle.var_6fe67e73 : 0;
        }
        player gadgetpowerchange(slot, cooldown);
    }
}

// Namespace supplypod/supplypod
// Params 0, eflags: 0x0
// Checksum 0xdbaf3523, Offset: 0x3e60
// Size: 0x20c
function function_e218986() {
    player = self;
    for (weapon = player getcurrentweapon(); weapon == level.weaponnone; weapon = player getcurrentweapon()) {
        waitframe(1);
    }
    slot = player gadgetgetslot(weapon);
    if (slot == 2 || weapon == getweapon(#"sig_buckler_turret")) {
        if (isdefined(weapon.var_7b5d314d)) {
            player gadgetpowerchange(slot, weapon.var_7b5d314d);
        }
        if (isdefined(weapon.var_85adb370)) {
            if (weapon == getweapon(#"sig_buckler_turret") || weapon == getweapon(#"sig_buckler_dw")) {
                stockammo = player getweaponammoclip(weapon);
                player setweaponammoclip(weapon, stockammo + int(weapon.var_85adb370));
                return;
            }
            stockammo = player getweaponammostock(weapon);
            player setweaponammostock(weapon, stockammo + int(weapon.var_85adb370));
        }
    }
}

