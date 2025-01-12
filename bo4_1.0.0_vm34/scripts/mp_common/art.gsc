#using scripts\core_common\system_shared;

#namespace art;

// Namespace art/art
// Params 0, eflags: 0x2
// Checksum 0xd4c15adc, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"art", &__init__, undefined, undefined);
}

// Namespace art/art
// Params 0, eflags: 0x0
// Checksum 0xa08c1987, Offset: 0xc0
// Size: 0x12c
function __init__() {
    if (!isdefined(level.dofdefault)) {
        level.dofdefault[#"nearstart"] = 0;
        level.dofdefault[#"nearend"] = 1;
        level.dofdefault[#"farstart"] = 8000;
        level.dofdefault[#"farend"] = 10000;
        level.dofdefault[#"nearblur"] = 6;
        level.dofdefault[#"farblur"] = 0;
    }
    level.curdof = (level.dofdefault[#"farstart"] - level.dofdefault[#"nearend"]) / 2;
    /#
        thread tweakart();
    #/
}

/#

    // Namespace art/art
    // Params 2, eflags: 0x0
    // Checksum 0xebe9fdf3, Offset: 0x1f8
    // Size: 0x44
    function artfxprintln(file, string) {
        if (file == -1) {
            return;
        }
        fprintln(file, string);
    }

#/

// Namespace art/art
// Params 2, eflags: 0x0
// Checksum 0x10b32058, Offset: 0x248
// Size: 0xc8
function strtok_loc(string, par1) {
    stringlist = [];
    indexstring = "";
    for (i = 0; i < string.size; i++) {
        if (string[i] == " ") {
            stringlist[stringlist.size] = indexstring;
            indexstring = "";
            continue;
        }
        indexstring += string[i];
    }
    if (indexstring.size) {
        stringlist[stringlist.size] = indexstring;
    }
    return stringlist;
}

// Namespace art/art
// Params 0, eflags: 0x0
// Checksum 0xb9a78252, Offset: 0x318
// Size: 0x1b4
function setfogsliders() {
    fogall = strtok_loc(getdvarstring(#"g_fogcolorreadonly"), " ");
    red = fogall[0];
    green = fogall[1];
    blue = fogall[2];
    halfplane = getdvarstring(#"g_foghalfdistreadonly");
    nearplane = getdvarstring(#"g_fogstartdistreadonly");
    if (!isdefined(red) || !isdefined(green) || !isdefined(blue) || !isdefined(halfplane)) {
        red = 1;
        green = 1;
        blue = 1;
        halfplane = 10000001;
        nearplane = 10000000;
    }
    setdvar(#"scr_fog_exp_halfplane", halfplane);
    setdvar(#"scr_fog_nearplane", nearplane);
    setdvar(#"scr_fog_color", red + " " + green + " " + blue);
}

/#

    // Namespace art/art
    // Params 0, eflags: 0x0
    // Checksum 0xbebb0d6c, Offset: 0x4d8
    // Size: 0xb00
    function tweakart() {
        if (!isdefined(level.tweakfile)) {
            level.tweakfile = 0;
        }
        if (getdvarstring(#"scr_fog_baseheight") == "<dev string:x30>") {
            setdvar(#"scr_fog_exp_halfplane", 500);
            setdvar(#"scr_fog_exp_halfheight", 500);
            setdvar(#"scr_fog_nearplane", 0);
            setdvar(#"scr_fog_baseheight", 0);
        }
        setdvar(#"scr_fog_fraction", 1);
        setdvar(#"scr_art_dump", 0);
        setdvar(#"scr_art_sun_fog_dir_set", 0);
        setdvar(#"scr_dof_nearstart", level.dofdefault[#"nearstart"]);
        setdvar(#"scr_dof_nearend", level.dofdefault[#"nearend"]);
        setdvar(#"scr_dof_farstart", level.dofdefault[#"farstart"]);
        setdvar(#"scr_dof_farend", level.dofdefault[#"farend"]);
        setdvar(#"scr_dof_nearblur", level.dofdefault[#"nearblur"]);
        setdvar(#"scr_dof_farblur", level.dofdefault[#"farblur"]);
        file = undefined;
        filename = undefined;
        tweak_toggle = 1;
        for (;;) {
            while (getdvarint(#"scr_art_tweak", 0) == 0) {
                tweak_toggle = 1;
                waitframe(1);
            }
            if (tweak_toggle) {
                tweak_toggle = 0;
                fogsettings = getfogsettings();
                setdvar(#"scr_fog_nearplane", fogsettings[0]);
                setdvar(#"scr_fog_exp_halfplane", fogsettings[1]);
                setdvar(#"scr_fog_exp_halfheight", fogsettings[3]);
                setdvar(#"scr_fog_baseheight", fogsettings[2]);
                setdvar(#"scr_fog_color", fogsettings[4] + "<dev string:x31>" + fogsettings[5] + "<dev string:x31>" + fogsettings[6]);
                setdvar(#"scr_fog_color_scale", fogsettings[7]);
                setdvar(#"scr_sun_fog_color", fogsettings[8] + "<dev string:x31>" + fogsettings[9] + "<dev string:x31>" + fogsettings[10]);
                level.fogsundir = [];
                level.fogsundir[0] = fogsettings[11];
                level.fogsundir[1] = fogsettings[12];
                level.fogsundir[2] = fogsettings[13];
                setdvar(#"scr_sun_fog_start_angle", fogsettings[14]);
                setdvar(#"scr_sun_fog_end_angle", fogsettings[15]);
                setdvar(#"scr_fog_max_opacity", fogsettings[16]);
            }
            level.fogexphalfplane = getdvarfloat(#"scr_fog_exp_halfplane", 0);
            level.fogexphalfheight = getdvarfloat(#"scr_fog_exp_halfheight", 0);
            level.fognearplane = getdvarfloat(#"scr_fog_nearplane", 0);
            level.fogbaseheight = getdvarfloat(#"scr_fog_baseheight", 0);
            colors = strtok(getdvarstring(#"scr_fog_color"), "<dev string:x31>");
            level.fogcolorred = int(colors[0]);
            level.fogcolorgreen = int(colors[1]);
            level.fogcolorblue = int(colors[2]);
            level.fogcolorscale = getdvarfloat(#"scr_fog_color_scale", 0);
            colors = strtok(getdvarstring(#"scr_sun_fog_color"), "<dev string:x31>");
            level.sunfogcolorred = int(colors[0]);
            level.sunfogcolorgreen = int(colors[1]);
            level.sunfogcolorblue = int(colors[2]);
            level.sunstartangle = getdvarfloat(#"scr_sun_fog_start_angle", 0);
            level.sunendangle = getdvarfloat(#"scr_sun_fog_end_angle", 0);
            level.fogmaxopacity = getdvarfloat(#"scr_fog_max_opacity", 0);
            if (getdvarint(#"scr_art_sun_fog_dir_set", 0)) {
                setdvar(#"scr_art_sun_fog_dir_set", 0);
                println("<dev string:x33>");
                players = getplayers();
                dir = vectornormalize(anglestoforward(players[0] getplayerangles()));
                level.fogsundir = [];
                level.fogsundir[0] = dir[0];
                level.fogsundir[1] = dir[1];
                level.fogsundir[2] = dir[2];
            }
            fovslidercheck();
            dumpsettings();
            if (!getdvarint(#"scr_fog_disable", 0)) {
                if (!isdefined(level.fogsundir)) {
                    level.fogsundir = [];
                    level.fogsundir[0] = 1;
                    level.fogsundir[1] = 0;
                    level.fogsundir[2] = 0;
                }
                setvolfog(level.fognearplane, level.fogexphalfplane, level.fogexphalfheight, level.fogbaseheight, level.fogcolorred, level.fogcolorgreen, level.fogcolorblue, level.fogcolorscale, level.sunfogcolorred, level.sunfogcolorgreen, level.sunfogcolorblue, level.fogsundir[0], level.fogsundir[1], level.fogsundir[2], level.sunstartangle, level.sunendangle, 0, level.fogmaxopacity);
            } else {
                setexpfog(100000000, 100000001, 0, 0, 0, 0);
            }
            wait 0.1;
        }
    }

#/

// Namespace art/art
// Params 0, eflags: 0x0
// Checksum 0x543a2d56, Offset: 0xfe0
// Size: 0x424
function fovslidercheck() {
    if (level.dofdefault[#"nearstart"] >= level.dofdefault[#"nearend"]) {
        level.dofdefault[#"nearstart"] = level.dofdefault[#"nearend"] - 1;
        setdvar(#"scr_dof_nearstart", level.dofdefault[#"nearstart"]);
    }
    if (level.dofdefault[#"nearend"] <= level.dofdefault[#"nearstart"]) {
        level.dofdefault[#"nearend"] = level.dofdefault[#"nearstart"] + 1;
        setdvar(#"scr_dof_nearend", level.dofdefault[#"nearend"]);
    }
    if (level.dofdefault[#"farstart"] >= level.dofdefault[#"farend"]) {
        level.dofdefault[#"farstart"] = level.dofdefault[#"farend"] - 1;
        setdvar(#"scr_dof_farstart", level.dofdefault[#"farstart"]);
    }
    if (level.dofdefault[#"farend"] <= level.dofdefault[#"farstart"]) {
        level.dofdefault[#"farend"] = level.dofdefault[#"farstart"] + 1;
        setdvar(#"scr_dof_farend", level.dofdefault[#"farend"]);
    }
    if (level.dofdefault[#"farblur"] >= level.dofdefault[#"nearblur"]) {
        level.dofdefault[#"farblur"] = level.dofdefault[#"nearblur"] - 0.1;
        setdvar(#"scr_dof_farblur", level.dofdefault[#"farblur"]);
    }
    if (level.dofdefault[#"farstart"] <= level.dofdefault[#"nearend"]) {
        level.dofdefault[#"farstart"] = level.dofdefault[#"nearend"] + 1;
        setdvar(#"scr_dof_farstart", level.dofdefault[#"farstart"]);
    }
}

/#

    // Namespace art/art
    // Params 0, eflags: 0x0
    // Checksum 0x162e970f, Offset: 0x1410
    // Size: 0x40c
    function dumpsettings() {
        if (getdvar(#"scr_art_dump", 0)) {
            println("<dev string:x61>" + level.fognearplane + "<dev string:x70>");
            println("<dev string:x72>" + level.fogexphalfplane + "<dev string:x70>");
            println("<dev string:x80>" + level.fogexphalfheight + "<dev string:x70>");
            println("<dev string:x90>" + level.fogbaseheight + "<dev string:x70>");
            println("<dev string:xa0>" + level.fogcolorred + "<dev string:x70>");
            println("<dev string:xaa>" + level.fogcolorgreen + "<dev string:x70>");
            println("<dev string:xb4>" + level.fogcolorblue + "<dev string:x70>");
            println("<dev string:xbe>" + level.fogcolorscale + "<dev string:x70>");
            println("<dev string:xcc>" + level.sunfogcolorred + "<dev string:x70>");
            println("<dev string:xda>" + level.sunfogcolorgreen + "<dev string:x70>");
            println("<dev string:xe8>" + level.sunfogcolorblue + "<dev string:x70>");
            println("<dev string:xf6>" + level.fogsundir[0] + "<dev string:x70>");
            println("<dev string:x104>" + level.fogsundir[1] + "<dev string:x70>");
            println("<dev string:x112>" + level.fogsundir[2] + "<dev string:x70>");
            println("<dev string:x120>" + level.sunstartangle + "<dev string:x70>");
            println("<dev string:x132>" + level.sunendangle + "<dev string:x70>");
            println("<dev string:x143>");
            println("<dev string:x14e>" + level.fogmaxopacity + "<dev string:x70>");
            println("<dev string:x30>");
            println("<dev string:x162>");
            println("<dev string:x1be>");
            println("<dev string:x212>");
            setdvar(#"scr_art_dump", 0);
        }
    }

#/
