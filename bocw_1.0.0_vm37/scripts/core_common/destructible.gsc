#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace destructible;

// Namespace destructible/destructible
// Params 0, eflags: 0x6
// Checksum 0x26f4ac51, Offset: 0x230
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"destructible", &preinit, undefined, undefined, undefined);
}

// Namespace destructible/destructible
// Params 0, eflags: 0x4
// Checksum 0x99fc13ef, Offset: 0x278
// Size: 0x13c
function private preinit() {
    clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int");
    level.destructible_callbacks = [];
    destructibles = getentarray("destructible", "targetname");
    if (destructibles.size <= 0) {
        return;
    }
    for (i = 0; i < destructibles.size; i++) {
        if (getsubstr(destructibles[i].destructibledef, 0, 4) == "veh_") {
            destructibles[i] thread car_death_think();
            destructibles[i] thread car_grenade_stuck_think();
            continue;
        }
        if (destructibles[i].destructibledef == "fxdest_upl_metal_tank_01") {
            destructibles[i] thread tank_grenade_stuck_think();
        }
    }
}

// Namespace destructible/destructible
// Params 3, eflags: 0x0
// Checksum 0x2caef9d, Offset: 0x3c0
// Size: 0xa4
function physics_explosion_and_rumble(*origin, radius, physics_explosion) {
    assert(radius <= pow(2, 10) - 1);
    if (is_true(physics_explosion)) {
        radius += 1 << 9;
    }
    self clientfield::set("start_destructible_explosion", radius);
}

// Namespace destructible/destructible
// Params 7, eflags: 0x0
// Checksum 0xd08710a6, Offset: 0x470
// Size: 0x506
function event_callback(destructible_event, attacker, weapon, piece_index, point, dir, mod) {
    if (isvehicle(self)) {
        if (isdefined(level.destructible_callbacks[destructible_event])) {
            self thread [[ level.destructible_callbacks[destructible_event] ]](destructible_event, attacker, weapon, piece_index, point, dir, mod);
        }
        return;
    }
    explosion_radius = 0;
    if (issubstr(destructible_event, "explode") && destructible_event != "explode") {
        tokens = strtok(destructible_event, "_");
        explosion_radius = tokens[1];
        if (explosion_radius == "sm") {
            explosion_radius = 150;
        } else if (explosion_radius == "lg") {
            explosion_radius = 450;
        } else {
            explosion_radius = int(explosion_radius);
        }
        destructible_event = "explode_complex";
    }
    physics_explosion = 0;
    if (issubstr(destructible_event, "explosive")) {
        tokens = strtok(destructible_event, "_");
        explosion_radius_type = tokens[3];
        if (explosion_radius_type == "small") {
            explosion_radius = 150;
        } else if (explosion_radius_type == "large") {
            explosion_radius = 450;
        } else {
            explosion_radius = 300;
        }
        if (tokens[4] === "physics") {
            physics_explosion = 1;
        }
    }
    if (issubstr(destructible_event, "simple_timed_explosion")) {
        self thread simple_timed_explosion(destructible_event, attacker);
        return;
    }
    switch (destructible_event) {
    case #"destructible_car_explosion":
        self car_explosion(attacker);
        if (isdefined(weapon)) {
            self.destroyingweapon = weapon;
        }
        break;
    case #"destructible_car_fire":
        self thread car_fire_think(attacker);
        if (isdefined(weapon)) {
            self.destroyingweapon = weapon;
        }
        break;
    case #"explode":
        self thread simple_explosion(attacker);
        break;
    case #"explode_complex":
        self thread complex_explosion(attacker, explosion_radius);
        break;
    case #"destructible_explosive_incendiary_large":
    case #"hash_13b4e4fbd7d961c0":
    case #"destructible_explosive_incendiary_small":
    case #"hash_5c6665f5f23b07a4":
        self explosive_incendiary_explosion(attacker, explosion_radius, physics_explosion);
        if (isdefined(weapon)) {
            self.destroyingweapon = weapon;
        }
        break;
    case #"hash_30141f23e4fc17c":
    case #"destructible_explosive_electrical_small":
    case #"hash_6f46ae8cbb1ddc40":
    case #"destructible_explosive_electrical_large":
        self explosive_electrical_explosion(attacker, explosion_radius, physics_explosion);
        if (isdefined(weapon)) {
            self.destroyingweapon = weapon;
        }
        break;
    case #"hash_321329f9a6ece4e":
    case #"destructible_explosive_concussive_large":
    case #"hash_49e6dd192f5f1686":
    case #"destructible_explosive_concussive_small":
        self explosive_concussive_explosion(attacker, explosion_radius, physics_explosion);
        if (isdefined(weapon)) {
            self.destroyingweapon = weapon;
        }
        break;
    default:
        break;
    }
    if (isdefined(level.destructible_callbacks[destructible_event])) {
        self thread [[ level.destructible_callbacks[destructible_event] ]](destructible_event, attacker, weapon, piece_index, point, dir, mod);
    }
}

