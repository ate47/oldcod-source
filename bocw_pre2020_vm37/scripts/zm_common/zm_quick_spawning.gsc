#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_quick_spawning;

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x6
// Checksum 0x6424f819, Offset: 0xf8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_quick_spawning", undefined, &postinit, undefined, undefined);
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x5 linked
// Checksum 0x70c1b278, Offset: 0x140
// Size: 0x84
function private postinit() {
    callback::on_spawned(&function_920e8738);
    level.var_2e20becd = 0;
    level.var_d4a79133 = 0;
    /#
        level thread function_af31614c();
        level thread function_497aad8f();
        level thread function_ba3ebac4();
    #/
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 1, eflags: 0x5 linked
// Checksum 0x8821a74c, Offset: 0x1d0
// Size: 0x16
function private function_6a51df96(*notifyhash) {
    self.var_552afb80 = undefined;
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x5 linked
// Checksum 0x21855555, Offset: 0x1f0
// Size: 0xe2
function private function_920e8738() {
    self endoncallback(&function_6a51df96, #"death", #"disconnect");
    while (true) {
        if (!isdefined(self.var_552afb80)) {
            self.var_552afb80 = [];
            self.var_b0ae2a = 0;
        }
        waitframe(1);
        velocity = self getvelocity();
        if (lengthsquared(velocity) < 25) {
            self.var_552afb80 = undefined;
            continue;
        }
        self.var_552afb80[self.var_b0ae2a] = velocity;
        self.var_b0ae2a = (self.var_b0ae2a + 1) % 20;
    }
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x1 linked
// Checksum 0xf819d2da, Offset: 0x2e0
// Size: 0xd0
function function_c5ea0b0() {
    if (isdefined(self.var_552afb80) && self.var_552afb80.size > 0) {
        var_65e4173d = (0, 0, 0);
        foreach (delta in self.var_552afb80) {
            var_65e4173d += delta;
        }
        vectorscale(var_65e4173d, 1 / self.var_552afb80.size);
        return var_65e4173d;
    }
    return (0, 0, 0);
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x1 linked
// Checksum 0xc0d2d213, Offset: 0x3b8
// Size: 0x34
function function_15e9bcbb() {
    return level.round_number >= getdvarint(#"hash_7e106c28bbbc7c9f", 5);
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x1 linked
// Checksum 0x895109d6, Offset: 0x3f8
// Size: 0x102
function function_15b283ea() {
    if (isdefined(self.var_53df2c57) && gettime() === self.var_dcdf2aec) {
        return self.var_53df2c57;
    }
    velocity = self function_c5ea0b0();
    var_49bf47e8 = lengthsquared(velocity);
    player_dir = undefined;
    if (var_49bf47e8 >= getdvarfloat(#"hash_6d953db31bc657cc", 30625)) {
        player_dir = {#player:self, #velocity:velocity, #var_49bf47e8:var_49bf47e8};
    }
    self.var_dcdf2aec = gettime();
    self.var_53df2c57 = player_dir;
    return player_dir;
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x1 linked
// Checksum 0x6e88d77a, Offset: 0x508
// Size: 0x110
function function_6b19043d() {
    if (!isdefined(level.var_326335cb) || level.var_326335cb >= level.players.size) {
        level.var_326335cb = 0;
    }
    for (i = 0; i < level.players.size; i++) {
        player_index = (level.var_326335cb + i) % level.players.size;
        player = level.players[player_index];
        if (!zombie_utility::is_player_valid(player)) {
            continue;
        }
        var_c71f49be = player function_15b283ea();
        if (isdefined(var_c71f49be)) {
            level.var_326335cb = (player_index + 1) % level.players.size;
            return var_c71f49be;
        }
    }
    return undefined;
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 1, eflags: 0x1 linked
// Checksum 0xd65740fb, Offset: 0x620
// Size: 0x394
function function_367e3573(force = 0) {
    if (!getdvarint(#"hash_371ec11ae0c07d27", 0)) {
        return;
    }
    if (!isdefined(level.cleanup_zombie_func)) {
        return;
    }
    if (gettime() < level.var_2e20becd && !force) {
        return;
    }
    level.var_2e20becd = gettime() + 250;
    if (level.var_d4a79133 >= 5) {
        return;
    }
    player_info = function_6b19043d();
    /#
        if (force) {
            player_info = {#player:level.players[0], #velocity:level.players[0] function_c5ea0b0()};
        }
    #/
    if (!isdefined(player_info)) {
        return;
    }
    var_1158d63 = function_f1ec5df(player_info.player, player_info.velocity, 1);
    if (var_1158d63.size == 0) {
        return;
    }
    a_ai_enemies = zombie_utility::get_round_enemy_array();
    if (a_ai_enemies.size < getdvarint(#"hash_53acd122b470e451", 0)) {
        return;
    }
    var_1ae24209 = undefined;
    foreach (ai_enemy in a_ai_enemies) {
        if (!isalive(ai_enemy)) {
            continue;
        }
        if (is_true(ai_enemy.var_e35c7b7e)) {
            continue;
        }
        if (!isdefined(ai_enemy.last_closest_player)) {
            continue;
        }
        if (ai_enemy.last_closest_player != player_info.player) {
            continue;
        }
        if (!is_true(ai_enemy.completed_emerging_into_playable_area)) {
            continue;
        }
        if (!isdefined(ai_enemy.var_c6e0686b) || ai_enemy.var_c6e0686b <= getdvarfloat(#"hash_24b315ce6034ab1c", 500000)) {
            continue;
        }
        zone = ai_enemy zm_utility::get_current_zone(1);
        var_403bc67a = isinarray(var_1158d63, zone);
        if (!var_403bc67a) {
            if (!isdefined(var_1ae24209)) {
                var_1ae24209 = ai_enemy;
                continue;
            }
            if (ai_enemy.var_c6e0686b > var_1ae24209.var_c6e0686b) {
                var_1ae24209 = ai_enemy;
            }
        }
    }
    if (isdefined(var_1ae24209)) {
        var_1ae24209 thread function_4b35e9ac();
    }
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x1 linked
// Checksum 0xa444b4a6, Offset: 0x9c0
// Size: 0x54
function function_4b35e9ac() {
    self thread function_5d642307();
    waitframe(1);
    if (isdefined(self) && isalive(self)) {
        self thread [[ level.cleanup_zombie_func ]]();
    }
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 0, eflags: 0x1 linked
// Checksum 0x4d98c383, Offset: 0xa20
// Size: 0x3a
function function_5d642307() {
    self endon(#"death");
    self.var_e35c7b7e = 1;
    wait 0.1;
    self.var_e35c7b7e = undefined;
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 2, eflags: 0x1 linked
// Checksum 0x79b9759f, Offset: 0xa68
// Size: 0x48e
function function_765cb1de(var_f4d3512f, player) {
    self endon(#"death");
    if (!function_15e9bcbb()) {
        zm_utility::move_zombie_spawn_location(var_f4d3512f);
        return;
    }
    if (isdefined(self.anchor)) {
        zm_utility::move_zombie_spawn_location(var_f4d3512f);
        return;
    }
    if (!isdefined(player)) {
        player_info = function_6b19043d();
    } else {
        player_info = player function_15b283ea();
    }
    if (!isdefined(player_info)) {
        zm_utility::move_zombie_spawn_location(var_f4d3512f);
        return;
    }
    if (isdefined(player_info.player.var_d18573c9) && player_info.player.var_d18573c9 > gettime()) {
        zm_utility::move_zombie_spawn_location(var_f4d3512f);
        return;
    }
    var_1158d63 = function_f1ec5df(player_info.player, player_info.velocity, 1);
    if (var_1158d63.size == 0) {
        zm_utility::move_zombie_spawn_location(var_f4d3512f);
        return;
    }
    if (level.var_d4a79133 > 0) {
        zone = var_1158d63[0];
    } else {
        player_zone = player_info.player zm_utility::get_current_zone(1);
        if (!isdefined(var_1158d63)) {
            var_1158d63 = [];
        } else if (!isarray(var_1158d63)) {
            var_1158d63 = array(var_1158d63);
        }
        if (!isinarray(var_1158d63, player_zone)) {
            var_1158d63[var_1158d63.size] = player_zone;
        }
        zone = array::random(var_1158d63);
    }
    if (is_true(zone.var_bdbb9c51)) {
        zm_utility::move_zombie_spawn_location(var_f4d3512f);
        return;
    }
    spot = function_3b2d308f(player_info.player, zone);
    if (!isdefined(spot)) {
        zm_utility::move_zombie_spawn_location(var_f4d3512f);
        return;
    }
    if (level.var_d4a79133 > 0) {
        level.var_d4a79133--;
    }
    player_info.player.var_d18573c9 = gettime() + 1000;
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
    if (!is_true(self.dontshow)) {
        self show();
    }
    /#
        self thread function_cd00ea8(spot);
    #/
    self notify(#"risen", {#find_flesh_struct_string:"find_flesh"});
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 2, eflags: 0x1 linked
// Checksum 0xe18b7cfa, Offset: 0xf00
// Size: 0x2f6
function function_3b2d308f(player, zone) {
    if (zone.nodes.size == 0) {
        return undefined;
    }
    var_87d682f9 = "zombie_spawn_tacquery_" + level.players.size + "player";
    var_a83960b5 = function_dad4891b(player);
    switch (var_a83960b5.size) {
    case 0:
        var_e50a845c = tacticalquery(var_87d682f9, zone.nodes[0], player);
        break;
    case 1:
        var_e50a845c = tacticalquery(var_87d682f9, zone.nodes[0], player, var_a83960b5[0]);
        break;
    case 2:
        var_e50a845c = tacticalquery(var_87d682f9, zone.nodes[0], player, var_a83960b5[0], var_a83960b5[1]);
        break;
    case 3:
        var_e50a845c = tacticalquery(var_87d682f9, zone.nodes[0], player, var_a83960b5[0], var_a83960b5[1], var_a83960b5[2]);
        break;
    default:
        var_e50a845c = tacticalquery("zombie_spawn_tacquery_1player", zone.nodes[0], player);
        break;
    }
    if (var_e50a845c.size > 0) {
        var_ca2de8ef = array::random(var_e50a845c);
        var_ca2de8ef.script_string = "find_flesh";
        foreach (player in level.players) {
            if (sighttracepassed(player geteye(), var_ca2de8ef.origin + (0, 0, 72), 0, player)) {
                return undefined;
            }
        }
        return var_ca2de8ef;
    }
    return undefined;
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 3, eflags: 0x1 linked
// Checksum 0x167cea53, Offset: 0x1200
// Size: 0x292
function function_f1ec5df(player, direction, var_ef0ae03b) {
    var_9521d651 = [];
    if (!isplayer(player)) {
        return var_9521d651;
    }
    if (lengthsquared(direction) == 0) {
        return var_9521d651;
    }
    if (isdefined(player.var_34b4e1a) && player.var_2bb1c157 === gettime()) {
        var_c99b5df = player.var_34b4e1a;
    } else {
        var_c99b5df = function_34c58d6(player.origin, direction, 1000, 1);
        player.var_34b4e1a = var_c99b5df;
        player.var_2bb1c157 = gettime();
    }
    if (var_c99b5df.size > 0) {
        foreach (regioninfo in var_c99b5df) {
            foreach (zone in level.zones) {
                if (var_ef0ae03b && !zm_zonemgr::zone_is_enabled(zone.name)) {
                    continue;
                }
                if (isinarray(zone.nodes, regioninfo.regionnode)) {
                    if (!isdefined(var_9521d651)) {
                        var_9521d651 = [];
                    } else if (!isarray(var_9521d651)) {
                        var_9521d651 = array(var_9521d651);
                    }
                    if (!isinarray(var_9521d651, zone)) {
                        var_9521d651[var_9521d651.size] = zone;
                    }
                    break;
                }
            }
        }
    }
    return var_9521d651;
}

// Namespace zm_quick_spawning/zm_quick_spawning
// Params 1, eflags: 0x5 linked
// Checksum 0xa300727c, Offset: 0x14a0
// Size: 0xf2
function private function_dad4891b(player_in) {
    var_a83960b5 = [];
    foreach (player in getplayers()) {
        if (player_in == player) {
            continue;
        }
        if (!isdefined(var_a83960b5)) {
            var_a83960b5 = [];
        } else if (!isarray(var_a83960b5)) {
            var_a83960b5 = array(var_a83960b5);
        }
        var_a83960b5[var_a83960b5.size] = player;
    }
    return var_a83960b5;
}

/#

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 0, eflags: 0x0
    // Checksum 0xe6a91741, Offset: 0x15a0
    // Size: 0x80
    function function_ba3ebac4() {
        while (true) {
            waitframe(1);
            if (!getdvarint(#"hash_879482f07431cc8", 0)) {
                continue;
            }
            function_367e3573(1);
            setdvar(#"hash_879482f07431cc8", 0);
        }
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 1, eflags: 0x0
    // Checksum 0x15177f6e, Offset: 0x1628
    // Size: 0xbe
    function function_cd00ea8(spot) {
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
    // Checksum 0x9885cee7, Offset: 0x16f0
    // Size: 0x152
    function function_1dbfb733(type, name, condition, text_func) {
        if (!isdefined(level.var_fb3f2839)) {
            level.var_fb3f2839 = [];
        }
        if (!isdefined(level.var_fb3f2839[type])) {
            level.var_fb3f2839[type] = [];
        }
        debug_info = spawnstruct();
        debug_info.name = name;
        debug_info.type = type;
        debug_info.condition = condition;
        debug_info.text_func = text_func;
        if (!isdefined(level.var_fb3f2839[type])) {
            level.var_fb3f2839[type] = [];
        } else if (!isarray(level.var_fb3f2839[type])) {
            level.var_fb3f2839[type] = array(level.var_fb3f2839[type]);
        }
        level.var_fb3f2839[type][level.var_fb3f2839[type].size] = debug_info;
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 2, eflags: 0x4
    // Checksum 0x755f890d, Offset: 0x1850
    // Size: 0xa4
    function private create_hudelem(y, x) {
        if (!isdefined(x)) {
            x = 0;
        }
        var_aa917a22 = newdebughudelem();
        var_aa917a22.alignx = "<dev string:x38>";
        var_aa917a22.horzalign = "<dev string:x38>";
        var_aa917a22.aligny = "<dev string:x40>";
        var_aa917a22.vertalign = "<dev string:x4a>";
        var_aa917a22.y = y;
        var_aa917a22.x = x;
        return var_aa917a22;
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 1, eflags: 0x0
    // Checksum 0x2d9ac85b, Offset: 0x1900
    // Size: 0x5e
    function function_af42554f(debug_info) {
        return debug_info.name + "<dev string:x51>" + (is_true(self [[ debug_info.condition ]]()) ? "<dev string:x58>" : "<dev string:x64>");
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 1, eflags: 0x0
    // Checksum 0x262ce321, Offset: 0x1968
    // Size: 0x32
    function function_bc774350(debug_info) {
        return debug_info.name + "<dev string:x51>" + level.var_d4a79133;
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 1, eflags: 0x0
    // Checksum 0x8ab21950, Offset: 0x19a8
    // Size: 0xac
    function function_766c006e(debug_info) {
        if (!isdefined(self.var_d18573c9)) {
            return (debug_info.name + "<dev string:x70>");
        }
        time_left = max(self.var_d18573c9 - gettime(), 0);
        returnstring = debug_info.name + "<dev string:x51>" + (time_left < 0 ? "<dev string:x8a>" : "<dev string:x84>");
        returnstring += time_left;
        return returnstring;
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 0, eflags: 0x0
    // Checksum 0x9a6ab3ba, Offset: 0x1a60
    // Size: 0x884
    function function_af31614c() {
        function_1dbfb733("<dev string:x90>", "<dev string:x9a>", &function_12d4cf28, &function_af42554f);
        function_1dbfb733("<dev string:x90>", "<dev string:xad>", &function_15e9bcbb, &function_af42554f);
        function_1dbfb733("<dev string:x90>", "<dev string:xb6>", undefined, &function_bc774350);
        function_1dbfb733("<dev string:xcf>", "<dev string:xd9>", &function_1dfb06de, &function_af42554f);
        function_1dbfb733("<dev string:xcf>", "<dev string:xe2>", &function_f34e4a6b, &function_af42554f);
        function_1dbfb733("<dev string:xcf>", "<dev string:xfd>", undefined, &function_766c006e);
        while (true) {
            var_f6c7efda = getplayers().size;
            waitframe(1);
            if (!getdvarint(#"hash_1067641cdc653b13", 0) || var_f6c7efda != getplayers().size) {
                if (isdefined(level.var_3d62686d)) {
                    foreach (hudelem in level.var_3d62686d) {
                        hudelem destroy();
                    }
                    level.var_3d62686d = undefined;
                }
                continue;
            }
            if (!isdefined(level.var_3d62686d)) {
                current_y = 30;
                foreach (var_42e5f033 in level.var_fb3f2839) {
                    type = var_42e5f033[0].type;
                    var_aa917a22 = create_hudelem(current_y);
                    var_aa917a22 settext("<dev string:x112>" + type + "<dev string:x11b>");
                    if (!isdefined(level.var_3d62686d)) {
                        level.var_3d62686d = [];
                    } else if (!isarray(level.var_3d62686d)) {
                        level.var_3d62686d = array(level.var_3d62686d);
                    }
                    level.var_3d62686d[level.var_3d62686d.size] = var_aa917a22;
                    current_y += 10;
                    if (type == "<dev string:xcf>") {
                        current_x = 0;
                        foreach (player in level.players) {
                            var_aa917a22 = create_hudelem(current_y, current_x);
                            var_aa917a22 settext(player.playername);
                            if (!isdefined(level.var_3d62686d)) {
                                level.var_3d62686d = [];
                            } else if (!isarray(level.var_3d62686d)) {
                                level.var_3d62686d = array(level.var_3d62686d);
                            }
                            level.var_3d62686d[level.var_3d62686d.size] = var_aa917a22;
                            current_x += 110;
                        }
                        current_y += 10;
                    }
                    foreach (var_dc66eccb in var_42e5f033) {
                        current_x = 0;
                        if (var_dc66eccb.type == "<dev string:xcf>") {
                            foreach (player in level.players) {
                                var_aa917a22 = create_hudelem(current_y, current_x);
                                var_aa917a22.debug_info = var_dc66eccb;
                                var_aa917a22.target = player;
                                if (!isdefined(level.var_3d62686d)) {
                                    level.var_3d62686d = [];
                                } else if (!isarray(level.var_3d62686d)) {
                                    level.var_3d62686d = array(level.var_3d62686d);
                                }
                                level.var_3d62686d[level.var_3d62686d.size] = var_aa917a22;
                                current_x += 110;
                            }
                        } else {
                            var_aa917a22 = create_hudelem(current_y);
                            var_aa917a22.debug_info = var_dc66eccb;
                            var_aa917a22.target = level;
                            if (!isdefined(level.var_3d62686d)) {
                                level.var_3d62686d = [];
                            } else if (!isarray(level.var_3d62686d)) {
                                level.var_3d62686d = array(level.var_3d62686d);
                            }
                            level.var_3d62686d[level.var_3d62686d.size] = var_aa917a22;
                        }
                        current_y += 10;
                    }
                }
            }
            foreach (hudelem in level.var_3d62686d) {
                if (!isdefined(hudelem.debug_info)) {
                    continue;
                }
                hudelem settext(hudelem.target [[ hudelem.debug_info.text_func ]](hudelem.debug_info));
            }
        }
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 0, eflags: 0x0
    // Checksum 0x1a2bccc1, Offset: 0x22f0
    // Size: 0x18
    function function_12d4cf28() {
        return level.zombie_respawns > 0;
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 0, eflags: 0x0
    // Checksum 0x55d49fef, Offset: 0x2310
    // Size: 0x2c
    function function_1dfb06de() {
        player_info = self function_15b283ea();
        return isdefined(player_info);
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 0, eflags: 0x0
    // Checksum 0xcdfb3658, Offset: 0x2348
    // Size: 0x6a
    function function_f34e4a6b() {
        player_speed = self function_c5ea0b0();
        if (lengthsquared(player_speed) == 0) {
            return 0;
        }
        return function_f1ec5df(self, player_speed, 1).size > 0;
    }

    // Namespace zm_quick_spawning/zm_quick_spawning
    // Params 0, eflags: 0x0
    // Checksum 0xad75a51d, Offset: 0x23c0
    // Size: 0x314
    function function_497aad8f() {
        while (true) {
            waitframe(1);
            if (isdefined(level.zones) && getdvarint(#"hash_31275bfb1fec2d76", -1) > -1) {
                if (getdvarint(#"hash_31275bfb1fec2d76", -1) >= level.players.size) {
                    continue;
                }
                player = level.players[getdvarint(#"hash_31275bfb1fec2d76", -1)];
                playerdirection = player function_c5ea0b0();
                sphere(player.origin + playerdirection, 5, (0, 1, 0), 1, 0, 12, 1);
                if (lengthsquared(playerdirection) == 0) {
                    continue;
                }
                var_c99b5df = function_34c58d6(player.origin, playerdirection, 1000, 1);
                if (var_c99b5df.size > 0) {
                    foreach (regioninfo in var_c99b5df) {
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
