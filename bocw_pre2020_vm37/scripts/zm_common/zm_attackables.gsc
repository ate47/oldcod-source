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
// Params 0, eflags: 0x6
// Checksum 0x9f0d84a, Offset: 0x168
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"zm_attackables", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_attackables/zm_attackables
// Params 0, eflags: 0x5 linked
// Checksum 0x1a501498, Offset: 0x1c0
// Size: 0x176
function private function_70a657d8() {
    level.attackablecallback = &attackable_callback;
    level.attackables = struct::get_array("scriptbundle_attackables", "classname");
    foreach (attackable in level.attackables) {
        attackable.bundle = getscriptbundle(attackable.scriptbundlename);
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
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x340
// Size: 0x4
function private postinit() {
    
}

// Namespace zm_attackables/zm_attackables
// Params 0, eflags: 0x0
// Checksum 0x18db2097, Offset: 0x350
// Size: 0x14a
function get_attackable() {
    foreach (attackable in level.attackables) {
        if (!is_true(attackable.is_active)) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0x3b8e4154, Offset: 0x4a8
// Size: 0xc2
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
// Params 0, eflags: 0x5 linked
// Checksum 0xa82c1629, Offset: 0x578
// Size: 0xd6
function private clear_slots() {
    foreach (slot in self.slot) {
        if (!isalive(slot.entity)) {
            slot.entity = undefined;
            continue;
        }
        if (is_true(slot.entity.missinglegs)) {
            slot.entity = undefined;
        }
    }
}

// Namespace zm_attackables/zm_attackables
// Params 0, eflags: 0x0
// Checksum 0x62d205eb, Offset: 0x658
// Size: 0x3a
function activate() {
    self.is_active = 1;
    if (self.health <= 0) {
        self.health = self.bundle.max_health;
    }
}

// Namespace zm_attackables/zm_attackables
// Params 0, eflags: 0x1 linked
// Checksum 0x5100627b, Offset: 0x6a0
// Size: 0xe
function deactivate() {
    self.is_active = 0;
}

// Namespace zm_attackables/zm_attackables
// Params 1, eflags: 0x1 linked
// Checksum 0x36d839d5, Offset: 0x6b8
// Size: 0x84
function do_damage(damage) {
    self.health -= damage;
    self notify(#"attackable_damaged");
    if (self.health <= 0) {
        self notify(#"attackable_deactivated");
        if (!is_true(self.b_deferred_deactivation)) {
            self deactivate();
        }
    }
}

// Namespace zm_attackables/zm_attackables
// Params 1, eflags: 0x1 linked
// Checksum 0x1341d45c, Offset: 0x748
// Size: 0x94
function attackable_callback(entity) {
    if (entity.archetype === "thrasher" && (self.scriptbundlename === "zm_island_trap_plant_attackable" || self.scriptbundlename === "zm_island_trap_plant_upgraded_attackable")) {
        self do_damage(self.health);
        return;
    }
    self do_damage(entity.meleeweapon.meleedamage);
}

