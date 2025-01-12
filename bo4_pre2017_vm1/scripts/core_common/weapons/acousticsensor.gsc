#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace namespace_efc40536;

// Namespace namespace_efc40536/namespace_efc40536
// Params 0, eflags: 0x0
// Checksum 0xadef10d, Offset: 0x2b8
// Size: 0x64
function init_shared() {
    level._effect["acousticsensor_enemy_light"] = "_t6/misc/fx_equip_light_red";
    level._effect["acousticsensor_friendly_light"] = "_t6/misc/fx_equip_light_green";
    callback::add_weapon_watcher(&function_f7da464e);
}

// Namespace namespace_efc40536/namespace_efc40536
// Params 0, eflags: 0x0
// Checksum 0x1340ff91, Offset: 0x328
// Size: 0xc0
function function_f7da464e() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("acoustic_sensor", self.team);
    watcher.onspawn = &function_ed275b60;
    watcher.ondetonatecallback = &function_46660dce;
    watcher.stun = &weaponobjects::weaponstun;
    watcher.stuntime = 5;
    watcher.hackable = 1;
    watcher.ondamage = &function_1e59bb1a;
}

// Namespace namespace_efc40536/namespace_efc40536
// Params 2, eflags: 0x0
// Checksum 0x3a6b5453, Offset: 0x3f0
// Size: 0x114
function function_ed275b60(watcher, player) {
    self endon(#"death");
    self thread weaponobjects::onspawnuseweaponobject(watcher, player);
    player.var_efc40536 = self;
    self setowner(player);
    self setteam(player.team);
    self.owner = player;
    self playloopsound("fly_acoustic_sensor_lp");
    if (!self util::ishacked()) {
        player addweaponstat(self.weapon, "used", 1);
    }
    self thread watchshutdown(player, self.origin);
}

// Namespace namespace_efc40536/namespace_efc40536
// Params 3, eflags: 0x0
// Checksum 0xf4e48abc, Offset: 0x510
// Size: 0x10c
function function_46660dce(attacker, weapon, target) {
    if (!isdefined(weapon) || !weapon.isemp) {
        playfx(level._equipment_explode_fx, self.origin);
    }
    if (isdefined(attacker)) {
        if (self.owner util::isenemyplayer(attacker)) {
            attacker challenges::destroyedequipment(weapon);
            scoreevents::processscoreevent("destroyed_motion_sensor", attacker, self.owner, weapon);
        }
    }
    playsoundatposition("dst_equipment_destroy", self.origin);
    self destroyent();
}

// Namespace namespace_efc40536/namespace_efc40536
// Params 0, eflags: 0x0
// Checksum 0x9fe736bd, Offset: 0x628
// Size: 0x1c
function destroyent() {
    self delete();
}

// Namespace namespace_efc40536/namespace_efc40536
// Params 2, eflags: 0x0
// Checksum 0x73a448f1, Offset: 0x650
// Size: 0x42
function watchshutdown(player, origin) {
    self waittill("death", "hacked");
    if (isdefined(player)) {
        player.var_efc40536 = undefined;
    }
}

// Namespace namespace_efc40536/namespace_efc40536
// Params 1, eflags: 0x0
// Checksum 0xdf103130, Offset: 0x6a0
// Size: 0x3ca
function function_1e59bb1a(watcher) {
    self endon(#"death");
    self endon(#"hacked");
    self setcandamage(1);
    damagemax = 100;
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
        if (level.teambased && attacker.team == self.owner.team && attacker != self.owner) {
            continue;
        }
        if (watcher.stuntime > 0 && weapon.var_b9c80e3b) {
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
        if (isplayer(attacker) && level.teambased && isdefined(attacker.team) && self.owner.team == attacker.team && attacker != self.owner) {
            continue;
        }
        if (type == "MOD_MELEE" || weapon.isemp) {
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

