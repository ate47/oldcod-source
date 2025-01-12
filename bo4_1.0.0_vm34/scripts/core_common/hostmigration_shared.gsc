#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace hostmigration;

/#

    // Namespace hostmigration/hostmigration_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6fa1e492, Offset: 0xe0
    // Size: 0x134
    function debug_script_structs() {
        if (isdefined(level.struct)) {
            println("<dev string:x30>" + level.struct.size);
            println("<dev string:x41>");
            for (i = 0; i < level.struct.size; i++) {
                struct = level.struct[i];
                if (isdefined(struct.targetname)) {
                    println("<dev string:x42>" + i + "<dev string:x46>" + struct.targetname);
                    continue;
                }
                println("<dev string:x42>" + i + "<dev string:x46>" + "<dev string:x4a>");
            }
            return;
        }
        println("<dev string:x4f>");
    }

#/

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0xab9457c8, Offset: 0x220
// Size: 0xba
function updatetimerpausedness() {
    shouldbestopped = isdefined(level.hostmigrationtimer);
    if (!level.timerstopped && shouldbestopped) {
        level.timerstopped = 1;
        level.playabletimerstopped = 1;
        level.timerpausetime = gettime();
        return;
    }
    if (level.timerstopped && !shouldbestopped) {
        level.timerstopped = 0;
        level.playabletimerstopped = 0;
        level.discardtime += gettime() - level.timerpausetime;
    }
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0xc42d0cdb, Offset: 0x2e8
// Size: 0x12
function pausetimer() {
    level.migrationtimerpausetime = gettime();
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0xba822b20, Offset: 0x308
// Size: 0x2a
function resumetimer() {
    level.discardtime += gettime() - level.migrationtimerpausetime;
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0x8b101f96, Offset: 0x340
// Size: 0x86
function locktimer() {
    level endon(#"host_migration_begin");
    level endon(#"host_migration_end");
    for (;;) {
        currtime = gettime();
        waitframe(1);
        if (!level.timerstopped && isdefined(level.discardtime)) {
            level.discardtime += gettime() - currtime;
        }
    }
}

// Namespace hostmigration/hostmigration_shared
// Params 1, eflags: 0x0
// Checksum 0xcdf3749c, Offset: 0x3d0
// Size: 0x72
function matchstarttimerconsole_internal(counttime) {
    waittillframeend();
    level endon(#"match_start_timer_beginning");
    luinotifyevent(#"create_prematch_timer", 2, gettime() + int(counttime * 1000), 1);
    wait counttime;
}

// Namespace hostmigration/hostmigration_shared
// Params 2, eflags: 0x0
// Checksum 0x2368d080, Offset: 0x450
// Size: 0xec
function matchstarttimerconsole(type, duration) {
    level notify(#"match_start_timer_beginning");
    waitframe(1);
    counttime = int(duration);
    if (isdefined(level.host_migration_activate_visionset_func)) {
        level thread [[ level.host_migration_activate_visionset_func ]]();
    }
    var_8ad39a91 = counttime >= 2;
    if (var_8ad39a91) {
        matchstarttimerconsole_internal(counttime);
    }
    if (isdefined(level.host_migration_deactivate_visionset_func)) {
        level thread [[ level.host_migration_deactivate_visionset_func ]]();
    }
    luinotifyevent(#"prematch_timer_ended", 1, var_8ad39a91);
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0xc88e4a5e, Offset: 0x548
// Size: 0xaa
function hostmigrationwait() {
    level endon(#"game_ended");
    if (level.hostmigrationreturnedplayercount < level.players.size * 2 / 3) {
        thread matchstarttimerconsole("waiting_for_teams", 20);
        hostmigrationwaitforplayers();
    }
    level notify(#"host_migration_countdown_begin");
    thread matchstarttimerconsole("match_starting_in", 5);
    wait 5;
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0xd529e517, Offset: 0x600
// Size: 0x44
function waittillhostmigrationcountdown() {
    level endon(#"host_migration_end");
    if (!isdefined(level.hostmigrationtimer)) {
        return;
    }
    level waittill(#"host_migration_countdown_begin");
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0xc29c2c0e, Offset: 0x650
// Size: 0x20
function hostmigrationwaitforplayers() {
    level endon(#"hostmigration_enoughplayers");
    wait 15;
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0xe245073c, Offset: 0x678
// Size: 0xec
function hostmigrationtimerthink_internal() {
    level endon(#"host_migration_begin");
    level endon(#"host_migration_end");
    self.hostmigrationcontrolsfrozen = 0;
    while (!isalive(self)) {
        self waittill(#"spawned");
    }
    self.hostmigrationcontrolsfrozen = 1;
    val::set(#"hostmigration", "freezecontrols", 1);
    val::set(#"hostmigration", "disablegadgets", 1);
    level waittill(#"host_migration_end");
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0x679b6571, Offset: 0x770
// Size: 0x94
function hostmigrationtimerthink() {
    self endon(#"disconnect");
    level endon(#"host_migration_begin");
    hostmigrationtimerthink_internal();
    if (self.hostmigrationcontrolsfrozen) {
        val::reset(#"hostmigration", "freezecontrols");
        val::reset(#"hostmigration", "disablegadgets");
    }
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0x1457563b, Offset: 0x810
// Size: 0x44
function waittillhostmigrationdone() {
    if (!isdefined(level.hostmigrationtimer)) {
        return 0;
    }
    starttime = gettime();
    level waittill(#"host_migration_end");
    return gettime() - starttime;
}

// Namespace hostmigration/hostmigration_shared
// Params 1, eflags: 0x0
// Checksum 0xbbc2a8d, Offset: 0x860
// Size: 0x38
function waittillhostmigrationstarts(duration) {
    if (isdefined(level.hostmigrationtimer)) {
        return;
    }
    level endon(#"host_migration_begin");
    wait duration;
}

// Namespace hostmigration/hostmigration_shared
// Params 1, eflags: 0x0
// Checksum 0xfbade99b, Offset: 0x8a0
// Size: 0x13c
function waitlongdurationwithhostmigrationpause(duration) {
    if (duration == 0) {
        return;
    }
    assert(duration > 0);
    starttime = gettime();
    for (endtime = gettime() + int(duration * 1000); gettime() < endtime; endtime += timepassed) {
        waittillhostmigrationstarts(float(endtime - gettime()) / 1000);
        if (isdefined(level.hostmigrationtimer)) {
            timepassed = waittillhostmigrationdone();
        }
    }
    /#
        if (gettime() != endtime) {
            println("<dev string:x67>" + gettime() + "<dev string:x84>" + endtime);
        }
    #/
    waittillhostmigrationdone();
    return gettime() - starttime;
}

// Namespace hostmigration/hostmigration_shared
// Params 1, eflags: 0x0
// Checksum 0x62c4549, Offset: 0x9e8
// Size: 0x15e
function waitlongdurationwithhostmigrationpauseemp(duration) {
    if (duration == 0) {
        return;
    }
    assert(duration > 0);
    starttime = gettime();
    empendtime = gettime() + int(duration * 1000);
    level.empendtime = empendtime;
    while (gettime() < empendtime) {
        waittillhostmigrationstarts(float(empendtime - gettime()) / 1000);
        if (isdefined(level.hostmigrationtimer)) {
            timepassed = waittillhostmigrationdone();
            if (isdefined(empendtime)) {
                empendtime += timepassed;
            }
        }
    }
    /#
        if (gettime() != empendtime) {
            println("<dev string:x67>" + gettime() + "<dev string:x9d>" + empendtime);
        }
    #/
    waittillhostmigrationdone();
    level.empendtime = undefined;
    return gettime() - starttime;
}

// Namespace hostmigration/hostmigration_shared
// Params 1, eflags: 0x0
// Checksum 0x48f6dc25, Offset: 0xb50
// Size: 0x196
function waitlongdurationwithgameendtimeupdate(duration) {
    if (duration == 0) {
        return;
    }
    assert(duration > 0);
    starttime = gettime();
    endtime = gettime() + int(duration * 1000);
    while (gettime() < endtime) {
        waittillhostmigrationstarts(float(endtime - gettime()) / 1000);
        while (isdefined(level.hostmigrationtimer)) {
            endtime += 1000;
            setgameendtime(int(endtime));
            wait 1;
        }
    }
    /#
        if (gettime() != endtime) {
            println("<dev string:x67>" + gettime() + "<dev string:x84>" + endtime);
        }
    #/
    while (isdefined(level.hostmigrationtimer)) {
        endtime += 1000;
        setgameendtime(int(endtime));
        wait 1;
    }
    return gettime() - starttime;
}

// Namespace hostmigration/hostmigration_shared
// Params 1, eflags: 0x0
// Checksum 0x8bbd6812, Offset: 0xcf0
// Size: 0xf0
function migrationawarewait(durationms) {
    waittillhostmigrationdone();
    endtime = gettime() + durationms;
    timeremaining = durationms;
    while (true) {
        event = level util::waittill_level_any_timeout(float(timeremaining) / 1000, self, "game_ended", "host_migration_begin");
        if (event != "host_migration_begin") {
            return;
        }
        timeremaining = endtime - gettime();
        if (timeremaining <= 0) {
            return;
        }
        endtime = gettime() + durationms;
        waittillhostmigrationdone();
    }
}

