#using scripts\core_common\exploder_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\util;

#namespace fx;

/#

    // Namespace fx/fx
    // Params 4, eflags: 0x0
    // Checksum 0xe11cb696, Offset: 0x88
    // Size: 0x17c
    function print_org(fxcommand, fxid, fxpos, waittime) {
        if (getdvarint(#"debug", 0)) {
            println("<dev string:x38>");
            println("<dev string:x3d>" + fxpos[0] + "<dev string:x4b>" + fxpos[1] + "<dev string:x4b>" + fxpos[2] + "<dev string:x50>");
            println("<dev string:x55>");
            println("<dev string:x73>");
            println("<dev string:x83>" + fxcommand + "<dev string:x50>");
            println("<dev string:x9b>" + fxid + "<dev string:x50>");
            println("<dev string:xae>" + waittime + "<dev string:x50>");
            println("<dev string:xc2>");
        }
    }

#/

// Namespace fx/fx
// Params 8, eflags: 0x0
// Checksum 0x41d8c60c, Offset: 0x210
// Size: 0x6c
function gunfireloopfx(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
    thread gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

// Namespace fx/fx
// Params 8, eflags: 0x0
// Checksum 0xc2b2870f, Offset: 0x288
// Size: 0x1ea
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
// Checksum 0xe87bc484, Offset: 0x480
// Size: 0x74
function gunfireloopfxvec(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
    thread gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

// Namespace fx/fx
// Params 9, eflags: 0x0
// Checksum 0x33833d1c, Offset: 0x500
// Size: 0x282
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
// Checksum 0x6046293b, Offset: 0x790
// Size: 0x5c
function grenadeexplosionfx(pos) {
    playfx(level._effect[#"mechanical explosion"], pos);
    earthquake(0.15, 0.5, pos, 250);
}

