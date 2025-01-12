#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace player;

// Namespace player/player_shared
// Params 0, eflags: 0x2
// Checksum 0xd1eed53a, Offset: 0x268
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("player", &__init__, undefined, undefined);
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x85c680aa, Offset: 0x2a8
// Size: 0x74
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    clientfield::register("world", "gameplay_started", 4000, 1, "int");
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x8a4b813c, Offset: 0x328
// Size: 0x6e
function on_player_connect() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill("level_change");
        var_2ac4da5a = waitresult;
        self thread callback::callback(#"hash_5bd9c78a", var_2ac4da5a);
        waitframe(1);
    }
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0xe8cadf41, Offset: 0x3a0
// Size: 0x2bc
function spawn_player() {
    self endon(#"disconnect");
    self endon(#"joined_spectators");
    self notify(#"spawned");
    level notify(#"player_spawned");
    self notify(#"end_respawn");
    self set_spawn_variables();
    self luinotifyevent(%player_spawned, 0);
    self luinotifyeventtospectators(%player_spawned, 0);
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
    self.laststand = undefined;
    self.resurrect_not_allowed_by = undefined;
    self.revivingteammate = 0;
    self.burning = undefined;
    self.lastshotby = 127;
    self.maxhealth = self.spawnhealth;
    self.health = self.maxhealth;
    if (!isdefined(level.takelivesondeath) || self.pers["lives"] && level.takelivesondeath == 0) {
        self.pers["lives"]--;
        if (self.pers["lives"] == 0) {
            level notify(#"player_eliminated");
            self notify(#"player_eliminated");
        }
    }
    self.disabledweapon = 0;
    self util::resetusability();
    self reset_attacker_list();
    self setdepthoffield(0, 0, 512, 512, 4, 0);
    self resetfov();
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0xfbf93579, Offset: 0x668
// Size: 0x134
function on_player_spawned() {
    mapname = getdvarstring("mapname");
    if (mapname === "core_frontend") {
        return;
    }
    if (sessionmodeiszombiesgame() || sessionmodeiscampaigngame()) {
        snappedorigin = self get_snapped_spot_origin(self.origin);
        if (!self flagsys::get("shared_igc")) {
            self setorigin(snappedorigin);
        }
    }
    var_e158cfcb = !sessionmodeiszombiesgame() && !sessionmodeiscampaigngame();
    if (isdefined(level.var_248798c8) && (!var_e158cfcb || level.var_248798c8)) {
        self thread last_valid_position();
    }
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x17120f5b, Offset: 0x7a8
// Size: 0x21c
function last_valid_position() {
    self endon(#"disconnect");
    self notify(#"stop_last_valid_position");
    self endon(#"stop_last_valid_position");
    while (!isdefined(self.last_valid_position)) {
        self.last_valid_position = getclosestpointonnavmesh(self.origin, 2048, 0);
        wait 0.1;
    }
    while (true) {
        if (distance2dsquared(self.origin, self.last_valid_position) < 15 * 15 && (self.origin[2] - self.last_valid_position[2]) * (self.origin[2] - self.last_valid_position[2]) < 16 * 16) {
            wait 0.1;
            continue;
        }
        if (ispointonnavmesh(self.origin, self)) {
            self.last_valid_position = self.origin;
        } else if (!ispointonnavmesh(self.origin, self) && ispointonnavmesh(self.last_valid_position, self) && distance2dsquared(self.origin, self.last_valid_position) < 32 * 32) {
            wait 0.1;
            continue;
        } else {
            position = getclosestpointonnavmesh(self.origin, 100, 15);
            if (isdefined(position)) {
                self.last_valid_position = position;
            }
        }
        wait 0.1;
    }
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x31d79832, Offset: 0x9d0
// Size: 0x268
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
// Checksum 0x1d5725ea, Offset: 0xc40
// Size: 0x268
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
// Checksum 0xbf1b52b9, Offset: 0xeb0
// Size: 0x186
function give_back_weapons(b_immediate) {
    if (!isdefined(b_immediate)) {
        b_immediate = 0;
    }
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
        } else if (isdefined(self.primaryloadoutweapon) && self hasweapon(self.primaryloadoutweapon)) {
            switch_to_primary_weapon(b_immediate);
        }
    }
    self._weapons = undefined;
    self.gun_removed = undefined;
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0xc086e192, Offset: 0x1040
// Size: 0x30a
function get_weapondata(weapon) {
    weapondata = [];
    if (!isdefined(weapon)) {
        weapon = self getcurrentweapon();
    }
    weapondata["weapon"] = weapon.name;
    if (weapon != level.weaponnone) {
        weapondata["clip"] = self getweaponammoclip(weapon);
        weapondata["stock"] = self getweaponammostock(weapon);
        weapondata["fuel"] = self getweaponammofuel(weapon);
        weapondata["heat"] = self isweaponoverheating(1, weapon);
        weapondata["overheat"] = self isweaponoverheating(0, weapon);
        weapondata["renderOptions"] = self getweaponoptions(weapon);
        weapondata["acvi"] = self getplayerattachmentcosmeticvariantindexes(weapon);
        if (weapon.isriotshield) {
            weapondata["health"] = self.weaponhealth;
        }
    } else {
        weapondata["clip"] = 0;
        weapondata["stock"] = 0;
        weapondata["fuel"] = 0;
        weapondata["heat"] = 0;
        weapondata["overheat"] = 0;
    }
    if (weapon.dualwieldweapon != level.weaponnone) {
        weapondata["lh_clip"] = self getweaponammoclip(weapon.dualwieldweapon);
    } else {
        weapondata["lh_clip"] = 0;
    }
    if (weapon.altweapon != level.weaponnone) {
        weapondata["alt_clip"] = self getweaponammoclip(weapon.altweapon);
        weapondata["alt_stock"] = self getweaponammostock(weapon.altweapon);
    } else {
        weapondata["alt_clip"] = 0;
        weapondata["alt_stock"] = 0;
    }
    return weapondata;
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0xdc38a9ba, Offset: 0x1358
// Size: 0x26c
function weapondata_give(weapondata) {
    weapon = util::get_weapon_by_name(weapondata["weapon"]);
    self giveweapon(weapon, weapondata["renderOptions"], weapondata["acvi"]);
    if (weapon != level.weaponnone) {
        self setweaponammoclip(weapon, weapondata["clip"]);
        self setweaponammostock(weapon, weapondata["stock"]);
        if (isdefined(weapondata["fuel"])) {
            self setweaponammofuel(weapon, weapondata["fuel"]);
        }
        if (isdefined(weapondata["heat"]) && isdefined(weapondata["overheat"])) {
            self setweaponoverheating(weapondata["overheat"], weapondata["heat"], weapon);
        }
        if (weapon.isriotshield && isdefined(weapondata["health"])) {
            self.weaponhealth = weapondata["health"];
        }
    }
    if (weapon.dualwieldweapon != level.weaponnone) {
        self setweaponammoclip(weapon.dualwieldweapon, weapondata["lh_clip"]);
    }
    if (weapon.altweapon != level.weaponnone) {
        self setweaponammoclip(weapon.altweapon, weapondata["alt_clip"]);
        self setweaponammostock(weapon.altweapon, weapondata["alt_stock"]);
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0xcc545cb4, Offset: 0x15d0
// Size: 0x84
function switch_to_primary_weapon(b_immediate) {
    if (!isdefined(b_immediate)) {
        b_immediate = 0;
    }
    if (is_valid_weapon(self.primaryloadoutweapon)) {
        if (b_immediate) {
            self switchtoweaponimmediate(self.primaryloadoutweapon);
            return;
        }
        self switchtoweapon(self.primaryloadoutweapon);
    }
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x36b3d483, Offset: 0x1660
// Size: 0x94
function fill_current_clip() {
    w_current = self getcurrentweapon();
    if (w_current.isheavyweapon) {
        w_current = self.primaryloadoutweapon;
    }
    if (isdefined(w_current) && self hasweapon(w_current)) {
        self setweaponammoclip(w_current, w_current.clipsize);
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0xc2b62e8a, Offset: 0x1700
// Size: 0x28
function is_valid_weapon(weaponobject) {
    return isdefined(weaponobject) && weaponobject != level.weaponnone;
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x10a6baeb, Offset: 0x1730
// Size: 0x34
function is_spawn_protected() {
    return gettime() - (isdefined(self.spawntime) ? self.spawntime : 0) <= level.spawnprotectiontimems;
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x7547bcc7, Offset: 0x1770
// Size: 0x1c
function simple_respawn() {
    self [[ level.onspawnplayer ]](0);
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0x946617f3, Offset: 0x1798
// Size: 0x142
function get_snapped_spot_origin(spot_position) {
    snap_max_height = 100;
    size = 15;
    height = size * 2;
    mins = (-1 * size, -1 * size, 0);
    maxs = (size, size, height);
    spot_position = (spot_position[0], spot_position[1], spot_position[2] + 5);
    new_spot_position = (spot_position[0], spot_position[1], spot_position[2] - snap_max_height);
    trace = physicstrace(spot_position, new_spot_position, mins, maxs, self);
    if (trace["fraction"] < 1) {
        return trace["position"];
    }
    return spot_position;
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0xf92975bf, Offset: 0x18e8
// Size: 0x19e
function allow_stance_change(b_allow) {
    if (!isdefined(b_allow)) {
        b_allow = 1;
    }
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
// Checksum 0x8c0df0eb, Offset: 0x1a90
// Size: 0x4c
function set_spawn_variables() {
    resettimeout();
    self stopshellshock();
    self stoprumble("damage_heavy");
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x193a203c, Offset: 0x1ae8
// Size: 0x34
function reset_attacker_list() {
    self.attackers = [];
    self.attackerdata = [];
    self.attackerdamage = [];
    self.firsttimedamaged = 0;
}

