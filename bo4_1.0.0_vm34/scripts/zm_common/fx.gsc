#using scripts\core_common\exploder_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\util;

#namespace fx;

/#

    // Namespace fx/fx
    // Params 4, eflags: 0x0
    // Checksum 0x43bf5d77, Offset: 0x90
    // Size: 0x17c
    function print_org(fxcommand, fxid, fxpos, waittime) {
        if (getdvarint(#"debug", 0)) {
            println("<dev string:x30>");
            println("<dev string:x32>" + fxpos[0] + "<dev string:x3d>" + fxpos[1] + "<dev string:x3d>" + fxpos[2] + "<dev string:x3f>");
            println("<dev string:x41>");
            println("<dev string:x5c>");
            println("<dev string:x69>" + fxcommand + "<dev string:x3f>");
            println("<dev string:x7e>" + fxid + "<dev string:x3f>");
            println("<dev string:x8e>" + waittime + "<dev string:x3f>");
            println("<dev string:x9f>");
        }
    }

#/

// Namespace fx/fx
// Params 8, eflags: 0x0
// Checksum 0xddd76fb6, Offset: 0x218
// Size: 0x74
function gunfireloopfx(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
    thread gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

// Namespace fx/fx
// Params 8, eflags: 0x0
// Checksum 0x8c36c626, Offset: 0x298
// Size: 0x20a
function gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
    level endon(#"stop all gunfireloopfx");
    waitframe(1);
    if (betweensetsmax < betweensetsmin) {
        temp = betweensetsmax;
        betweensetsmax = betweensetsmin;
        betweensetsmin = temp;
    }
    betweensetsbase = betweensetsmin;
    betweensetsrange = betweensetsmax - betweensetsmin;
    if (shotdelaymax < shotdelaymin) {
        temp = shotdelaymax;
        shotdelaymax = shotdelaymin;
        shotdelaymin = temp;
    }
    shotdelaybase = shotdelaymin;
    shotdelayrange = shotdelaymax - shotdelaymin;
    if (shotsmax < shotsmin) {
        temp = shotsmax;
        shotsmax = shotsmin;
        shotsmin = temp;
    }
    shotsbase = shotsmin;
    shotsrange = shotsmax - shotsmin;
    fxent = spawnfx(level._effect[fxid], fxpos);
    for (;;) {
        shotnum = shotsbase + randomint(shotsrange);
        for (i = 0; i < shotnum; i++) {
            triggerfx(fxent);
            wait shotdelaybase + randomfloat(shotdelayrange);
        }
        wait betweensetsbase + randomfloat(betweensetsrange);
    }
}

// Namespace fx/fx
// Params 9, eflags: 0x0
// Checksum 0xd3f1584a, Offset: 0x4b0
// Size: 0x84
function gunfireloopfxvec(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
    thread gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

// Namespace fx/fx
// Params 9, eflags: 0x0
// Checksum 0x4934e320, Offset: 0x540
// Size: 0x29a
function gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
    level endon(#"stop all gunfireloopfx");
    waitframe(1);
    if (betweensetsmax < betweensetsmin) {
        temp = betweensetsmax;
        betweensetsmax = betweensetsmin;
        betweensetsmin = temp;
    }
    betweensetsbase = betweensetsmin;
    betweensetsrange = betweensetsmax - betweensetsmin;
    if (shotdelaymax < shotdelaymin) {
        temp = shotdelaymax;
        shotdelaymax = shotdelaymin;
        shotdelaymin = temp;
    }
    shotdelaybase = shotdelaymin;
    shotdelayrange = shotdelaymax - shotdelaymin;
    if (shotsmax < shotsmin) {
        temp = shotsmax;
        shotsmax = shotsmin;
        shotsmin = temp;
    }
    shotsbase = shotsmin;
    shotsrange = shotsmax - shotsmin;
    fxpos2 = vectornormalize(fxpos2 - fxpos);
    fxent = spawnfx(level._effect[fxid], fxpos, fxpos2);
    for (;;) {
        shotnum = shotsbase + randomint(shotsrange);
        for (i = 0; i < int(shotnum / level.fxfireloopmod); i++) {
            triggerfx(fxent);
            delay = (shotdelaybase + randomfloat(shotdelayrange)) * level.fxfireloopmod;
            if (delay < 0.05) {
                delay = 0.05;
            }
            wait delay;
        }
        wait shotdelaybase + randomfloat(shotdelayrange);
        wait betweensetsbase + randomfloat(betweensetsrange);
    }
}

// Namespace fx/fx
// Params 1, eflags: 0x0
// Checksum 0x76e87e94, Offset: 0x7e8
// Size: 0x5c
function grenadeexplosionfx(pos) {
    playfx(level._effect[#"hash_38faf2be38a9b539"], pos);
    earthquake(0.15, 0.5, pos, 250);
}

