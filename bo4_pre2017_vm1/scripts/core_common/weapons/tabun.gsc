#using scripts/core_common/sound_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;

#namespace tabun;

// Namespace tabun/tabun
// Params 0, eflags: 0x0
// Checksum 0x9ae1706a, Offset: 0x3f0
// Size: 0x37c
function init_shared() {
    level.tabuninitialgasshockduration = getdvarint("scr_tabunInitialGasShockDuration", "7");
    level.tabunwalkingasshockduration = getdvarint("scr_tabunWalkInGasShockDuration", "4");
    level.tabungasshockradius = getdvarint("scr_tabun_shock_radius", "185");
    level.tabungasshockheight = getdvarint("scr_tabun_shock_height", "20");
    level.tabungaspoisonradius = getdvarint("scr_tabun_effect_radius", "185");
    level.tabungaspoisonheight = getdvarint("scr_tabun_shock_height", "20");
    level.tabungasduration = getdvarint("scr_tabunGasDuration", "8");
    level.poisonduration = getdvarint("scr_poisonDuration", "8");
    level.poisondamage = getdvarint("scr_poisonDamage", "13");
    level.poisondamagehardcore = getdvarint("scr_poisonDamageHardcore", "5");
    level.fx_tabun_0 = "tabun_tiny_mp";
    level.fx_tabun_1 = "tabun_small_mp";
    level.fx_tabun_2 = "tabun_medium_mp";
    level.fx_tabun_3 = "tabun_large_mp";
    level.fx_tabun_single = "tabun_center_mp";
    level.fx_tabun_radius0 = getdvarint("scr_fx_tabun_radius0", 55);
    level.fx_tabun_radius1 = getdvarint("scr_fx_tabun_radius1", 55);
    level.fx_tabun_radius2 = getdvarint("scr_fx_tabun_radius2", 50);
    level.fx_tabun_radius3 = getdvarint("scr_fx_tabun_radius3", 25);
    level.sound_tabun_start = "wpn_gas_hiss_start";
    level.sound_tabun_loop = "wpn_gas_hiss_lp";
    level.sound_tabun_stop = "wpn_gas_hiss_end";
    level.sound_shock_tabun_start = "";
    level.sound_shock_tabun_loop = "";
    level.sound_shock_tabun_stop = "";
    /#
        level thread checkdvarupdates();
    #/
}

// Namespace tabun/tabun
// Params 0, eflags: 0x0
// Checksum 0x6c965141, Offset: 0x778
// Size: 0x2bc
function checkdvarupdates() {
    while (true) {
        level.tabungaspoisonradius = getdvarint("scr_tabun_effect_radius", level.tabungaspoisonradius);
        level.tabungaspoisonheight = getdvarint("scr_tabun_shock_height", level.tabungaspoisonheight);
        level.tabungasshockradius = getdvarint("scr_tabun_shock_radius", level.tabungasshockradius);
        level.tabungasshockheight = getdvarint("scr_tabun_shock_height", level.tabungasshockheight);
        level.tabuninitialgasshockduration = getdvarint("scr_tabunInitialGasShockDuration", level.tabuninitialgasshockduration);
        level.tabunwalkingasshockduration = getdvarint("scr_tabunWalkInGasShockDuration", level.tabunwalkingasshockduration);
        level.tabungasduration = getdvarint("scr_tabunGasDuration", level.tabungasduration);
        level.poisonduration = getdvarint("scr_poisonDuration", level.poisonduration);
        level.poisondamage = getdvarint("scr_poisonDamage", level.poisondamage);
        level.poisondamagehardcore = getdvarint("scr_poisonDamageHardcore", level.poisondamagehardcore);
        level.fx_tabun_radius0 = getdvarint("scr_fx_tabun_radius0", level.fx_tabun_radius0);
        level.fx_tabun_radius1 = getdvarint("scr_fx_tabun_radius1", level.fx_tabun_radius1);
        level.fx_tabun_radius2 = getdvarint("scr_fx_tabun_radius2", level.fx_tabun_radius2);
        level.fx_tabun_radius3 = getdvarint("scr_fx_tabun_radius3", level.fx_tabun_radius3);
        wait 1;
    }
}

