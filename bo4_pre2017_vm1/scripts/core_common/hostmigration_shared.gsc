#using scripts/core_common/hud_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;

#namespace hostmigration;

/#

    // Namespace hostmigration/hostmigration_shared
    // Params 0, eflags: 0x0
    // Checksum 0xde2a385a, Offset: 0x1f0
    // Size: 0x14c
    function debug_script_structs() {
        if (isdefined(level.struct)) {
            println("<dev string:x28>" + level.struct.size);
            println("<dev string:x39>");
            for (i = 0; i < level.struct.size; i++) {
                struct = level.struct[i];
                if (isdefined(struct.targetname)) {
                    println("<dev string:x3a>" + i + "<dev string:x3e>" + struct.targetname);
                    continue;
                }
                println("<dev string:x3a>" + i + "<dev string:x3e>" + "<dev string:x42>");
            }
            return;
        }
        println("<dev string:x47>");
    }

#/

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0x286f9c2c, Offset: 0x348
// Size: 0xcc
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
// Checksum 0x96aa340, Offset: 0x420
// Size: 0x14
function pausetimer() {
    level.migrationtimerpausetime = gettime();
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0x5e68c5d0, Offset: 0x440
// Size: 0x2c
function resumetimer() {
    level.discardtime += gettime() - level.migrationtimerpausetime;
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0xa714aeea, Offset: 0x478
// Size: 0x7c
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
// Params 2, eflags: 0x0
// Checksum 0x2c45e2ff, Offset: 0x500
// Size: 0xfc
function matchstarttimerconsole_internal(counttime, matchstarttimer) {
    waittillframeend();
    level endon(#"match_start_timer_beginning");
    while (counttime > 0 && !level.gameended) {
        matchstarttimer thread hud::function_5e2578bc(level);
        wait matchstarttimer.inframes * 0.05;
        matchstarttimer setvalue(counttime);
        if (counttime == 2) {
            visionsetnaked(getdvarstring("mapname"), 3);
        }
        counttime--;
        wait 1 - matchstarttimer.inframes * 0.05;
    }
}

// Namespace hostmigration/hostmigration_shared
// Params 2, eflags: 0x0
// Checksum 0xdecffe0f, Offset: 0x608
// Size: 0x29c
function matchstarttimerconsole(type, duration) {
    level notify(#"match_start_timer_beginning");
    waitframe(1);
    var_a2ceaf69 = hud::createserverfontstring("objective", 1.5);
    var_a2ceaf69 hud::setpoint("CENTER", "CENTER", 0, -40);
    var_a2ceaf69.sort = 1001;
    var_a2ceaf69 settext(game.strings["waiting_for_teams"]);
    var_a2ceaf69.foreground = 0;
    var_a2ceaf69.hidewheninmenu = 1;
    var_a2ceaf69 settext(game.strings[type]);
    matchstarttimer = hud::createserverfontstring("objective", 2.2);
    matchstarttimer hud::setpoint("CENTER", "CENTER", 0, 0);
    matchstarttimer.sort = 1001;
    matchstarttimer.color = (1, 1, 0);
    matchstarttimer.foreground = 0;
    matchstarttimer.hidewheninmenu = 1;
    matchstarttimer hud::function_1ad5c13d();
    counttime = int(duration);
    if (isdefined(level.host_migration_activate_visionset_func)) {
        level thread [[ level.host_migration_activate_visionset_func ]]();
    }
    if (counttime >= 2) {
        matchstarttimerconsole_internal(counttime, matchstarttimer);
    }
    if (isdefined(level.host_migration_deactivate_visionset_func)) {
        level thread [[ level.host_migration_deactivate_visionset_func ]]();
    }
    matchstarttimer hud::destroyelem();
    var_a2ceaf69 hud::destroyelem();
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0x81d0fb8d, Offset: 0x8b0
// Size: 0xa2
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
// Checksum 0xb82e376d, Offset: 0x960
// Size: 0x38
function waittillhostmigrationcountdown() {
    level endon(#"host_migration_end");
    if (!isdefined(level.hostmigrationtimer)) {
        return;
    }
    level waittill("host_migration_countdown_begin");
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0x166d0348, Offset: 0x9a0
// Size: 0x18
function hostmigrationwaitforplayers() {
    level endon(#"hostmigration_enoughplayers");
    wait 15;
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0x2dac181f, Offset: 0x9c0
// Size: 0x9c
function hostmigrationtimerthink_internal() {
    level endon(#"host_migration_begin");
    level endon(#"host_migration_end");
    self.hostmigrationcontrolsfrozen = 0;
    while (!isalive(self)) {
        self waittill("spawned");
    }
    self.hostmigrationcontrolsfrozen = 1;
    val::set("hostmigration", "freezecontrols", 1);
    level waittill("host_migration_end");
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0x41a94939, Offset: 0xa68
// Size: 0x64
function hostmigrationtimerthink() {
    self endon(#"disconnect");
    level endon(#"host_migration_begin");
    hostmigrationtimerthink_internal();
    if (self.hostmigrationcontrolsfrozen) {
        val::reset("hostmigration", "freezecontrols");
    }
}

// Namespace hostmigration/hostmigration_shared
// Params 0, eflags: 0x0
// Checksum 0x5cece074, Offset: 0xad8
// Size: 0x40
function waittillhostmigrationdone() {
    if (!isdefined(level.hostmigrationtimer)) {
        return 0;
    }
    starttime = gettime();
    level waittill("host_migration_end");
    return gettime() - starttime;
}

// Namespace hostmigration/hostmigration_shared
// Params 1, eflags: 0x0
// Checksum 0x90bec699, Offset: 0xb20
// Size: 0x34
function waittillhostmigrationstarts(duration) {
    if (isdefined(level.hostmigrationtimer)) {
        return;
    }
    level endon(#"host_migration_begin");
    wait duration;
}

// Namespace hostmigration/hostmigration_shared
// Params 1, eflags: 0x0
// Checksum 0x28d2ac96, Offset: 0xb60
// Size: 0x12c
function waitlongdurationwithhostmigrationpause(duration) {
    if (duration == 0) {
        return;
    }
    assert(duration > 0);
    starttime = gettime();
    for (endtime = gettime() + duration * 1000; gettime() < endtime; endtime += timepassed) {
        waittillhostmigrationstarts((endtime - gettime()) / 1000);
        if (isdefined(level.hostmigrationtimer)) {
            timepassed = waittillhostmigrationdone();
        }
    }
    /#
        if (gettime() != endtime) {
            println("<dev string:x5f>" + gettime() + "<dev string:x7c>" + endtime);
        }
    #/
    waittillhostmigrationdone();
    return gettime() - starttime;
}

// Namespace hostmigration/hostmigration_shared
// Params 1, eflags: 0x0
// Checksum 0x77656e6c, Offset: 0xc98
// Size: 0x14e
function waitlongdurationwithhostmigrationpauseemp(duration) {
    if (duration == 0) {
        return;
    }
    assert(duration > 0);
    starttime = gettime();
    empendtime = gettime() + duration * 1000;
    level.empendtime = empendtime;
    while (gettime() < empendtime) {
        waittillhostmigrationstarts((empendtime - gettime()) / 1000);
        if (isdefined(level.hostmigrationtimer)) {
            timepassed = waittillhostmigrationdone();
            if (isdefined(empendtime)) {
                empendtime += timepassed;
            }
        }
    }
    /#
        if (gettime() != empendtime) {
            println("<dev string:x5f>" + gettime() + "<dev string:x95>" + empendtime);
        }
    #/
    waittillhostmigrationdone();
    level.empendtime = undefined;
    return gettime() - starttime;
}

// Namespace hostmigration/hostmigration_shared
// Params 1, eflags: 0x0
// Checksum 0x8a5b524e, Offset: 0xdf0
// Size: 0x17e
function waitlongdurationwithgameendtimeupdate(duration) {
    if (duration == 0) {
        return;
    }
    assert(duration > 0);
    starttime = gettime();
    endtime = gettime() + duration * 1000;
    while (gettime() < endtime) {
        waittillhostmigrationstarts((endtime - gettime()) / 1000);
        while (isdefined(level.hostmigrationtimer)) {
            endtime += 1000;
            setgameendtime(int(endtime));
            wait 1;
        }
    }
    /#
        if (gettime() != endtime) {
            println("<dev string:x5f>" + gettime() + "<dev string:x7c>" + endtime);
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
// Checksum 0xea85835b, Offset: 0xf78
// Size: 0xd8
function migrationawarewait(durationms) {
    waittillhostmigrationdone();
    endtime = gettime() + durationms;
    timeremaining = durationms;
    while (true) {
        event = level util::waittill_level_any_timeout(timeremaining / 1000, self, "game_ended", "host_migration_begin");
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

