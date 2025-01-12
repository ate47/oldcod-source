#using script_34e162235fb08844;
#using script_4e44ad88a2b0f559;
#using script_56658a4b2d9bfa24;
#using script_5e6a760c6f43dd12;
#using script_7124f66ae9dd2bde;
#using script_74453936abc39adf;
#using script_79b47c663155f8bd;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_chain;
#using scripts\core_common\bots\bot_interface;
#using scripts\core_common\bots\bot_orders;
#using scripts\core_common\bots\bot_position;
#using scripts\core_common\bots\bot_stance;
#using scripts\core_common\bots\bot_traversals;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace bot;

// Namespace bot/bot
// Params 0, eflags: 0x6
// Checksum 0x38c11f0f, Offset: 0x1d0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"bot", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace bot/bot
// Params 0, eflags: 0x5 linked
// Checksum 0xd200fd31, Offset: 0x218
// Size: 0x384
function private function_70a657d8() {
    if (currentsessionmode() == 4 || currentsessionmode() == 2) {
        return;
    }
    level.var_fa5cacde = getgametypesetting(#"hash_77b7734750cd75e9") || is_true(level.var_fa5cacde);
    level.var_7cabd617 = getgametypesetting(#"bot_difficulty_allies");
    /#
        level namespace_1f0cb9eb::function_70a657d8();
        if (getdvarint(#"hash_7140b31f7170f18b", 0)) {
            setdvar(#"scr_player_ammo", "<dev string:x38>");
        }
    #/
    if (is_true(level.var_fa5cacde)) {
        callback::on_spawned(&function_abe38e0f);
        callback::on_player_killed(&function_96dddf6f);
        return;
    }
    namespace_87549638::function_70a657d8();
    bot_action::function_70a657d8();
    namespace_38ee089b::function_70a657d8();
    namespace_4567f5de::function_70a657d8();
    bot_orders::function_70a657d8();
    namespace_ffbf548b::function_70a657d8();
    bot_position::function_70a657d8();
    bot_stance::function_70a657d8();
    namespace_255a2b21::function_70a657d8();
    bot_traversals::function_70a657d8();
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_damage(&on_player_damage);
    callback::on_player_killed(&on_player_killed);
    callback::add_callback(#"hash_6efb8cec1ca372dc", &function_7291a729);
    callback::add_callback(#"hash_6280ac8ed281ce3c", &function_99a2ecf5);
    /#
        level thread bot_joinleave_loop();
        level.var_b3287493 = [#"combat_state_in_combat":(1, 0, 0), #"combat_state_has_visible_enemy":(1, 0.5, 0), #"combat_state_aware_of_enemies":(1, 1, 0), #"combat_state_idle":(0, 1, 0)];
    #/
    botinterface::registerbotinterfaceattributes();
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x8423f4a4, Offset: 0x5a8
// Size: 0x6
function is_bot_ranked_match() {
    return false;
}

// Namespace bot/bot
// Params 3, eflags: 0x1 linked
// Checksum 0x46a03ca, Offset: 0x5b8
// Size: 0x16a
function add_bot(team, name = undefined, clanabbrev = undefined) {
    bot = addtestclient(name, clanabbrev);
    if (!isdefined(bot)) {
        return undefined;
    }
    bot init_bot();
    bot.goalradius = 512;
    if (is_true(level.disableclassselection)) {
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
// Checksum 0x805ed721, Offset: 0x730
// Size: 0x96
function add_bots(count = 1, team) {
    level endon(#"game_ended", #"remove_bot");
    for (i = 0; i < count; i++) {
        bot = add_bot(team);
        if (!isdefined(bot)) {
            return;
        }
        waitframe(1);
    }
}

/#

    // Namespace bot/bot
    // Params 5, eflags: 0x0
    // Checksum 0x2f1bf151, Offset: 0x7d0
    // Size: 0x1a4
    function function_bd48ef10(team, count, origin, yaw, roleindex) {
        bots = [];
        if (!isdefined(bots)) {
            bots = [];
        } else if (!isarray(bots)) {
            bots = array(bots);
        }
        bots[bots.size] = self add_fixed_spawn_bot(team, origin, yaw, roleindex);
        spiral = dev::function_a4ccb933(origin, yaw);
        for (i = 0; i < count - 1; i++) {
            dev::function_df0b6f84(spiral);
            origin = dev::function_98c05766(spiral);
            angle = dev::function_4783f10c(spiral);
            if (!isdefined(bots)) {
                bots = [];
            } else if (!isarray(bots)) {
                bots = array(bots);
            }
            bots[bots.size] = self add_fixed_spawn_bot(team, origin, angle, roleindex);
        }
        return bots;
    }

    // Namespace bot/bot
    // Params 4, eflags: 0x0
    // Checksum 0x1654093b, Offset: 0x980
    // Size: 0x112
    function add_fixed_spawn_bot(team, origin, yaw, roleindex) {
        if (!isdefined(roleindex)) {
            roleindex = undefined;
        }
        bot = add_bot(team);
        if (isdefined(bot)) {
            if (isdefined(roleindex) && roleindex >= 0) {
                bot.var_29b433bd = int(roleindex);
            }
            bot allow_all(0);
            node = bot get_nearest_node(origin);
            if (isdefined(node)) {
                bot function_917c2944(node);
            } else {
                bot function_bab12815(origin, yaw);
            }
        }
        return bot;
    }

    // Namespace bot/bot
    // Params 2, eflags: 0x0
    // Checksum 0x1ac966f9, Offset: 0xaa0
    // Size: 0x62
    function function_bab12815(origin, yaw) {
        if (!isstruct(self.bot)) {
            return;
        }
        self.bot.var_4d578249 = origin;
        self.bot.var_1ba7812 = (0, yaw, 0);
    }

    // Namespace bot/bot
    // Params 1, eflags: 0x0
    // Checksum 0x344b3b6, Offset: 0xb10
    // Size: 0x42
    function function_917c2944(node) {
        if (!isstruct(self.bot)) {
            return;
        }
        self.bot.var_f7b7c2ed = node;
    }

    // Namespace bot/bot
    // Params 1, eflags: 0x0
    // Checksum 0x2a3c8b88, Offset: 0xb60
    // Size: 0x42
    function function_39d30bb6(forcegoal) {
        if (!isstruct(self.bot)) {
            return;
        }
        self.bot.var_7280cc1b = forcegoal;
    }

    // Namespace bot/bot
    // Params 2, eflags: 0x0
    // Checksum 0xf40b55b6, Offset: 0xbb0
    // Size: 0x66
    function function_bcc79b86(vehicle, seatindex) {
        if (!isdefined(seatindex)) {
            seatindex = undefined;
        }
        if (!isstruct(self.bot)) {
            return;
        }
        self.bot.var_22989bf = vehicle;
        self.bot.var_a3d475e5 = seatindex;
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x4
    // Checksum 0x42c9f12f, Offset: 0xc20
    // Size: 0x1cc
    function private fixed_spawn_override() {
        self endon(#"death", #"disconnect", #"hash_6280ac8ed281ce3c");
        waittillframeend();
        if (!isstruct(self.bot)) {
            return;
        }
        node = self.bot.var_f7b7c2ed;
        origin = self.bot.var_4d578249;
        angles = self.bot.var_1ba7812;
        forcegoal = isdefined(self.bot.var_7280cc1b) ? self.bot.var_7280cc1b : 1;
        if (isdefined(node)) {
            self setorigin(node.origin);
            self setplayerangles(node.angles);
            self setgoal(node, forcegoal);
        } else if (isdefined(origin)) {
            self setorigin(origin);
            if (isdefined(angles)) {
                self setplayerangles(angles);
            }
            self setgoal(origin, forcegoal);
        }
        self dontinterpolate();
        self function_50c012c9();
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x4
    // Checksum 0xde49bacb, Offset: 0xdf8
    // Size: 0x178
    function private function_50c012c9() {
        if (!isstruct(self.bot)) {
            return;
        }
        vehicle = self.bot.var_22989bf;
        seatindex = self.bot.var_a3d475e5;
        if (!isvehicle(vehicle)) {
            return;
        }
        if (isint(seatindex) && !vehicle isvehicleseatoccupied(seatindex)) {
            vehicle usevehicle(self, seatindex);
            return;
        }
        for (i = 0; i < 11; i++) {
            if (vehicle function_dcef0ba1(i)) {
                var_3693c73b = vehicle function_defc91b2(i);
                if (isdefined(var_3693c73b) && var_3693c73b >= 0 && !vehicle isvehicleseatoccupied(i)) {
                    vehicle usevehicle(self, i);
                    break;
                }
            }
        }
    }

#/

// Namespace bot/bot
// Params 1, eflags: 0x1 linked
// Checksum 0xe9ccaaf9, Offset: 0xf78
// Size: 0xe0
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
// Params 0, eflags: 0x1 linked
// Checksum 0x2fa2bd2c, Offset: 0x1060
// Size: 0x64
function remove_random_bot() {
    bots = get_bots();
    if (!bots.size) {
        return;
    }
    bot = bots[randomint(bots.size)];
    remove_bot(bot);
}

// Namespace bot/bot
// Params 1, eflags: 0x1 linked
// Checksum 0xc236d39b, Offset: 0x10d0
// Size: 0x54
function remove_bot(bot) {
    if (!bot istestclient()) {
        return;
    }
    level notify(#"remove_bot");
    bot botdropclient();
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x3ef6f90a, Offset: 0x1130
// Size: 0xc2
function get_bots() {
    players = getplayers();
    bots = [];
    foreach (player in players) {
        if (isbot(player)) {
            bots[bots.size] = player;
        }
    }
    return bots;
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0xb59d2b3e, Offset: 0x1200
// Size: 0xce
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
// Checksum 0xb9f4872b, Offset: 0x12d8
// Size: 0xea
function get_enemy_bots() {
    players = getplayers();
    bots = [];
    foreach (player in players) {
        if (!isbot(player)) {
            continue;
        }
        if (util::function_fbce7263(player.team, self.team)) {
            bots[bots.size] = player;
        }
    }
    return bots;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xf157c7f2, Offset: 0x13d0
// Size: 0xd6
function function_a0f5b7f5(team) {
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
// Params 0, eflags: 0x0
// Checksum 0x8de63122, Offset: 0x14b0
// Size: 0xa2
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
// Params 0, eflags: 0x1 linked
// Checksum 0x1b28f214, Offset: 0x1560
// Size: 0x54
function function_abe38e0f() {
    if (!isbot(self)) {
        return;
    }
    /#
        self thread fixed_spawn_override();
    #/
    waitframe(1);
    self bottakemanualcontrol();
}

// Namespace bot/bot
// Params 1, eflags: 0x5 linked
// Checksum 0xb3a37735, Offset: 0x15c0
// Size: 0x3c
function private function_96dddf6f(*params) {
    if (!isbot(self)) {
        return;
    }
    self thread respawn();
}

// Namespace bot/bot
// Params 0, eflags: 0x5 linked
// Checksum 0x6a171f3d, Offset: 0x1608
// Size: 0xae
function private on_player_connect() {
    if (!isbot(self)) {
        return;
    }
    self endon(#"disconnect");
    if (!self initialized()) {
        self init_bot();
    }
    if (isdefined(self.var_29b433bd) && player_role::is_valid(self.var_29b433bd)) {
        player_role::set(self.var_29b433bd);
        self.var_29b433bd = undefined;
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x5 linked
// Checksum 0xbe74466a, Offset: 0x16c0
// Size: 0x184
function private on_player_spawned() {
    if (!isbot(self)) {
        return;
    }
    self.var_2925fedc = undefined;
    if (self bot_chain::function_58b429fb()) {
        self bot_chain::function_34a84039();
    } else if (ai::getaiattribute(self, "control") === "autonomous" && isdefined(self.bot.var_bd883a25)) {
        self setgoal(self.bot.var_bd883a25, self.bot.var_4e3a654);
    } else {
        self setgoal(self.origin);
    }
    self.bot.var_f9954cf6 = undefined;
    self.bot.var_44114a0e = undefined;
    self.bot.currentflag = undefined;
    self thread function_b781f1e5();
    /#
        self thread fixed_spawn_override();
        if (is_true(self.bot.var_261b9ab3)) {
            waitframe(1);
            self bottakemanualcontrol();
        }
    #/
}

// Namespace bot/bot
// Params 1, eflags: 0x5 linked
// Checksum 0xcedbc95e, Offset: 0x1850
// Size: 0x6e
function private on_player_damage(*params) {
    if (!isbot(self)) {
        return;
    }
    if (function_ffa5b184(self.enemy)) {
        self clearentitytarget();
        self.bot.var_2a98e9ea = 0;
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x5 linked
// Checksum 0x94f9a13f, Offset: 0x18c8
// Size: 0x54
function private on_player_killed(*params) {
    if (!isbot(self)) {
        return;
    }
    self clear_interact();
    self thread respawn();
}

// Namespace bot/bot
// Params 0, eflags: 0x5 linked
// Checksum 0x493625ad, Offset: 0x1928
// Size: 0xf8
function private respawn() {
    level endon(#"game_ended");
    self endon(#"disconnect", #"spawned");
    self waittilltimeout(3, #"death_delay_finished");
    wait 0.1;
    if (is_true(getgametypesetting(#"hash_2b1f40bc711c41f3"))) {
        self thread squad_spawn(0.1);
        return;
    }
    while (true) {
        self bottapbutton(3);
        wait 0.1;
    }
}

// Namespace bot/bot
// Params 1, eflags: 0x5 linked
// Checksum 0xcab76b74, Offset: 0x1a28
// Size: 0x1c6
function private squad_spawn(var_2b6a7c31) {
    level endon(#"game_ended");
    self endon(#"death", #"disconnect", #"spawned");
    while (!isdefined(self.var_f7900902) || self.var_f7900902 <= 0) {
        wait var_2b6a7c31;
    }
    aliveplayers = function_a1cff525(self.squad);
    var_f2cc505e = [];
    foreach (player in aliveplayers) {
        if (!isdefined(player.var_83de62a2) || player.var_83de62a2 != 0) {
            continue;
        }
        var_f2cc505e[var_f2cc505e.size] = player;
    }
    if (var_f2cc505e.size > 0) {
        targetplayer = var_f2cc505e[randomint(var_f2cc505e.size)];
        self.var_f7900902 = 0;
        self.var_d50e861c = "spawnOnPlayer";
        self.var_d690fc0b = targetplayer;
        return;
    }
    self.var_f7900902 = 0;
    self.var_d50e861c = "autoSpawn";
}

// Namespace bot/bot
// Params 0, eflags: 0x5 linked
// Checksum 0x2362bb20, Offset: 0x1bf8
// Size: 0x54
function private function_7291a729() {
    if (!self initialized()) {
        self init_bot();
    }
    self.goalradius = 512;
    self thread function_b781f1e5();
}

// Namespace bot/bot
// Params 0, eflags: 0x5 linked
// Checksum 0x57d4c21b, Offset: 0x1c58
// Size: 0x1e
function private function_99a2ecf5() {
    self notify(#"hash_6280ac8ed281ce3c");
    self.bot = undefined;
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x33214bb0, Offset: 0x1c80
// Size: 0x38e
function function_b781f1e5() {
    self endon(#"death", #"hash_6280ac8ed281ce3c");
    level endon(#"game_ended");
    while (true) {
        /#
            if (self should_record(#"bot_recordthreat")) {
                self function_112e10ff();
            }
            if (isdefined(self get_revive_target())) {
                target = self get_revive_target().origin;
                recordline(self.origin, target, (0, 1, 1), "<dev string:x3d>", self);
                recordcircle(target, 32, (0, 1, 1), "<dev string:x3d>", self);
            }
            if (self should_record(#"hash_16eb77415dcf6054")) {
                self function_d45e8714();
            }
        #/
        self function_23c46f6e();
        if (!self isplayinganimscripted() && !self arecontrolsfrozen() && !self function_5972c3cf() && !self isinvehicle() && !self util::isflashed() && isdefined(self.sessionstate) && self.sessionstate == "playing") {
            self function_4fb21bb4();
            self function_7d5bb412();
            self bot_orders::think();
            self namespace_87549638::think();
            self bot_action::think();
            self bot_stance::think();
            self bot_position::think();
            self namespace_94e44221::update();
        } else if (self function_dd750ead()) {
            gameobject = self get_interact();
            if (is_true(gameobject.inuse) && isdefined(gameobject.trigger) && self.claimtrigger === gameobject.trigger) {
                self bottapbutton(3);
            }
        }
        /#
            self namespace_1f0cb9eb::function_e4055765();
        #/
        waitframe(1);
    }
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x41cc8f1f, Offset: 0x2018
// Size: 0x174
function function_23c46f6e() {
    if (self function_dd750ead()) {
        gameobject = self get_interact();
        if (!isdefined(gameobject.trigger) || !gameobject.trigger istriggerenabled() || !gameobject gameobjects::can_interact_with(self)) {
            self clear_interact();
        } else if (is_true(gameobject.inuse) && self.claimtrigger !== gameobject.trigger) {
            self clear_interact();
        }
        return;
    }
    if (self function_914feddd()) {
        return;
    }
    if (self function_43a720c7()) {
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
// Params 0, eflags: 0x5 linked
// Checksum 0xb9af6b8e, Offset: 0x2198
// Size: 0x126
function private function_4fb21bb4() {
    if (self.combatstate == "combat_state_idle" || !isdefined(self.enemy) || !isalive(self.enemy)) {
        self.bot.enemyvisible = 0;
        self.bot.var_e8c84f98 = 0;
        return;
    }
    if (self cansee(self.enemy, 250)) {
        self.bot.enemyvisible = 1;
        self.bot.var_e8c84f98 = 1;
        return;
    }
    if (isdefined(self.enemylastseentime)) {
        self.bot.enemyvisible = 0;
        self.bot.var_e8c84f98 = self.enemylastseentime + 4500 >= gettime();
        return;
    }
    self.bot.enemyvisible = 0;
    self.bot.var_e8c84f98 = 0;
}

// Namespace bot/bot
// Params 0, eflags: 0x5 linked
// Checksum 0x5ca07719, Offset: 0x22c8
// Size: 0xae
function private function_7d5bb412() {
    dist = 1000;
    if (self.bot.enemyvisible) {
        dist = distance(self.origin, self.enemy.origin);
    } else if (self.bot.var_e8c84f98) {
        dist = distance(self.origin, self.enemylastseenpos);
    }
    self.bot.enemydist = dist;
    self.bot.enemydistsq = dist * dist;
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x6019628e, Offset: 0x2380
// Size: 0x1ac
function init_bot() {
    self.bot = {#var_b2b8f0b6:300, #var_e8c941d6:470, #var_51cee2ad:0, #var_af11e334:0, #var_18fa994c:0, #var_857c5ea8:0};
    /#
        self.bot.var_a0f96630 = [];
    #/
    ai::createinterfaceforentity(self);
    self.maxsightdistsqrd = 0 * 0;
    self.highlyawareradius = 256;
    self.fovcosine = fov_angle_to_cosine(179);
    self.fovcosinebusy = fov_angle_to_cosine(110);
    self botsetlooksensitivity(1, 1);
    self function_4f0b9564(7.5, 15);
    blackboard::createblackboardforentity(self);
    self function_eaf7ef38(#"hash_1b029888c4965031", #"hash_41b1340b7efb3261");
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x8faf0833, Offset: 0x2538
// Size: 0xc
function initialized() {
    return isdefined(self.bot);
}

// Namespace bot/bot
// Params 1, eflags: 0x1 linked
// Checksum 0xecd48be2, Offset: 0x2550
// Size: 0x42
function fov_angle_to_cosine(fovangle = 0) {
    if (fovangle >= 180) {
        return 0;
    }
    return cos(fovangle / 2);
}

// Namespace bot/bot
// Params 1, eflags: 0x1 linked
// Checksum 0x799c982e, Offset: 0x25a0
// Size: 0x1e
function set_interact(interact) {
    self.bot.interact = interact;
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0xdadbed1e, Offset: 0x25c8
// Size: 0x12
function clear_interact() {
    self.bot.interact = undefined;
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x6fb09970, Offset: 0x25e8
// Size: 0x12
function get_interact() {
    return self.bot.interact;
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x641ce38d, Offset: 0x2608
// Size: 0x14
function has_interact() {
    return isdefined(self.bot.interact);
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0xcea3c368, Offset: 0x2628
// Size: 0x5a
function function_dd750ead() {
    return isdefined(self.bot.interact) && isdefined(self.bot.interact.trigger) && self.bot.interact.triggertype === "use";
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x31469519, Offset: 0x2690
// Size: 0x32
function function_914feddd() {
    return isdefined(self.bot.interact) && isdefined(self.bot.interact.zombie_weapon_upgrade);
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0xc54f5476, Offset: 0x26d0
// Size: 0x56
function function_e8a17817() {
    return isdefined(self.bot.interact) && isdefined(self.bot.interact.zombie_cost) && self.bot.interact._door_open !== 1;
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x7a7e458a, Offset: 0x2730
// Size: 0x5e
function function_2d99e476() {
    return isdefined(self.bot.interact) && self.bot.interact.objectid === "magicbox_struct" && self.bot.interact.hidden !== 1;
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x13f0ac63, Offset: 0x2798
// Size: 0x3a
function function_4e55eb5d() {
    return isdefined(self.bot.interact) && self.bot.interact.targetname === "use_elec_switch";
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0xd25e557a, Offset: 0x27e0
// Size: 0x3a
function function_ca9fb875() {
    return isdefined(self.bot.interact) && self.bot.interact.script_unitrigger_type === "unitrigger_box_use";
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x91624d07, Offset: 0x2828
// Size: 0x5c
function function_43a720c7() {
    return function_e8a17817() || function_2d99e476() || function_4e55eb5d() || function_ca9fb875();
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x2a0114ff, Offset: 0x2890
// Size: 0x188
function function_bba89736() {
    if (!self has_interact()) {
        return undefined;
    }
    interact = self get_interact();
    if (self function_dd750ead()) {
        return interact.trigger;
    } else if (self function_914feddd() || self function_43a720c7()) {
        if (isentity(interact)) {
            return interact;
        } else if (isdefined(interact.trigger_stub) && isdefined(interact.trigger_stub.playertrigger)) {
            return interact.trigger_stub.playertrigger[self getentitynumber()];
        } else if (isdefined(interact.unitrigger_stub) && isdefined(interact.unitrigger_stub.playertrigger)) {
            return interact.unitrigger_stub.playertrigger[self getentitynumber()];
        } else if (isdefined(interact.playertrigger)) {
            return interact.playertrigger[self getentitynumber()];
        }
    }
    return undefined;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0x3466d204, Offset: 0x2a20
// Size: 0x6e
function menu_cancel(menukey) {
    self notify(#"menuresponse", {#menu:game.menu[menukey], #response:"cancel", #intpayload:0});
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x939afe3d, Offset: 0x2a98
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
// Params 0, eflags: 0x1 linked
// Checksum 0xc29c64f0, Offset: 0x2b08
// Size: 0x20
function function_12b52153() {
    return self.bot.enemydist <= 200;
}

// Namespace bot/bot
// Params 2, eflags: 0x0
// Checksum 0x15f4ae00, Offset: 0x2b30
// Size: 0x36
function function_7aeb27f1(smin, smax) {
    return gettime() + 1000 * randomfloatrange(smin, smax);
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0x3689f6cf, Offset: 0x2b70
// Size: 0xb2
function function_343d7ef4() {
    if (!isbot(self)) {
        return false;
    }
    if (self isinvehicle()) {
        vehicle = self getvehicleoccupied();
        if (is_true(vehicle.goalforced) || is_true(vehicle.ignoreall)) {
            return false;
        }
    } else if (self.ignoreall) {
        return false;
    }
    return true;
}

// Namespace bot/bot
// Params 4, eflags: 0x1 linked
// Checksum 0xa42de310, Offset: 0x2c30
// Size: 0x24
function function_b5dd2fd2(*entity, *attribute, *oldvalue, *value) {
    
}

// Namespace bot/bot
// Params 0, eflags: 0x0
// Checksum 0xa95bd922, Offset: 0x2c60
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
// Checksum 0xdb3a08f8, Offset: 0x2cb0
// Size: 0x112
function function_f0c35734(trigger) {
    assert(isbot(self));
    assert(isdefined(trigger));
    radius = self getpathfindingradius();
    height = self function_6a9ae71();
    heightoffset = (0, 0, height * -1 / 2);
    var_e790dc87 = (radius, radius, height / 2);
    obb = ai::function_470c0597(trigger.origin + heightoffset, trigger.maxs + var_e790dc87, trigger.angles);
    return obb;
}

// Namespace bot/bot
// Params 1, eflags: 0x0
// Checksum 0xdb5b1043, Offset: 0x2dd0
// Size: 0x142
function function_52947b70(trigger) {
    assert(isbot(self));
    assert(isstruct(trigger));
    radius = self getpathfindingradius();
    height = self function_6a9ae71();
    heightoffset = (0, 0, height * -1 / 2);
    var_e790dc87 = (radius, radius, height / 2);
    maxs = (trigger.script_width, trigger.script_length, trigger.script_height);
    obb = ai::function_470c0597(trigger.origin + heightoffset, maxs + var_e790dc87, trigger.angles);
    return obb;
}

/#

    // Namespace bot/bot
    // Params 1, eflags: 0x0
    // Checksum 0xbf2a23dc, Offset: 0x2f20
    // Size: 0x1d4
    function allow_all(allow) {
        self.ignoreall = !allow;
        self ai::set_behavior_attribute(#"reload", allow);
        self ai::set_behavior_attribute(#"revive", allow);
        self ai::set_behavior_attribute(#"slide", allow);
        self ai::set_behavior_attribute(#"swim", allow);
        self ai::set_behavior_attribute(#"sprint", allow);
        self ai::set_behavior_attribute(#"primaryoffhand", allow);
        self ai::set_behavior_attribute(#"secondaryoffhand", allow);
        self ai::set_behavior_attribute(#"specialoffhand", allow);
        self ai::set_behavior_attribute(#"scorestreak", allow);
        if (allow) {
            self ai::set_behavior_attribute("<dev string:x69>", "<dev string:x74>");
            self clearforcedgoal();
            return;
        }
        self ai::set_behavior_attribute("<dev string:x69>", "<dev string:x81>");
        self setgoal(self.origin, 1);
    }

    // Namespace bot/bot
    // Params 4, eflags: 0x0
    // Checksum 0x83f46bd3, Offset: 0x3100
    // Size: 0x106
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
        nodes = getnodesinradiussorted(pos, maxradius, minradius, height, "<dev string:x8f>");
        if (nodes.size > 0) {
            return nodes[0];
        }
        nodes = getnodesinradiussorted(pos, maxradius, minradius, height, "<dev string:x9b>");
        if (nodes.size > 0) {
            return nodes[0];
        }
        nodes = getnodesinradiussorted(pos, maxradius, minradius, height, "<dev string:xa4>");
        if (nodes.size > 0) {
            return nodes[0];
        }
        return undefined;
    }

    // Namespace bot/bot
    // Params 1, eflags: 0x0
    // Checksum 0x669ea9, Offset: 0x3210
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
    // Checksum 0xd088b60f, Offset: 0x32d8
    // Size: 0x64
    function record_text(text, textcolor, dvarstr) {
        if (self should_record(dvarstr)) {
            record3dtext(text, self.origin, textcolor, "<dev string:x3d>", self, 0.5);
        }
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0xac79075e, Offset: 0x3348
    // Size: 0x6c
    function function_112e10ff() {
        color = level.var_b3287493[self.combatstate];
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        record3dtext(self.combatstate, self.origin, color, "<dev string:x3d>", self, 0.5);
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0xce5a9cf6, Offset: 0x33c0
    // Size: 0x204
    function function_d45e8714() {
        if (!self has_interact()) {
            return;
        }
        interact = self get_interact();
        var_dda174e9 = self function_bba89736();
        origin = interact.origin;
        desc = "<dev string:xac>";
        if (self function_dd750ead()) {
            desc = "<dev string:xc0>";
        } else if (self function_914feddd()) {
            desc = "<dev string:xce>";
        } else if (self function_e8a17817()) {
            desc = "<dev string:xe8>";
        } else if (self function_ca9fb875()) {
            desc = "<dev string:xfb>";
        }
        if (isdefined(var_dda174e9)) {
            self function_1744d303(var_dda174e9, (0, 1, 0), "<dev string:x3d>");
        }
        if (!isvec(origin)) {
            if (isdefined(var_dda174e9)) {
                origin = var_dda174e9.origin;
            } else {
                origin = self.origin;
            }
        }
        recordline(self.origin, origin, (0, 1, 0), "<dev string:x3d>", self);
        recordsphere(origin, 8, (0, 1, 0), "<dev string:x3d>", self);
        record3dtext(desc, origin, (1, 1, 1), "<dev string:x3d>", undefined, 0.5);
    }

    // Namespace bot/bot
    // Params 3, eflags: 0x0
    // Checksum 0x407255a4, Offset: 0x35d0
    // Size: 0x184
    function function_1744d303(trigger, color, channel) {
        maxs = trigger getmaxs();
        mins = trigger getmins();
        if (issubstr(trigger.classname, "<dev string:x111>")) {
            radius = max(maxs[0], maxs[1]);
            top = trigger.origin + (0, 0, maxs[2]);
            bottom = trigger.origin + (0, 0, mins[2]);
            recordcircle(bottom, radius, color, channel, self);
            recordcircle(top, radius, color, channel, self);
            recordline(bottom, top, color, channel, self);
            return;
        }
        function_af72dbc5(trigger.origin, mins, maxs, trigger.angles[0], color, channel, self);
    }

    // Namespace bot/bot
    // Params 3, eflags: 0x20 variadic
    // Checksum 0xe87b792, Offset: 0x3760
    // Size: 0xdc
    function map_color(val, maxval, ...) {
        if (val <= 0) {
            return vararg[0];
        } else if (val >= maxval) {
            return vararg[vararg.size - 1];
        }
        var_c0dabf48 = val * vararg.size / maxval;
        var_c0dabf48 -= 1;
        colorindex = int(var_c0dabf48);
        colorfrac = var_c0dabf48 - colorindex;
        return vectorlerp(vararg[colorindex], vararg[colorindex + 1], colorfrac);
    }

    // Namespace bot/bot
    // Params 0, eflags: 0x0
    // Checksum 0x3263f31b, Offset: 0x3848
    // Size: 0x138
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
// Params 0, eflags: 0x1 linked
// Checksum 0x7540c394, Offset: 0x3988
// Size: 0x32
function function_e5d7f472() {
    return isdefined(self.bot.revivetarget) && isdefined(self.bot.revivetarget.revivetrigger);
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0xe12f20c7, Offset: 0x39c8
// Size: 0x12
function get_revive_target() {
    return self.bot.revivetarget;
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x2bf1271d, Offset: 0x39e8
// Size: 0x32
function function_85bfe6d3() {
    if (isdefined(self.bot.revivetarget)) {
        return self.bot.revivetarget.revivetrigger;
    }
    return undefined;
}

// Namespace bot/bot
// Params 1, eflags: 0x1 linked
// Checksum 0x2c12e41f, Offset: 0x3a28
// Size: 0x1e
function set_revive_target(target) {
    self.bot.revivetarget = target;
}

// Namespace bot/bot
// Params 0, eflags: 0x1 linked
// Checksum 0x70e912e0, Offset: 0x3a50
// Size: 0x12
function clear_revive_target() {
    self.bot.revivetarget = undefined;
}

