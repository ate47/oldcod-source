#using scripts\core_common\rewindobjects;

#namespace airsupport;

// Namespace airsupport/airsupport
// Params 4, eflags: 0x0
// Checksum 0xb444011a, Offset: 0x90
// Size: 0x8c
function planesounds(*localclientnum, spawnsound, flybysound, flybysoundloop) {
    self endon(#"delete");
    playsound(0, spawnsound, (0, 0, 0));
    if (isdefined(flybysound)) {
        self playsound(0, flybysound);
    }
    self playloopsound(flybysoundloop, 0);
}

// Namespace airsupport/airsupport
// Params 1, eflags: 0x0
// Checksum 0xb082e2af, Offset: 0x128
// Size: 0x22
function getplanemodel(*teamfaction) {
    planemodel = "t5_veh_jet_f4_gearup";
    return planemodel;
}

// Namespace airsupport/airsupport
// Params 5, eflags: 0x0
// Checksum 0x767e82f4, Offset: 0x158
// Size: 0x4c
function planeturnright(localclientnum, plane, yaw, halflife, starttime) {
    planeturn(localclientnum, plane, yaw, halflife, starttime, 1);
}

// Namespace airsupport/airsupport
// Params 5, eflags: 0x0
// Checksum 0xdb1d5741, Offset: 0x1b0
// Size: 0x4c
function planeturnleft(localclientnum, plane, yaw, halflife, starttime) {
    planeturn(localclientnum, plane, yaw, halflife, starttime, 0);
}

// Namespace airsupport/airsupport
// Params 6, eflags: 0x0
// Checksum 0xfe8e05ca, Offset: 0x208
// Size: 0x9d4
function planeturn(localclientnum, plane, yaw, halflife, starttime, isturningright) {
    plane endon(#"delete");
    plane endon(#"death");
    level endon("demo_jump" + localclientnum);
    leftturn = -1;
    rightturn = 1;
    if (isturningright) {
        turndirection = rightturn;
    } else {
        turndirection = leftturn;
    }
    yawy = getdvarfloat(#"scr_planeyaw", -1.5 * turndirection);
    rollz = getdvarfloat(#"scr_planeroll", 1.5 * turndirection);
    maxyaw = getdvarfloat(#"scr_max_planeyaw", -45 * turndirection);
    minroll = getdvarfloat(#"scr_min_planeroll", 60 * turndirection);
    ox = getdvarfloat(#"scr_planeox", 30000);
    oy = getdvarfloat(#"scr_planeoy", -30000 * turndirection);
    maxox = getdvarfloat(#"scr_maxo_planex", -1);
    maxoy = getdvarfloat(#"scr_maxo_planey", -1);
    if (plane.angles[1] == 360) {
        plane.angles = (plane.angles[0], 0, plane.angles[2]);
    }
    origx = plane.origin[0];
    origy = plane.origin[1];
    accumturn = 0;
    looptime = 0.1;
    waitamount = 0.1;
    waitformovedone = 0;
    while (looptime <= halflife) {
        if (plane.angles[1] == 360) {
            plane.angles = (plane.angles[0], 0, plane.angles[2]);
        }
        if (minroll != -1 && plane.angles[2] >= minroll * turndirection) {
            rollz = 0;
        }
        accumturn += yawy;
        if (accumturn <= maxyaw * turndirection) {
            yawy = 0;
        }
        angles = (plane.angles[0], plane.angles[1] + yawy, plane.angles[2] + rollz);
        mathx = sin(45 * looptime / halflife) * ox;
        mathy = cos(45 * looptime / halflife) * oy;
        oldx = mathx;
        oldy = oy - mathy;
        rotatedx = cos(yaw) * oldx - sin(yaw) * oldy;
        rotatedy = sin(yaw) * oldx + cos(yaw) * oldy;
        endpoint = (origx + rotatedx, origy + rotatedy, plane.origin[2]);
        if (waitformovedone) {
            plane waittill(#"movedone");
        }
        waitformovedone = plane rewindobjects::servertimedmoveto(localclientnum, plane.origin, endpoint, starttime, waitamount);
        plane rewindobjects::servertimedrotateto(localclientnum, angles, starttime, waitamount);
        looptime += waitamount;
        starttime += int(waitamount * 1000);
    }
    yawy = getdvarfloat(#"scr_planeyaw2", 1.5);
    rollz = getdvarfloat(#"scr_planeroll2", -0.9);
    ox = getdvarfloat(#"scr_planeox", 30000);
    oy = getdvarfloat(#"scr_planeoy", -30000 * turndirection);
    maxox = getdvarfloat(#"scr_maxo_planex", -1);
    maxoy = getdvarfloat(#"scr_maxo_planey", -1);
    y = getdvarfloat(#"scr_planey2", 0.6);
    z = getdvarfloat(#"scr_planez2", -1.5);
    maxy = getdvarfloat(#"scr_max_planey2", 90);
    accumturn = 0;
    while (looptime < halflife + halflife) {
        if (plane.angles[1] == 360) {
            plane.angles = (plane.angles[0], 0, plane.angles[2]);
        }
        if (minroll != -1 && plane.angles[2] >= 0) {
            rollz = 0;
        }
        accumturn += yawy;
        if (accumturn >= maxyaw) {
            yawy = 0;
        }
        angles = (plane.angles[0], plane.angles[1] + yawy, plane.angles[2] - rollz);
        mathx = sin(45 * looptime / halflife) * ox;
        mathy = cos(45 * looptime / halflife) * oy;
        oldx = mathx;
        oldy = oy - mathy;
        rotatedx = cos(yaw) * oldx - sin(yaw) * oldy;
        rotatedy = sin(yaw) * oldx + cos(yaw) * oldy;
        endpoint = (origx + rotatedx, origy + rotatedy, plane.origin[2]);
        if (waitformovedone) {
            plane waittill(#"movedone");
        }
        waitformovedone = plane rewindobjects::servertimedmoveto(localclientnum, plane.origin, endpoint, starttime, waitamount);
        plane rewindobjects::servertimedrotateto(localclientnum, angles, starttime, waitamount);
        looptime += waitamount;
        starttime += int(waitamount * 1000);
    }
}

// Namespace airsupport/airsupport
// Params 5, eflags: 0x0
// Checksum 0x6233c75a, Offset: 0xbe8
// Size: 0x424
function doabarrelroll(localclientnum, plane, endpoint, flytime, starttime) {
    plane endon(#"death");
    plane endon(#"delete");
    level endon(#"demo_jump");
    origin = plane.origin;
    originalheight = origin[2];
    loopwaittime = getdvarfloat(#"scr_loopwaittime", 0.5);
    loopheightrand = getdvarfloat(#"scr_loopheightrand", 500);
    loopheight = getdvarfloat(#"scr_loopheight", 1200);
    rollz = getdvarfloat(#"scr_barrelroll", 10);
    degreestoroll = getdvarfloat(#"scr_degreestoroll", 360);
    unitsfromcentrepoint = 100;
    timeelapsed = 0;
    degreesrolled = 0;
    waitamount = 0.1;
    loopheight += randomfloatrange(0 - loopheightrand, loopheightrand);
    waitformovedone = 0;
    angles = plane.angles;
    originalroll = plane.angles[2];
    while (timeelapsed < flytime) {
        timeelapsed += waitamount;
        if (timeelapsed > loopwaittime && degreesrolled < degreestoroll) {
            pitch = degreesrolled / 8;
            if (pitch > 22.5) {
                pitch = 45 - pitch;
            }
            originalangle = plane.angles[2];
            scr_degreestoroll = getdvarint(#"scr_degreestoroll", 0);
            if (scr_degreestoroll) {
                plane.angles[1] = 0;
            }
            angles = (0 - pitch, plane.angles[1], originalroll + degreesrolled);
            degreesrolled += rollz;
        }
        ratio = timeelapsed / flytime / 2;
        nextpoint = rewindobjects::getpointonline(origin, endpoint, ratio);
        nextheight = originalheight + loopheight - cos(degreesrolled / 2) * loopheight;
        nextpoint = (nextpoint[0], nextpoint[1], nextheight);
        if (waitformovedone) {
            plane waittill(#"movedone");
        }
        waitformovedone = plane rewindobjects::servertimedmoveto(localclientnum, plane.origin, nextpoint, starttime, waitamount);
        plane rewindobjects::servertimedrotateto(localclientnum, angles, starttime, waitamount);
        starttime += int(waitamount * 1000);
    }
}

// Namespace airsupport/airsupport
// Params 6, eflags: 0x0
// Checksum 0xdb66bf75, Offset: 0x1018
// Size: 0xcc
function planegostraight(localclientnum, plane, startpoint, endpoint, movetime, starttime) {
    plane endon(#"delete");
    level endon(#"demo_jump");
    distanceincreaseratio = 2;
    destpoint = rewindobjects::getpointonline(startpoint, endpoint, distanceincreaseratio);
    if (plane rewindobjects::servertimedmoveto(localclientnum, startpoint, destpoint, starttime, movetime)) {
        plane waittill(#"movedone");
    }
}

