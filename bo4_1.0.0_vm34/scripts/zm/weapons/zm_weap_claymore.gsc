#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\proximity_grenade;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_claymore;

// Namespace zm_weap_claymore/zm_weap_claymore
// Params 0, eflags: 0x2
// Checksum 0x7fd4d109, Offset: 0x140
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"claymore_zm", &__init__, undefined, undefined);
}

// Namespace zm_weap_claymore/zm_weap_claymore
// Params 0, eflags: 0x0
// Checksum 0xb2c98195, Offset: 0x188
// Size: 0x54
function __init__() {
    weaponobjects::function_f298eae6("claymore", &createclaymorewatcher, 0);
    weaponobjects::function_f298eae6("claymore_extra", &createclaymorewatcher, 0);
}

// Namespace zm_weap_claymore/zm_weap_claymore
// Params 1, eflags: 0x0
// Checksum 0xf57cbd03, Offset: 0x1e8
// Size: 0x19e
function createclaymorewatcher(watcher) {
    watcher.watchforfire = 1;
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = undefined;
    watcher.immediatedetonation = 1;
    watcher.immunespecialty = "specialty_immunetriggerbetty";
    watcher.deleteonplayerspawn = 0;
    watcher.detectiondot = cos(70);
    watcher.detectionmindist = 10;
    watcher.detectiongraceperiod = 0.3;
    watcher.detonateradius = 100;
    watcher.stuntime = 1;
    watcher.ondetonatecallback = &proximitydetonate;
    watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
    watcher.onspawn = &function_daea5bd3;
    watcher.stun = &weaponobjects::weaponstun;
    watcher.var_46869d39 = &function_9f078ba7;
}

// Namespace zm_weap_claymore/zm_weap_claymore
// Params 3, eflags: 0x0
// Checksum 0xb3970662, Offset: 0x390
// Size: 0x4c
function proximitydetonate(attacker, weapon, target) {
    self thread function_cc8d6713(attacker, weapon);
    self weaponobjects::weapondetonate(attacker, weapon);
}

// Namespace zm_weap_claymore/zm_weap_claymore
// Params 2, eflags: 0x0
// Checksum 0x955f23c1, Offset: 0x3e8
// Size: 0x64
function function_cc8d6713(attacker, weapon) {
    radiusdamage(self.origin, 64, self.weapon.explosioninnerdamage, self.weapon.explosionouterdamage, attacker, "MOD_EXPLOSIVE", self.weapon);
}

// Namespace zm_weap_claymore/zm_weap_claymore
// Params 1, eflags: 0x0
// Checksum 0xb3900548, Offset: 0x458
// Size: 0x24
function function_9f078ba7(player) {
    self weaponobjects::weaponobjectfizzleout();
}

// Namespace zm_weap_claymore/zm_weap_claymore
// Params 2, eflags: 0x0
// Checksum 0x83b559c5, Offset: 0x488
// Size: 0x52
function function_daea5bd3(watcher, player) {
    proximity_grenade::onspawnproximitygrenadeweaponobject(watcher, player);
    self.weapon = getweapon(#"claymore");
}

// Namespace zm_weap_claymore/zm_weap_claymore
// Params 1, eflags: 0x0
// Checksum 0x50b5e2dc, Offset: 0x4e8
// Size: 0x34
function play_claymore_effects(e_planter) {
    self endon(#"death");
    self zm_utility::waittill_not_moving();
}

// Namespace zm_weap_claymore/zm_weap_claymore
// Params 1, eflags: 0x0
// Checksum 0x8595a426, Offset: 0x528
// Size: 0x382
function claymore_detonation(e_planter) {
    self endon(#"death");
    self zm_utility::waittill_not_moving();
    detonateradius = 96;
    damagearea = spawn("trigger_radius", self.origin, (512 | 1) + 8, detonateradius, detonateradius * 2);
    damagearea setexcludeteamfortrigger(self.owner.team);
    damagearea enablelinkto();
    damagearea linkto(self);
    if (isdefined(self.isonbus) && self.isonbus) {
        damagearea setmovingplatformenabled(1);
    }
    self.damagearea = damagearea;
    self thread delete_mines_on_death(self.owner, damagearea);
    if (!isdefined(self.owner.placeable_mines)) {
        self.owner.placeable_mines = [];
    } else if (!isarray(self.owner.placeable_mines)) {
        self.owner.placeable_mines = array(self.owner.placeable_mines);
    }
    self.owner.placeable_mines[self.owner.placeable_mines.size] = self;
    while (true) {
        waitresult = damagearea waittill(#"trigger");
        ent = waitresult.activator;
        if (isdefined(self.owner) && ent == self.owner) {
            continue;
        }
        if (isdefined(ent.pers) && isdefined(ent.pers[#"team"]) && ent.pers[#"team"] == self.team) {
            continue;
        }
        if (isdefined(ent.ignore_placeable_mine) && ent.ignore_placeable_mine) {
            continue;
        }
        if (!ent should_trigger_claymore(self)) {
            continue;
        }
        if (ent damageconetrace(self.origin, self) > 0) {
            self playsound(#"wpn_claymore_alert");
            wait 0.4;
            if (isdefined(self.owner)) {
                self detonate(self.owner);
                return;
            }
            self detonate(undefined);
            return;
        }
    }
}

// Namespace zm_weap_claymore/zm_weap_claymore
// Params 1, eflags: 0x4
// Checksum 0x24714a5c, Offset: 0x8b8
// Size: 0x118
function private should_trigger_claymore(e_mine) {
    n_detonation_dot = cos(70);
    pos = self.origin + (0, 0, 32);
    dirtopos = pos - e_mine.origin;
    objectforward = anglestoforward(e_mine.angles);
    dist = vectordot(dirtopos, objectforward);
    if (dist < 20) {
        return false;
    }
    dirtopos = vectornormalize(dirtopos);
    dot = vectordot(dirtopos, objectforward);
    return dot > n_detonation_dot;
}

// Namespace zm_weap_claymore/zm_weap_claymore
// Params 2, eflags: 0x4
// Checksum 0xdcd7e799, Offset: 0x9d8
// Size: 0x74
function private delete_mines_on_death(player, ent) {
    self waittill(#"death");
    if (isdefined(player)) {
        arrayremovevalue(player.placeable_mines, self);
    }
    waitframe(1);
    if (isdefined(ent)) {
        ent delete();
    }
}

