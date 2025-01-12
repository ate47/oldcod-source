#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_utility;

#namespace zm_bot;

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x6
// Checksum 0x1d972689, Offset: 0x108
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_bot", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x5 linked
// Checksum 0xcfa2f185, Offset: 0x150
// Size: 0xac
function private function_70a657d8() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    level.var_df0a0911 = "bot_tacstate_zm_default";
    level.var_258cdebb = "bot_tacstate_zm_laststand";
    level.var_34eb792d = &handleplayerfasttravel;
    level.zm_bots_scale = getdvarint(#"zm_bots_scale", 1);
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x1 linked
// Checksum 0xf1dfc4de, Offset: 0x208
// Size: 0x1e
function on_player_connect() {
    if (isbot(self)) {
    }
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x1 linked
// Checksum 0x463e4de2, Offset: 0x230
// Size: 0x34
function on_player_spawned() {
    self thread function_69745ea0();
    self function_70e42260();
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x5 linked
// Checksum 0x64c9dd0c, Offset: 0x270
// Size: 0x62
function private function_70e42260() {
    if (isprofilebuild()) {
        if (getdvarint(#"scr_botsoaktest", 0)) {
            if (isbot(self)) {
                self.allowdeath = 0;
            }
        }
    }
}

/#

    // Namespace zm_bot/button_bit_actionslot_2_pressed
    // Params 0, eflags: 0x40
    // Checksum 0x2e493f8, Offset: 0x2e0
    // Size: 0x114
    function event_handler[button_bit_actionslot_2_pressed] function_9b83de0f() {
        if (getdvarint(#"zm_bot_orders", 0) == 0) {
            return;
        }
        players = getplayers();
        players = arraysort(players, self.origin);
        foreach (player in players) {
            if (!isbot(player)) {
                continue;
            }
            self order_bot(player);
            break;
        }
    }

#/

// Namespace zm_bot/zm_bot
// Params 1, eflags: 0x0
// Checksum 0x789b8a66, Offset: 0x400
// Size: 0x416
function order_bot(bot) {
    target = undefined;
    targetdistsq = undefined;
    targetdot = undefined;
    fwd = anglestoforward(self getplayerangles());
    eye = self.origin + (0, 0, self getplayerviewheight());
    foreach (wallbuy in level._spawned_wallbuys) {
        distsq = distancesquared(self.origin, wallbuy.origin);
        if (distsq > 262144) {
            continue;
        }
        dir = wallbuy.origin - eye;
        dot = vectordot(fwd, dir);
        if (dot < 0.985) {
            continue;
        }
        if (!isdefined(target) || dot > targetdot) {
            target = wallbuy;
            targetdistsq = distsq;
            targetdot = dot;
        }
    }
    if (isdefined(target)) {
        /#
            iprintlnbold(bot.name + "<dev string:x38>" + target.zombie_weapon_upgrade);
        #/
        bot bot::set_interact(target);
        return;
    }
    doors = getentarray("zombie_door", "targetname");
    targetdistsq = undefined;
    targetdot = undefined;
    fwd = anglestoforward(self getplayerangles());
    eye = self.origin + (0, 0, self getplayerviewheight());
    foreach (door in doors) {
        if (door._door_open) {
            continue;
        }
        distsq = distancesquared(self.origin, door.origin);
        if (distsq > 262144) {
            continue;
        }
        dir = door.origin - eye;
        dot = vectordot(fwd, dir);
        if (dot < 0.985) {
            continue;
        }
        if (!isdefined(target) || dot > targetdot) {
            target = door;
            targetdistsq = distsq;
            targetdot = dot;
        }
    }
    if (isdefined(target)) {
        /#
            iprintlnbold(bot.name + "<dev string:x48>");
        #/
        bot bot::set_interact(target);
        return;
    }
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x1 linked
// Checksum 0xa04f182e, Offset: 0x820
// Size: 0x238
function function_69745ea0() {
    self endon(#"death", #"disconnect");
    self notify(#"hash_6b46933396f9db04");
    self endon(#"hash_6b46933396f9db04");
    while (isdefined(self)) {
        if (isbot(self)) {
            maxsightdist = sqrt(self.maxsightdistsqrd);
            allenemies = self getenemiesinradius(self.origin, maxsightdist);
            allenemies = arraysortclosest(allenemies, self.origin);
            visibleenemy = allenemies[0];
            foreach (enemy in allenemies) {
                if (self cansee(enemy, 2500)) {
                    visibleenemy = enemy;
                    break;
                }
            }
            if (isdefined(visibleenemy) && isdefined(self.favoriteenemy) && self cansee(self.favoriteenemy, 2500)) {
                if (distance(self.origin, visibleenemy.origin) < distance(self.origin, self.favoriteenemy.origin) * 0.9) {
                    self.favoriteenemy = visibleenemy;
                }
            } else {
                self.favoriteenemy = visibleenemy;
            }
        }
        waitframe(1);
    }
}

// Namespace zm_bot/zm_bot
// Params 1, eflags: 0x1 linked
// Checksum 0x7287c388, Offset: 0xa60
// Size: 0x8c
function function_e16b5033(actor) {
    base_health = isdefined(actor ai::function_9139c839().basehealth) ? actor ai::function_9139c839().basehealth : 100;
    max_health = actor zm_ai_utility::function_f7014c3d(base_health);
    return max_health / base_health * 1;
}

// Namespace zm_bot/zm_bot
// Params 1, eflags: 0x1 linked
// Checksum 0x2e6de148, Offset: 0xaf8
// Size: 0xec
function function_1f9de69d(var_40b86c4b) {
    if (!isdefined(var_40b86c4b)) {
        return false;
    }
    players = getplayers();
    foreach (player in players) {
        if (isbot(player)) {
            continue;
        }
        currentzone = player zm_utility::get_current_zone();
        if (currentzone === var_40b86c4b) {
            return true;
        }
    }
    return false;
}

// Namespace zm_bot/zm_bot
// Params 2, eflags: 0x1 linked
// Checksum 0x4728026c, Offset: 0xbf0
// Size: 0x208
function handleplayerfasttravel(player, var_12230d08) {
    player endon(#"death");
    level notify(#"handleplayerfasttravel");
    level endon(#"handleplayerfasttravel");
    if (!isdefined(var_12230d08)) {
        return;
    }
    wait 3;
    currentzone = player zm_utility::get_current_zone();
    currentorigin = player.origin;
    if (!isdefined(currentzone)) {
        return;
    }
    players = getplayers();
    foreach (player in players) {
        if (!isbot(player)) {
            continue;
        }
        var_40b86c4b = player zm_utility::get_current_zone();
        if (var_40b86c4b === currentzone) {
            continue;
        }
        if (function_1f9de69d(var_40b86c4b)) {
            continue;
        }
        if (isdefined(level.var_1dbf5163) && ![[ level.var_1dbf5163 ]](player)) {
            continue;
        }
        if (isdefined(level.var_3c84697b)) {
            player thread [[ level.var_3c84697b ]](var_12230d08);
            continue;
        }
        player setorigin(currentorigin);
        player dontinterpolate();
    }
}

