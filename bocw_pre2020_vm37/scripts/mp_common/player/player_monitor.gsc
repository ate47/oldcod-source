#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\match_record;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\bb;
#using scripts\mp_common\gametypes\globallogic_utils;

#namespace player_monitor;

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x6
// Checksum 0x7de4ae51, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"player_monitor", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x5 linked
// Checksum 0x4b052777, Offset: 0x118
// Size: 0x24
function private function_70a657d8() {
    callback::on_player_killed(&on_player_killed);
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x1 linked
// Checksum 0x153b7ac8, Offset: 0x148
// Size: 0x144
function monitor() {
    if (sessionmodeismultiplayergame()) {
        if (!isbot(self) && getdvarint(#"hash_18b3343408da85f5", 0) == 1) {
            self thread breadcrumbs();
        }
    } else if (sessionmodeiswarzonegame()) {
        if (!isbot(self) && getdvarint(#"hash_6d5a49354d02940d", 0) == 1) {
            self thread breadcrumbs();
        }
    }
    self thread travel_dist();
    if (sessionmodeiswarzonegame()) {
        self function_654cd97();
        return;
    }
    self thread inactivity();
}

// Namespace player_monitor/player_monitor
// Params 4, eflags: 0x1 linked
// Checksum 0x1321d4b2, Offset: 0x298
// Size: 0x1a2
function function_d35f877a(player, *weapon, statname, value = 0) {
    if (isdefined(weapon.var_3dc66299)) {
        if (statname == #"shots") {
            weapon.var_3dc66299.shots += value;
            return;
        }
        if (statname == #"hits") {
            weapon.var_3dc66299.hits += value;
            return;
        }
        if (statname == #"kills") {
            weapon.var_3dc66299.kills += value;
            return;
        }
        if (statname == #"deathsduringuse") {
            weapon.var_3dc66299.deathsduringuse += value;
            return;
        }
        if (statname == #"headshots") {
            weapon.var_3dc66299.headshots += value;
        }
    }
}

// Namespace player_monitor/player_monitor
// Params 1, eflags: 0x1 linked
// Checksum 0x851f068b, Offset: 0x448
// Size: 0x3c
function function_36185795(*params) {
    if (isalive(self)) {
        waittillframeend();
        self function_43e771ee();
    }
}

// Namespace player_monitor/player_monitor
// Params 1, eflags: 0x5 linked
// Checksum 0xddb5067b, Offset: 0x490
// Size: 0x36a
function private function_43e771ee(died = 0) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"disconnect");
    if (isdefined(self.var_3dc66299.currentweapon)) {
        timeused = function_f8d53445() - self.var_3dc66299.starttime;
        if (self.var_3dc66299.shots > 0 || timeused >= 2000) {
            longesthitdist = 0;
            currentlifeindex = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
            if (isdefined(currentlifeindex)) {
                longesthitdist = self match_record::get_stat(#"lives", currentlifeindex, "longest_hit_distance");
                self match_record::set_stat(#"lives", currentlifeindex, "longest_hit_distance", 0);
            }
            if (self.var_3dc66299.deathsduringuse > 0) {
                died = 1;
            }
            var_27047881 = int(timeused / 1000);
            attachments = bb::function_285f8efd(self.var_3dc66299.currentweapon);
            reticle = hash(self getweaponoptic(self.var_3dc66299.currentweapon));
            var_178db383 = spawnstruct();
            var_178db383.shots = self.var_3dc66299.shots;
            var_178db383.hits = self.var_3dc66299.hits;
            var_178db383.kills = self.var_3dc66299.kills;
            var_178db383.headshots = self.var_3dc66299.headshots;
            var_178db383.died = died;
            var_178db383.time_used_s = var_27047881;
            var_178db383.longest_hit_distance = longesthitdist;
            var_178db383.attachment1 = attachments.attachment0;
            var_178db383.attachment2 = attachments.attachment1;
            var_178db383.attachment3 = attachments.attachment2;
            var_178db383.attachment4 = attachments.attachment3;
            var_178db383.attachment5 = attachments.attachment4;
            var_178db383.attachment6 = attachments.attachment5;
            var_178db383.attachment7 = attachments.attachment6;
            var_178db383.reticle = reticle;
            var_178db383.weapon = self.var_3dc66299.currentweapon.name;
            function_92d1707f(#"hash_618e6178a21f0b3d", var_178db383);
            self.var_3dc66299.currentweapon = undefined;
        }
    }
}

// Namespace player_monitor/weapon_change_complete
// Params 1, eflags: 0x40
// Checksum 0xd8c17304, Offset: 0x808
// Size: 0xfa
function event_handler[weapon_change_complete] function_91abdff4(eventstruct) {
    if (!sessionmodeiswarzonegame()) {
        return;
    }
    if (game.state == "playing") {
        if (isdefined(eventstruct.weapon)) {
            self function_43e771ee();
            if (!isdefined(self.var_3dc66299)) {
                self.var_3dc66299 = {};
            }
            self.var_3dc66299.currentweapon = eventstruct.weapon;
            self.var_3dc66299.starttime = function_f8d53445();
            self.var_3dc66299.shots = 0;
            self.var_3dc66299.hits = 0;
            self.var_3dc66299.kills = 0;
            self.var_3dc66299.deathsduringuse = 0;
            self.var_3dc66299.headshots = 0;
        }
    }
}

// Namespace player_monitor/player_monitor
// Params 1, eflags: 0x1 linked
// Checksum 0x594bd824, Offset: 0x910
// Size: 0x94
function on_player_killed(*params) {
    self function_43e771ee(1);
    if (isdefined(self.lastswimmingstarttime) && self isplayerswimming()) {
        self function_9fabf258();
    }
    if (isdefined(self.lastwallrunstarttime) && self isplayerwallrunning()) {
        self function_83433c76();
    }
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x5 linked
// Checksum 0x498b646, Offset: 0x9b0
// Size: 0x82
function private function_654cd97() {
    self.var_3dc66299 = {};
    self.var_3dc66299.starttime = -1;
    self.var_3dc66299.shots = 0;
    self.var_3dc66299.hits = 0;
    self.var_3dc66299.kills = 0;
    self.var_3dc66299.deathsduringuse = 0;
    self.var_3dc66299.headshots = 0;
    self.var_3dc66299.currentweapon = undefined;
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x5 linked
// Checksum 0x4bd8f751, Offset: 0xa40
// Size: 0x13e
function private breadcrumbs() {
    self endon(#"death", #"disconnect");
    level endon(#"game_ended");
    waittime = 10;
    if (sessionmodeismultiplayergame()) {
        while (level.inprematchperiod) {
            waitframe(1);
        }
        waittime = getdvarfloat(#"hash_78606296733432c4", 2);
    } else if (sessionmodeiswarzonegame()) {
        level waittill(#"game_playing");
        waittime = getdvarfloat(#"hash_2872d2b12241500c", 4);
    }
    while (true) {
        if (isalive(self)) {
            recordbreadcrumbdataforplayer(self);
        }
        wait waittime;
    }
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x5 linked
// Checksum 0xfb46c9d1, Offset: 0xb88
// Size: 0x3b8
function private travel_dist() {
    self endon(#"death", #"disconnect");
    waittime = 1;
    minimummovedistance = 16;
    wait 4;
    if (!isdefined(self.pers[#"movement_update_count"])) {
        self.pers[#"movement_update_count"] = 0;
    }
    prevpos = self.origin;
    positionptm = self.origin;
    while (true) {
        wait waittime;
        if (self util::isusingremote()) {
            self waittill(#"stopped_using_remote");
            prevpos = self.origin;
            positionptm = self.origin;
            continue;
        }
        distance = distance(self.origin, prevpos);
        self.pers[#"total_distance_travelled"] = self.pers[#"total_distance_travelled"] + distance;
        if (gamestate::is_state("playing") && distance > 0) {
            if (!self isinvehicle()) {
                groundent = self getgroundent();
                if (isdefined(groundent) && !isvehicle(groundent)) {
                    self stats::function_d40764f3(#"distance_traveled_foot", int(distance));
                    if (is_true(self.outsidedeathcircle)) {
                        self stats::function_d40764f3(#"hash_630fffa7f053a2b7", int(distance));
                        self match_record::function_34800eec(#"hash_630fffa7f053a2b7", int(distance));
                    }
                }
            }
        }
        self.pers[#"movement_update_count"]++;
        prevpos = self.origin;
        if (self.pers[#"movement_update_count"] % 5 == 0) {
            distancemoving = distance(self.origin, positionptm);
            positionptm = self.origin;
            if (distancemoving > minimummovedistance) {
                self.pers[#"num_speeds_when_moving_entries"]++;
                self.pers[#"total_speeds_when_moving"] = self.pers[#"total_speeds_when_moving"] + distancemoving / waittime;
                self.pers[#"time_played_moving"] = self.pers[#"time_played_moving"] + waittime;
            }
        }
    }
}

// Namespace player_monitor/wallrun_begin
// Params 1, eflags: 0x40
// Checksum 0xa39f3f26, Offset: 0xf48
// Size: 0x16
function event_handler[wallrun_begin] function_f69038ac(*eventstruct) {
    self.lastwallrunstarttime = gettime();
}

// Namespace player_monitor/wallrun_end
// Params 1, eflags: 0x40
// Checksum 0xe51fc66e, Offset: 0xf68
// Size: 0x24
function event_handler[wallrun_end] function_830b9d71(*eventstruct) {
    self function_83433c76();
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x1 linked
// Checksum 0x97ac3c39, Offset: 0xf98
// Size: 0x36
function function_83433c76() {
    if (!isdefined(self.timespentwallrunninginlife)) {
        self.timespentwallrunninginlife = 0;
    }
    self.timespentwallrunninginlife += gettime() - self.lastwallrunstarttime;
}

// Namespace player_monitor/swimming_begin
// Params 1, eflags: 0x40
// Checksum 0xa7530633, Offset: 0xfd8
// Size: 0x16
function event_handler[swimming_begin] function_d18b7e6e(*eventstruct) {
    self.lastswimmingstarttime = gettime();
}

// Namespace player_monitor/swimming_end
// Params 1, eflags: 0x40
// Checksum 0xa66f8080, Offset: 0xff8
// Size: 0x24
function event_handler[swimming_end] function_b3154405(*eventstruct) {
    self function_9fabf258();
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x1 linked
// Checksum 0x2e4efad2, Offset: 0x1028
// Size: 0x36
function function_9fabf258() {
    if (!isdefined(self.timespentswimminginlife)) {
        self.timespentswimminginlife = 0;
    }
    self.timespentswimminginlife += gettime() - self.lastswimmingstarttime;
}

// Namespace player_monitor/slide_begin
// Params 1, eflags: 0x40
// Checksum 0xc154cb38, Offset: 0x1068
// Size: 0x38
function event_handler[slide_begin] function_86596790(*eventstruct) {
    self.lastslidestarttime = gettime();
    if (!isdefined(self.numberofslidesinlife)) {
        self.numberofslidesinlife = 0;
    }
    self.numberofslidesinlife++;
}

// Namespace player_monitor/doublejump_begin
// Params 1, eflags: 0x40
// Checksum 0x8417cc6e, Offset: 0x10a8
// Size: 0x38
function event_handler[doublejump_begin] function_2d820dd0(*eventstruct) {
    self.lastdoublejumpstarttime = gettime();
    if (!isdefined(self.numberofdoublejumpsinlife)) {
        self.numberofdoublejumpsinlife = 0;
    }
    self.numberofdoublejumpsinlife++;
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x5 linked
// Checksum 0xc4073a42, Offset: 0x10e8
// Size: 0xe6
function private inactivity() {
    self endon(#"disconnect");
    self notify(#"player_monitor_inactivity");
    self endon(#"player_monitor_inactivity");
    wait 10;
    while (true) {
        if (isdefined(self)) {
            if (self isremotecontrolling() || self util::isusingremote() || is_true(level.inprematchperiod) || is_true(self.var_4c45f505)) {
                self resetinactivitytimer();
            }
        }
        wait 5;
    }
}

