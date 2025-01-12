#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/decoy;
#using scripts/core_common/weapons/hacker_tool;
#using scripts/core_common/weapons/weaponobjects;

#namespace sensor_grenade;

// Namespace sensor_grenade/sensor_grenade
// Params 0, eflags: 0x0
// Checksum 0x77c2047a, Offset: 0x330
// Size: 0x44
function init_shared() {
    level.var_a747f90a = &function_e9649fd8;
    callback::function_367a33a8(&function_cb111d01);
}

// Namespace sensor_grenade/sensor_grenade
// Params 0, eflags: 0x0
// Checksum 0x656497e2, Offset: 0x380
// Size: 0xcc
function function_cb111d01() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("sensor_grenade", self.team);
    watcher.headicon = 0;
    watcher.onspawn = &function_bdecb8fd;
    watcher.ondetonatecallback = &function_7750ac68;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 0;
    watcher.ondamage = &function_288c9631;
    watcher.enemydestroy = 1;
}

// Namespace sensor_grenade/sensor_grenade
// Params 2, eflags: 0x0
// Checksum 0x451e6694, Offset: 0x458
// Size: 0x144
function function_bdecb8fd(watcher, player) {
    self endon(#"death");
    self thread weaponobjects::onspawnuseweaponobject(watcher, player);
    self setowner(player);
    self setteam(player.team);
    self.owner = player;
    self playloopsound("wpn_sensor_nade_lp");
    self hacker_tool::registerwithhackertool(level.equipmenthackertoolradius, level.equipmenthackertooltimems);
    player addweaponstat(self.weapon, "used", 1);
    self thread function_5aadfa85(player);
    self thread function_ab966fda(player);
    self thread function_f4ccbeb2(player);
}

// Namespace sensor_grenade/sensor_grenade
// Params 1, eflags: 0x0
// Checksum 0x6e27b67, Offset: 0x5a8
// Size: 0x6c
function function_5aadfa85(owner) {
    self endon(#"death", #"hacked", #"explode");
    owner endon(#"death", #"disconnect");
    self waittill("stationary");
    function_32b1b0c7(self.origin);
}

// Namespace sensor_grenade/sensor_grenade
// Params 1, eflags: 0x0
// Checksum 0x4a1a3e93, Offset: 0x620
// Size: 0x7c
function function_ab966fda(owner) {
    self endon(#"hacked", #"delete");
    owner endon(#"death", #"disconnect");
    waitresult = self waittill("explode");
    function_32b1b0c7(waitresult.position + (0, 0, 1));
}

// Namespace sensor_grenade/sensor_grenade
// Params 1, eflags: 0x0
// Checksum 0x47bda178, Offset: 0x6a8
// Size: 0x1e2
function function_32b1b0c7(origin) {
    if (isdefined(self.owner) == 0) {
        return;
    }
    players = level.players;
    foreach (player in level.players) {
        if (player util::isenemyplayer(self.owner)) {
            if (!player hasperk("specialty_nomotionsensor") && !(player hasperk("specialty_sengrenjammer") && player clientfield::get("sg_jammer_active"))) {
                if (distancesquared(player.origin, origin) < 562500) {
                    trace = bullettrace(origin, player.origin + (0, 0, 12), 0, player);
                    if (trace["fraction"] == 1) {
                        self.owner function_eaae596a(player);
                    }
                }
            }
        }
    }
}

// Namespace sensor_grenade/sensor_grenade
// Params 1, eflags: 0x0
// Checksum 0xb06d7a25, Offset: 0x898
// Size: 0x62
function function_eaae596a(victim) {
    if (!isdefined(self.sensorgrenadedata)) {
        self.sensorgrenadedata = [];
    }
    if (!isdefined(self.sensorgrenadedata[victim.clientid])) {
        self.sensorgrenadedata[victim.clientid] = gettime();
    }
}

// Namespace sensor_grenade/sensor_grenade
// Params 2, eflags: 0x0
// Checksum 0xcbe7a823, Offset: 0x908
// Size: 0x86
function function_e9649fd8(player, time) {
    var_569f288c = 0;
    if (isdefined(self.sensorgrenadedata) && isdefined(self.sensorgrenadedata[player.clientid])) {
        if (self.sensorgrenadedata[player.clientid] + 10000 > time) {
            var_569f288c = 1;
        }
    }
    return var_569f288c;
}

// Namespace sensor_grenade/sensor_grenade
// Params 3, eflags: 0x0
// Checksum 0x1002168e, Offset: 0x998
// Size: 0x10c
function function_7750ac68(attacker, weapon, target) {
    if (!isdefined(weapon) || !weapon.isemp) {
        playfx(level._equipment_explode_fx, self.origin);
    }
    if (isdefined(attacker)) {
        if (self.owner util::isenemyplayer(attacker)) {
            attacker challenges::destroyedequipment(weapon);
            scoreevents::processscoreevent("destroyed_motion_sensor", attacker, self.owner, weapon);
        }
    }
    playsoundatposition("wpn_sensor_nade_explo", self.origin);
    self delete();
}

// Namespace sensor_grenade/sensor_grenade
// Params 1, eflags: 0x0
// Checksum 0x515f2271, Offset: 0xab0
// Size: 0x39a
function function_288c9631(watcher) {
    self endon(#"death");
    self endon(#"hacked");
    self setcandamage(1);
    damagemax = 1;
    if (!self util::ishacked()) {
        self.damagetaken = 0;
    }
    while (true) {
        self.maxhealth = 100000;
        self.health = self.maxhealth;
        waitresult = self waittill("damage");
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        type = waitresult.mod;
        damage = waitresult.amount;
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        if (level.teambased && isplayer(attacker)) {
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
            watcher thread weaponobjects::waitanddetonate(self, 0, attacker, weapon);
            return;
        }
    }
}

// Namespace sensor_grenade/sensor_grenade
// Params 1, eflags: 0x0
// Checksum 0x604b8c5d, Offset: 0xe58
// Size: 0x152
function function_f4ccbeb2(owner) {
    self waittill("stationary");
    players = level.players;
    foreach (player in level.players) {
        if (player util::isenemyplayer(self.owner)) {
            if (isalive(player) && player hasperk("specialty_decoy")) {
                if (distancesquared(player.origin, self.origin) < 57600) {
                    player thread function_d7943f6b(self);
                }
            }
        }
    }
}

// Namespace sensor_grenade/sensor_grenade
// Params 0, eflags: 0x0
// Checksum 0xcbac97d0, Offset: 0xfb8
// Size: 0x2e
function function_23685d89() {
    return self.origin - 240 * anglestoforward(self.angles);
}

// Namespace sensor_grenade/sensor_grenade
// Params 1, eflags: 0x0
// Checksum 0xfdb7e929, Offset: 0xff0
// Size: 0xf4
function function_d7943f6b(sensor_grenade) {
    origin = self function_23685d89();
    decoy_grenade = sys::spawn("script_model", origin);
    decoy_grenade.angles = -1 * self.angles;
    waitframe(1);
    decoy_grenade.var_8d009e7f = -1 * self getvelocity();
    decoy_grenade thread decoy::function_a63701dd(self);
    wait 15;
    decoy_grenade notify(#"done");
    decoy_grenade notify(#"hash_deb9ad6f");
    decoy_grenade delete();
}

