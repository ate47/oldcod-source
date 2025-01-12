#using scripts\core_common\animation_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace teleport;

// Namespace teleport/teleport_shared
// Params 3, eflags: 0x0
// Checksum 0x10c326c5, Offset: 0xe0
// Size: 0x320
function team(kvp, var_b6bca4c6, var_60ed90fe = 0) {
    level function_a9a577e8();
    var_dbc75f02 = self function_7d11831a(kvp, var_b6bca4c6);
    if (!isdefined(var_dbc75f02)) {
        return 0;
    }
    if (var_dbc75f02.a_s_players.size < level.players.size) {
        assertmsg("<dev string:x30>");
        return undefined;
    }
    foreach (e_player in level.players) {
        foreach (s_teleport in var_dbc75f02.a_s_players) {
            if (!(isdefined(s_teleport.b_used) && s_teleport.b_used)) {
                e_player function_a6da2ca4(s_teleport, var_dbc75f02.var_b6bca4c6, var_60ed90fe);
                break;
            }
        }
    }
    if (isdefined(level.heroes)) {
        foreach (ai_hero in level.heroes) {
            foreach (s_teleport in var_dbc75f02.a_s_heroes) {
                if (isdefined(s_teleport.script_hero_name) && s_teleport.script_hero_name != ai_hero.targetname) {
                    continue;
                }
                if (!(isdefined(s_teleport.b_used) && s_teleport.b_used)) {
                    ai_hero function_addc6fe3(s_teleport, var_dbc75f02.var_b6bca4c6);
                    break;
                }
            }
        }
    }
    function_8db85ae7(kvp);
    return 1;
}

// Namespace teleport/teleport_shared
// Params 4, eflags: 0x0
// Checksum 0xa5822b89, Offset: 0x408
// Size: 0x178
function player(e_player, kvp, var_b6bca4c6, var_60ed90fe = 0) {
    if (!isalive(e_player)) {
        return;
    }
    level function_a9a577e8();
    var_cf44281 = self function_b429ae46(kvp, var_b6bca4c6);
    str_key = var_cf44281.str_key;
    str_value = var_cf44281.str_value;
    foreach (s_teleport in level.a_s_teleport_players) {
        if (s_teleport.(str_key) === str_value && !(isdefined(s_teleport.b_used) && s_teleport.b_used)) {
            e_player function_a6da2ca4(s_teleport, var_cf44281.var_b6bca4c6, var_60ed90fe);
            return 1;
        }
    }
    return 0;
}

// Namespace teleport/teleport_shared
// Params 3, eflags: 0x0
// Checksum 0x9bf26a8c, Offset: 0x588
// Size: 0x180
function hero(ai_hero, kvp, var_b6bca4c6) {
    level function_a9a577e8();
    var_cf44281 = self function_b429ae46(kvp, var_b6bca4c6);
    str_key = var_cf44281.str_key;
    str_value = var_cf44281.str_value;
    foreach (s_teleport in level.var_6ca9c4d1) {
        if (isdefined(s_teleport.script_hero_name) && s_teleport.script_hero_name != ai_hero.targetname) {
            continue;
        }
        if (s_teleport.(str_key) === str_value && !(isdefined(s_teleport.b_used) && s_teleport.b_used)) {
            ai_hero function_addc6fe3(s_teleport, var_cf44281.var_b6bca4c6);
            return true;
        }
    }
    return false;
}

// Namespace teleport/teleport_shared
// Params 1, eflags: 0x0
// Checksum 0x2c9ddd45, Offset: 0x710
// Size: 0xb6
function function_8db85ae7(kvp) {
    var_cf44281 = self function_b429ae46(kvp);
    foreach (s_teleport in struct::get_array(var_cf44281.str_value, var_cf44281.str_key)) {
        s_teleport.b_used = undefined;
    }
}

// Namespace teleport/teleport_shared
// Params 0, eflags: 0x4
// Checksum 0x9ca5af19, Offset: 0x7d0
// Size: 0x86
function private function_a9a577e8() {
    if (!isdefined(level.a_s_teleport_players)) {
        if (!isdefined(level.a_s_teleport_players)) {
            level.a_s_teleport_players = struct::get_array("teleport_player", "variantname");
        }
        if (!isdefined(level.var_6ca9c4d1)) {
            level.var_6ca9c4d1 = struct::get_array("teleport_hero", "variantname");
        }
    }
}

