#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_clone;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_cymbal_monkey;

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x2
// Checksum 0x5d02f694, Offset: 0x148
// Size: 0x54
function autoexec __init__system__() {
    system::register(#"zm_weap_cymbal_monkey", &__init__, &__main__, #"zm_weapons");
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x0
// Checksum 0x674c1a91, Offset: 0x1a8
// Size: 0x74
function __init__() {
    level.weaponzmcymbalmonkey = getweapon(#"cymbal_monkey");
    zm_weapons::register_zombie_weapon_callback(level.weaponzmcymbalmonkey, &player_give_cymbal_monkey);
    zm_loadout::register_lethal_grenade_for_level(#"cymbal_monkey");
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x0
// Checksum 0x995c274d, Offset: 0x228
// Size: 0x172
function __main__() {
    if (!cymbal_monkey_exists()) {
        return;
    }
    /#
        level.zombiemode_devgui_cymbal_monkey_give = &player_give_cymbal_monkey;
    #/
    if (isdefined(level.legacy_cymbal_monkey) && level.legacy_cymbal_monkey) {
        level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
    } else {
        level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
    }
    level._effect[#"monkey_glow"] = #"zm_weapons/fx8_cymbal_monkey_light";
    level._effect[#"grenade_samantha_steal"] = #"hash_7965ec9e0938553f";
    level.cymbal_monkeys = [];
    if (!isdefined(level.valid_poi_max_radius)) {
        level.valid_poi_max_radius = 200;
    }
    if (!isdefined(level.valid_poi_half_height)) {
        level.valid_poi_half_height = 100;
    }
    if (!isdefined(level.valid_poi_inner_spacing)) {
        level.valid_poi_inner_spacing = 2;
    }
    if (!isdefined(level.valid_poi_radius_from_edges)) {
        level.valid_poi_radius_from_edges = 20;
    }
    if (!isdefined(level.valid_poi_height)) {
        level.valid_poi_height = 36;
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x0
// Checksum 0x65625a90, Offset: 0x3a8
// Size: 0x64
function player_give_cymbal_monkey() {
    w_weapon = level.weaponzmcymbalmonkey;
    if (!self hasweapon(w_weapon)) {
        self giveweapon(w_weapon);
    }
    self thread player_handle_cymbal_monkey();
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x0
// Checksum 0x8248b72, Offset: 0x418
// Size: 0xfe
function player_handle_cymbal_monkey() {
    self notify(#"starting_monkey_watch");
    self endon(#"disconnect");
    self endon(#"starting_monkey_watch");
    attract_dist_diff = level.monkey_attract_dist_diff;
    if (!isdefined(attract_dist_diff)) {
        attract_dist_diff = 20;
    }
    num_attractors = level.num_monkey_attractors;
    if (!isdefined(num_attractors)) {
        num_attractors = 96;
    }
    max_attract_dist = level.monkey_attract_dist;
    if (!isdefined(max_attract_dist)) {
        max_attract_dist = 1536;
    }
    while (true) {
        grenade = get_thrown_monkey();
        self player_throw_cymbal_monkey(grenade, num_attractors, max_attract_dist, attract_dist_diff);
        waitframe(1);
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x0
// Checksum 0xa83aef28, Offset: 0x520
// Size: 0x104
function watch_for_dud(actor) {
    self endon(#"death");
    self waittill(#"grenade_dud");
    self.mdl_monkey.dud = 1;
    self playsound(#"zmb_vox_monkey_scream");
    self.monk_scream_vox = 1;
    wait 3;
    if (isdefined(self.mdl_monkey)) {
        self.mdl_monkey delete();
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
// Params 1, eflags: 0x0
// Checksum 0x8027e3b8, Offset: 0x630
// Size: 0x1e4
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
    if (isdefined(self.mdl_monkey)) {
        self.mdl_monkey delete();
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
// Params 1, eflags: 0x0
// Checksum 0xe6929790, Offset: 0x820
// Size: 0x58
function clone_player_angles(owner) {
    self endon(#"death");
    owner endon(#"death");
    while (isdefined(self)) {
        self.angles = owner.angles;
        waitframe(1);
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 1, eflags: 0x0
// Checksum 0x10ca76e3, Offset: 0x880
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
// Params 1, eflags: 0x0
// Checksum 0x700390e7, Offset: 0x940
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
// Params 1, eflags: 0x0
// Checksum 0xd73ad011, Offset: 0x9f8
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
    println("<dev string:x30>" + evt._notify);
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
// Params 1, eflags: 0x0
// Checksum 0x5fbcf563, Offset: 0xc38
// Size: 0x27c
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

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 4, eflags: 0x0
// Checksum 0xa687fdb4, Offset: 0xec0
// Size: 0x5dc
function player_throw_cymbal_monkey(e_grenade, num_attractors, max_attract_dist, attract_dist_diff) {
    self endon(#"disconnect");
    self endon(#"starting_monkey_watch");
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
        e_grenade.mdl_monkey = util::spawn_model(e_grenade.model, e_grenade.origin, e_grenade.angles);
        e_grenade.mdl_monkey linkto(e_grenade);
        e_grenade.mdl_monkey thread monkey_cleanup(e_grenade);
        e_grenade.mdl_monkey playsound(#"hash_68402c92c838b7f7");
        clone = undefined;
        if (isdefined(level.cymbal_monkey_dual_view) && level.cymbal_monkey_dual_view) {
            e_grenade.mdl_monkey setvisibletoallexceptteam(level.zombie_team);
            clone = zm_clone::spawn_player_clone(self, (0, 0, -999), level.cymbal_monkey_clone_weapon, undefined);
            e_grenade.mdl_monkey.simulacrum = clone;
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
            self thread [[ level.grenade_planted ]](e_grenade, e_grenade.mdl_monkey);
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
            playfxontag(level._effect[#"monkey_glow"], e_grenade.mdl_monkey, "tag_weapon");
            valid_poi = zm_utility::check_point_in_enabled_zone(e_grenade.origin, undefined, undefined);
            if (isdefined(level.var_11c66679) && level.var_11c66679) {
                valid_poi = e_grenade function_11c66679(valid_poi);
            }
            if (isdefined(level.var_db78371d)) {
                valid_poi = e_grenade [[ level.var_db78371d ]](valid_poi);
            }
            if (valid_poi) {
                e_grenade zm_utility::create_zombie_point_of_interest(max_attract_dist, num_attractors, 10000);
                valid_poi = e_grenade zm_utility::create_zombie_point_of_interest_attractor_positions(attract_dist_diff, undefined, 300);
                if (valid_poi) {
                    e_grenade thread do_monkey_sound(info);
                    e_grenade thread function_5080ec42();
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
// Checksum 0x4143fee2, Offset: 0x14a8
// Size: 0xae
function private function_bee5b12() {
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
// Params 1, eflags: 0x0
// Checksum 0xb6355188, Offset: 0x1560
// Size: 0x1ce
function function_11c66679(valid_poi) {
    if (!(isdefined(valid_poi) && valid_poi)) {
        return false;
    }
    if (ispointonnavmesh(self.origin)) {
        return true;
    }
    v_orig = self.origin;
    queryresult = positionquery_source_navigation(self.origin, 0, level.valid_poi_max_radius, level.valid_poi_half_height, level.valid_poi_inner_spacing, level.valid_poi_radius_from_edges);
    if (queryresult.data.size) {
        foreach (point in queryresult.data) {
            height_offset = abs(self.origin[2] - point.origin[2]);
            if (height_offset > level.valid_poi_height) {
                continue;
            }
            if (bullettracepassed(point.origin + (0, 0, 20), v_orig + (0, 0, 20), 0, self, undefined, 0, 0)) {
                self.origin = point.origin;
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 2, eflags: 0x0
// Checksum 0xa95bd301, Offset: 0x1738
// Size: 0x2d4
function grenade_stolen_by_sam(e_grenade, e_actor) {
    if (!isdefined(e_grenade.mdl_monkey)) {
        return;
    }
    direction = e_grenade.mdl_monkey.origin;
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
    playfxontag(level._effect[#"grenade_samantha_steal"], e_grenade.mdl_monkey, "tag_origin");
    e_grenade.mdl_monkey unlink();
    e_grenade.mdl_monkey movez(60, 1, 0.25, 0.25);
    e_grenade.mdl_monkey vibrate(direction, 1.5, 2.5, 1);
    e_grenade.mdl_monkey waittill(#"movedone");
    e_grenade.mdl_monkey delete();
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
// Params 1, eflags: 0x0
// Checksum 0x9b97e747, Offset: 0x1a18
// Size: 0x90
function monkey_cleanup(e_grenade) {
    self endon(#"death");
    while (true) {
        if (!isdefined(e_grenade)) {
            if (isdefined(self.dud) && self.dud) {
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
// Params 1, eflags: 0x0
// Checksum 0x24ce898, Offset: 0x1ab0
// Size: 0x258
function do_monkey_sound(info) {
    self endon(#"death");
    self.monk_scream_vox = 0;
    if (isdefined(level.grenade_safe_to_bounce)) {
        if (![[ level.grenade_safe_to_bounce ]](self.owner, level.weaponzmcymbalmonkey)) {
            self playsound(#"zmb_vox_monkey_scream");
            self.monk_scream_vox = 1;
        }
    }
    if (!self.monk_scream_vox && level.musicsystem.currentplaytype < 4) {
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
// Params 0, eflags: 0x0
// Checksum 0x48202bde, Offset: 0x1d10
// Size: 0x7c
function function_5080ec42() {
    mdl_monkey = self.mdl_monkey;
    mdl_monkey thread scene::play(#"cin_t8_monkeybomb_dance", mdl_monkey);
    while (isdefined(self)) {
        waitframe(1);
    }
    if (isdefined(mdl_monkey)) {
        mdl_monkey thread scene::stop(#"cin_t8_monkeybomb_dance", mdl_monkey);
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x0
// Checksum 0x69dd99ef, Offset: 0x1d98
// Size: 0x34
function play_delayed_explode_vox() {
    wait 6.5;
    if (isdefined(self)) {
        self playsound(#"zmb_vox_monkey_explode");
    }
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x0
// Checksum 0x87aea521, Offset: 0x1dd8
// Size: 0xca
function get_thrown_monkey() {
    self endon(#"disconnect");
    self endon(#"starting_monkey_watch");
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
// Checksum 0x93b2fcda, Offset: 0x1eb0
// Size: 0x1b0
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
// Params 0, eflags: 0x0
// Checksum 0x45f2c201, Offset: 0x2068
// Size: 0x7e
function play_zombie_groans() {
    self endon(#"death");
    self endon(#"monkey_blown_up");
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
// Params 0, eflags: 0x0
// Checksum 0x5e1139b2, Offset: 0x20f0
// Size: 0x1a
function cymbal_monkey_exists() {
    return zm_weapons::is_weapon_included(level.weaponzmcymbalmonkey);
}

