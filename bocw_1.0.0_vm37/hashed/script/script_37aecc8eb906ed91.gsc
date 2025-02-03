#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\entityheadicons_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weaponobjects;

#namespace nightingale;

// Namespace nightingale/nightingale
// Params 0, eflags: 0x6
// Checksum 0x92689b1, Offset: 0x148
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"nightingale", &preinit, undefined, undefined, undefined);
}

// Namespace nightingale/nightingale
// Params 0, eflags: 0x4
// Checksum 0xa5bab630, Offset: 0x190
// Size: 0x1dc
function private preinit() {
    clientfield::register("scriptmover", "" + #"nightingale_deployed", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_7c2ee5bfa7cad803", 1, 1, "int");
    weapon = getweapon(#"nightingale");
    level.var_432fa05c = {#var_402a4207:[], #var_558ae5bc:sqr(500)};
    callback::add_callback(#"hash_7c6da2f2c9ef947a", &function_30a3d1d2);
    globallogic_score::register_kill_callback(weapon, &function_dedc78a9);
    weaponobjects::function_e6400478(#"nightingale", &function_713a08b, 1);
    if (isdefined(level.var_a5dacbea)) {
        [[ level.var_a5dacbea ]](weapon, &function_6ab1797f);
    }
    if (isdefined(level.var_f9109dc6)) {
        [[ level.var_f9109dc6 ]](weapon, &function_7dfb4daa);
    }
}

// Namespace nightingale/nightingale
// Params 1, eflags: 0x4
// Checksum 0xe8329c4c, Offset: 0x378
// Size: 0x62
function private function_713a08b(watcher) {
    watcher.ignoredirection = 1;
    watcher.ondestroyed = &function_81619d12;
    watcher.ondamage = &function_acc36c55;
    watcher.ondetonatecallback = &function_c4afd8d1;
}

// Namespace nightingale/nightingale
// Params 2, eflags: 0x4
// Checksum 0x631aed3a, Offset: 0x3e8
// Size: 0x5c
function private function_81619d12(attacker, *data) {
    if (isdefined(self.owner) && isdefined(level.playequipmentdestroyedonplayer)) {
        self.owner [[ level.playequipmentdestroyedonplayer ]]();
    }
    self function_1bda2316(data);
}

// Namespace nightingale/nightingale
// Params 3, eflags: 0x4
// Checksum 0xcd24ee3e, Offset: 0x450
// Size: 0x34
function private function_c4afd8d1(attacker, weapon, *target) {
    self function_1bda2316(weapon, target);
}

// Namespace nightingale/nightingale
// Params 2, eflags: 0x4
// Checksum 0x24c3186b, Offset: 0x490
// Size: 0xdc
function private function_1bda2316(attacker, weapon) {
    weaponobjects::function_b4793bda(self, self.weapon);
    if (isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        scoreevents::processscoreevent(#"destroyed_nightingale", attacker, self.owner, weapon);
        attacker challenges::destroyedequipment();
        self battlechatter::function_d2600afc(attacker, self.owner, self.weapon, weapon);
    }
    self delete();
}

// Namespace nightingale/nightingale
// Params 1, eflags: 0x4
// Checksum 0xf5f340ac, Offset: 0x578
// Size: 0x44c
function private function_acc36c55(watcher) {
    self endon(#"death", #"hacked", #"detonating");
    self waittill(#"deployed");
    if (!isdefined(self.var_20a0f018)) {
        return;
    }
    self.var_20a0f018 endon(#"death");
    self.var_20a0f018 setcandamage(1);
    self.var_20a0f018.maxhealth = 100000;
    self.var_20a0f018.health = self.var_20a0f018.maxhealth;
    while (true) {
        waitresult = self.var_20a0f018 waittill(#"damage");
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        damage = waitresult.amount;
        type = waitresult.mod;
        idflags = waitresult.flags;
        if (!isplayer(attacker) && isdefined(attacker.owner)) {
            attacker = attacker.owner;
        }
        if (isdefined(weapon)) {
            self weaponobjects::weapon_object_do_damagefeedback(weapon, attacker, type, waitresult.inflictor);
        }
        if (!level.weaponobjectdebug && level.teambased && isplayer(attacker) && isdefined(self.owner)) {
            if (!level.hardcoremode && !util::function_fbce7263(self.owner.team, attacker.pers[#"team"]) && self.owner != attacker) {
                continue;
            }
        }
        if (!isvehicle(self) && !damage::friendlyfirecheck(self.owner, attacker)) {
            continue;
        }
        if (util::function_fbce7263(attacker.team, self.team)) {
            killstreaks::function_e729ccee(attacker, weapon);
        }
        break;
    }
    if (level.weaponobjectexplodethisframe) {
        wait 0.1 + randomfloat(0.4);
    } else {
        waitframe(1);
    }
    if (!isdefined(self)) {
        return;
    }
    level.weaponobjectexplodethisframe = 1;
    thread weaponobjects::resetweaponobjectexplodethisframe();
    self entityheadicons::setentityheadicon("none");
    if (isdefined(type) && (issubstr(type, "MOD_GRENADE_SPLASH") || issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE"))) {
        self.waschained = 1;
    }
    if (isdefined(idflags) && idflags & 8) {
        self.wasdamagedfrombulletpenetration = 1;
    }
    self.wasdamaged = 1;
    watcher thread weaponobjects::waitanddetonate(self, 0, attacker, weapon);
}

// Namespace nightingale/nightingale
// Params 1, eflags: 0x4
// Checksum 0xda80cd20, Offset: 0x9d0
// Size: 0xc4
function private function_6ab1797f(decoygrenade) {
    if (is_true(decoygrenade.shuttingdown)) {
        return;
    }
    if (isdefined(decoygrenade.var_20a0f018)) {
        decoygrenade.var_20a0f018 clientfield::set("isJammed", 1);
        decoygrenade.var_20a0f018 clientfield::set("" + #"hash_7c2ee5bfa7cad803", 0);
        decoygrenade.var_20a0f018 stoploopsound(0.5);
    }
    decoygrenade scene::stop();
}

// Namespace nightingale/nightingale
// Params 1, eflags: 0x4
// Checksum 0x9aa4d7cd, Offset: 0xaa0
// Size: 0xe4
function private function_7dfb4daa(decoygrenade) {
    if (is_true(decoygrenade.shuttingdown)) {
        return;
    }
    if (!isdefined(decoygrenade.var_20a0f018)) {
        return;
    }
    decoygrenade.var_20a0f018 clientfield::set("isJammed", 0);
    decoygrenade.var_20a0f018 clientfield::set("" + #"hash_7c2ee5bfa7cad803", 1);
    decoygrenade.var_20a0f018 playloopsound(#"hash_6e07f5906d35471");
    decoygrenade thread scene::play(#"scene_grenade_decoy_footsteps", decoygrenade.var_20a0f018);
}

// Namespace nightingale/grenade_fire
// Params 1, eflags: 0x44
// Checksum 0xd3b98f73, Offset: 0xb90
// Size: 0x164
function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
    if (eventstruct.weapon.name == #"nightingale") {
        grenade = eventstruct.projectile;
        grenade.var_cb19e5d4 = 1;
        grenade.var_515d6dda = 1;
        grenade.var_48d842c3 = 1;
        grenade waittill(#"stationary", #"death");
        if (!isdefined(grenade)) {
            return;
        }
        grenade thread function_db24f032();
        if (!isdefined(level.var_432fa05c.var_402a4207)) {
            level.var_432fa05c.var_402a4207 = [];
        } else if (!isarray(level.var_432fa05c.var_402a4207)) {
            level.var_432fa05c.var_402a4207 = array(level.var_432fa05c.var_402a4207);
        }
        level.var_432fa05c.var_402a4207[level.var_432fa05c.var_402a4207.size] = grenade;
    }
}

// Namespace nightingale/nightingale
// Params 0, eflags: 0x0
// Checksum 0xf0905aae, Offset: 0xd00
// Size: 0x2b4
function function_db24f032() {
    decoy = util::spawn_model(self.model, self.origin, self.angles);
    self.var_20a0f018 = decoy;
    decoy setteam(self.team);
    decoy.team = self.team;
    decoy clientfield::set("enemyequip", 1);
    decoy.aitype = #"hash_25454a5a4de341b8";
    decoy linkto(self);
    if (isdefined(self.originalowner) && isplayer(self.originalowner)) {
        decoy setowner(self.originalowner);
    }
    decoy clientfield::set("" + #"nightingale_deployed", 1);
    self ghost();
    self notsolid();
    if (is_true(self.isjammed)) {
        decoy clientfield::set("isJammed", 1);
    } else {
        self thread scene::play(#"scene_grenade_decoy_footsteps", decoy);
        decoy clientfield::set("" + #"hash_7c2ee5bfa7cad803", 1);
        decoy playloopsound(#"hash_6e07f5906d35471");
    }
    self notify(#"deployed");
    self waittill(#"death");
    self.shuttingdown = 1;
    if (isdefined(self)) {
        self scene::stop();
    }
    weaponobjects::function_f2a06099(self, self.weapon);
    if (isdefined(decoy)) {
        decoy deletedelay();
    }
}

// Namespace nightingale/nightingale
// Params 1, eflags: 0x0
// Checksum 0x8fc3388f, Offset: 0xfc0
// Size: 0x92
function function_29fbe24f(zombie) {
    arrayremovevalue(level.var_432fa05c.var_402a4207, undefined);
    var_402a4207 = level.var_432fa05c.var_402a4207;
    var_ed793fcb = undefined;
    if (var_402a4207.size > 0) {
        var_ed793fcb = arraygetclosest(zombie.origin, var_402a4207, 420);
    }
    return var_ed793fcb;
}

// Namespace nightingale/nightingale
// Params 1, eflags: 0x0
// Checksum 0x38ec8821, Offset: 0x1060
// Size: 0x160
function function_30a3d1d2(params) {
    arrayremovevalue(level.var_432fa05c.var_402a4207, undefined);
    foreach (var_e5d834ab in level.var_432fa05c.var_402a4207) {
        if (var_e5d834ab.team == self.team) {
            continue;
        }
        owner = var_e5d834ab.owner;
        if (isdefined(owner) && isdefined(params.players[owner getentitynumber()]) && level.var_432fa05c.var_558ae5bc >= distancesquared(var_e5d834ab.origin, self.origin)) {
            scoreevents::processscoreevent(#"nightingale_assist", owner);
        }
    }
}

// Namespace nightingale/nightingale
// Params 5, eflags: 0x0
// Checksum 0xa9a9516b, Offset: 0x11c8
// Size: 0x13e
function function_dedc78a9(attacker, victim, *weapon, *attackerweapon, *meansofdeath) {
    arrayremovevalue(level.var_432fa05c.var_402a4207, undefined);
    foreach (var_e5d834ab in level.var_432fa05c.var_402a4207) {
        if (var_e5d834ab.team == meansofdeath.team) {
            continue;
        }
        if (attackerweapon === var_e5d834ab.owner && level.var_432fa05c.var_558ae5bc >= distancesquared(var_e5d834ab.origin, meansofdeath.origin)) {
            return true;
        }
    }
    return false;
}

