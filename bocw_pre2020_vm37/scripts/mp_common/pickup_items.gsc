#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapons;

#namespace pickup_items;

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x6
// Checksum 0xea48b155, Offset: 0x188
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"pickup_items", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x4
// Checksum 0x38cfea80, Offset: 0x1d0
// Size: 0x90
function private function_70a657d8() {
    callback::on_start_gametype(&start_gametype);
    level.nullprimaryoffhand = getweapon(#"null_offhand_primary");
    level.nullsecondaryoffhand = getweapon(#"null_offhand_secondary");
    level.pickup_items = [];
    level.pickupitemrespawn = 1;
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0xe1c76413, Offset: 0x268
// Size: 0x16
function on_player_spawned() {
    self.pickup_damage_scale = undefined;
    self.pickup_damage_scale_time = undefined;
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0x9876f321, Offset: 0x288
// Size: 0x1f0
function start_gametype() {
    callback::on_spawned(&on_player_spawned);
    pickup_triggers = getentarray("pickup_item", "targetname");
    pickup_models = getentarray("pickup_model", "targetname");
    visuals = [];
    foreach (trigger in pickup_triggers) {
        visuals[0] = get_visual_for_trigger(trigger, pickup_models);
        assert(isdefined(visuals[0]));
        visuals[0] pickup_item_init();
        pickup_item_object = gameobjects::create_use_object(#"neutral", trigger, visuals, (0, 0, 0), #"pickup_item");
        pickup_item_object gameobjects::allow_use(#"hash_5ccfd7bbbf07c770");
        pickup_item_object gameobjects::set_use_time(0);
        pickup_item_object.onuse = &on_touch;
        level.pickup_items[level.pickup_items.size] = pickup_item_object;
    }
}

// Namespace pickup_items/pickup_items
// Params 2, eflags: 0x0
// Checksum 0xbcadedc0, Offset: 0x480
// Size: 0xa2
function get_visual_for_trigger(trigger, pickup_models) {
    foreach (model in pickup_models) {
        if (model istouchingswept(trigger)) {
            return model;
        }
    }
    return undefined;
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0x384455f6, Offset: 0x530
// Size: 0x24
function set_pickup_bobbing() {
    self bobbing((0, 0, 1), 4, 1);
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0xc9a05edf, Offset: 0x560
// Size: 0x24
function set_pickup_rotation() {
    self rotate((0, 175, 0));
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0x7a0dfcc3, Offset: 0x590
// Size: 0x82
function get_item_for_pickup() {
    if (self.items.size == 1) {
        return self.items[0];
    }
    if (self.items_shuffle.size == 0) {
        self.items_shuffle = arraycopy(self.items);
        array::randomize(self.items_shuffle);
    }
    return array::pop_front(self.items_shuffle);
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0x8e6518e8, Offset: 0x620
// Size: 0x5c
function cycle_item() {
    self.current_item = self get_item_for_pickup();
    if (isdefined(self.current_item.model)) {
        self setmodel(self.current_item.model);
    }
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0x68d39166, Offset: 0x688
// Size: 0xa0
function get_item_from_string_ammo(*perks_string) {
    item_struct = spawnstruct();
    item_struct.name = "ammo";
    item_struct.weapon = getweapon(#"scavenger_item");
    item_struct.model = item_struct.weapon.worldmodel;
    self.angles = (0, 0, 90);
    self thread weapons::scavenger_think();
    return item_struct;
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0xab414b1, Offset: 0x730
// Size: 0x98
function get_item_from_string_damage(perks_string) {
    item_struct = spawnstruct();
    item_struct.name = "damage";
    item_struct.damage_scale = float(perks_string);
    item_struct.model = "wpn_t7_igc_bullet_prop";
    self.angles = (-45, 0, 0);
    self setscale(2);
    return item_struct;
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0xe96e1990, Offset: 0x7d0
// Size: 0x98
function get_item_from_string_health(perks_string) {
    item_struct = spawnstruct();
    item_struct.name = "health";
    item_struct.extra_health = int(perks_string);
    item_struct.model = "p7_medical_surgical_tools_syringe";
    self.angles = (-45, 0, 45);
    self setscale(5);
    return item_struct;
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0x2ef5570d, Offset: 0x870
// Size: 0xe8
function get_item_from_string_perk(perks_string) {
    item_struct = spawnstruct();
    if (!isdefined(level.perkspecialties[perks_string])) {
        /#
            util::error("<dev string:x38>" + perks_string + "<dev string:x4e>" + self.origin);
        #/
        return;
    }
    item_struct.name = perks_string;
    item_struct.specialties = strtok(level.perkspecialties[perks_string], "|");
    item_struct.model = "p7_perk_" + level.perkicons[perks_string];
    self setscale(2);
    return item_struct;
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0x170b6d28, Offset: 0x960
// Size: 0x100
function get_item_from_string_weapon(weapon_and_attachments_string) {
    item_struct = spawnstruct();
    weapon_and_attachments = strtok(weapon_and_attachments_string, "+");
    weapon_name = getsubstr(weapon_and_attachments[0], 0, weapon_and_attachments[0].size);
    attachments = array::remove_index(weapon_and_attachments, 0);
    item_struct.name = weapon_name;
    item_struct.weapon = getweapon(weapon_name, attachments);
    item_struct.model = item_struct.weapon.worldmodel;
    self setscale(1.5);
    return item_struct;
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0x739dbd5f, Offset: 0xa68
// Size: 0xea
function get_item_from_string(item_string) {
    switch (self.script_noteworthy) {
    case #"ammo":
        return self get_item_from_string_ammo(item_string);
    case #"damage":
        return self get_item_from_string_damage(item_string);
    case #"health":
        return self get_item_from_string_health(item_string);
    case #"perk":
        return self get_item_from_string_perk(item_string);
    case #"weapon":
        return self get_item_from_string_weapon(item_string);
    }
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0x9b661e39, Offset: 0xb60
// Size: 0xde
function init_items_for_pickup() {
    items_string = self.script_parameters;
    items_array = strtok(items_string, " ");
    items = [];
    foreach (item_string in items_array) {
        items[items.size] = self get_item_from_string(item_string);
    }
    return items;
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0x54d07993, Offset: 0xc48
// Size: 0x8a
function pickup_item_respawn_time() {
    switch (self.script_noteworthy) {
    case #"ammo":
        return 10;
    case #"damage":
        return 60;
    case #"health":
        return 10;
    case #"perk":
        return 10;
    case #"weapon":
        return 30;
    }
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0x6bac0f0e, Offset: 0xce0
// Size: 0x92
function pickup_item_sound_pickup() {
    switch (self.script_noteworthy) {
    case #"ammo":
        return "wpn_ammo_pickup_oldschool";
    case #"damage":
        return "wpn_weap_pickup_oldschool";
    case #"health":
        return "wpn_weap_pickup_oldschool";
    case #"perk":
        return "wpn_weap_pickup_oldschool";
    case #"weapon":
        return "wpn_weap_pickup_oldschool";
    }
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0xcd4f3219, Offset: 0xd80
// Size: 0x92
function pickup_item_sound_respawn() {
    switch (self.script_noteworthy) {
    case #"ammo":
        return "wpn_ammo_pickup_oldschool";
    case #"damage":
        return "wpn_weap_pickup_oldschool";
    case #"health":
        return "wpn_weap_pickup_oldschool";
    case #"perk":
        return "wpn_weap_pickup_oldschool";
    case #"weapon":
        return "wpn_weap_pickup_oldschool";
    }
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0xbbda702a, Offset: 0xe20
// Size: 0xb4
function pickup_item_init() {
    self.items_shuffle = [];
    self set_pickup_bobbing();
    self.items = self init_items_for_pickup();
    self.respawn_time = self pickup_item_respawn_time();
    self.sound_pickup = self pickup_item_sound_pickup();
    self.sound_respawn = self pickup_item_sound_respawn();
    self set_pickup_rotation();
    self cycle_item();
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0xfede6050, Offset: 0xee0
// Size: 0x1cc
function on_touch(player) {
    self endon(#"respawned");
    pickup_item = self.visuals[0];
    switch (pickup_item.script_noteworthy) {
    case #"ammo":
        pickup_item on_touch_ammo(player);
        break;
    case #"damage":
        pickup_item on_touch_damage(player);
        break;
    case #"health":
        pickup_item on_touch_health(player);
        break;
    case #"perk":
        pickup_item on_touch_perk(player);
        break;
    case #"weapon":
        if (!pickup_item on_touch_weapon(player)) {
            return;
        }
        break;
    }
    pickup_item playsound(pickup_item.sound_pickup);
    self gameobjects::set_model_visibility(0);
    self gameobjects::allow_use(#"hash_161f03feaadc9b8f");
    if (level.pickupitemrespawn) {
        wait pickup_item.respawn_time;
        self thread respawn_pickup();
    }
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0x8a6b1ca9, Offset: 0x10b8
// Size: 0x9c
function respawn_pickup() {
    self notify(#"respawned");
    pickup_item = self.visuals[0];
    pickup_item playsound(pickup_item.sound_respawn);
    pickup_item cycle_item();
    self gameobjects::set_model_visibility(1);
    self gameobjects::allow_use(#"hash_5ccfd7bbbf07c770");
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0xe4a10546, Offset: 0x1160
// Size: 0x88
function respawn_all_pickups() {
    foreach (item in level.pickup_items) {
        item respawn_pickup();
    }
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0x33f4d294, Offset: 0x11f0
// Size: 0x4c
function on_touch_ammo(player) {
    self notify(#"scavenger", {#player:player});
    player pickupammoevent();
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0xb06800f5, Offset: 0x1248
// Size: 0x5e
function on_touch_damage(player) {
    damage_scale_length = int(15 * 1000);
    player.pickup_damage_scale = self.current_item.damage_scale;
    player.pickup_damage_scale_time = gettime() + damage_scale_length;
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0x61005c82, Offset: 0x12b0
// Size: 0x82
function on_touch_health(player) {
    if (self.current_item.extra_health <= 100) {
        health = player.health + self.current_item.extra_health;
        if (health > 100) {
            health = 100;
        }
    } else {
        health = self.current_item.extra_health;
    }
    player.health = health;
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0x6a9e4c64, Offset: 0x1340
// Size: 0x98
function on_touch_perk(player) {
    foreach (specialty in self.current_item.specialties) {
        player setperk(specialty);
    }
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0xa131286e, Offset: 0x13e0
// Size: 0x112
function has_active_gadget() {
    weapons = self getweaponslist(1);
    foreach (weapon in weapons) {
        if (!weapon.isgadget) {
            continue;
        }
        if (!weapon.isheavyweapon && weapon.offhandslot !== "Gadget") {
            continue;
        }
        slot = self gadgetgetslot(weapon);
        if (self gadgetisactive(slot)) {
            return true;
        }
    }
    return false;
}

// Namespace pickup_items/pickup_items
// Params 0, eflags: 0x0
// Checksum 0x346ac6a6, Offset: 0x1500
// Size: 0xb8
function take_player_gadgets() {
    weapons = self getweaponslist(1);
    foreach (weapon in weapons) {
        if (weapon.isgadget) {
            self takeweapon(weapon);
        }
    }
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0x1095782e, Offset: 0x15c0
// Size: 0xc2
function take_offhand_weapon(offhandslot) {
    weapons = self getweaponslist(1);
    foreach (weapon in weapons) {
        if (weapon.offhandslot == offhandslot) {
            self takeweapon(weapon);
            return;
        }
    }
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0xa865c310, Offset: 0x1690
// Size: 0x32
function should_switch_to_pickup_weapon(weapon) {
    if (weapon.isgadget) {
        return false;
    }
    if (weapon.isgrenadeweapon) {
        return false;
    }
    return true;
}

// Namespace pickup_items/pickup_items
// Params 1, eflags: 0x0
// Checksum 0x3219de38, Offset: 0x16d0
// Size: 0x260
function on_touch_weapon(player) {
    weapon = self.current_item.weapon;
    had_weapon = player hasweapon(weapon);
    ammo_in_reserve = player getweaponammostock(weapon);
    if (weapon.isgadget) {
        if (player has_active_gadget()) {
            return false;
        }
        player take_player_gadgets();
    }
    if (weapon.inventorytype == "offhand") {
        player take_offhand_weapon(weapon.offhandslot);
    }
    player pickupweaponevent(weapon);
    player giveweapon(weapon);
    if (!player hasweapon(weapon)) {
        return false;
    }
    if (isdefined(self.script_ammo_clip) && isdefined(self.script_ammo_extra)) {
        if (had_weapon) {
            player setweaponammostock(weapon, ammo_in_reserve + self.script_ammo_clip + self.script_ammo_extra);
        } else {
            if (self.script_ammo_clip >= 0) {
                player setweaponammoclip(weapon, self.script_ammo_clip);
            }
            if (self.script_ammo_extra >= 0) {
                player setweaponammostock(weapon, self.script_ammo_extra);
            }
        }
    }
    if (weapon.isgadget) {
        slot = player gadgetgetslot(weapon);
        player gadgetpowerset(slot, 100);
    }
    if (!had_weapon && should_switch_to_pickup_weapon(weapon)) {
        player switchtoweapon(weapon);
    }
    return true;
}