// Namespace teleport/teleport_shared
// Params 2, eflags: 0x4
// Checksum 0x31335225, Offset: 0x860
// Size: 0x13c
function private function_b429ae46(kvp, var_b6bca4c6) {
    if (isdefined(self.script_teleport_location)) {
        str_value = self.script_teleport_location;
        str_key = "script_teleport_location";
        if (!isdefined(var_b6bca4c6) && isdefined(self.script_regroup_distance)) {
            var_b6bca4c6 = self.script_regroup_distance;
        }
    } else if (isdefined(kvp) && isarray(kvp)) {
        str_value = kvp[0];
        str_key = kvp[1];
    } else {
        str_value = kvp;
        str_key = "script_teleport_location";
    }
    if (!isdefined(var_b6bca4c6)) {
        var_b6bca4c6 = 0;
    }
    if (!isdefined(str_value) || !isdefined(str_key)) {
        assertmsg("<dev string:x62>");
        return undefined;
    }
    return {#str_value:str_value, #str_key:str_key, #var_b6bca4c6:var_b6bca4c6};
}

// Namespace teleport/teleport_shared
// Params 2, eflags: 0x4
// Checksum 0x3c21d4f5, Offset: 0x9a8
// Size: 0x2d4
function private function_7d11831a(kvp, var_b6bca4c6) {
    var_cf44281 = self function_b429ae46(kvp, var_b6bca4c6);
    if (!isdefined(var_cf44281)) {
        return undefined;
    }
    str_key = var_cf44281.str_key;
    str_value = var_cf44281.str_value;
    a_s_players = [];
    foreach (s_teleport_player in level.a_s_teleport_players) {
        if (s_teleport_player.(str_key) === str_value) {
            if (!isdefined(a_s_players)) {
                a_s_players = [];
            } else if (!isarray(a_s_players)) {
                a_s_players = array(a_s_players);
            }
            if (!isinarray(a_s_players, s_teleport_player)) {
                a_s_players[a_s_players.size] = s_teleport_player;
            }
        }
    }
    a_s_heroes = [];
    if (isdefined(level.heroes)) {
        foreach (s_teleport_hero in level.var_6ca9c4d1) {
            if (s_teleport_hero.(str_key) === str_value) {
                if (!isdefined(a_s_heroes)) {
                    a_s_heroes = [];
                } else if (!isarray(a_s_heroes)) {
                    a_s_heroes = array(a_s_heroes);
                }
                if (!isinarray(a_s_heroes, s_teleport_hero)) {
                    a_s_heroes[a_s_heroes.size] = s_teleport_hero;
                }
            }
        }
        if (a_s_heroes.size < level.heroes.size) {
            assertmsg("<dev string:x97>");
            return undefined;
        }
    }
    return {#a_s_players:a_s_players, #a_s_heroes:a_s_heroes, #var_b6bca4c6:var_cf44281.var_b6bca4c6};
}

// Namespace teleport/teleport_shared
// Params 3, eflags: 0x4
// Checksum 0xdb928706, Offset: 0xc88
// Size: 0x22e
function private function_a6da2ca4(s_teleport, var_b6bca4c6, var_60ed90fe = 0) {
    self endon(#"death");
    if (distancesquared(s_teleport.origin, self.origin) < var_b6bca4c6 * var_b6bca4c6) {
        return;
    }
    s_teleport.b_used = 1;
    if (!var_60ed90fe) {
        self thread lui::screen_flash(0, 0.3, 0.3);
    }
    if (self isinvehicle()) {
        vehicle = self getvehicleoccupied();
        if (isdefined(s_teleport.script_allow_vehicle) && s_teleport.script_allow_vehicle) {
            vehicle.origin = s_teleport.origin;
            vehicle.angles = s_teleport.angles;
            self notify(#"teleported");
            vehicle notify(#"teleported");
            return;
        }
        vehicle makevehicleunusable();
    }
    if (isdefined(self._scene_object)) {
        [[ self._scene_object ]]->stop();
    } else if (self isplayinganimscripted()) {
        self animation::stop();
    }
    self setorigin(s_teleport.origin);
    self setplayerangles(s_teleport.angles);
    if (isdefined(vehicle)) {
        vehicle thread util::auto_delete();
    }
    self notify(#"teleported");
}

// Namespace teleport/teleport_shared
// Params 2, eflags: 0x0
// Checksum 0x2d8d3690, Offset: 0xec0
// Size: 0x116
function function_addc6fe3(s_teleport, var_b6bca4c6) {
    if (distancesquared(s_teleport.origin, self.origin) < var_b6bca4c6 * var_b6bca4c6) {
        return;
    }
    s_teleport.b_used = 1;
    self forceteleport(s_teleport.origin, s_teleport.angles);
    if (isdefined(s_teleport.target)) {
        node = getnode(s_teleport.target, "targetname");
    }
    if (isdefined(node)) {
        self setgoal(node);
    } else {
        self setgoal(s_teleport.origin);
    }
    self notify(#"teleported");
}