// Namespace tabun/tabun
// Params 1, eflags: 0x0
// Checksum 0x89548cb4, Offset: 0xa40
// Size: 0xfc
function watchtabungrenadedetonation(owner) {
    self endon(#"trophy_destroyed");
    waitresult = self waittill("explode");
    if (!isdefined(level.water_duds) || level.water_duds == 1) {
        if (isdefined(waitresult.stype) && waitresult.stype == "water") {
            return;
        }
    }
    if (getdvarint("scr_enable_new_tabun", 1)) {
        generatelocations(waitresult.position, owner);
        return;
    }
    singlelocation(waitresult.position, owner);
}

// Namespace tabun/tabun
// Params 5, eflags: 0x0
// Checksum 0x2f72f33e, Offset: 0xb48
// Size: 0x424
function damageeffectarea(owner, position, radius, height, killcament) {
    shockeffectarea = spawn("trigger_radius", position, 0, radius, height);
    gaseffectarea = spawn("trigger_radius", position, 0, radius, height);
    /#
        if (getdvarint("<dev string:x28>")) {
            level thread util::drawcylinder(position, radius, height, undefined, "<dev string:x3a>");
        }
    #/
    if (isdefined(level.dogsonflashdogs)) {
        owner thread [[ level.dogsonflashdogs ]](shockeffectarea);
        owner thread [[ level.dogsonflashdogs ]](gaseffectarea);
    }
    loopwaittime = 0.5;
    for (durationoftabun = level.tabungasduration; durationoftabun > 0; durationoftabun -= loopwaittime) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (level.friendlyfire == 0) {
                if (players[i] != owner) {
                    if (!isdefined(owner) || !isdefined(owner.team)) {
                        continue;
                    }
                    if (level.teambased && players[i].team == owner.team) {
                        continue;
                    }
                }
            }
            if (!isdefined(players[i].inpoisonarea) || players[i].inpoisonarea == 0) {
                if (players[i] istouching(gaseffectarea) && players[i].sessionstate == "playing") {
                    if (!players[i] hasperk("specialty_proximityprotection")) {
                        trace = bullettrace(position, players[i].origin + (0, 0, 12), 0, players[i]);
                        if (trace["fraction"] == 1) {
                            players[i].lastpoisonedby = owner;
                            players[i] thread damageinpoisonarea(shockeffectarea, killcament, trace, position);
                        }
                    }
                }
            }
        }
        wait loopwaittime;
    }
    if (level.tabungasduration < level.poisonduration) {
        wait level.poisonduration - level.tabungasduration;
    }
    shockeffectarea delete();
    gaseffectarea delete();
    /#
        if (getdvarint("<dev string:x28>")) {
            level notify(#"tabun_draw_cylinder_stop");
        }
    #/
}

