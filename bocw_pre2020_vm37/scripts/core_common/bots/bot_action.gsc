#using script_4e44ad88a2b0f559;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_actions;
#using scripts\core_common\bots\bot_position;
#using scripts\core_common\bots\bot_weapons;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;

#namespace bot_action;

// Namespace bot_action/bot_action
// Params 0, eflags: 0x1 linked
// Checksum 0x6868a33b, Offset: 0xe8
// Size: 0x5c
function function_70a657d8() {
    level.botactions = [];
    level.botweapons = [];
    namespace_eed5a117::function_70a657d8();
    namespace_d9f3dd47::function_70a657d8();
    callback::on_player_killed(&on_player_killed);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x5 linked
// Checksum 0xa23f138a, Offset: 0x150
// Size: 0x56
function private on_player_killed(*params) {
    if (!isstruct(self.bot)) {
        return;
    }
    self.bot.actionparam = undefined;
    self.bot.var_e6a1f475 = undefined;
    self.bot.var_ceffa180 = undefined;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x1 linked
// Checksum 0x32da089d, Offset: 0x1b0
// Size: 0x11c
function think() {
    actionparams = self function_9e181b0f();
    if (isdefined(actionparams)) {
        if (self function_6082c8d3(actionparams)) {
            self notify(#"hash_77f2882ff9140e86");
            return;
        }
        self notify(#"hash_1ae115949cd752c8");
        self.bot.actionparams = actionparams;
        self namespace_87549638::clear();
        self bot_position::clear();
        self thread [[ actionparams.action.executefunc ]](actionparams);
        return;
    }
    self notify(#"hash_1ae115949cd752c8");
    self.bot.actionparams = undefined;
    self namespace_87549638::clear();
    self bot_position::clear();
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x5 linked
// Checksum 0xdce3bf48, Offset: 0x2d8
// Size: 0x5a
function private function_6082c8d3(var_df4ec816) {
    var_1e1a049a = self.bot.actionparams;
    return isdefined(var_1e1a049a) && var_1e1a049a.action == var_df4ec816.action && var_1e1a049a.weapon === var_df4ec816.weapon;
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x1 linked
// Checksum 0x80581e97, Offset: 0x340
// Size: 0x54
function register_action(name, weightfunc, executefunc) {
    level.botactions[name] = {#weightfunc:weightfunc, #executefunc:executefunc};
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x1 linked
// Checksum 0xc2e73084, Offset: 0x3a0
// Size: 0x90
function register_weapon(weaponname, weightfunc, executefunc) {
    weapon = getweapon(weaponname);
    if (weapon.name == #"none") {
        return;
    }
    level.botweapons[weapon.name] = {#weightfunc:weightfunc, #executefunc:executefunc};
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x5 linked
// Checksum 0xca8a56b6, Offset: 0x438
// Size: 0x186
function private function_daafd48c(&paramslist) {
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        action = level.botweapons[weapon.name];
        if (!isstruct(action) || !isfunctionptr(action.weightfunc) && !isfunctionptr(action.executefunc)) {
            continue;
        }
        actionparams = {#action:action, #weapon:weapon};
        /#
            actionparams.name = getweaponname(weapon);
            actionparams.debug = [];
        #/
        paramslist[paramslist.size] = actionparams;
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x5 linked
// Checksum 0x424cbec8, Offset: 0x5c8
// Size: 0xc6
function private function_f692725c(&paramslist) {
    foreach (name, action in level.botactions) {
        actionparams = {#action:action};
        /#
            actionparams.name = name;
            actionparams.debug = [];
        #/
        paramslist[paramslist.size] = actionparams;
    }
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x5 linked
// Checksum 0x778675db, Offset: 0x698
// Size: 0x212
function private function_9e181b0f() {
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
            return params;
        }
        self.bot.var_e6a1f475 = undefined;
        self.bot.var_ceffa180 = undefined;
    }
    paramslist = [];
    self function_daafd48c(paramslist);
    self function_f692725c(paramslist);
    var_3a4035f3 = self weight_actions(paramslist);
    return var_3a4035f3;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x5 linked
// Checksum 0xb63f7724, Offset: 0x8b8
// Size: 0x520
function private weight_actions(&paramslist) {
    pixbeginevent(#"bot_weight_actions");
    aiprofile_beginentry("bot_weight_actions");
    var_3a4035f3 = undefined;
    bestweight = undefined;
    foreach (actionparams in paramslist) {
        actionparams.weight = self [[ actionparams.action.weightfunc ]](actionparams);
        if (!isdefined(actionparams.weight)) {
            continue;
        }
        if (!isdefined(var_3a4035f3) || actionparams.weight > bestweight) {
            var_3a4035f3 = actionparams;
            bestweight = actionparams.weight;
        }
    }
    pixendevent();
    aiprofile_endentry();
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
                        if (self function_6082c8d3(actionparams)) {
                            recordweight = self.bot.actionparams.weight + "<dev string:x9a>" + recordweight;
                        }
                    } else {
                        headerstr = "<dev string:xa2>";
                    }
                }
                record3dtext(headerstr + function_9e72a96(actionparams.name) + "<dev string:xa7>" + recordweight, self.origin, color, "<dev string:x4a>", self, 0.5);
                foreach (entry in actionparams.debug) {
                    record3dtext("<dev string:xad>" + entry, self.origin, color, "<dev string:x4a>", self, 0.5);
                }
            }
        }
    #/
    return var_3a4035f3;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x76279159, Offset: 0xde0
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
// Checksum 0x50200105, Offset: 0xe98
// Size: 0x4a
function function_32020adf(delaysec = undefined) {
    self.bot.var_ceffa180 = gettime() + int(delaysec * 1000);
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x5 linked
// Checksum 0x5cbb5b8, Offset: 0xef0
// Size: 0xe2
function private function_2a2a2cd2(name, action, weapon = undefined) {
    actionparams = {#action:action, #weapon:weapon};
    eye = self.origin + (0, 0, self getplayerviewheight());
    actionparams.var_94a7f067 = eye + 128 * anglestoforward(self.angles);
    /#
        actionparams.name = name;
        actionparams.weight = "<dev string:xb4>";
    #/
    self.bot.var_e6a1f475 = actionparams;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x4685fe15, Offset: 0xfe0
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
