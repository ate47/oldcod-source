#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace sensor_arrow;

// Namespace sensor_arrow/sensor_arrow
// Params 0, eflags: 0x2
// Checksum 0x912f820a, Offset: 0x338
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("sensor_arrow", &init_shared, undefined, undefined);
}

// Namespace sensor_arrow/sensor_arrow
// Params 0, eflags: 0x0
// Checksum 0x32771313, Offset: 0x378
// Size: 0x5c
function init_shared() {
    level thread register();
    callback::on_spawned(&on_player_spawned);
    callback::on_start_gametype(&start_gametype);
}

// Namespace sensor_arrow/sensor_arrow
// Params 0, eflags: 0x0
// Checksum 0xdbf9be0, Offset: 0x3e0
// Size: 0x34
function register() {
    clientfield::register("missile", "sensor_arrow_state", 1, 1, "int");
}

// Namespace sensor_arrow/sensor_arrow
// Params 0, eflags: 0x0
// Checksum 0x4341b8ec, Offset: 0x420
// Size: 0x44
function start_gametype() {
    weaponobjects::function_daf3d8b3("sig_bow_sensor", %SENSORARROW_HOLD_TO_PICKUP);
    weaponobjects::function_25e68262("sig_bow_sensor", %SENSORARROW_HOLD_TO_DESTROY);
}

// Namespace sensor_arrow/sensor_arrow
// Params 0, eflags: 0x0
// Checksum 0xa059572a, Offset: 0x470
// Size: 0x1c
function on_player_spawned() {
    self function_3cdfa315();
}

// Namespace sensor_arrow/sensor_arrow
// Params 0, eflags: 0x0
// Checksum 0xce772909, Offset: 0x498
// Size: 0x212
function function_3cdfa315() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("sig_bow_sensor", self.team);
    watcher.ondetonatecallback = &function_9fc405e7;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.headicon = 0;
    watcher.enemydestroy = 1;
    watcher.var_87c87431 = 1;
    watcher.onspawn = &function_57f8d0ec;
    watcher.ondamage = &function_222ae58c;
    watcher.ondestroyed = &function_e2fc3dc8;
    watcher.var_1ededbfb = [];
    watcher.var_1ededbfb["sig_bow_sensor"] = getweapon("sig_bow_sensor");
    watcher.var_1ededbfb["sig_bow_sensor2"] = getweapon("sig_bow_sensor2");
    watcher.var_1ededbfb["sig_bow_sensor3"] = getweapon("sig_bow_sensor3");
    watcher.var_1ededbfb["sig_bow_sensor4"] = getweapon("sig_bow_sensor4");
}

// Namespace sensor_arrow/sensor_arrow
// Params 2, eflags: 0x0
// Checksum 0xc70bed3a, Offset: 0x6b8
// Size: 0x194
function function_57f8d0ec(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    level endon(#"game_ended");
    self endon(#"death");
    self weaponobjects::onspawnuseweaponobject(watcher, player);
    self clientfield::set("sensor_arrow_state", 0);
    self waittill("stationary");
    self clientfield::set("sensor_arrow_state", 1);
    player addweaponstat(self.weapon, "used", 1);
    self thread function_1d8070f6(player);
    self thread function_8fecd8e7();
    self thread function_146a8038();
    self thread function_753f0863(self.weapon.fusetime);
    self clientfield::set("enemyequip", 1);
    playfxontag("weapon/fx8_hero_sig_bow_sensor_pulse", self, "tag_fx");
}

// Namespace sensor_arrow/sensor_arrow
// Params 0, eflags: 0x4
// Checksum 0x5a38b2c, Offset: 0x858
// Size: 0x74
function private function_146a8038() {
    waitresult = self waittill("picked_up", "death", "hacked");
    if (waitresult._notify == "death") {
        return;
    }
    if (isdefined(self)) {
        self clientfield::set("sensor_arrow_state", 0);
    }
}

// Namespace sensor_arrow/sensor_arrow
// Params 1, eflags: 0x4
// Checksum 0x481d234f, Offset: 0x8d8
// Size: 0x54
function private function_753f0863(fuse_time) {
    if (!isdefined(fuse_time) || fuse_time <= 0) {
        return;
    }
    self endon(#"death");
    wait fuse_time / 1000;
    self function_95e3375a();
}

// Namespace sensor_arrow/sensor_arrow
// Params 0, eflags: 0x0
// Checksum 0x9251076e, Offset: 0x938
// Size: 0x1e
function function_8fecd8e7() {
    self endon(#"death");
    self waittill("hacked");
}

// Namespace sensor_arrow/sensor_arrow
// Params 1, eflags: 0x0
// Checksum 0x657e6406, Offset: 0x960
// Size: 0xdc
function function_e2fc3dc8(attacker) {
    playfx(level._equipment_explode_fx_lg, self.origin);
    self playsound("dst_trophy_smash");
    if (isdefined(level.playequipmentdestroyedonplayer)) {
        self.owner [[ level.playequipmentdestroyedonplayer ]]();
    }
    if (isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedequipment();
    }
    self delete();
}

// Namespace sensor_arrow/sensor_arrow
// Params 1, eflags: 0x0
// Checksum 0xbe29c79a, Offset: 0xa48
// Size: 0x80
function function_1d8070f6(owner) {
    owner endon(#"disconnect");
    self endon(#"death");
    self endon(#"hacked");
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

// Namespace sensor_arrow/sensor_arrow
// Params 0, eflags: 0x0
// Checksum 0xd701ec0a, Offset: 0xad0
// Size: 0x1c
function function_95e3375a() {
    self thread function_e2fc3dc8(undefined);
}

// Namespace sensor_arrow/sensor_arrow
// Params 3, eflags: 0x0
// Checksum 0xb4deac34, Offset: 0xaf8
// Size: 0xe4
function function_9fc405e7(attacker, weapon, target) {
    if (!isdefined(weapon) || !weapon.isemp) {
        playfx(level._equipment_explode_fx_lg, self.origin);
    }
    if (isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedequipment(weapon);
    }
    playsoundatposition("exp_trophy_system", self.origin);
    self delete();
}

// Namespace sensor_arrow/sensor_arrow
// Params 1, eflags: 0x0
// Checksum 0xccb03ca1, Offset: 0xbe8
// Size: 0x3a2
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
        waitresult = self waittill("damage");
        damage = waitresult.amount;
        type = waitresult.mod;
        weapon = waitresult.weapon;
        attacker = self [[ level.figure_out_attacker ]](waitresult.attacker);
        if (!isplayer(attacker)) {
            continue;
        }
        if (level.teambased) {
            if (!level.hardcoremode && self.owner.team == attacker.pers["team"] && self.owner != attacker) {
                continue;
            }
        }
        if (watcher.stuntime > 0 && weapon.dostun) {
            self thread weaponobjects::stunstart(watcher, watcher.stuntime);
        }
        if (weapon.dodamagefeedback) {
            if (level.teambased && self.owner.team != attacker.team) {
                if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                    attacker damagefeedback::update();
                }
            } else if (!level.teambased && self.owner != attacker) {
                if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                    attacker damagefeedback::update();
                }
            }
        }
        if (type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment) {
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

