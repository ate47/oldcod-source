#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\bots\zm_bot_action;
#using scripts\zm_common\bots\zm_bot_position;

#namespace zm_bot;

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x2
// Checksum 0xc8ec0215, Offset: 0x188
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_bot", &__init__, undefined, undefined);
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x0
// Checksum 0x38b3ce21, Offset: 0x1d0
// Size: 0x16e
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_killed(&on_player_killed);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_laststand(&on_player_laststand);
    callback::on_revived(&on_player_revived);
    callback::on_start_gametype(&init);
    level.var_9baecddf = "bot_tacstate_zm_default";
    level.var_431500ee = "bot_tacstate_zm_laststand";
    level.onbotconnect = &on_bot_connect;
    level.onbotspawned = &on_bot_spawned;
    level.zm_bots_scale = getdvarint(#"zm_bots_scale", 1);
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x0
// Checksum 0xf10b69c3, Offset: 0x348
// Size: 0x9c
function init() {
    level endon(#"game_ended");
    botsoak = isdedicated() && getdvarint(#"sv_botsoak", 0);
    if (!botsoak) {
        level flag::wait_till("all_players_connected");
    }
    level thread bot::populate_bots();
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3f0
// Size: 0x4
function on_bot_connect() {
    
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x0
// Checksum 0x3a03f765, Offset: 0x400
// Size: 0x2a
function on_bot_spawned() {
    self.bot.var_87b5f83a = 150;
    self.bot.var_5d23ecf4 = 300;
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x0
// Checksum 0xa4f50e38, Offset: 0x438
// Size: 0xbc
function on_player_connect() {
    if (isbot(self)) {
        self botclassadditem(0, "perk_electric_cherry");
        self botclassadditem(0, "perk_staminup");
        self botclassadditem(0, "perk_quick_revive");
        self botclassadditem(0, "perk_dead_shot");
        self botclassadditem(0, "hero_chakram_lv1");
    }
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x0
// Checksum 0x85d07277, Offset: 0x500
// Size: 0x3c
function on_player_spawned() {
    level bot::function_3e733511(self.team);
    self thread function_bbaa9a4a();
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x0
// Checksum 0x987dbeb0, Offset: 0x548
// Size: 0x54
function on_player_killed() {
    if (isbot(self)) {
        self bot::clear_revive_target();
    }
    level bot::function_3e733511(self.team);
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x0
// Checksum 0xd6e5aab7, Offset: 0x5a8
// Size: 0x24
function on_player_disconnect() {
    level bot::function_3e733511(self.team);
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x0
// Checksum 0x196393e6, Offset: 0x5d8
// Size: 0x64
function on_player_laststand() {
    if (isbot(self)) {
        self bot::clear_revive_target();
    }
    waitframe(1);
    if (!isdefined(self)) {
        return;
    }
    level bot::function_3e733511(self.team);
}

// Namespace zm_bot/zm_bot
// Params 1, eflags: 0x0
// Checksum 0x9772a7ce, Offset: 0x648
// Size: 0x2c
function on_player_revived(params) {
    level bot::function_3e733511(self.team);
}

// Namespace zm_bot/button_bit_actionslot_2_pressed
// Params 0, eflags: 0x40
// Checksum 0x11010d66, Offset: 0x680
// Size: 0xd4
function event_handler[button_bit_actionslot_2_pressed] function_f3e7d51e() {
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

// Namespace zm_bot/zm_bot
// Params 1, eflags: 0x0
// Checksum 0x22c4cb0f, Offset: 0x760
// Size: 0x336
function order_bot(bot) {
    target = undefined;
    targetdistsq = undefined;
    targetdot = undefined;
    foreach (wallbuy in level._spawned_wallbuys) {
        distsq = distancesquared(self.origin, wallbuy.origin);
        if (distsq > 262144) {
            continue;
        }
        dot = self bot::fwd_dot(wallbuy.origin);
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
            iprintlnbold(bot.name + "<dev string:x30>" + target.zombie_weapon_upgrade);
        #/
        bot bot::set_interact(target);
        return;
    }
    doors = getentarray("zombie_door", "targetname");
    targetdistsq = undefined;
    targetdot = undefined;
    foreach (door in doors) {
        if (door._door_open) {
            continue;
        }
        distsq = distancesquared(self.origin, door.origin);
        if (distsq > 262144) {
            continue;
        }
        dot = self bot::fwd_dot(door.origin);
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
            iprintlnbold(bot.name + "<dev string:x3d>");
        #/
        bot bot::set_interact(target);
        return;
    }
}

// Namespace zm_bot/zm_bot
// Params 0, eflags: 0x0
// Checksum 0xb19267db, Offset: 0xaa0
// Size: 0x230
function function_bbaa9a4a() {
    self endon(#"death");
    self endon(#"disconnect");
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
// Params 1, eflags: 0x0
// Checksum 0xff81d56c, Offset: 0xcd8
// Size: 0x27c
function function_c68c1b9f(actor) {
    if (!isdefined(level.var_d5d80750)) {
        level.var_d5d80750 = [];
    }
    if (!isdefined(level.var_d5d80750[actor.archetype])) {
        level.var_d5d80750[actor.archetype] = spawnstruct();
        level.var_d5d80750[actor.archetype].round_number = -1;
        level.var_d5d80750[actor.archetype].min_health = actor ai::function_a0dbf10a().minhealth;
        level.var_d5d80750[actor.archetype].var_e36c2450 = isdefined(actor ai::function_a0dbf10a().var_e63097b4);
    }
    if (level.var_d5d80750[actor.archetype].round_number != level.round_number) {
        override_round_num = undefined;
        if (isdefined(actor._starting_round_number)) {
            override_round_num = actor._starting_round_number;
        }
        if (actor.archetype == #"zombie") {
            max_health = float(level.zombie_health);
        } else {
            max_health = float(actor zm_ai_utility::function_55a1bfd1(level.var_d5d80750[actor.archetype].var_e36c2450, override_round_num));
        }
        level.var_d5d80750[actor.archetype].scale = max_health / level.var_d5d80750[actor.archetype].min_health;
        level.var_d5d80750[actor.archetype].round_number = level.round_number;
    }
    return level.var_d5d80750[actor.archetype].scale * 1;
}

