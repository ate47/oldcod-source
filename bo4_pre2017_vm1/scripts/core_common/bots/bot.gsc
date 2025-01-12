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
function autoexec function_2dc19561() {
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
    bot function_cb53fa9c();
    bot.goalradius = 512;
    bot function_e0fc553b("bot_default");
    if (isdefined(level.disableclassselection) && level.disableclassselection) {
        bot.pers["class"] = level.defaultclass;
        bot.curclass = level.defaultclass;
    }
    if (level.teambased) {
        bot.var_4fc64051 = isdefined(team) ? team : "autoassign";
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
        bot function_cbebb79a("favorite");
        bot function_70d271b8("priority");
        bot function_2ebaf0ac(0);
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
function function_2438fe8f(owner) {
    self.owner = owner;
    self setgoal(owner);
    if (isdefined(level.var_40841531)) {
        self [[ level.var_40841531 ]]();
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x48c2ba8, Offset: 0x1238
// Size: 0x58
function function_9325803() {
    self.owner = undefined;
    self.protectent = undefined;
    self setgoal(self.origin);
    if (isdefined(level.var_9833a244)) {
        self [[ level.var_9833a244 ]]();
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
            self function_25d513bb();
        #/
        return;
    }
    self endon(#"disconnect");
    /#
        self add_bot_devgui_menu();
    #/
    if (!isdefined(self.__blackboard)) {
        self function_cb53fa9c();
    }
    waitframe(1);
    if (level.teambased && isdefined(self.var_4fc64051)) {
        self notify(#"menuresponse", {#menu:game.menu["menu_team"], #response:self.var_4fc64051});
        self.var_4fc64051 = undefined;
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
        self function_f8cdf22b(weapon);
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
function function_5c68e2ff() {
    if (!isdefined(self.__blackboard)) {
        self function_cb53fa9c();
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
function function_17fae91c() {
    self notify(#"hash_e92acdd7");
    self bot_action::function_cefa7850();
    self namespace_d9f95110::function_39041145();
    self notify(#"hash_4c7b12b7");
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x97cae3ab, Offset: 0x1760
// Size: 0xc8
function update_loop() {
    self endon(#"death");
    self endon(#"hash_e92acdd7");
    level endon(#"game_ended");
    self namespace_d9f95110::function_80f06707();
    while (true) {
        self clear_revive_target();
        while (self frozen()) {
            waitframe(1);
        }
        self function_dc2282e4();
        self update_objective();
        self function_917dc61d();
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x4b992a81, Offset: 0x1830
// Size: 0x8c
function update_objective() {
    objective = self function_12ce9d6f();
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
function function_dc2282e4() {
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
function function_917dc61d() {
    self endon(#"death");
    level endon(#"game_ended");
    bundlename = self function_686f19c7();
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
    var_583eb5a2 = 0;
    if (self function_3dbfc81c() != "none") {
        var_583eb5a2 = self namespace_d9f95110::function_2ea4aef7(tacbundle.var_5650366c, tacbundle.var_aeda73e, tacbundle.var_3150b3e);
    } else {
        self.overridepos = undefined;
    }
    self bot_action::function_36ff3787(tacbundle);
    if (!var_583eb5a2 && self function_3dbfc81c() == "all") {
        query = tacbundle.var_b8355c81;
        var_12e0fe71 = tacbundle.var_5ffcc0e3;
        if (self has_visible_enemy()) {
            query = tacbundle.var_49f80b7d;
            var_12e0fe71 = tacbundle.var_998cfea7;
        } else if (self has_active_enemy()) {
            query = tacbundle.var_6455648f;
            var_12e0fe71 = tacbundle.var_86e63991;
        }
        self namespace_d9f95110::function_53b0caa0(tacbundle.var_5650366c, query, var_12e0fe71);
    }
    self bot_action::function_505b5c0d();
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x44909ad8, Offset: 0x1c70
// Size: 0x5c
function function_cb53fa9c() {
    blackboard::createblackboardforentity(self);
    blackboard::registerblackboardattribute(self, "bot_objective", undefined, undefined);
    blackboard::registerblackboardattribute(self, "bot_point_of_interest", undefined, undefined);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xdcefdc43, Offset: 0x1cd8
// Size: 0x22
function function_686f19c7() {
    return self getblackboardattribute("bot_tactical_state");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xe19ad7ec, Offset: 0x1d08
// Size: 0x2c
function function_46bb241b(name) {
    self setblackboardattribute("bot_tactical_state", name);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xc0545d35, Offset: 0x1d40
// Size: 0x22
function function_12ce9d6f() {
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
function function_abb768ba() {
    return self getblackboardattribute("bot_action");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xd5ad1d84, Offset: 0x1e00
// Size: 0x2c
function function_abbddcde(name) {
    self setblackboardattribute("bot_action", name);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x45a9a9e8, Offset: 0x1e38
// Size: 0x22
function function_4da698e1() {
    return self getblackboardattribute("bot_action_table");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xb03513f2, Offset: 0x1e68
// Size: 0x2c
function function_8f14e255(name) {
    self setblackboardattribute("bot_action_table", name);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x61bd4c4b, Offset: 0x1ea0
// Size: 0x22
function function_fab42cc7() {
    return self getblackboardattribute("bot_stance_table");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x8fca60af, Offset: 0x1ed0
// Size: 0x2c
function function_c58f076b(name) {
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
function function_ec5ce651(point) {
    self setblackboardattribute("bot_point_of_interest", point);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xf8ccd3c7, Offset: 0x1f70
// Size: 0x1c
function function_a3f30b42() {
    self function_ec5ce651(undefined);
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
function function_bc797f4e() {
    return self getblackboardattribute("bot_engage_enemies");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xcc0dadf3, Offset: 0x2058
// Size: 0x2c
function function_cbebb79a(var_d3c8863c) {
    self setblackboardattribute("bot_engage_enemies", var_d3c8863c);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xae8d7725, Offset: 0x2090
// Size: 0x22
function function_3dbfc81c() {
    return self getblackboardattribute("bot_position_updates");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x9d12e12f, Offset: 0x20c0
// Size: 0x2c
function function_70d271b8(var_a640e38e) {
    self setblackboardattribute("bot_position_updates", var_a640e38e);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x95ab59c0, Offset: 0x20f8
// Size: 0x22
function function_76ca6f40() {
    return self getblackboardattribute("bot_commander");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x8d46f816, Offset: 0x2128
// Size: 0x2c
function function_2ebaf0ac(commander) {
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
function function_e0fc553b(bundlename) {
    var_93fffa7b = struct::get_script_bundle("botsettings", bundlename);
    if (!isdefined(var_93fffa7b)) {
        self botprinterror("Could not find botsettings bundle: " + bundlename);
        return;
    }
    if (isdefined(var_93fffa7b.highlyawareradius)) {
        self.highlyawareradius = var_93fffa7b.highlyawareradius;
    }
    if (isdefined(var_93fffa7b.fov)) {
        self.fovcosine = fov_angle_to_cosine(var_93fffa7b.fov);
    }
    if (isdefined(var_93fffa7b.fovbusy)) {
        self.fovcosinebusy = fov_angle_to_cosine(var_93fffa7b.fovbusy);
    }
    self botsetlooksensitivity(var_93fffa7b.pitchsensitivity, var_93fffa7b.yawsensitivity);
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
function function_7a9265d() {
    return struct::get_script_bundle("botsettings", "bot_default");
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xb0b33dce, Offset: 0x2368
// Size: 0x9a
function function_b989f311(enemy) {
    if (!isdefined(enemy)) {
        return 0;
    }
    if (self function_bc797f4e() == "none") {
        return 0;
    }
    if (self function_bc797f4e() == "favorite") {
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
function function_40bc42f0(enemy) {
    return isdefined(self.enemy) && self.enemy === enemy;
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x53fc531b, Offset: 0x2478
// Size: 0x22
function function_bc93b0d1() {
    return self function_b989f311(self.enemy);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x651195e2, Offset: 0x24a8
// Size: 0x3a
function has_visible_enemy() {
    return self function_bc93b0d1() && self enemy_is_visible(self.enemy);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x26583814, Offset: 0x24f0
// Size: 0x46
function has_active_enemy() {
    if (!self function_bc93b0d1()) {
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
    var_2c1f54f = getdvarstring("pauseBotTeam", "none");
    return var_2c1f54f == "any" || var_2c1f54f == "all" || var_2c1f54f == self.team;
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
function function_6796569() {
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
function function_41153256() {
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
function function_cf8f9518(weapon) {
    if (weapon.isheavyweapon) {
        self function_4ab36ef5(weapon);
        return;
    }
    if (weapon.isabilityweapon) {
        self function_dfc491e9(weapon);
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x54d1a2fc, Offset: 0x2f50
// Size: 0xdc
function function_4ab36ef5(weapon) {
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
function function_dfc491e9(weapon) {
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
function function_3ee74245(var_d0870a8f, var_5e7f9b54, var_83faa6dc, origin, yaw, team_a, team_b) {
    if (!isdefined(var_d0870a8f)) {
        var_d0870a8f = 70;
    }
    if (!isdefined(var_5e7f9b54)) {
        var_5e7f9b54 = 100;
    }
    if (!isdefined(var_83faa6dc)) {
        var_83faa6dc = 30;
    }
    var_73022886 = 6;
    var_688bd21a = isplayer(self) ? var_73022886 - 1 : var_73022886;
    var_428957b1 = var_73022886;
    function_8734aa44(origin, yaw, team_a, var_688bd21a, var_d0870a8f, team_b, var_428957b1, var_5e7f9b54, var_83faa6dc);
}

// Namespace bot/bot
// Params 7, eflags: 0x0
// Checksum 0x58465b0c, Offset: 0x32c8
// Size: 0x8c
function function_5bc6411e(var_d0870a8f, var_5e7f9b54, var_83faa6dc, origin, yaw, team_a, team_b) {
    setdvar("pauseBotTeam", "all");
    function_3ee74245(var_d0870a8f, var_5e7f9b54, var_83faa6dc, origin, yaw, team_a, team_b);
}

// Namespace bot/bot
// Params 9, eflags: 0x0
// Checksum 0x70af1343, Offset: 0x3360
// Size: 0x1d4
function function_8734aa44(origin, yaw, team_a, var_688bd21a, var_d0870a8f, team_b, var_428957b1, var_5e7f9b54, var_83faa6dc) {
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
    if (!isdefined(var_428957b1)) {
        var_428957b1 = 0;
    }
    function_8a113de(origin, yaw, team_a, var_688bd21a, var_d0870a8f, var_83faa6dc, spawn_delay);
    function_8a113de(origin, yaw, team_b, var_428957b1, var_5e7f9b54, var_83faa6dc, spawn_delay);
}

// Namespace bot/bot
// Params 7, eflags: 0x0
// Checksum 0x7873e673, Offset: 0x3540
// Size: 0x15c
function function_8a113de(origin, yaw, team, spawn_count, radius, var_99df81d4, spawn_delay) {
    if (!isdefined(spawn_delay)) {
        spawn_delay = 0.15;
    }
    if (spawn_count <= 0) {
        return;
    }
    player = self;
    start_yaw = (spawn_count - 1) * var_99df81d4 * 0.5;
    var_11c6ecec = angleclamp180(start_yaw * -1 + yaw);
    for (i = 0; i < spawn_count; i++) {
        function_7e05a58d(team, origin + horizontal_offset(var_11c6ecec, radius), angleclamp180(var_11c6ecec - 180));
        wait spawn_delay;
        var_11c6ecec += var_99df81d4;
    }
}

// Namespace bot/bot
// Params 3, eflags: 0x0
// Checksum 0xd4415186, Offset: 0x36a8
// Size: 0xf4
function function_7e05a58d(team, hint_origin, yaw) {
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
            host function_5c47075a(args[1], args[2]);
            break;
        case #"move":
            host function_26c0d8fd(args[1], args[2]);
            break;
        case #"hash_14c393c6":
            host function_58f81025(args[1], args[2]);
            break;
        case #"goal":
            host devgui_goal(args[1], args[2]);
            break;
        case #"hash_ec7c1238":
            host function_b21e81f7();
            break;
        case #"hash_fdc11eb4":
            host function_9ff9464();
            break;
        case #"hash_18cde5dc":
            host function_18cde5dc();
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
function function_5c47075a(botarg, cmdarg) {
    bots = self devgui_get_bots(botarg);
    foreach (bot in bots) {
        bot function_cbebb79a(cmdarg);
    }
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0xbddf4697, Offset: 0x4448
// Size: 0xea
function function_26c0d8fd(botarg, cmdarg) {
    bots = self devgui_get_bots(botarg);
    foreach (bot in bots) {
        bot function_70d271b8(cmdarg);
        bot function_2ebaf0ac(cmdarg == "all");
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
function function_58f81025(botarg, cmdarg) {
    target = undefined;
    switch (cmdarg) {
    case #"player":
        target = self function_da67e50e();
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
        self function_2f22dbc7(botarg);
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
function function_2f22dbc7(botarg) {
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
function function_da67e50e() {
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
function function_b21e81f7() {
    if (level.gametype === "pvp") {
        return;
    }
    players = getplayers();
    players = arraysort(players, self.origin);
    foreach (player in players) {
        if (!player isbot() || player util::function_4f5dd9d2() || isdefined(player.owner) || player.team != self.team) {
            continue;
        }
        /#
            function_ed1cd99c("<dev string:x1be>" + player.name);
        #/
        player setiscompanion(1);
        player function_2438fe8f(self);
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
function function_9ff9464() {
    if (level.gametype === "pvp") {
        return;
    }
    players = getplayers();
    players = arraysort(players, self.origin, 0);
    foreach (player in players) {
        if (!player isbot() || !player util::function_4f5dd9d2() || !isdefined(player.owner) || player.owner != self) {
            continue;
        }
        /#
            function_ed1cd99c("<dev string:x1d3>" + player.name);
        #/
        player setiscompanion(0);
        player function_9325803();
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
            if (!player isbot() || !player util::function_4f5dd9d2() || !isdefined(player.owner) || player.owner != self) {
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
function function_18cde5dc() {
    weapon = self getcurrentweapon();
    bots = get_bots();
    foreach (bot in bots) {
        bot function_f8cdf22b(weapon);
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x33e922c1, Offset: 0x56d0
// Size: 0xa4
function function_f8cdf22b(weapon) {
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
    function function_25d513bb() {
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
        self.var_aba1b570 = hud;
    }

    // Namespace bot/bot
    // Params 1, eflags: 0x0
    // Checksum 0x20f285d4, Offset: 0x59a8
    // Size: 0x7c
    function function_ed1cd99c(msg) {
        host = util::gethostplayerforbots();
        host notify(#"hash_cae03ef8");
        host.var_aba1b570 settext(msg);
        host thread function_13c09ca2();
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0xf924a4c1, Offset: 0x5a30
    // Size: 0x44
    function function_13c09ca2() {
        self endon(#"hash_cae03ef8");
        self endon(#"disconnect");
        wait 3;
        self.var_aba1b570 settext("<dev string:x39>");
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
