#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\table_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_attackables;

// Namespace zm_attackables/zm_attackables
// Params 0, eflags: 0x2
// Checksum 0xb05cb9c6, Offset: 0x168
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_attackables", &__init__, &__main__, undefined);
}

// Namespace zm_attackables/zm_attackables
// Params 0, eflags: 0x0
// Checksum 0x8994c776, Offset: 0x1b8
// Size: 0x182
function __init__() {
    level.attackablecallback = &attackable_callback;
    level.attackables = struct::get_array("scriptbundle_attackables", "classname");
    foreach (attackable in level.attackables) {
        attackable.bundle = struct::get_script_bundle("attackables", attackable.scriptbundlename);
        if (isdefined(attackable.target)) {
            attackable.slot = struct::get_array(attackable.target, "targetname");
        }
        attackable.is_active = 0;
        attackable.health = attackable.bundle.max_health;
        if (getdvarint(#"zm_attackables", 0) > 0) {
            attackable.is_active = 1;
            attackable.health = 1000;
        }
    }
}

// Namespace zm_attackables/zm_attackables
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x348
// Size: 0x4
function __main__() {
    
}

// Namespace zm_attackables/zm_attackables
// Params 0, eflags: 0x0
// Checksum 0x89a087fe, Offset: 0x358
// Size: 0x14a
function get_attackable() {
    foreach (attackable in level.attackables) {
        if (!(isdefined(attackable.is_active) && attackable.is_active)) {
            continue;
        }
        dist = distance(self.origin, attackable.origin);
        if (dist < attackable.bundle.aggro_distance) {
            if (attackable get_attackable_slot(self)) {
                return attackable;
            }
        }
        /#
            if (getdvarint(#"zm_attackables", 0) > 1) {
                if (attackable get_attackable_slot(self)) {
                    return attackable;
                }
            }
        #/
    }
    return undefined;
}

// Namespace zm_attackables/zm_attackables
// Params 1, eflags: 0x0
// Checksum 0xf57c0d55, Offset: 0x4b0
// Size: 0xba
function get_attackable_slot(entity) {
    self clear_slots();
    foreach (slot in self.slot) {
        if (!isdefined(slot.entity)) {
            slot.entity = entity;
            entity.attackable_slot = slot;
            return true;
        }
    }
    return false;
}

// Namespace zm_attackables/zm_attackables
// Params 0, eflags: 0x4
// Checksum 0x5cbd56e, Offset: 0x578
// Size: 0xce
function private clear_slots() {
    foreach (slot in self.slot) {
        if (!isalive(slot.entity)) {
            slot.entity = undefined;
            continue;
        }
        if (isdefined(slot.entity.missinglegs) && slot.entity.missinglegs) {
            slot.entity = undefined;
        }
    }
}

// Namespace zm_attackables/zm_attackables
// Params 0, eflags: 0x0
// Checksum 0x6c04bab0, Offset: 0x650
// Size: 0x3a
function activate() {
    self.is_active = 1;
    if (self.health <= 0) {
        self.health = self.bundle.max_health;
    }
}

// Namespace zm_attackables/zm_attackables
// Params 0, eflags: 0x0
// Checksum 0x5372923c, Offset: 0x698
// Size: 0xe
function deactivate() {
    self.is_active = 0;
}

// Namespace zm_attackables/zm_attackables
// Params 1, eflags: 0x0
// Checksum 0xe6e5caac, Offset: 0x6b0
// Size: 0x84
function do_damage(damage) {
    self.health -= damage;
    self notify(#"attackable_damaged");
    if (self.health <= 0) {
        self notify(#"attackable_deactivated");
        if (!(isdefined(self.b_deferred_deactivation) && self.b_deferred_deactivation)) {
            self deactivate();
        }
    }
}

// Namespace zm_attackables/zm_attackables
// Params 1, eflags: 0x0
// Checksum 0xfc5e899, Offset: 0x740
// Size: 0x94
function attackable_callback(entity) {
    if (entity.archetype === "thrasher" && (self.scriptbundlename === "zm_island_trap_plant_attackable" || self.scriptbundlename === "zm_island_trap_plant_upgraded_attackable")) {
        self do_damage(self.health);
        return;
    }
    self do_damage(entity.meleeweapon.meleedamage);
}

