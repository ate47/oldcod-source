#using script_2cb831533cab2794;
#using scripts\abilities\ability_player;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_equipment;

// Namespace zm_equipment/zm_equipment
// Params 0, eflags: 0x2
// Checksum 0x774ba73d, Offset: 0x1c8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_equipment", &__init__, &__main__, undefined);
}

// Namespace zm_equipment/zm_equipment
// Params 0, eflags: 0x0
// Checksum 0xa3922ed2, Offset: 0x218
// Size: 0xae
function __init__() {
    level.buildable_piece_count = 24;
    /#
        level.abilities_devgui_add_gadgets_custom = &abilities_devgui_add_gadgets_custom;
    #/
    level.placeable_equipment_destroy_fn = [];
    if (!(isdefined(level._no_equipment_activated_clientfield) && level._no_equipment_activated_clientfield)) {
        clientfield::register("scriptmover", "equipment_activated", 1, 4, "int");
    }
    level.zm_hint_text = zm_hint_text::register("zm_hint_text");
}

// Namespace zm_equipment/zm_equipment
// Params 0, eflags: 0x0
// Checksum 0xd5e24d18, Offset: 0x2d0
// Size: 0x14
function __main__() {
    init_upgrade();
}

/#

    // Namespace zm_equipment/zm_equipment
    // Params 4, eflags: 0x0
    // Checksum 0xd4aec5c8, Offset: 0x2f0
    // Size: 0xd62
    function abilities_devgui_add_gadgets_custom(root, pname, pid, menu_index) {
        var_1b94d3d6 = "<dev string:x30>";
        add_cmd_with_root = "<dev string:x46>" + var_1b94d3d6 + pname + "<dev string:x52>";
        a_abilities = [];
        arrayinsert(a_abilities, getweapon(#"eq_frag_grenade"), 0);
        arrayinsert(a_abilities, getweapon(#"incendiary_grenade"), 0);
        arrayinsert(a_abilities, getweapon(#"sticky_grenade"), 0);
        arrayinsert(a_abilities, getweapon(#"proximity_grenade"), 0);
        arrayinsert(a_abilities, getweapon(#"incendiary_fire"), 0);
        arrayinsert(a_abilities, getweapon(#"concussion_grenade"), 0);
        arrayinsert(a_abilities, getweapon(#"flash_grenade"), 0);
        arrayinsert(a_abilities, getweapon(#"emp_grenade"), 0);
        arrayinsert(a_abilities, getweapon(#"cymbal_monkey"), 0);
        arrayinsert(a_abilities, getweapon(#"tesla_coil"), 0);
        arrayinsert(a_abilities, getweapon(#"tomahawk_t8"), 0);
        ability_player::function_2ebc3573(add_cmd_with_root, pid, a_abilities, "<dev string:x54>", menu_index);
        a_hero_weapons = [];
        arrayinsert(a_hero_weapons, getweapon(#"hero_gravityspikes"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_lightninggun"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_minigun"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_pineapplegun"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_chemicalgelgun"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_bowlauncher"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_armblade"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_annihilator"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_flamethrower"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_chakram_lv1"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_chakram_lv2"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_chakram_lv3"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_hammer_lv1"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_hammer_lv2"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_hammer_lv3"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_scepter_lv1"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_scepter_lv2"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_scepter_lv3"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_sword_pistol_lv1"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_sword_pistol_lv2"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_sword_pistol_lv3"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_chakram_lv1"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_chakram_lv2"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_chakram_lv3"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_hammer_lv1"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_hammer_lv2"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_hammer_lv3"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_scepter_lv1"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_scepter_lv2"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_scepter_lv3"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_sword_pistol_lv1"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_sword_pistol_lv2"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_sword_pistol_lv3"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_flamethrower_t8_lv1"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_flamethrower_t8_lv2"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_flamethrower_t8_lv3"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_gravityspikes_t8_lv1"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_gravityspikes_t8_lv2"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_gravityspikes_t8_lv3"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_katana_t8_lv1"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_katana_t8_lv2"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_katana_t8_lv3"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_minigun_t8_lv1"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_minigun_t8_lv2"), 0);
        arrayinsert(a_hero_weapons, getweapon(#"hero_minigun_t8_lv3"), 0);
        ability_player::function_e270d61e(add_cmd_with_root, pid, a_hero_weapons, "<dev string:x5e>", menu_index);
        menu_index++;
        menu_index = ability_player::abilities_devgui_add_power(add_cmd_with_root, pid, menu_index);
        menu_index = ability_player::function_cad495e7(add_cmd_with_root, pid, menu_index);
        adddebugcommand("<dev string:x6b>");
        return menu_index;
    }

#/

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xfe2dfba7, Offset: 0x1060
// Size: 0xc4
function signal_activated(val = 1) {
    if (isdefined(level._no_equipment_activated_clientfield) && level._no_equipment_activated_clientfield) {
        return;
    }
    self endon(#"death");
    self clientfield::set("equipment_activated", val);
    for (i = 0; i < 2; i++) {
        util::wait_network_frame();
    }
    self clientfield::set("equipment_activated", 0);
}

// Namespace zm_equipment/zm_equipment
// Params 5, eflags: 0x0
// Checksum 0x1dda4772, Offset: 0x1130
// Size: 0x1e4
function register(equipment_name, hint, howto_hint, hint_icon, equipmentvo) {
    equipment = getweapon(equipment_name);
    struct = spawnstruct();
    if (!isdefined(level.zombie_equipment)) {
        level.zombie_equipment = [];
    }
    struct.equipment = equipment;
    struct.hint = hint;
    struct.howto_hint = howto_hint;
    struct.hint_icon = hint_icon;
    struct.vox = equipmentvo;
    struct.triggers = [];
    struct.models = [];
    struct.notify_strings = spawnstruct();
    struct.notify_strings.activate = equipment.name + "_activate";
    struct.notify_strings.deactivate = equipment.name + "_deactivate";
    struct.notify_strings.taken = equipment.name + "_taken";
    struct.notify_strings.pickup = equipment.name + "_pickup";
    level.zombie_equipment[equipment] = struct;
    /#
        level thread function_de79cac6(equipment);
    #/
}

// Namespace zm_equipment/zm_equipment
// Params 2, eflags: 0x0
// Checksum 0xa562ac7, Offset: 0x1320
// Size: 0x2a
function register_slot_watcher_override(str_equipment, func_slot_watcher_override) {
    level.a_func_equipment_slot_watcher_override[str_equipment] = func_slot_watcher_override;
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x21a27a73, Offset: 0x1358
// Size: 0x66
function is_included(equipment) {
    if (!isdefined(level.zombie_include_equipment)) {
        return false;
    }
    if (isstring(equipment)) {
        equipment = getweapon(equipment);
    }
    return isdefined(level.zombie_include_equipment[equipment.rootweapon]);
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xacbd0319, Offset: 0x13c8
// Size: 0x52
function include(equipment_name) {
    if (!isdefined(level.zombie_include_equipment)) {
        level.zombie_include_equipment = [];
    }
    level.zombie_include_equipment[getweapon(equipment_name)] = 1;
}

// Namespace zm_equipment/zm_equipment
// Params 3, eflags: 0x0
// Checksum 0x53613c2d, Offset: 0x1428
// Size: 0xa6
function set_ammo_driven(equipment_name, start, refill_max_ammo = 0) {
    level.zombie_equipment[getweapon(equipment_name)].notake = 1;
    level.zombie_equipment[getweapon(equipment_name)].start_ammo = start;
    level.zombie_equipment[getweapon(equipment_name)].refill_max_ammo = refill_max_ammo;
}

// Namespace zm_equipment/zm_equipment
// Params 2, eflags: 0x0
// Checksum 0xd9653b53, Offset: 0x14d8
// Size: 0x94
function limit(equipment_name, limited) {
    if (!isdefined(level._limited_equipment)) {
        level._limited_equipment = [];
    }
    if (limited) {
        level._limited_equipment[level._limited_equipment.size] = getweapon(equipment_name);
        return;
    }
    arrayremovevalue(level._limited_equipment, getweapon(equipment_name), 0);
}

// Namespace zm_equipment/zm_equipment
// Params 0, eflags: 0x0
// Checksum 0x517d784e, Offset: 0x1578
// Size: 0x15e
function init_upgrade() {
    equipment_spawns = [];
    equipment_spawns = getentarray("zombie_equipment_upgrade", "targetname");
    for (i = 0; i < equipment_spawns.size; i++) {
        equipment_spawns[i].equipment = getweapon(equipment_spawns[i].zombie_equipment_upgrade);
        hint_string = get_hint(equipment_spawns[i].equipment);
        equipment_spawns[i] sethintstring(hint_string);
        equipment_spawns[i] setcursorhint("HINT_NOICON");
        equipment_spawns[i] usetriggerrequirelookat();
        equipment_spawns[i] add_to_trigger_list(equipment_spawns[i].equipment);
        equipment_spawns[i] thread equipment_spawn_think();
    }
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xd1c87d03, Offset: 0x16e0
// Size: 0x5a
function get_hint(equipment) {
    assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "<dev string:xbd>");
    return level.zombie_equipment[equipment].hint;
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xb3202947, Offset: 0x1748
// Size: 0x5a
function get_howto_hint(equipment) {
    assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "<dev string:xbd>");
    return level.zombie_equipment[equipment].howto_hint;
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x1fb8824c, Offset: 0x17b0
// Size: 0x5a
function get_icon(equipment) {
    assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "<dev string:xbd>");
    return level.zombie_equipment[equipment].hint_icon;
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x4d919f6c, Offset: 0x1818
// Size: 0x5a
function get_notify_strings(equipment) {
    assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "<dev string:xbd>");
    return level.zombie_equipment[equipment].notify_strings;
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x16d17026, Offset: 0x1880
// Size: 0xce
function add_to_trigger_list(equipment) {
    assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "<dev string:xbd>");
    level.zombie_equipment[equipment].triggers[level.zombie_equipment[equipment].triggers.size] = self;
    level.zombie_equipment[equipment].models[level.zombie_equipment[equipment].models.size] = getent(self.target, "targetname");
}

// Namespace zm_equipment/zm_equipment
// Params 0, eflags: 0x0
// Checksum 0x99c8dfba, Offset: 0x1958
// Size: 0x1bc
function equipment_spawn_think() {
    for (;;) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        if (player zm_utility::in_revive_trigger() || player zm_utility::is_drinking()) {
            wait 0.1;
            continue;
        }
        if (!is_limited(self.equipment) || !limited_in_use(self.equipment)) {
            if (is_limited(self.equipment)) {
                player setup_limited(self.equipment);
                if (isdefined(level.hacker_tool_positions)) {
                    new_pos = array::random(level.hacker_tool_positions);
                    self.origin = new_pos.trigger_org;
                    model = getent(self.target, "targetname");
                    model.origin = new_pos.model_org;
                    model.angles = new_pos.model_ang;
                }
            }
            player give(self.equipment);
            continue;
        }
        wait 0.1;
    }
}

// Namespace zm_equipment/zm_equipment
// Params 2, eflags: 0x0
// Checksum 0x84086035, Offset: 0x1b20
// Size: 0xfe
function set_equipment_invisibility_to_player(equipment, invisible) {
    triggers = level.zombie_equipment[equipment].triggers;
    for (i = 0; i < triggers.size; i++) {
        if (isdefined(triggers[i])) {
            triggers[i] setinvisibletoplayer(self, invisible);
        }
    }
    models = level.zombie_equipment[equipment].models;
    for (i = 0; i < models.size; i++) {
        if (isdefined(models[i])) {
            models[i] setinvisibletoplayer(self, invisible);
        }
    }
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x5e510d6a, Offset: 0x1c28
// Size: 0x2d4
function take(equipment = self get_player_equipment()) {
    if (!isdefined(equipment)) {
        return;
    }
    if (equipment == level.weaponnone) {
        return;
    }
    if (!self has_player_equipment(equipment)) {
        return;
    }
    current = 0;
    current_weapon = 0;
    if (isdefined(self get_player_equipment()) && equipment == self get_player_equipment()) {
        current = 1;
    }
    if (equipment == self getcurrentweapon()) {
        current_weapon = 1;
    }
    println("<dev string:xff>" + self.name + "<dev string:x10e>" + getweaponname(equipment) + "<dev string:x115>");
    notify_strings = get_notify_strings(equipment);
    if (isdefined(self.current_equipment_active[equipment]) && self.current_equipment_active[equipment]) {
        self.current_equipment_active[equipment] = 0;
        self notify(notify_strings.deactivate);
    }
    self notify(notify_strings.taken);
    if (!is_limited(equipment) || is_limited(equipment) && !limited_in_use(equipment)) {
        self set_equipment_invisibility_to_player(equipment, 0);
    }
    if (current) {
        self set_player_equipment(level.weaponnone);
        self setactionslot(2, "");
    } else {
        arrayremovevalue(self.deployed_equipment, equipment);
    }
    if (self hasweapon(equipment)) {
        self takeweapon(equipment);
    }
    if (current_weapon) {
        self zm_weapons::switch_back_primary_weapon();
    }
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xfce43602, Offset: 0x1f08
// Size: 0x1e6
function give(equipment) {
    if (!isdefined(equipment)) {
        return;
    }
    if (!isdefined(level.zombie_equipment[equipment])) {
        return;
    }
    if (self has_player_equipment(equipment)) {
        return;
    }
    println("<dev string:xff>" + self.name + "<dev string:x117>" + getweaponname(equipment) + "<dev string:x115>");
    curr_weapon = self getcurrentweapon();
    curr_weapon_was_curr_equipment = self is_player_equipment(curr_weapon);
    self take();
    self set_player_equipment(equipment);
    self giveweapon(equipment);
    self start_ammo(equipment);
    self thread show_hint(equipment);
    self set_equipment_invisibility_to_player(equipment, 1);
    self setactionslot(2, "weapon", equipment);
    self thread slot_watcher(equipment);
    self zm_audio::create_and_play_dialog("weapon_pickup", level.zombie_equipment[equipment].vox);
    self notify(#"player_given", equipment);
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x9376d404, Offset: 0x20f8
// Size: 0x134
function buy(equipment) {
    if (isstring(equipment)) {
        equipment = getweapon(equipment);
    }
    println("<dev string:xff>" + self.name + "<dev string:x11d>" + getweaponname(equipment) + "<dev string:x115>");
    if (isdefined(self.current_equipment) && equipment != self.current_equipment && self.current_equipment != level.weaponnone) {
        self take(self.current_equipment);
    }
    self notify(#"player_bought", equipment);
    self give(equipment);
    if (equipment.isriotshield && isdefined(self.player_shield_reset_health)) {
        self [[ self.player_shield_reset_health ]](equipment);
    }
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x2b00d71b, Offset: 0x2238
// Size: 0x216
function slot_watcher(equipment) {
    self notify(#"kill_equipment_slot_watcher");
    self endon(#"kill_equipment_slot_watcher", #"disconnect");
    notify_strings = get_notify_strings(equipment);
    while (true) {
        waitresult = self waittill(#"weapon_change");
        prev_weapon = waitresult.last_weapon;
        curr_weapon = waitresult.weapon;
        self.prev_weapon_before_equipment_change = undefined;
        if (isdefined(prev_weapon) && level.weaponnone != prev_weapon) {
            prev_weapon_type = prev_weapon.inventorytype;
            if ("primary" == prev_weapon_type || "altmode" == prev_weapon_type) {
                self.prev_weapon_before_equipment_change = prev_weapon;
            }
        }
        if (!isdefined(level.a_func_equipment_slot_watcher_override)) {
            level.a_func_equipment_slot_watcher_override = [];
        }
        if (isdefined(level.a_func_equipment_slot_watcher_override[equipment.name])) {
            self [[ level.a_func_equipment_slot_watcher_override[equipment.name] ]](equipment, curr_weapon, prev_weapon, notify_strings);
            continue;
        }
        if (curr_weapon == equipment && !self.current_equipment_active[equipment]) {
            self notify(notify_strings.activate);
            self.current_equipment_active[equipment] = 1;
            continue;
        }
        if (curr_weapon != equipment && self.current_equipment_active[equipment]) {
            self notify(notify_strings.deactivate);
            self.current_equipment_active[equipment] = 0;
        }
    }
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xf428ccaa, Offset: 0x2458
// Size: 0x68
function is_limited(equipment) {
    if (isdefined(level._limited_equipment)) {
        for (i = 0; i < level._limited_equipment.size; i++) {
            if (level._limited_equipment[i] == equipment) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x69d4903d, Offset: 0x24c8
// Size: 0xbc
function limited_in_use(equipment) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        current_equipment = players[i] get_player_equipment();
        if (isdefined(current_equipment) && current_equipment == equipment) {
            return true;
        }
    }
    if (isdefined(level.dropped_equipment) && isdefined(level.dropped_equipment[equipment])) {
        return true;
    }
    return false;
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xa4e108ef, Offset: 0x2590
// Size: 0x9c
function setup_limited(equipment) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] set_equipment_invisibility_to_player(equipment, 1);
    }
    self thread release_limited_on_disconnect(equipment);
    self thread release_limited_on_taken(equipment);
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x8315e043, Offset: 0x2638
// Size: 0xc6
function release_limited_on_taken(equipment) {
    self endon(#"disconnect");
    notify_strings = get_notify_strings(equipment);
    self util::waittill_either(notify_strings.taken, "spawned_spectator");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] set_equipment_invisibility_to_player(equipment, 0);
    }
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x69419f0a, Offset: 0x2708
// Size: 0xd6
function release_limited_on_disconnect(equipment) {
    notify_strings = get_notify_strings(equipment);
    self endon(notify_strings.taken);
    self waittill(#"disconnect");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isalive(players[i])) {
            players[i] set_equipment_invisibility_to_player(equipment, 0);
        }
    }
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xb23b20ee, Offset: 0x27e8
// Size: 0x44
function is_active(equipment) {
    if (!isdefined(self.current_equipment_active) || !isdefined(self.current_equipment_active[equipment])) {
        return 0;
    }
    return self.current_equipment_active[equipment];
}

// Namespace zm_equipment/zm_equipment
// Params 6, eflags: 0x0
// Checksum 0xe36b52cc, Offset: 0x2838
// Size: 0x8a
function init_hint_hudelem(x, y, alignx, aligny, fontscale, alpha) {
    self.x = x;
    self.y = y;
    self.alignx = alignx;
    self.aligny = aligny;
    self.fontscale = fontscale;
    self.alpha = alpha;
    self.sort = 20;
}

/#

    // Namespace zm_equipment/zm_equipment
    // Params 2, eflags: 0x0
    // Checksum 0x77519fc3, Offset: 0x28d0
    // Size: 0x184
    function setup_client_hintelem(ypos, font_scale) {
        if (!isdefined(ypos)) {
            ypos = 220;
        }
        if (!isdefined(font_scale)) {
            font_scale = 1.25;
        }
        self endon(#"death");
        if (!isdefined(self.hintelem)) {
            self.hintelem = newdebughudelem(self);
        }
        if (self issplitscreen()) {
            if (getdvarint(#"splitscreen_playercount", 0) >= 3) {
                self.hintelem init_hint_hudelem(160, 90, "<dev string:x126>", "<dev string:x12d>", font_scale * 0.8, 1);
            } else {
                self.hintelem init_hint_hudelem(160, 90, "<dev string:x126>", "<dev string:x12d>", font_scale, 1);
            }
            return;
        }
        self.hintelem init_hint_hudelem(320, ypos, "<dev string:x126>", "<dev string:x134>", font_scale, 1);
    }

#/

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xb52b795d, Offset: 0x2a60
// Size: 0x9c
function show_hint(equipment) {
    self notify(#"kill_previous_show_equipment_hint_thread");
    self endon(#"kill_previous_show_equipment_hint_thread", #"death");
    if (isdefined(self.do_not_display_equipment_pickup_hint) && self.do_not_display_equipment_pickup_hint) {
        return;
    }
    wait 0.5;
    text = get_howto_hint(equipment);
    self show_hint_text(text);
}

// Namespace zm_equipment/zm_equipment
// Params 4, eflags: 0x0
// Checksum 0xfad62fe, Offset: 0x2b08
// Size: 0x22c
function show_hint_text(text, show_for_time = 3.2, font_scale = 1.25, ypos = 220) {
    self notify("19c7e5308a9dbe3f");
    self endon("19c7e5308a9dbe3f");
    self endon(#"disconnect");
    level endoncallback(&function_5ca8ed72, #"end_game");
    if (!level.zm_hint_text zm_hint_text::is_open(self)) {
        level.zm_hint_text zm_hint_text::open(self);
    }
    level.zm_hint_text zm_hint_text::set_text(self, text);
    level.zm_hint_text zm_hint_text::set_state(self, #"visible");
    time = self waittilltimeout(show_for_time, #"hide_equipment_hint_text", #"death", #"disconnect");
    if (isdefined(time) && isdefined(self) && level.zm_hint_text zm_hint_text::is_open(self)) {
        level.zm_hint_text zm_hint_text::set_state(self, #"defaultstate");
        self waittilltimeout(1, #"hide_equipment_hint_text");
    }
    if (isdefined(self) && level.zm_hint_text zm_hint_text::is_open(self)) {
        level.zm_hint_text zm_hint_text::close(self);
    }
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x3280586b, Offset: 0x2d40
// Size: 0xb8
function function_5ca8ed72(str_notify) {
    foreach (player in level.players) {
        if (isdefined(player) && level.zm_hint_text zm_hint_text::is_open(player)) {
            level.zm_hint_text zm_hint_text::close(player);
        }
    }
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xd6d43aa4, Offset: 0x2e00
// Size: 0xd6
function start_ammo(equipment) {
    if (self hasweapon(equipment)) {
        maxammo = 1;
        if (isdefined(level.zombie_equipment[equipment].notake) && level.zombie_equipment[equipment].notake) {
            maxammo = level.zombie_equipment[equipment].start_ammo;
        }
        self setweaponammoclip(equipment, maxammo);
        self notify(#"equipment_ammo_changed", {#equipment:equipment});
        return maxammo;
    }
    return 0;
}

// Namespace zm_equipment/zm_equipment
// Params 2, eflags: 0x0
// Checksum 0x3c6c656f, Offset: 0x2ee0
// Size: 0x146
function change_ammo(equipment, change) {
    if (self hasweapon(equipment)) {
        oldammo = self getweaponammoclip(equipment);
        maxammo = 1;
        if (isdefined(level.zombie_equipment[equipment].notake) && level.zombie_equipment[equipment].notake) {
            maxammo = level.zombie_equipment[equipment].start_ammo;
        }
        newammo = int(min(maxammo, max(0, oldammo + change)));
        self setweaponammoclip(equipment, newammo);
        self notify(#"equipment_ammo_changed", {#equipment:equipment});
        return newammo;
    }
    return 0;
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x8d46cd0b, Offset: 0x3030
// Size: 0x7e
function register_for_level(weaponname) {
    weapon = getweapon(weaponname);
    if (is_equipment(weapon)) {
        return;
    }
    if (!isdefined(level.zombie_equipment_list)) {
        level.zombie_equipment_list = [];
    }
    level.zombie_equipment_list[weapon] = weapon;
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xd1bd08fa, Offset: 0x30b8
// Size: 0x3e
function is_equipment(weapon) {
    if (!isdefined(weapon) || !isdefined(level.zombie_equipment_list)) {
        return false;
    }
    return isdefined(level.zombie_equipment_list[weapon]);
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x28cbb2c4, Offset: 0x3100
// Size: 0x22
function is_equipment_that_blocks_purchase(weapon) {
    return is_equipment(weapon);
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x8a22c9ea, Offset: 0x3130
// Size: 0x38
function is_player_equipment(weapon) {
    if (!isdefined(weapon) || !isdefined(self.current_equipment)) {
        return false;
    }
    return self.current_equipment == weapon;
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x384d7af1, Offset: 0x3170
// Size: 0x88
function has_deployed_equipment(weapon) {
    if (!isdefined(weapon) || !isdefined(self.deployed_equipment) || self.deployed_equipment.size < 1) {
        return false;
    }
    for (i = 0; i < self.deployed_equipment.size; i++) {
        if (self.deployed_equipment[i] == weapon) {
            return true;
        }
    }
    return false;
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x44ca30a9, Offset: 0x3200
// Size: 0x3c
function has_player_equipment(weapon) {
    return self is_player_equipment(weapon) || self has_deployed_equipment(weapon);
}

// Namespace zm_equipment/zm_equipment
// Params 0, eflags: 0x0
// Checksum 0x5b5ce74b, Offset: 0x3248
// Size: 0x36
function get_player_equipment() {
    equipment = level.weaponnone;
    if (isdefined(self.current_equipment)) {
        equipment = self.current_equipment;
    }
    return equipment;
}

// Namespace zm_equipment/zm_equipment
// Params 0, eflags: 0x0
// Checksum 0xe6841686, Offset: 0x3288
// Size: 0x32
function hacker_active() {
    return self is_active(getweapon(#"equip_hacker"));
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xb7dae88d, Offset: 0x32c8
// Size: 0x9a
function set_player_equipment(weapon) {
    if (!isdefined(self.current_equipment_active)) {
        self.current_equipment_active = [];
    }
    if (isdefined(weapon)) {
        self.current_equipment_active[weapon] = 0;
    }
    if (!isdefined(self.equipment_got_in_round)) {
        self.equipment_got_in_round = [];
    }
    if (isdefined(weapon)) {
        self.equipment_got_in_round[weapon] = level.round_number;
    }
    self notify(#"new_equipment", weapon);
    self.current_equipment = weapon;
}

// Namespace zm_equipment/zm_equipment
// Params 0, eflags: 0x0
// Checksum 0x677b3f6f, Offset: 0x3370
// Size: 0x24
function init_player_equipment() {
    self set_player_equipment(level.zombie_equipment_player_init);
}

/#

    // Namespace zm_equipment/zm_equipment
    // Params 0, eflags: 0x0
    // Checksum 0xccbd370f, Offset: 0x33a0
    // Size: 0x1ce
    function function_f30ee99e() {
        setdvar(#"give_equipment", "<dev string:x13b>");
        waitframe(1);
        level flag::wait_till("<dev string:x13c>");
        waitframe(1);
        str_cmd = "<dev string:x155>" + "<dev string:x18f>" + "<dev string:x194>";
        adddebugcommand(str_cmd);
        while (true) {
            equipment_id = getdvarstring(#"give_equipment");
            if (equipment_id != "<dev string:x13b>") {
                foreach (player in getplayers()) {
                    if (equipment_id == "<dev string:x18f>") {
                        player take();
                        continue;
                    }
                    if (is_included(equipment_id)) {
                        player buy(equipment_id);
                    }
                }
                setdvar(#"give_equipment", "<dev string:x13b>");
            }
            waitframe(1);
        }
    }

    // Namespace zm_equipment/zm_equipment
    // Params 1, eflags: 0x0
    // Checksum 0x2670363a, Offset: 0x3578
    // Size: 0xa4
    function function_de79cac6(equipment) {
        waitframe(1);
        level flag::wait_till("<dev string:x13c>");
        waitframe(1);
        if (isdefined(equipment)) {
            equipment_id = getweaponname(equipment);
            str_cmd = "<dev string:x197>" + equipment_id + "<dev string:x1b1>" + equipment_id + "<dev string:x194>";
            adddebugcommand(str_cmd);
        }
    }

#/
