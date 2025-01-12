#using scripts\core_common\match_record;
#using scripts\core_common\util_shared;
#using scripts\mp_common\bb;
#using scripts\mp_common\gametypes\globallogic_utils;

#namespace player_monitor;

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x0
// Checksum 0xaf3c7e32, Offset: 0xa8
// Size: 0x1a4
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
    if (sessionmodeiswarzonegame()) {
        self thread function_320ed7e6();
        return;
    }
    self thread travel_dist();
    self thread wall_run();
    self thread swimming();
    self thread slide();
    self thread doublejump();
    self thread inactivity();
}

// Namespace player_monitor/player_monitor
// Params 4, eflags: 0x0
// Checksum 0xe04b03c0, Offset: 0x258
// Size: 0x192
function function_add15ef8(player, weapon, statname, value) {
    if (isdefined(player.var_40ad634c)) {
        if (statname == #"shots") {
            player.var_40ad634c.shots += value;
            return;
        }
        if (statname == #"hits") {
            player.var_40ad634c.hits += value;
            return;
        }
        if (statname == #"kills") {
            player.var_40ad634c.kills += value;
            return;
        }
        if (statname == #"deathsduringuse") {
            player.var_40ad634c.deathsduringuse += value;
            return;
        }
        if (statname == #"headshots") {
            player.var_40ad634c.headshots += value;
        }
    }
}

