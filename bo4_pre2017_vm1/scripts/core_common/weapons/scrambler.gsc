#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace scrambler;

// Namespace scrambler/scrambler
// Params 0, eflags: 0x0
// Checksum 0x4a0f0c34, Offset: 0x268
// Size: 0xd4
function init_shared() {
    level._effect["scrambler_enemy_light"] = "_t6/misc/fx_equip_light_red";
    level._effect["scrambler_friendly_light"] = "_t6/misc/fx_equip_light_green";
    level.var_46ae24da = getweapon("scrambler");
    level.var_cbb5d4be = 30;
    level.var_e30750d9 = 1000000;
    level.var_261f70bc = 360000;
    clientfield::register("missile", "scrambler", 1, 1, "int");
}

// Namespace scrambler/scrambler
// Params 0, eflags: 0x0
// Checksum 0xc837e29f, Offset: 0x348
// Size: 0xc0
function function_d01280e2() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("scrambler", self.team);
    watcher.onspawn = &function_fd7f52d0;
    watcher.ondetonatecallback = &function_5bf68b8a;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 5;
    watcher.hackable = 1;
    watcher.ondamage = &function_b8f94770;
}

// Namespace scrambler/scrambler
// Params 2, eflags: 0x0
// Checksum 0xf24b6853, Offset: 0x410
// Size: 0x12c
function function_fd7f52d0(watcher, player) {
    player endon(#"disconnect");
    self endon(#"death");
    self thread weaponobjects::onspawnuseweaponobject(watcher, player);
    player.scrambler = self;
    self setowner(player);
    self setteam(player.team);
    self.owner = player;
    self clientfield::set("scrambler", 1);
    if (!self util::ishacked()) {
        player addweaponstat(self.weapon, "used", 1);
    }
    self thread watchshutdown(player);
    level notify(#"hash_8f3f45d2");
}

// Namespace scrambler/scrambler
// Params 3, eflags: 0x0
// Checksum 0x52b464f2, Offset: 0x548
// Size: 0xdc
function function_5bf68b8a(attacker, weapon, target) {
    if (!isdefined(weapon) || !weapon.isemp) {
        playfx(level._equipment_explode_fx, self.origin);
    }
    if (self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedequipment(weapon);
    }
    playsoundatposition("dst_equipment_destroy", self.origin);
    self delete();
}

// Namespace scrambler/scrambler
// Params 1, eflags: 0x0
// Checksum 0x1836d03c, Offset: 0x630
// Size: 0x46
function watchshutdown(player) {
    self waittill("death", "hacked");
    level notify(#"hash_2c016435");
    if (isdefined(player)) {
        player.scrambler = undefined;
    }
}

// Namespace scrambler/scrambler
// Params 0, eflags: 0x0
// Checksum 0x2834dec4, Offset: 0x680
// Size: 0x1c
function destroyent() {
    self delete();
}

// Namespace scrambler/scrambler
// Params 1, eflags: 0x0
// Checksum 0xea304d67, Offset: 0x6a8
// Size: 0x3c8
function function_b8f94770(watcher) {
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
        type = waitresult.mod;
        damage = waitresult.amount;
        weapon = waitresult.weapon;
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        if (level.teambased && attacker.team == self.owner.team && attacker != self.owner) {
            continue;
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
        }
    }
}

// Namespace scrambler/scrambler
// Params 2, eflags: 0x0
// Checksum 0xe3357711, Offset: 0xa78
// Size: 0x88
function function_a1969e7f(var_4bab063, var_92b34128) {
    if (!level.teambased) {
        return false;
    }
    if (!isdefined(var_4bab063) || !isdefined(var_92b34128)) {
        return false;
    }
    if (!isdefined(var_4bab063.team) || !isdefined(var_92b34128.team)) {
        return false;
    }
    return var_4bab063.team == var_92b34128.team;
}

// Namespace scrambler/scrambler
// Params 0, eflags: 0x0
// Checksum 0xff6860d6, Offset: 0xb08
// Size: 0x1ae
function function_ec2ed838() {
    scramblers = getentarray("grenade", "classname");
    if (isdefined(self.name) && self.name == "scrambler") {
        return false;
    }
    for (i = 0; i < scramblers.size; i++) {
        scrambler = scramblers[i];
        if (!isalive(scrambler)) {
            continue;
        }
        if (!isdefined(scrambler.name)) {
            continue;
        }
        if (scrambler.name != "scrambler") {
            continue;
        }
        if (function_a1969e7f(self.owner, scrambler.owner)) {
            continue;
        }
        flattenedselforigin = (self.origin[0], self.origin[1], 0);
        var_3c689c3d = (scrambler.origin[0], scrambler.origin[1], 0);
        if (distancesquared(flattenedselforigin, var_3c689c3d) < level.var_e30750d9) {
            return true;
        }
    }
    return false;
}

