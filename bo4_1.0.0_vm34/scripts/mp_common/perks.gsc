#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace perks;

// Namespace perks/perks
// Params 0, eflags: 0x2
// Checksum 0x78319e22, Offset: 0xd0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"perks", &__init__, undefined, undefined);
}

// Namespace perks/perks
// Params 0, eflags: 0x0
// Checksum 0xcbbbbafd, Offset: 0x118
// Size: 0x54
function __init__() {
    clientfield::register("allplayers", "flying", 1, 1, "int");
    callback::on_spawned(&on_player_spawned);
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x9a90cab0, Offset: 0x178
// Size: 0x54
function on_player_spawned(local_client_num) {
    self thread monitorgpsjammer();
    self thread monitorsengrenjammer();
    self thread monitorflight();
}

// Namespace perks/perks
// Params 0, eflags: 0x0
// Checksum 0x6eeea24e, Offset: 0x1d8
// Size: 0x9c
function monitorflight() {
    self endon(#"death");
    self endon(#"disconnect");
    self.flying = 0;
    while (isdefined(self)) {
        flying = !self isonground();
        if (self.flying != flying) {
            self clientfield::set("flying", flying);
            self.flying = flying;
        }
        waitframe(1);
    }
}

// Namespace perks/perks
// Params 0, eflags: 0x0
// Checksum 0xa065f908, Offset: 0x280
// Size: 0x5d0
function monitorgpsjammer() {
    self endon(#"death");
    self endon(#"disconnect");
    require_perk = 1;
    /#
        require_perk = 0;
    #/
    if (require_perk && self hasperk(#"specialty_gpsjammer") == 0) {
        return;
    }
    self clientfield::set("gps_jammer_active", self hasperk(#"specialty_gpsjammer") ? 1 : 0);
    graceperiods = self function_71b411f4(#"grace_periods");
    minspeed = self function_71b411f4(#"min_speed");
    mindistance = self function_71b411f4(#"min_distance");
    timeperiod = self function_71b411f4("time_period");
    timeperiodsec = float(timeperiod) / 1000;
    minspeedsq = minspeed * minspeed;
    mindistancesq = mindistance * mindistance;
    if (minspeedsq == 0) {
        return;
    }
    assert(timeperiodsec >= 0.05);
    if (timeperiodsec < 0.05) {
        return;
    }
    hasperk = 1;
    statechange = 0;
    faileddistancecheck = 0;
    currentfailcount = 0;
    timepassed = 0;
    timesincedistancecheck = 0;
    previousorigin = self.origin;
    gpsjammerprotection = 0;
    while (true) {
        /#
            graceperiods = self function_71b411f4(#"grace_periods");
            minspeed = self function_71b411f4(#"min_speed");
            mindistance = self function_71b411f4(#"min_distance");
            timeperiod = self function_71b411f4("<dev string:x30>");
            timeperiodsec = float(timeperiod) / 1000;
            minspeedsq = minspeed * minspeed;
            mindistancesq = mindistance * mindistance;
        #/
        gpsjammerprotection = 0;
        if (util::isusingremote() || isdefined(self.isplanting) && self.isplanting || isdefined(self.isdefusing) && self.isdefusing) {
            gpsjammerprotection = 1;
        } else {
            if (timesincedistancecheck > 1) {
                timesincedistancecheck = 0;
                if (distancesquared(previousorigin, self.origin) < mindistancesq) {
                    faileddistancecheck = 1;
                } else {
                    faileddistancecheck = 0;
                }
                previousorigin = self.origin;
            }
            velocity = self getvelocity();
            speedsq = lengthsquared(velocity);
            if (speedsq > minspeedsq && faileddistancecheck == 0) {
                gpsjammerprotection = 1;
            }
        }
        if (gpsjammerprotection == 1 && self hasperk(#"specialty_gpsjammer")) {
            /#
                if (getdvarint(#"scr_debug_perk_gpsjammer", 0) != 0) {
                    sphere(self.origin + (0, 0, 70), 12, (0, 0, 1), 1, 1, 16, 3);
                }
            #/
            currentfailcount = 0;
            if (hasperk == 0) {
                statechange = 0;
                hasperk = 1;
                self clientfield::set("gps_jammer_active", 1);
            }
        } else {
            currentfailcount++;
            if (hasperk == 1 && currentfailcount >= graceperiods) {
                statechange = 1;
                hasperk = 0;
                self clientfield::set("gps_jammer_active", 0);
            }
        }
        if (statechange == 1) {
            level notify(#"radar_status_change");
        }
        timesincedistancecheck += timeperiodsec;
        wait timeperiodsec;
    }
}

// Namespace perks/perks
// Params 0, eflags: 0x0
// Checksum 0xa99e6e15, Offset: 0x858
// Size: 0x608
function monitorsengrenjammer() {
    self endon(#"death");
    self endon(#"disconnect");
    require_perk = 1;
    /#
        require_perk = 0;
    #/
    if (require_perk && self hasperk(#"specialty_sengrenjammer") == 0) {
        return;
    }
    self clientfield::set("sg_jammer_active", self hasperk(#"specialty_sengrenjammer") ? 1 : 0);
    graceperiods = getdvarint(#"perk_sgjammer_graceperiods", 4);
    minspeed = getdvarint(#"perk_sgjammer_min_speed", 100);
    mindistance = getdvarint(#"perk_sgjammer_min_distance", 10);
    timeperiod = getdvarint(#"perk_sgjammer_time_period", 200);
    timeperiodsec = float(timeperiod) / 1000;
    minspeedsq = minspeed * minspeed;
    mindistancesq = mindistance * mindistance;
    if (minspeedsq == 0) {
        return;
    }
    assert(timeperiodsec >= 0.05);
    if (timeperiodsec < 0.05) {
        return;
    }
    hasperk = 1;
    statechange = 0;
    faileddistancecheck = 0;
    currentfailcount = 0;
    timepassed = 0;
    timesincedistancecheck = 0;
    previousorigin = self.origin;
    sgjammerprotection = 0;
    while (true) {
        /#
            graceperiods = getdvarint(#"perk_sgjammer_graceperiods", graceperiods);
            minspeed = getdvarint(#"perk_sgjammer_min_speed", minspeed);
            mindistance = getdvarint(#"perk_sgjammer_min_distance", mindistance);
            timeperiod = getdvarint(#"perk_sgjammer_time_period", timeperiod);
            timeperiodsec = float(timeperiod) / 1000;
            minspeedsq = minspeed * minspeed;
            mindistancesq = mindistance * mindistance;
        #/
        sgjammerprotection = 0;
        if (util::isusingremote() || isdefined(self.isplanting) && self.isplanting || isdefined(self.isdefusing) && self.isdefusing) {
            sgjammerprotection = 1;
        } else {
            if (timesincedistancecheck > 1) {
                timesincedistancecheck = 0;
                if (distancesquared(previousorigin, self.origin) < mindistancesq) {
                    faileddistancecheck = 1;
                } else {
                    faileddistancecheck = 0;
                }
                previousorigin = self.origin;
            }
            velocity = self getvelocity();
            speedsq = lengthsquared(velocity);
            if (speedsq > minspeedsq && faileddistancecheck == 0) {
                sgjammerprotection = 1;
            }
        }
        if (sgjammerprotection == 1 && self hasperk(#"specialty_sengrenjammer")) {
            /#
                if (getdvarint(#"scr_debug_perk_sengrenjammer", 0) != 0) {
                    sphere(self.origin + (0, 0, 65), 12, (0, 1, 0), 1, 1, 16, 3);
                }
            #/
            currentfailcount = 0;
            if (hasperk == 0) {
                statechange = 0;
                hasperk = 1;
                self clientfield::set("sg_jammer_active", 1);
            }
        } else {
            currentfailcount++;
            if (hasperk == 1 && currentfailcount >= graceperiods) {
                statechange = 1;
                hasperk = 0;
                self clientfield::set("sg_jammer_active", 0);
            }
        }
        if (statechange == 1) {
            level notify(#"radar_status_change");
        }
        timesincedistancecheck += timeperiodsec;
        wait timeperiodsec;
    }
}

