#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/globallogic/globallogic_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/killcam_shared;
#using scripts/core_common/spectating;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace potm;

// Namespace potm/potm_shared
// Params 0, eflags: 0x2
// Checksum 0xe90f1a14, Offset: 0x320
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("potm", &__init__, undefined, undefined);
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xb5228e7, Offset: 0x360
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xdaba64d5, Offset: 0x390
// Size: 0x84
function init() {
    level.potm_enabled = getgametypesetting("allowPlayOfTheMatch");
    level.potm_max_events = getgametypesetting("maxPlayOfTheMatchEvents");
    level.var_7a4c1316 = 0;
    level.potmevents = [];
    /#
        debuginit();
    #/
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xdc06c9c1, Offset: 0x420
// Size: 0x1e
function isenabled() {
    return isdefined(level.potm_enabled) && level.potm_enabled;
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0x99f50f3c, Offset: 0x448
// Size: 0x6c
function post_round_potm() {
    if (!isenabled()) {
        return;
    }
    if (!util::waslastround()) {
        /#
            println("<dev string:x28>");
        #/
        return;
    }
    level notify(#"play_potm");
    level waittill("potm_finished");
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0x45426bb0, Offset: 0x4c0
// Size: 0x43a
function play_potm_on_player_internal(eventindex) {
    eventsettings = level.potmevents[eventindex];
    postdeathdelay = (gettime() - eventsettings.deathtime) / 1000;
    predelay = postdeathdelay + eventsettings.deathtimeoffset;
    killcamentitystarttime = killcam::get_killcam_entity_info_starttime(eventsettings.killcam_entity_info);
    camtime = killcam::calc_time(eventsettings.weapon, killcamentitystarttime, predelay, 0, undefined);
    postdelay = killcam::calc_post_delay();
    killcamoffset = camtime + predelay;
    killcamlength = camtime + postdelay - 0.05;
    killcamstarttime = gettime() - killcamoffset * 1000;
    self notify(#"begin_killcam", {#start_time:gettime()});
    self.sessionstate = "spectator";
    self.spectatorclient = eventsettings.spectatorclient;
    self.killcamentity = -1;
    self thread killcam::set_killcam_entities(eventsettings.killcam_entity_info, killcamstarttime);
    self.killcamtargetentity = eventsettings.targetentityindex;
    self.killcamweapon = eventsettings.weapon;
    self.killcammod = eventsettings.meansofdeath;
    self.archivetime = killcamoffset;
    self.killcamlength = killcamlength;
    self.psoffsettime = eventsettings.offsettime;
    foreach (team in level.teams) {
        self allowspectateteam(team, 1);
    }
    self allowspectateteam("freelook", 1);
    self allowspectateteam("none", 1);
    self thread killcam::function_5551058f();
    waitframe(1);
    if (self.archivetime <= predelay) {
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        self notify(#"end_killcam");
        return;
    }
    self thread killcam::check_for_abrupt_end();
    self.killcam = 1;
    if (!self issplitscreen()) {
        self killcam::function_a6953bec(camtime);
    }
    self thread killcam::wait_killcam_time();
    self thread killcam::wait_final_killcam_slowdown(eventsettings.deathtime, killcamstarttime);
    self waittill("end_killcam");
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0xe7b4ab43, Offset: 0x908
// Size: 0xa4
function play_potm_on_player(eventindex) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    luinotifyevent(%potm_fadeout);
    play_potm_on_player_internal(eventindex);
    luinotifyevent(%potm_fadein);
    wait 1;
    self freezecontrols(1);
    self killcam::end(1);
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xe659036d, Offset: 0x9b8
// Size: 0x36c
function play_potm() {
    if (isdefined(level.var_b363408a) && level.var_b363408a) {
        return;
    }
    level.var_b363408a = 1;
    level waittill("play_potm");
    level.infinalkillcam = 1;
    visionsetnaked(getdvarstring("mapname"), 0);
    setmatchflag("potm", 1);
    util::setclientsysstate("levelNotify", "sndFKs");
    luinotifyevent(%pre_potm_transition);
    for (eventindex = 0; eventindex < level.potmevents.size; eventindex++) {
        event = level.potmevents[eventindex];
        wait 0.35;
        if (!isdefined(event.targetentityindex)) {
            continue;
        }
        attacker = event.attacker;
        if (isdefined(attacker) && isdefined(attacker.archetype) && attacker.archetype == "mannequin") {
            continue;
        }
        startplayofthematch(eventindex);
        for (index = 0; index < level.players.size; index++) {
            player = level.players[index];
            player closeingamemenu();
            player thread play_potm_on_player(eventindex);
        }
        wait 0.1;
        while (killcam::are_any_players_watching()) {
            waitframe(1);
        }
    }
    util::wait_network_frame();
    util::setclientsysstate("levelNotify", "sndFKe");
    luinotifyevent(%post_potm_transition);
    stopplayofthematch();
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        player killcam::spawn_end_of_final_killcam();
    }
    wait 1;
    setmatchflag("potm", 0);
    level.infinalkillcam = 0;
    level notify(#"potm_finished");
    level.var_b363408a = 0;
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xba297936, Offset: 0xd30
// Size: 0x3c
function waitthennotifyplaypotm() {
    waitframe(1);
    level notify(#"play_potm");
    waitframe(1);
    setdvar("scr_force_potm", 0);
}

// Namespace potm/potm_shared
// Params 11, eflags: 0x0
// Checksum 0xd853bc28, Offset: 0xd78
// Size: 0x40c
function function_42d3c3cb(spectatorclient, targetentityindex, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, perks, killstreaks, attacker) {
    if (!isenabled()) {
        return;
    }
    if (attacker isbot()) {
        return;
    }
    if (spectatorclient >= level.players.size) {
        /#
            println("<dev string:x65>" + spectatorclient + "<dev string:x92>" + level.players.size + "<dev string:xac>");
        #/
        return;
    }
    event = spawnstruct();
    event.var_97813bea = gettime();
    event.spectatorclient = spectatorclient;
    event.targetentityindex = targetentityindex;
    event.killcam_entity_info = killcam_entity_info;
    event.weapon = weapon;
    event.meansofdeath = meansofdeath;
    event.deathtime = deathtime;
    event.deathtimeoffset = deathtimeoffset;
    event.offsettime = offsettime;
    event.perks = perks;
    event.killstreaks = killstreaks;
    event.attacker = attacker;
    postdeathdelay = (gettime() - deathtime) / 1000;
    predelay = postdeathdelay + deathtimeoffset;
    killcamentitystarttime = killcam::get_killcam_entity_info_starttime(killcam_entity_info);
    camtime = killcam::calc_time(weapon, killcamentitystarttime, predelay, 0, undefined);
    postdelay = killcam::calc_post_delay();
    killcamoffset = camtime + predelay;
    killcamlength = camtime + postdelay - 0.05;
    event.killcamstarttime = gettime() - killcamoffset * 1000;
    event.var_668dad4e = event.killcamstarttime + killcamlength * 1000;
    for (eventindex = 0; eventindex < level.potmevents.size; eventindex++) {
        var_4cc339b8 = level.potmevents[eventindex];
        if (var_4cc339b8.spectatorclient != event.spectatorclient) {
            continue;
        }
        if (event.killcamstarttime >= var_4cc339b8.killcamstarttime && event.killcamstarttime < var_4cc339b8.var_668dad4e) {
            /#
                println("<dev string:xb0>");
            #/
            return;
        }
    }
    self thread function_63785aa0(event, killcamoffset, killcamlength);
}

// Namespace potm/potm_shared
// Params 3, eflags: 0x0
// Checksum 0xf28c79ec, Offset: 0x1190
// Size: 0x1bc
function function_63785aa0(event, killcamoffset, killcamlength) {
    var_5ccfd3f1 = getcurrentarchiveframenumber();
    var_fb932f4a = getframenumberforarchivetime(killcamoffset);
    var_6d3b47f5 = getframenumberforarchivetime(killcamoffset - killcamlength);
    while (var_5ccfd3f1 <= var_6d3b47f5) {
        var_5ccfd3f1 = getcurrentarchiveframenumber();
        waitframe(1);
    }
    if (level.potmevents.size >= level.potm_max_events) {
        if (removepotmevent(0)) {
            array::pop(level.potmevents, 0, 0);
        }
    }
    if (addpotmevent(var_fb932f4a, var_6d3b47f5)) {
        array::push(level.potmevents, event, level.potmevents.size);
        /#
            if (getdvarint("<dev string:xe9>") == 1) {
                printplayofthematchdebuginformation(event.killcamstarttime, event.var_668dad4e, var_fb932f4a, var_6d3b47f5);
            }
        #/
    }
    /#
        updatedebugmenudata(1);
    #/
}

/#

    // Namespace potm/potm_shared
    // Params 0, eflags: 0x0
    // Checksum 0x67900e01, Offset: 0x1358
    // Size: 0x74
    function debuginit() {
        if (!isenabled()) {
            return;
        }
        setdvar("<dev string:xfe>", 0);
        setdvar("<dev string:xe9>", 0);
        setdvar("<dev string:x10d>", 1);
    }

    // Namespace potm/potm_shared
    // Params 1, eflags: 0x0
    // Checksum 0x10e97fea, Offset: 0x13d8
    // Size: 0x4e4
    function updatedebugmenudata(forceupdate) {
        if (!isdefined(level.potmdebugmenu)) {
            return;
        }
        hostplayer = util::gethostplayer();
        menu = level.potmdebugmenu;
        debugeventnum = getdvarint("<dev string:x10d>");
        oldestarchivetime = getearliestarchiveclientinfotime();
        hostplayer setluimenudata(menu, "<dev string:x126>", oldestarchivetime);
        if (isdefined(level.potmdebugeventnum) && level.potmdebugeventnum == debugeventnum && !forceupdate) {
            return;
        }
        level.potmdebugeventnum = debugeventnum;
        var_97813bea = 0;
        spectatorclient = "<dev string:x138>";
        targetentity = "<dev string:x138>";
        weaponname = "<dev string:x138>";
        meansofdeath = "<dev string:x138>";
        deathtime = 0;
        deathtimeoffset = 0;
        offsettime = 0;
        if (debugeventnum - 1 < level.potmevents.size) {
            event = level.potmevents[debugeventnum - 1];
            var_97813bea = event.var_97813bea;
            spectatorclient = event.attacker.name + "<dev string:x142>" + event.spectatorclient + "<dev string:x145>";
            if (event.targetentityindex < level.players.size) {
                targetentity = level.players[event.targetentityindex].name + "<dev string:x142>" + event.targetentityindex + "<dev string:x145>";
            } else {
                targetentity = "<dev string:x147>" + event.targetentityindex + "<dev string:x145>";
            }
            if (isdefined(event.weapon)) {
                weaponname = event.weapon.name;
            }
            if (isdefined(event.meansofdeath)) {
                meansofdeath = event.meansofdeath;
            }
            deathtime = event.deathtime;
            deathtimeoffset = event.deathtimeoffset;
            offsettime = event.offsettime;
        }
        hostplayer setluimenudata(menu, "<dev string:x150>", level.potmevents.size);
        hostplayer setluimenudata(menu, "<dev string:x156>", debugeventnum);
        hostplayer setluimenudata(menu, "<dev string:x15f>", var_97813bea);
        hostplayer setluimenudata(menu, "<dev string:x167>", spectatorclient);
        hostplayer setluimenudata(menu, "<dev string:x177>", targetentity);
        hostplayer setluimenudata(menu, "<dev string:x184>", weaponname);
        hostplayer setluimenudata(menu, "<dev string:x18f>", meansofdeath);
        hostplayer setluimenudata(menu, "<dev string:x19c>", deathtime);
        hostplayer setluimenudata(menu, "<dev string:x1a6>", deathtimeoffset);
        hostplayer setluimenudata(menu, "<dev string:x1b6>", offsettime);
    }

    // Namespace potm/potm_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9ad691ef, Offset: 0x18c8
    // Size: 0xce
    function updatedebugmenustate() {
        player = util::gethostplayer();
        if (getdvarint("<dev string:xfe>") == 1) {
            if (!isdefined(level.potmdebugmenu) && isdefined(player)) {
                level.potmdebugmenu = player openluimenu("<dev string:x1c1>");
            }
            return;
        }
        if (isdefined(level.potmdebugmenu)) {
            player closeluimenu(level.potmdebugmenu);
            level.potmdebugmenu = undefined;
        }
    }

    // Namespace potm/potm_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3cfba1f0, Offset: 0x19a0
    // Size: 0x9c
    function debugupdate() {
        if (!isenabled()) {
            return;
        }
        updatedebugmenustate();
        updatedebugmenudata(0);
        if (getdvarint("<dev string:x1cc>") == 1) {
            level thread play_potm();
            level thread waitthennotifyplaypotm();
        }
    }

#/
