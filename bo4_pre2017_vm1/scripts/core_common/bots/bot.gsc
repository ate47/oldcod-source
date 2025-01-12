#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/array_shared;
#using scripts/core_common/bots/bot_action;
#using scripts/core_common/bots/bot_move;
#using scripts/core_common/bots/bot_traversals;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/laststand_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;

#namespace bot;

// Namespace bot/bot
// Params 0, eflags: 0x2
// Checksum 0xf0f9d952, Offset: 0x5e8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("bot", &__init__, undefined, undefined);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x683624b0, Offset: 0x628
// Size: 0x134
function __init__() {
    level.addbot = &add_bot;
    level.addbots = &add_bots;
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_killed(&on_player_killed);
    callback::on_disconnect(&on_player_disconnect);
    setdvar("bot_maxMantleHeight", 200);
    /#
        level thread devgui_bot_loop();
        level thread bot_joinleave_loop();
    #/
    if (isprofilebuild()) {
        level thread devgui_bot_loop();
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xdbf37214, Offset: 0x768
// Size: 0x6
function is_bot_ranked_match() {
    return false;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x4f2226c5, Offset: 0x778
// Size: 0x110
function add_bot(team) {
    bot = addtestclient();
    if (!isdefined(bot)) {
        return undefined;
    }
    bot setup_blackboard();
    bot.goalradius = 512;
    bot apply_bot_settings("bot_default");
    if (isdefined(level.disableclassselection) && level.disableclassselection) {
        bot.pers["class"] = level.defaultclass;
        bot.curclass = level.defaultclass;
    }
    if (level.teambased) {
        bot.chooseteam = isdefined(team) ? team : "autoassign";
    }
    return bot;
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0xc398cebb, Offset: 0x890
// Size: 0x94
function add_bots(count, team) {
    if (!isdefined(count)) {
        count = 1;
    }
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
// Params 3, eflags: 0x0
// Checksum 0x60a472f0, Offset: 0x930
// Size: 0xbc
function add_fixed_spawn_bot(team, origin, yaw) {
    bot = add_bot(team);
    if (isdefined(bot)) {
        bot set_engage_enemies("favorite");
        bot set_position_updates("priority");
        bot set_commander(0);
        bot thread fixed_spawn_override(origin, yaw);
    }
}

// Namespace bot/bot
// Params 4, eflags: 0x0
// Checksum 0x7ca82258, Offset: 0x9f8
// Size: 0xb6
function add_balanced_bot(allies, maxallies, axis, maxaxis) {
    bot = undefined;
    if (allies.size <= axis.size || allies.size < maxallies && axis.size >= maxaxis) {
        bot = add_bot("allies");
    } else if (axis.size < maxaxis) {
        bot = add_bot("axis");
    }
    return isdefined(bot);
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x3d73af70, Offset: 0xab8
// Size: 0xb0
function fixed_spawn_override(origin, yaw) {
    self endon(#"disconnect");
    angles = (0, yaw, 0);
    while (true) {
        self waittill("spawned_player");
        self setorigin(origin);
        self setplayerangles(angles);
        self dontinterpolate();
        self setgoal(origin);
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xe42d637e, Offset: 0xb70
// Size: 0xea
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
// Checksum 0x1434127e, Offset: 0xc68
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
// Checksum 0x784a2ef8, Offset: 0xce0
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
// Checksum 0xd36b68f0, Offset: 0xd50
// Size: 0x32
function get_bots() {
    players = getplayers();
    return filter_bots(players);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xe23d23f8, Offset: 0xd90
// Size: 0xba
function filter_bots(players) {
    bots = [];
    foreach (player in players) {
        if (player isbot()) {
            bots[bots.size] = player;
        }
    }
    return bots;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xf2a820fd, Offset: 0xe58
// Size: 0xe8
function get_friendly_bots() {
    players = getplayers();
    bots = [];
    foreach (player in players) {
        if (!player isbot()) {
            continue;
        }
        if (player.team == self.team) {
            bots[bots.size] = player;
        }
    }
    return bots;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xcdf8df9d, Offset: 0xf48
// Size: 0xe8
function get_enemy_bots() {
    players = getplayers();
    bots = [];
    foreach (player in players) {
        if (!player isbot()) {
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
// Checksum 0x689dc539, Offset: 0x1038
// Size: 0xda
function get_bot_by_entity_number(entnum) {
    players = getplayers();
    foreach (player in players) {
        if (!player isbot()) {
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
// Checksum 0xccb9cc30, Offset: 0x1120
// Size: 0xae
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
// Params 1, eflags: 0x0
// Checksum 0xacaba239, Offset: 0x11d8
// Size: 0x58
function assign_companion_to(owner) {
    self.owner = owner;
    self setgoal(owner);
    if (isdefined(level.onbotcompanionassigned)) {
        self [[ level.onbotcompanionassigned ]]();
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x48c2ba8, Offset: 0x1238
// Size: 0x58
function release_companion() {
    self.owner = undefined;
    self.protectent = undefined;
    self setgoal(self.origin);
    if (isdefined(level.onbotcompanionreleased)) {
        self [[ level.onbotcompanionreleased ]]();
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xde5de9b0, Offset: 0x1298
// Size: 0x158
function on_player_connect() {
    if (!self istestclient()) {
        /#
            self ishostforbots();
            self create_dev_hud();
        #/
        return;
    }
    self endon(#"disconnect");
    /#
        self add_bot_devgui_menu();
    #/
    if (!isdefined(self.__blackboard)) {
        self setup_blackboard();
    }
    waitframe(1);
    if (level.teambased && isdefined(self.chooseteam)) {
        self notify(#"menuresponse", {#menu:game.menu["menu_team"], #response:self.chooseteam});
        self.chooseteam = undefined;
        wait 0.2;
    }
    self notify(#"joined_team");
    callback::callback(#"hash_95a6c4c0");
    if (isdefined(level.onbotconnect)) {
        self thread [[ level.onbotconnect ]]();
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x1f4ebd33, Offset: 0x13f8
// Size: 0x1d4
function on_player_spawned() {
    if (!self isbot()) {
        return;
    }
    /#
        weapon = undefined;
        if (getdvarstring("<dev string:x28>", "<dev string:x39>") != "<dev string:x39>") {
            weapon = getweapon(getdvarstring("<dev string:x28>"));
        }
        self test_give_only_weapon(weapon);
        if (getdvarstring("<dev string:x3a>", "<dev string:x39>") != "<dev string:x39>") {
            weapon = getweapon(getdvarstring("<dev string:x3a>"));
            if (isdefined(weapon)) {
                self giveweapon(weapon);
            }
        }
    #/
    if (isdefined(self.owner)) {
        self setgoal(self.owner);
    }
    if (isdefined(level.onbotspawned)) {
        self thread [[ level.onbotspawned ]]();
    }
    self thread update_loop();
    if (getdvarint("bots_invulnerable", 0)) {
        self val::set("devgui", "takedamage", 0);
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x2c4e230a, Offset: 0x15d8
// Size: 0x6c
function on_player_killed() {
    if (!self isbot()) {
        return;
    }
    self clear_objective();
    if (isdefined(level.onbotkilled)) {
        self thread [[ level.onbotkilled ]]();
    }
    self botreleasemanualcontrol();
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xf2487eb7, Offset: 0x1650
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
// Checksum 0xb77f7b64, Offset: 0x1698
// Size: 0x68
function callback_createplayerbot() {
    if (!isdefined(self.__blackboard)) {
        self setup_blackboard();
    }
    self thread update_loop();
    if (isdefined(level.onbotspawned)) {
        self thread [[ level.onbotspawned ]]();
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x5817844f, Offset: 0x1708
// Size: 0x4a
function callback_stopupdate() {
    self notify(#"bot_update_stop");
    self bot_action::cancel_action();
    self bot_move::stop_handling_events();
    self notify(#"traversal_end");
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x97cae3ab, Offset: 0x1760
// Size: 0xc8
function update_loop() {
    self endon(#"death");
    self endon(#"bot_update_stop");
    level endon(#"game_ended");
    self bot_move::start_handling_events();
    while (true) {
        self clear_revive_target();
        while (self frozen()) {
            waitframe(1);
        }
        self update_protect_ent();
        self update_objective();
        self update_action_and_position();
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x4b992a81, Offset: 0x1830
// Size: 0x8c
function update_objective() {
    objective = self get_objective();
    if (isdefined(objective)) {
        if (!objective.trigger istriggerenabled() || !objective gameobjects::can_interact_with(self)) {
            self clear_objective();
        }
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x457d3b5d, Offset: 0x18c8
// Size: 0x82
function update_protect_ent() {
    if (!isdefined(self.owner)) {
        return;
    }
    distsq = distance2dsquared(self.origin, self.owner.origin);
    if (distsq <= 490000) {
        self.protectent = self.owner;
        return;
    }
    self.protectent = undefined;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x6ad1c5f7, Offset: 0x1958
// Size: 0x30c
function update_action_and_position() {
    self endon(#"death");
    level endon(#"game_ended");
    bundlename = self get_tactical_state_name();
    if (!isdefined(bundlename)) {
        self botprinterror("No tactical state");
        wait 0.5;
        return;
    }
    tacbundle = struct::get_script_bundle("bottacticalstate", bundlename);
    if (!isdefined(tacbundle)) {
        self botprinterror("Could not find bottacticalstate bundle: " + bundlename);
        wait 0.5;
        return;
    }
    /#
        if (self should_record("<dev string:x4f>") || self should_record("<dev string:x64>")) {
            record3dtext("<dev string:x73>" + bundlename + "<dev string:x76>", self.origin, (1, 1, 1), "<dev string:x79>", self, 0.5);
        }
    #/
    haspriorityposition = 0;
    if (self get_position_updates() != "none") {
        haspriorityposition = self bot_move::priority_update_position(tacbundle.pathablequery, tacbundle.usequery, tacbundle.touchquery);
    } else {
        self.overridepos = undefined;
    }
    self bot_action::pick_action(tacbundle);
    if (!haspriorityposition && self get_position_updates() == "all") {
        query = tacbundle.idlequery;
        fallbackquery = tacbundle.idlefallbackquery;
        if (self has_visible_enemy()) {
            query = tacbundle.visibleenemyquery;
            fallbackquery = tacbundle.visibleenemyfallbackquery;
        } else if (self has_active_enemy()) {
            query = tacbundle.activeenemyquery;
            fallbackquery = tacbundle.activeenemyfallbackquery;
        }
        self bot_move::update_position(tacbundle.pathablequery, query, fallbackquery);
    }
    self bot_action::execute_current_action();
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x44909ad8, Offset: 0x1c70
// Size: 0x5c
function setup_blackboard() {
    blackboard::createblackboardforentity(self);
    blackboard::registerblackboardattribute(self, "bot_objective", undefined, undefined);
    blackboard::registerblackboardattribute(self, "bot_point_of_interest", undefined, undefined);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xdcefdc43, Offset: 0x1cd8
// Size: 0x22
function get_tactical_state_name() {
    return self getblackboardattribute("bot_tactical_state");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xe19ad7ec, Offset: 0x1d08
// Size: 0x2c
function set_tactical_state_name(name) {
    self setblackboardattribute("bot_tactical_state", name);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xc0545d35, Offset: 0x1d40
// Size: 0x22
function get_objective() {
    return self getblackboardattribute("bot_objective");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x6457b1bf, Offset: 0x1d70
// Size: 0x2c
function set_objective(gameobject) {
    self setblackboardattribute("bot_objective", gameobject);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x7fc40a6e, Offset: 0x1da8
// Size: 0x1c
function clear_objective() {
    self set_objective(undefined);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x326fdffa, Offset: 0x1dd0
// Size: 0x22
function get_action_name() {
    return self getblackboardattribute("bot_action");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xd5ad1d84, Offset: 0x1e00
// Size: 0x2c
function set_action_name(name) {
    self setblackboardattribute("bot_action", name);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x45a9a9e8, Offset: 0x1e38
// Size: 0x22
function get_action_table_name() {
    return self getblackboardattribute("bot_action_table");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xb03513f2, Offset: 0x1e68
// Size: 0x2c
function set_action_table_name(name) {
    self setblackboardattribute("bot_action_table", name);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x61bd4c4b, Offset: 0x1ea0
// Size: 0x22
function get_stance_table_name() {
    return self getblackboardattribute("bot_stance_table");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x8fca60af, Offset: 0x1ed0
// Size: 0x2c
function set_stance_table_name(name) {
    self setblackboardattribute("bot_stance_table", name);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xdf71890b, Offset: 0x1f08
// Size: 0x22
function get_point_of_interest() {
    return self getblackboardattribute("bot_point_of_interest");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x740be0e1, Offset: 0x1f38
// Size: 0x2c
function set_point_of_interest(point) {
    self setblackboardattribute("bot_point_of_interest", point);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xf8ccd3c7, Offset: 0x1f70
// Size: 0x1c
function clear_point_of_interest() {
    self set_point_of_interest(undefined);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x55c1e2d3, Offset: 0x1f98
// Size: 0x22
function get_revive_target() {
    return self getblackboardattribute("bot_revive_target");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xa2e8916, Offset: 0x1fc8
// Size: 0x2c
function set_revive_target(target) {
    self setblackboardattribute("bot_revive_target", target);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x277ed386, Offset: 0x2000
// Size: 0x1c
function clear_revive_target() {
    self set_revive_target(undefined);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x7c3b0334, Offset: 0x2028
// Size: 0x22
function get_engage_enemies() {
    return self getblackboardattribute("bot_engage_enemies");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xcc0dadf3, Offset: 0x2058
// Size: 0x2c
function set_engage_enemies(engageenemies) {
    self setblackboardattribute("bot_engage_enemies", engageenemies);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xae8d7725, Offset: 0x2090
// Size: 0x22
function get_position_updates() {
    return self getblackboardattribute("bot_position_updates");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x9d12e12f, Offset: 0x20c0
// Size: 0x2c
function set_position_updates(positionupdates) {
    self setblackboardattribute("bot_position_updates", positionupdates);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x95ab59c0, Offset: 0x20f8
// Size: 0x22
function get_commander() {
    return self getblackboardattribute("bot_commander");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x8d46f816, Offset: 0x2128
// Size: 0x2c
function set_commander(commander) {
    self setblackboardattribute("bot_commander", commander);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x50859995, Offset: 0x2160
// Size: 0x42
function menu_cancel(menukey) {
    self notify(#"menuresponse", {#menu:game.menu[menukey], #response:"cancel"});
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x7ce0a9bd, Offset: 0x21b0
// Size: 0x134
function apply_bot_settings(bundlename) {
    botsettings = struct::get_script_bundle("botsettings", bundlename);
    if (!isdefined(botsettings)) {
        self botprinterror("Could not find botsettings bundle: " + bundlename);
        return;
    }
    if (isdefined(botsettings.highlyawareradius)) {
        self.highlyawareradius = botsettings.highlyawareradius;
    }
    if (isdefined(botsettings.fov)) {
        self.fovcosine = fov_angle_to_cosine(botsettings.fov);
    }
    if (isdefined(botsettings.fovbusy)) {
        self.fovcosinebusy = fov_angle_to_cosine(botsettings.fovbusy);
    }
    self botsetlooksensitivity(botsettings.pitchsensitivity, botsettings.yawsensitivity);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x748b474d, Offset: 0x22f0
// Size: 0x3a
function fov_angle_to_cosine(fovangle) {
    if (fovangle >= 180) {
        return 0;
    }
    return cos(fovangle / 2);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xf01b097d, Offset: 0x2338
// Size: 0x22
function get_bot_default_settings() {
    return struct::get_script_bundle("botsettings", "bot_default");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xb0b33dce, Offset: 0x2368
// Size: 0x9a
function enemy_is_valid(enemy) {
    if (!isdefined(enemy)) {
        return 0;
    }
    if (self get_engage_enemies() == "none") {
        return 0;
    }
    if (self get_engage_enemies() == "favorite") {
        if (!isdefined(self.favoriteenemy) || self.favoriteenemy != enemy) {
            return 0;
        }
    }
    return isalive(enemy);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x9be5243e, Offset: 0x2410
// Size: 0x22
function enemy_is_visible(enemy) {
    return self cansee(enemy);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xd98871f3, Offset: 0x2440
// Size: 0x2c
function enemy_is_current(enemy) {
    return isdefined(self.enemy) && self.enemy === enemy;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x53fc531b, Offset: 0x2478
// Size: 0x22
function has_valid_enemy() {
    return self enemy_is_valid(self.enemy);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x651195e2, Offset: 0x24a8
// Size: 0x3a
function has_visible_enemy() {
    return self has_valid_enemy() && self enemy_is_visible(self.enemy);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x26583814, Offset: 0x24f0
// Size: 0x46
function has_active_enemy() {
    if (!self has_valid_enemy()) {
        return false;
    }
    if (!isdefined(self.enemylastseentime)) {
        return false;
    }
    return gettime() < self.enemylastseentime + 3000;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x85c653b9, Offset: 0x2540
// Size: 0xcc
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
// Params 1, eflags: 0x0
// Checksum 0xb1550715, Offset: 0x2618
// Size: 0xea
function eye_trace(hitents) {
    if (!isdefined(hitents)) {
        hitents = 0;
    }
    direction = self getplayerangles();
    direction_vec = anglestoforward(direction);
    eye = self geteye();
    scale = 8000;
    direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
    return bullettrace(eye, eye + direction_vec, hitents, self);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xd00ea31, Offset: 0x2710
// Size: 0x5a
function can_interact_with(gameobject) {
    return isdefined(gameobject) && isdefined(gameobject.trigger) && gameobject.trigger istriggerenabled() && gameobject gameobjects::can_interact_with(self);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x4a919e68, Offset: 0x2778
// Size: 0x178
function frozen() {
    if (isdefined(level.inprematchperiod) && level.inprematchperiod) {
        return true;
    }
    if (self isplayinganimscripted()) {
        return true;
    }
    if (self arecontrolsfrozen()) {
        return true;
    }
    if (!isdefined(self.sessionstate) || self.sessionstate != "playing") {
        return true;
    }
    if (level flag::exists("intro_igcs_done")) {
        return !level flag::get("intro_igcs_done");
    } else if (isdefined(mission) && mission flag::exists("intro_igcs_done")) {
        return !mission flag::get("intro_igcs_done");
    }
    pausebotteam = getdvarstring("pauseBotTeam", "none");
    return pausebotteam == "any" || pausebotteam == "all" || pausebotteam == self.team;
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0xda6f982c, Offset: 0x28f8
// Size: 0x150
function rename(clanabbrev, name) {
    /#
        self clear_bot_devgui_menu();
        if (isdefined(level.abilities_devgui_player_disconnect)) {
            self [[ level.abilities_devgui_player_disconnect ]]();
        }
        if (isdefined(level.status_effects_devgui_player_disconnect)) {
            self [[ level.status_effects_devgui_player_disconnect ]]();
        }
        if (isdefined(level.devgui_player_disconnect)) {
            self [[ level.devgui_player_disconnect ]]();
        }
    #/
    self botsetclanabbrev(clanabbrev);
    self botsetname(name);
    /#
        self add_bot_devgui_menu();
        if (isdefined(level.abilities_devgui_player_connect)) {
            self [[ level.abilities_devgui_player_connect ]]();
        }
        if (isdefined(level.status_effects_devgui_player_connect)) {
            self [[ level.status_effects_devgui_player_connect ]]();
        }
        if (isdefined(level.devgui_player_connect)) {
            self [[ level.devgui_player_connect ]]();
        }
    #/
}

// Namespace bot/bot
// Params 4, eflags: 0x0
// Checksum 0x9097c72b, Offset: 0x2a50
// Size: 0x13a
function get_nearest_node(pos, maxradius, minradius, height) {
    if (!isdefined(maxradius)) {
        maxradius = 24;
    }
    if (!isdefined(minradius)) {
        minradius = 0;
    }
    if (!isdefined(height)) {
        height = 64;
    }
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
// Checksum 0xeecc833a, Offset: 0x2b98
// Size: 0x42
function get_position_node() {
    if (isdefined(self.overridenode)) {
        return self.overridenode;
    } else if (isdefined(self.goalnode)) {
        return self.goalnode;
    }
    return undefined;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x366d42ec, Offset: 0x2be8
// Size: 0x1ec
function give_hero_gadget(weaponname) {
    weapon = getweapon(weaponname);
    if (weapon == level.weaponnone) {
        return level.weaponnone;
    }
    if (sessionmodeiscampaigngame()) {
        current_count = 0;
        for (i = 0; i < 4; i++) {
            if (isdefined(self._gadgets_player[i])) {
                current_count++;
            }
        }
        if (current_count == 4) {
            for (i = 0; i < 4; i++) {
                if (isdefined(self._gadgets_player[i])) {
                    self takeweapon(self._gadgets_player[i]);
                }
            }
        }
        self notify(#"gadget_devgui_give", {#weapon:weaponname});
        self giveweapon(weapon);
        return;
    }
    for (i = 0; i < 4; i++) {
        if (isdefined(self._gadgets_player[i]) && weapon.inventorytype == self._gadgets_player[i].inventorytype) {
            self takeweapon(self._gadgets_player[i]);
        }
    }
    self giveweapon(weapon);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x6c8330c4, Offset: 0x2de0
// Size: 0x76
function take_hero_gadgets() {
    if (!isdefined(self._gadgets_player)) {
        return;
    }
    for (i = 0; i < 4; i++) {
        if (isdefined(self._gadgets_player[i])) {
            self takeweapon(self._gadgets_player[i]);
        }
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x70c37dd8, Offset: 0x2e60
// Size: 0x76
function charge_hero_gadgets() {
    if (!isdefined(self._gadgets_player)) {
        return;
    }
    for (i = 0; i < 4; i++) {
        if (isdefined(self._gadgets_player[i])) {
            self gadgetpowerset(i, 100);
        }
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x93917722, Offset: 0x2ee0
// Size: 0x64
function activate_hero_gadget(weapon) {
    if (weapon.isheavyweapon) {
        self activate_heavy_weapon(weapon);
        return;
    }
    if (weapon.isabilityweapon) {
        self activate_ability(weapon);
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x54d1a2fc, Offset: 0x2f50
// Size: 0xdc
function activate_heavy_weapon(weapon) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"entering_last_stand");
    level endon(#"game_ended");
    if (weapon.offhandslot == "None") {
        self botswitchtoweapon(weapon);
        self waittilltimeout(1, "weapon_change_complete");
        return;
    }
    if (weapon.offhandslot == "Special") {
        self botpressbutton(72);
        wait 0.25;
        self botreleasebutton(72);
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x3d4f4769, Offset: 0x3038
// Size: 0x12c
function activate_ability(weapon) {
    if (sessionmodeiscampaigngame()) {
        slot = undefined;
        for (i = 0; i < 4; i++) {
            if (self._gadgets_player[i] === weapon) {
                slot = i;
                break;
            }
        }
        if (!isdefined(slot)) {
            return;
        }
        switch (slot) {
        case 0:
            self bottapbutton(47);
            break;
        case 1:
            self bottapbutton(45);
            break;
        case 2:
            self bottapbutton(48);
            break;
        }
        return;
    }
    self bottapbutton(70);
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0xa1b540ad, Offset: 0x3170
// Size: 0x40
function horizontal_offset(yaw, radius) {
    return anglestoforward((0, angleclamp180(yaw), 0)) * radius;
}

// Namespace bot/bot
// Params 7, eflags: 0x0
// Checksum 0x9df11c54, Offset: 0x31b8
// Size: 0x104
function spawn_full_teams(radius_a, radius_b, angle_between_bots, origin, yaw, team_a, team_b) {
    if (!isdefined(radius_a)) {
        radius_a = 70;
    }
    if (!isdefined(radius_b)) {
        radius_b = 100;
    }
    if (!isdefined(angle_between_bots)) {
        angle_between_bots = 30;
    }
    full_team_count = 6;
    count_a = isplayer(self) ? full_team_count - 1 : full_team_count;
    count_b = full_team_count;
    spawn_teams_around_point(origin, yaw, team_a, count_a, radius_a, team_b, count_b, radius_b, angle_between_bots);
}

// Namespace bot/bot
// Params 7, eflags: 0x0
// Checksum 0x58465b0c, Offset: 0x32c8
// Size: 0x8c
function spawn_full_teams_paused(radius_a, radius_b, angle_between_bots, origin, yaw, team_a, team_b) {
    setdvar("pauseBotTeam", "all");
    spawn_full_teams(radius_a, radius_b, angle_between_bots, origin, yaw, team_a, team_b);
}

// Namespace bot/bot
// Params 9, eflags: 0x0
// Checksum 0x70af1343, Offset: 0x3360
// Size: 0x1d4
function spawn_teams_around_point(origin, yaw, team_a, count_a, radius_a, team_b, count_b, radius_b, angle_between_bots) {
    if (!isdefined(team_a)) {
        team_a = isdefined(self) && isdefined(self.team) ? self.team : "allies";
    }
    if (!isdefined(team_b)) {
        team_b = util::getotherteam(team_a);
    }
    if (!isdefined(yaw)) {
        direction = isplayer(self) ? self getplayerangles() : self getangles();
        yaw = direction[1];
    }
    if (!isdefined(origin)) {
        origin = isdefined(self) && isdefined(self.origin) ? self.origin : (0, 0, 0);
    }
    spawn_delay = 0.15;
    if (!isdefined(count_b)) {
        count_b = 0;
    }
    spawn_bots_around_point(origin, yaw, team_a, count_a, radius_a, angle_between_bots, spawn_delay);
    spawn_bots_around_point(origin, yaw, team_b, count_b, radius_b, angle_between_bots, spawn_delay);
}

// Namespace bot/bot
// Params 7, eflags: 0x0
// Checksum 0x7873e673, Offset: 0x3540
// Size: 0x15c
function spawn_bots_around_point(origin, yaw, team, spawn_count, radius, offset_angle, spawn_delay) {
    if (!isdefined(spawn_delay)) {
        spawn_delay = 0.15;
    }
    if (spawn_count <= 0) {
        return;
    }
    player = self;
    start_yaw = (spawn_count - 1) * offset_angle * 0.5;
    bot_yaw = angleclamp180(start_yaw * -1 + yaw);
    for (i = 0; i < spawn_count; i++) {
        trace_spawn_fixed_bot(team, origin + horizontal_offset(bot_yaw, radius), angleclamp180(bot_yaw - 180));
        wait spawn_delay;
        bot_yaw += offset_angle;
    }
}

// Namespace bot/bot
// Params 3, eflags: 0x0
// Checksum 0xd4415186, Offset: 0x36a8
// Size: 0xf4
function trace_spawn_fixed_bot(team, hint_origin, yaw) {
    if (!isdefined(yaw)) {
        yaw = 0;
    }
    start = hint_origin + (0, 0, 200);
    end = hint_origin + (0, 0, -200);
    trace = physicstrace(start, end, (-10, -10, 0), (10, 10, 0), undefined, 32);
    if (isdefined(trace["position"])) {
        add_fixed_spawn_bot(team, trace["position"], yaw);
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xa08a420f, Offset: 0x37a8
// Size: 0x358
function devgui_bot_loop() {
    while (true) {
        wait 0.25;
        dvarstr = getdvarstring("devgui_bot", "");
        if (dvarstr == "") {
            continue;
        }
        args = strtok(dvarstr, " ");
        host = util::gethostplayerforbots();
        switch (args[0]) {
        case #"add":
            host devgui_add_bots(args[1], int(args[2]));
            break;
        case #"add_fixed_spawn":
            host devgui_add_fixed_spawn_bots(args[1]);
            break;
        case #"spawn_enemy":
            host devgui_add_bots("enemy", 1);
            break;
        case #"remove":
            host devgui_remove_bots(args[1]);
            break;
        case #"kill":
            host devgui_kill_bots(args[1]);
            break;
        case #"invulnerable":
            host devgui_invulnerable(args[1], args[2]);
            break;
        case #"attack":
            host devgui_attack(args[1], args[2]);
            break;
        case #"move":
            host devgui_move(args[1], args[2]);
            break;
        case #"hash_14c393c6":
            host devgui_set_favorite(args[1], args[2]);
            break;
        case #"goal":
            host devgui_goal(args[1], args[2]);
            break;
        case #"hash_ec7c1238":
            host test_assign_nearest_companion();
            break;
        case #"hash_fdc11eb4":
            host test_release_furthest_companion();
            break;
        case #"test_give_player_weapon":
            host test_give_player_weapon();
            break;
        }
        setdvar("devgui_bot", "");
    }
}

/#

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0x48878f4d, Offset: 0x3b08
    // Size: 0x45a
    function add_bot_devgui_menu() {
        entnum = self getentitynumber();
        i = 0;
        self add_bot_devgui_cmd(entnum, "<dev string:x80>", i, "<dev string:x87>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x8e>", i, "<dev string:x93>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x98>" + i + "<dev string:xa6>", 0, "<dev string:xaa>", "<dev string:xb7>");
        self add_bot_devgui_cmd(entnum, "<dev string:x98>" + i + "<dev string:xba>", 1, "<dev string:xaa>", "<dev string:xbf>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:xc3>" + i + "<dev string:xcb>", 0, "<dev string:xd0>", "<dev string:xd7>");
        self add_bot_devgui_cmd(entnum, "<dev string:xc3>" + i + "<dev string:xdb>", 1, "<dev string:xd0>", "<dev string:xe5>");
        self add_bot_devgui_cmd(entnum, "<dev string:xc3>" + i + "<dev string:xee>", 2, "<dev string:xd0>", "<dev string:xf4>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:xf9>" + i + "<dev string:xcb>", 0, "<dev string:xff>", "<dev string:xd7>");
        self add_bot_devgui_cmd(entnum, "<dev string:xf9>" + i + "<dev string:x104>", 1, "<dev string:xff>", "<dev string:x10e>");
        self add_bot_devgui_cmd(entnum, "<dev string:xf9>" + i + "<dev string:xee>", 2, "<dev string:xff>", "<dev string:xf4>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x117>" + i + "<dev string:x125>", 0, "<dev string:x12d>", "<dev string:x13a>");
        self add_bot_devgui_cmd(entnum, "<dev string:x117>" + i + "<dev string:x141>", 1, "<dev string:x12d>", "<dev string:x145>");
        self add_bot_devgui_cmd(entnum, "<dev string:x117>" + i + "<dev string:x148>", 2, "<dev string:x12d>", "<dev string:x150>");
        self add_bot_devgui_cmd(entnum, "<dev string:x117>" + i + "<dev string:xee>", 3, "<dev string:x12d>", "<dev string:xf4>");
        i++;
        self add_bot_devgui_cmd(entnum, "<dev string:x157>" + i + "<dev string:x15d>", 0, "<dev string:x164>", "<dev string:x169>");
        self add_bot_devgui_cmd(entnum, "<dev string:x157>" + i + "<dev string:x16f>", 1, "<dev string:x164>", "<dev string:x176>");
        self add_bot_devgui_cmd(entnum, "<dev string:x157>" + i + "<dev string:x141>", 2, "<dev string:x164>", "<dev string:x145>");
        i++;
    }

    // Namespace bot/bot
    // Params 5, eflags: 0x0
    // Checksum 0xe5aaa67d, Offset: 0x3f70
    // Size: 0xf4
    function add_bot_devgui_cmd(entnum, path, sortkey, devguiarg, cmdargs) {
        if (!isdefined(cmdargs)) {
            cmdargs = "<dev string:x39>";
        }
        cmd = "<dev string:x17c>" + entnum + "<dev string:x18e>" + self.name + "<dev string:x190>" + entnum + "<dev string:x192>" + path + "<dev string:x190>" + sortkey + "<dev string:x194>" + devguiarg + "<dev string:x18e>" + entnum + "<dev string:x18e>" + cmdargs + "<dev string:x1a7>";
        adddebugcommand(cmd);
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0xd797daba, Offset: 0x4070
    // Size: 0x74
    function clear_bot_devgui_menu() {
        entnum = self getentitynumber();
        cmd = "<dev string:x1a9>" + entnum + "<dev string:x18e>" + self.name + "<dev string:x1a7>";
        adddebugcommand(cmd);
    }

#/

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0xd67094a, Offset: 0x40f0
// Size: 0x54
function devgui_add_bots(botarg, count) {
    team = self devgui_relative_team(botarg);
    level thread add_bots(count, team);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x65ab4a76, Offset: 0x4150
// Size: 0xc4
function devgui_add_fixed_spawn_bots(botarg) {
    team = self devgui_relative_team(botarg);
    trace = self eye_trace();
    spawndir = self.origin - trace["position"];
    spawnangles = vectortoangles(spawndir);
    self thread add_fixed_spawn_bot(team, trace["position"], spawnangles[1]);
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x3434e68d, Offset: 0x4220
// Size: 0x84
function devgui_relative_team(botarg) {
    team = self.team != "spectator" ? self.team : "allies";
    if (botarg == "enemy") {
        team = team == "allies" ? "axis" : "allies";
    }
    return team;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x8ac5338d, Offset: 0x42b0
// Size: 0xba
function devgui_remove_bots(botarg) {
    bots = self devgui_get_bots(botarg);
    foreach (bot in bots) {
        level thread remove_bot(bot);
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x1faa5982, Offset: 0x4378
// Size: 0xc2
function devgui_attack(botarg, cmdarg) {
    bots = self devgui_get_bots(botarg);
    foreach (bot in bots) {
        bot set_engage_enemies(cmdarg);
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0xbddf4697, Offset: 0x4448
// Size: 0xea
function devgui_move(botarg, cmdarg) {
    bots = self devgui_get_bots(botarg);
    foreach (bot in bots) {
        bot set_position_updates(cmdarg);
        bot set_commander(cmdarg == "all");
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x635c711e, Offset: 0x4540
// Size: 0x142
function devgui_kill_bots(botarg) {
    bots = self devgui_get_bots(botarg);
    foreach (bot in bots) {
        if (!isalive(bot)) {
            continue;
        }
        bot val::set("devgui_kill", "takedamage", 1);
        bot dodamage(bot.health + 1000, bot.origin);
        bot val::reset("devgui_kill", "takedamage");
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x4dd39adc, Offset: 0x4690
// Size: 0x102
function devgui_invulnerable(botarg, cmdarg) {
    bots = self devgui_get_bots(botarg);
    foreach (bot in bots) {
        if (cmdarg == "on") {
            bot val::set("devgui", "takedamage", 0);
            continue;
        }
        bot val::reset("devgui", "takedamage");
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x4ff6a966, Offset: 0x47a0
// Size: 0x172
function devgui_set_favorite(botarg, cmdarg) {
    target = undefined;
    switch (cmdarg) {
    case #"player":
        target = self devgui_get_target_player();
        break;
    case #"me":
        target = self;
        break;
    case #"entity":
        trace = self eye_trace(1);
        target = trace["entity"];
        break;
    case #"none":
        break;
    default:
        return;
    }
    bots = self devgui_get_bots(botarg);
    foreach (bot in bots) {
        bot.favoriteenemy = target;
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0xf1e4915d, Offset: 0x4920
// Size: 0x86
function devgui_goal(botarg, cmdarg) {
    switch (cmdarg) {
    case #"force":
        self devgui_goal_force(botarg);
        return;
    case #"clear":
        self devgui_goal_clear(botarg);
        return;
    case #"me":
        self devgui_goal_me(botarg);
        return;
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x6d604c5f, Offset: 0x49b0
// Size: 0x17a
function devgui_goal_force(botarg) {
    trace = self eye_trace(1);
    bots = devgui_get_bots(botarg);
    goalent = trace["entity"];
    pos = trace["position"];
    node = self get_nearest_node(pos);
    if (isdefined(node)) {
        pos = node;
    }
    foreach (bot in bots) {
        if (isdefined(goalent) && goalent != bot) {
            bot setgoal(goalent);
            continue;
        }
        bot setgoal(pos, 1);
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x8e3a36b9, Offset: 0x4b38
// Size: 0xc2
function devgui_goal_clear(botarg) {
    bots = devgui_get_bots(botarg);
    foreach (bot in bots) {
        bot setgoal(bot.origin);
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x229edf82, Offset: 0x4c08
// Size: 0xba
function devgui_goal_me(botarg) {
    bots = devgui_get_bots(botarg);
    foreach (bot in bots) {
        bot setgoal(self);
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x713d9cab, Offset: 0x4cd0
// Size: 0xe2
function devgui_get_bots(botarg) {
    if (strisnumber(botarg)) {
        bots = [];
        bot = get_bot_by_entity_number(int(botarg));
        if (isdefined(bot)) {
            bots[0] = bot;
        }
        return bots;
    }
    if (botarg == "friendly") {
        return self get_friendly_bots();
    }
    if (botarg == "enemy") {
        return self get_enemy_bots();
    }
    return get_bots();
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x50b61b14, Offset: 0x4dc0
// Size: 0x15c
function devgui_get_target_player() {
    targetplayer = undefined;
    targetdot = undefined;
    players = getplayers();
    foreach (player in players) {
        if (!isalive(player)) {
            continue;
        }
        if (!self cansee(player)) {
            continue;
        }
        dot = self fwd_dot(player.origin);
        if (dot < 0.94) {
            continue;
        }
        if (!isdefined(targetplayer) || dot > targetdot) {
            targetplayer = player;
            targetdot = dot;
        }
    }
    return targetplayer;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xe52eac99, Offset: 0x4f28
// Size: 0x2c8
function test_assign_nearest_companion() {
    if (level.gametype === "pvp") {
        return;
    }
    players = getplayers();
    players = arraysort(players, self.origin);
    foreach (player in players) {
        if (!player isbot() || player util::is_companion() || isdefined(player.owner) || player.team != self.team) {
            continue;
        }
        /#
            hud_print("<dev string:x1be>" + player.name);
        #/
        player setiscompanion(1);
        player assign_companion_to(self);
        if (sessionmodeiscampaigngame() && !isdefined(self.companion)) {
            self.companion = player;
        }
        if (isdefined(level.companions)) {
            arrayremovevalue(level.players, player);
            if (!isdefined(level.companions)) {
                level.companions = [];
            } else if (!isarray(level.companions)) {
                level.companions = array(level.companions);
            }
            if (!isinarray(level.companions, player)) {
                level.companions[level.companions.size] = player;
            }
            if (isdefined(level.updateteamstatus)) {
                level [[ level.updateteamstatus ]]();
            }
        }
        return;
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x432bb114, Offset: 0x51f8
// Size: 0x3ee
function test_release_furthest_companion() {
    if (level.gametype === "pvp") {
        return;
    }
    players = getplayers();
    players = arraysort(players, self.origin, 0);
    foreach (player in players) {
        if (!player isbot() || !player util::is_companion() || !isdefined(player.owner) || player.owner != self) {
            continue;
        }
        /#
            hud_print("<dev string:x1d3>" + player.name);
        #/
        player setiscompanion(0);
        player release_companion();
        if (sessionmodeiscampaigngame() && self.companion == player) {
            self.companion = undefined;
        }
        if (isdefined(level.companions)) {
            arrayremovevalue(level.companions, player);
            if (!isdefined(level.players)) {
                level.players = [];
            } else if (!isarray(level.players)) {
                level.players = array(level.players);
            }
            if (!isinarray(level.players, player)) {
                level.players[level.players.size] = player;
            }
            if (isdefined(level.updateteamstatus)) {
                level [[ level.updateteamstatus ]]();
            }
        }
        break;
    }
    if (sessionmodeiscampaigngame() && !isdefined(self.companion)) {
        players = arraysort(players, self.origin);
        foreach (player in players) {
            if (!player isbot() || !player util::is_companion() || !isdefined(player.owner) || player.owner != self) {
                continue;
            }
            self.companion = player;
            break;
        }
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x42c16061, Offset: 0x55f0
// Size: 0xd2
function test_give_player_weapon() {
    weapon = self getcurrentweapon();
    bots = get_bots();
    foreach (bot in bots) {
        bot test_give_only_weapon(weapon);
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x33e922c1, Offset: 0x56d0
// Size: 0xa4
function test_give_only_weapon(weapon) {
    if (!isdefined(weapon) || weapon == level.weaponnone) {
        return;
    }
    self takeallweapons();
    self giveweapon(weapon);
    self givemaxammo(weapon);
    self switchtoweapon(weapon);
    self setspawnweapon(weapon);
}

/#

    // Namespace bot/bot
    // Params 1, eflags: 0x0
    // Checksum 0x8262c680, Offset: 0x5780
    // Size: 0xbc
    function should_record(dvarstr) {
        if (getdvarint(dvarstr, 0) <= 0) {
            return 0;
        }
        if (self == level) {
            return 1;
        }
        botnum = getdvarint("<dev string:x1e8>", 0);
        if (botnum < 0) {
            return 1;
        }
        ent = getentbynum(botnum);
        return isdefined(ent) && ent == self;
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0x3087c99b, Offset: 0x5848
    // Size: 0x158
    function create_dev_hud() {
        hud = newclienthudelem(self);
        hud.elemtype = "<dev string:x1f2>";
        hud.font = "<dev string:x1f7>";
        hud.alignx = "<dev string:x201>";
        hud.aligny = "<dev string:x208>";
        hud.horzalign = "<dev string:x201>";
        hud.vertalign = "<dev string:x208>";
        hud.x += 0;
        hud.y += 100;
        hud.foreground = 1;
        hud.fontscale = 2;
        hud.alpha = 1;
        hud.color = (1, 1, 0);
        hud.hidewheninmenu = 1;
        self.botdevhud = hud;
    }

    // Namespace bot/bot
    // Params 1, eflags: 0x0
    // Checksum 0x20f285d4, Offset: 0x59a8
    // Size: 0x7c
    function hud_print(msg) {
        host = util::gethostplayerforbots();
        host notify(#"bot_dev_print");
        host.botdevhud settext(msg);
        host thread wait_clear_hud_print();
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0xf924a4c1, Offset: 0x5a30
    // Size: 0x44
    function wait_clear_hud_print() {
        self endon(#"bot_dev_print");
        self endon(#"disconnect");
        wait 3;
        self.botdevhud settext("<dev string:x39>");
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0x234e107f, Offset: 0x5a80
    // Size: 0x158
    function bot_joinleave_loop() {
        active = 0;
        while (true) {
            wait 1;
            joinleavecount = getdvarint("<dev string:x20f>", 0);
            if (!joinleavecount) {
                if (active) {
                    active = 0;
                    remove_bots();
                }
                continue;
            }
            if (!active) {
                adddebugcommand("<dev string:x223>");
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