// Namespace tabun/tabun
// Params 4, eflags: 0x0
// Checksum 0xa4ff89f8, Offset: 0xf78
// Size: 0x3f8
function damageinpoisonarea(gaseffectarea, killcament, trace, position) {
    self endon(#"disconnect");
    self endon(#"death");
    self thread watch_death();
    self.inpoisonarea = 1;
    self startpoisoning();
    tabunshocksound = spawn("script_origin", (0, 0, 1));
    tabunshocksound thread deleteentonownerdeath(self);
    tabunshocksound.origin = position;
    tabunshocksound playsound(level.sound_shock_tabun_start);
    tabunshocksound playloopsound(level.sound_shock_tabun_loop);
    timer = 0;
    while (trace["fraction"] == 1 && isdefined(gaseffectarea) && self istouching(gaseffectarea) && self.sessionstate == "playing" && isdefined(self.lastpoisonedby)) {
        damage = level.poisondamage;
        if (level.hardcoremode) {
            damage = level.poisondamagehardcore;
        }
        self dodamage(damage, gaseffectarea.origin, self.lastpoisonedby, killcament, "none", "MOD_GAS", 0, getweapon("tabun_gas"));
        if (self util::mayapplyscreeneffect()) {
            switch (timer) {
            case 0:
                self shellshock("tabun_gas_mp", 1);
                break;
            case 1:
                self shellshock("tabun_gas_nokick_mp", 1);
                break;
            default:
                break;
            }
            timer++;
            if (timer >= 2) {
                timer = 0;
            }
            self val::set("tabun", "show_hud", 0);
        }
        wait 1;
        trace = bullettrace(position, self.origin + (0, 0, 12), 0, self);
    }
    tabunshocksound stoploopsound(0.5);
    wait 0.5;
    thread sound::play_in_space(level.sound_shock_tabun_stop, position);
    wait 0.5;
    tabunshocksound notify(#"delete");
    tabunshocksound delete();
    self val::reset("tabun", "show_hud");
    self stoppoisoning();
    self.inpoisonarea = 0;
}

// Namespace tabun/tabun
// Params 1, eflags: 0x0
// Checksum 0x94bd2f58, Offset: 0x1378
// Size: 0x3c
function deleteentonownerdeath(owner) {
    self endon(#"delete");
    owner waittill("death");
    self delete();
}

// Namespace tabun/tabun
// Params 0, eflags: 0x0
// Checksum 0x46cd65c1, Offset: 0x13c0
// Size: 0x34
function watch_death() {
    self waittill("death");
    self val::reset("tabun", "show_hud");
}

// Namespace tabun/tabun
// Params 2, eflags: 0x0
// Checksum 0x92958ed6, Offset: 0x1400
// Size: 0xd4
function generatelocations(position, owner) {
    onefoot = (0, 0, 12);
    startpos = position + onefoot;
    /#
        level.tabun_debug = getdvarint("<dev string:x53>", 0);
        if (level.tabun_debug) {
            black = (0.2, 0.2, 0.2);
            debugstar(startpos, 2000, black);
        }
    #/
    spawnalllocs(owner, startpos);
}

// Namespace tabun/tabun
// Params 2, eflags: 0x0
// Checksum 0x48042a54, Offset: 0x14e0
// Size: 0xd4
function singlelocation(position, owner) {
    spawntimedfx(level.fx_tabun_single, position);
    killcament = spawn("script_model", position + (0, 0, 60));
    killcament util::deleteaftertime(15);
    killcament.starttime = gettime();
    damageeffectarea(owner, position, level.tabungaspoisonradius, level.tabungaspoisonheight, killcament);
}

// Namespace tabun/tabun
// Params 3, eflags: 0x0
// Checksum 0xc71f67f0, Offset: 0x15c0
// Size: 0xe0
function hitpos(start, end, color) {
    trace = bullettrace(start, end, 0, undefined);
    /#
        level.tabun_debug = getdvarint("<dev string:x53>", 0);
        if (level.tabun_debug) {
            debugstar(trace["<dev string:x63>"], 2000, color);
        }
        thread tabun_debug_line(start, trace["<dev string:x63>"], color, 1, 80);
    #/
    return trace["position"];
}

// Namespace tabun/tabun
// Params 2, eflags: 0x0
// Checksum 0x8a3e289f, Offset: 0x16a8
// Size: 0x9a6
function spawnalllocs(owner, startpos) {
    defaultdistance = getdvarint("scr_defaultDistanceTabun", 220);
    cos45 = 0.707;
    negcos45 = -0.707;
    red = (0.9, 0.2, 0.2);
    blue = (0.2, 0.2, 0.9);
    green = (0.2, 0.9, 0.2);
    white = (0.9, 0.9, 0.9);
    north = startpos + (defaultdistance, 0, 0);
    south = startpos - (defaultdistance, 0, 0);
    east = startpos + (0, defaultdistance, 0);
    west = startpos - (0, defaultdistance, 0);
    nw = startpos + (cos45 * defaultdistance, negcos45 * defaultdistance, 0);
    ne = startpos + (cos45 * defaultdistance, cos45 * defaultdistance, 0);
    sw = startpos + (negcos45 * defaultdistance, negcos45 * defaultdistance, 0);
    se = startpos + (negcos45 * defaultdistance, cos45 * defaultdistance, 0);
    locations = [];
    locations["color"] = [];
    locations["loc"] = [];
    locations["tracePos"] = [];
    locations["distSqrd"] = [];
    locations["fxtoplay"] = [];
    locations["radius"] = [];
    locations["color"][0] = red;
    locations["color"][1] = red;
    locations["color"][2] = blue;
    locations["color"][3] = blue;
    locations["color"][4] = green;
    locations["color"][5] = green;
    locations["color"][6] = white;
    locations["color"][7] = white;
    locations["point"][0] = north;
    locations["point"][1] = ne;
    locations["point"][2] = east;
    locations["point"][3] = se;
    locations["point"][4] = south;
    locations["point"][5] = sw;
    locations["point"][6] = west;
    locations["point"][7] = nw;
    for (count = 0; count < 8; count++) {
        trace = hitpos(startpos, locations["point"][count], locations["color"][count]);
        locations["tracePos"][count] = trace;
        locations["loc"][count] = startpos / 2 + trace / 2;
        locations["loc"][count] = locations["loc"][count] - (0, 0, 12);
        locations["distSqrd"][count] = distancesquared(startpos, trace);
    }
    centroid = getcenteroflocations(locations);
    killcament = spawn("script_model", centroid + (0, 0, 60));
    killcament util::deleteaftertime(15);
    killcament.starttime = gettime();
    center = getcenter(locations);
    for (i = 0; i < 8; i++) {
        fxtoplay = setuptabunfx(owner, locations, i);
        switch (fxtoplay) {
        case 0:
            locations["fxtoplay"][i] = level.fx_tabun_0;
            locations["radius"][i] = level.fx_tabun_radius0;
            break;
        case 1:
            locations["fxtoplay"][i] = level.fx_tabun_1;
            locations["radius"][i] = level.fx_tabun_radius1;
            break;
        case 2:
            locations["fxtoplay"][i] = level.fx_tabun_2;
            locations["radius"][i] = level.fx_tabun_radius2;
            break;
        case 3:
            locations["fxtoplay"][i] = level.fx_tabun_3;
            locations["radius"][i] = level.fx_tabun_radius3;
            break;
        default:
            locations["fxtoplay"][i] = undefined;
            locations["radius"][i] = 0;
            break;
        }
    }
    singleeffect = 1;
    freepassused = 0;
    for (i = 0; i < 8; i++) {
        if (locations["radius"][i] != level.fx_tabun_radius0) {
            if (freepassused == 0 && locations["radius"][i] == level.fx_tabun_radius1) {
                freepassused = 1;
                continue;
            }
            singleeffect = 0;
        }
    }
    onefoot = (0, 0, 12);
    startpos -= onefoot;
    thread playtabunsound(startpos);
    if (singleeffect == 1) {
        singlelocation(startpos, owner);
        return;
    }
    spawntimedfx(level.fx_tabun_3, startpos);
    for (count = 0; count < 8; count++) {
        if (isdefined(locations["fxtoplay"][count])) {
            spawntimedfx(locations["fxtoplay"][count], locations["loc"][count]);
            thread damageeffectarea(owner, locations["loc"][count], locations["radius"][count], locations["radius"][count], killcament);
        }
    }
}

// Namespace tabun/tabun
// Params 1, eflags: 0x0
// Checksum 0xb33bfbec, Offset: 0x2058
// Size: 0xfc
function playtabunsound(position) {
    tabunsound = spawn("script_origin", (0, 0, 1));
    tabunsound.origin = position;
    tabunsound playsound(level.sound_tabun_start);
    tabunsound playloopsound(level.sound_tabun_loop);
    wait level.tabungasduration;
    thread sound::play_in_space(level.sound_tabun_stop, position);
    tabunsound stoploopsound(0.5);
    wait 0.5;
    tabunsound delete();
}

// Namespace tabun/tabun
// Params 3, eflags: 0x0
// Checksum 0xc8af2f79, Offset: 0x2160
// Size: 0x306
function setuptabunfx(owner, locations, count) {
    fxtoplay = undefined;
    previous = count - 1;
    if (previous < 0) {
        previous += locations["loc"].size;
    }
    next = count + 1;
    if (next >= locations["loc"].size) {
        next -= locations["loc"].size;
    }
    effect0dist = level.fx_tabun_radius0 * level.fx_tabun_radius0;
    effect1dist = level.fx_tabun_radius1 * level.fx_tabun_radius1;
    effect2dist = level.fx_tabun_radius2 * level.fx_tabun_radius2;
    effect3dist = level.fx_tabun_radius3 * level.fx_tabun_radius3;
    effect4dist = level.fx_tabun_radius3;
    fxtoplay = -1;
    if (locations["distSqrd"][count] > effect0dist && locations["distSqrd"][previous] > effect1dist && locations["distSqrd"][next] > effect1dist) {
        fxtoplay = 0;
    } else if (locations["distSqrd"][count] > effect1dist && locations["distSqrd"][previous] > effect2dist && locations["distSqrd"][next] > effect2dist) {
        fxtoplay = 1;
    } else if (locations["distSqrd"][count] > effect2dist && locations["distSqrd"][previous] > effect3dist && locations["distSqrd"][next] > effect3dist) {
        fxtoplay = 2;
    } else if (locations["distSqrd"][count] > effect3dist && locations["distSqrd"][previous] > effect4dist && locations["distSqrd"][next] > effect4dist) {
        fxtoplay = 3;
    }
    return fxtoplay;
}

// Namespace tabun/tabun
// Params 1, eflags: 0x0
// Checksum 0x815ba70e, Offset: 0x2470
// Size: 0x108
function getcenteroflocations(locations) {
    centroid = (0, 0, 0);
    for (i = 0; i < locations["loc"].size; i++) {
        centroid += locations["loc"][i] / locations["loc"].size;
    }
    /#
        level.tabun_debug = getdvarint("<dev string:x53>", 0);
        if (level.tabun_debug) {
            purple = (0.9, 0.2, 0.9);
            debugstar(centroid, 2000, purple);
        }
    #/
    return centroid;
}

// Namespace tabun/tabun
// Params 1, eflags: 0x0
// Checksum 0xb16493be, Offset: 0x2580
// Size: 0x270
function getcenter(locations) {
    center = (0, 0, 0);
    curx = locations["tracePos"][0][0];
    cury = locations["tracePos"][0][1];
    minx = curx;
    maxx = curx;
    miny = cury;
    maxy = cury;
    for (i = 1; i < locations["tracePos"].size; i++) {
        curx = locations["tracePos"][i][0];
        cury = locations["tracePos"][i][1];
        if (curx > maxx) {
            maxx = curx;
        } else if (curx < minx) {
            minx = curx;
        }
        if (cury > maxy) {
            maxy = cury;
            continue;
        }
        if (cury < miny) {
            miny = cury;
        }
    }
    avgx = (maxx + minx) / 2;
    avgy = (maxy + miny) / 2;
    center = (avgx, avgy, locations["tracePos"][0][2]);
    /#
        level.tabun_debug = getdvarint("<dev string:x53>", 0);
        if (level.tabun_debug) {
            cyan = (0.2, 0.9, 0.9);
            debugstar(center, 2000, cyan);
        }
    #/
    return center;
}

/#

    // Namespace tabun/tabun
    // Params 5, eflags: 0x0
    // Checksum 0xa607c49f, Offset: 0x27f8
    // Size: 0xbc
    function tabun_debug_line(from, to, color, depthtest, time) {
        debug_rcbomb = getdvarint("<dev string:x53>", 0);
        if (debug_rcbomb == "<dev string:x6c>") {
            if (!isdefined(time)) {
                time = 100;
            }
            if (!isdefined(depthtest)) {
                depthtest = 1;
            }
            line(from, to, color, 1, depthtest, time);
        }
    }

#/
