#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_melee_weapon;

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 0, eflags: 0x2
// Checksum 0xa07dfc4e, Offset: 0x130
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"melee_weapon", &__init__, &__main__, undefined);
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 0, eflags: 0x4
// Checksum 0xa1ebd6b8, Offset: 0x180
// Size: 0x22
function private __init__() {
    if (!isdefined(level._melee_weapons)) {
        level._melee_weapons = [];
    }
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x1b0
// Size: 0x4
function private __main__() {
    
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 9, eflags: 0x0
// Checksum 0x66d2355f, Offset: 0x1c0
// Size: 0x3d8
function init(weapon_name, flourish_weapon_name, var_ae3c4699, var_92998c6a, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn) {
    weapon = getweapon(weapon_name);
    flourish_weapon = getweapon(flourish_weapon_name);
    var_834ec52d = level.weaponnone;
    if (isdefined(var_ae3c4699)) {
        var_834ec52d = getweapon(var_ae3c4699);
    }
    var_499da020 = level.weaponnone;
    if (isdefined(var_92998c6a)) {
        var_499da020 = getweapon(var_92998c6a);
    }
    add_melee_weapon(weapon, flourish_weapon, var_834ec52d, var_499da020, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn);
    melee_weapon_triggers = getentarray(wallbuy_targetname, "targetname");
    for (i = 0; i < melee_weapon_triggers.size; i++) {
        knife_model = getent(melee_weapon_triggers[i].target, "targetname");
        if (isdefined(knife_model)) {
            knife_model hide();
        }
        melee_weapon_triggers[i] thread melee_weapon_think(weapon, cost, flourish_fn, vo_dialog_id, flourish_weapon, var_834ec52d, var_499da020);
        melee_weapon_triggers[i] sethintstring(hint_string, cost);
        cursor_hint = "HINT_WEAPON";
        cursor_hint_weapon = weapon;
        melee_weapon_triggers[i] setcursorhint(cursor_hint, cursor_hint_weapon);
        melee_weapon_triggers[i] usetriggerrequirelookat();
    }
    melee_weapon_structs = struct::get_array(wallbuy_targetname, "targetname");
    for (i = 0; i < melee_weapon_structs.size; i++) {
        prepare_stub(melee_weapon_structs[i].trigger_stub, weapon, flourish_weapon, var_834ec52d, var_499da020, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn);
    }
    zm_loadout::register_melee_weapon_for_level(weapon.name);
    if (!isdefined(level.var_834ec52d)) {
        level.var_834ec52d = [];
    }
    level.var_834ec52d[weapon] = var_834ec52d;
    if (!isdefined(level.var_499da020)) {
        level.var_499da020 = [];
    }
    level.var_499da020[weapon] = var_499da020;
    /#
        if (!isdefined(level.zombie_weapons[weapon])) {
            if (isdefined(level.devgui_add_weapon)) {
                level thread [[ level.devgui_add_weapon ]](weapon, "<dev string:x30>", weapon_name, cost);
            }
        }
    #/
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 10, eflags: 0x0
// Checksum 0x95964807, Offset: 0x5a0
// Size: 0x12e
function prepare_stub(stub, weapon, flourish_weapon, var_834ec52d, var_499da020, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn) {
    if (isdefined(stub)) {
        stub.hint_string = hint_string;
        stub.cursor_hint = "HINT_WEAPON";
        stub.cursor_hint_weapon = weapon;
        stub.cost = cost;
        stub.weapon = weapon;
        stub.vo_dialog_id = vo_dialog_id;
        stub.flourish_weapon = flourish_weapon;
        stub.var_834ec52d = var_834ec52d;
        stub.var_499da020 = var_499da020;
        stub.trigger_func = &melee_weapon_think;
        stub.prompt_and_visibility_func = &function_bec5da73;
        stub.flourish_fn = flourish_fn;
    }
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 1, eflags: 0x0
// Checksum 0x3120ff8b, Offset: 0x6d8
// Size: 0x7a
function find_melee_weapon(weapon) {
    melee_weapon = undefined;
    for (i = 0; i < level._melee_weapons.size; i++) {
        if (level._melee_weapons[i].weapon == weapon) {
            return level._melee_weapons[i];
        }
    }
    return undefined;
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 2, eflags: 0x0
// Checksum 0xa48719ab, Offset: 0x760
// Size: 0xc4
function add_stub(stub, weapon) {
    melee_weapon = find_melee_weapon(weapon);
    if (isdefined(stub) && isdefined(melee_weapon)) {
        prepare_stub(stub, melee_weapon.weapon, melee_weapon.flourish_weapon, melee_weapon.var_834ec52d, melee_weapon.var_499da020, melee_weapon.cost, melee_weapon.wallbuy_targetname, melee_weapon.hint_string, melee_weapon.vo_dialog_id, melee_weapon.flourish_fn);
    }
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 9, eflags: 0x0
// Checksum 0x94d6119c, Offset: 0x830
// Size: 0x12e
function add_melee_weapon(weapon, flourish_weapon, var_834ec52d, var_499da020, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn) {
    melee_weapon = spawnstruct();
    melee_weapon.weapon = weapon;
    melee_weapon.flourish_weapon = flourish_weapon;
    melee_weapon.var_834ec52d = var_834ec52d;
    melee_weapon.var_499da020 = var_499da020;
    melee_weapon.cost = cost;
    melee_weapon.wallbuy_targetname = wallbuy_targetname;
    melee_weapon.hint_string = hint_string;
    melee_weapon.vo_dialog_id = vo_dialog_id;
    melee_weapon.flourish_fn = flourish_fn;
    if (!isdefined(level._melee_weapons)) {
        level._melee_weapons = [];
    }
    level._melee_weapons[level._melee_weapons.size] = melee_weapon;
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 2, eflags: 0x0
// Checksum 0x58b0f570, Offset: 0x968
// Size: 0x6e
function set_fallback_weapon(weapon_name, fallback_weapon_name) {
    melee_weapon = find_melee_weapon(getweapon(weapon_name));
    if (isdefined(melee_weapon)) {
        melee_weapon.fallback_weapon = getweapon(fallback_weapon_name);
    }
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 0, eflags: 0x0
// Checksum 0xb770a998, Offset: 0x9e0
// Size: 0xb4
function determine_fallback_weapon() {
    fallback_weapon = level.weaponzmfists;
    if (isdefined(self zm_loadout::get_player_melee_weapon()) && self hasweapon(self zm_loadout::get_player_melee_weapon())) {
        melee_weapon = find_melee_weapon(self zm_loadout::get_player_melee_weapon());
        if (isdefined(melee_weapon) && isdefined(melee_weapon.fallback_weapon)) {
            return melee_weapon.fallback_weapon;
        }
    }
    return fallback_weapon;
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 1, eflags: 0x0
// Checksum 0xfbbd8dc, Offset: 0xaa0
// Size: 0xac
function give_fallback_weapon(immediate = 0) {
    fallback_weapon = self determine_fallback_weapon();
    had_weapon = self hasweapon(fallback_weapon);
    self giveweapon(fallback_weapon);
    if (immediate && had_weapon) {
        self switchtoweaponimmediate(fallback_weapon);
        return;
    }
    self switchtoweapon(fallback_weapon);
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 0, eflags: 0x0
// Checksum 0xce3d478, Offset: 0xb58
// Size: 0x60
function take_fallback_weapon() {
    fallback_weapon = self determine_fallback_weapon();
    had_weapon = self hasweapon(fallback_weapon);
    self zm_weapons::weapon_take(fallback_weapon);
    return had_weapon;
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 0, eflags: 0x0
// Checksum 0x21a20800, Offset: 0xbc0
// Size: 0x70
function player_can_see_weapon_prompt() {
    if (isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching) {
        return true;
    }
    if (isdefined(self zm_loadout::get_player_melee_weapon()) && self hasweapon(self zm_loadout::get_player_melee_weapon())) {
        return false;
    }
    return true;
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 1, eflags: 0x0
// Checksum 0x949e8259, Offset: 0xc38
// Size: 0x250
function function_bec5da73(player) {
    weapon = self.stub.weapon;
    player_has_weapon = player zm_weapons::has_weapon_or_upgrade(weapon);
    if (isdefined(level.func_override_wallbuy_prompt)) {
        if (!self [[ level.func_override_wallbuy_prompt ]](player, player_has_weapon)) {
            return false;
        }
    } else if (zm_trial_disable_buys::is_active()) {
        return false;
    } else if (!player_has_weapon && !player zm_utility::is_drinking()) {
        self.stub.cursor_hint = "HINT_WEAPON";
        cost = zm_weapons::get_weapon_cost(weapon);
        self.stub.hint_string = #"hash_60606b68e93a29c8";
        if (self.stub.var_3cbfae8d) {
            self sethintstringforplayer(player, self.stub.hint_string);
        } else {
            self sethintstring(self.stub.hint_string);
        }
    } else {
        self.stub.hint_string = "";
        if (self.stub.var_3cbfae8d) {
            self sethintstringforplayer(player, self.stub.hint_string);
        } else {
            self sethintstring(self.stub.hint_string);
        }
        return false;
    }
    self.stub.cursor_hint = "HINT_WEAPON";
    self.stub.cursor_hint_weapon = weapon;
    self setcursorhint(self.stub.cursor_hint, self.stub.cursor_hint_weapon);
    return true;
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 0, eflags: 0x0
// Checksum 0x7bebbd92, Offset: 0xe90
// Size: 0x6e
function spectator_respawn_all() {
    for (i = 0; i < level._melee_weapons.size; i++) {
        self spectator_respawn(level._melee_weapons[i].wallbuy_targetname, level._melee_weapons[i].weapon);
    }
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 2, eflags: 0x0
// Checksum 0x147744c7, Offset: 0xf08
// Size: 0x128
function spectator_respawn(wallbuy_targetname, weapon) {
    melee_triggers = getentarray(wallbuy_targetname, "targetname");
    players = getplayers();
    for (i = 0; i < melee_triggers.size; i++) {
        melee_triggers[i] setvisibletoall();
        if (!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)) {
            for (j = 0; j < players.size; j++) {
                if (!players[j] player_can_see_weapon_prompt()) {
                    melee_triggers[i] setinvisibletoplayer(players[j]);
                }
            }
        }
    }
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 0, eflags: 0x0
// Checksum 0x1e1ff06c, Offset: 0x1038
// Size: 0x56
function trigger_hide_all() {
    for (i = 0; i < level._melee_weapons.size; i++) {
        self trigger_hide(level._melee_weapons[i].wallbuy_targetname);
    }
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 1, eflags: 0x0
// Checksum 0xaa4b2ca5, Offset: 0x1098
// Size: 0x7e
function trigger_hide(wallbuy_targetname) {
    melee_triggers = getentarray(wallbuy_targetname, "targetname");
    for (i = 0; i < melee_triggers.size; i++) {
        melee_triggers[i] setinvisibletoplayer(self);
    }
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 0, eflags: 0x0
// Checksum 0x6674b359, Offset: 0x1120
// Size: 0x68
function function_52b66e86() {
    primaryweapons = self getweaponslistprimaries();
    for (i = 0; i < primaryweapons.size; i++) {
        if (primaryweapons[i].isballisticknife) {
            return true;
        }
    }
    return false;
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 0, eflags: 0x0
// Checksum 0x296eabd, Offset: 0x1190
// Size: 0x8a
function function_9f93cad8() {
    primaryweapons = self getweaponslistprimaries();
    for (i = 0; i < primaryweapons.size; i++) {
        if (primaryweapons[i].isballisticknife && zm_weapons::is_weapon_upgraded(primaryweapons[i])) {
            return true;
        }
    }
    return false;
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 2, eflags: 0x0
// Checksum 0x16353d23, Offset: 0x1228
// Size: 0xc8
function function_b81c1f0(weapon, upgraded) {
    current_melee_weapon = self zm_loadout::get_player_melee_weapon();
    if (isdefined(current_melee_weapon)) {
        if (upgraded && isdefined(level.var_499da020) && isdefined(level.var_499da020[current_melee_weapon])) {
            weapon = level.var_499da020[current_melee_weapon];
        }
        if (!upgraded && isdefined(level.var_834ec52d) && isdefined(level.var_834ec52d[current_melee_weapon])) {
            weapon = level.var_834ec52d[current_melee_weapon];
        }
    }
    return weapon;
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 2, eflags: 0x0
// Checksum 0x3ba7c18f, Offset: 0x12f8
// Size: 0x230
function change_melee_weapon(weapon, current_weapon) {
    current_melee_weapon = self zm_loadout::get_player_melee_weapon();
    self zm_loadout::set_player_melee_weapon(weapon);
    if (current_melee_weapon != level.weaponnone && current_melee_weapon != weapon && self hasweapon(current_melee_weapon)) {
        self takeweapon(current_melee_weapon);
    }
    var_b8e08f70 = 0;
    var_c0d5ccf3 = 0;
    var_beeec9b = 0;
    primaryweapons = self getweaponslistprimaries();
    for (i = 0; i < primaryweapons.size; i++) {
        primary_weapon = primaryweapons[i];
        if (primary_weapon.isballisticknife) {
            var_b8e08f70 = 1;
            if (primary_weapon == current_weapon) {
                var_beeec9b = 1;
            }
            self notify(#"hash_1fdb7e931333fd8b");
            self takeweapon(primary_weapon);
            if (zm_weapons::is_weapon_upgraded(primary_weapon)) {
                var_c0d5ccf3 = 1;
            }
        }
    }
    if (var_b8e08f70) {
        if (var_c0d5ccf3) {
            var_c5f559e5 = level.var_499da020[weapon];
            if (var_beeec9b) {
                current_weapon = var_c5f559e5;
            }
            self zm_weapons::give_build_kit_weapon(var_c5f559e5);
        } else {
            var_c5f559e5 = level.var_834ec52d[weapon];
            if (var_beeec9b) {
                current_weapon = var_c5f559e5;
            }
            self giveweapon(var_c5f559e5, 0);
        }
    }
    return current_weapon;
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 7, eflags: 0x0
// Checksum 0xa0ada166, Offset: 0x1530
// Size: 0x610
function melee_weapon_think(weapon, cost, flourish_fn, vo_dialog_id, flourish_weapon, var_834ec52d, var_499da020) {
    self.first_time_triggered = 0;
    if (isdefined(self.stub)) {
        self endon(#"kill_trigger");
        if (isdefined(self.stub.first_time_triggered)) {
            self.first_time_triggered = self.stub.first_time_triggered;
        }
        weapon = self.stub.weapon;
        cost = self.stub.cost;
        flourish_fn = self.stub.flourish_fn;
        vo_dialog_id = self.stub.vo_dialog_id;
        flourish_weapon = self.stub.flourish_weapon;
        var_834ec52d = self.stub.var_834ec52d;
        var_499da020 = self.stub.var_499da020;
        players = getplayers();
        if (!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)) {
            for (i = 0; i < players.size; i++) {
                if (!players[i] player_can_see_weapon_prompt()) {
                    self setinvisibletoplayer(players[i]);
                }
            }
        }
    }
    for (;;) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        if (!zm_utility::is_player_valid(player)) {
            player thread zm_utility::ignore_triggers(0.5);
            continue;
        }
        if (player zm_utility::in_revive_trigger()) {
            wait 0.1;
            continue;
        }
        if (player isthrowinggrenade()) {
            wait 0.1;
            continue;
        }
        if (player zm_utility::is_drinking()) {
            wait 0.1;
            continue;
        }
        if (zm_trial_disable_buys::is_active()) {
            wait 0.1;
            continue;
        }
        player_has_weapon = player hasweapon(weapon);
        if (player_has_weapon || player zm_loadout::has_powerup_weapon()) {
            wait 0.1;
            continue;
        }
        if (player isswitchingweapons()) {
            wait 0.1;
            continue;
        }
        current_weapon = player getcurrentweapon();
        if (zm_loadout::is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon)) {
            wait 0.1;
            continue;
        }
        if (player laststand::player_is_in_laststand() || isdefined(player.intermission) && player.intermission) {
            wait 0.1;
            continue;
        }
        if (isdefined(player.check_override_melee_wallbuy_purchase)) {
            if (player [[ player.check_override_melee_wallbuy_purchase ]](vo_dialog_id, flourish_weapon, weapon, var_834ec52d, var_499da020, flourish_fn, self)) {
                continue;
            }
        }
        if (!player_has_weapon) {
            cost = self.stub.cost;
            if (player zm_score::can_player_purchase(cost)) {
                if (self.first_time_triggered == 0) {
                    model = getent(self.target, "targetname");
                    if (isdefined(model)) {
                        model thread melee_weapon_show(player);
                    } else if (isdefined(self.clientfieldname)) {
                        level clientfield::set(self.clientfieldname, 1);
                    }
                    self.first_time_triggered = 1;
                    if (isdefined(self.stub)) {
                        self.stub.first_time_triggered = 1;
                    }
                }
                player zm_score::minus_to_player_score(cost);
                player zm_callings::function_7cafbdd3(19);
                player zm_callings::function_7cafbdd3(18);
                player thread give_melee_weapon(vo_dialog_id, flourish_weapon, weapon, var_834ec52d, var_499da020, flourish_fn, self);
            } else {
                zm_utility::play_sound_on_ent("no_purchase");
                player zm_audio::create_and_play_dialog("general", "outofmoney", 1);
            }
            continue;
        }
        if (!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)) {
            self setinvisibletoplayer(player);
        }
    }
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 1, eflags: 0x0
// Checksum 0x69db1708, Offset: 0x1b48
// Size: 0x16c
function melee_weapon_show(player) {
    player_angles = vectortoangles(player.origin - self.origin);
    player_yaw = player_angles[1];
    weapon_yaw = self.angles[1];
    yaw_diff = angleclamp180(player_yaw - weapon_yaw);
    if (yaw_diff > 0) {
        yaw = weapon_yaw - 90;
    } else {
        yaw = weapon_yaw + 90;
    }
    self.og_origin = self.origin;
    self.origin += anglestoforward((0, yaw, 0)) * 8;
    waitframe(1);
    self show();
    zm_utility::play_sound_at_pos("weapon_show", self.origin, self);
    time = 1;
    self moveto(self.og_origin, time);
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 1, eflags: 0x0
// Checksum 0x199de21f, Offset: 0x1cc0
// Size: 0xb4
function award_melee_weapon(weapon_name) {
    weapon = getweapon(weapon_name);
    melee_weapon = find_melee_weapon(weapon);
    if (isdefined(melee_weapon)) {
        self give_melee_weapon(melee_weapon.vo_dialog_id, melee_weapon.flourish_weapon, melee_weapon.weapon, melee_weapon.var_834ec52d, melee_weapon.var_499da020, melee_weapon.flourish_fn, undefined);
    }
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 7, eflags: 0x0
// Checksum 0x408ab939, Offset: 0x1d80
// Size: 0x194
function give_melee_weapon(vo_dialog_id, flourish_weapon, weapon, var_834ec52d, var_499da020, flourish_fn, trigger) {
    if (isdefined(flourish_fn)) {
        self thread [[ flourish_fn ]]();
    }
    original_weapon = self do_melee_weapon_flourish_begin(flourish_weapon);
    self zm_audio::create_and_play_dialog("weapon_pickup", vo_dialog_id);
    self waittill(#"fake_death", #"death", #"player_downed", #"weapon_change_complete");
    self do_melee_weapon_flourish_end(original_weapon, flourish_weapon, weapon, var_834ec52d, var_499da020);
    if (self laststand::player_is_in_laststand() || isdefined(self.intermission) && self.intermission) {
        return;
    }
    if (!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)) {
        if (isdefined(trigger)) {
            trigger setinvisibletoplayer(self);
        }
        self trigger_hide_all();
    }
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 1, eflags: 0x0
// Checksum 0xb6263a24, Offset: 0x1f20
// Size: 0xa0
function do_melee_weapon_flourish_begin(flourish_weapon) {
    self zm_utility::increment_is_drinking();
    self zm_utility::disable_player_move_states(1);
    original_weapon = self getcurrentweapon();
    weapon = flourish_weapon;
    self zm_weapons::give_build_kit_weapon(weapon);
    self switchtoweapon(weapon);
    return original_weapon;
}

// Namespace zm_melee_weapon/zm_melee_weapon
// Params 5, eflags: 0x0
// Checksum 0x4b1a2f75, Offset: 0x1fc8
// Size: 0x2b4
function do_melee_weapon_flourish_end(original_weapon, flourish_weapon, weapon, var_834ec52d, var_499da020) {
    assert(!original_weapon.isperkbottle);
    assert(original_weapon != level.weaponrevivetool);
    self zm_utility::enable_player_move_states();
    self takeweapon(flourish_weapon);
    self zm_weapons::give_build_kit_weapon(weapon);
    original_weapon = change_melee_weapon(weapon, original_weapon);
    if (self laststand::player_is_in_laststand() || isdefined(self.intermission) && self.intermission) {
        self.lastactiveweapon = level.weaponnone;
        return;
    }
    if (self hasweapon(level.weaponbasemelee)) {
        self takeweapon(level.weaponbasemelee);
    }
    if (self zm_utility::is_multiple_drinking()) {
        self zm_utility::decrement_is_drinking();
        return;
    } else if (original_weapon == level.weaponbasemelee) {
        self switchtoweapon(weapon);
        self zm_utility::decrement_is_drinking();
        return;
    } else if (original_weapon != level.weaponbasemelee && !zm_loadout::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment(original_weapon)) {
        self zm_weapons::switch_back_primary_weapon(original_weapon);
    } else {
        self zm_weapons::switch_back_primary_weapon();
    }
    self waittill(#"weapon_change_complete");
    if (!self laststand::player_is_in_laststand() && !(isdefined(self.intermission) && self.intermission)) {
        self zm_utility::decrement_is_drinking();
    }
}

