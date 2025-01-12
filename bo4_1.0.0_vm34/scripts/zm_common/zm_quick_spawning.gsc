#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_quick_spawning;

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x2
// Checksum 0x9254e601, Offset: 0xf0
// Size: 0x34
function autoexec __init__system__() {
    system::register(#"zm_quick_spawning", undefined, &__main__, undefined);
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x0
// Checksum 0x7a54fa39, Offset: 0x130
// Size: 0x8c
function __main__() {
    callback::on_spawned(&function_96515c90);
    level.var_484f8531 = 0;
    level.var_d307b969 = 0;
    /#
        level thread function_219d7337();
        level thread function_1c0351dc();
        level thread function_4cd606f9();
    #/
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 1, eflags: 0x4
// Checksum 0xa204218, Offset: 0x1c8
// Size: 0x16
function private function_ec3c1c46(notifyhash) {
    self.var_15522179 = undefined;
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x4
// Checksum 0xb8b81519, Offset: 0x1e8
// Size: 0xe6
function private function_96515c90() {
    self endoncallback(&function_ec3c1c46, #"death", #"disconnect");
    while (true) {
        if (!isdefined(self.var_15522179)) {
            self.var_15522179 = [];
            self.var_30f494e9 = 0;
        }
        waitframe(1);
        velocity = self getvelocity();
        if (lengthsquared(velocity) < 25) {
            self.var_15522179 = undefined;
            continue;
        }
        self.var_15522179[self.var_30f494e9] = velocity;
        self.var_30f494e9 = (self.var_30f494e9 + 1) % 20;
    }
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x0
// Checksum 0xc036f9f4, Offset: 0x2d8
// Size: 0xc8
function function_dd6c5a27() {
    if (isdefined(self.var_15522179) && self.var_15522179.size > 0) {
        var_436f864b = (0, 0, 0);
        foreach (delta in self.var_15522179) {
            var_436f864b += delta;
        }
        vectorscale(var_436f864b, 1 / self.var_15522179.size);
        return var_436f864b;
    }
    return (0, 0, 0);
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x0
// Checksum 0xa3a7d74c, Offset: 0x3a8
// Size: 0x34
function function_e1b74f9a() {
    return level.round_number >= getdvarint(#"hash_7e106c28bbbc7c9f", 5);
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x0
// Checksum 0xa92c99e4, Offset: 0x3e8
// Size: 0x102
function function_a9feced5() {
    if (isdefined(self.var_fea3247d) && gettime() === self.var_a42b0a4b) {
        return self.var_fea3247d;
    }
    velocity = self function_dd6c5a27();
    speed_sq = lengthsquared(velocity);
    player_dir = undefined;
    if (speed_sq >= getdvarfloat(#"hash_6d953db31bc657cc", 30625)) {
        player_dir = {#player:self, #velocity:velocity, #speed_sq:speed_sq};
    }
    self.var_a42b0a4b = gettime();
    self.var_fea3247d = player_dir;
    return player_dir;
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x0
// Checksum 0xb59b493e, Offset: 0x4f8
// Size: 0x11c
function function_fb16a313() {
    if (!isdefined(level.var_7f40bcde) || level.var_7f40bcde >= level.players.size) {
        level.var_7f40bcde = 0;
    }
    for (i = 0; i < level.players.size; i++) {
        player_index = (level.var_7f40bcde + i) % level.players.size;
        player = level.players[player_index];
        if (!zombie_utility::is_player_valid(player)) {
            continue;
        }
        var_b9f5b2ec = player function_a9feced5();
        if (isdefined(var_b9f5b2ec)) {
            level.var_7f40bcde = (player_index + 1) % level.players.size;
            return var_b9f5b2ec;
        }
    }
    return undefined;
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 1, eflags: 0x0
// Checksum 0x27348355, Offset: 0x620
// Size: 0x39c
function function_8817321f(force = 0) {
    if (!getdvarint(#"hash_371ec11ae0c07d27", 0)) {
        return;
    }
    if (!isdefined(level.cleanup_zombie_func)) {
        return;
    }
    if (gettime() < level.var_484f8531 && !force) {
        return;
    }
    level.var_484f8531 = gettime() + 250;
    if (level.var_d307b969 >= 5) {
        return;
    }
    player_info = function_fb16a313();
    /#
        if (force) {
            player_info = {#player:level.players[0], #velocity:level.players[0] function_dd6c5a27()};
        }
    #/
    if (!isdefined(player_info)) {
        return;
    }
    var_f070b7d2 = function_13fedb5(player_info.player, player_info.velocity, 1);
    if (var_f070b7d2.size == 0) {
        return;
    }
    a_ai_enemies = zombie_utility::get_round_enemy_array();
    if (a_ai_enemies.size < getdvarint(#"hash_53acd122b470e451", 0)) {
        return;
    }
    var_73bb1435 = undefined;
    foreach (ai_enemy in a_ai_enemies) {
        if (!isalive(ai_enemy)) {
            continue;
        }
        if (isdefined(ai_enemy.var_e2b9e022) && ai_enemy.var_e2b9e022) {
            continue;
        }
        if (!isdefined(ai_enemy.last_closest_player)) {
            continue;
        }
        if (ai_enemy.last_closest_player != player_info.player) {
            continue;
        }
        if (!(isdefined(ai_enemy.completed_emerging_into_playable_area) && ai_enemy.completed_emerging_into_playable_area)) {
            continue;
        }
        if (!isdefined(ai_enemy.var_abbcbd32) || ai_enemy.var_abbcbd32 <= getdvarfloat(#"hash_24b315ce6034ab1c", 500000)) {
            continue;
        }
        zone = ai_enemy zm_utility::get_current_zone(1);
        var_e45dfdfd = isinarray(var_f070b7d2, zone);
        if (!var_e45dfdfd) {
            if (!isdefined(var_73bb1435)) {
                var_73bb1435 = ai_enemy;
                continue;
            }
            if (ai_enemy.var_abbcbd32 > var_73bb1435.var_abbcbd32) {
                var_73bb1435 = ai_enemy;
            }
        }
    }
    if (isdefined(var_73bb1435)) {
        var_73bb1435 thread function_1c488b30();
    }
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x0
// Checksum 0x3651af8c, Offset: 0x9c8
// Size: 0x54
function function_1c488b30() {
    self thread function_8bea7fd6();
    waitframe(1);
    if (isdefined(self) && isalive(self)) {
        self thread [[ level.cleanup_zombie_func ]]();
    }
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x0
// Checksum 0xfd8dc7f4, Offset: 0xa28
// Size: 0x3a
function function_8bea7fd6() {
    self endon(#"death");
    self.var_e2b9e022 = 1;
    wait 0.1;
    self.var_e2b9e022 = undefined;
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 2, eflags: 0x0
// Checksum 0x1a121d7c, Offset: 0xa70
// Size: 0x4ae
function function_d379ad4b(var_9ed888b2, player) {
    self endon(#"death");
    if (!function_e1b74f9a()) {
        zm_utility::move_zombie_spawn_location(var_9ed888b2);
        return;
    }
    if (isdefined(self.anchor)) {
        zm_utility::move_zombie_spawn_location(var_9ed888b2);
        return;
    }
    if (!isdefined(player)) {
        player_info = function_fb16a313();
    } else {
        player_info = player function_a9feced5();
    }
    if (!isdefined(player_info)) {
        zm_utility::move_zombie_spawn_location(var_9ed888b2);
        return;
    }
    if (isdefined(player_info.player.var_c5afbfbe) && player_info.player.var_c5afbfbe > gettime()) {
        zm_utility::move_zombie_spawn_location(var_9ed888b2);
        return;
    }
    var_f070b7d2 = function_13fedb5(player_info.player, player_info.velocity, 1);
    if (var_f070b7d2.size == 0) {
        zm_utility::move_zombie_spawn_location(var_9ed888b2);
        return;
    }
    if (level.var_d307b969 > 0) {
        zone = var_f070b7d2[0];
    } else {
        player_zone = player_info.player zm_utility::get_current_zone(1);
        if (!isdefined(var_f070b7d2)) {
            var_f070b7d2 = [];
        } else if (!isarray(var_f070b7d2)) {
            var_f070b7d2 = array(var_f070b7d2);
        }
        if (!isinarray(var_f070b7d2, player_zone)) {
            var_f070b7d2[var_f070b7d2.size] = player_zone;
        }
        zone = array::random(var_f070b7d2);
    }
    if (isdefined(zone.var_99169511) && zone.var_99169511) {
        zm_utility::move_zombie_spawn_location(var_9ed888b2);
        return;
    }
    spot = function_7280e5b6(player_info.player, zone);
    if (!isdefined(spot)) {
        zm_utility::move_zombie_spawn_location(var_9ed888b2);
        return;
    }
    if (level.var_d307b969 > 0) {
        level.var_d307b969--;
    }
    player_info.player.var_c5afbfbe = gettime() + 1000;
    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = self.angles;
    self linkto(self.anchor);
    self.anchor thread zm_utility::anchor_delete_failsafe(self);
    if (!isdefined(spot.angles)) {
        spot.angles = (0, 0, 0);
    }
    self ghost();
    self.anchor moveto(spot.origin, 0.05);
    self.anchor waittill(#"movedone");
    self unlink();
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    if (!(isdefined(self.dontshow) && self.dontshow)) {
        self show();
    }
    /#
        self thread function_33427ac5(spot);
    #/
    self notify(#"risen", {#find_flesh_struct_string:"find_flesh"});
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 2, eflags: 0x0
// Checksum 0x33548b70, Offset: 0xf28
// Size: 0x2f6
function function_7280e5b6(player, zone) {
    if (zone.nodes.size == 0) {
        return undefined;
    }
    var_8357f4a9 = "zombie_spawn_tacquery_" + level.players.size + "player";
    var_22557d12 = function_53e7c3f3(player);
    switch (var_22557d12.size) {
    case 0:
        var_7ee4a5fa = tacticalquery(var_8357f4a9, zone.nodes[0], player);
        break;
    case 1:
        var_7ee4a5fa = tacticalquery(var_8357f4a9, zone.nodes[0], player, var_22557d12[0]);
        break;
    case 2:
        var_7ee4a5fa = tacticalquery(var_8357f4a9, zone.nodes[0], player, var_22557d12[0], var_22557d12[1]);
        break;
    case 3:
        var_7ee4a5fa = tacticalquery(var_8357f4a9, zone.nodes[0], player, var_22557d12[0], var_22557d12[1], var_22557d12[2]);
        break;
    default:
        var_7ee4a5fa = tacticalquery("zombie_spawn_tacquery_1player", zone.nodes[0], player);
        break;
    }
    if (var_7ee4a5fa.size > 0) {
        var_e9bca8c2 = array::random(var_7ee4a5fa);
        var_e9bca8c2.script_string = "find_flesh";
        foreach (player in level.players) {
            if (sighttracepassed(player geteye(), var_e9bca8c2.origin + (0, 0, 72), 0, player)) {
                return undefined;
            }
        }
        return var_e9bca8c2;
    }
    return undefined;
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 3, eflags: 0x0
// Checksum 0x5b32617b, Offset: 0x1228
// Size: 0x280
function function_13fedb5(player, direction, var_a79c836e) {
    var_56de4203 = [];
    if (!isplayer(player)) {
        return var_56de4203;
    }
    if (lengthsquared(direction) == 0) {
        return var_56de4203;
    }
    if (isdefined(player.var_c468e0d1) && player.var_8213a0b4 === gettime()) {
        var_60cf1474 = player.var_c468e0d1;
    } else {
        var_60cf1474 = function_b861edbc(player.origin, direction, 1000, 1);
        player.var_c468e0d1 = var_60cf1474;
        player.var_8213a0b4 = gettime();
    }
    if (var_60cf1474.size > 0) {
        foreach (regioninfo in var_60cf1474) {
            foreach (zone in level.zones) {
                if (var_a79c836e && !zm_zonemgr::zone_is_enabled(zone.name)) {
                    continue;
                }
                if (isinarray(zone.nodes, regioninfo.regionnode)) {
                    if (!isdefined(var_56de4203)) {
                        var_56de4203 = [];
                    } else if (!isarray(var_56de4203)) {
                        var_56de4203 = array(var_56de4203);
                    }
                    if (!isinarray(var_56de4203, zone)) {
                        var_56de4203[var_56de4203.size] = zone;
                    }
                    break;
                }
            }
        }
    }
    return var_56de4203;
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 1, eflags: 0x4
// Checksum 0xfaa0339, Offset: 0x14b0
// Size: 0xf0
function private function_53e7c3f3(player_in) {
    var_22557d12 = [];
    foreach (player in getplayers()) {
        if (player_in == player) {
            continue;
        }
        if (!isdefined(var_22557d12)) {
            var_22557d12 = [];
        } else if (!isarray(var_22557d12)) {
            var_22557d12 = array(var_22557d12);
        }
        var_22557d12[var_22557d12.size] = player;
    }
    return var_22557d12;
}

/#

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 0, eflags: 0x0
    // Checksum 0x888de89b, Offset: 0x15a8
    // Size: 0x80
    function function_4cd606f9() {
        while (true) {
            waitframe(1);
            if (!getdvarint(#"hash_879482f07431cc8", 0)) {
                continue;
            }
            function_8817321f(1);
            setdvar(#"hash_879482f07431cc8", 0);
        }
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 1, eflags: 0x0
    // Checksum 0x9fa08d6a, Offset: 0x1630
    // Size: 0xbe
    function function_33427ac5(spot) {
        self endon(#"death");
        while (true) {
            if (!getdvarint(#"hash_2442d868ecc2788a", 0)) {
                return;
            }
            debugstar(spot.origin, 1, (0, 1, 1));
            line(self.origin, spot.origin, (0, 1, 1), 1, 0, 1);
            waitframe(1);
        }
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 4, eflags: 0x0
    // Checksum 0xda52a7ba, Offset: 0x16f8
    // Size: 0x178
    function function_68d07de3(type, name, condition, text_func) {
        if (!isdefined(level.var_680f8cb2)) {
            level.var_680f8cb2 = [];
        }
        if (!isdefined(level.var_680f8cb2[type])) {
            level.var_680f8cb2[type] = [];
        }
        debug_info = spawnstruct();
        debug_info.name = name;
        debug_info.type = type;
        debug_info.condition = condition;
        debug_info.text_func = text_func;
        if (!isdefined(level.var_680f8cb2[type])) {
            level.var_680f8cb2[type] = [];
        } else if (!isarray(level.var_680f8cb2[type])) {
            level.var_680f8cb2[type] = array(level.var_680f8cb2[type]);
        }
        level.var_680f8cb2[type][level.var_680f8cb2[type].size] = debug_info;
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 2, eflags: 0x4
    // Checksum 0x27c992b1, Offset: 0x1878
    // Size: 0xbc
    function private create_hudelem(y, x) {
        if (!isdefined(x)) {
            x = 0;
        }
        var_587f26ea = newdebughudelem();
        var_587f26ea.alignx = "<dev string:x30>";
        var_587f26ea.horzalign = "<dev string:x30>";
        var_587f26ea.aligny = "<dev string:x35>";
        var_587f26ea.vertalign = "<dev string:x3c>";
        var_587f26ea.y = y;
        var_587f26ea.x = x;
        return var_587f26ea;
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 1, eflags: 0x0
    // Checksum 0x11e6f78e, Offset: 0x1940
    // Size: 0x6a
    function function_8c23de7f(debug_info) {
        return debug_info.name + "<dev string:x40>" + (isdefined(self [[ debug_info.condition ]]()) && self [[ debug_info.condition ]]() ? "<dev string:x44>" : "<dev string:x4d>");
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 1, eflags: 0x0
    // Checksum 0x22c816ad, Offset: 0x19b8
    // Size: 0x32
    function function_2f2a6e20(debug_info) {
        return debug_info.name + "<dev string:x40>" + level.var_d307b969;
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 1, eflags: 0x0
    // Checksum 0xd80433cd, Offset: 0x19f8
    // Size: 0xb4
    function function_a9be198e(debug_info) {
        if (!isdefined(self.var_c5afbfbe)) {
            return (debug_info.name + "<dev string:x56>");
        }
        time_left = max(self.var_c5afbfbe - gettime(), 0);
        returnstring = debug_info.name + "<dev string:x40>" + (time_left < 0 ? "<dev string:x6a>" : "<dev string:x67>");
        returnstring += time_left;
        return returnstring;
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 0, eflags: 0x0
    // Checksum 0x625a439b, Offset: 0x1ab8
    // Size: 0x87c
    function function_219d7337() {
        function_68d07de3("<dev string:x6d>", "<dev string:x74>", &function_fb0f7e7f, &function_8c23de7f);
        function_68d07de3("<dev string:x6d>", "<dev string:x84>", &function_e1b74f9a, &function_8c23de7f);
        function_68d07de3("<dev string:x6d>", "<dev string:x8a>", undefined, &function_2f2a6e20);
        function_68d07de3("<dev string:xa0>", "<dev string:xa7>", &function_45cd02de, &function_8c23de7f);
        function_68d07de3("<dev string:xa0>", "<dev string:xad>", &function_807d1f3e, &function_8c23de7f);
        function_68d07de3("<dev string:xa0>", "<dev string:xc5>", undefined, &function_a9be198e);
        while (true) {
            var_e70cbe57 = getplayers().size;
            waitframe(1);
            if (!getdvarint(#"hash_1067641cdc653b13", 0) || var_e70cbe57 != getplayers().size) {
                if (isdefined(level.var_dcb2e2a8)) {
                    foreach (hudelem in level.var_dcb2e2a8) {
                        hudelem destroy();
                    }
                    level.var_dcb2e2a8 = undefined;
                }
                continue;
            }
            if (!isdefined(level.var_dcb2e2a8)) {
                current_y = 30;
                foreach (var_c9140d6 in level.var_680f8cb2) {
                    type = var_c9140d6[0].type;
                    var_587f26ea = create_hudelem(current_y);
                    var_587f26ea settext("<dev string:xd7>" + type + "<dev string:xdd>");
                    if (!isdefined(level.var_dcb2e2a8)) {
                        level.var_dcb2e2a8 = [];
                    } else if (!isarray(level.var_dcb2e2a8)) {
                        level.var_dcb2e2a8 = array(level.var_dcb2e2a8);
                    }
                    level.var_dcb2e2a8[level.var_dcb2e2a8.size] = var_587f26ea;
                    current_y += 10;
                    if (type == "<dev string:xa0>") {
                        current_x = 0;
                        foreach (player in level.players) {
                            var_587f26ea = create_hudelem(current_y, current_x);
                            var_587f26ea settext(player.playername);
                            if (!isdefined(level.var_dcb2e2a8)) {
                                level.var_dcb2e2a8 = [];
                            } else if (!isarray(level.var_dcb2e2a8)) {
                                level.var_dcb2e2a8 = array(level.var_dcb2e2a8);
                            }
                            level.var_dcb2e2a8[level.var_dcb2e2a8.size] = var_587f26ea;
                            current_x += 110;
                        }
                        current_y += 10;
                    }
                    foreach (var_cd6f29fc in var_c9140d6) {
                        current_x = 0;
                        if (var_cd6f29fc.type == "<dev string:xa0>") {
                            foreach (player in level.players) {
                                var_587f26ea = create_hudelem(current_y, current_x);
                                var_587f26ea.debug_info = var_cd6f29fc;
                                var_587f26ea.target = player;
                                if (!isdefined(level.var_dcb2e2a8)) {
                                    level.var_dcb2e2a8 = [];
                                } else if (!isarray(level.var_dcb2e2a8)) {
                                    level.var_dcb2e2a8 = array(level.var_dcb2e2a8);
                                }
                                level.var_dcb2e2a8[level.var_dcb2e2a8.size] = var_587f26ea;
                                current_x += 110;
                            }
                        } else {
                            var_587f26ea = create_hudelem(current_y);
                            var_587f26ea.debug_info = var_cd6f29fc;
                            var_587f26ea.target = level;
                            if (!isdefined(level.var_dcb2e2a8)) {
                                level.var_dcb2e2a8 = [];
                            } else if (!isarray(level.var_dcb2e2a8)) {
                                level.var_dcb2e2a8 = array(level.var_dcb2e2a8);
                            }
                            level.var_dcb2e2a8[level.var_dcb2e2a8.size] = var_587f26ea;
                        }
                        current_y += 10;
                    }
                }
            }
            foreach (hudelem in level.var_dcb2e2a8) {
                if (!isdefined(hudelem.debug_info)) {
                    continue;
                }
                hudelem settext(hudelem.target [[ hudelem.debug_info.text_func ]](hudelem.debug_info));
            }
        }
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 0, eflags: 0x0
    // Checksum 0xd00bcdd0, Offset: 0x2340
    // Size: 0x18
    function function_fb0f7e7f() {
        return level.zombie_respawns > 0;
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 0, eflags: 0x0
    // Checksum 0x6f59044f, Offset: 0x2360
    // Size: 0x2c
    function function_45cd02de() {
        player_info = self function_a9feced5();
        return isdefined(player_info);
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 0, eflags: 0x0
    // Checksum 0xfb4f294, Offset: 0x2398
    // Size: 0x6a
    function function_807d1f3e() {
        player_speed = self function_dd6c5a27();
        if (lengthsquared(player_speed) == 0) {
            return 0;
        }
        return function_13fedb5(self, player_speed, 1).size > 0;
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 0, eflags: 0x0
    // Checksum 0x96438295, Offset: 0x2410
    // Size: 0x304
    function function_1c0351dc() {
        while (true) {
            waitframe(1);
            if (isdefined(level.zones) && getdvarint(#"hash_31275bfb1fec2d76", -1) > -1) {
                if (getdvarint(#"hash_31275bfb1fec2d76", -1) >= level.players.size) {
                    continue;
                }
                player = level.players[getdvarint(#"hash_31275bfb1fec2d76", -1)];
                playerdirection = player function_dd6c5a27();
                sphere(player.origin + playerdirection, 5, (0, 1, 0), 1, 0, 12, 1);
                if (lengthsquared(playerdirection) == 0) {
                    continue;
                }
                var_60cf1474 = function_b861edbc(player.origin, playerdirection, 1000, 1);
                if (var_60cf1474.size > 0) {
                    foreach (regioninfo in var_60cf1474) {
                        foreach (zone in level.zones) {
                            if (isinarray(zone.nodes, regioninfo.regionnode)) {
                                print3d(regioninfo.regionnode.origin + (0, 0, 12), regioninfo.regionnode.targetname, (0, 1, 0), 1, 1, 1);
                                break;
                            }
                        }
                        sphere(regioninfo.contactpoint, 5, (0, 1, 0), 1, 0, 12, 1);
                    }
                }
            }
        }
    }

#/
