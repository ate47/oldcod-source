#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_utility;

#namespace zm_power;

// Namespace zm_power/zm_power
// Params 0, eflags: 0x2
// Checksum 0xf6d070ce, Offset: 0x1d0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_power", &__init__, &__main__, undefined);
}

// Namespace zm_power/zm_power
// Params 0, eflags: 0x0
// Checksum 0xb219da0c, Offset: 0x220
// Size: 0x1e
function __init__() {
    level.powered_items = [];
    level.local_power = [];
}

// Namespace zm_power/zm_power
// Params 0, eflags: 0x0
// Checksum 0x4f8be17f, Offset: 0x248
// Size: 0x44
function __main__() {
    thread standard_powered_items();
    level thread electric_switch_init();
    /#
        thread debug_powered_items();
    #/
}

/#

    // Namespace zm_power/zm_power
    // Params 0, eflags: 0x0
    // Checksum 0xe42b7af6, Offset: 0x298
    // Size: 0xea
    function debug_powered_items() {
        while (true) {
            if (getdvarint(#"zombie_equipment_health", 0)) {
                if (isdefined(level.local_power)) {
                    foreach (localpower in level.local_power) {
                        circle(localpower.origin, localpower.radius, (1, 0, 0), 0, 1, 1);
                    }
                }
            }
            waitframe(1);
        }
    }

#/

// Namespace zm_power/zm_power
// Params 0, eflags: 0x0
// Checksum 0x2f1bf3e5, Offset: 0x390
// Size: 0x84
function electric_switch_init() {
    trigs = getentarray("use_elec_switch", "targetname");
    if (isdefined(level.temporary_power_switch_logic)) {
        array::thread_all(trigs, level.temporary_power_switch_logic, trigs);
        return;
    }
    array::thread_all(trigs, &electric_switch);
}

// Namespace zm_power/zm_power
// Params 0, eflags: 0x0
// Checksum 0x92a52e6b, Offset: 0x420
// Size: 0x768
function electric_switch() {
    self endon(#"hash_21e36726a7f30458");
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.target)) {
        ent_parts = getentarray(self.target, "targetname");
        struct_parts = struct::get_array(self.target, "targetname");
        foreach (ent in ent_parts) {
            if (isdefined(ent.script_noteworthy)) {
                master_switch = ent;
                switch (ent.script_noteworthy) {
                case #"elec_switch":
                    break;
                case #"hash_47bde376753a03c9":
                    break;
                case #"artifact_mind":
                    if (master_switch.model !== #"hash_5b45a93aa747e902") {
                        master_switch util::delay(1, undefined, &clientfield::set, "rob_zm_prop_fade", 1);
                    }
                    master_switch notsolid();
                    master_switch bobbing((0, 0, 1), 0.5, 5);
                    break;
                }
            }
        }
        foreach (struct in struct_parts) {
            if (isdefined(struct.script_noteworthy) && struct.script_noteworthy == "elec_switch_fx") {
                fx_pos = struct;
            }
        }
    }
    while (isdefined(self)) {
        if (isdefined(master_switch) && isdefined(master_switch.script_noteworthy) && !(isdefined(self.var_8b5f088) && self.var_8b5f088)) {
            switch (master_switch.script_noteworthy) {
            case #"elec_switch":
                self sethintstring(#"zombie/electric_switch");
                break;
            case #"hash_47bde376753a03c9":
                self sethintstring(#"zombie/electric_switch");
                break;
            case #"artifact_mind":
                self sethintstring(#"hash_60e4802baafefe56");
                break;
            }
        }
        self setvisibletoall();
        waitresult = self waittill(#"trigger");
        user = waitresult.activator;
        if (isdefined(self.var_58b0b006) && self.var_58b0b006) {
            self.var_8b5f088 = 1;
            waitframe(1);
            continue;
        }
        self setinvisibletoall();
        power_zone = undefined;
        if (isdefined(self.script_int)) {
            power_zone = self.script_int;
        }
        level thread zm_perks::perk_unpause_all_perks(power_zone);
        if (isdefined(master_switch) && isdefined(master_switch.script_noteworthy)) {
            switch (master_switch.script_noteworthy) {
            case #"elec_switch":
                elec_switch_on(master_switch, fx_pos);
                break;
            case #"hash_47bde376753a03c9":
                function_fff28a65(master_switch);
                break;
            case #"artifact_mind":
                artifact_mind_on(master_switch, fx_pos, user);
                break;
            }
        }
        level turn_power_on_and_open_doors(power_zone);
        switchentnum = self getentitynumber();
        if (isdefined(switchentnum) && isdefined(user)) {
            user recordmapevent(17, gettime(), user.origin, level.round_number, switchentnum);
        }
        if (!isdefined(self.script_noteworthy) || self.script_noteworthy != "allow_power_off") {
            self delete();
            return;
        }
        if (isdefined(master_switch) && isdefined(master_switch.script_noteworthy)) {
            switch (master_switch.script_noteworthy) {
            case #"elec_switch":
                self sethintstring(#"hash_3071a199ee6ad7a6");
                break;
            }
        }
        self setvisibletoall();
        waitresult = self waittill(#"trigger");
        user = waitresult.activator;
        self setinvisibletoall();
        level thread zm_perks::perk_pause_all_perks(power_zone);
        if (isdefined(master_switch) && isdefined(master_switch.script_noteworthy)) {
            switch (master_switch.script_noteworthy) {
            case #"elec_switch":
                elec_switch_off(master_switch);
                break;
            }
        }
        if (isdefined(switchentnum) && isdefined(user)) {
            user recordmapevent(18, gettime(), user.origin, level.round_number, switchentnum);
        }
        level turn_power_off_and_close_doors(power_zone);
    }
}

// Namespace zm_power/zm_power
// Params 2, eflags: 0x0
// Checksum 0x3a256386, Offset: 0xb90
// Size: 0x84
function elec_switch_on(master_switch, fx_pos) {
    master_switch rotateroll(-90, 0.3);
    master_switch waittill(#"rotatedone");
    if (isdefined(fx_pos)) {
        playfx(level._effect[#"switch_sparks"], fx_pos.origin);
    }
}

// Namespace zm_power/zm_power
// Params 1, eflags: 0x0
// Checksum 0xb347fa89, Offset: 0xc20
// Size: 0x44
function elec_switch_off(master_switch) {
    master_switch rotateroll(90, 0.3);
    master_switch waittill(#"rotatedone");
}

// Namespace zm_power/zm_power
// Params 1, eflags: 0x0
// Checksum 0x420a6ba8, Offset: 0xc70
// Size: 0x74
function function_fff28a65(master_switch) {
    if (isdefined(master_switch.model_on)) {
        master_switch setmodel(master_switch.model_on);
    }
    if (isdefined(master_switch.bundle)) {
        master_switch thread scene::play(master_switch.bundle, "ON", master_switch);
    }
}

// Namespace zm_power/zm_power
// Params 3, eflags: 0x0
// Checksum 0x60f51115, Offset: 0xcf0
// Size: 0x114
function artifact_mind_on(master_switch, fx_pos, user) {
    level notify(#"hash_3e80d503318a5674", {#player:user});
    if (master_switch.model === #"hash_5b45a93aa747e902") {
        return;
    }
    master_switch moveto(user.origin + (0, 0, 48), 0.3);
    master_switch playsound(#"hash_8af14b85ea364b5");
    master_switch clientfield::set("rob_zm_prop_fade", 0);
    master_switch waittill(#"movedone");
    master_switch delete();
}

// Namespace zm_power/zm_power
// Params 0, eflags: 0x0
// Checksum 0x6f621812, Offset: 0xe10
// Size: 0x80
function watch_global_power() {
    while (true) {
        level flag::wait_till("power_on");
        level thread set_global_power(1);
        level flag::wait_till_clear("power_on");
        level thread set_global_power(0);
    }
}

// Namespace zm_power/zm_power
// Params 0, eflags: 0x0
// Checksum 0x1639705, Offset: 0xe98
// Size: 0x374
function standard_powered_items() {
    level flag::wait_till("start_zombie_round_logic");
    vending_machines = zm_perks::get_perk_machines();
    foreach (trigger in vending_machines) {
        powered_on = zm_perks::get_perk_machine_start_state(trigger.script_noteworthy);
        powered_perk = add_powered_item(&perk_power_on, &perk_power_off, &perk_range, &cost_low_if_local, 0, powered_on, trigger);
        if (isdefined(trigger.script_int)) {
            powered_perk thread zone_controlled_perk(trigger.script_int);
        }
    }
    if (zm_custom::function_5638f689(#"zmpowerdoorstate") != 0) {
        zombie_doors = getentarray("zombie_door", "targetname");
        foreach (door in zombie_doors) {
            if (isdefined(door.script_noteworthy) && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
                add_powered_item(&door_power_on, &door_power_off, &door_range, &cost_door, 0, 0, door);
                continue;
            }
            if (isdefined(door.script_noteworthy) && door.script_noteworthy == "local_electric_door") {
                power_sources = 0;
                if (!(isdefined(level.power_local_doors_globally) && level.power_local_doors_globally)) {
                    power_sources = 1;
                }
                add_powered_item(&door_local_power_on, &door_local_power_off, &door_range, &cost_door, power_sources, 0, door);
            }
        }
    }
    thread watch_global_power();
}

// Namespace zm_power/zm_power
// Params 1, eflags: 0x0
// Checksum 0xdb5560ab, Offset: 0x1218
// Size: 0x90
function zone_controlled_perk(zone) {
    while (true) {
        power_flag = "power_on" + zone;
        level flag::wait_till(power_flag);
        self thread perk_power_on();
        level flag::wait_till_clear(power_flag);
        self thread perk_power_off();
    }
}

// Namespace zm_power/zm_power
// Params 7, eflags: 0x0
// Checksum 0xc5faf4a6, Offset: 0x12b0
// Size: 0x112
function add_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target) {
    powered = spawnstruct();
    powered.power_on_func = power_on_func;
    powered.power_off_func = power_off_func;
    powered.range_func = range_func;
    powered.power_sources = power_sources;
    powered.self_powered = self_powered;
    powered.target = target;
    powered.cost_func = cost_func;
    powered.power = self_powered;
    powered.powered_count = self_powered;
    powered.depowered_count = 0;
    level.powered_items[level.powered_items.size] = powered;
    return powered;
}

// Namespace zm_power/zm_power
// Params 1, eflags: 0x0
// Checksum 0xb15968fa, Offset: 0x13d0
// Size: 0x2c
function remove_powered_item(powered) {
    arrayremovevalue(level.powered_items, powered, 0);
}

// Namespace zm_power/zm_power
// Params 7, eflags: 0x0
// Checksum 0x8252f2ff, Offset: 0x1408
// Size: 0x1a0
function add_temp_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target) {
    powered = add_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target);
    if (isdefined(level.local_power)) {
        foreach (localpower in level.local_power) {
            if (powered [[ powered.range_func ]](1, localpower.origin, localpower.radius)) {
                powered change_power(1, localpower.origin, localpower.radius);
                if (!isdefined(localpower.added_list)) {
                    localpower.added_list = [];
                }
                localpower.added_list[localpower.added_list.size] = powered;
            }
        }
    }
    thread watch_temp_powered_item(powered);
    return powered;
}

// Namespace zm_power/zm_power
// Params 1, eflags: 0x0
// Checksum 0xa859482b, Offset: 0x15b0
// Size: 0x118
function watch_temp_powered_item(powered) {
    powered.target waittill(#"death");
    remove_powered_item(powered);
    if (isdefined(level.local_power)) {
        foreach (localpower in level.local_power) {
            if (isdefined(localpower.added_list)) {
                arrayremovevalue(localpower.added_list, powered, 0);
            }
            if (isdefined(localpower.enabled_list)) {
                arrayremovevalue(localpower.enabled_list, powered, 0);
            }
        }
    }
}

// Namespace zm_power/zm_power
// Params 3, eflags: 0x0
// Checksum 0x7fab2e92, Offset: 0x16d0
// Size: 0xe4
function change_power_in_radius(delta, origin, radius) {
    changed_list = [];
    for (i = 0; i < level.powered_items.size; i++) {
        powered = level.powered_items[i];
        if (powered.power_sources != 2 && powered [[ powered.range_func ]](delta, origin, radius)) {
            powered change_power(delta, origin, radius);
            changed_list[changed_list.size] = powered;
        }
    }
    return changed_list;
}

// Namespace zm_power/zm_power
// Params 3, eflags: 0x0
// Checksum 0xf47f5dcc, Offset: 0x17c0
// Size: 0xa8
function change_power(delta, origin, radius) {
    if (delta > 0) {
        if (!self.power) {
            self.power = 1;
            self [[ self.power_on_func ]](origin, radius);
        }
        self.powered_count++;
        return;
    }
    if (delta < 0) {
        if (self.power) {
            self.power = 0;
            self [[ self.power_off_func ]](origin, radius);
        }
        self.depowered_count++;
    }
}

// Namespace zm_power/zm_power
// Params 4, eflags: 0x0
// Checksum 0x87253f3c, Offset: 0x1870
// Size: 0x7e
function revert_power_to_list(delta, origin, radius, powered_list) {
    for (i = 0; i < powered_list.size; i++) {
        powered = powered_list[i];
        powered revert_power(delta, origin, radius);
    }
}

// Namespace zm_power/zm_power
// Params 4, eflags: 0x0
// Checksum 0xbdcbb720, Offset: 0x18f8
// Size: 0x130
function revert_power(delta, origin, radius, powered_list) {
    if (delta > 0) {
        self.depowered_count--;
        assert(self.depowered_count >= 0, "<dev string:x30>");
        if (self.depowered_count == 0 && self.powered_count > 0 && !self.power) {
            self.power = 1;
            self [[ self.power_on_func ]](origin, radius);
        }
        return;
    }
    if (delta < 0) {
        self.powered_count--;
        assert(self.powered_count >= 0, "<dev string:x52>");
        if (self.powered_count == 0 && self.power) {
            self.power = 0;
            self [[ self.power_off_func ]](origin, radius);
        }
    }
}

// Namespace zm_power/zm_power
// Params 2, eflags: 0x0
// Checksum 0x8deb06f9, Offset: 0x1a30
// Size: 0xce
function add_local_power(origin, radius) {
    localpower = spawnstruct();
    println("<dev string:x74>" + origin + "<dev string:x91>" + radius + "<dev string:x9a>");
    localpower.origin = origin;
    localpower.radius = radius;
    localpower.enabled_list = change_power_in_radius(1, origin, radius);
    level.local_power[level.local_power.size] = localpower;
    return localpower;
}

// Namespace zm_power/zm_power
// Params 2, eflags: 0x0
// Checksum 0x85e434e3, Offset: 0x1b08
// Size: 0x1ba
function move_local_power(localpower, origin) {
    changed_list = [];
    for (i = 0; i < level.powered_items.size; i++) {
        powered = level.powered_items[i];
        if (powered.power_sources == 2) {
            continue;
        }
        waspowered = isinarray(localpower.enabled_list, powered);
        ispowered = powered [[ powered.range_func ]](1, origin, localpower.radius);
        if (ispowered && !waspowered) {
            powered change_power(1, origin, localpower.radius);
            localpower.enabled_list[localpower.enabled_list.size] = powered;
            continue;
        }
        if (!ispowered && waspowered) {
            powered revert_power(-1, localpower.origin, localpower.radius, localpower.enabled_list);
            arrayremovevalue(localpower.enabled_list, powered, 0);
        }
    }
    localpower.origin = origin;
    return localpower;
}

// Namespace zm_power/zm_power
// Params 1, eflags: 0x0
// Checksum 0x42818dd5, Offset: 0x1cd0
// Size: 0x114
function end_local_power(localpower) {
    println("<dev string:x9c>" + localpower.origin + "<dev string:x91>" + localpower.radius + "<dev string:x9a>");
    if (isdefined(localpower.enabled_list)) {
        revert_power_to_list(-1, localpower.origin, localpower.radius, localpower.enabled_list);
    }
    localpower.enabled_list = undefined;
    if (isdefined(localpower.added_list)) {
        revert_power_to_list(-1, localpower.origin, localpower.radius, localpower.added_list);
    }
    localpower.added_list = undefined;
    arrayremovevalue(level.local_power, localpower, 0);
}

// Namespace zm_power/zm_power
// Params 1, eflags: 0x0
// Checksum 0xe423c94c, Offset: 0x1df0
// Size: 0xc4
function has_local_power(origin) {
    if (isdefined(level.local_power)) {
        foreach (localpower in level.local_power) {
            if (distancesquared(localpower.origin, origin) < localpower.radius * localpower.radius) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_power/zm_power
// Params 0, eflags: 0x0
// Checksum 0x99cad51, Offset: 0x1ec0
// Size: 0xa4
function get_powered_item_cost() {
    if (!(isdefined(self.power) && self.power)) {
        return 0;
    }
    if (isdefined(level._power_global) && level._power_global && !(self.power_sources == 1)) {
        return 0;
    }
    cost = [[ self.cost_func ]]();
    power_sources = self.powered_count;
    if (power_sources < 1) {
        power_sources = 1;
    }
    return cost / power_sources;
}

// Namespace zm_power/zm_power
// Params 1, eflags: 0x0
// Checksum 0xafefd1da, Offset: 0x1f70
// Size: 0x158
function get_local_power_cost(localpower) {
    cost = 0;
    if (isdefined(localpower) && isdefined(localpower.enabled_list)) {
        foreach (powered in localpower.enabled_list) {
            cost += powered get_powered_item_cost();
        }
    }
    if (isdefined(localpower) && isdefined(localpower.added_list)) {
        foreach (powered in localpower.added_list) {
            cost += powered get_powered_item_cost();
        }
    }
    return cost;
}

// Namespace zm_power/zm_power
// Params 1, eflags: 0x0
// Checksum 0xb877e8c2, Offset: 0x20d0
// Size: 0xfe
function set_global_power(on_off) {
    demo::bookmark(#"zm_power", gettime(), undefined, undefined, 1);
    potm::bookmark(#"zm_power", gettime(), undefined, undefined, 1);
    level._power_global = on_off;
    for (i = 0; i < level.powered_items.size; i++) {
        powered = level.powered_items[i];
        if (isdefined(powered.target) && powered.power_sources != 1) {
            powered global_power(on_off);
            util::wait_network_frame();
        }
    }
}

// Namespace zm_power/zm_power
// Params 1, eflags: 0x0
// Checksum 0x20c0235c, Offset: 0x21d8
// Size: 0xfc
function global_power(on_off) {
    if (on_off) {
        println("<dev string:xba>");
        if (!self.power) {
            self.power = 1;
            self [[ self.power_on_func ]]();
        }
        self.powered_count++;
        return;
    }
    println("<dev string:xd5>");
    self.powered_count--;
    assert(self.powered_count >= 0, "<dev string:x52>");
    if (self.powered_count == 0 && self.power) {
        self.power = 0;
        self [[ self.power_off_func ]]();
    }
}

// Namespace zm_power/zm_power
// Params 2, eflags: 0x0
// Checksum 0x52607fc2, Offset: 0x22e0
// Size: 0x14
function never_power_on(origin, radius) {
    
}

// Namespace zm_power/zm_power
// Params 2, eflags: 0x0
// Checksum 0x594ce5a6, Offset: 0x2300
// Size: 0x14
function never_power_off(origin, radius) {
    
}

// Namespace zm_power/zm_power
// Params 0, eflags: 0x0
// Checksum 0x5b93746d, Offset: 0x2320
// Size: 0x32
function cost_negligible() {
    if (isdefined(self.one_time_cost)) {
        cost = self.one_time_cost;
        self.one_time_cost = undefined;
        return cost;
    }
    return 0;
}

// Namespace zm_power/zm_power
// Params 0, eflags: 0x0
// Checksum 0x4f035953, Offset: 0x2360
// Size: 0x72
function cost_low_if_local() {
    if (isdefined(self.one_time_cost)) {
        cost = self.one_time_cost;
        self.one_time_cost = undefined;
        return cost;
    }
    if (isdefined(level._power_global) && level._power_global || isdefined(self.self_powered) && self.self_powered) {
        return 0;
    }
    return 1;
}

// Namespace zm_power/zm_power
// Params 0, eflags: 0x0
// Checksum 0x90445226, Offset: 0x23e0
// Size: 0x34
function cost_high() {
    if (isdefined(self.one_time_cost)) {
        cost = self.one_time_cost;
        self.one_time_cost = undefined;
        return cost;
    }
    return 10;
}

// Namespace zm_power/zm_power
// Params 3, eflags: 0x0
// Checksum 0xaf117633, Offset: 0x2420
// Size: 0x60
function door_range(delta, origin, radius) {
    if (delta < 0) {
        return false;
    }
    if (distancesquared(self.target.origin, origin) < radius * radius) {
        return true;
    }
    return false;
}

// Namespace zm_power/zm_power
// Params 2, eflags: 0x0
// Checksum 0x32d1776c, Offset: 0x2488
// Size: 0x5c
function door_power_on(origin, radius) {
    println("<dev string:xf1>");
    self.target.power_on = 1;
    self.target notify(#"power_on");
}

// Namespace zm_power/zm_power
// Params 2, eflags: 0x0
// Checksum 0xb3b07bad, Offset: 0x24f0
// Size: 0x5e
function door_power_off(origin, radius) {
    println("<dev string:x106>");
    self.target notify(#"power_off");
    self.target.power_on = 0;
}

// Namespace zm_power/zm_power
// Params 2, eflags: 0x0
// Checksum 0xb1a3289e, Offset: 0x2558
// Size: 0x5c
function door_local_power_on(origin, radius) {
    println("<dev string:x11c>");
    self.target.local_power_on = 1;
    self.target notify(#"local_power_on");
}

// Namespace zm_power/zm_power
// Params 2, eflags: 0x0
// Checksum 0x2870572c, Offset: 0x25c0
// Size: 0x5e
function door_local_power_off(origin, radius) {
    println("<dev string:x139>");
    self.target notify(#"local_power_off");
    self.target.local_power_on = 0;
}

// Namespace zm_power/zm_power
// Params 0, eflags: 0x0
// Checksum 0x18336e29, Offset: 0x2628
// Size: 0x92
function cost_door() {
    if (isdefined(self.target.power_cost)) {
        if (!isdefined(self.one_time_cost)) {
            self.one_time_cost = 0;
        }
        self.one_time_cost += self.target.power_cost;
        self.target.power_cost = 0;
    }
    if (isdefined(self.one_time_cost)) {
        cost = self.one_time_cost;
        self.one_time_cost = undefined;
        return cost;
    }
    return 0;
}

// Namespace zm_power/zm_power
// Params 3, eflags: 0x0
// Checksum 0x435ccc94, Offset: 0x26c8
// Size: 0x7e
function zombie_range(delta, origin, radius) {
    if (delta > 0) {
        return false;
    }
    self.zombies = array::get_all_closest(origin, zombie_utility::get_round_enemy_array(), undefined, undefined, radius);
    if (!isdefined(self.zombies)) {
        return false;
    }
    self.power = 1;
    return true;
}

// Namespace zm_power/zm_power
// Params 2, eflags: 0x0
// Checksum 0x3ee4c438, Offset: 0x2750
// Size: 0x84
function zombie_power_off(origin, radius) {
    println("<dev string:x157>");
    for (i = 0; i < self.zombies.size; i++) {
        self.zombies[i] thread stun_zombie();
        waitframe(1);
    }
}

// Namespace zm_power/zm_power
// Params 0, eflags: 0x0
// Checksum 0xffebc9e, Offset: 0x27e0
// Size: 0xa2
function stun_zombie() {
    self notify(#"stun_zombie");
    self endon(#"death", #"stun_zombie");
    if (self.health <= 0) {
        /#
            iprintln("<dev string:x170>");
        #/
        return;
    }
    if (isdefined(self.ignore_inert) && self.ignore_inert) {
        return;
    }
    if (isdefined(self.stun_zombie)) {
        self thread [[ self.stun_zombie ]]();
        return;
    }
}

// Namespace zm_power/zm_power
// Params 3, eflags: 0x0
// Checksum 0x7b9064b0, Offset: 0x2890
// Size: 0xf0
function perk_range(delta, origin, radius) {
    if (isdefined(self.target)) {
        perkorigin = self.target.origin;
        if (isdefined(self.target.trigger_off) && self.target.trigger_off) {
            perkorigin = self.target.realorigin;
        } else if (isdefined(self.target.disabled) && self.target.disabled) {
            perkorigin += (0, 0, 10000);
        }
        if (distancesquared(perkorigin, origin) < radius * radius) {
            return true;
        }
    }
    return false;
}

// Namespace zm_power/zm_power
// Params 2, eflags: 0x0
// Checksum 0x95f9a53a, Offset: 0x2988
// Size: 0x9c
function perk_power_on(origin, radius) {
    println("<dev string:x18d>" + self.target zm_perks::getvendingmachinenotify() + "<dev string:x19f>");
    level notify(self.target zm_perks::getvendingmachinenotify() + "_on");
    zm_perks::perk_unpause(self.target.script_noteworthy);
}

// Namespace zm_power/zm_power
// Params 2, eflags: 0x0
// Checksum 0x4823dc0, Offset: 0x2a30
// Size: 0x17a
function perk_power_off(origin, radius) {
    notify_name = self.target zm_perks::getvendingmachinenotify();
    if (isdefined(notify_name) && notify_name == "revive") {
        if (level flag::exists("solo_game") && level flag::get("solo_game")) {
            return;
        }
    }
    println("<dev string:x18d>" + self.target.script_noteworthy + "<dev string:x1a4>");
    self.target notify(#"death");
    self.target thread zm_perks::vending_trigger_think();
    if (isdefined(self.target.perk_hum)) {
        self.target.perk_hum delete();
    }
    zm_perks::perk_pause(self.target.script_noteworthy);
    level notify(self.target zm_perks::getvendingmachinenotify() + "_off");
}

// Namespace zm_power/zm_power
// Params 1, eflags: 0x0
// Checksum 0x27b53355, Offset: 0x2bb8
// Size: 0x2bc
function turn_power_on_and_open_doors(power_zone) {
    level.local_doors_stay_open = 1;
    level.power_local_doors_globally = 1;
    if (!isdefined(power_zone)) {
        level flag::set("power_on");
        level clientfield::set("zombie_power_on", 0);
    } else {
        level flag::set("power_on" + power_zone);
        level clientfield::set("zombie_power_on", power_zone);
    }
    if (zm_custom::function_5638f689(#"zmpowerdoorstate") != 0) {
        zombie_doors = getentarray("zombie_door", "targetname");
        foreach (door in zombie_doors) {
            if (!isdefined(door.script_noteworthy)) {
                continue;
            }
            if (!isdefined(power_zone) && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
                door notify(#"power_on");
                continue;
            }
            if (isdefined(door.script_int) && door.script_int == power_zone && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
                door notify(#"power_on");
                if (isdefined(level.temporary_power_switch_logic)) {
                    door.power_on = 1;
                }
                continue;
            }
            if (isdefined(door.script_int) && door.script_int == power_zone && door.script_noteworthy === "local_electric_door") {
                door notify(#"local_power_on");
            }
        }
    }
}

// Namespace zm_power/zm_power
// Params 1, eflags: 0x0
// Checksum 0xd0c43f42, Offset: 0x2e80
// Size: 0x2ec
function turn_power_off_and_close_doors(power_zone) {
    level.local_doors_stay_open = 0;
    level.power_local_doors_globally = 0;
    if (!isdefined(power_zone)) {
        level flag::clear("power_on");
        level clientfield::set("zombie_power_off", 0);
    } else {
        level flag::clear("power_on" + power_zone);
        level clientfield::set("zombie_power_off", power_zone);
    }
    if (zm_custom::function_5638f689(#"zmpowerdoorstate") != 0) {
        zombie_doors = getentarray("zombie_door", "targetname");
        foreach (door in zombie_doors) {
            if (!isdefined(door.script_noteworthy)) {
                continue;
            }
            if (!isdefined(power_zone) && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
                door notify(#"power_on");
                continue;
            }
            if (isdefined(door.script_int) && door.script_int == power_zone && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
                door notify(#"power_on");
                if (isdefined(level.temporary_power_switch_logic)) {
                    door.power_on = 0;
                    door sethintstring(#"zombie/need_power");
                    door notify(#"kill_door_think");
                    door thread zm_blockers::door_think();
                }
                continue;
            }
            if (isdefined(door.script_noteworthy) && door.script_noteworthy == "local_electric_door") {
                door notify(#"local_power_on");
            }
        }
    }
}