// Namespace player_monitor/player_monitor
// Params 1, eflags: 0x0
// Checksum 0x870da76a, Offset: 0x3f8
// Size: 0x4c
function function_153528fd(params) {
    if (isalive(self)) {
        waittillframeend();
        self function_7a3253bb(#"game_ended");
    }
}

// Namespace player_monitor/player_monitor
// Params 1, eflags: 0x4
// Checksum 0xdb92f9b9, Offset: 0x450
// Size: 0x3c2
function private function_7a3253bb(reason) {
    if (isdefined(self.var_40ad634c.currentweapon)) {
        timeused = function_25e96038() - self.var_40ad634c.starttime;
        if (self.var_40ad634c.shots > 0 || timeused >= 2000) {
            longesthitdist = 0;
            currentlifeindex = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
            if (isdefined(currentlifeindex)) {
                longesthitdist = self match_record::get_stat(#"lives", currentlifeindex, "longest_hit_distance");
                self match_record::set_stat(#"lives", currentlifeindex, "longest_hit_distance", 0);
            }
            died = 0;
            if (reason == #"death" || self.var_40ad634c.deathsduringuse > 0) {
                died = 1;
            }
            var_9b01ac9c = int(timeused / 1000);
            attachments = bb::function_753291e4(self.var_40ad634c.currentweapon);
            reticle = hash(self getweaponoptic(self.var_40ad634c.currentweapon));
            var_63a5c4db = spawnstruct();
            var_63a5c4db.shots = self.var_40ad634c.shots;
            var_63a5c4db.hits = self.var_40ad634c.hits;
            var_63a5c4db.kills = self.var_40ad634c.kills;
            var_63a5c4db.headshots = self.var_40ad634c.headshots;
            var_63a5c4db.died = died;
            var_63a5c4db.time_used_s = var_9b01ac9c;
            var_63a5c4db.longest_hit_distance = longesthitdist;
            var_63a5c4db.attachment1 = attachments.attachment0;
            var_63a5c4db.attachment2 = attachments.attachment1;
            var_63a5c4db.attachment3 = attachments.attachment2;
            var_63a5c4db.attachment4 = attachments.attachment3;
            var_63a5c4db.attachment5 = attachments.attachment4;
            var_63a5c4db.attachment6 = attachments.attachment5;
            var_63a5c4db.attachment7 = attachments.attachment6;
            var_63a5c4db.reticle = reticle;
            var_63a5c4db.weapon = self.var_40ad634c.currentweapon.name;
            function_b1f6086c(#"hash_618e6178a21f0b3d", var_63a5c4db);
            self.var_40ad634c.currentweapon = undefined;
        }
    }
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x4
// Checksum 0x9ad22f26, Offset: 0x820
// Size: 0x1fe
function private function_320ed7e6() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self.var_40ad634c = {};
    self.var_40ad634c.starttime = -1;
    self.var_40ad634c.shots = 0;
    self.var_40ad634c.hits = 0;
    self.var_40ad634c.kills = 0;
    self.var_40ad634c.deathsduringuse = 0;
    self.var_40ad634c.headshots = 0;
    self.var_40ad634c.currentweapon = undefined;
    level waittill(#"game_playing");
    while (true) {
        result = self waittill(#"weapon_change_complete", #"death");
        if (result._notify == #"death") {
            self function_7a3253bb(result._notify);
            break;
        }
        self function_7a3253bb(result._notify);
        if (isdefined(result.weapon)) {
            self.var_40ad634c.currentweapon = result.weapon;
            self.var_40ad634c.starttime = function_25e96038();
            self.var_40ad634c.shots = 0;
            self.var_40ad634c.hits = 0;
            self.var_40ad634c.kills = 0;
            self.var_40ad634c.deathsduringuse = 0;
            self.var_40ad634c.headshots = 0;
        }
    }
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x4
// Checksum 0xaf02eef5, Offset: 0xa28
// Size: 0x13e
function private breadcrumbs() {
    self endon(#"death");
    self endon(#"disconnect");
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
// Params 0, eflags: 0x4
// Checksum 0x74bb91e9, Offset: 0xb70
// Size: 0x242
function private travel_dist() {
    self endon(#"death");
    self endon(#"disconnect");
    waittime = 1;
    minimummovedistance = 16;
    wait 4;
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

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x4
// Checksum 0xbc2a8907, Offset: 0xdc0
// Size: 0x158
function private wall_run() {
    self endon(#"disconnect");
    self notify(#"stop_player_monitor_wall_run");
    self endon(#"stop_player_monitor_wall_run");
    self.lastwallrunstarttime = 0;
    self.timespentwallrunninginlife = 0;
    while (true) {
        notification = self waittill(#"wallrun_begin", #"death", #"disconnect", #"stop_player_monitor_wall_run");
        if (notification._notify == "death") {
            break;
        }
        self.lastwallrunstarttime = gettime();
        notification = self waittill(#"wallrun_end", #"death", #"disconnect", #"stop_player_monitor_wall_run");
        self.timespentwallrunninginlife += gettime() - self.lastwallrunstarttime;
        if (notification._notify == "death") {
            break;
        }
    }
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x4
// Checksum 0x6d6cd549, Offset: 0xf20
// Size: 0x158
function private swimming() {
    self endon(#"disconnect");
    self notify(#"stop_player_monitor_swimming");
    self endon(#"stop_player_monitor_swimming");
    self.lastswimmingstarttime = 0;
    self.timespentswimminginlife = 0;
    while (true) {
        notification = self waittill(#"swimming_begin", #"death", #"disconnect", #"stop_player_monitor_swimming");
        if (notification._notify == "death") {
            break;
        }
        self.lastswimmingstarttime = gettime();
        notification = self waittill(#"swimming_end", #"death", #"disconnect", #"stop_player_monitor_swimming");
        self.timespentswimminginlife += gettime() - self.lastswimmingstarttime;
        if (notification._notify == "death") {
            break;
        }
    }
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x4
// Checksum 0x6f57c769, Offset: 0x1080
// Size: 0x144
function private slide() {
    self endon(#"disconnect");
    self notify(#"stop_player_monitor_slide");
    self endon(#"stop_player_monitor_slide");
    self.lastslidestarttime = 0;
    self.numberofslidesinlife = 0;
    while (true) {
        notification = self waittill(#"slide_begin", #"death", #"disconnect", #"stop_player_monitor_slide");
        if (notification._notify == "death") {
            break;
        }
        self.lastslidestarttime = gettime();
        self.numberofslidesinlife++;
        notification = self waittill(#"slide_end", #"death", #"disconnect", #"stop_player_monitor_slide");
        if (notification._notify == "death") {
            break;
        }
    }
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x4
// Checksum 0x5822dec2, Offset: 0x11d0
// Size: 0x144
function private doublejump() {
    self endon(#"disconnect");
    self notify(#"stop_player_monitor_doublejump");
    self endon(#"stop_player_monitor_doublejump");
    self.lastdoublejumpstarttime = 0;
    self.numberofdoublejumpsinlife = 0;
    while (true) {
        notification = self waittill(#"doublejump_begin", #"death", #"disconnect", #"stop_player_monitor_doublejump");
        if (notification._notify == "death") {
            break;
        }
        self.lastdoublejumpstarttime = gettime();
        self.numberofdoublejumpsinlife++;
        notification = self waittill(#"doublejump_end", #"death", #"disconnect", #"stop_player_monitor_doublejump");
        if (notification._notify == "death") {
            break;
        }
    }
}

// Namespace player_monitor/player_monitor
// Params 0, eflags: 0x4
// Checksum 0x8dc2080e, Offset: 0x1320
// Size: 0xc6
function private inactivity() {
    self endon(#"disconnect");
    self notify(#"player_monitor_inactivity");
    self endon(#"player_monitor_inactivity");
    wait 10;
    while (true) {
        if (isdefined(self)) {
            if (self isremotecontrolling() || self util::isusingremote() || isdefined(level.inprematchperiod) && level.inprematchperiod) {
                self resetinactivitytimer();
            }
        }
        wait 5;
    }
}

