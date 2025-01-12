#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\system_shared;

#namespace bot_stance;

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x2
// Checksum 0xa565ace2, Offset: 0xc8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"bot_stance", &__init__, undefined, undefined);
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0x47f79b26, Offset: 0x110
// Size: 0x31c
function __init__() {
    level.var_d3d5b0db = [];
    level.botstances = [];
    register_handler(#"default", &handle_default);
    register_handler(#"hash_2405aec12988c1f7", &function_6b9e09a6);
    register_handler(#"hash_ca2f8909b847c6f", &function_c35af938);
    register_handler(#"hash_7a468797a3a33424", &function_56927e7);
    register_handler(#"hash_2ebb09bf5581043d", &function_34fd0cec);
    register_handler(#"hash_3173f482acc24ec8", &function_bd905eb1);
    register_handler(#"sprint_set", &function_fd08f5f);
    register_handler(#"sprint_set", &function_fd08f5f);
    register_handler(#"hash_59db68c04af7aab5", &function_54dd3faa);
    register_handler(#"hash_51f609ea675fecde", &function_936f033d);
    register_handler(#"hash_21f619ce507cec96", &function_e2613805);
    register_stance(#"stand", &stand);
    register_stance(#"sprint", &sprint);
    register_stance(#"crouch", &crouch);
    register_stance(#"prone", &prone);
    register_stance(#"slide", &slide);
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0x14c3ea93, Offset: 0x438
// Size: 0x42
function start() {
    self thread handle_path_success();
    self thread handle_goal_reached();
    self.bot.var_aa7144a7 = undefined;
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0xa86af86, Offset: 0x488
// Size: 0x16
function stop() {
    self notify(#"hash_399ca08ed5c94410");
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0x783bdbe5, Offset: 0x4a8
// Size: 0x16
function reset() {
    self.bot.var_359e0919 = 0;
}

// Namespace bot_stance/bot_stance
// Params 1, eflags: 0x0
// Checksum 0x8ebee546, Offset: 0x4c8
// Size: 0x92
function update(tacbundle) {
    if (self.bot.var_359e0919 > gettime()) {
        return;
    }
    /#
        self bot::record_text("<dev string:x30>", (1, 1, 0), "<dev string:x42>");
    #/
    self function_e2fa90e2(tacbundle);
    self.bot.var_359e0919 = bot::function_905773a(0.4, 1);
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0x362663e7, Offset: 0x568
// Size: 0x86
function handle_path_success() {
    self endon(#"death");
    self endon(#"hash_399ca08ed5c94410");
    level endon(#"game_ended");
    while (isdefined(self.bot)) {
        self waittill(#"bot_path_success");
        if (!isbot(self)) {
            return;
        }
        self.bot.var_359e0919 = 0;
    }
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0x6ed08aa3, Offset: 0x5f8
// Size: 0x86
function handle_goal_reached() {
    self endon(#"death");
    self endon(#"hash_399ca08ed5c94410");
    level endon(#"game_ended");
    while (isdefined(self.bot)) {
        self waittill(#"bot_goal_reached");
        if (!isbot(self)) {
            return;
        }
        self.bot.var_359e0919 = 0;
    }
}

// Namespace bot_stance/bot_stance
// Params 2, eflags: 0x0
// Checksum 0x8b7c69fc, Offset: 0x688
// Size: 0x2a
function register_handler(name, func) {
    level.var_d3d5b0db[name] = func;
}

// Namespace bot_stance/bot_stance
// Params 2, eflags: 0x0
// Checksum 0x3d517b5, Offset: 0x6c0
// Size: 0x2a
function register_stance(name, func) {
    level.botstances[name] = func;
}

// Namespace bot_stance/bot_stance
// Params 1, eflags: 0x0
// Checksum 0x72e56995, Offset: 0x6f8
// Size: 0x1a4
function function_e2fa90e2(tacbundle) {
    var_ef8d8c4f = tacbundle.stationarystancehandlerlist;
    if (self haspath()) {
        var_ef8d8c4f = tacbundle.movingstancehandlerlist;
    }
    if (!isdefined(var_ef8d8c4f)) {
        /#
            self bot::record_text("<dev string:x53>", (1, 0, 0), "<dev string:x42>");
        #/
        return;
    }
    pixbeginevent(#"bot_stance_update");
    aiprofile_beginentry("bot_stance_update");
    handled = 0;
    node = self bot::get_position_node();
    foreach (params in var_ef8d8c4f) {
        if (self function_541dea78(tacbundle, params, node)) {
            self.bot.var_aa7144a7 = params.name;
            handled = 1;
            break;
        }
    }
    pixendevent();
    aiprofile_endentry();
}

// Namespace bot_stance/bot_stance
// Params 3, eflags: 0x0
// Checksum 0x3567621c, Offset: 0x8a8
// Size: 0x168
function function_541dea78(tacbundle, params, node) {
    if (!isdefined(params)) {
        return 0;
    }
    func = level.var_d3d5b0db[params.name];
    if (!isdefined(func)) {
        /#
            self botprinterror("<dev string:x68>" + function_15979fa9(params.name));
        #/
        return 0;
    }
    /#
        self bot::record_text(function_15979fa9(params.name), (1, 1, 1), "<dev string:x42>");
    #/
    pixbeginevent("bot_stance_handler: " + params.name);
    aiprofile_beginentry("bot_stance_handler: " + params.name);
    handled = self [[ func ]](tacbundle, params, node);
    pixendevent();
    aiprofile_endentry();
    return handled;
}

// Namespace bot_stance/bot_stance
// Params 1, eflags: 0x0
// Checksum 0x9e56de0b, Offset: 0xa18
// Size: 0xbe
function function_996d9c49(name) {
    if (!isdefined(name)) {
        return false;
    }
    func = level.botstances[name];
    if (!isdefined(func)) {
        /#
            self botprinterror("<dev string:x88>" + function_15979fa9(name));
        #/
        return false;
    }
    /#
        self bot::record_text("<dev string:xa0>" + function_15979fa9(name), (1, 1, 0), "<dev string:x42>");
    #/
    self [[ func ]]();
    return true;
}

// Namespace bot_stance/bot_stance
// Params 3, eflags: 0x0
// Checksum 0x98018858, Offset: 0xae0
// Size: 0x3a
function handle_default(tacbundle, params, node) {
    return self function_996d9c49(params.stance);
}

// Namespace bot_stance/bot_stance
// Params 3, eflags: 0x0
// Checksum 0xd99b6da6, Offset: 0xb28
// Size: 0x11a
function function_6b9e09a6(tacbundle, params, node) {
    if (!isdefined(node)) {
        /#
            self bot::record_text("<dev string:xa3>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (!iscrouchcovernode(node)) {
        /#
            self bot::record_text("<dev string:xb1>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (self bot::in_combat() && !self iscovervalid(node)) {
        /#
            self bot::record_text("<dev string:xc7>", (1, 0, 0), "<dev string:x42>");
        #/
    }
    return self function_996d9c49(params.stance);
}

// Namespace bot_stance/bot_stance
// Params 3, eflags: 0x0
// Checksum 0x19a6def9, Offset: 0xc50
// Size: 0x11a
function function_c35af938(tacbundle, params, node) {
    if (!isdefined(node)) {
        /#
            self bot::record_text("<dev string:xa3>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (!isstandcovernode(node)) {
        /#
            self bot::record_text("<dev string:xd8>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (self bot::in_combat() && !self iscovervalid(node)) {
        /#
            self bot::record_text("<dev string:xc7>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    return self function_996d9c49(params.stance);
}

// Namespace bot_stance/bot_stance
// Params 3, eflags: 0x0
// Checksum 0x4054bbaf, Offset: 0xd78
// Size: 0x11a
function function_56927e7(tacbundle, params, node) {
    if (!isdefined(node)) {
        /#
            self bot::record_text("<dev string:xa3>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (!isfullcovernode(node)) {
        /#
            self bot::record_text("<dev string:xed>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (self bot::in_combat() && !self iscovervalid(node)) {
        /#
            self bot::record_text("<dev string:xc7>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    return self function_996d9c49(params.stance);
}

// Namespace bot_stance/bot_stance
// Params 3, eflags: 0x0
// Checksum 0x354a2fb2, Offset: 0xea0
// Size: 0x182
function function_34fd0cec(tacbundle, params, node) {
    if (!isdefined(self.enemy)) {
        /#
            self bot::record_text("<dev string:x101>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (!isdefined(node)) {
        /#
            self bot::record_text("<dev string:xa3>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (!isstandcovernode(node)) {
        /#
            self bot::record_text("<dev string:xd8>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (self bot::in_combat() && !self iscovervalid(node)) {
        /#
            self bot::record_text("<dev string:xc7>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (!self bot::function_34f76f34(tacbundle, "bot_recordStance")) {
        return 0;
    }
    return self function_996d9c49(params.stance);
}

// Namespace bot_stance/bot_stance
// Params 3, eflags: 0x0
// Checksum 0xe0670146, Offset: 0x1030
// Size: 0x162
function function_bd905eb1(tacbundle, params, node) {
    if (!isdefined(node)) {
        /#
            self bot::record_text("<dev string:xa3>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (!(node.spawnflags & 8)) {
        /#
            self bot::record_text("<dev string:x10c>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (node.spawnflags & 4) {
        /#
            self bot::record_text("<dev string:x125>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (self bot::in_combat() && !self iscovervalid(node)) {
        /#
            self bot::record_text("<dev string:xc7>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    return self function_996d9c49(params.stance);
}

// Namespace bot_stance/bot_stance
// Params 3, eflags: 0x0
// Checksum 0x6c55a6ca, Offset: 0x11a0
// Size: 0xda
function function_fd08f5f(tacbundle, params, node) {
    if (!self ai::has_behavior_attribute("sprint")) {
        /#
            self bot::record_text("<dev string:x139>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (!self ai::get_behavior_attribute("sprint")) {
        /#
            self bot::record_text("<dev string:x14f>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    return self function_996d9c49(params.stance);
}

// Namespace bot_stance/bot_stance
// Params 3, eflags: 0x0
// Checksum 0x76e29d0f, Offset: 0x1288
// Size: 0x212
function function_54dd3faa(tacbundle, params, node) {
    if (self issprinting()) {
        /#
            self bot::record_text("<dev string:x16a>", (1, 1, 0), "<dev string:x42>");
        #/
        return 1;
    }
    if (isdefined(tacbundle.sprintdist)) {
        var_9a1c37c1 = self function_28dbe634();
        movepoint = self.goalpos;
        if (isdefined(var_9a1c37c1) && isdefined(var_9a1c37c1.var_92706ab9)) {
            movepoint = var_9a1c37c1.var_92706ab9;
        } else if (isdefined(self.overridegoalpos)) {
            movepoint = self.overridegoalpos;
        }
        distsq = distance2dsquared(self.origin, movepoint);
        var_4846ae59 = tacbundle.sprintdist * tacbundle.sprintdist;
        if (distsq < var_4846ae59) {
            /#
                self bot::record_text("<dev string:x17b>", (1, 0, 0), "<dev string:x42>");
            #/
            return 0;
        }
    }
    dir = self getnormalizedmovement();
    if (vectordot(dir, (1, 0, 0)) < 0.82) {
        /#
            self bot::record_text("<dev string:x196>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    return self function_996d9c49(params.stance);
}

// Namespace bot_stance/bot_stance
// Params 3, eflags: 0x0
// Checksum 0x7ed363ff, Offset: 0x14a8
// Size: 0x31a
function function_936f033d(tacbundle, params, node) {
    if (!self ai::get_behavior_attribute("slide")) {
        /#
            self bot::record_text("<dev string:x1ab>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (self issliding()) {
        /#
            self bot::record_text("<dev string:x1c5>", (1, 1, 0), "<dev string:x42>");
        #/
        return 1;
    }
    if (!self issprinting()) {
        /#
            self bot::record_text("<dev string:x1d4>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (isdefined(tacbundle.var_35e9ad34) && isdefined(tacbundle.var_b2fe6b2a)) {
        var_9a1c37c1 = self function_28dbe634();
        movepoint = self.goalpos;
        if (isdefined(var_9a1c37c1) && isdefined(var_9a1c37c1.var_92706ab9)) {
            movepoint = var_9a1c37c1.var_92706ab9;
        } else if (isdefined(self.overridegoalpos)) {
            movepoint = self.overridegoalpos;
        }
        distsq = distance2dsquared(self.origin, movepoint);
        var_7e5441cc = tacbundle.var_35e9ad34 * tacbundle.var_35e9ad34;
        var_cf35b6c6 = tacbundle.var_b2fe6b2a * tacbundle.var_b2fe6b2a;
        if (distsq < var_7e5441cc) {
            /#
                self bot::record_text("<dev string:x17b>", (1, 0, 0), "<dev string:x42>");
            #/
            return 0;
        }
        if (distsq > var_cf35b6c6) {
            /#
                self bot::record_text("<dev string:x1e4>", (1, 0, 0), "<dev string:x42>");
            #/
            return 0;
        }
    }
    dir = self getnormalizedmovement();
    if (vectordot(dir, (1, 0, 0)) < 0.82) {
        /#
            self bot::record_text("<dev string:x196>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    return self function_996d9c49(params.stance);
}

// Namespace bot_stance/bot_stance
// Params 3, eflags: 0x0
// Checksum 0xc958aca9, Offset: 0x17d0
// Size: 0x39a
function function_e2613805(tacbundle, params, node) {
    if (!self ai::get_behavior_attribute("slide")) {
        /#
            self bot::record_text("<dev string:x1ab>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (self issliding()) {
        /#
            self bot::record_text("<dev string:x1c5>", (1, 1, 0), "<dev string:x42>");
        #/
        return 1;
    }
    if (!self issprinting()) {
        /#
            self bot::record_text("<dev string:x1d4>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (!isdefined(node) || !iscovernode(node)) {
        /#
            self bot::record_text("<dev string:x1ff>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    if (isdefined(self function_28dbe634())) {
        /#
            self bot::record_text("<dev string:x219>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    distsq = distance2dsquared(self.origin, node.origin);
    mindistsq = isdefined(tacbundle.var_35e9ad34) ? tacbundle.var_35e9ad34 : 0;
    mindistsq *= mindistsq;
    if (distsq < mindistsq) {
        /#
            self bot::record_text("<dev string:x238>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    maxdistsq = isdefined(tacbundle.var_b2fe6b2a) ? tacbundle.var_b2fe6b2a : 0;
    maxdistsq *= maxdistsq;
    if (distsq > maxdistsq) {
        /#
            self bot::record_text("<dev string:x24c>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    mindot = isdefined(tacbundle.var_f6ca3bf3) ? tacbundle.var_f6ca3bf3 : 0;
    dir = vectornormalize(node.origin - self.origin);
    if (vectordot(dir, anglestoforward(node.angles)) <= mindot) {
        /#
            self bot::record_text("<dev string:x260>", (1, 0, 0), "<dev string:x42>");
        #/
        return 0;
    }
    return self function_996d9c49(params.stance);
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0x2bd1ed63, Offset: 0x1b78
// Size: 0x64
function sprint() {
    self botpressbutton(1);
    self botreleasebutton(9);
    self botreleasebutton(8);
    self botreleasebutton(39);
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0xb31e3e3b, Offset: 0x1be8
// Size: 0x64
function stand() {
    self botreleasebutton(1);
    self botreleasebutton(9);
    self botreleasebutton(8);
    self botreleasebutton(39);
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0xfcd3f9f, Offset: 0x1c58
// Size: 0x64
function crouch() {
    self botreleasebutton(1);
    self botpressbutton(9);
    self botreleasebutton(8);
    self botreleasebutton(39);
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0x6a7072c0, Offset: 0x1cc8
// Size: 0x64
function prone() {
    self botreleasebutton(1);
    self botreleasebutton(9);
    self botpressbutton(8);
    self botreleasebutton(39);
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0x207c2523, Offset: 0x1d38
// Size: 0x64
function slide() {
    self botreleasebutton(1);
    self botreleasebutton(9);
    self botreleasebutton(8);
    self bottapbutton(39);
}

