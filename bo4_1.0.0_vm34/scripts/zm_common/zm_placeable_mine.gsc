#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_placeable_mine;

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 0, eflags: 0x2
// Checksum 0xe4ce8961, Offset: 0x158
// Size: 0x34
function autoexec __init__system__() {
    system::register(#"placeable_mine", undefined, &__main__, undefined);
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 0, eflags: 0x4
// Checksum 0xeb8fd864, Offset: 0x198
// Size: 0x2c
function private __main__() {
    if (isdefined(level.placeable_mines)) {
        level thread replenish_after_rounds();
    }
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 0, eflags: 0x4
// Checksum 0xb2574573, Offset: 0x1d0
// Size: 0x7a
function private init_internal() {
    if (isdefined(level.placeable_mines)) {
        return;
    }
    level.placeable_mines = [];
    level.placeable_mines_on_damage = &placeable_mine_damage;
    level.pickup_placeable_mine = &pickup_placeable_mine;
    level.pickup_placeable_mine_trigger_listener = &pickup_placeable_mine_trigger_listener;
    level.placeable_mine_planted_callbacks = [];
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 0, eflags: 0x0
// Checksum 0xa263f650, Offset: 0x258
// Size: 0xa6
function get_first_available() {
    if (isdefined(zm_loadout::function_992fe093("placeable_mine")) && zm_loadout::function_992fe093("placeable_mine").size > 0) {
        str_key = getarraykeys(zm_loadout::function_992fe093("placeable_mine"))[0];
        return zm_loadout::function_992fe093("placeable_mine")[str_key];
    }
    return level.weaponnone;
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 2, eflags: 0x0
// Checksum 0xc7cab3b5, Offset: 0x308
// Size: 0x52
function add_mine_type(mine_name, str_retrieval_prompt) {
    init_internal();
    zm_loadout::function_4e1a22d7("placeable_mine", mine_name);
    level.placeable_mine_planted_callbacks[mine_name] = [];
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 1, eflags: 0x0
// Checksum 0x1707fb90, Offset: 0x368
// Size: 0x9e
function add_weapon_to_mine_slot(mine_name) {
    init_internal();
    level.placeable_mines[mine_name] = getweapon(mine_name);
    level.placeable_mine_planted_callbacks[mine_name] = [];
    if (!isdefined(level.placeable_mines_in_name_only)) {
        level.placeable_mines_in_name_only = [];
    }
    level.placeable_mines_in_name_only[mine_name] = getweapon(mine_name);
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 1, eflags: 0x0
// Checksum 0x5a3b82eb, Offset: 0x410
// Size: 0x1a
function set_max_per_player(n_max_per_player) {
    level.placeable_mines_max_per_player = n_max_per_player;
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 2, eflags: 0x0
// Checksum 0x2eee8405, Offset: 0x438
// Size: 0xc0
function add_planted_callback(fn_planted_cb, wpn_name) {
    if (!isdefined(level.placeable_mine_planted_callbacks[wpn_name])) {
        level.placeable_mine_planted_callbacks[wpn_name] = [];
    } else if (!isarray(level.placeable_mine_planted_callbacks[wpn_name])) {
        level.placeable_mine_planted_callbacks[wpn_name] = array(level.placeable_mine_planted_callbacks[wpn_name]);
    }
    level.placeable_mine_planted_callbacks[wpn_name][level.placeable_mine_planted_callbacks[wpn_name].size] = fn_planted_cb;
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 1, eflags: 0x4
// Checksum 0xb82a8889, Offset: 0x500
// Size: 0x8e
function private run_planted_callbacks(e_planter) {
    foreach (fn in level.placeable_mine_planted_callbacks[self.weapon.name]) {
        self thread [[ fn ]](e_planter);
    }
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 0, eflags: 0x4
// Checksum 0x25bd7a33, Offset: 0x598
// Size: 0x3e
function private safe_to_plant() {
    if (isdefined(level.placeable_mines_max_per_player) && self.owner.placeable_mines.size >= level.placeable_mines_max_per_player) {
        return false;
    }
    return true;
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 0, eflags: 0x4
// Checksum 0xddac65ad, Offset: 0x5e0
// Size: 0x2c
function private wait_and_detonate() {
    wait 0.1;
    self detonate(self.owner);
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 1, eflags: 0x4
// Checksum 0xbd0985fa, Offset: 0x618
// Size: 0x198
function private mine_watch(wpn_type) {
    self endon(#"death");
    self notify(#"mine_watch");
    self endon(#"mine_watch");
    while (true) {
        waitresult = self waittill(#"grenade_fire");
        mine = waitresult.projectile;
        fired_weapon = waitresult.weapon;
        if (fired_weapon == wpn_type) {
            mine.owner = self;
            mine.team = self.team;
            mine.weapon = fired_weapon;
            self notify("zmb_enable_" + fired_weapon.name + "_prompt");
            if (mine safe_to_plant()) {
                mine run_planted_callbacks(self);
                self zm_stats::increment_client_stat(fired_weapon.name + "_planted");
                self zm_stats::increment_player_stat(fired_weapon.name + "_planted");
                continue;
            }
            mine thread wait_and_detonate();
        }
    }
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 1, eflags: 0x0
// Checksum 0x8204ad87, Offset: 0x7b8
// Size: 0x3e
function is_true_placeable_mine(mine_name) {
    if (!isdefined(level.placeable_mines_in_name_only)) {
        return true;
    }
    if (!isdefined(level.placeable_mines_in_name_only[mine_name])) {
        return true;
    }
    return false;
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 2, eflags: 0x0
// Checksum 0x945cafc2, Offset: 0x800
// Size: 0x15a
function setup_for_player(wpn_type, ui_model = "hudItems.showDpadRight") {
    if (!isdefined(self.placeable_mines)) {
        self.placeable_mines = [];
    }
    if (isdefined(self.last_placeable_mine_uimodel)) {
        self clientfield::set_player_uimodel(self.last_placeable_mine_uimodel, 0);
    }
    if (is_true_placeable_mine(wpn_type.name)) {
        self thread mine_watch(wpn_type);
    }
    self giveweapon(wpn_type);
    self zm_loadout::set_player_placeable_mine(wpn_type);
    self setactionslot(4, "weapon", wpn_type);
    startammo = wpn_type.startammo;
    if (startammo) {
        self setweaponammostock(wpn_type, startammo);
    }
    if (isdefined(ui_model)) {
        self clientfield::set_player_uimodel(ui_model, 1);
    }
    self.last_placeable_mine_uimodel = ui_model;
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 1, eflags: 0x0
// Checksum 0x5e388b3e, Offset: 0x968
// Size: 0x30
function disable_prompt_for_player(wpn_type) {
    self notify("zmb_disable_" + wpn_type.name + "_prompt");
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 0, eflags: 0x0
// Checksum 0xb1c221aa, Offset: 0x9a0
// Size: 0x88
function disable_all_prompts_for_player() {
    foreach (mine in zm_loadout::function_992fe093("placeable_mine")) {
        self disable_prompt_for_player(mine);
    }
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 0, eflags: 0x4
// Checksum 0x16520616, Offset: 0xa30
// Size: 0x27c
function private pickup_placeable_mine() {
    player = self.owner;
    wpn_type = self.weapon;
    if (player zm_utility::is_drinking()) {
        return;
    }
    current_player_mine = player zm_loadout::get_player_placeable_mine();
    if (current_player_mine != wpn_type) {
        player takeweapon(current_player_mine);
    }
    if (!player hasweapon(wpn_type)) {
        player thread mine_watch(wpn_type);
        player giveweapon(wpn_type);
        player zm_loadout::set_player_placeable_mine(wpn_type);
        player setactionslot(4, "weapon", wpn_type);
        player setweaponammoclip(wpn_type, 0);
        player notify("zmb_enable_" + wpn_type.name + "_prompt");
    } else {
        clip_ammo = player getweaponammoclip(wpn_type);
        clip_max_ammo = wpn_type.clipsize;
        if (clip_ammo >= clip_max_ammo) {
            self delete();
            player disable_prompt_for_player(wpn_type);
            return;
        }
    }
    self zm_utility::pick_up();
    clip_ammo = player getweaponammoclip(wpn_type);
    clip_max_ammo = wpn_type.clipsize;
    if (clip_ammo >= clip_max_ammo) {
        player disable_prompt_for_player(wpn_type);
    }
    player zm_stats::increment_client_stat(wpn_type.name + "_pickedup");
    player zm_stats::increment_player_stat(wpn_type.name + "_pickedup");
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 2, eflags: 0x4
// Checksum 0xf90d8b22, Offset: 0xcb8
// Size: 0x44
function private pickup_placeable_mine_trigger_listener(trigger, player) {
    self thread pickup_placeable_mine_trigger_listener_enable(trigger, player);
    self thread pickup_placeable_mine_trigger_listener_disable(trigger, player);
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 2, eflags: 0x4
// Checksum 0x7ca50643, Offset: 0xd08
// Size: 0xb8
function private pickup_placeable_mine_trigger_listener_enable(trigger, player) {
    self endon(#"delete");
    self endon(#"death");
    while (true) {
        player waittill("zmb_enable_" + self.weapon.name + "_prompt", #"spawned_player");
        if (!isdefined(trigger)) {
            return;
        }
        trigger triggerenable(1);
        trigger linkto(self);
    }
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 2, eflags: 0x4
// Checksum 0xc9a8440b, Offset: 0xdc8
// Size: 0xa8
function private pickup_placeable_mine_trigger_listener_disable(trigger, player) {
    self endon(#"delete");
    self endon(#"death");
    while (true) {
        player waittill("zmb_disable_" + self.weapon.name + "_prompt");
        if (!isdefined(trigger)) {
            return;
        }
        trigger unlink();
        trigger triggerenable(0);
    }
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 0, eflags: 0x4
// Checksum 0x8242b328, Offset: 0xe78
// Size: 0x1ec
function private placeable_mine_damage() {
    self endon(#"death");
    self setcandamage(1);
    self.health = 100000;
    self.maxhealth = self.health;
    attacker = undefined;
    while (true) {
        waitresult = self waittill(#"damage");
        if (!isdefined(self)) {
            return;
        }
        self.health = self.maxhealth;
        if (!isplayer(waitresult.attacker)) {
            continue;
        }
        if (isdefined(self.owner) && attacker == self.owner) {
            continue;
        }
        if (isdefined(waitresult.attacker.pers) && isdefined(waitresult.attacker.pers[#"team"]) && waitresult.attacker.pers[#"team"] != level.zombie_team) {
            continue;
        }
        break;
    }
    if (level.satchelexplodethisframe) {
        wait 0.1 + randomfloat(0.4);
    } else {
        waitframe(1);
    }
    if (!isdefined(self)) {
        return;
    }
    level.satchelexplodethisframe = 1;
    thread reset_satchel_explode_this_frame();
    self detonate(waitresult.attacker);
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 0, eflags: 0x4
// Checksum 0x2c99c4b8, Offset: 0x1070
// Size: 0x16
function private reset_satchel_explode_this_frame() {
    waitframe(1);
    level.satchelexplodethisframe = 0;
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 0, eflags: 0x4
// Checksum 0x67365890, Offset: 0x1090
// Size: 0x212
function private replenish_after_rounds() {
    while (true) {
        level waittill(#"between_round_over");
        if (isdefined(level.var_d109cb41)) {
            [[ level.var_d109cb41 ]]();
            continue;
        }
        if (!level flag::exists("teleporter_used") || !level flag::get("teleporter_used")) {
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                foreach (mine in zm_loadout::function_992fe093("placeable_mine")) {
                    if (players[i] zm_loadout::is_player_placeable_mine(mine) && is_true_placeable_mine(mine.name)) {
                        players[i] giveweapon(mine);
                        players[i] zm_loadout::set_player_placeable_mine(mine);
                        players[i] setactionslot(4, "weapon", mine);
                        players[i] setweaponammoclip(mine, 2);
                        break;
                    }
                }
            }
        }
    }
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 0, eflags: 0x0
// Checksum 0xb65debf4, Offset: 0x12b0
// Size: 0xc0
function setup_watchers() {
    if (isdefined(zm_loadout::function_992fe093("placeable_mine"))) {
        foreach (mine_type in zm_loadout::function_992fe093("placeable_mine")) {
            weaponobjects::function_f298eae6(mine_type.name, &function_b0f5c8b1, 1);
        }
    }
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 1, eflags: 0x0
// Checksum 0xef12d241, Offset: 0x1378
// Size: 0xb2
function function_b0f5c8b1(watcher) {
    watcher.onspawnretrievetriggers = &on_spawn_retrieve_trigger;
    watcher.adjusttriggerorigin = &adjust_trigger_origin;
    watcher.pickup = level.pickup_placeable_mine;
    watcher.pickup_trigger_listener = level.pickup_placeable_mine_trigger_listener;
    watcher.skip_weapon_object_damage = 1;
    watcher.watchforfire = 1;
    watcher.ondetonatecallback = &placeable_mine_detonate;
    watcher.ondamage = level.placeable_mines_on_damage;
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 2, eflags: 0x4
// Checksum 0xb6cdb978, Offset: 0x1438
// Size: 0x54
function private on_spawn_retrieve_trigger(watcher, player) {
    self weaponobjects::function_62336657(watcher, player);
    if (isdefined(self.pickuptrigger)) {
        self.pickuptrigger sethintlowpriority(0);
    }
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 1, eflags: 0x4
// Checksum 0x8b0d4ae8, Offset: 0x1498
// Size: 0x26
function private adjust_trigger_origin(origin) {
    origin += (0, 0, 20);
    return origin;
}

// Namespace zm_placeable_mine/zm_placeable_mine
// Params 3, eflags: 0x4
// Checksum 0x9df58677, Offset: 0x14c8
// Size: 0xbc
function private placeable_mine_detonate(attacker, weapon, target) {
    if (weapon.isemp) {
        self delete();
        return;
    }
    if (isdefined(attacker)) {
        self detonate(attacker);
        return;
    }
    if (isdefined(self.owner) && isplayer(self.owner)) {
        self detonate(self.owner);
        return;
    }
    self detonate();
}

