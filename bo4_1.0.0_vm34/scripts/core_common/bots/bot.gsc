#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_chain;
#using scripts\core_common\bots\bot_interface;
#using scripts\core_common\bots\bot_position;
#using scripts\core_common\bots\bot_stance;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace bot;

// Namespace bot/bot
// Params 0, eflags: 0x2
// Checksum 0x2a795cb0, Offset: 0x210
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"bot", &__init__, undefined, undefined);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x1d337d1a, Offset: 0x258
// Size: 0x164
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_damage(&on_player_damage);
    callback::on_player_killed(&on_player_killed);
    callback::on_disconnect(&on_player_disconnect);
    level.var_18197185 = getgametypesetting(#"hash_77b7734750cd75e9");
    if (isdefined(level.var_18197185) && level.var_18197185) {
        thread function_d00e584b();
    }
    setdvar(#"bot_maxmantleheight", 200);
    /#
        level thread devgui_bot_loop();
        level thread bot_joinleave_loop();
    #/
    botinterface::registerbotinterfaceattributes();
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x8495a8c4, Offset: 0x3c8
// Size: 0x6
function is_bot_ranked_match() {
    return false;
}

// Namespace bot/bot
// Params 3, eflags: 0x0
// Checksum 0x59a965ff, Offset: 0x3d8
// Size: 0x182
function add_bot(team, name = undefined, clanabbrev = undefined) {
    bot = addtestclient(name, clanabbrev);
    if (!isdefined(bot)) {
        return undefined;
    }
    bot init_bot();
    bot.goalradius = 512;
    if (isdefined(level.disableclassselection) && level.disableclassselection) {
        bot.pers[#"class"] = level.defaultclass;
        bot.curclass = level.defaultclass;
    }
    if (level.teambased && isdefined(team) && isdefined(level.teams[team])) {
        bot.botteam = team;
    } else if (isdefined(team) && team == #"spectator") {
        bot.botteam = #"spectator";
    } else {
        bot.botteam = "autoassign";
    }
    return bot;
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x248b39c9, Offset: 0x568
// Size: 0x90
function add_bots(count = 1, team) {
    level endon(#"game_ended");
    for (i = 0; i < count; i++) {
        bot = add_bot(team);
        if (!isdefined(bot)) {
            return;
        }
        waitframe(1);
    }
}

// Namespace bot/bot
// Params 4, eflags: 0x0
// Checksum 0x2c9bf4e5, Offset: 0x600
// Size: 0xd4
function add_fixed_spawn_bot(team, origin, yaw, roleindex = undefined) {
    bot = add_bot(team);
    if (isdefined(bot)) {
        if (isdefined(roleindex)) {
            bot.var_f1a6dad4 = int(roleindex);
        }
        bot allow_all(0);
        node = bot get_nearest_node(origin);
        bot thread fixed_spawn_override(origin, yaw, node);
    }
}

// Namespace bot/bot
// Params 4, eflags: 0x0
// Checksum 0x9479ffe8, Offset: 0x6e0
// Size: 0xca
function add_balanced_bot(allies, maxallies, axis, maxaxis) {
    bot = undefined;
    if (allies.size < maxallies && (allies.size <= axis.size || axis.size >= maxaxis)) {
        bot = add_bot(#"allies");
    } else if (axis.size < maxaxis) {
        bot = add_bot(#"axis");
    }
    return isdefined(bot);
}

// Namespace bot/bot
// Params 4, eflags: 0x0
// Checksum 0xa4339381, Offset: 0x7b8
// Size: 0x158
function fixed_spawn_override(origin, yaw, node = undefined, force = 1) {
    self endon(#"disconnect");
    angles = (0, yaw, 0);
    while (isdefined(self.bot)) {
        self waittill(#"spawned_player");
        if (isdefined(node)) {
            self setorigin(node.origin);
            self setplayerangles(node.angles);
            self setgoal(node, force);
        } else {
            self setorigin(origin);
            self setplayerangles(angles);
            self setgoal(origin, force);
        }
        self dontinterpolate();
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xa56737c7, Offset: 0x918
// Size: 0xd8
function remove_bots(team) {
    players = getplayers();
    foreach (player in players) {
        if (!player istestclient()) {
            continue;
        }
        if (isdefined(team) && player.team != team) {
            continue;
        }
        remove_bot(player);
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xa48f039b, Offset: 0x9f8
// Size: 0x6c
function remove_random_bot() {
    bots = get_bots();
    if (!bots.size) {
        return;
    }
    bot = bots[randomint(bots.size)];
    remove_bot(bot);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xb8071969, Offset: 0xa70
// Size: 0x64
function remove_bot(bot) {
    if (!bot istestclient()) {
        return;
    }
    if (isdefined(level.onbotremove)) {
        bot [[ level.onbotremove ]]();
    }
    bot botdropclient();
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x4d0b2516, Offset: 0xae0
// Size: 0x32
function get_bots() {
    players = getplayers();
    return filter_bots(players);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x853045ad, Offset: 0xb20
// Size: 0xa8
function filter_bots(players) {
    bots = [];
    foreach (player in players) {
        if (isbot(player)) {
            bots[bots.size] = player;
        }
    }
    return bots;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x87febdc9, Offset: 0xbd0
// Size: 0xc4
function get_friendly_bots() {
    players = getplayers(self.team);
    bots = [];
    foreach (player in players) {
        if (!isbot(player)) {
            continue;
        }
        bots[bots.size] = player;
    }
    return bots;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xb63a6b63, Offset: 0xca0
// Size: 0xd6
function get_enemy_bots() {
    players = getplayers();
    bots = [];
    foreach (player in players) {
        if (!isbot(player)) {
            continue;
        }
        if (player.team != self.team) {
            bots[bots.size] = player;
        }
    }
    return bots;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x1f4e19cf, Offset: 0xd80
// Size: 0xcc
function function_ca55e5ea(team) {
    players = getplayers(team);
    bots = [];
    foreach (player in players) {
        if (!isbot(player)) {
            continue;
        }
        bots[bots.size] = player;
    }
    return bots;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xe55e124b, Offset: 0xe58
// Size: 0xc0
function get_bot_by_entity_number(entnum) {
    players = getplayers();
    foreach (player in players) {
        if (!isbot(player)) {
            continue;
        }
        if (player getentitynumber() == entnum) {
            return player;
        }
    }
    return undefined;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x471b7dc2, Offset: 0xf20
// Size: 0x94
function bot_count() {
    count = 0;
    foreach (player in level.players) {
        if (player istestclient()) {
            count++;
        }
    }
    return count;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x20635d00, Offset: 0xfc0
// Size: 0xf6
function on_player_connect() {
    if (!self istestclient()) {
        return;
    }
    self endon(#"disconnect");
    /#
        self thread add_bot_devgui_menu();
    #/
    if (!self initialized()) {
        self init_bot();
    }
    waitframe(1);
    if (isdefined(level.onbotconnect)) {
        self thread [[ level.onbotconnect ]]();
    }
    if (isdefined(self.var_f1a6dad4) && player_role::is_valid(self.var_f1a6dad4)) {
        player_role::set(self.var_f1a6dad4);
        self.var_f1a6dad4 = undefined;
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xddfce614, Offset: 0x10c0
// Size: 0x24c
function on_player_spawned() {
    if (!isbot(self)) {
        return;
    }
    /#
        weapon = undefined;
        if (getdvarstring(#"bot_spawn_weapon", "<dev string:x30>") != "<dev string:x30>") {
            weapon = util::get_weapon_by_name(getdvarstring(#"bot_spawn_weapon"), getdvarstring(#"hash_c6e51858c88a5ee"));
            if (isdefined(weapon)) {
                self function_184438f2(weapon);
            }
        }
    #/
    self.var_e13b45f4 = undefined;
    if (self bot_chain::function_3a0e73ad()) {
        self bot_chain::function_dda3d64();
    } else if (ai::getaiattribute(self, "control") === "autonomous" && isdefined(self.bot.var_5cff12d7)) {
        self setgoal(self.bot.var_5cff12d7, self.bot.var_59330b87);
    } else {
        self setgoal(self.origin);
    }
    self function_163e1835();
    if (isdefined(level.onbotspawned)) {
        self thread [[ level.onbotspawned ]]();
    }
    self thread update_loop();
    if (getdvarint(#"bots_invulnerable", 0)) {
        self val::set(#"devgui", "takedamage", 0);
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x96951ee7, Offset: 0x1318
// Size: 0x6e
function on_player_damage(params) {
    if (!isbot(self)) {
        return;
    }
    if (function_a5354464(self.enemy)) {
        self clearentitytarget();
        self.bot.var_470dfa67 = 0;
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xf38ab4ca, Offset: 0x1390
// Size: 0xac
function on_player_killed() {
    if (!isbot(self)) {
        return;
    }
    self clear_interact();
    self clear_revive_target();
    if (isdefined(level.onbotkilled)) {
        self thread [[ level.onbotkilled ]]();
    }
    self clearentitytarget();
    self.bot.var_470dfa67 = 0;
    self botreleasemanualcontrol();
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xcba6136e, Offset: 0x1448
// Size: 0x3c
function on_player_disconnect() {
    if (!self istestclient()) {
        return;
    }
    /#
        self clear_bot_devgui_menu();
    #/
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xd358cdee, Offset: 0x1490
// Size: 0x90
function function_3894691d() {
    /#
        self thread add_bot_devgui_menu();
    #/
    if (!self initialized()) {
        self init_bot();
    }
    self.goalradius = 512;
    self thread update_loop();
    if (isdefined(level.onbotspawned)) {
        self thread [[ level.onbotspawned ]]();
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xa3f9b0f3, Offset: 0x1528
// Size: 0x36
function function_8747b717() {
    /#
        self clear_bot_devgui_menu();
    #/
    self notify(#"hash_a729d7d4c6847f6");
    self.bot = undefined;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xd703aba2, Offset: 0x1568
// Size: 0x506
function update_loop() {
    /#
        if (getdvarint(#"hash_40d23c5b73e8bad4", 0)) {
            waitframe(1);
            self bottakemanualcontrol();
            return;
        }
    #/
    self endon(#"death", #"bled_out");
    level endon(#"game_ended");
    if (isdefined(level.var_18197185) && level.var_18197185) {
        waitframe(1);
        self bottakemanualcontrol();
        return;
    }
    self bot_action::start();
    self bot_position::start();
    self bot_stance::start();
    while (isdefined(self.bot)) {
        if (!isbot(self) || !self initialized()) {
            self bot_action::stop();
            self bot_position::stop();
            self bot_stance::stop();
            return;
        }
        tacbundle = self function_9dca972f();
        /#
            if (!isdefined(tacbundle)) {
                record3dtext("<dev string:x31>", self.origin, (1, 0, 0), "<dev string:x3a>", self, 0.5);
                waitframe(1);
                continue;
            }
            record3dtext("<dev string:x41>" + tacbundle.name + "<dev string:x44>", self.origin, (1, 1, 1), "<dev string:x3a>", self, 0.5);
            if (isdefined(self get_revive_target())) {
                target = self get_revive_target().origin;
                recordline(self.origin, target, (0, 1, 1), "<dev string:x3a>", self);
                recordcircle(target, 32, (0, 1, 1), "<dev string:x3a>", self);
            }
        #/
        self function_1f0c9158();
        self function_bc2127d3();
        self function_4775a73f();
        if (!self isplayinganimscripted() && !self arecontrolsfrozen() && !self function_416a50a4() && !self isinvehicle() && isdefined(self.sessionstate) && self.sessionstate == "playing") {
            self bot_action::update();
            self bot_position::update(tacbundle);
            self bot_stance::update(tacbundle);
            self update_swim();
        } else {
            self bot_action::reset();
            self bot_position::reset();
            self bot_stance::reset();
            if (self function_7928da6()) {
                gameobject = self get_interact();
                if (isdefined(gameobject.inuse) && gameobject.inuse && isdefined(gameobject.trigger) && self.claimtrigger === gameobject.trigger) {
                    self bottapbutton(3);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xa0ddaa45, Offset: 0x1a78
// Size: 0x314
function function_d00e584b() {
    /#
        if (getdvarint(#"hash_40d23c5b73e8bad4", 0)) {
            return;
        }
    #/
    level endon(#"game_ended");
    while (game.state !== "playing") {
        waitframe(1);
    }
    while (game.state == "playing") {
        waitframe(1);
        players = getplayers();
        foreach (player in players) {
            waitframe(1);
            if (!isdefined(player) || !isalive(player) || !isbot(player) || !player isonground()) {
                continue;
            }
            if (!isdefined(player.botenemy) || !isbot(player.botenemy) || !isalive(player.botenemy) || player.team == player.botenemy.team) {
                player.botenemy = players[randomint(players.size)];
                player botsetmovemagnitude(0);
                player bottapbutton(4);
                continue;
            }
            center = player.botenemy getcentroid();
            player botsetmovepoint(player.botenemy.origin);
            player botsetmovemagnitude(1);
            player botsetlookpoint(center);
            if (player function_a3ec3e() && distance2dsquared(player.origin, center) < 3062500) {
                player bottapbutton(0);
            }
        }
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x6b26c792, Offset: 0x1d98
// Size: 0x174
function function_bc2127d3() {
    if (self function_7928da6()) {
        gameobject = self get_interact();
        if (!isdefined(gameobject.trigger) || !gameobject.trigger istriggerenabled() || !gameobject gameobjects::can_interact_with(self)) {
            self clear_interact();
        } else if (isdefined(gameobject.inuse) && gameobject.inuse && self.claimtrigger !== gameobject.trigger) {
            self clear_interact();
        }
        return;
    }
    if (self function_cdf20f6b()) {
        return;
    }
    if (self function_ccdf4349()) {
        return;
    }
    if (self has_interact()) {
        /#
            self botprinterror("<dev string:x47>");
        #/
        self clear_interact();
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x569d007a, Offset: 0x1f18
// Size: 0x86
function function_4775a73f() {
    if (!has_visible_enemy()) {
        self.bot.var_3cbdf005 = isdefined(self.bot.tacbundle.inaccuracy) ? self.bot.tacbundle.inaccuracy : 0;
        self.bot.aimoffset = (0, 0, 0);
        self.bot.var_e7cf4067 = (0, 0, 0);
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x32ef2052, Offset: 0x1fa8
// Size: 0xbc
function function_1f0c9158() {
    if (isdefined(self.revivetrigger)) {
        if (isstring(level.var_431500ee) && self.bot.tacbundle.name != level.var_431500ee) {
            self function_f242f2bb(level.var_431500ee);
        }
        return;
    }
    if (isdefined(self.var_ae1fb00a)) {
        self function_f242f2bb(self.var_ae1fb00a);
        return;
    }
    self function_163e1835();
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x820f6391, Offset: 0x2070
// Size: 0x19c
function function_4378a549() {
    if (isdefined(self.bot.var_470dfa67) && self.bot.var_470dfa67 && !function_a5354464(self.enemy)) {
        self.bot.var_470dfa67 = 0;
        self clearentitytarget();
        return;
    }
    if (!isdefined(self.enemy) || !function_a5354464(self.enemy)) {
        return;
    }
    if (self.ignoreall || isdefined(self.enemy.var_65f743a8) && self.enemy.var_65f743a8 || self.enemy ai::function_3416a7e4()) {
        self clearentitytarget();
        return;
    }
    targetpoint = isdefined(self.enemy.var_b49c3390) ? self.enemy.var_b49c3390 : self.enemy getcentroid();
    if (!sighttracepassed(self geteye(), targetpoint, 0, self.enemy)) {
        self clearentitytarget();
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x8a8e41a2, Offset: 0x2218
// Size: 0x2e4
function update_swim() {
    if (!self isplayerswimming()) {
        self.bot.resurfacetime = undefined;
        return;
    }
    if (isdefined(self.drownstage) && self.drownstage != 0) {
        self bottapbutton(67);
        return;
    }
    if (self isplayerunderwater()) {
        if (!isdefined(self.bot.resurfacetime)) {
            self.bot.resurfacetime = gettime() + int((self.playerrole.swimtime - 1) * 1000);
        }
    } else {
        if (isdefined(self.bot.resurfacetime) && gettime() - self.bot.resurfacetime < int(2 * 1000)) {
            self bottapbutton(67);
            return;
        }
        self.bot.resurfacetime = undefined;
    }
    if (self botundermanualcontrol()) {
        return;
    }
    goalposition = self.goalpos;
    if (distance2dsquared(goalposition, self.origin) <= 16384 && getwaterheight(goalposition) > 0) {
        self bottapbutton(68);
        return;
    }
    if (isdefined(self.bot.resurfacetime) && self.bot.resurfacetime <= gettime()) {
        self bottapbutton(67);
        return;
    }
    bottomtrace = groundtrace(self.origin, self.origin + (0, 0, -1000), 0, self, 1);
    swimheight = self.origin[2] - bottomtrace[#"position"][2];
    if (swimheight < 25) {
        self bottapbutton(67);
        return;
    }
    if (swimheight > 45) {
        self bottapbutton(68);
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xcc10b173, Offset: 0x2508
// Size: 0xfc
function init_bot() {
    self.bot = spawnstruct();
    ai::createinterfaceforentity(self);
    self function_163e1835();
    self.bot.var_87b5f83a = 300;
    self.bot.var_5d23ecf4 = 470;
    self.bot.var_58dc4d2e = 0;
    self.bot.var_c9739ad5 = 0;
    self.bot.var_80fecbdf = 0;
    self.bot.var_622eee0 = 0;
    self.bot.var_359e0919 = 0;
    blackboard::createblackboardforentity(self);
    self function_23332dc6(#"hash_1b029888c4965031", #"hash_41b1340b7efb3261");
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xebb563ba, Offset: 0x2610
// Size: 0xc
function initialized() {
    return isdefined(self.bot);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x6f40f5b6, Offset: 0x2628
// Size: 0x3c
function function_163e1835() {
    self function_f242f2bb(isdefined(level.var_9baecddf) ? level.var_9baecddf : "bot_tacstate_default");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xc2d64465, Offset: 0x2670
// Size: 0x32e
function function_f242f2bb(bundlename) {
    tacbundle = getscriptbundle(bundlename);
    if (!isdefined(tacbundle)) {
        /#
            self botprinterror("<dev string:x66>" + bundlename);
        #/
        return;
    }
    if (self.bot.tacbundle === tacbundle) {
        return;
    }
    maxsightdist = isdefined(tacbundle.maxsightdist) ? tacbundle.maxsightdist : 0;
    self.maxsightdistsqrd = maxsightdist * maxsightdist;
    self.highlyawareradius = isdefined(tacbundle.highlyawareradius) ? tacbundle.highlyawareradius : 0;
    self.fovcosine = fov_angle_to_cosine(tacbundle.fov);
    self.fovcosinebusy = fov_angle_to_cosine(tacbundle.fovbusy);
    self.perfectaim = isdefined(tacbundle.perfectaim) ? tacbundle.perfectaim : 0;
    self.accuracy = isdefined(tacbundle.accuracy) ? tacbundle.accuracy : 0;
    self.pacifist = isdefined(tacbundle.pacifist) ? tacbundle.pacifist : 0;
    self.pacifistwait = isdefined(tacbundle.pacifistwait) ? tacbundle.pacifistwait : 0;
    self botsetlooksensitivity(isdefined(tacbundle.pitchsensitivity) ? tacbundle.pitchsensitivity : 0, isdefined(tacbundle.yawsensitivity) ? tacbundle.yawsensitivity : 0);
    self function_b0c6fe39(isdefined(tacbundle.pitchacceleration) ? tacbundle.pitchacceleration : 0, isdefined(tacbundle.yawacceleration) ? tacbundle.yawacceleration : 0);
    self function_466583d8(isdefined(tacbundle.var_9fc91905) ? tacbundle.var_9fc91905 : 0, isdefined(tacbundle.var_e5f608a0) ? tacbundle.var_e5f608a0 : 0);
    self function_769277e7(isdefined(tacbundle.var_125c200b) ? tacbundle.var_125c200b : 0, isdefined(tacbundle.var_cd642a14) ? tacbundle.var_cd642a14 : 0);
    self.bot.tacbundle = tacbundle;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x3c7990b5, Offset: 0x29a8
// Size: 0x42
function fov_angle_to_cosine(fovangle = 0) {
    if (fovangle >= 180) {
        return 0;
    }
    return cos(fovangle / 2);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x2c5a0478, Offset: 0x29f8
// Size: 0x12
function function_9dca972f() {
    return self.bot.tacbundle;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x29528ac1, Offset: 0x2a18
// Size: 0x1e
function set_interact(interact) {
    self.bot.interact = interact;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x2bddd34c, Offset: 0x2a40
// Size: 0x12
function clear_interact() {
    self.bot.interact = undefined;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x1a98e2a9, Offset: 0x2a60
// Size: 0x12
function get_interact() {
    return self.bot.interact;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xfe4820ae, Offset: 0x2a80
// Size: 0x14
function has_interact() {
    return isdefined(self.bot.interact);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xdde51686, Offset: 0x2aa0
// Size: 0x5a
function function_7928da6() {
    return isdefined(self.bot.interact) && isdefined(self.bot.interact.trigger) && self.bot.interact.triggertype === "use";
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x227307bf, Offset: 0x2b08
// Size: 0x32
function function_cdf20f6b() {
    return isdefined(self.bot.interact) && isdefined(self.bot.interact.zombie_weapon_upgrade);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x32c2eb70, Offset: 0x2b48
// Size: 0x56
function function_105e698c() {
    return isdefined(self.bot.interact) && isdefined(self.bot.interact.zombie_cost) && self.bot.interact._door_open !== 1;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x8c84e9f1, Offset: 0x2ba8
// Size: 0x5e
function function_afa34057() {
    return isdefined(self.bot.interact) && self.bot.interact.objectid === "magicbox_struct" && self.bot.interact.hidden !== 1;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xb3a72372, Offset: 0x2c10
// Size: 0x3a
function function_a80eeee9() {
    return isdefined(self.bot.interact) && self.bot.interact.script_unitrigger_type === "unitrigger_box_use";
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xc3465c8d, Offset: 0x2c58
// Size: 0x44
function function_ccdf4349() {
    return function_105e698c() || function_afa34057() || function_a80eeee9();
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x5a930bb9, Offset: 0x2ca8
// Size: 0x12
function get_revive_target() {
    return self.bot.revivetarget;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x8b06b778, Offset: 0x2cc8
// Size: 0x1e
function set_revive_target(target) {
    self.bot.revivetarget = target;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x17b55398, Offset: 0x2cf0
// Size: 0x1c
function clear_revive_target() {
    self set_revive_target(undefined);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x946de24c, Offset: 0x2d18
// Size: 0x6e
function menu_cancel(menukey) {
    self notify(#"menuresponse", {#menu:game.menu[menukey], #response:"cancel", #intpayload:0});
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x7ce0d086, Offset: 0x2d90
// Size: 0x58
function has_visible_enemy() {
    if (self in_combat()) {
        return (isalive(self.enemy) && self cansee(self.enemy));
    }
    return false;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x83171bed, Offset: 0x2df0
// Size: 0x64
function in_combat() {
    if (!isdefined(self.enemy)) {
        return false;
    }
    switch (self.combatstate) {
    case #"combat_state_aware_of_enemies":
    case #"combat_state_in_combat":
    case #"combat_state_has_visible_enemy":
        return true;
    }
    return false;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x3503d24f, Offset: 0x2e60
// Size: 0xc2
function fwd_dot(point) {
    angles = self getplayerangles();
    fwd = anglestoforward(angles);
    eye = self geteye();
    dir = point - eye;
    dir = vectornormalize(dir);
    dot = vectordot(fwd, dir);
    return dot;
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0xe6cee85e, Offset: 0x2f30
// Size: 0x36
function function_905773a(smin, smax) {
    return gettime() + 1000 * randomfloatrange(smin, smax);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xb655df1c, Offset: 0x2f70
// Size: 0xe2
function eye_trace(hitents = 0) {
    direction = self getplayerangles();
    direction_vec = anglestoforward(direction);
    eye = self geteye();
    scale = 8000;
    direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
    return bullettrace(eye, eye + direction_vec, hitents, self);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x1b57563d, Offset: 0x3060
// Size: 0xc4
function function_68d6034a() {
    if (!isbot(self)) {
        return false;
    }
    if (self isinvehicle()) {
        vehicle = self getvehicleoccupied();
        if (isdefined(vehicle.goalforced) && vehicle.goalforced || isdefined(vehicle.ignoreall) && vehicle.ignoreall) {
            return false;
        }
    } else if (self.goalforced || self.ignoreall) {
        return false;
    }
    return true;
}

// Namespace bot/bot
// Params 4, eflags: 0x0
// Checksum 0x31927208, Offset: 0x3130
// Size: 0x24
function function_42bd6558(entity, attribute, oldvalue, value) {
    
}

// Namespace bot/bot
// Params 4, eflags: 0x0
// Checksum 0x338ca3d9, Offset: 0x3160
// Size: 0x11e
function get_nearest_node(pos, maxradius = 24, minradius = 0, height = 64) {
    nodes = getnodesinradiussorted(pos, maxradius, minradius, height, "Scripted");
    if (nodes.size > 0) {
        return nodes[0];
    }
    nodes = getnodesinradiussorted(pos, maxradius, minradius, height, "Cover");
    if (nodes.size > 0) {
        return nodes[0];
    }
    nodes = getnodesinradiussorted(pos, maxradius, minradius, height, "Path");
    if (nodes.size > 0) {
        return nodes[0];
    }
    return undefined;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x4f19ebb7, Offset: 0x3288
// Size: 0x46
function get_position_node() {
    if (isdefined(self.node)) {
        return self.node;
    } else if (!isdefined(self.overridegoalpos) && isdefined(self.goalnode)) {
        return self.goalnode;
    }
    return undefined;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x18d665cb, Offset: 0x32d8
// Size: 0x12c
function allow_all(allow) {
    self.ignoreall = !allow;
    self ai::set_behavior_attribute("allowprimaryoffhand", allow);
    self ai::set_behavior_attribute("allowsecondaryoffhand", allow);
    self ai::set_behavior_attribute("allowspecialoffhand", allow);
    self ai::set_behavior_attribute("allowscorestreak", allow);
    if (allow) {
        self ai::set_behavior_attribute("control", "commander");
        self clearforcedgoal();
        return;
    }
    self ai::set_behavior_attribute("control", "autonomous");
    self setgoal(self.origin, 1);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xde1ded5d, Offset: 0x3410
// Size: 0x11a
function function_75b62024(trigger) {
    assert(isbot(self));
    assert(isdefined(trigger));
    radius = self getpathfindingradius();
    height = self function_5c52d4ac();
    heightoffset = (0, 0, height * -1 / 2);
    var_e69d54e8 = (radius, radius, height / 2);
    obb = ai::function_63b748bd(trigger.origin + heightoffset, trigger.maxs + var_e69d54e8, trigger.angles);
    return obb;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x40b1b573, Offset: 0x3538
// Size: 0x152
function function_80dce372(trigger) {
    assert(isbot(self));
    assert(isstruct(trigger));
    radius = self getpathfindingradius();
    height = self function_5c52d4ac();
    heightoffset = (0, 0, height * -1 / 2);
    var_e69d54e8 = (radius, radius, height / 2);
    maxs = (trigger.script_width, trigger.script_length, trigger.script_height);
    obb = ai::function_63b748bd(trigger.origin + heightoffset, maxs + var_e69d54e8, trigger.angles);
    return obb;
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x41baa63a, Offset: 0x3698
// Size: 0x12c
function function_34f76f34(tacbundle, dvarstr) {
    healthratio = self.health / self.maxhealth;
    if (healthratio <= tacbundle.var_b7baa2a0) {
        /#
            self record_text("<dev string:xa7>", (1, 0, 0), dvarstr);
        #/
        return false;
    }
    if (self isreloading()) {
        /#
            self record_text("<dev string:xb4>", (1, 0, 0), dvarstr);
        #/
        return false;
    }
    weapon = self getcurrentweapon();
    if (weapon != level.weaponnone && self getweaponammoclip(weapon) <= 0) {
        /#
            self record_text("<dev string:xc0>", (1, 0, 0), dvarstr);
        #/
        return false;
    }
    return true;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xe3b1c796, Offset: 0x37d0
// Size: 0x12a
function function_4e025546(lefthand = 0) {
    weapon = self get_current_weapon(lefthand);
    buttonbit = lefthand ? 24 : 0;
    self bottapbutton(buttonbit);
    if (isdefined(level.var_8d9d90ec)) {
        self [[ level.var_8d9d90ec ]](lefthand);
        return;
    }
    if (weapon function_9a4655fe()) {
        var_58dc4d2e = gettime() + randomintrange(self.bot.var_87b5f83a, self.bot.var_5d23ecf4);
        if (lefthand) {
            self.bot.var_c9739ad5 = var_58dc4d2e;
            return;
        }
        self.bot.var_58dc4d2e = var_58dc4d2e;
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xdb7b8166, Offset: 0x3908
// Size: 0x4c
function function_58e90f90(lefthand = 0) {
    if (function_34a60ad(lefthand)) {
        function_4e025546(lefthand);
        return true;
    }
    return false;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x4c85aa8e, Offset: 0x3960
// Size: 0x162
function function_34a60ad(lefthand = 0) {
    weapon = get_current_weapon(lefthand);
    if (weapon == level.weaponnone) {
        return 0;
    }
    if (self getweaponammoclip(weapon) <= 0) {
        return 0;
    }
    if (isdefined(level.var_69104357)) {
        return self [[ level.var_69104357 ]](lefthand);
    } else if (weapon function_9a4655fe()) {
        if (self function_a3ec3e(lefthand) || self isplayerswimming()) {
            return (gettime() > (lefthand ? self.bot.var_c9739ad5 : self.bot.var_58dc4d2e));
        }
        return 0;
    } else if (weapon function_ae8e4113()) {
        return (self function_a3ec3e(lefthand) || self isplayerswimming());
    }
    return 1;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xaa09ef89, Offset: 0x3ad0
// Size: 0x50
function get_current_weapon(lefthand = 0) {
    weapon = self getcurrentweapon();
    if (lefthand) {
        return weapon.dualwieldweapon;
    }
    return weapon;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xc83da1d6, Offset: 0x3b28
// Size: 0x50
function weapon_loaded(weapon) {
    return self getweaponammoclip(weapon) > 0 || self getweaponammoclip(weapon.dualwieldweapon) > 0;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x2931a329, Offset: 0x3b80
// Size: 0x14
function function_9a4655fe() {
    return self.firetype == "Single Shot";
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x6fb2d272, Offset: 0x3ba0
// Size: 0x14
function function_ae8e4113() {
    return self.firetype == "Burst";
}

/#

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0x5fe62b80, Offset: 0x3bc0
    // Size: 0x7c0
    function devgui_bot_loop() {
        sessionmode = currentsessionmode();
        if (sessionmode != 4) {
            var_f43be767 = getallcharacterbodies(sessionmode);
            foreach (index in var_f43be767) {
                if (index == 0) {
                    continue;
                }
                name = makelocalizedstring(getcharacterdisplayname(index, sessionmode));
                cmd = "<dev string:xcd>" + name + "<dev string:xff>" + index + "<dev string:x101>" + index + "<dev string:x12d>";
                adddebugcommand(cmd);
                cmd = "<dev string:x12f>" + name + "<dev string:xff>" + index + "<dev string:x15e>" + index + "<dev string:x12d>";
                adddebugcommand(cmd);
            }
        }
        while (true) {
            wait 0.25;
            dvarstr = getdvarstring(#"devgui_bot", "<dev string:x30>");
            if (dvarstr == "<dev string:x30>") {
                continue;
            }
            args = strtok(dvarstr, "<dev string:x187>");
            host = util::gethostplayerforbots();
            switch (args[0]) {
            case #"add":
                level devgui_add_bots(host, args[1], int(args[2]));
                break;
            case #"spawn_enemy":
                level devgui_add_bots(host, #"enemy", 1);
                break;
            case #"remove":
                level devgui_remove_bots(host, args[1]);
                break;
            case #"kill":
                level devgui_kill_bots(host, args[1]);
                break;
            case #"invulnerable":
                level devgui_invulnerable(host, args[1], args[2]);
                break;
            case #"ignoreall":
                level devgui_ignoreall(host, args[1], int(args[2]));
                break;
            case #"primaryoffhand":
                level devgui_attribute(host, "<dev string:x189>", args[1], int(args[2]));
                break;
            case #"secondaryoffhand":
                level devgui_attribute(host, "<dev string:x19d>", args[1], int(args[2]));
                break;
            case #"specialoffhand":
                level devgui_attribute(host, "<dev string:x1b3>", args[1], int(args[2]));
                break;
            case #"scorestreak":
                level devgui_attribute(host, "<dev string:x1c7>", args[1], int(args[2]));
                break;
            case #"usegadget":
                level devgui_use_gadget(host, args[1], int(args[2]));
                break;
            case #"usekillstreak":
                level function_9e3f921a(host, args[1]);
                break;
            case #"tpose":
                level devgui_tpose(host, args[1]);
                break;
            }
            if (isdefined(host)) {
                switch (args[0]) {
                case #"add_fixed_spawn":
                    host function_7d978b46(args[1], args[2]);
                    break;
                case #"set_target":
                    host devgui_set_target(args[1], args[2]);
                    break;
                case #"goal":
                    host devgui_goal(args[1], args[2]);
                    break;
                case #"companion":
                    host function_4583aa1b(args[1]);
                    break;
                case #"hash_7d471b297adb925d":
                    host function_ff014f1e();
                    break;
                }
            }
            level notify(#"devgui_bot", {#host:host, #args:args});
            setdvar(#"devgui_bot", "<dev string:x30>");
        }
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0x6e1c3e2f, Offset: 0x4388
    // Size: 0x492
    function add_bot_devgui_menu() {
        entnum = self getentitynumber();
        if (level.var_18197185 && entnum > 12) {
            return;
        }
        i = 0;
        self add_bot_devgui_cmd(entnum, "<dev string:x1d8>" + i + "<dev string:x1df>", 0, "<dev string:x1e4>", "<dev string:x1ee>");
        self add_bot_devgui_cmd(entnum, "<dev string:x1d8>" + i + "<dev string:x1f0>", 1, "<dev string:x1e4>", "<dev string:x1f6>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x1f8>" + i + "<dev string:x204>", 0, "<dev string:x214>", "<dev string:x21f>");
        self add_bot_devgui_cmd(entnum, "<dev string:x1f8>" + i + "<dev string:x229>", 1, "<dev string:x214>", "<dev string:x234>");
        self add_bot_devgui_cmd(entnum, "<dev string:x1f8>" + i + "<dev string:x237>", 2, "<dev string:x214>", "<dev string:x23e>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x244>" + i + "<dev string:x204>", 0, "<dev string:x24e>", "<dev string:x253>");
        self add_bot_devgui_cmd(entnum, "<dev string:x244>" + i + "<dev string:x257>", 1, "<dev string:x24e>", "<dev string:x234>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x262>" + i + "<dev string:x204>", 0, "<dev string:x24e>", "<dev string:x273>");
        self add_bot_devgui_cmd(entnum, "<dev string:x262>" + i + "<dev string:x237>", 1, "<dev string:x24e>", "<dev string:x23e>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x279>" + i + "<dev string:x287>", 0, "<dev string:x28b>", "<dev string:x298>");
        self add_bot_devgui_cmd(entnum, "<dev string:x279>" + i + "<dev string:x29b>", 1, "<dev string:x28b>", "<dev string:x2a0>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x2a4>" + i + "<dev string:x2b0>", 0, "<dev string:x2b9>", "<dev string:x1ee>");
        self add_bot_devgui_cmd(entnum, "<dev string:x2a4>" + i + "<dev string:x2c3>", 1, "<dev string:x2b9>", "<dev string:x1f6>");
        self add_bot_devgui_cmd(entnum, "<dev string:x2a4>" + i + "<dev string:x2ce>", 2, "<dev string:x2b9>", "<dev string:x2d7>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x2d9>", i, "<dev string:x2e8>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x2f6>", i, "<dev string:x2fd>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x303>", i, "<dev string:x308>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x30d>", i, "<dev string:x314>");
        i++;
    }

    // Namespace bot/bot
    // Params 5, eflags: 0x0
    // Checksum 0xf30ad97b, Offset: 0x4828
    // Size: 0xec
    function add_bot_devgui_cmd(entnum, path, sortkey, devguiarg, cmdargs) {
        if (!isdefined(cmdargs)) {
            cmdargs = "<dev string:x30>";
        }
        cmd = "<dev string:x31b>" + entnum + "<dev string:x187>" + self.name + "<dev string:xff>" + entnum + "<dev string:x32d>" + path + "<dev string:xff>" + sortkey + "<dev string:x32f>" + devguiarg + "<dev string:x187>" + entnum + "<dev string:x187>" + cmdargs + "<dev string:x12d>";
        util::add_debug_command(cmd);
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0x358e52f3, Offset: 0x4920
    // Size: 0x8c
    function clear_bot_devgui_menu() {
        entnum = self getentitynumber();
        if (level.var_18197185 && entnum > 12) {
            return;
        }
        cmd = "<dev string:x342>" + entnum + "<dev string:x187>" + self.name + "<dev string:x12d>";
        util::add_debug_command(cmd);
    }

#/

// Namespace bot/bot
// Params 3, eflags: 0x0
// Checksum 0x5fabdfb5, Offset: 0x49b8
// Size: 0x5c
function devgui_add_bots(host, botarg, count) {
    team = devgui_relative_team(host, botarg);
    level thread add_bots(count, team);
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x5c09f0e0, Offset: 0x4a20
// Size: 0xe4
function function_7d978b46(botarg, var_ae04e4ab) {
    team = devgui_relative_team(self, botarg);
    trace = self eye_trace();
    spawndir = self.origin - trace[#"position"];
    spawnangles = vectortoangles(spawndir);
    self thread add_fixed_spawn_bot(team, trace[#"position"] + (0, 0, 5), spawnangles[1], var_ae04e4ab);
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x87a482da, Offset: 0x4b10
// Size: 0xda
function devgui_relative_team(host, botarg) {
    if (isdefined(host)) {
        team = host.team != #"spectator" ? host.team : #"allies";
        if (botarg == "enemy") {
            team = team == #"allies" ? #"axis" : #"allies";
        }
        return team;
    }
    if (botarg == "friendly") {
        return #"allies";
    }
    return #"axis";
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x718f16af, Offset: 0x4bf8
// Size: 0xc8
function devgui_remove_bots(host, botarg) {
    level notify(#"hash_d3e36871aa6829f");
    bots = devgui_get_bots(host, botarg);
    foreach (bot in bots) {
        level thread remove_bot(bot);
    }
}

// Namespace bot/bot
// Params 3, eflags: 0x0
// Checksum 0x4ec3337, Offset: 0x4cc8
// Size: 0xb8
function devgui_ignoreall(host, botarg, cmdarg) {
    bots = devgui_get_bots(host, botarg);
    foreach (bot in bots) {
        bot allow_all(cmdarg);
    }
}

// Namespace bot/bot
// Params 4, eflags: 0x0
// Checksum 0x463cf5af, Offset: 0x4d88
// Size: 0x114
function devgui_attribute(host, attribute, botarg, cmdarg) {
    bots = devgui_get_bots(host, botarg);
    foreach (bot in bots) {
        foreach (bot in bots) {
            bot ai::set_behavior_attribute(attribute, cmdarg);
        }
    }
}

// Namespace bot/bot
// Params 3, eflags: 0x0
// Checksum 0x6dd8ad33, Offset: 0x4ea8
// Size: 0xb8
function devgui_use_gadget(host, botarg, cmdarg) {
    bots = devgui_get_bots(host, botarg);
    foreach (bot in bots) {
        bot bot_action::function_38c9bca9(cmdarg);
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0xd2720bcd, Offset: 0x4f68
// Size: 0xa8
function function_9e3f921a(host, botarg) {
    bots = devgui_get_bots(host, botarg);
    foreach (bot in bots) {
        bot bot_action::function_56a75d03();
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x303a40af, Offset: 0x5018
// Size: 0xd8
function devgui_tpose(host, botarg) {
    bots = devgui_get_bots(host, botarg);
    foreach (bot in bots) {
        setdvar(#"bg_boastenabled", 1);
        bot function_d65cc3c6("dev_boast_tpose");
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x16119646, Offset: 0x50f8
// Size: 0x130
function devgui_kill_bots(host, botarg) {
    bots = devgui_get_bots(host, botarg);
    foreach (bot in bots) {
        if (!isalive(bot)) {
            continue;
        }
        bot val::set(#"devgui_kill", "takedamage", 1);
        bot dodamage(bot.health + 1000, bot.origin);
        bot val::reset(#"devgui_kill", "takedamage");
    }
}

// Namespace bot/bot
// Params 3, eflags: 0x0
// Checksum 0xe25375d5, Offset: 0x5230
// Size: 0x108
function devgui_invulnerable(host, botarg, cmdarg) {
    bots = devgui_get_bots(host, botarg);
    foreach (bot in bots) {
        if (cmdarg == "on") {
            bot val::set(#"devgui", "takedamage", 0);
            continue;
        }
        bot val::reset(#"devgui", "takedamage");
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x1c8a63d8, Offset: 0x5340
// Size: 0x168
function devgui_set_target(botarg, cmdarg) {
    target = undefined;
    switch (cmdarg) {
    case #"crosshair":
        target = self function_bc1a1e7c();
        break;
    case #"me":
        target = self;
        break;
    case #"clear":
        break;
    default:
        return;
    }
    bots = devgui_get_bots(self, botarg);
    foreach (bot in bots) {
        if (isdefined(target)) {
            if (target != bot) {
                bot setentitytarget(target);
            }
            continue;
        }
        bot clearentitytarget();
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x2c00624d, Offset: 0x54b0
// Size: 0xda
function devgui_goal(botarg, cmdarg) {
    switch (cmdarg) {
    case #"set":
        self function_b9bde18a(botarg, 0);
        return;
    case #"me":
        self devgui_goal_me(botarg);
        return;
    case #"force":
        self function_b9bde18a(botarg, 1);
        return;
    case #"clear":
        self devgui_goal_clear(botarg);
        return;
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x914388c5, Offset: 0x5598
// Size: 0x130
function function_b9bde18a(botarg, force = 0) {
    trace = self eye_trace(1);
    bots = devgui_get_bots(self, botarg);
    pos = trace[#"position"];
    node = self get_nearest_node(pos);
    if (isdefined(node)) {
        pos = node;
    }
    foreach (bot in bots) {
        bot setgoal(pos, force);
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xb1784804, Offset: 0x56d0
// Size: 0xa0
function devgui_goal_clear(botarg) {
    bots = devgui_get_bots(self, botarg);
    foreach (bot in bots) {
        bot clearforcedgoal();
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x360ab6f2, Offset: 0x5778
// Size: 0xa8
function devgui_goal_me(botarg) {
    bots = devgui_get_bots(self, botarg);
    foreach (bot in bots) {
        bot setgoal(self);
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0xb83ee64d, Offset: 0x5828
// Size: 0x15a
function devgui_get_bots(host, botarg) {
    if (strisnumber(botarg)) {
        bots = [];
        bot = get_bot_by_entity_number(int(botarg));
        if (isdefined(bot)) {
            bots[0] = bot;
        }
        return bots;
    }
    if (isdefined(host)) {
        if (botarg == "friendly") {
            return host get_friendly_bots();
        }
        if (botarg == "enemy") {
            return host get_enemy_bots();
        }
    } else if (level.teambased) {
        if (botarg == "friendly") {
            return function_ca55e5ea(#"allies");
        }
        return function_ca55e5ea(#"axis");
    }
    return get_bots();
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xe5ab601, Offset: 0x5990
// Size: 0x1b2
function function_bc1a1e7c() {
    targetentity = undefined;
    targetdot = undefined;
    players = getplayers();
    foreach (player in players) {
        if (!isalive(player)) {
            continue;
        }
        dot = self fwd_dot(player.origin);
        if (dot < 0.997) {
            continue;
        }
        if (!self cansee(player)) {
            continue;
        }
        if (!isdefined(targetentity) || dot > targetdot) {
            targetentity = player;
            targetdot = dot;
        }
    }
    if (!isdefined(targetentity)) {
        trace = self eye_trace(1);
        targetentity = trace[#"entity"];
    }
    if (isdefined(targetentity) && !isalive(targetentity)) {
        return undefined;
    }
    return targetentity;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xa29ab439, Offset: 0x5b50
// Size: 0x2c
function function_4583aa1b(companionname) {
    setdvar(#"companion", companionname);
}

/#

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0x7a8e78d0, Offset: 0x5b88
    // Size: 0x130
    function function_ff014f1e() {
        weapon = self getcurrentweapon();
        setdvar(#"bot_spawn_weapon", getweaponname(weapon.rootweapon));
        setdvar(#"hash_c6e51858c88a5ee", util::function_e819f6ec(weapon));
        bots = get_bots();
        foreach (bot in bots) {
            bot function_184438f2(weapon);
        }
    }

#/

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x577baa2e, Offset: 0x5cc0
// Size: 0xa4
function function_184438f2(weapon) {
    if (!isdefined(weapon) || weapon == level.weaponnone) {
        return;
    }
    self function_643bac4d();
    self giveweapon(weapon);
    self givemaxammo(weapon);
    self switchtoweaponimmediate(weapon);
    self setspawnweapon(weapon);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x43733f37, Offset: 0x5d70
// Size: 0x98
function function_643bac4d() {
    weapons = self getweaponslistprimaries();
    foreach (weapon in weapons) {
        self takeweapon(weapon);
    }
}

/#

    // Namespace bot/bot
    // Params 1, eflags: 0x0
    // Checksum 0x24cd68b9, Offset: 0x5e10
    // Size: 0xba
    function should_record(dvarstr) {
        if (getdvarint(dvarstr, 0) <= 0) {
            return 0;
        }
        if (self == level) {
            return 1;
        }
        botnum = getdvarint(#"hash_457b3d0b71e0fd8a", 0);
        if (botnum < 0) {
            return 1;
        }
        ent = getentbynum(botnum);
        return isdefined(ent) && ent == self;
    }

    // Namespace bot/bot
    // Params 3, eflags: 0x0
    // Checksum 0x97f0fce1, Offset: 0x5ed8
    // Size: 0x64
    function record_text(text, textcolor, dvarstr) {
        if (self should_record(dvarstr)) {
            record3dtext(text, self.origin, textcolor, "<dev string:x3a>", self, 0.5);
        }
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0xea18ce7d, Offset: 0x5f48
    // Size: 0x150
    function bot_joinleave_loop() {
        active = 0;
        while (true) {
            wait 1;
            joinleavecount = getdvarint(#"debug_bot_joinleave", 0);
            if (!joinleavecount) {
                if (active) {
                    active = 0;
                    remove_bots();
                }
                continue;
            }
            if (!active) {
                adddebugcommand("<dev string:x357>");
                active = 1;
            }
            botcount = bot_count();
            if (botcount > 0 && randomint(100) < 30) {
                remove_random_bot();
                wait 2;
            } else if (botcount < joinleavecount) {
                add_bot();
                wait 2;
            }
            wait randomintrange(1, 3);
        }
    }

#/

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xec93c58, Offset: 0x60a0
// Size: 0x640
function function_3e733511(team) {
    var_137d7761 = [];
    var_c3f5f8fc = [];
    players = getplayers(team);
    foreach (player in players) {
        if (!isalive(player)) {
            continue;
        }
        if (isdefined(player.revivetrigger)) {
            if (!(isdefined(player.revivetrigger.beingrevived) && player.revivetrigger.beingrevived)) {
                var_137d7761[var_137d7761.size] = player;
            }
            continue;
        }
        if (isbot(player)) {
            if (!(isdefined(player.is_reviving_any) && player.is_reviving_any) && player ai::get_behavior_attribute("revive")) {
                var_c3f5f8fc[var_c3f5f8fc.size] = player;
            }
        }
    }
    assignments = [];
    foreach (bot in var_c3f5f8fc) {
        radius = bot getpathfindingradius();
        foreach (player in var_137d7761) {
            distance = undefined;
            navmeshpoint = getclosestpointonnavmesh(player.origin, 64, radius);
            if (!isdefined(navmeshpoint)) {
                continue;
            }
            if (tracepassedonnavmesh(bot.origin, navmeshpoint, 15)) {
                distance = distance2d(bot.origin, navmeshpoint);
            } else {
                var_a8009ffa = getclosestpointonnavmesh(bot.origin, 64, radius);
                if (!isdefined(var_a8009ffa)) {
                    continue;
                }
                path = generatenavmeshpath(var_a8009ffa, navmeshpoint, bot);
                if (!isdefined(path) || !isdefined(path.pathpoints) || path.pathpoints.size == 0) {
                    continue;
                }
                distance = path.pathdistance;
            }
            if (distance > 2000) {
                continue;
            }
            for (i = 0; i < assignments.size; i++) {
                if (distance < assignments[i].distance) {
                    break;
                }
            }
            arrayinsert(assignments, {#bot:bot, #target:player, #distance:distance}, i);
        }
    }
    for (i = 0; i < assignments.size; i++) {
        assignment = assignments[i];
        if (assignment.bot get_revive_target() !== assignment.target) {
            assignment.bot set_revive_target(assignment.target);
            assignment.bot bot_position::reset();
        }
        arrayremovevalue(var_c3f5f8fc, assignment.bot);
        for (j = i + 1; j < assignments.size; j++) {
            var_1cdcf9a2 = assignments[j];
            if (var_1cdcf9a2.bot == assignment.bot || var_1cdcf9a2.target == assignment.target) {
                arrayremoveindex(assignments, j);
                continue;
            }
        }
    }
    foreach (bot in var_c3f5f8fc) {
        if (isdefined(bot get_revive_target())) {
            bot clear_revive_target();
            bot bot_position::reset();
        }
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xec45cc2d, Offset: 0x66e8
// Size: 0x184
function populate_bots() {
    level endon(#"game_ended", #"hash_d3e36871aa6829f");
    botfill = getdvarint(#"botfill", 0);
    if (botfill > 0) {
        for (i = 0; i < botfill; i++) {
            bot = add_bot();
            if (!isdefined(bot)) {
                return;
            }
            wait 0.5;
        }
        return;
    }
    if (level.teambased) {
        maxallies = getdvarint(#"bot_maxallies", 0);
        maxaxis = getdvarint(#"bot_maxaxis", 0);
        level thread monitor_bot_team_population(maxallies, maxaxis);
        return;
    }
    maxfree = getdvarint(#"bot_maxfree", 0);
    level thread monitor_bot_population(maxfree);
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x73f6dad2, Offset: 0x6878
// Size: 0x170
function monitor_bot_team_population(maxallies, maxaxis) {
    level endon(#"game_ended", #"hash_d3e36871aa6829f");
    if (!maxallies && !maxaxis) {
        return;
    }
    fill_balanced_teams(maxallies, maxaxis);
    while (true) {
        wait 3;
        allies = getplayers(#"allies");
        axis = getplayers(#"axis");
        if (allies.size > maxallies && remove_best_bot(allies)) {
            continue;
        }
        if (axis.size > maxaxis && remove_best_bot(axis)) {
            continue;
        }
        if (allies.size < maxallies || axis.size < maxaxis) {
            add_balanced_bot(allies, maxallies, axis, maxaxis);
        }
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x288c14e0, Offset: 0x69f0
// Size: 0xfa
function fill_balanced_teams(maxallies, maxaxis) {
    allies = getplayers(#"allies");
    for (axis = getplayers(#"axis"); (allies.size < maxallies || axis.size < maxaxis) && add_balanced_bot(allies, maxallies, axis, maxaxis); axis = getplayers(#"axis")) {
        waitframe(1);
        allies = getplayers(#"allies");
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x79e2714c, Offset: 0x6af8
// Size: 0x100
function monitor_bot_population(maxfree) {
    level endon(#"game_ended", #"hash_d3e36871aa6829f");
    if (!maxfree) {
        return;
    }
    for (players = getplayers(); players.size < maxfree; players = getplayers()) {
        add_bot();
        waitframe(1);
    }
    while (true) {
        wait 3;
        players = getplayers();
        if (players.size < maxfree) {
            add_bot();
            continue;
        }
        if (players.size > maxfree) {
            remove_best_bot(players);
        }
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x68a2d001, Offset: 0x6c00
// Size: 0x168
function remove_best_bot(players) {
    bots = filter_bots(players);
    if (!bots.size) {
        return false;
    }
    bestbots = [];
    foreach (bot in bots) {
        if (bot.sessionstate == "spectator") {
            continue;
        }
        if (bot.sessionstate == "dead") {
            bestbots[bestbots.size] = bot;
        }
    }
    if (bestbots.size) {
        remove_bot(bestbots[randomint(bestbots.size)]);
    } else {
        remove_bot(bots[randomint(bots.size)]);
    }
    return true;
}

