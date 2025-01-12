#using script_cb32d07c95e5628;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\wz_common\wz_ai_vehicle;
#using scripts\wz_common\wz_ai_zombie;

#namespace wz_ai_utils;

// Namespace wz_ai_utils/wz_ai_utils
// Params 0, eflags: 0x2
// Checksum 0x2772c4c2, Offset: 0x168
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_ai_utils", &__init__, undefined, undefined);
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 0, eflags: 0x4
// Checksum 0x8773fffb, Offset: 0x1b0
// Size: 0x64
function private __init__() {
    level.var_5d14d5d5 = #"world";
    level.zombie_team = level.var_5d14d5d5;
    clientfield::register("scriptmover", "aizoneflag", 1, 1, "int");
}

/#

    // Namespace wz_ai_utils/wz_ai_utils
    // Params 0, eflags: 0x0
    // Checksum 0x6caa4ec6, Offset: 0x220
    // Size: 0x70a
    function debug_ai() {
        level endon(#"game_ended");
        level.var_220fa606 = [];
        level.var_220fa606[0] = "<dev string:x30>";
        level.var_220fa606[1] = "<dev string:x3a>";
        level.var_220fa606[2] = "<dev string:x41>";
        level.var_220fa606[3] = "<dev string:x4c>";
        level.var_220fa606[4] = "<dev string:x52>";
        level.var_220fa606[5] = "<dev string:x58>";
        while (true) {
            if (isdefined(level.var_604a6181) && level.var_604a6181) {
                axis = getaiteamarray(level.var_5d14d5d5);
                foreach (entity in axis) {
                    if (!isalive(entity)) {
                        continue;
                    }
                    org = entity.origin + (0, 0, 100);
                    if (isdefined(entity.aistate)) {
                        org = entity.origin + (0, 0, 85);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext((isdefined(level.var_220fa606[entity.aistate]) ? level.var_220fa606[entity.aistate] : "<dev string:x60>") + "<dev string:x68>" + entity.health, entity.origin, (1, 0.5, 0), "<dev string:x6a>", entity);
                        } else {
                            print3d(org, (isdefined(level.var_220fa606[entity.aistate]) ? level.var_220fa606[entity.aistate] : "<dev string:x60>") + "<dev string:x68>" + entity.health, (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    ai_cansee = 0;
                    if (isdefined(entity.enemy) && entity cansee(entity.enemy)) {
                        ai_cansee = 1;
                    }
                    if (isdefined(entity.canseeplayer)) {
                        org = entity.origin + (0, 0, 80);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x71>" + entity.canseeplayer + "<dev string:x79>" + ai_cansee + "<dev string:x7b>", entity.origin, (1, 0.5, 0), "<dev string:x6a>", entity);
                        } else {
                            print3d(org, "<dev string:x71>" + entity.canseeplayer + "<dev string:x79>" + ai_cansee + "<dev string:x7b>", (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    if (isdefined(entity.allowoffnavmesh)) {
                        org = entity.origin + (0, 0, 75);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x7d>" + entity.allowoffnavmesh, entity.origin, (1, 0.5, 0), "<dev string:x6a>", entity);
                        } else {
                            print3d(org, "<dev string:x7d>" + entity.allowoffnavmesh, (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    if (isdefined(entity.var_705d9447)) {
                        org = entity.origin + (0, 0, 70);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x85>" + entity.var_705d9447, entity.origin, (1, 0.5, 0), "<dev string:x6a>", entity);
                        } else {
                            print3d(org, "<dev string:x85>" + entity.var_705d9447, (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    if (isdefined(entity.var_fb776b4)) {
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x8e>", entity.origin, (0, 0, 1), "<dev string:x6a>", entity);
                            continue;
                        }
                        print3d(entity.var_fb776b4 + (0, 0, 10), "<dev string:x8e>", (0, 0, 1), 1, 1);
                    }
                }
            }
            waitframe(1);
        }
    }

#/

// Namespace wz_ai_utils/wz_ai_utils
// Params 0, eflags: 0x0
// Checksum 0xf8598618, Offset: 0x938
// Size: 0x7a
function hide_pop() {
    self endon(#"death");
    self ghost();
    wait 0.5;
    if (isdefined(self)) {
        self show();
        util::wait_network_frame();
        if (isdefined(self)) {
            self.create_eyes = 1;
        }
    }
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 4, eflags: 0x0
// Checksum 0xe87a7c68, Offset: 0x9c0
// Size: 0x284
function function_4feb4f21(spot_origin, spot_angles, anim_name, var_9eab12dc) {
    self endon(#"death");
    self clientfield::set("zombie_riser_fx", 1);
    self.in_the_ground = 1;
    if (var_9eab12dc) {
        self thread wz_ai_zombie::delayed_zombie_eye_glow();
    }
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = self.angles;
    self linkto(self.anchor);
    if (!isdefined(spot_angles)) {
        spot_angles = (0, 0, 0);
    }
    anim_org = spot_origin;
    anim_ang = spot_angles;
    anim_org += (0, 0, 0);
    self ghost();
    self.anchor moveto(anim_org, 0.05);
    self.anchor waittill(#"movedone");
    self unlink();
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self thread hide_pop();
    self orientmode("face default");
    self animscripted("rise_anim", self.origin, spot_angles, anim_name, "normal");
    self notify(#"rise_anim_finished");
    self.in_the_ground = 0;
    self clientfield::set("zombie_riser_fx", 0);
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 0, eflags: 0x4
// Checksum 0xdc6f7998, Offset: 0xc50
// Size: 0xe
function private function_489cfab4() {
    self.allowoffnavmesh = 0;
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 4, eflags: 0x0
// Checksum 0x3ab3299a, Offset: 0xc68
// Size: 0x25c
function function_47b052a(spot_origin, spot_angles, anim_name, var_ee406a8f) {
    self endon(#"death");
    if (!isdefined(anim_name)) {
        return;
    }
    self clientfield::set("zombie_riser_fx", 1);
    self.is_digging = 1;
    self animscripted("dig_anim", self.origin, self.angles, anim_name, "normal");
    self waittillmatch({#notetrack:"end"}, #"dig_anim");
    self ghost();
    self notsolid();
    self clientfield::set("zombie_riser_fx", 0);
    self pathmode("dont move", 1);
    spawn_point = self.ai_zone.spawn_points[randomint(self.ai_zone.spawn_points.size)];
    wait 2;
    self forceteleport(spawn_point.origin, spawn_point.angles);
    wait 2;
    self pathmode("move allowed");
    self solid();
    self function_4feb4f21(spawn_point.origin, spawn_point.angles, self.spawn_anim, 0);
    self.is_digging = 0;
    if (isdefined(var_ee406a8f)) {
        self [[ var_ee406a8f ]]();
    }
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 1, eflags: 0x0
// Checksum 0x865de732, Offset: 0xed0
// Size: 0x9c
function function_7a59ba87(ai_zone) {
    level endon(#"game_ended");
    self.ai_zone = ai_zone;
    self.disabletargetservice = 1;
    self.canseeplayer = undefined;
    self.var_9112257e = undefined;
    self.aistate = 0;
    self.favoriteenemy = undefined;
    self.team = level.var_5d14d5d5;
    self callback::function_1dea870d(#"on_ai_killed", &function_ee91edca);
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 1, eflags: 0x0
// Checksum 0x5b4faab7, Offset: 0xf78
// Size: 0x38
function function_ee91edca(params) {
    if (isdefined(self.ai_zone)) {
        self.ai_zone.var_91d29ce9--;
        self.ai_zone.var_a0ed3172++;
    }
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 1, eflags: 0x0
// Checksum 0x558941c5, Offset: 0xfb8
// Size: 0xf0
function is_player_valid(player) {
    if (!isdefined(player)) {
        return false;
    }
    if (!isalive(player)) {
        return false;
    }
    if (!isplayer(player)) {
        return false;
    }
    if (player.sessionstate == "spectator") {
        return false;
    }
    if (player.sessionstate == "intermission") {
        return false;
    }
    if (isdefined(player.intermission) && player.intermission) {
        return false;
    }
    if (player laststand::player_is_in_laststand()) {
        return false;
    }
    if (player.ignoreme || player isnotarget()) {
        return false;
    }
    return true;
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 1, eflags: 0x0
// Checksum 0xc25f69eb, Offset: 0x10b0
// Size: 0x11a
function function_8ac865a8(enemy) {
    if (!is_player_valid(enemy)) {
        return 0;
    }
    if (isdefined(self.canseeplayer) && gettime() < self.var_9112257e) {
        return self.canseeplayer;
    }
    targetpoint = isdefined(enemy.var_b49c3390) ? enemy.var_b49c3390 : enemy getcentroid();
    if (bullettracepassed(self geteye(), targetpoint, 0, enemy)) {
        self clearentitytarget();
        self.canseeplayer = 1;
        self.var_9112257e = gettime() + 2000;
    } else {
        self.canseeplayer = 0;
        self.var_9112257e = gettime() + 500;
    }
    return self.canseeplayer;
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 0, eflags: 0x0
// Checksum 0xd456a374, Offset: 0x11d8
// Size: 0x116
function ai_wz_can_see() {
    /#
        if (getdvarint(#"wz_ai_on", 0) > 2) {
            return undefined;
        }
    #/
    if (isdefined(self.favoriteenemy)) {
        if (self function_8ac865a8(self.favoriteenemy)) {
            return self.favoriteenemy;
        }
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].ai_zone) && players[i].ai_zone == self.ai_zone) {
            if (self function_8ac865a8(players[i])) {
                return players[i];
            }
        }
    }
    return undefined;
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 2, eflags: 0x0
// Checksum 0x281f7434, Offset: 0x12f8
// Size: 0xfe
function get_closest_player(str_zone, v_origin) {
    n_closest_dist = 9999999;
    var_3c3c118f = undefined;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].ai_zone) && players[i].ai_zone == str_zone) {
            n_dist = distance(players[i].origin, v_origin);
            if (n_dist < n_closest_dist) {
                n_closest_dist = n_dist;
                var_3c3c118f = players[i];
            }
        }
    }
    return var_3c3c118f;
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 2, eflags: 0x0
// Checksum 0x1941ffad, Offset: 0x1400
// Size: 0x130
function fake_physicslaunch(target_pos, power) {
    start_pos = self.origin;
    gravity = getdvarint(#"bg_gravity", 0) * -1;
    dist = distance(start_pos, target_pos);
    time = dist / power;
    delta = target_pos - start_pos;
    drop = 0.5 * gravity * time * time;
    velocity = (delta[0] / time, delta[1] / time, (delta[2] - drop) / time);
    self movegravity(velocity, time);
    return time;
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 2, eflags: 0x0
// Checksum 0x6785fe0f, Offset: 0x1538
// Size: 0xdc
function function_f5c3f36b(v_origin, ai_zone) {
    items = self namespace_f68e9756::function_99b7eb57("zombie_itemlist", 1);
    item = items[0];
    if (isdefined(item)) {
        ai_zone.var_e7ed204d++;
        item.origin = v_origin;
        dest_origin = function_d1dcc11d(v_origin);
        time = item fake_physicslaunch(dest_origin, 100);
        wait time;
        waitframe(1);
        item physicslaunch();
    }
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 1, eflags: 0x0
// Checksum 0xb4bee74d, Offset: 0x1620
// Size: 0xca
function function_d1dcc11d(v_origin) {
    var_250899ab = v_origin;
    queryresult = positionquery_source_navigation(var_250899ab, 50, 70, 500, 4);
    if (isdefined(queryresult.data[0])) {
        var_250899ab = queryresult.data[randomint(queryresult.data.size)].origin + (0, 0, 20);
    } else {
        var_250899ab = v_origin + (50, 50, 20);
    }
    return var_250899ab;
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 1, eflags: 0x0
// Checksum 0x288ac048, Offset: 0x16f8
// Size: 0xb4
function function_a2a4020(ai_zone) {
    waitresult = self waittill(#"death");
    var_ebb70479 = self.ai_zone;
    self.ai_zone = undefined;
    if (isplayer(waitresult.attacker)) {
        if (isdefined(var_ebb70479) && waitresult.attacker istouching(var_ebb70479)) {
            waitresult.attacker function_f5c3f36b(self.origin, ai_zone);
        }
    }
}

// Namespace wz_ai_utils/wz_ai_utils
// Params 1, eflags: 0x0
// Checksum 0xedf06c02, Offset: 0x17b8
// Size: 0xb2
function function_26a629a8(speed) {
    if (self.zombie_move_speed === speed) {
        return;
    }
    self.zombie_move_speed = speed;
    if (!isdefined(self.zombie_arms_position)) {
        self.zombie_arms_position = math::cointoss() == 1 ? "up" : "down";
    }
    if (isdefined(level.var_47a0b064)) {
        self.variant_type = randomint(level.var_47a0b064[self.zombie_move_speed][self.zombie_arms_position]);
    }
}