// Namespace destructible/destructible
// Params 1, eflags: 0x0
// Checksum 0x33824e45, Offset: 0x980
// Size: 0x134
function simple_explosion(attacker) {
    if (is_true(self.exploded)) {
        return;
    }
    self.exploded = 1;
    offset = (0, 0, 5);
    self radiusdamage(self.origin + offset, 256, 300, 75, attacker, "MOD_EXPLOSIVE", getweapon(#"explodable_barrel"));
    physics_explosion_and_rumble(self.origin, 255, 1);
    if (isdefined(attacker)) {
        self dodamage(self.health + 10000, self.origin + offset, attacker);
        return;
    }
    self dodamage(self.health + 10000, self.origin + offset);
}

// Namespace destructible/destructible
// Params 2, eflags: 0x0
// Checksum 0xed5e69ee, Offset: 0xac0
// Size: 0x124
function simple_timed_explosion(destructible_event, attacker) {
    self endon(#"death");
    wait_times = [];
    str = getsubstr(destructible_event, 23);
    tokens = strtok(str, "_");
    for (i = 0; i < tokens.size; i++) {
        wait_times[wait_times.size] = int(tokens[i]);
    }
    if (wait_times.size <= 0) {
        wait_times[0] = 5;
        wait_times[1] = 10;
    }
    wait randomintrange(wait_times[0], wait_times[1]);
    simple_explosion(attacker);
}

// Namespace destructible/destructible
// Params 2, eflags: 0x0
// Checksum 0x794e3f49, Offset: 0xbf0
// Size: 0x10c
function complex_explosion(attacker, max_radius) {
    offset = (0, 0, 5);
    if (isdefined(attacker)) {
        self radiusdamage(self.origin + offset, max_radius, 300, 100, attacker);
    } else {
        self radiusdamage(self.origin + offset, max_radius, 300, 100);
    }
    physics_explosion_and_rumble(self.origin, max_radius, 1);
    if (isdefined(attacker)) {
        self dodamage(20000, self.origin + offset, attacker);
        return;
    }
    self dodamage(20000, self.origin + offset);
}

// Namespace destructible/destructible
// Params 2, eflags: 0x0
// Checksum 0xb468e40a, Offset: 0xd08
// Size: 0x1b4
function car_explosion(attacker, physics_explosion) {
    if (is_true(self.car_dead)) {
        return;
    }
    if (!isdefined(physics_explosion)) {
        physics_explosion = 1;
    }
    self notify(#"car_dead");
    self.car_dead = 1;
    if (isdefined(attacker)) {
        self radiusdamage(self.origin, 256, 300, 75, attacker, "MOD_EXPLOSIVE", getweapon(#"destructible_car"));
    } else {
        self radiusdamage(self.origin, 256, 300, 75);
    }
    physics_explosion_and_rumble(self.origin, 255, physics_explosion);
    if (isdefined(attacker)) {
        attacker thread challenges::destroyed_car();
    }
    level.globalcarsdestroyed++;
    if (isdefined(attacker)) {
        self dodamage(self.health + 10000, self.origin + (0, 0, 1), attacker);
    } else {
        self dodamage(self.health + 10000, self.origin + (0, 0, 1));
    }
    self markdestructibledestroyed();
}

// Namespace destructible/destructible
// Params 0, eflags: 0x0
// Checksum 0xef4de627, Offset: 0xec8
// Size: 0xe8
function tank_grenade_stuck_think() {
    self endon(#"destructible_base_piece_death", #"death");
    for (;;) {
        waitresult = self waittill(#"grenade_stuck");
        missile = waitresult.projectile;
        if (!isdefined(missile) || !isdefined(missile.model)) {
            continue;
        }
        if (missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world") {
            self thread tank_grenade_stuck_explode(missile);
        }
    }
}

// Namespace destructible/destructible
// Params 1, eflags: 0x0
// Checksum 0x51420bfd, Offset: 0xfb8
// Size: 0x144
function tank_grenade_stuck_explode(missile) {
    self endon(#"destructible_base_piece_death", #"death");
    owner = getmissileowner(missile);
    if (isdefined(owner) && missile.model == "wpn_t7_c4_world") {
        owner endon(#"disconnect", #"weapon_object_destroyed");
        missile endon(#"picked_up");
        missile thread tank_hacked_c4(self);
    }
    missile waittill(#"explode");
    if (isdefined(owner)) {
        self dodamage(self.health + 10000, self.origin + (0, 0, 1), owner);
        return;
    }
    self dodamage(self.health + 10000, self.origin + (0, 0, 1));
}

// Namespace destructible/destructible
// Params 1, eflags: 0x0
// Checksum 0x78b923c6, Offset: 0x1108
// Size: 0x84
function tank_hacked_c4(tank) {
    tank endon(#"destructible_base_piece_death", #"death");
    self endon(#"death");
    self waittill(#"hacked");
    self notify(#"picked_up");
    tank thread tank_grenade_stuck_explode(self);
}

// Namespace destructible/destructible
// Params 0, eflags: 0x0
// Checksum 0xa89ef618, Offset: 0x1198
// Size: 0x84
function car_death_think() {
    self endon(#"car_dead");
    self.car_dead = 0;
    self thread car_death_notify();
    waitresult = self waittill(#"destructible_base_piece_death");
    if (isdefined(self)) {
        self thread car_explosion(waitresult.attacker, 0);
    }
}

// Namespace destructible/destructible
// Params 0, eflags: 0x0
// Checksum 0x5e0e7118, Offset: 0x1228
// Size: 0xf8
function car_grenade_stuck_think() {
    self endon(#"destructible_base_piece_death", #"car_dead", #"death");
    for (;;) {
        waitresult = self waittill(#"grenade_stuck");
        missile = waitresult.projectile;
        if (!isdefined(missile) || !isdefined(missile.model)) {
            continue;
        }
        if (missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world") {
            self thread car_grenade_stuck_explode(missile);
        }
    }
}

// Namespace destructible/destructible
// Params 1, eflags: 0x0
// Checksum 0x31b94fd3, Offset: 0x1328
// Size: 0x154
function car_grenade_stuck_explode(missile) {
    self endon(#"destructible_base_piece_death", #"car_dead", #"death");
    owner = getmissileowner(missile);
    if (isdefined(owner) && missile.model == "wpn_t7_c4_world") {
        owner endon(#"disconnect", #"weapon_object_destroyed");
        missile endon(#"picked_up");
        missile thread car_hacked_c4(self);
    }
    missile waittill(#"explode");
    if (isdefined(owner)) {
        self dodamage(self.health + 10000, self.origin + (0, 0, 1), owner);
        return;
    }
    self dodamage(self.health + 10000, self.origin + (0, 0, 1));
}

// Namespace destructible/destructible
// Params 1, eflags: 0x0
// Checksum 0xd0e65c3b, Offset: 0x1488
// Size: 0x94
function car_hacked_c4(car) {
    car endon(#"destructible_base_piece_death", #"car_dead", #"death");
    self endon(#"death");
    self waittill(#"hacked");
    self notify(#"picked_up");
    car thread car_grenade_stuck_explode(self);
}

// Namespace destructible/destructible
// Params 0, eflags: 0x0
// Checksum 0x90d514b5, Offset: 0x1528
// Size: 0x3e
function car_death_notify() {
    self endon(#"car_dead");
    self notify(#"destructible_base_piece_death", self waittill(#"death"));
}

// Namespace destructible/destructible
// Params 1, eflags: 0x0
// Checksum 0xebf2637a, Offset: 0x1570
// Size: 0x54
function car_fire_think(attacker) {
    self endon(#"death");
    wait randomintrange(7, 10);
    self thread car_explosion(attacker);
}

// Namespace destructible/destructible
// Params 1, eflags: 0x40
// Checksum 0xb7708e88, Offset: 0x15d0
// Size: 0x13c
function event_handler[destructible] codecallback_destructibleevent(eventstruct) {
    if (eventstruct.event == "broken") {
        event_callback(eventstruct.notify_type, eventstruct.attacker, eventstruct.weapon, eventstruct.piece, eventstruct.point, eventstruct.dir, eventstruct.mod);
        self notify(eventstruct.event, {#type:eventstruct.notify_type, #attacker:eventstruct.attacker});
        return;
    }
    if (eventstruct.event == "breakafter") {
        self thread breakafter(eventstruct.time, eventstruct.amount, eventstruct.piece);
        return;
    }
    if (eventstruct.event == "damage entity over time") {
        self thread function_93f99ad9(eventstruct.damage, eventstruct.time_interval);
    }
}

// Namespace destructible/destructible
// Params 2, eflags: 0x0
// Checksum 0xefa2f500, Offset: 0x1718
// Size: 0x58
function function_93f99ad9(damage, time_interval) {
    self endon(#"death");
    while (true) {
        wait time_interval;
        self dodamage(damage, self.origin);
    }
}

// Namespace destructible/destructible
// Params 3, eflags: 0x0
// Checksum 0xce07a885, Offset: 0x1778
// Size: 0x74
function breakafter(time, damage, *piece) {
    self notify(#"breakafter");
    self endon(#"breakafter");
    wait damage;
    if (isdefined(self)) {
        self dodamage(piece, self.origin, undefined, undefined);
    }
}

// Namespace destructible/destructible
// Params 3, eflags: 0x0
// Checksum 0x91767d59, Offset: 0x17f8
// Size: 0x174
function explosive_incendiary_explosion(attacker, explosion_radius, physics_explosion) {
    if (!isvehicle(self)) {
        offset = (0, 0, 5);
        if (isdefined(attacker)) {
            self radiusdamage(self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_BURNED", getweapon(#"incendiary_fire"));
        } else {
            self radiusdamage(self.origin + offset, explosion_radius, 256, 75);
        }
        physics_explosion_and_rumble(self.origin, 255, physics_explosion);
    }
    if (isdefined(self.target)) {
        dest_clip = getent(self.target, "targetname");
        if (isdefined(dest_clip)) {
            dest_clip delete();
        }
    }
    self markdestructibledestroyed();
}

// Namespace destructible/destructible
// Params 3, eflags: 0x0
// Checksum 0xd9833841, Offset: 0x1978
// Size: 0x154
function explosive_electrical_explosion(attacker, explosion_radius, physics_explosion) {
    if (!isvehicle(self)) {
        offset = (0, 0, 5);
        if (isdefined(attacker)) {
            self radiusdamage(self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_ELECTROCUTED");
        } else {
            self radiusdamage(self.origin + offset, explosion_radius, 256, 75);
        }
        physics_explosion_and_rumble(self.origin, 255, physics_explosion);
    }
    if (isdefined(self.target)) {
        dest_clip = getent(self.target, "targetname");
        if (isdefined(dest_clip)) {
            dest_clip delete();
        }
    }
    self markdestructibledestroyed();
}

// Namespace destructible/destructible
// Params 3, eflags: 0x0
// Checksum 0x8e9a2a26, Offset: 0x1ad8
// Size: 0x154
function explosive_concussive_explosion(attacker, explosion_radius, physics_explosion) {
    if (!isvehicle(self)) {
        offset = (0, 0, 5);
        if (isdefined(attacker)) {
            self radiusdamage(self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_GRENADE");
        } else {
            self radiusdamage(self.origin + offset, explosion_radius, 256, 75);
        }
        physics_explosion_and_rumble(self.origin, 255, physics_explosion);
    }
    if (isdefined(self.target)) {
        dest_clip = getent(self.target, "targetname");
        if (isdefined(dest_clip)) {
            dest_clip delete();
        }
    }
    self markdestructibledestroyed();
}

