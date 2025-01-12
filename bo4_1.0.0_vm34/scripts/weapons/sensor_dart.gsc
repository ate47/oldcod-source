#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\weaponobjects;

#namespace sensor_dart;

// Namespace sensor_dart/sensor_dart
// Params 0, eflags: 0x2
// Checksum 0xfcef80b3, Offset: 0x150
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"sensor_dart", &init_shared, undefined, undefined);
}

// Namespace sensor_dart/sensor_dart
// Params 0, eflags: 0x0
// Checksum 0x1a42910a, Offset: 0x198
// Size: 0xe4
function init_shared() {
    level thread register();
    callback::on_spawned(&on_player_spawned);
    weaponobjects::function_f298eae6(#"eq_sensor", &function_9bb3268b, 1);
    globallogic_score::register_kill_callback(getweapon("eq_sensor"), &function_500e9ca1);
    globallogic_score::function_55e3f7c(getweapon("eq_sensor"), &function_500e9ca1);
}

// Namespace sensor_dart/sensor_dart
// Params 0, eflags: 0x0
// Checksum 0x620aab82, Offset: 0x288
// Size: 0x64
function register() {
    clientfield::register("missile", "sensor_dart_state", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.sensorDartCount", 1, 3, "int");
}

// Namespace sensor_dart/sensor_dart
// Params 0, eflags: 0x0
// Checksum 0x82ea5be6, Offset: 0x2f8
// Size: 0x6c
function on_player_spawned() {
    weapon = getweapon("eq_sensor");
    if (isdefined(weapon) && !self hasweapon(weapon)) {
        self clientfield::set_player_uimodel("hudItems.sensorDartCount", 0);
    }
}

// Namespace sensor_dart/sensor_dart
// Params 5, eflags: 0x0
// Checksum 0x202f3c92, Offset: 0x370
// Size: 0x16e
function function_500e9ca1(attacker, victim, weapon, attackerweapon, meansofdeath) {
    if (!isdefined(attackerweapon) || !isdefined(attacker) || !isdefined(victim) || !isdefined(weapon)) {
        return false;
    }
    if (isdefined(attacker.sensor_darts)) {
        foreach (dart in attacker.sensor_darts) {
            if (isdefined(dart) && distancesquared(victim.origin, dart.origin) < ((sessionmodeiswarzonegame() ? 2400 : 800) + 50) * ((sessionmodeiswarzonegame() ? 2400 : 800) + 50) && weapon != attackerweapon) {
                return true;
            }
        }
    }
    return false;
}

// Namespace sensor_dart/sensor_dart
// Params 1, eflags: 0x0
// Checksum 0xd1d8efc, Offset: 0x4e8
// Size: 0x116
function function_9bb3268b(watcher) {
    watcher.ondetonatecallback = &function_9fc405e7;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.deleteonplayerspawn = 0;
    watcher.enemydestroy = 1;
    watcher.onspawn = &function_57f8d0ec;
    watcher.ondamage = &function_222ae58c;
    watcher.ondestroyed = &function_e2fc3dc8;
    watcher.pickup = &weaponobjects::function_e00a2820;
    watcher.var_46869d39 = &function_ca44422;
}

// Namespace sensor_dart/sensor_dart
// Params 1, eflags: 0x0
// Checksum 0xab6dba00, Offset: 0x608
// Size: 0x24
function function_ca44422(player) {
    self function_e2fc3dc8(undefined, undefined);
}

// Namespace sensor_dart/sensor_dart
// Params 2, eflags: 0x0
// Checksum 0x9299e3a6, Offset: 0x638
// Size: 0x2fc
function function_57f8d0ec(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    level endon(#"game_ended");
    self endon(#"death");
    self weaponobjects::onspawnuseweaponobject(watcher, player);
    self clientfield::set("sensor_dart_state", 1);
    self.weapon = getweapon(#"eq_sensor");
    self setweapon(self.weapon);
    if (!isdefined(player.sensor_darts)) {
        player.sensor_darts = [];
    }
    if (!isdefined(player.sensor_darts)) {
        player.sensor_darts = [];
    } else if (!isarray(player.sensor_darts)) {
        player.sensor_darts = array(player.sensor_darts);
    }
    player.sensor_darts[player.sensor_darts.size] = self;
    player clientfield::set_player_uimodel("hudItems.sensorDartCount", player.sensor_darts.size);
    self waittill(#"stationary");
    player stats::function_4f10b697(self.weapon, #"used", 1);
    self util::make_sentient();
    self thread function_7c1cd376(player);
    self thread function_428ce367();
    self thread function_b20fceb8();
    if (isdefined(level.var_6a59f8eb)) {
        level thread [[ level.var_6a59f8eb ]](self, player);
    }
    self thread weaponobjects::function_15617e5c(self.weapon.fusetime, &function_95e3375a);
    self clientfield::set("enemyequip", 1);
    playfxontag(#"hash_1307839267d89579", self, "tag_fx");
}

// Namespace sensor_dart/sensor_dart
// Params 0, eflags: 0x4
// Checksum 0xce90291, Offset: 0x940
// Size: 0xf4
function private function_b20fceb8() {
    owner = self.owner;
    waitresult = self waittill(#"picked_up", #"death", #"hacked");
    if (isdefined(owner) && isdefined(owner.sensor_darts)) {
        arrayremovevalue(owner.sensor_darts, undefined);
        owner clientfield::set_player_uimodel("hudItems.sensorDartCount", owner.sensor_darts.size);
    }
    if (waitresult._notify == "death") {
        return;
    }
    if (isdefined(self)) {
        self clientfield::set("sensor_dart_state", 0);
    }
}

// Namespace sensor_dart/sensor_dart
// Params 0, eflags: 0x0
// Checksum 0x65f629cd, Offset: 0xa40
// Size: 0x2a
function function_428ce367() {
    self endon(#"death");
    self waittill(#"hacked");
}

// Namespace sensor_dart/sensor_dart
// Params 2, eflags: 0x0
// Checksum 0x9e792975, Offset: 0xa78
// Size: 0x15c
function function_e2fc3dc8(attacker, callback_data) {
    playfx(level._equipment_explode_fx_lg, self.origin);
    self playsound(#"hash_2e37b2a562ab2bf8");
    if (isdefined(level.playequipmentdestroyedonplayer)) {
        self.owner [[ level.playequipmentdestroyedonplayer ]]();
    }
    if (isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedequipment();
        scoreevents::processscoreevent(#"hash_4c5d3e163d180de8", attacker, self.owner, undefined);
        self.owner globallogic_score::function_8fe8d71e(#"hash_116d984c5c7c887e");
        if (isdefined(level.var_b31e16d4)) {
            self [[ level.var_b31e16d4 ]](attacker, self.owner, self.weapon);
        }
    }
    self delete();
}

// Namespace sensor_dart/sensor_dart
// Params 1, eflags: 0x0
// Checksum 0xa17dd5cd, Offset: 0xbe0
// Size: 0xba
function function_7c1cd376(owner) {
    owner endon(#"disconnect");
    self endon(#"death", #"hacked");
    level notify(#"hash_70f03cfbb15356c0", {#dart:self});
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        if (level.missileentities.size < 1 || isdefined(self.disabled)) {
            waitframe(1);
            continue;
        }
        waitframe(1);
    }
}

// Namespace sensor_dart/sensor_dart
// Params 0, eflags: 0x0
// Checksum 0x8c469fb5, Offset: 0xca8
// Size: 0x1c
function function_95e3375a() {
    self thread function_e2fc3dc8(undefined, undefined);
}

// Namespace sensor_dart/sensor_dart
// Params 3, eflags: 0x0
// Checksum 0xe0b68ec2, Offset: 0xcd0
// Size: 0x19c
function function_9fc405e7(attacker, weapon, target) {
    level notify(#"hash_4ee855fb0aa467c9");
    if (!isdefined(weapon) || !weapon.isemp) {
        playfx(level._equipment_explode_fx_lg, self.origin);
    }
    if (isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedequipment(weapon);
        self.owner globallogic_score::function_a63adb85(attacker, weapon, self.weapon);
    }
    playsoundatposition(#"hash_206452ff3953c686", self.origin);
    if (isdefined(level.var_b31e16d4)) {
        self [[ level.var_b31e16d4 ]](attacker, self.owner, self.weapon, weapon);
    }
    self.owner luinotifyevent(#"hash_4ee855fb0aa467c9");
    self.owner globallogic_score::function_8fe8d71e(#"hash_116d984c5c7c887e");
    self delete();
}

// Namespace sensor_dart/sensor_dart
// Params 1, eflags: 0x0
// Checksum 0x579a5be3, Offset: 0xe78
// Size: 0x35a
function function_222ae58c(watcher) {
    self endon(#"death");
    self endon(#"hacked");
    self setcandamage(1);
    damagemax = 20;
    if (!self util::ishacked()) {
        self.damagetaken = 0;
    }
    self.maxhealth = 10000;
    self.health = self.maxhealth;
    self setmaxhealth(self.maxhealth);
    attacker = undefined;
    while (true) {
        waitresult = self waittill(#"damage");
        damage = waitresult.amount;
        type = waitresult.mod;
        weapon = waitresult.weapon;
        damage = weapons::function_fa5602(damage, weapon, self.weapon);
        attacker = self [[ level.figure_out_attacker ]](waitresult.attacker);
        attackerisplayer = isplayer(attacker);
        if (level.teambased) {
            if (attackerisplayer && !level.hardcoremode && self.owner.team == attacker.pers[#"team"] && self.owner != attacker) {
                continue;
            }
        }
        if (watcher.stuntime > 0 && weapon.dostun) {
            self thread weaponobjects::stunstart(watcher, watcher.stuntime);
        }
        if (attackerisplayer && damage::friendlyfirecheck(self.owner, attacker)) {
            if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                attacker damagefeedback::update();
            }
        }
        if (type == "MOD_MELEE" || type == "MOD_MELEE_WEAPON_BUTT" || weapon.isemp || weapon.destroysequipment) {
            self.damagetaken = damagemax;
        } else {
            self.damagetaken += damage;
        }
        if (self.damagetaken >= damagemax) {
            watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
            return;
        }
    }
}

