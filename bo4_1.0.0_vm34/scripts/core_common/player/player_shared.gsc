#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace player;

// Namespace player/player_shared
// Params 0, eflags: 0x2
// Checksum 0x66c46f4a, Offset: 0x120
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"player", &__init__, undefined, undefined);
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x769f10cb, Offset: 0x168
// Size: 0x124
function __init__() {
    callback::on_spawned(&on_player_spawned);
    clientfield::register("world", "gameplay_started", 1, 1, "int");
    clientfield::register("toplayer", "gameplay_allows_deploy", 1, 1, "int");
    clientfield::register("toplayer", "player_dof_settings", 1, 2, "int");
    setdvar(#"hash_256144ebda864b87", 1);
    if (!isdefined(getdvarint(#"hash_8351525729015ab", 0))) {
        setdvar(#"hash_8351525729015ab", 0);
    }
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x9387cb3a, Offset: 0x298
// Size: 0x38c
function spawn_player() {
    self endon(#"disconnect", #"joined_spectators");
    self notify(#"spawned");
    level notify(#"player_spawned");
    self notify(#"end_respawn");
    self set_spawn_variables();
    self luinotifyevent(#"player_spawned", 0);
    self luinotifyeventtospectators(#"player_spawned", 0);
    self setclientuivisibilityflag("killcam_nemesis", 0);
    self.sessionteam = self.team;
    self.sessionstate = "playing";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self.statusicon = "";
    self.damagedplayers = [];
    self.friendlydamage = undefined;
    self.hasspawned = 1;
    self.spawntime = gettime();
    self.afk = 0;
    self.laststunnedby = undefined;
    self.var_94ffc146 = undefined;
    self.var_d0b44166 = undefined;
    self.lastflashedby = undefined;
    self.var_8236e828 = undefined;
    self.var_4243ae4 = undefined;
    self.var_9c898c78 = undefined;
    self.var_4de7caf4 = undefined;
    self.laststand = undefined;
    self.resurrect_not_allowed_by = undefined;
    self.revivingteammate = 0;
    self.burning = undefined;
    self.lastshotby = 127;
    self.maxhealth = self.spawnhealth;
    self.health = self.maxhealth;
    self function_26fa96fc();
    if (self.pers[#"lives"] && !(isdefined(level.takelivesondeath) && level.takelivesondeath)) {
        self.pers[#"lives"]--;
        if (self.pers[#"lives"] == 0) {
            level notify(#"player_eliminated");
            self notify(#"player_eliminated");
        }
    }
    if (isdefined(game.lives) && isdefined(game.lives[self.team]) && game.lives[self.team] && !(isdefined(level.takelivesondeath) && level.takelivesondeath)) {
        game.lives[self.team]--;
    }
    self.disabledweapon = 0;
    self util::resetusability();
    self reset_attacker_list();
    self resetfov();
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0xeca9bb04, Offset: 0x630
// Size: 0xfc
function on_player_spawned() {
    if (util::is_frontend_map()) {
        return;
    }
    if (sessionmodeiszombiesgame() || sessionmodeiscampaigngame()) {
        snappedorigin = self get_snapped_spot_origin(self.origin);
        if (!self flagsys::get(#"shared_igc")) {
            self setorigin(snappedorigin);
        }
        update_rate = 0.1;
    }
    if (sessionmodeiswarzonegame()) {
        update_rate = 0.4;
    }
    if (isdefined(update_rate)) {
        self thread last_valid_position(update_rate);
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0x85bb8393, Offset: 0x738
// Size: 0x398
function last_valid_position(update_rate) {
    self notify(#"stop_last_valid_position");
    self endon(#"stop_last_valid_position", #"disconnect");
    while (!isdefined(self.last_valid_position)) {
        self.last_valid_position = getclosestpointonnavmesh(self.origin, 2048, 0);
        wait update_rate;
    }
    while (true) {
        if (isdefined(level.var_e3cc172b) && ![[ level.var_e3cc172b ]]()) {
            wait update_rate;
            continue;
        }
        playerradius = self getpathfindingradius();
        if (distance2dsquared(self.origin, self.last_valid_position) < playerradius * playerradius && (self.origin[2] - self.last_valid_position[2]) * (self.origin[2] - self.last_valid_position[2]) < 16 * 16) {
            wait update_rate;
            continue;
        }
        if (self isplayerswimming()) {
            if (isdefined(self.var_f91d8cc9)) {
                if (distancesquared(self.origin, self.var_f91d8cc9) < playerradius * playerradius) {
                    wait update_rate;
                    continue;
                }
            }
            ground_pos = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"];
            if (!isdefined(ground_pos)) {
                wait update_rate;
                continue;
            }
            position = getclosestpointonnavmesh(ground_pos, 100, playerradius);
            if (isdefined(position)) {
                self.last_valid_position = position;
                self.var_f91d8cc9 = self.origin;
            }
        } else if (ispointonnavmesh(self.origin, self)) {
            self.last_valid_position = self.origin;
        } else if (!ispointonnavmesh(self.origin, self) && ispointonnavmesh(self.last_valid_position, self) && distance2dsquared(self.origin, self.last_valid_position) < 32 * 32) {
            wait update_rate;
            continue;
        } else {
            position = getclosestpointonnavmesh(self.origin, 100, playerradius);
            if (isdefined(position)) {
                self.last_valid_position = position;
            } else if (isdefined(level.var_96884b5e)) {
                self.last_valid_position = self [[ level.var_96884b5e ]](playerradius);
            }
        }
        wait update_rate;
    }
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x7721e01c, Offset: 0xad8
// Size: 0x224
function take_weapons() {
    if (!(isdefined(self.gun_removed) && self.gun_removed)) {
        self.gun_removed = 1;
        self._weapons = [];
        if (!isdefined(self._current_weapon)) {
            self._current_weapon = level.weaponnone;
        }
        w_current = self getcurrentweapon();
        if (w_current != level.weaponnone) {
            self._current_weapon = w_current;
        }
        a_weapon_list = self getweaponslist();
        if (self._current_weapon == level.weaponnone) {
            if (isdefined(a_weapon_list[0])) {
                self._current_weapon = a_weapon_list[0];
            }
        }
        foreach (weapon in a_weapon_list) {
            if (isdefined(weapon.dniweapon) && weapon.dniweapon) {
                continue;
            }
            if (!isdefined(self._weapons)) {
                self._weapons = [];
            } else if (!isarray(self._weapons)) {
                self._weapons = array(self._weapons);
            }
            self._weapons[self._weapons.size] = get_weapondata(weapon);
            self takeweapon(weapon);
        }
        if (isdefined(level.detach_all_weapons)) {
            self [[ level.detach_all_weapons ]]();
        }
    }
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0xcf36f493, Offset: 0xd08
// Size: 0x216
function generate_weapon_data() {
    self._generated_weapons = [];
    if (!isdefined(self._generated_current_weapon)) {
        self._generated_current_weapon = level.weaponnone;
    }
    if (isdefined(self.gun_removed) && self.gun_removed && isdefined(self._weapons)) {
        self._generated_weapons = arraycopy(self._weapons);
        self._generated_current_weapon = self._current_weapon;
        return;
    }
    w_current = self getcurrentweapon();
    if (w_current != level.weaponnone) {
        self._generated_current_weapon = w_current;
    }
    a_weapon_list = self getweaponslist();
    if (self._generated_current_weapon == level.weaponnone) {
        if (isdefined(a_weapon_list[0])) {
            self._generated_current_weapon = a_weapon_list[0];
        }
    }
    foreach (weapon in a_weapon_list) {
        if (isdefined(weapon.dniweapon) && weapon.dniweapon) {
            continue;
        }
        if (!isdefined(self._generated_weapons)) {
            self._generated_weapons = [];
        } else if (!isarray(self._generated_weapons)) {
            self._generated_weapons = array(self._generated_weapons);
        }
        self._generated_weapons[self._generated_weapons.size] = get_weapondata(weapon);
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0x684b948d, Offset: 0xf28
// Size: 0x176
function give_back_weapons(b_immediate = 0) {
    if (isdefined(self._weapons)) {
        foreach (weapondata in self._weapons) {
            weapondata_give(weapondata);
        }
        if (isdefined(self._current_weapon) && self._current_weapon != level.weaponnone) {
            if (b_immediate) {
                self switchtoweaponimmediate(self._current_weapon);
            } else {
                self switchtoweapon(self._current_weapon);
            }
        } else {
            weapon = self loadout::function_3d8b02a0("primary");
            if (isdefined(weapon) && self hasweapon(weapon)) {
                switch_to_primary_weapon(b_immediate);
            }
        }
    }
    self._weapons = undefined;
    self.gun_removed = undefined;
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0x6bbb7ed0, Offset: 0x10a8
// Size: 0x386
function get_weapondata(weapon) {
    weapondata = [];
    if (!isdefined(weapon)) {
        weapon = self getcurrentweapon();
    }
    weapondata[#"weapon"] = weapon.rootweapon.name;
    weapondata[#"attachments"] = util::function_e819f6ec(weapon);
    if (weapon != level.weaponnone) {
        weapondata[#"clip"] = self getweaponammoclip(weapon);
        weapondata[#"stock"] = self getweaponammostock(weapon);
        weapondata[#"fuel"] = self getweaponammofuel(weapon);
        weapondata[#"heat"] = self isweaponoverheating(1, weapon);
        weapondata[#"overheat"] = self isweaponoverheating(0, weapon);
        weapondata[#"renderoptions"] = self getweaponoptions(weapon);
        if (weapon.isriotshield) {
            weapondata[#"health"] = self.weaponhealth;
        }
    } else {
        weapondata[#"clip"] = 0;
        weapondata[#"stock"] = 0;
        weapondata[#"fuel"] = 0;
        weapondata[#"heat"] = 0;
        weapondata[#"overheat"] = 0;
    }
    if (weapon.dualwieldweapon != level.weaponnone) {
        weapondata[#"lh_clip"] = self getweaponammoclip(weapon.dualwieldweapon);
    } else {
        weapondata[#"lh_clip"] = 0;
    }
    if (weapon.altweapon != level.weaponnone) {
        weapondata[#"alt_clip"] = self getweaponammoclip(weapon.altweapon);
        weapondata[#"alt_stock"] = self getweaponammostock(weapon.altweapon);
    } else {
        weapondata[#"alt_clip"] = 0;
        weapondata[#"alt_stock"] = 0;
    }
    return weapondata;
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0xcabf1369, Offset: 0x1438
// Size: 0x294
function weapondata_give(weapondata) {
    weapon = util::get_weapon_by_name(weapondata[#"weapon"], weapondata[#"attachments"]);
    self giveweapon(weapon, weapondata[#"renderoptions"]);
    if (weapon != level.weaponnone) {
        self setweaponammoclip(weapon, weapondata[#"clip"]);
        self setweaponammostock(weapon, weapondata[#"stock"]);
        if (isdefined(weapondata[#"fuel"])) {
            self setweaponammofuel(weapon, weapondata[#"fuel"]);
        }
        if (isdefined(weapondata[#"heat"]) && isdefined(weapondata[#"overheat"])) {
            self setweaponoverheating(weapondata[#"overheat"], weapondata[#"heat"], weapon);
        }
        if (weapon.isriotshield && isdefined(weapondata[#"health"])) {
            self.weaponhealth = weapondata[#"health"];
        }
    }
    if (weapon.dualwieldweapon != level.weaponnone) {
        self setweaponammoclip(weapon.dualwieldweapon, weapondata[#"lh_clip"]);
    }
    if (weapon.altweapon != level.weaponnone) {
        self setweaponammoclip(weapon.altweapon, weapondata[#"alt_clip"]);
        self setweaponammostock(weapon.altweapon, weapondata[#"alt_stock"]);
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0xba233483, Offset: 0x16d8
// Size: 0x8c
function switch_to_primary_weapon(b_immediate = 0) {
    weapon = self loadout::function_3d8b02a0("primary");
    if (is_valid_weapon(weapon)) {
        if (b_immediate) {
            self switchtoweaponimmediate(weapon);
            return;
        }
        self switchtoweapon(weapon);
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0x57f4ae62, Offset: 0x1770
// Size: 0x8c
function function_5260fe8f(b_immediate = 0) {
    weapon = self loadout::function_3d8b02a0("secondary");
    if (is_valid_weapon(weapon)) {
        if (b_immediate) {
            self switchtoweaponimmediate(weapon);
            return;
        }
        self switchtoweapon(weapon);
    }
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x779fe686, Offset: 0x1808
// Size: 0x9c
function fill_current_clip() {
    w_current = self getcurrentweapon();
    if (w_current.isheavyweapon) {
        w_current = self loadout::function_3d8b02a0("primary");
    }
    if (isdefined(w_current) && self hasweapon(w_current)) {
        self setweaponammoclip(w_current, w_current.clipsize);
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0xbfca665e, Offset: 0x18b0
// Size: 0x26
function is_valid_weapon(weaponobject) {
    return isdefined(weaponobject) && weaponobject != level.weaponnone;
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x727281a6, Offset: 0x18e0
// Size: 0x2c
function is_spawn_protected() {
    return gettime() - (isdefined(self.spawntime) ? self.spawntime : 0) <= level.spawnprotectiontimems;
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0xb3ca58b3, Offset: 0x1918
// Size: 0x18
function simple_respawn() {
    self [[ level.onspawnplayer ]](0);
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0xf8499ea9, Offset: 0x1938
// Size: 0x136
function get_snapped_spot_origin(spot_position) {
    snap_max_height = 100;
    size = 15;
    height = size * 2;
    mins = (-1 * size, -1 * size, 0);
    maxs = (size, size, height);
    spot_position = (spot_position[0], spot_position[1], spot_position[2] + 5);
    new_spot_position = (spot_position[0], spot_position[1], spot_position[2] - snap_max_height);
    trace = physicstrace(spot_position, new_spot_position, mins, maxs, self);
    if (trace[#"fraction"] < 1) {
        return trace[#"position"];
    }
    return spot_position;
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0x27fa8e13, Offset: 0x1a78
// Size: 0x1b2
function allow_stance_change(b_allow = 1) {
    if (b_allow) {
        self allowprone(1);
        self allowcrouch(1);
        self allowstand(1);
        return;
    }
    str_stance = self getstance();
    switch (str_stance) {
    case #"prone":
        self allowprone(1);
        self allowcrouch(0);
        self allowstand(0);
        break;
    case #"crouch":
        self allowprone(0);
        self allowcrouch(1);
        self allowstand(0);
        break;
    case #"stand":
        self allowprone(0);
        self allowcrouch(0);
        self allowstand(1);
        break;
    }
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x378bf05f, Offset: 0x1c38
// Size: 0x4c
function set_spawn_variables() {
    resettimeout();
    self stopshellshock();
    self stoprumble("damage_heavy");
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x23d1b157, Offset: 0x1c90
// Size: 0x3e
function reset_attacker_list() {
    self.attackers = [];
    self.attackerdata = [];
    self.attackerdamage = [];
    self.var_aad77fda = [];
    self.firsttimedamaged = 0;
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0x6372e286, Offset: 0x1cd8
// Size: 0x11e
function function_26fa96fc(var_df3d3ac6) {
    if (!isdefined(self.var_759e1044)) {
        self.var_759e1044 = [];
    }
    var_614b2b6f = 0;
    foreach (modifier in self.var_759e1044) {
        var_614b2b6f += modifier;
    }
    basemaxhealth = isdefined(var_df3d3ac6) ? var_df3d3ac6 : self.spawnhealth;
    self.var_63f2cd6e = int(basemaxhealth + var_614b2b6f + (isdefined(level.var_9ef11bf6) ? level.var_9ef11bf6 : 0));
    if (self.var_63f2cd6e < 1) {
        self.var_63f2cd6e = 1;
    }
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x51083ce1, Offset: 0x1e00
// Size: 0x34
function function_581b3131() {
    self notify(#"fully_healed");
    callback::callback(#"fully_healed");
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x9175c3d4, Offset: 0x1e40
// Size: 0x34
function function_9dbfe984() {
    self notify(#"done_healing");
    callback::callback(#"done_healing");
}

// Namespace player/player_shared
// Params 4, eflags: 0x0
// Checksum 0x752647ff, Offset: 0x1e80
// Size: 0xe4
function function_129882c1(modname, value, var_d7c5e732, var_1f037ca) {
    if (!isdefined(self.var_759e1044)) {
        self.var_759e1044 = [];
    }
    self function_3b099e8e(var_d7c5e732);
    can_modify = 1;
    if (level.wound_disabled === 1 && value < 0) {
        can_modify = 0;
    }
    if (can_modify) {
        self.var_759e1044[modname] = value;
    }
    self function_26fa96fc();
    if (!(isdefined(var_1f037ca) && var_1f037ca)) {
        self function_98fb2879();
    }
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x9cfd29b2, Offset: 0x1f70
// Size: 0x4c
function function_98fb2879() {
    if (isdefined(self.var_bffe7e05)) {
        return;
    }
    if (self.health > self.var_63f2cd6e) {
        self.health = self.var_63f2cd6e;
        self function_581b3131();
    }
}

// Namespace player/player_shared
// Params 2, eflags: 0x0
// Checksum 0x424c663, Offset: 0x1fc8
// Size: 0x94
function function_20786ad7(modname, var_1f037ca) {
    if (isdefined(self)) {
        if (!isdefined(self.var_759e1044)) {
            self.var_759e1044 = [];
        }
        var_7d02ba85 = self.var_63f2cd6e;
        self.var_759e1044[modname] = undefined;
        self function_26fa96fc();
        if (!(isdefined(var_1f037ca) && var_1f037ca)) {
            self function_98fb2879();
        }
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0x77dc4116, Offset: 0x2068
// Size: 0xa8
function function_3b099e8e(var_d7c5e732) {
    if (!isdefined(var_d7c5e732)) {
        return;
    }
    foreach (modifier in var_d7c5e732) {
        if (!isdefined(modifier)) {
            continue;
        }
        self function_20786ad7(modifier.name, modifier.var_1f037ca);
    }
}

// Namespace player/player_shared
// Params 2, eflags: 0x0
// Checksum 0xdb313f58, Offset: 0x2118
// Size: 0x94
function function_c68794fe(var_b75f6e20, team) {
    params = {#team:team, #var_b75f6e20:var_b75f6e20};
    self notify(#"joined_team", params);
    level notify(#"joined_team");
    self callback::callback(#"joined_team", params);
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0x2a1db309, Offset: 0x21b8
// Size: 0x9c
function function_7da2050c(var_b75f6e20) {
    params = {#team:#"spectator", #var_b75f6e20:var_b75f6e20};
    self notify(#"joined_spectator", params);
    level notify(#"joined_spectator");
    self callback::callback(#"on_joined_spectator", params);
}

// Namespace player/player_shared
// Params 2, eflags: 0x20 variadic
// Checksum 0xdf16cc74, Offset: 0x2260
// Size: 0xa8
function function_15b6b25d(player_func, ...) {
    players = level.players;
    foreach (player in players) {
        util::single_func_argarray(player, player_func, vararg);
    }
}

// Namespace player/player_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0x6f6286cd, Offset: 0x2310
// Size: 0x98
function function_40a2a4fd(players, player_func, ...) {
    foreach (player in players) {
        util::single_func_argarray(player, player_func, vararg);
    }
}

// Namespace player/player_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0xb0aec5eb, Offset: 0x23b0
// Size: 0xc0
function function_6b8ed28b(team, player_func, ...) {
    players = level.players;
    foreach (player in players) {
        if (player.team == team) {
            util::single_func_argarray(player, player_func, vararg);
        }
    }
}

// Namespace player/player_shared
// Params 2, eflags: 0x20 variadic
// Checksum 0x23442c7f, Offset: 0x2478
// Size: 0xc8
function function_b8a53d1a(player_func, ...) {
    players = level.players;
    foreach (player in players) {
        if (!isdefined(player.pers[#"team"])) {
            continue;
        }
        util::single_func_argarray(player, player_func, vararg);
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0xee9478c8, Offset: 0x2548
// Size: 0x8a
function function_94273df5(notification) {
    players = level.players;
    foreach (player in players) {
        player notify(notification);
    }
}

// Namespace player/player_shared
// Params 2, eflags: 0x0
// Checksum 0x8b2afc17, Offset: 0x25e0
// Size: 0xb6
function init_heal(var_75433659, var_61dff488) {
    var_b538a421 = {#enabled:var_75433659, #rate:0, #var_93dfabb3:0, #var_f26dc4ce:var_61dff488, #var_a750f845:0};
    if (!isdefined(self.heal)) {
        self.heal = var_b538a421;
    }
    if (!isdefined(self.var_63f2cd6e)) {
        self.var_63f2cd6e = self.maxhealth;
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0x43209f44, Offset: 0x26a0
// Size: 0xa6
function figure_out_attacker(eattacker) {
    if (isdefined(eattacker) && !isplayer(eattacker)) {
        team = self.team;
        if (isdefined(eattacker.script_owner)) {
            if (eattacker.script_owner.team != team) {
                eattacker = eattacker.script_owner;
            }
        }
        if (isdefined(eattacker.owner)) {
            eattacker = eattacker.owner;
        }
    }
    return eattacker;
}

