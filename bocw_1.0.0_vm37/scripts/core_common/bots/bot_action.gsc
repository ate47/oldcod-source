#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_actions;
#using scripts\core_common\bots\bot_weapons;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;

#namespace bot_action;

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xab812c41, Offset: 0x130
// Size: 0x5c
function preinit() {
    level.botactions = [];
    level.botweapons = [];
    bot_actions::preinit();
    bot_weapons::preinit();
    callback::on_player_killed(&on_player_killed);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x4
// Checksum 0x796127da, Offset: 0x198
// Size: 0x6a
function private on_player_killed(*params) {
    if (!isstruct(self.bot)) {
        return;
    }
    self clear();
    self.bot.actionparam = undefined;
    self.bot.var_e6a1f475 = undefined;
    self.bot.var_ceffa180 = undefined;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x7467f324, Offset: 0x210
// Size: 0xf6
function think() {
    pixbeginevent(#"");
    var_41fcf220 = self.bot.actionparams;
    actionparams = self function_9e181b0f();
    if (isdefined(actionparams) && isdefined(var_41fcf220) && actionparams == var_41fcf220) {
        self notify(#"hash_77f2882ff9140e86");
        profilestop();
        return;
    }
    self notify(#"hash_1ae115949cd752c8");
    self.bot.actionparams = undefined;
    clear();
    if (isdefined(actionparams)) {
        self.bot.actionparams = actionparams;
        self thread [[ actionparams.action.executefunc ]](actionparams);
    }
    profilestop();
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x1315c514, Offset: 0x310
// Size: 0xa6
function clear() {
    self.bot.var_87751145 = undefined;
    self.bot.var_2d563ebf = undefined;
    self.bot.var_f50fa466 = undefined;
    self.bot.var_32d8dabe = undefined;
    self.bot.var_d70788cb = undefined;
    self.bot.shoottime = undefined;
    self.bot.var_6bea1d82 = undefined;
    self.bot.var_9cf66413 = undefined;
    self.bot.var_ce28855b = undefined;
    /#
        self.bot.var_9e5aaf8d = undefined;
    #/
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x2f9c65ab, Offset: 0x3c0
// Size: 0x70
function function_a0b0f487(actionparams) {
    if (self arecontrolsfrozen() || self function_5972c3cf()) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_329792b380cfd409";
        #/
        return true;
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xfe5c718d, Offset: 0x438
// Size: 0x58
function function_2c3ea0c6(actionparams) {
    if (self isplayinganimscripted()) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_5cbefc6b234455fc";
        #/
        return true;
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xba277a37, Offset: 0x498
// Size: 0x58
function in_vehicle(actionparams) {
    if (self isinvehicle()) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_74dd6cdecdd53e96";
        #/
        return true;
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x55cc5963, Offset: 0x4f8
// Size: 0x50
function function_ed7b2f42(actionparams) {
    if (isdefined(self.bot.traversal)) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_17222d5087946703";
        #/
        return true;
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x304f0bb3, Offset: 0x550
// Size: 0x48
function function_a43bc7e2(actionparams) {
    if (self.ignoreall) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_5a308775df684ba1";
        #/
        return true;
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xdce5f21d, Offset: 0x5a0
// Size: 0x70
function in_combat(actionparams) {
    if (self.combatstate == #"combat_state_in_combat" || self.combatstate == #"combat_state_has_visible_enemy") {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_6c8a68a6b0ba3e46";
        #/
        return true;
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x18b4ff4c, Offset: 0x618
// Size: 0x48
function just_spawned(actionparams) {
    if (self.spawntime >= gettime()) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_5080fb7f9d457021";
        #/
        return true;
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xf20b7bc0, Offset: 0x668
// Size: 0x50
function flashed(actionparams) {
    if (self.bot.flashed) {
        /#
            actionparams.debug[actionparams.debug.size] = #"flashed";
        #/
        return true;
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xa3d2f413, Offset: 0x6c0
// Size: 0xa0
function function_ebb8205b(actionparams) {
    if (self isinexecutionvictim()) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_6ad5723518a9aa59";
        #/
        return true;
    } else if (self isinexecutionattack()) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_21cc6a6be1e0b67";
        #/
        return true;
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x0
// Checksum 0xa9d5a002, Offset: 0x768
// Size: 0x54
function register_action(name, weightfunc, executefunc) {
    level.botactions[name] = {#weightfunc:weightfunc, #executefunc:executefunc};
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x0
// Checksum 0xb2da32ca, Offset: 0x7c8
// Size: 0x90
function register_weapon(weaponname, weightfunc, executefunc) {
    weapon = getweapon(weaponname);
    if (weapon.name == #"none") {
        return;
    }
    level.botweapons[weapon.name] = {#weightfunc:weightfunc, #executefunc:executefunc};
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x4
// Checksum 0x1ea4914f, Offset: 0x860
// Size: 0x1f0
function private function_daafd48c(&paramslist) {
    pixbeginevent(#"");
    var_6577f082 = self.bot.actionparams;
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        action = level.botweapons[weapon.name];
        if (!isstruct(action) || !isfunctionptr(action.weightfunc) && !isfunctionptr(action.executefunc)) {
            continue;
        }
        actionparams = undefined;
        if (isdefined(var_6577f082) && var_6577f082.action == action && var_6577f082.weapon == weapon) {
            actionparams = var_6577f082;
        } else {
            actionparams = {#action:action, #weapon:weapon};
        }
        /#
            actionparams.name = getweaponname(weapon);
            actionparams.debug = [];
        #/
        paramslist[paramslist.size] = actionparams;
    }
    profilestop();
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x4
// Checksum 0x1374d397, Offset: 0xa58
// Size: 0x120
function private function_f692725c(&paramslist) {
    pixbeginevent(#"");
    var_6577f082 = self.bot.actionparams;
    foreach (name, action in level.botactions) {
        actionparams = undefined;
        if (isdefined(var_6577f082) && var_6577f082.action == action) {
            actionparams = var_6577f082;
        } else {
            actionparams = {#action:action};
        }
        /#
            actionparams.name = name;
            actionparams.debug = [];
        #/
        paramslist[paramslist.size] = actionparams;
    }
    profilestop();
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x4
// Checksum 0xbc12fab4, Offset: 0xb80
// Size: 0x224
function private function_9e181b0f() {
    pixbeginevent(#"");
    if (isdefined(self.bot.var_e6a1f475)) {
        endtime = self.bot.var_ceffa180;
        if (!isdefined(endtime) || endtime > gettime()) {
            params = self.bot.var_e6a1f475;
            /#
                record3dtext("<dev string:x38>" + function_9e72a96(params.name) + "<dev string:x3e>", self.origin, (1, 0, 1), "<dev string:x4a>", self, 0.5);
                if (isdefined(params.weapon)) {
                    clipammo = self getweaponammoclip(params.weapon);
                    stockammo = self getweaponammostock(params.weapon);
                    record3dtext("<dev string:x54>" + clipammo + "<dev string:x61>" + params.weapon.clipsize + "<dev string:x66>" + stockammo, self.origin, (1, 0, 1), "<dev string:x4a>", self, 0.5);
                }
            #/
            profilestop();
            return params;
        }
        self.bot.var_e6a1f475 = undefined;
        self.bot.var_ceffa180 = undefined;
    }
    paramslist = [];
    self function_daafd48c(paramslist);
    self function_f692725c(paramslist);
    var_3a4035f3 = self weight_actions(paramslist);
    profilestop();
    return var_3a4035f3;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x4
// Checksum 0xfe4e5998, Offset: 0xdb0
// Size: 0x4ba
function private weight_actions(&paramslist) {
    pixbeginevent(#"");
    var_3a4035f3 = undefined;
    bestweight = undefined;
    foreach (actionparams in paramslist) {
        pixbeginevent(#"");
        actionparams.weight = self [[ actionparams.action.weightfunc ]](actionparams);
        profilestop();
        if (!isdefined(actionparams.weight)) {
            continue;
        }
        if (!isdefined(var_3a4035f3) || actionparams.weight > bestweight) {
            var_3a4035f3 = actionparams;
            bestweight = actionparams.weight;
        }
    }
    /#
        if (self bot::should_record("<dev string:x6d>")) {
            if (!isdefined(var_3a4035f3)) {
                record3dtext("<dev string:x81>", self.origin, (1, 0, 1), "<dev string:x4a>", self, 0.5);
            }
            sortedlist = [];
            foreach (actionparams in paramslist) {
                if (!isdefined(actionparams.weight)) {
                    sortedlist[sortedlist.size] = actionparams;
                    continue;
                }
                for (i = 0; i < sortedlist.size; i++) {
                    var_fd5e06c8 = sortedlist[i].weight;
                    if (!isdefined(var_fd5e06c8) || var_fd5e06c8 < actionparams.weight) {
                        break;
                    }
                }
                arrayinsert(sortedlist, actionparams, i);
            }
            foreach (actionparams in sortedlist) {
                color = (0.75, 0.75, 0.75);
                headerstr = "<dev string:x90>";
                recordweight = "<dev string:x90>";
                if (isdefined(actionparams.weight)) {
                    color = bot::map_color(actionparams.weight, 100, (1, 0, 0), (1, 0.5, 0), (1, 1, 0), (0, 1, 0));
                    recordweight = actionparams.weight;
                    if (actionparams === var_3a4035f3) {
                        headerstr = "<dev string:x95>";
                    } else {
                        headerstr = "<dev string:x9a>";
                    }
                }
                record3dtext(headerstr + function_9e72a96(actionparams.name) + "<dev string:x9f>" + recordweight, self.origin, color, "<dev string:x4a>", self, 0.5);
                foreach (entry in actionparams.debug) {
                    record3dtext("<dev string:xa5>" + function_9e72a96(entry), self.origin, color, "<dev string:x4a>", self, 0.5);
                }
            }
        }
    #/
    profilestop();
    return var_3a4035f3;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x3a12c7bd, Offset: 0x1278
// Size: 0xaa
function function_d6318084(weapon) {
    action = level.botweapons[weapon.name];
    if (!isdefined(action) || !isfunctionptr(action.executefunc)) {
        return;
    }
    /#
        name = getweaponname(weapon);
    #/
    self function_2a2a2cd2(name, action, weapon);
    self.bot.var_ceffa180 = undefined;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x1a32bbbf, Offset: 0x1330
// Size: 0x4a
function function_32020adf(delaysec = undefined) {
    self.bot.var_ceffa180 = gettime() + int(delaysec * 1000);
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x4
// Checksum 0xd5d88b54, Offset: 0x1388
// Size: 0xe2
function private function_2a2a2cd2(name, action, weapon = undefined) {
    actionparams = {#action:action, #weapon:weapon};
    eye = self.origin + (0, 0, self getplayerviewheight());
    actionparams.aimorigin = eye + 128 * anglestoforward(self.angles);
    /#
        actionparams.name = name;
        actionparams.weight = "<dev string:xac>";
    #/
    self.bot.var_e6a1f475 = actionparams;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xf21f3a18, Offset: 0x1478
// Size: 0x594
function function_2a24a928() {
    potentialtargets = [];
    if (isdefined(level.spawneduavs)) {
        foreach (uav in level.spawneduavs) {
            if (isdefined(uav) && util::function_fbce7263(uav.team, self.team)) {
                potentialtargets[potentialtargets.size] = uav;
            }
        }
    }
    if (isdefined(level.counter_uav_entities)) {
        foreach (cuav in level.counter_uav_entities) {
            if (isdefined(cuav) && util::function_fbce7263(cuav.team, self.team)) {
                potentialtargets[potentialtargets.size] = cuav;
            }
        }
    }
    choppers = getentarray("chopper", "targetName");
    if (isdefined(choppers)) {
        foreach (chopper in choppers) {
            if (isdefined(chopper) && util::function_fbce7263(chopper.team, self.team)) {
                potentialtargets[potentialtargets.size] = chopper;
            }
        }
    }
    planes = getentarray("strafePlane", "targetName");
    if (isdefined(planes)) {
        foreach (plane in planes) {
            if (isdefined(plane) && util::function_fbce7263(plane.team, self.team)) {
                potentialtargets[potentialtargets.size] = plane;
            }
        }
    }
    if (isdefined(level.ac130) && util::function_fbce7263(level.ac130.team, self.team)) {
        potentialtargets[potentialtargets.size] = level.ac130;
    }
    if (potentialtargets.size == 0) {
        return undefined;
    }
    var_137299d = [];
    var_7607a546 = getclosesttacpoint(self.origin);
    if (isdefined(var_7607a546)) {
        foreach (target in potentialtargets) {
            if (issentient(target)) {
                if (!isdefined(target.var_e38e137f) || !isdefined(target.var_e38e137f[self getentitynumber()])) {
                    target.var_e38e137f[self getentitynumber()] = randomfloat(1) < (isdefined(self.bot.tacbundle.var_d1fb2f1a) ? self.bot.tacbundle.var_d1fb2f1a : 0);
                }
                if (!target.var_e38e137f[self getentitynumber()]) {
                    continue;
                }
                if (function_96c81b85(var_7607a546, target.origin)) {
                    var_137299d[var_137299d.size] = target;
                }
            }
        }
    }
    if (var_137299d.size == 0) {
        return undefined;
    }
    var_1f5c2eac = util::get_array_of_closest(self.origin, var_137299d);
    return var_1f5c2eac[0];
}

