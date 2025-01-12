#using script_4e44ad88a2b0f559;
#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_position;

#namespace namespace_eed5a117;

// Namespace namespace_eed5a117/namespace_eed5a117
// Params 0, eflags: 0x1 linked
// Checksum 0x21381719, Offset: 0xa0
// Size: 0x5a
function function_70a657d8() {
    if (!isdefined(level.gametype)) {
        return;
    }
    switch (level.gametype) {
    default:
        function_9cefb01();
        break;
    }
}

// Namespace namespace_eed5a117/namespace_eed5a117
// Params 0, eflags: 0x5 linked
// Checksum 0x1586be80, Offset: 0x108
// Size: 0xec
function private function_9cefb01() {
    bot_action::register_action("Reload", &function_61e53840, &reload);
    if ((isdefined(getgametypesetting(#"allowlaststandforactiveclients")) ? getgametypesetting(#"allowlaststandforactiveclients") : 0) || getdvarint(#"g_allowlaststandforactiveclients", 0)) {
        bot_action::register_action("Revive", &function_5040c5b8, &revive);
    }
}

// Namespace namespace_eed5a117/namespace_eed5a117
// Params 1, eflags: 0x1 linked
// Checksum 0xe1637a3d, Offset: 0x200
// Size: 0x384
function function_61e53840(actionparams) {
    if (!self ai::get_behavior_attribute(#"reload")) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x38>" + function_9e72a96(#"reload") + "<dev string:x46>";
        #/
        return undefined;
    }
    weapon = self getcurrentweapon();
    /#
        actionparams.debug[actionparams.debug.size] = getweaponname(weapon);
    #/
    if (self isreloading()) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x54>";
        #/
        return 100;
    }
    if (weapon.iscliponly) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x63>";
        #/
        return undefined;
    }
    stockammo = self getweaponammostock(weapon);
    if (stockammo <= 0) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x70>";
        #/
        return undefined;
    }
    /#
        if (getdvarint(#"bot_forcefire", 0)) {
            /#
                actionparams.debug[actionparams.debug.size] = "<dev string:x81>";
            #/
            return undefined;
        }
        if (getdvarint(#"hash_7140b31f7170f18b", 0)) {
            /#
                actionparams.debug[actionparams.debug.size] = function_9e72a96(#"hash_7140b31f7170f18b") + "<dev string:x91>";
            #/
            return undefined;
        }
        if (is_true(self.bot.var_a0f96630[0])) {
            /#
                actionparams.debug[actionparams.debug.size] = "<dev string:x9e>";
            #/
            return undefined;
        }
    #/
    clipammo = self getweaponammoclip(weapon);
    var_1cc50542 = clipammo / weapon.clipsize;
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:xb6>" + var_1cc50542;
    #/
    if (var_1cc50542 >= 1) {
        return undefined;
    }
    if (self.bot.enemyvisible) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:xc6>";
        #/
        return undefined;
    }
    if (self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:xd7>";
        #/
        return undefined;
    }
    return 100 * (1 - var_1cc50542);
}

// Namespace namespace_eed5a117/namespace_eed5a117
// Params 1, eflags: 0x1 linked
// Checksum 0xbaa4d3c4, Offset: 0x590
// Size: 0xbe
function reload(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    while (true) {
        if (!self isreloading()) {
            self bottapbutton(4);
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_eed5a117/namespace_eed5a117
// Params 1, eflags: 0x1 linked
// Checksum 0xa47e3ed0, Offset: 0x658
// Size: 0x188
function function_5040c5b8(actionparams) {
    if (!self ai::get_behavior_attribute(#"revive")) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x38>" + function_9e72a96(#"revive") + "<dev string:x46>";
        #/
        return undefined;
    }
    revivetarget = self bot::get_revive_target();
    if (!isdefined(revivetarget)) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:xee>";
        #/
        return undefined;
    }
    actionparams.revivetarget = revivetarget;
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:x102>" + revivetarget.name;
    #/
    if (!isdefined(revivetarget.revivetrigger)) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x10e>";
        #/
        return undefined;
    }
    if (!self istouching(revivetarget.revivetrigger)) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x123>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_eed5a117/namespace_eed5a117
// Params 1, eflags: 0x1 linked
// Checksum 0x74808c2b, Offset: 0x7e8
// Size: 0x11e
function revive(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    player = actionparams.revivetarget;
    self bot_position::hold();
    while (true) {
        self namespace_87549638::function_aa7316c1(player.revivetrigger.origin);
        if (self botgetlookdot() > 0) {
            self bottapbutton(3);
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

