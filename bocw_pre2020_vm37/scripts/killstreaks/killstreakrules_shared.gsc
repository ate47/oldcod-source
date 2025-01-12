#using scripts\core_common\popups_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace killstreakrules;

// Namespace killstreakrules/killstreakrules_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x6cfba6, Offset: 0xa8
// Size: 0xb8
function init_shared() {
    val::register(#"killstreaksdisabled", 1, "$self", &function_4a433a3f, "$value");
    if (!isdefined(level.var_ef447a73)) {
        level.var_ef447a73 = {};
        level.killstreakrules = [];
        level.killstreaktype = [];
        level.var_dcc3befb = [];
        level.killstreaks_triggered = [];
        level.matchrecorderkillstreakkills = [];
        if (!isdefined(level.globalkillstreakscalled)) {
            level.globalkillstreakscalled = 0;
        }
    }
}

// Namespace killstreakrules/killstreakrules_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xfa0ff9d4, Offset: 0x168
// Size: 0x24
function function_4a433a3f(value) {
    self function_fe89725a(value);
}

// Namespace killstreakrules/killstreakrules_shared
// Params 6, eflags: 0x1 linked
// Checksum 0x91a9d2ad, Offset: 0x198
// Size: 0x132
function createrule(rule, maxallowable, maxallowableperteam, var_11c5ecfd, var_5b7d134, var_cc6f8ade) {
    level.killstreakrules[rule] = spawnstruct();
    level.killstreakrules[rule].cur = 0;
    level.killstreakrules[rule].curteam = [];
    level.killstreakrules[rule].max = maxallowable;
    level.killstreakrules[rule].maxperteam = maxallowableperteam;
    level.killstreakrules[rule].var_11c5ecfd = var_11c5ecfd;
    if (isdefined(var_11c5ecfd) && var_11c5ecfd != 0) {
        level.killstreakrules[rule].var_62a7c0b4 = var_5b7d134;
        level.killstreakrules[rule].var_ee52fece = var_cc6f8ade;
        level.killstreakrules[rule].var_8c2bb724 = [];
    }
}

// Namespace killstreakrules/killstreakrules_shared
// Params 5, eflags: 0x1 linked
// Checksum 0xfe4c561d, Offset: 0x2d8
// Size: 0x12c
function addkillstreaktorule(killstreak, rule, counttowards, checkagainst, inventoryvariant) {
    if (!isdefined(level.killstreaktype[killstreak])) {
        level.killstreaktype[killstreak] = [];
    }
    assert(isdefined(level.killstreakrules[rule]));
    if (!isdefined(level.killstreaktype[killstreak][rule])) {
        level.killstreaktype[killstreak][rule] = spawnstruct();
    }
    level.killstreaktype[killstreak][rule].counts = counttowards;
    level.killstreaktype[killstreak][rule].checks = checkagainst;
    if (!is_true(inventoryvariant)) {
        addkillstreaktorule("inventory_" + killstreak, rule, counttowards, checkagainst, 1);
    }
}

// Namespace killstreakrules/killstreakrules_shared
// Params 4, eflags: 0x1 linked
// Checksum 0xae7af8aa, Offset: 0x410
// Size: 0x3a8
function killstreakstart(hardpointtype, team, hacked, displayteammessage) {
    assert(isdefined(team), "<dev string:x38>");
    if (self iskillstreakallowed(hardpointtype, team) == 0) {
        return -1;
    }
    assert(isdefined(hardpointtype));
    if (!isdefined(hacked)) {
        hacked = 0;
    }
    if (!isdefined(displayteammessage)) {
        displayteammessage = 1;
    }
    if (displayteammessage == 1) {
        if (!hacked) {
            level thread popups::displaykillstreakteammessagetoall(hardpointtype, self);
        }
    }
    keys = getarraykeys(level.killstreaktype[hardpointtype]);
    killstreak_id = level.globalkillstreakscalled;
    foreach (key in keys) {
        if (!level.killstreaktype[hardpointtype][key].counts) {
            continue;
        }
        assert(isdefined(level.killstreakrules[key]));
        level.killstreakrules[key].cur++;
        if (level.teambased) {
            if (!isdefined(level.killstreakrules[key].curteam[team])) {
                level.killstreakrules[key].curteam[team] = 0;
            }
            level.killstreakrules[key].curteam[team]++;
        }
    }
    level notify(#"killstreak_started", {#killstreaktype:hardpointtype, #team:team, #attacker:self});
    level.globalkillstreakscalled++;
    var_5c07b36e = [];
    var_5c07b36e[#"caller"] = self getxuid();
    var_5c07b36e[#"spawnid"] = getplayerspawnid(self);
    var_5c07b36e[#"starttime"] = gettime();
    var_5c07b36e[#"type"] = hardpointtype;
    var_5c07b36e[#"endtime"] = 0;
    level.matchrecorderkillstreakkills[killstreak_id] = 0;
    level.killstreaks_triggered[killstreak_id] = var_5c07b36e;
    /#
        killstreak_debug_text("<dev string:x54>" + hardpointtype + "<dev string:x6c>" + team + "<dev string:x7b>" + killstreak_id);
    #/
    return killstreak_id;
}

// Namespace killstreakrules/killstreakrules_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x4b19be7f, Offset: 0x7c0
// Size: 0x158
function function_2e6ff61a(hardpointtype, killstreak_id, var_8c2bb724) {
    keys = getarraykeys(level.killstreaktype[hardpointtype]);
    foreach (key in keys) {
        if (!level.killstreaktype[hardpointtype][key].counts) {
            continue;
        }
        assert(isdefined(level.killstreakrules[key]));
        if (!isdefined(level.killstreakrules[key].var_11c5ecfd)) {
            continue;
        }
        if (level.killstreakrules[key].var_11c5ecfd == 0) {
            continue;
        }
        level.killstreakrules[key].var_8c2bb724[killstreak_id] = var_8c2bb724;
    }
}

// Namespace killstreakrules/killstreakrules_shared
// Params 1, eflags: 0x0
// Checksum 0x1dbe01a2, Offset: 0x920
// Size: 0x142
function function_7f69aa48(hardpointtype) {
    keys = getarraykeys(level.killstreaktype[hardpointtype]);
    foreach (key in keys) {
        if (!level.killstreaktype[hardpointtype][key].counts) {
            continue;
        }
        assert(isdefined(level.killstreakrules[key]));
        if (!isdefined(level.killstreakrules[key].var_11c5ecfd) || level.killstreakrules[key].var_11c5ecfd == 0) {
            continue;
        }
        return level.killstreakrules[key].var_11c5ecfd;
    }
    return undefined;
}

// Namespace killstreakrules/killstreakrules_shared
// Params 2, eflags: 0x0
// Checksum 0xd463e819, Offset: 0xa70
// Size: 0x40
function function_feb4595f(hardpointtype, var_5f910be6) {
    level.var_dcc3befb[hardpointtype] = var_5f910be6;
    level.var_dcc3befb["inventory_" + hardpointtype] = var_5f910be6;
}

// Namespace killstreakrules/killstreakrules_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x67cf05be, Offset: 0xab8
// Size: 0x54
function recordkillstreakenddirect(eventindex, recordstreakindex, totalkills) {
    player = self;
    player recordkillstreakendevent(eventindex, recordstreakindex, totalkills);
    player.killstreakevents[recordstreakindex] = undefined;
}

// Namespace killstreakrules/killstreakrules_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x6e8cee2b, Offset: 0xb18
// Size: 0xc0
function recordkillstreakend(recordstreakindex, totalkills) {
    player = self;
    if (!isplayer(player)) {
        return;
    }
    if (!isdefined(totalkills)) {
        totalkills = 0;
    }
    if (!isdefined(player.killstreakevents)) {
        player.killstreakevents = associativearray();
    }
    eventindex = player.killstreakevents[recordstreakindex];
    if (isdefined(eventindex)) {
        player recordkillstreakenddirect(eventindex, recordstreakindex, totalkills);
        return;
    }
    player.killstreakevents[recordstreakindex] = totalkills;
}

// Namespace killstreakrules/killstreakrules_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x25599063, Offset: 0xbe0
// Size: 0x5fc
function killstreakstop(hardpointtype, team, id) {
    assert(isdefined(team), "<dev string:x38>");
    assert(isdefined(hardpointtype));
    /#
        idstr = "<dev string:x84>";
        if (isdefined(id)) {
            idstr = id;
        }
        killstreak_debug_text("<dev string:x91>" + hardpointtype + "<dev string:x6c>" + team + "<dev string:x7b>" + idstr);
    #/
    keys = getarraykeys(level.killstreaktype[hardpointtype]);
    foreach (key in keys) {
        if (!level.killstreaktype[hardpointtype][key].counts) {
            continue;
        }
        assert(isdefined(level.killstreakrules[key]));
        if (isdefined(level.killstreakrules[key].cur)) {
            level.killstreakrules[key].cur--;
        }
        assert(level.killstreakrules[key].cur >= 0);
        if (isdefined(level.killstreakrules[key].var_8c2bb724[id])) {
            level.killstreakrules[key].var_8c2bb724[id] = undefined;
        }
        if (level.teambased) {
            assert(isdefined(team));
            assert(isdefined(level.killstreakrules[key].curteam[team]));
            if (isdefined(team) && isdefined(level.killstreakrules[key].curteam[team])) {
                level.killstreakrules[key].curteam[team]--;
            }
            assert(level.killstreakrules[key].curteam[team] >= 0);
        }
    }
    if (!isdefined(id) || id == -1) {
        /#
            killstreak_debug_text("<dev string:xa9>" + hardpointtype);
        #/
        if (sessionmodeismultiplayergame()) {
            function_92d1707f(#"hash_710b205b26e46446", {#starttime:0, #endtime:gettime(), #name:hardpointtype, #team:team});
        }
        return;
    }
    level.killstreaks_triggered[id][#"endtime"] = gettime();
    totalkillswiththiskillstreak = level.matchrecorderkillstreakkills[id];
    if (sessionmodeismultiplayergame()) {
        mpkillstreakuses = {#starttime:level.killstreaks_triggered[id][#"starttime"], #endtime:level.killstreaks_triggered[id][#"endtime"], #spawnid:level.killstreaks_triggered[id][#"spawnid"], #name:hardpointtype, #team:team};
        function_92d1707f(#"hash_710b205b26e46446", mpkillstreakuses);
    }
    level.killstreaks_triggered[id] = undefined;
    level.matchrecorderkillstreakkills[id] = undefined;
    if (isdefined(level.killstreaks[hardpointtype].menuname)) {
        recordstreakindex = level.killstreakindices[level.killstreaks[hardpointtype].menuname];
        if (isdefined(self) && isdefined(recordstreakindex) && (!isdefined(self.activatingkillstreak) || !self.activatingkillstreak)) {
            entity = self;
            if (isdefined(entity.owner)) {
                entity = entity.owner;
            }
            entity recordkillstreakend(recordstreakindex, totalkillswiththiskillstreak);
        }
    }
    if (!killstreaks::function_6bde02cc(hardpointtype)) {
        self function_d9f8f32b(hardpointtype);
    }
}

// Namespace killstreakrules/killstreakrules_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x9af76ad4, Offset: 0x11e8
// Size: 0x13c
function function_d9f8f32b(killstreaktype) {
    owner = undefined;
    if (isplayer(self)) {
        owner = self;
    } else if (isdefined(self.owner)) {
        self.owner.var_9e10e827 = self.var_9e10e827;
        owner = self.owner;
    }
    if (!isdefined(owner)) {
        return;
    }
    var_f66fab06 = owner function_3859ee41(killstreaktype);
    if (level.var_5b544215 === 1 || level.var_5b544215 === 2) {
        if (!isdefined(var_f66fab06)) {
            cooldownendtime = owner.var_8b9b1bba[killstreaktype];
            if (isdefined(cooldownendtime) && cooldownendtime > gettime()) {
                var_f66fab06 = float(cooldownendtime - gettime()) / 1000;
            }
        }
        if (isdefined(var_f66fab06)) {
            owner thread function_9f635a5(var_f66fab06, killstreaktype);
        }
    }
}

// Namespace killstreakrules/killstreakrules_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xdf8a10c, Offset: 0x1330
// Size: 0x264
function function_9f635a5(cooldowntime = 0, killstreaktype) {
    if (level.var_5b544215 !== 1 && level.var_5b544215 !== 2) {
        return;
    }
    level endon(#"game_ended");
    self endon(#"disconnect");
    if (!isdefined(killstreaktype)) {
        return;
    }
    var_5b220756 = self killstreaks::function_a2c375bb(killstreaktype);
    if (!isdefined(var_5b220756) || var_5b220756 === 3) {
        return;
    }
    wait cooldowntime;
    if (!isdefined(self)) {
        return;
    }
    if (level.var_5b544215 === 1) {
        if (self function_40451ab0(killstreaktype)) {
            self killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, undefined, killstreaktype, 0, 0);
            self.pers[#"hash_b05d8e95066f3ce"][killstreaktype] = 1;
        } else if (self.pers[#"hash_b05d8e95066f3ce"][killstreaktype] === 1) {
            self.pers[#"hash_b05d8e95066f3ce"][killstreaktype] = 0;
        }
        return;
    }
    if (level.var_5b544215 === 2) {
        weapon = killstreaks::get_killstreak_weapon(killstreaktype);
        if ((isdefined(self.pers[#"killstreak_quantity"][weapon]) ? self.pers[#"killstreak_quantity"][weapon] : 0) >= level.scorestreaksmaxstacking) {
            self killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, undefined, killstreaktype, 0, 0);
        }
    }
}

// Namespace killstreakrules/killstreakrules_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xc99c9788, Offset: 0x15a0
// Size: 0x94
function function_40451ab0(killstreaktype) {
    if (isdefined(killstreaktype)) {
        momentum = self.pers[#"momentum"];
        var_36f2d8a2 = self function_dceb5542(level.killstreaks[killstreaktype].itemindex);
        if (isdefined(momentum) && isdefined(var_36f2d8a2) && momentum >= var_36f2d8a2) {
            return true;
        }
    }
    return false;
}

// Namespace killstreakrules/killstreakrules_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xa39334e0, Offset: 0x1640
// Size: 0x178
function private function_3859ee41(killstreaktype) {
    if (!isplayer(self)) {
        return;
    }
    if (self.var_9e10e827 === 1) {
        self.var_9e10e827 = undefined;
        return;
    }
    var_5b220756 = self killstreaks::function_a2c375bb(killstreaktype);
    if (!isdefined(var_5b220756)) {
        return;
    }
    if (var_5b220756 == 3) {
        return;
    }
    killstreakweapon = killstreaks::get_killstreak_weapon(killstreaktype);
    if (level.var_5b544215 === 1) {
        var_f66fab06 = level.var_b29e45cf[killstreakweapon.statname];
    }
    if (level.var_5b544215 === 2) {
        var_f66fab06 = level.var_b3c95dd8[killstreakweapon.statname];
    }
    if (!isdefined(var_f66fab06)) {
        return;
    }
    cooldownendtime = gettime() + int(var_f66fab06 * 1000);
    self.var_8b9b1bba[killstreaktype] = cooldownendtime;
    self killstreaks::function_a831f92c(var_5b220756, var_f66fab06, 1);
    self killstreaks::function_b3185041(var_5b220756, cooldownendtime);
    return var_f66fab06;
}

// Namespace killstreakrules/killstreakrules_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x6af1dc79, Offset: 0x17c0
// Size: 0x57c
function iskillstreakallowed(hardpointtype, team, var_1d8339ae) {
    if (level.var_7aa0d894 === 1) {
        return 0;
    }
    if (self.var_7aa0d894 === 1) {
        return 0;
    }
    assert(isdefined(team), "<dev string:x38>");
    assert(isdefined(hardpointtype));
    if (isdefined(level.var_dcc3befb[hardpointtype])) {
        if (!self [[ level.var_dcc3befb[hardpointtype] ]]()) {
            return 0;
        }
    }
    isallowed = 1;
    if (!isdefined(level.killstreaktype[hardpointtype])) {
        var_22eba84a = getweapon(hardpointtype);
        if (var_22eba84a.iscarriedkillstreak) {
            return 1;
        }
        if (hardpointtype == #"supplydrop_marker" || hardpointtype == #"inventory_supplydrop_marker") {
            return 1;
        }
        return 0;
    }
    keys = getarraykeys(level.killstreaktype[hardpointtype]);
    foreach (key in keys) {
        if (!isallowed) {
            break;
        }
        if (!level.killstreaktype[hardpointtype][key].checks) {
            continue;
        }
        rule = level.killstreakrules[key];
        if (rule.max != 0) {
            if (rule.cur >= rule.max) {
                /#
                    killstreak_debug_text("<dev string:xd9>" + key + "<dev string:xe6>");
                #/
                isallowed = 0;
                break;
            }
        }
        if (isdefined(rule.var_11c5ecfd) && rule.var_11c5ecfd != 0) {
            playerorigin = self.origin;
            radiussq = function_a3f6cdac(rule.var_11c5ecfd);
            var_9a9cdff6 = 0;
            var_6eeac690 = 0;
            foreach (var_69e8e774 in rule.var_8c2bb724) {
                if (distance2dsquared(playerorigin, var_69e8e774.origin) > radiussq) {
                    continue;
                }
                var_9a9cdff6++;
                if (var_9a9cdff6 >= rule.var_62a7c0b4) {
                    /#
                        killstreak_debug_text("<dev string:xf2>" + key + "<dev string:x101>");
                    #/
                    isallowed = 0;
                    break;
                }
                if (level.teambased && rule.var_ee52fece != 0) {
                    if (self.team == var_69e8e774.team) {
                        var_6eeac690++;
                        if (var_6eeac690 >= rule.var_ee52fece) {
                            isallowed = 0;
                            /#
                                killstreak_debug_text("<dev string:xd9>" + key + "<dev string:x111>");
                            #/
                            break;
                        }
                    }
                }
            }
        }
        if (level.teambased && rule.maxperteam != 0) {
            if (!isdefined(rule.curteam[team])) {
                rule.curteam[team] = 0;
            }
            if (rule.curteam[team] >= rule.maxperteam) {
                isallowed = 0;
                /#
                    killstreak_debug_text("<dev string:xd9>" + key + "<dev string:x11e>");
                #/
                break;
            }
        }
    }
    if (isdefined(self.laststand) && self.laststand) {
        /#
            killstreak_debug_text("<dev string:x127>");
        #/
        isallowed = 0;
    }
    if (!is_true(var_1d8339ae)) {
        if (isallowed == 0) {
            if (isdefined(level.var_956bde25)) {
                self [[ level.var_956bde25 ]](hardpointtype, team, 0);
            }
        }
    }
    return isallowed;
}

/#

    // Namespace killstreakrules/killstreakrules_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc2a6f84c, Offset: 0x1d48
    // Size: 0xcc
    function killstreak_debug_text(text) {
        level.killstreak_rule_debug = getdvarint(#"scr_killstreak_rule_debug", 0);
        if (isdefined(level.killstreak_rule_debug)) {
            if (level.killstreak_rule_debug == 1) {
                iprintln("<dev string:x137>" + text + "<dev string:x140>");
                return;
            }
            if (level.killstreak_rule_debug == 2) {
                iprintlnbold("<dev string:x137>" + text);
            }
        }
    }

#/
