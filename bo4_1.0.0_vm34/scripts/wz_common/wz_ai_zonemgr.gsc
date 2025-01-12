#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\wz_common\wz_ai_utils;

#namespace wz_ai_zonemgr;

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 0, eflags: 0x2
// Checksum 0x1faa7e8a, Offset: 0x108
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_ai_zonemgr", &__init__, undefined, undefined);
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 0, eflags: 0x0
// Checksum 0x56bbc9d8, Offset: 0x150
// Size: 0x114
function __init__() {
    level.var_41edb5d9 = 1;
    /#
        if (getdvarint(#"wz_ai_on", 0) > 0) {
            level.var_604a6181 = 1;
        } else {
            level.var_604a6181 = 0;
        }
    #/
    level thread function_b6c1fac5();
    callback::on_spawned(&on_player_spawned);
    level.startinghealth = 300;
    level.var_9cf874df = &function_9cf874df;
    level.var_74905877 = [];
    level thread function_210c26b1();
    level thread function_a185f354();
    /#
        level thread function_7fcd318a();
    #/
}

/#

    // Namespace wz_ai_zonemgr/wz_ai_zonemgr
    // Params 0, eflags: 0x0
    // Checksum 0xffbcf910, Offset: 0x270
    // Size: 0x530
    function function_7fcd318a() {
        sessionmode = currentsessionmode();
        setdvar(#"hash_70cb00491d863294", "<dev string:x30>");
        if (sessionmode != 4) {
            adddebugcommand("<dev string:x31>");
            adddebugcommand("<dev string:x6d>");
            adddebugcommand("<dev string:xab>");
            adddebugcommand("<dev string:xc8>");
            adddebugcommand("<dev string:xe7>");
            adddebugcommand("<dev string:x107>");
            adddebugcommand("<dev string:x128>");
            adddebugcommand("<dev string:x149>");
            adddebugcommand("<dev string:x181>");
            adddebugcommand("<dev string:x1c0>");
            adddebugcommand("<dev string:x1fa>");
            adddebugcommand("<dev string:x238>");
        }
        while (true) {
            wait 0.25;
            cmd = getdvarstring(#"hash_70cb00491d863294", "<dev string:x30>");
            if (cmd == "<dev string:x30>") {
                continue;
            }
            if (strstartswith(cmd, "<dev string:x276>")) {
                zone_name = strreplace(cmd, "<dev string:x276>", "<dev string:x30>");
                zone = function_e5956f11(zone_name);
                if (!(isdefined(zone.is_active) && zone.is_active)) {
                    level thread function_151db441(zone);
                    level notify(#"hash_4168bee802274065");
                }
            } else if (strstartswith(cmd, "<dev string:x285>")) {
                zone_name = strreplace(cmd, "<dev string:x285>", "<dev string:x30>");
                zone = function_e5956f11(zone_name);
                zone.is_active = 0;
                zone.minimap clientfield::set("<dev string:x296>", 0);
                zone function_686b77e9();
                level notify(#"hash_4168bee802274065");
            } else if (strstartswith(cmd, "<dev string:x2a1>")) {
                weapon_name = strreplace(cmd, "<dev string:x2a1>", "<dev string:x30>");
                weapon = getweapon(weapon_name);
                players = getplayers();
                players[0] giveweapon(weapon);
                players[0] switchtoweapon(weapon);
                players[0] setweaponammostock(weapon, weapon.maxammo);
                players[0] setweaponammoclip(weapon, weapon.clipsize);
                players[0] givestartammo(weapon);
            } else {
                switch (cmd) {
                case #"debug_on":
                    level.var_604a6181 = 1;
                    break;
                case #"debug_off":
                    level.var_604a6181 = 0;
                    break;
                }
            }
            setdvar(#"hash_70cb00491d863294", "<dev string:x30>");
        }
    }

#/

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 0, eflags: 0x0
// Checksum 0xbb0f4606, Offset: 0x7a8
// Size: 0x1ae
function function_b64bfdab() {
    for (i = 0; i < level.var_74905877.size; i++) {
        assert(i < 10, "<dev string:x2ae>");
        ai_zone = level.var_74905877[i];
        match_record::function_3fad861b(#"ai_zones", i, #"origin", ai_zone.root_node.origin);
        match_record::set_stat(#"ai_zones", i, #"name", hash(ai_zone.zone_name));
        match_record::set_stat(#"ai_zones", i, #"death_circle", ai_zone.death_circle);
        match_record::set_stat(#"ai_zones", i, #"spawn_count", ai_zone.total_spawn_count);
        match_record::set_stat(#"ai_zones", i, #"death_count", ai_zone.var_a0ed3172);
    }
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 0, eflags: 0x0
// Checksum 0xe0631714, Offset: 0x960
// Size: 0x100
function function_686b77e9() {
    all_ai = getaiteamarray(#"world");
    if (isdefined(all_ai) && all_ai.size > 0) {
        foreach (ai in all_ai) {
            if (isalive(ai) && ai.ai_zone === self) {
                ai dodamage(ai.health + 100, ai.origin);
            }
        }
    }
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 0, eflags: 0x0
// Checksum 0x2241866d, Offset: 0xa68
// Size: 0x288
function function_9cf874df() {
    if (!(isdefined(level.var_41edb5d9) && level.var_41edb5d9)) {
        return;
    }
    var_86d00a82 = level.deathcircles.size - 2;
    if (isdefined(level.deathcircle) && isdefined(level.deathcircleindex)) {
        if (level.deathcircleindex > var_86d00a82) {
            foreach (ai_zone in level.var_74905877) {
                if (!ai_zone.is_disabled) {
                    var_6d292f23 = ai_zone.root_node.origin;
                    ai_zone.is_active = 0;
                    ai_zone.minimap clientfield::set("aizoneflag", 0);
                    ai_zone function_686b77e9();
                    ai_zone.is_disabled = 1;
                    ai_zone.death_circle = level.deathcircleindex;
                }
            }
            level.var_41edb5d9 = 0;
            level notify(#"hash_329c3f546e49cb9f");
            return;
        }
    }
    level.startinghealth += level.deathcircleindex * 100;
    all_ai = getaiteamarray(#"world");
    if (isdefined(all_ai) && all_ai.size > 0) {
        foreach (ai in all_ai) {
            if (isalive(ai)) {
                ai thread function_581138c1(level.startinghealth);
            }
        }
    }
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 1, eflags: 0x0
// Checksum 0x94e117b7, Offset: 0xcf8
// Size: 0x36
function function_581138c1(newhealth) {
    self.maxhealth = newhealth;
    self.health = self.maxhealth;
    self.var_6edb26c0 = 1;
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 0, eflags: 0x0
// Checksum 0x4c4a937a, Offset: 0xd38
// Size: 0x1e4
function function_a185f354() {
    level endon(#"game_ended", #"hash_12a8f2c59a67e4fc", #"hash_329c3f546e49cb9f");
    while (!isdefined(level.deathcircle)) {
        wait 1;
    }
    while (true) {
        radiussq = level.deathcircle.radius * level.deathcircle.radius;
        origin = level.deathcircle.origin;
        foreach (ai_zone in level.var_74905877) {
            if (!ai_zone.is_disabled) {
                var_6d292f23 = ai_zone.root_node.origin;
                distsq = distance2dsquared(var_6d292f23, origin);
                if (distsq > radiussq) {
                    ai_zone.is_active = 0;
                    ai_zone.minimap clientfield::set("aizoneflag", 0);
                    ai_zone function_686b77e9();
                    ai_zone.is_disabled = 1;
                    ai_zone.death_circle = level.deathcircleindex;
                    break;
                }
            }
        }
        wait 1;
    }
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 0, eflags: 0x0
// Checksum 0x10c05416, Offset: 0xf28
// Size: 0x1c
function on_player_spawned() {
    self thread function_c30b6f96();
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 0, eflags: 0x0
// Checksum 0xd1475deb, Offset: 0xf50
// Size: 0x158
function function_c30b6f96() {
    level endon(#"game_ended", #"hash_329c3f546e49cb9f");
    self endon(#"death");
    while (true) {
        self.ai_zone = undefined;
        if (isdefined(level.var_41edb5d9) && level.var_41edb5d9) {
            foreach (ai_zone in level.var_74905877) {
                if (!ai_zone.is_disabled && isdefined(ai_zone.is_active) && ai_zone.is_active) {
                    if (self istouching(ai_zone)) {
                        self.ai_zone = ai_zone;
                        break;
                    }
                }
            }
        }
        wait randomfloatrange(1, 2);
    }
}

/#

    // Namespace wz_ai_zonemgr/wz_ai_zonemgr
    // Params 0, eflags: 0x0
    // Checksum 0x852677dc, Offset: 0x10b0
    // Size: 0x3a2
    function function_6d00d08b() {
        level endon(#"game_ended", #"hash_329c3f546e49cb9f");
        while (true) {
            if (isdefined(level.var_41edb5d9) && level.var_41edb5d9 && isdefined(level.var_604a6181) && level.var_604a6181 && isdefined(level.var_74905877)) {
                foreach (ai_zone in level.var_74905877) {
                    drawpos = ai_zone.root_node.origin;
                    zonecolor = (1, 0, 0);
                    if (!ai_zone.is_disabled && isdefined(level.var_41edb5d9) && level.var_41edb5d9) {
                        zonecolor = (1, 1, 0);
                        if (ai_zone.is_occupied) {
                            zonecolor = (0, 1, 0);
                        }
                        foreach (spawn_point in ai_zone.spawn_points) {
                            circle(spawn_point.origin + (0, 0, 1), 15, (1, 0, 0), 0, 1);
                        }
                        foreach (hide_point in ai_zone.hide_points) {
                            circle(hide_point.origin + (0, 0, 1), 10, (0, 0, 1), 0, 1);
                        }
                    }
                    print3d(drawpos + (0, 0, 40), "<dev string:x2db>" + ai_zone.zone_name, zonecolor);
                    print3d(drawpos + (0, 0, 25), "<dev string:x2df>" + ai_zone.var_21269506 + "<dev string:x2e6>" + ai_zone.var_6d9293de, zonecolor);
                    print3d(drawpos + (0, 0, 10), "<dev string:x2e8>" + ai_zone.var_91d29ce9 + "<dev string:x2e6>" + ai_zone.var_399f1be8, zonecolor);
                    circle(drawpos, 40, zonecolor, 0, 1);
                }
            }
            waitframe(1);
        }
    }

#/

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 1, eflags: 0x0
// Checksum 0x5dc80ee1, Offset: 0x1460
// Size: 0x8a
function function_e5956f11(zone_name) {
    foreach (ai_zone in level.ai_zones) {
        if (ai_zone.zone_name === zone_name) {
            return ai_zone;
        }
    }
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 2, eflags: 0x0
// Checksum 0x1edcb5fe, Offset: 0x14f8
// Size: 0x4e
function function_57126dd(zone_name, num) {
    ai_zone = function_e5956f11(zone_name);
    if (isdefined(ai_zone)) {
        ai_zone.var_5425e424 = num;
    }
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 6, eflags: 0x0
// Checksum 0x83f00b1, Offset: 0x1550
// Size: 0x328
function function_c23585d(zone_category, zone_name, spawner_type, var_6d9293de, var_ba612a2b, var_37830de) {
    ai_zone = function_e5956f11(zone_name);
    if (isdefined(ai_zone)) {
        level.var_74905877[level.var_74905877.size] = ai_zone;
        ai_zone.is_disabled = 0;
        ai_zone.is_active = 0;
        ai_zone.zone_category = zone_category;
        ai_zone.var_6d9293de = var_6d9293de;
        ai_zone.var_399f1be8 = var_ba612a2b;
        ai_zone.var_37830de = var_37830de;
        ai_zone.var_8ad990b6 = spawner_type;
        ai_zone.var_66f84279 = 0;
        ai_zone.var_af9577c = &function_ea251756;
        ai_zone.var_39d3907c = &function_dc3df776;
        ai_zone.var_18871d97 = 0;
        ai_zone.last_spawn_time = 0;
        ai_zone.spawn_delay = int(6 * 1000);
        ai_zone.var_e7ed204d = 0;
        ai_zone.var_21269506 = 0;
        ai_zone.var_5425e424 = undefined;
        ai_zone.death_circle = 0;
        ai_zone.total_spawn_count = 0;
        ai_zone.var_a0ed3172 = 0;
        /#
            path = "<dev string:x2ef>" + ai_zone.zone_name + "<dev string:x30d>" + "<dev string:x317>";
            command = "<dev string:x319>" + ai_zone.zone_name + "<dev string:x317>";
            adddebugcommand(path + "<dev string:x33a>" + command + "<dev string:x33c>");
            path = "<dev string:x2ef>" + ai_zone.zone_name + "<dev string:x33f>" + "<dev string:x317>";
            command = "<dev string:x34b>" + ai_zone.zone_name + "<dev string:x317>";
            adddebugcommand(path + "<dev string:x33a>" + command + "<dev string:x33c>");
            path = "<dev string:x2ef>" + ai_zone.zone_name + "<dev string:x33f>" + "<dev string:x317>";
            command = "<dev string:x34b>" + ai_zone.zone_name + "<dev string:x317>";
            adddebugcommand(path + "<dev string:x33a>" + command + "<dev string:x33c>");
        #/
    }
    return ai_zone;
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 6, eflags: 0x0
// Checksum 0x9d56f8c1, Offset: 0x1880
// Size: 0x7e
function function_a5c8f040(zone_category, zone_name, spawner_type, var_6d9293de, var_ba612a2b, var_37830de) {
    ai_zone = function_c23585d(zone_category, zone_name, spawner_type, var_6d9293de, var_ba612a2b, var_37830de);
    if (isdefined(ai_zone)) {
        ai_zone.var_66f84279 = 1;
    }
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 0, eflags: 0x0
// Checksum 0x6356b059, Offset: 0x1908
// Size: 0x620
function function_b6c1fac5() {
    level endon(#"game_ended", #"hash_329c3f546e49cb9f");
    level.ai_zones = getentarray("wz_ai_zone", "targetname");
    foreach (ai_zone in level.ai_zones) {
        ai_zone.spawn_points = struct::get_array(ai_zone.target, "targetname");
        ai_zone.hide_points = [];
        ai_zone.var_7a44fd53 = 0;
        for (i = 0; i < ai_zone.spawn_points.size; i++) {
            if (isdefined(ai_zone.spawn_points[i].script_noteworthy)) {
                if (ai_zone.spawn_points[i].script_noteworthy == "hide_here") {
                    elem = ai_zone.spawn_points[i];
                    ai_zone.hide_points[ai_zone.hide_points.size] = elem;
                }
            }
        }
        ai_zone.var_18871d97 = 0;
        ai_zone.root_node = getnode(ai_zone.target, "targetname");
        if (isdefined(ai_zone.root_node.script_noteworthy)) {
            ai_zone.zone_name = ai_zone.root_node.script_noteworthy;
        } else {
            ai_zone.zone_name = "unnamed";
        }
        ai_zone.is_active = 0;
        ai_zone.var_6d9293de = 0;
        ai_zone.var_399f1be8 = 0;
        ai_zone.var_8ad990b6 = undefined;
        ai_zone.var_91d29ce9 = 0;
        ai_zone.is_occupied = 0;
        var_19c990a0 = struct::get(ai_zone.root_node.target, "targetname");
        if (isdefined(var_19c990a0)) {
            ai_zone.minimap = spawn("script_model", var_19c990a0.origin);
        } else {
            ai_zone.minimap = spawn("script_model", ai_zone.root_node.origin);
        }
        ai_zone.minimap setmodel("tag_origin");
    }
    /#
        level thread function_6d00d08b();
        level thread wz_ai_utils::debug_ai();
    #/
    while (true) {
        if (isdefined(level.var_41edb5d9) && level.var_41edb5d9 && isdefined(level.var_74905877)) {
            foreach (ai_zone in level.var_74905877) {
                if (!ai_zone.is_disabled) {
                    ai_zone.is_occupied = 0;
                    if (isdefined(ai_zone.is_active) && ai_zone.is_active) {
                        players = getplayers();
                        for (i = 0; i < players.size; i++) {
                            if (isdefined(players[i].ai_zone) && players[i].ai_zone == ai_zone) {
                                ai_zone.is_occupied = 1;
                                break;
                            }
                        }
                    }
                    if (!(isdefined(ai_zone.is_occupied) && ai_zone.is_occupied)) {
                        ai_zone [[ ai_zone.var_39d3907c ]]();
                        continue;
                    }
                    ai_zone [[ ai_zone.var_af9577c ]]();
                }
            }
        } else {
            all_ai = getaiteamarray(#"world");
            if (isdefined(all_ai) && all_ai.size > 0) {
                foreach (ai in all_ai) {
                    ai dodamage(ai.health + 100, ai.origin);
                    waitframe(1);
                }
            }
        }
        wait randomfloatrange(2, 3);
    }
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 0, eflags: 0x0
// Checksum 0x66c6dac7, Offset: 0x1f30
// Size: 0x186
function function_ea251756() {
    if (self.var_21269506 < self.var_6d9293de && self.var_91d29ce9 < self.var_399f1be8) {
        if (gettime() > self.last_spawn_time + self.spawn_delay) {
            s_loc = self.spawn_points[self.var_18871d97];
            self.var_18871d97++;
            if (self.var_18871d97 >= self.spawn_points.size) {
                self.var_18871d97 = 0;
            }
            if (isdefined(self.var_66f84279) && self.var_66f84279) {
                spawned = spawnvehicle(self.var_8ad990b6, s_loc.origin, (0, 0, 0), "wz_vehicle_ai");
            } else {
                spawned = spawnactor(self.var_8ad990b6, s_loc.origin, (0, 0, 0), "wz_ai");
            }
            if (isdefined(spawned)) {
                spawned thread wz_ai_utils::function_7a59ba87(self);
                spawned thread wz_ai_utils::function_a2a4020(self);
                self.var_91d29ce9++;
                self.var_21269506++;
                self.total_spawn_count++;
            }
        }
        return;
    }
    self.last_spawn_time = gettime();
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 0, eflags: 0x0
// Checksum 0xa29dd0f8, Offset: 0x20c0
// Size: 0x12c
function function_dc3df776() {
    if (false) {
        if (self.var_91d29ce9 > 0) {
            all_ai = getaiteamarray(#"world");
            if (isdefined(all_ai) && all_ai.size > 0) {
                foreach (ai in all_ai) {
                    if (isalive(ai) && ai.ai_zone === self) {
                        if (!self.is_occupied) {
                            ai dodamage(ai.health + 100, ai.origin);
                            break;
                        }
                    }
                }
            }
        }
    }
}

// Namespace wz_ai_zonemgr/event_57a8880c
// Params 1, eflags: 0x40
// Checksum 0x9d9813a4, Offset: 0x21f8
// Size: 0xc4
function event_handler[event_57a8880c] function_565a245e(eventstruct) {
    if (isdefined(eventstruct.ent.target) && eventstruct.ent.target != "") {
        traversal_start_node = getnode(eventstruct.ent.target, "targetname");
        if (isdefined(traversal_start_node)) {
            if (eventstruct.state == 0) {
                unlinktraversal(traversal_start_node);
                return;
            }
            linktraversal(traversal_start_node);
        }
    }
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 2, eflags: 0x0
// Checksum 0x4d69ea1d, Offset: 0x22c8
// Size: 0xf2
function function_324bc97c(category, last_zone) {
    level endon(#"game_ended", #"hash_12a8f2c59a67e4fc", #"hash_329c3f546e49cb9f");
    foreach (ai_zone in level.var_74905877) {
        if (!ai_zone.is_disabled) {
            if (ai_zone.zone_category === category) {
                if (!isdefined(last_zone) || ai_zone != last_zone) {
                    return ai_zone;
                }
            }
        }
    }
    return undefined;
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 1, eflags: 0x0
// Checksum 0xb97cc6d, Offset: 0x23c8
// Size: 0x254
function function_151db441(zone) {
    if (!isdefined(zone)) {
        return;
    }
    /#
        if (getdvarint(#"zone_override", 0) > 0) {
            zone.var_37830de = getdvarint(#"zone_prespawn", 2);
            zone.var_6d9293de = getdvarint(#"zone_maxcount", 10);
            zone.var_399f1be8 = getdvarint(#"zone_alivecount", 5);
            zone.spawn_delay = getdvarint(#"zone_spawndelay", 5);
        }
    #/
    zone.is_active = 1;
    zone.minimap clientfield::set("aizoneflag", 1);
    zone.var_21269506 = 0;
    zone.var_e7ed204d = 0;
    while (zone.var_21269506 < zone.var_37830de) {
        zone [[ zone.var_af9577c ]]();
        waitframe(1);
    }
    while (zone.is_active && zone.var_21269506 < zone.var_6d9293de) {
        waitframe(1);
    }
    while (zone.var_91d29ce9 > 0) {
        waitframe(1);
    }
    if (isdefined(zone.var_5425e424)) {
        zone.var_5425e424--;
        if (zone.var_5425e424 <= 0) {
            zone.is_disabled = 1;
        }
    }
    zone.is_active = 0;
    zone.minimap clientfield::set("aizoneflag", 0);
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 1, eflags: 0x0
// Checksum 0x9edbdc9c, Offset: 0x2628
// Size: 0xd6
function function_44564270(category) {
    level endon(#"game_ended", #"hash_12a8f2c59a67e4fc", #"hash_329c3f546e49cb9f", #"hash_4168bee802274065");
    last_zone = undefined;
    while (isdefined(level.var_41edb5d9) && level.var_41edb5d9) {
        zone = function_324bc97c(category, last_zone);
        if (!isdefined(zone)) {
            break;
        }
        last_zone = zone;
        function_151db441(zone);
        waitframe(1);
    }
}

// Namespace wz_ai_zonemgr/wz_ai_zonemgr
// Params 0, eflags: 0x0
// Checksum 0xb5e891b3, Offset: 0x2708
// Size: 0xcc
function function_210c26b1() {
    level waittill(#"hash_7f7eec328c07606d");
    /#
        level thread function_8d0fd711();
    #/
    if (getdvarint(#"wz_ai_on", 0) < 2) {
        level flagsys::wait_till(#"hash_224cb97b8f682317");
    }
    level.var_74905877 = array::randomize(level.var_74905877);
    level thread function_44564270(0);
    level thread function_44564270(1);
}

/#

    // Namespace wz_ai_zonemgr/wz_ai_zonemgr
    // Params 0, eflags: 0x0
    // Checksum 0x9e4b8f72, Offset: 0x27e0
    // Size: 0x1a8
    function function_8d0fd711() {
        level endon(#"game_ended", #"hash_329c3f546e49cb9f");
        while (true) {
            if (getdvarint(#"scr_print_ai", 0) && isdefined(level.var_604a6181) && level.var_604a6181) {
                if (isdefined(level.var_41edb5d9) && level.var_41edb5d9) {
                    var_b5ce6a9 = 0;
                    foreach (ai_zone in level.var_74905877) {
                        if (!ai_zone.is_disabled && isdefined(ai_zone.is_active) && ai_zone.is_active) {
                            iprintlnbold(ai_zone.zone_name + "<dev string:x36e>" + ai_zone.var_91d29ce9 + "<dev string:x371>");
                            var_b5ce6a9 = 1;
                        }
                    }
                    if (var_b5ce6a9) {
                    }
                } else {
                    iprintlnbold("<dev string:x379>");
                }
            }
            wait 1;
        }
    }

#/
