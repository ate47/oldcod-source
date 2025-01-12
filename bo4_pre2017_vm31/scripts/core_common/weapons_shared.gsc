#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weapons;

#namespace weapons;

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x6ed9a268, Offset: 0x160
// Size: 0x4e
function is_primary_weapon(weapon) {
    root_weapon = weapon.rootweapon;
    return root_weapon != level.weaponnone && isdefined(level.primary_weapon_array[root_weapon]);
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x7ec593d1, Offset: 0x1b8
// Size: 0x4e
function is_side_arm(weapon) {
    root_weapon = weapon.rootweapon;
    return root_weapon != level.weaponnone && isdefined(level.side_arm_array[root_weapon]);
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x706e0a65, Offset: 0x210
// Size: 0x4e
function is_inventory(weapon) {
    root_weapon = weapon.rootweapon;
    return root_weapon != level.weaponnone && isdefined(level.inventory_array[root_weapon]);
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x1418c061, Offset: 0x268
// Size: 0x4e
function is_grenade(weapon) {
    root_weapon = weapon.rootweapon;
    return root_weapon != level.weaponnone && isdefined(level.grenade_array[root_weapon]);
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0x92a31939, Offset: 0x2c0
// Size: 0x34
function force_stowed_weapon_update() {
    detach_all_weapons();
    stow_on_back();
    stow_on_hip();
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0x2f296e68, Offset: 0x300
// Size: 0x6e
function detach_carry_object_model() {
    if (isdefined(self.carryobject) && isdefined(self.carryobject gameobjects::get_visible_carrier_model())) {
        if (isdefined(self.tag_stowed_back)) {
            self detach(self.tag_stowed_back, "tag_stowed_back");
            self.tag_stowed_back = undefined;
        }
    }
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0xcb726104, Offset: 0x378
// Size: 0x13e
function detach_all_weapons() {
    if (isdefined(self.tag_stowed_back)) {
        clear_weapon = 1;
        if (isdefined(self.carryobject)) {
            carriermodel = self.carryobject gameobjects::get_visible_carrier_model();
            if (isdefined(carriermodel) && carriermodel == self.tag_stowed_back) {
                self detach(self.tag_stowed_back, "tag_stowed_back");
                clear_weapon = 0;
            }
        }
        if (clear_weapon) {
            self clearstowedweapon();
        }
        self.tag_stowed_back = undefined;
    } else {
        self clearstowedweapon();
    }
    if (isdefined(self.tag_stowed_hip)) {
        detach_model = self.tag_stowed_hip.worldmodel;
        self detach(detach_model, "tag_stowed_hip_rear");
        self.tag_stowed_hip = undefined;
    }
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0xf569d022, Offset: 0x4c0
// Size: 0x29c
function stow_on_back(current) {
    currentweapon = self getcurrentweapon();
    currentaltweapon = currentweapon.altweapon;
    self.tag_stowed_back = undefined;
    weaponoptions = 0;
    index_weapon = level.weaponnone;
    if (isdefined(self.carryobject) && isdefined(self.carryobject gameobjects::get_visible_carrier_model())) {
        self.tag_stowed_back = self.carryobject gameobjects::get_visible_carrier_model();
        self attach(self.tag_stowed_back, "tag_stowed_back", 1);
        return;
    } else if (currentweapon != level.weaponnone) {
        for (idx = 0; idx < self.weapon_array_primary.size; idx++) {
            temp_index_weapon = self.weapon_array_primary[idx];
            assert(isdefined(temp_index_weapon), "<dev string:x28>");
            if (temp_index_weapon == currentweapon) {
                continue;
            }
            if (temp_index_weapon == currentaltweapon) {
                continue;
            }
            if (temp_index_weapon.nonstowedweapon) {
                continue;
            }
            index_weapon = temp_index_weapon;
        }
        if (index_weapon == level.weaponnone) {
            for (idx = 0; idx < self.weapon_array_sidearm.size; idx++) {
                temp_index_weapon = self.weapon_array_sidearm[idx];
                assert(isdefined(temp_index_weapon), "<dev string:x47>");
                if (temp_index_weapon == currentweapon) {
                    continue;
                }
                if (temp_index_weapon == currentaltweapon) {
                    continue;
                }
                if (temp_index_weapon.nonstowedweapon) {
                    continue;
                }
                index_weapon = temp_index_weapon;
            }
        }
    }
    self setstowedweapon(index_weapon);
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0x4aede095, Offset: 0x768
// Size: 0xfc
function stow_on_hip() {
    currentweapon = self getcurrentweapon();
    self.tag_stowed_hip = undefined;
    for (idx = 0; idx < self.weapon_array_inventory.size; idx++) {
        if (self.weapon_array_inventory[idx] == currentweapon) {
            continue;
        }
        if (!self getweaponammostock(self.weapon_array_inventory[idx])) {
            continue;
        }
        self.tag_stowed_hip = self.weapon_array_inventory[idx];
    }
    if (!isdefined(self.tag_stowed_hip)) {
        return;
    }
    self attach(self.tag_stowed_hip.worldmodel, "tag_stowed_hip_rear", 1);
}

// Namespace weapons/weapons_shared
// Params 4, eflags: 0x0
// Checksum 0x68bacae9, Offset: 0x870
// Size: 0x62
function weapondamagetracepassed(from, to, startradius, ignore) {
    trace = weapondamagetrace(from, to, startradius, ignore);
    return trace["fraction"] == 1;
}

// Namespace weapons/weapons_shared
// Params 4, eflags: 0x0
// Checksum 0x64216ac2, Offset: 0x8e0
// Size: 0x1e0
function weapondamagetrace(from, to, startradius, ignore) {
    midpos = undefined;
    diff = to - from;
    if (lengthsquared(diff) < startradius * startradius) {
        midpos = to;
    }
    dir = vectornormalize(diff);
    midpos = from + (dir[0] * startradius, dir[1] * startradius, dir[2] * startradius);
    trace = bullettrace(midpos, to, 0, ignore);
    if (getdvarint("scr_damage_debug") != 0) {
        if (trace["fraction"] == 1) {
            thread debugline(midpos, to, (1, 1, 1));
        } else {
            thread debugline(midpos, trace["position"], (1, 0.9, 0.8));
            thread debugline(trace["position"], to, (1, 0.4, 0.3));
        }
    }
    return trace;
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0xbcd4c9a7, Offset: 0xac8
// Size: 0x40
function has_lmg() {
    weapon = self getcurrentweapon();
    return weapon.weapclass == "mg";
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0xb868d6f4, Offset: 0xb10
// Size: 0x36
function has_launcher() {
    weapon = self getcurrentweapon();
    return weapon.isrocketlauncher;
}

// Namespace weapons/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0xdccad265, Offset: 0xb50
// Size: 0x36
function has_heavy_weapon() {
    weapon = self getcurrentweapon();
    return weapon.isheavyweapon;
}

// Namespace weapons/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0xf01cac3a, Offset: 0xb90
// Size: 0x6e
function has_lockon(target) {
    player = self;
    clientnum = player getentitynumber();
    return isdefined(target.locked_on) && target.locked_on & 1 << clientnum;
}

