#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_clone;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_cymbal_monkey;

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x6
// Checksum 0x4b8ff927, Offset: 0x180
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"zm_weap_cymbal_monkey", &function_70a657d8, &postinit, undefined, #"zm_weapons");
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x5 linked
// Checksum 0xe792d943, Offset: 0x1e0
// Size: 0x8c
function private function_70a657d8() {
    level.var_3c9fec21 = 1;
    level.weaponzmcymbalmonkey = getweapon(#"cymbal_monkey");
    zm_loadout::register_lethal_grenade_for_level(#"cymbal_monkey");
    zm::function_84d343d(#"cymbal_monkey", &function_3681e2bc);
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x5 linked
// Checksum 0x2474c8db, Offset: 0x278
// Size: 0x130
function private postinit() {
    if (!cymbal_monkey_exists()) {
        return;
    }
    /#
        level.zombiemode_devgui_cymbal_monkey_give = &player_give_cymbal_monkey;
    #/
    if (is_true(level.legacy_cymbal_monkey)) {
        level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
    } else {
        level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
    }
    level.cymbal_monkeys = [];
    level.var_2f2478f2 = 1;
    if (!isdefined(level.valid_poi_max_radius)) {
        level.valid_poi_max_radius = 150;
    }
    if (!isdefined(level.valid_poi_half_height)) {
        level.valid_poi_half_height = 100;
    }
    if (!isdefined(level.valid_poi_inner_spacing)) {
        level.valid_poi_inner_spacing = 2;
    }
    if (!isdefined(level.valid_poi_radius_from_edges)) {
        level.valid_poi_radius_from_edges = 16;
    }
    if (!isdefined(level.valid_poi_height)) {
        level.valid_poi_height = 36;
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 12, eflags: 0x1 linked
// Checksum 0x56f61362, Offset: 0x3b0
// Size: 0x82
function function_3681e2bc(*inflictor, *attacker, damage, *flags, meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    if (surfacetype === "MOD_IMPACT") {
        return 0;
    }
    return boneindex;
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x0
// Checksum 0x905cdac5, Offset: 0x440
// Size: 0x64
function player_give_cymbal_monkey() {
    w_weapon = level.weaponzmcymbalmonkey;
    if (!self hasweapon(w_weapon)) {
        self giveweapon(w_weapon);
    }
    self thread player_handle_cymbal_monkey();
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x1 linked
// Checksum 0x9809f28e, Offset: 0x4b0
// Size: 0xf6
function player_handle_cymbal_monkey() {
    self notify(#"starting_monkey_watch");
    self endon(#"starting_monkey_watch", #"disconnect");
    attract_dist_diff = level.monkey_attract_dist_diff;
    if (!isdefined(attract_dist_diff)) {
        attract_dist_diff = 16;
    }
    num_attractors = level.num_monkey_attractors;
    if (!isdefined(num_attractors)) {
        num_attractors = 32;
    }
    max_attract_dist = level.monkey_attract_dist;
    if (!isdefined(max_attract_dist)) {
        max_attract_dist = 3000;
    }
    while (true) {
        grenade = get_thrown_monkey();
        self player_throw_cymbal_monkey(grenade, num_attractors, max_attract_dist, attract_dist_diff);
        waitframe(1);
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x1 linked
// Checksum 0x7491d1ba, Offset: 0x5b0
// Size: 0x104
function watch_for_dud(actor) {
    self endon(#"death");
    self waittill(#"grenade_dud");
    self.var_bdd70f6a.dud = 1;
    self playsound(#"zmb_vox_monkey_scream");
    self.monk_scream_vox = 1;
    wait 3;
    if (isdefined(self.var_bdd70f6a)) {
        self.var_bdd70f6a delete();
    }
    if (isdefined(actor)) {
        actor delete();
    }
    if (isdefined(self.damagearea)) {
        self.damagearea delete();
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x1 linked
// Checksum 0x8db3b76, Offset: 0x6c0
// Size: 0x1dc
function watch_for_emp(actor) {
    self endon(#"death");
    if (!zm_utility::should_watch_for_emp()) {
        return;
    }
    while (true) {
        waitresult = level waittill(#"emp_detonate");
        if (distancesquared(waitresult.position, self.origin) < waitresult.radius * waitresult.radius) {
            break;
        }
    }
    self.stun_fx = 1;
    if (isdefined(level._equipment_emp_destroy_fx)) {
        playfx(level._equipment_emp_destroy_fx, self.origin + (0, 0, 5), (0, randomfloat(360), 0));
    }
    wait 0.15;
    self.attract_to_origin = 0;
    self zm_utility::deactivate_zombie_point_of_interest();
    wait 1;
    self detonate();
    wait 1;
    if (isdefined(self.var_bdd70f6a)) {
        self.var_bdd70f6a delete();
    }
    if (isdefined(actor)) {
        actor delete();
    }
    if (isdefined(self.damagearea)) {
        self.damagearea delete();
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x1 linked
// Checksum 0x1199e2f5, Offset: 0x8a8
// Size: 0x54
function clone_player_angles(owner) {
    self endon(#"death");
    owner endon(#"death");
    while (isdefined(self)) {
        self.angles = owner.angles;
        waitframe(1);
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x1 linked
// Checksum 0xf4e676b8, Offset: 0x908
// Size: 0xb6
function show_briefly(showtime) {
    self endon(#"show_owner");
    if (isdefined(self.show_for_time)) {
        self.show_for_time = showtime;
        return;
    }
    self.show_for_time = showtime;
    self setvisibletoall();
    while (self.show_for_time > 0) {
        self.show_for_time -= 0.05;
        waitframe(1);
    }
    self setvisibletoallexceptteam(level.zombie_team);
    self.show_for_time = undefined;
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x1 linked
// Checksum 0x7a065035, Offset: 0x9c8
// Size: 0xb0
function show_owner_on_attack(owner) {
    owner endon(#"hide_owner", #"show_owner");
    self endon(#"explode", #"death", #"grenade_dud");
    owner.show_for_time = undefined;
    for (;;) {
        owner waittill(#"weapon_fired");
        owner thread show_briefly(0.5);
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x1 linked
// Checksum 0x8e2bd917, Offset: 0xa80
// Size: 0x234
function hide_owner(owner) {
    owner notify(#"hide_owner");
    owner endon(#"hide_owner");
    owner setperk("specialty_immunemms");
    owner.no_burning_sfx = 1;
    owner notify(#"stop_flame_sounds");
    owner setvisibletoallexceptteam(level.zombie_team);
    owner.hide_owner = 1;
    if (isdefined(level._effect[#"human_disappears"])) {
        playfx(level._effect[#"human_disappears"], owner.origin);
    }
    self thread show_owner_on_attack(owner);
    evt = self waittill(#"explode", #"death", #"grenade_dud");
    println("<dev string:x38>" + evt._notify);
    owner notify(#"show_owner");
    owner unsetperk("specialty_immunemms");
    if (isdefined(level._effect[#"human_disappears"])) {
        playfx(level._effect[#"human_disappears"], owner.origin);
    }
    owner.no_burning_sfx = undefined;
    owner setvisibletoall();
    owner.hide_owner = undefined;
    owner show();
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x1 linked
// Checksum 0xe0bac8e0, Offset: 0xcc0
// Size: 0x26c
function proximity_detonate(owner) {
    wait 1.5;
    if (!isdefined(self)) {
        return;
    }
    detonateradius = 96;
    explosionradius = detonateradius * 2;
    damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - detonateradius), 512 | 4, detonateradius, detonateradius * 1.5);
    damagearea setexcludeteamfortrigger(owner.team);
    damagearea enablelinkto();
    damagearea linkto(self);
    self.damagearea = damagearea;
    while (isdefined(self)) {
        waitresult = damagearea waittill(#"trigger");
        ent = waitresult.activator;
        if (isdefined(owner) && ent == owner) {
            continue;
        }
        if (isdefined(ent.team) && ent.team == owner.team) {
            continue;
        }
        self playsound(#"wpn_claymore_alert");
        dist = distance(self.origin, ent.origin);
        radiusdamage(self.origin + (0, 0, 12), explosionradius, 1, 1, owner, "MOD_GRENADE_SPLASH", level.weaponzmcymbalmonkey);
        if (isdefined(owner)) {
            self detonate(owner);
        } else {
            self detonate(undefined);
        }
        break;
    }
    if (isdefined(damagearea)) {
        damagearea delete();
    }
}

// Namespace zm_weap_cymbal_monkey/grenade_fire
// Params 1, eflags: 0x44
// Checksum 0x9c06ada6, Offset: 0xf38
// Size: 0xec
function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
    if (eventstruct.weapon.name !== #"cymbal_monkey") {
        return;
    }
    self endon(#"disconnect");
    attract_dist_diff = level.monkey_attract_dist_diff;
    if (!isdefined(attract_dist_diff)) {
        attract_dist_diff = 16;
    }
    num_attractors = level.num_monkey_attractors;
    if (!isdefined(num_attractors)) {
        num_attractors = 32;
    }
    max_attract_dist = level.monkey_attract_dist;
    if (!isdefined(max_attract_dist)) {
        max_attract_dist = 3000;
    }
    grenade = eventstruct.projectile;
    self player_throw_cymbal_monkey(grenade, num_attractors, max_attract_dist, attract_dist_diff);
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 4, eflags: 0x1 linked
// Checksum 0xd05282d9, Offset: 0x1030
// Size: 0x564
function player_throw_cymbal_monkey(e_grenade, num_attractors, max_attract_dist, attract_dist_diff) {
    self endon(#"starting_monkey_watch", #"disconnect");
    if (isdefined(e_grenade)) {
        e_grenade endon(#"death");
        if (self laststand::player_is_in_laststand()) {
            if (isdefined(e_grenade.damagearea)) {
                e_grenade.damagearea delete();
            }
            e_grenade delete();
            return;
        }
        e_grenade ghost();
        e_grenade.angles = self.angles;
        e_grenade.var_bdd70f6a = util::spawn_model(e_grenade.model, e_grenade.origin, e_grenade.angles);
        e_grenade.var_bdd70f6a linkto(e_grenade);
        e_grenade.var_bdd70f6a thread monkey_cleanup(e_grenade);
        e_grenade.var_bdd70f6a playsound(#"hash_68402c92c838b7f7");
        clone = undefined;
        if (is_true(level.cymbal_monkey_dual_view)) {
            e_grenade.var_bdd70f6a setvisibletoallexceptteam(level.zombie_team);
            clone = zm_clone::spawn_player_clone(self, (0, 0, -999), level.cymbal_monkey_clone_weapon, undefined);
            e_grenade.var_bdd70f6a.simulacrum = clone;
            clone zm_clone::clone_animate("idle");
            clone thread clone_player_angles(self);
            clone notsolid();
            clone ghost();
        }
        e_grenade thread watch_for_dud(clone);
        e_grenade thread watch_for_emp(clone);
        info = spawnstruct();
        info.sound_attractors = [];
        e_grenade waittill(#"stationary");
        if (isdefined(level.grenade_planted)) {
            self thread [[ level.grenade_planted ]](e_grenade, e_grenade.var_bdd70f6a);
        }
        if (isdefined(e_grenade)) {
            if (isdefined(clone)) {
                clone forceteleport(e_grenade.origin, e_grenade.angles);
                clone thread hide_owner(self);
                e_grenade thread proximity_detonate(self);
                clone show();
                clone setinvisibletoall();
                clone setvisibletoteam(level.zombie_team);
            }
            e_grenade resetmissiledetonationtime();
            playfxontag(#"hash_5d0dd3293cfdb3dd", e_grenade.var_bdd70f6a, "tag_weapon");
            valid_poi = e_grenade is_on_navmesh(self);
            if (valid_poi && is_true(e_grenade.var_45eaa114)) {
                wait 0.1;
                e_grenade zm_utility::create_zombie_point_of_interest(max_attract_dist, num_attractors, 10000);
                valid_poi = e_grenade zm_utility::create_zombie_point_of_interest_attractor_positions(attract_dist_diff, undefined, level.valid_poi_max_radius, 1);
                if (valid_poi) {
                    e_grenade thread do_monkey_sound(info);
                    e_grenade thread function_875fd1df();
                    level.cymbal_monkeys[level.cymbal_monkeys.size] = e_grenade;
                } else {
                    e_grenade zm_utility::deactivate_zombie_point_of_interest();
                }
            }
            if (!valid_poi) {
                e_grenade.script_noteworthy = undefined;
                level thread grenade_stolen_by_sam(e_grenade, clone);
            }
            return;
        }
        e_grenade.script_noteworthy = undefined;
        level thread grenade_stolen_by_sam(e_grenade, clone);
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x4
// Checksum 0xe6232f08, Offset: 0x15a0
// Size: 0xa6
function private function_ab9a9770() {
    s_trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);
    if (isdefined(s_trace[#"entity"])) {
        entity = s_trace[#"entity"];
        if (entity ismovingplatform()) {
            return true;
        }
    }
    return false;
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x0
// Checksum 0xa89a9453, Offset: 0x1650
// Size: 0x1ae
function function_2f2478f2() {
    v_orig = self.origin;
    queryresult = positionquery_source_navigation(self.origin, 0, level.valid_poi_max_radius, level.valid_poi_half_height, level.valid_poi_inner_spacing, level.valid_poi_radius_from_edges);
    if (queryresult.data.size) {
        foreach (point in queryresult.data) {
            height_offset = abs(self.origin[2] - point.origin[2]);
            if (height_offset > level.valid_poi_height) {
                continue;
            }
            if (zm_utility::check_point_in_enabled_zone(point.origin) && bullettracepassed(point.origin + (0, 0, 20), v_orig + (0, 0, 20), 0, self, undefined, 0, 0)) {
                self.origin = point.origin;
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 2, eflags: 0x1 linked
// Checksum 0xcb9a2c6d, Offset: 0x1808
// Size: 0x2a4
function grenade_stolen_by_sam(e_grenade, e_actor) {
    if (!isdefined(e_grenade.var_bdd70f6a)) {
        return;
    }
    direction = e_grenade.var_bdd70f6a.origin;
    direction = (direction[1], direction[0], 0);
    if (direction[1] < 0 || direction[0] > 0 && direction[1] > 0) {
        direction = (direction[0], direction[1] * -1, 0);
    } else if (direction[0] < 0) {
        direction = (direction[0] * -1, direction[1], 0);
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isalive(players[i])) {
            players[i] playlocalsound(level.zmb_laugh_alias);
        }
    }
    playfxontag(#"hash_733eecf99198ecb9", e_grenade.var_bdd70f6a, "tag_origin");
    e_grenade.var_bdd70f6a unlink();
    e_grenade.var_bdd70f6a movez(60, 1, 0.25, 0.25);
    e_grenade.var_bdd70f6a vibrate(direction, 1.5, 2.5, 1);
    e_grenade.var_bdd70f6a waittill(#"movedone");
    e_grenade.var_bdd70f6a delete();
    if (isdefined(e_actor)) {
        e_actor delete();
    }
    if (isdefined(e_grenade)) {
        if (isdefined(e_grenade.damagearea)) {
            e_grenade.damagearea delete();
        }
        e_grenade delete();
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x1 linked
// Checksum 0x6c00cb1a, Offset: 0x1ab8
// Size: 0x98
function monkey_cleanup(e_grenade) {
    self endon(#"death");
    while (true) {
        if (!isdefined(e_grenade)) {
            if (is_true(self.dud)) {
                wait 6;
            }
            if (isdefined(self.simulacrum)) {
                self.simulacrum delete();
            }
            zm_utility::self_delete();
            return;
        }
        waitframe(1);
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x1 linked
// Checksum 0x5845f179, Offset: 0x1b58
// Size: 0x262
function do_monkey_sound(info) {
    self endon(#"death");
    self.monk_scream_vox = 0;
    if (isdefined(level.grenade_safe_to_bounce)) {
        if (![[ level.grenade_safe_to_bounce ]](self.owner, level.weaponzmcymbalmonkey)) {
            self playsound(#"zmb_vox_monkey_scream");
            self.monk_scream_vox = 1;
        }
    }
    if (!self.monk_scream_vox && isdefined(level.musicsystem) && level.musicsystem.currentplaytype < 4) {
        self playsound(#"hash_4509539f9e7954e2");
    }
    self playloopsound(#"hash_4ac1d6c76c698e02");
    if (!self.monk_scream_vox) {
        self thread play_delayed_explode_vox();
    }
    waitresult = self waittill(#"explode");
    level notify(#"grenade_exploded", waitresult.position);
    self stoploopsound();
    monkey_index = -1;
    for (i = 0; i < level.cymbal_monkeys.size; i++) {
        if (!isdefined(level.cymbal_monkeys[i])) {
            monkey_index = i;
            break;
        }
    }
    if (monkey_index >= 0) {
        arrayremoveindex(level.cymbal_monkeys, monkey_index);
    }
    for (i = 0; i < info.sound_attractors.size; i++) {
        if (isdefined(info.sound_attractors[i])) {
            info.sound_attractors[i] notify(#"monkey_blown_up");
        }
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x1 linked
// Checksum 0xca66a13f, Offset: 0x1dc8
// Size: 0x6c
function function_875fd1df() {
    var_bdd70f6a = self.var_bdd70f6a;
    var_bdd70f6a thread scene::play(#"cin_t8_monkeybomb_dance", var_bdd70f6a);
    while (isdefined(self)) {
        waitframe(1);
    }
    if (isdefined(var_bdd70f6a)) {
        var_bdd70f6a thread scene::stop();
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x1 linked
// Checksum 0x35d91cb0, Offset: 0x1e40
// Size: 0x34
function play_delayed_explode_vox() {
    wait 6.5;
    if (isdefined(self)) {
        self playsound(#"zmb_vox_monkey_explode");
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x1 linked
// Checksum 0x20468cee, Offset: 0x1e80
// Size: 0xc6
function get_thrown_monkey() {
    self endon(#"starting_monkey_watch", #"disconnect");
    while (true) {
        waitresult = self waittill(#"grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        if (weapon == level.weaponzmcymbalmonkey) {
            grenade.use_grenade_special_long_bookmark = 1;
            grenade.grenade_multiattack_bookmark_count = 1;
            grenade.weapon = weapon;
            return grenade;
        }
        waitframe(1);
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x0
// Checksum 0x7b25b9a8, Offset: 0x1f50
// Size: 0x19e
function monitor_zombie_groans(info) {
    self endon(#"explode");
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        if (!isdefined(self.attractor_array)) {
            waitframe(1);
            continue;
        }
        for (i = 0; i < self.attractor_array.size; i++) {
            if (!isinarray(info.sound_attractors, self.attractor_array[i])) {
                if (isdefined(self.origin) && isdefined(self.attractor_array[i].origin)) {
                    if (distancesquared(self.origin, self.attractor_array[i].origin) < 250000) {
                        if (!isdefined(info.sound_attractors)) {
                            info.sound_attractors = [];
                        } else if (!isarray(info.sound_attractors)) {
                            info.sound_attractors = array(info.sound_attractors);
                        }
                        info.sound_attractors[info.sound_attractors.size] = self.attractor_array[i];
                        self.attractor_array[i] thread play_zombie_groans();
                    }
                }
            }
        }
        waitframe(1);
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x1 linked
// Checksum 0xd90a201e, Offset: 0x20f8
// Size: 0x7e
function play_zombie_groans() {
    self endon(#"monkey_blown_up", #"death");
    while (true) {
        if (isdefined(self)) {
            self playsound(#"zmb_vox_zombie_groan");
            wait randomfloatrange(2, 3);
            continue;
        }
        return;
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x1 linked
// Checksum 0x32ff5d7a, Offset: 0x2180
// Size: 0x18
function cymbal_monkey_exists() {
    return level.weaponzmcymbalmonkey != level.weaponnone;
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x1 linked
// Checksum 0xe147777c, Offset: 0x21a0
// Size: 0x224
function is_on_navmesh(e_player) {
    self endon(#"death");
    if (isdefined(e_player)) {
        e_player endon(#"death");
        e_origin = e_player.origin;
    } else {
        e_origin = self.origin;
    }
    if (ispointonnavmesh(self.origin, 60) == 1) {
        self.var_45eaa114 = 1;
        return true;
    }
    v_valid_point = getclosestpointonnavmesh(self.origin, 150, 12);
    if (isdefined(v_valid_point)) {
        var_3fb36683 = zm_utility::check_point_in_enabled_zone(v_valid_point, undefined, undefined);
        if (!is_true(var_3fb36683)) {
            v_dir = vectornormalize(e_origin - self.origin);
            v_pos = self.origin + v_dir * 24;
            v_valid_point = getclosestpointonnavmesh(v_pos, 150, 12);
            if (isdefined(v_valid_point)) {
                var_3fb36683 = zm_utility::check_point_in_enabled_zone(v_valid_point, undefined, undefined);
                if (!is_true(var_3fb36683)) {
                    v_valid_point = undefined;
                }
            }
        }
    }
    if (isdefined(v_valid_point)) {
        self.origin = v_valid_point;
        if (isdefined(self.var_bdd70f6a)) {
            self.var_bdd70f6a.origin = self.origin;
        }
        self.var_45eaa114 = 1;
        return true;
    }
    self.var_45eaa114 = 0;
    return false;
}

