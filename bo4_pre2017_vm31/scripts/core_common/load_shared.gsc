#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/debug_shared;
#using scripts/core_common/doors_shared;
#using scripts/core_common/drown;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/exploder_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/fx_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/music_shared;
#using scripts/core_common/player_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicles/raps;
#using scripts/core_common/visionset_mgr_shared;

#namespace load;

// Namespace load/load_shared
// Params 0, eflags: 0x2
// Checksum 0x377cf35b, Offset: 0x720
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("load", &__init__, undefined, undefined);
}

// Namespace load/load_shared
// Params 0, eflags: 0x2
// Checksum 0xb8788cbc, Offset: 0x760
// Size: 0x64
function autoexec init_flags() {
    level flag::init("all_players_connected");
    level flag::init("all_players_spawned");
    level flag::init("first_player_spawned");
}

// Namespace load/load_shared
// Params 0, eflags: 0x2
// Checksum 0x91b19104, Offset: 0x7d0
// Size: 0x26
function autoexec first_frame() {
    level.first_frame = 1;
    waitframe(1);
    level.first_frame = undefined;
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x2e5e3fb7, Offset: 0x800
// Size: 0x384
function __init__() {
    /#
        level thread function_bce02ad1();
        level thread level_notify_listener();
        level thread client_notify_listener();
        level thread load_checkpoint_on_notify();
        level thread save_checkpoint_on_notify();
    #/
    defaultaspectratio = 1;
    if (sessionmodeiscampaigngame()) {
        level.game_mode_suffix = "_cp";
    } else if (sessionmodeiszombiesgame()) {
        level.game_mode_suffix = "_zm";
    } else {
        level.game_mode_suffix = "_mp";
        defaultaspectratio = 1.77778;
    }
    level.script = tolower(getdvarstring("mapname"));
    level.clientscripts = getdvarstring("cg_usingClientScripts") != "";
    level.campaign = "american";
    level.clientscripts = getdvarstring("cg_usingClientScripts") != "";
    if (!isdefined(level.timeofday)) {
        level.timeofday = "day";
    }
    if (getdvarstring("scr_RequiredMapAspectratio") == "") {
        setdvar("scr_RequiredMapAspectratio", defaultaspectratio);
    }
    setdvar("tu6_player_shallowWaterHeight", "0.0");
    util::registerclientsys("levelNotify");
    level thread all_players_spawned();
    level thread keep_time();
    level thread count_network_frames();
    callback::on_spawned(&on_spawned);
    self thread playerdamagerumble();
    array::thread_all(getentarray("water", "targetname"), &water_think);
    array::thread_all_ents(getentarray("badplace", "targetname"), &badplace_think);
    weapon_ammo();
    set_objective_text_colors();
    link_ents();
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0xae574089, Offset: 0xb90
// Size: 0x3c
function count_network_frames() {
    level.network_frame = 0;
    while (true) {
        util::wait_network_frame();
        level.network_frame++;
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x8e68b79b, Offset: 0xbd8
// Size: 0x26
function keep_time() {
    while (true) {
        level.time = gettime();
        waitframe(1);
    }
}

/#

    // Namespace load/load_shared
    // Params 1, eflags: 0x0
    // Checksum 0x82902555, Offset: 0xc08
    // Size: 0x9e
    function function_1bf0e5a5(msg) {
        if (!isdefined(level.var_ed1cf314)) {
            level.var_ed1cf314 = [];
        } else if (!isarray(level.var_ed1cf314)) {
            level.var_ed1cf314 = array(level.var_ed1cf314);
        }
        level.var_ed1cf314[level.var_ed1cf314.size] = msg;
    }

    // Namespace load/load_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb1e2aa0d, Offset: 0xcb0
    // Size: 0x104
    function function_bce02ad1() {
        level.var_ed1cf314 = array("<dev string:x28>", "<dev string:x2a>", "<dev string:x2c>");
        wait 1;
        println("<dev string:x2e>");
        foreach (msg in level.var_ed1cf314) {
            println("<dev string:x7d>");
        }
        println("<dev string:x82>");
    }

    // Namespace load/load_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf24c8438, Offset: 0xdc0
    // Size: 0x130
    function level_notify_listener() {
        while (true) {
            val = getdvarstring("<dev string:xd2>");
            if (val != "<dev string:xdf>") {
                toks = strtok(val, "<dev string:xe0>");
                if (toks.size == 3) {
                    level notify(toks[0], {#param1:toks[1], #param2:toks[2]});
                } else if (toks.size == 2) {
                    level notify(toks[0], {#param1:toks[1]});
                } else {
                    level notify(toks[0]);
                }
                setdvar("<dev string:xd2>", "<dev string:xdf>");
            }
            wait 0.2;
        }
    }

    // Namespace load/load_shared
    // Params 0, eflags: 0x0
    // Checksum 0xbf746381, Offset: 0xef8
    // Size: 0x88
    function client_notify_listener() {
        while (true) {
            val = getdvarstring("<dev string:xe2>");
            if (val != "<dev string:xdf>") {
                util::clientnotify(val);
                setdvar("<dev string:xe2>", "<dev string:xdf>");
            }
            wait 0.2;
        }
    }

    // Namespace load/load_shared
    // Params 0, eflags: 0x0
    // Checksum 0x263052bc, Offset: 0xf88
    // Size: 0x48
    function load_checkpoint_on_notify() {
        while (true) {
            level waittill("<dev string:xf0>");
            checkpointcreate();
            checkpointcommit();
        }
    }

    // Namespace load/load_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3361d8cd, Offset: 0xfd8
    // Size: 0x38
    function save_checkpoint_on_notify() {
        while (true) {
            level waittill("<dev string:xf5>");
            checkpointrestore();
        }
    }

#/

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x88cd8769, Offset: 0x1018
// Size: 0x23e
function weapon_ammo() {
    ents = getentarray();
    for (i = 0; i < ents.size; i++) {
        if (isdefined(ents[i].classname) && getsubstr(ents[i].classname, 0, 7) == "weapon_") {
            weap = ents[i];
            change_ammo = 0;
            clip = undefined;
            extra = undefined;
            if (isdefined(weap.script_ammo_clip)) {
                clip = weap.script_ammo_clip;
                change_ammo = 1;
            }
            if (isdefined(weap.script_ammo_extra)) {
                extra = weap.script_ammo_extra;
                change_ammo = 1;
            }
            if (change_ammo) {
                if (!isdefined(clip)) {
                    assertmsg("<dev string:xfa>" + weap.classname + "<dev string:x103>" + weap.origin + "<dev string:x105>");
                }
                if (!isdefined(extra)) {
                    assertmsg("<dev string:xfa>" + weap.classname + "<dev string:x103>" + weap.origin + "<dev string:x136>");
                }
                weap itemweaponsetammo(clip, extra);
                weap itemweaponsetammo(clip, extra, 1);
            }
        }
    }
}

// Namespace load/load_shared
// Params 1, eflags: 0x0
// Checksum 0xcce42748, Offset: 0x1260
// Size: 0x84
function badplace_think(badplace) {
    if (!isdefined(level.badplaces)) {
        level.badplaces = 0;
    }
    level.badplaces++;
    badplace_box("badplace" + level.badplaces, -1, badplace.origin, badplace.radius, "all");
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x3e16ad87, Offset: 0x12f0
// Size: 0x50
function playerdamagerumble() {
    while (true) {
        self waittill("damage");
        if (isdefined(self.specialdamage)) {
            continue;
        }
        self playrumbleonentity("damage_heavy");
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x5d651bcc, Offset: 0x1348
// Size: 0x98
function map_is_early_in_the_game() {
    /#
        if (isdefined(level.testmap)) {
            return true;
        }
    #/
    /#
        if (!isdefined(level.early_level[level.script])) {
            level.early_level[level.script] = 0;
        }
    #/
    return isdefined(level.early_level[level.script]) && level.early_level[level.script];
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x44548f2f, Offset: 0x13e8
// Size: 0x88
function player_throwgrenade_timer() {
    self endon(#"death");
    self endon(#"disconnect");
    self.lastgrenadetime = 0;
    while (true) {
        while (!self isthrowinggrenade()) {
            wait 0.05;
        }
        self.lastgrenadetime = gettime();
        while (self isthrowinggrenade()) {
            wait 0.05;
        }
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x27cd9ad3, Offset: 0x1478
// Size: 0x3d6
function function_cebdcdf7() {
    self endon(#"disconnect");
    self thread player_throwgrenade_timer();
    if (issplitscreen() || util::coopgame()) {
        return;
    }
    waitresult = self waittill("death");
    attacker = waitresult.attacker;
    cause = waitresult.mod;
    weapon = waitresult.weapon;
    var_75db6cbf = waitresult.inflictor;
    if (cause != "MOD_GAS" && cause != "MOD_GRENADE" && cause != "MOD_GRENADE_SPLASH" && cause != "MOD_SUICIDE" && cause != "MOD_EXPLOSIVE" && cause != "MOD_PROJECTILE" && cause != "MOD_PROJECTILE_SPLASH") {
        return;
    }
    if (level.gameskill >= 2) {
        if (!map_is_early_in_the_game()) {
            return;
        }
    }
    if (cause == "MOD_EXPLOSIVE") {
        if (attacker.classname == "script_vehicle" || isdefined(attacker) && isdefined(attacker.var_4d8d3fde)) {
            level notify(#"hash_4021bd14");
            setdvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
            self thread function_8229d210();
            return;
        }
        if (isdefined(var_75db6cbf) && isdefined(var_75db6cbf.destructibledef)) {
            if (issubstr(var_75db6cbf.destructibledef, "barrel_explosive")) {
                level notify(#"hash_4021bd14");
                setdvar("ui_deadquote", "@SCRIPT_EXPLODING_BARREL_DEATH");
                return;
            }
            if (isdefined(var_75db6cbf.var_675dbca3) && var_75db6cbf.var_675dbca3) {
                level notify(#"hash_4021bd14");
                setdvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
                self thread function_8229d210();
                return;
            }
        }
    }
    if (cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH") {
        if (!weapon.istimeddetonation || !weapon.isgrenadeweapon) {
            return;
        }
        level notify(#"hash_4021bd14");
        if (weapon.name == "explosive_bolt") {
            setdvar("ui_deadquote", "@SCRIPT_EXPLOSIVE_BOLT_DEATH");
            thread function_f67aaa2d();
            return;
        }
        setdvar("ui_deadquote", "@SCRIPT_GRENADE_DEATH");
        thread function_49fc0e66();
        return;
    }
}

// Namespace load/load_shared
// Params 2, eflags: 0x0
// Checksum 0xb23bfca2, Offset: 0x1858
// Size: 0x30c
function function_fed824a2(var_a211332b, var_3009c3f0) {
    self.failingmission = 1;
    setdvar("ui_deadquote", "");
    wait 0.5;
    fontelem = newhudelem();
    fontelem.elemtype = "font";
    fontelem.font = "default";
    fontelem.fontscale = 1.5;
    fontelem.x = 0;
    fontelem.y = -60;
    fontelem.alignx = "center";
    fontelem.aligny = "middle";
    fontelem.horzalign = "center";
    fontelem.vertalign = "middle";
    fontelem settext(var_a211332b);
    fontelem.foreground = 1;
    fontelem.alpha = 0;
    fontelem fadeovertime(1);
    fontelem.alpha = 1;
    fontelem.hidewheninmenu = 1;
    if (isdefined(var_3009c3f0)) {
        fontelem = newhudelem();
        fontelem.elemtype = "font";
        fontelem.font = "default";
        fontelem.fontscale = 1.5;
        fontelem.x = 0;
        fontelem.y = -60 + level.fontheight * fontelem.fontscale;
        fontelem.alignx = "center";
        fontelem.aligny = "middle";
        fontelem.horzalign = "center";
        fontelem.vertalign = "middle";
        fontelem settext(var_3009c3f0);
        fontelem.foreground = 1;
        fontelem.alpha = 0;
        fontelem fadeovertime(1);
        fontelem.alpha = 1;
        fontelem.hidewheninmenu = 1;
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0xb7092a7d, Offset: 0x1b70
// Size: 0x284
function function_49fc0e66() {
    self endon(#"disconnect");
    wait 0.5;
    var_e1479b80 = newclienthudelem(self);
    var_e1479b80.x = 0;
    var_e1479b80.y = 68;
    var_e1479b80 setshader("hud_grenadeicon_256", 50, 50);
    var_e1479b80.alignx = "center";
    var_e1479b80.aligny = "middle";
    var_e1479b80.horzalign = "center";
    var_e1479b80.vertalign = "middle";
    var_e1479b80.foreground = 1;
    var_e1479b80.alpha = 0;
    var_e1479b80 fadeovertime(1);
    var_e1479b80.alpha = 1;
    var_e1479b80.hidewheninmenu = 1;
    var_ed3ed80e = newclienthudelem(self);
    var_ed3ed80e.x = 0;
    var_ed3ed80e.y = 25;
    var_ed3ed80e setshader("hud_grenadepointer", 50, 25);
    var_ed3ed80e.alignx = "center";
    var_ed3ed80e.aligny = "middle";
    var_ed3ed80e.horzalign = "center";
    var_ed3ed80e.vertalign = "middle";
    var_ed3ed80e.foreground = 1;
    var_ed3ed80e.alpha = 0;
    var_ed3ed80e fadeovertime(1);
    var_ed3ed80e.alpha = 1;
    var_ed3ed80e.hidewheninmenu = 1;
    self thread function_69110cf3(var_e1479b80, var_ed3ed80e);
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0xd2132305, Offset: 0x1e00
// Size: 0x284
function function_f67aaa2d() {
    self endon(#"disconnect");
    wait 0.5;
    var_e1479b80 = newclienthudelem(self);
    var_e1479b80.x = 0;
    var_e1479b80.y = 68;
    var_e1479b80 setshader("hud_explosive_arrow_icon", 50, 50);
    var_e1479b80.alignx = "center";
    var_e1479b80.aligny = "middle";
    var_e1479b80.horzalign = "center";
    var_e1479b80.vertalign = "middle";
    var_e1479b80.foreground = 1;
    var_e1479b80.alpha = 0;
    var_e1479b80 fadeovertime(1);
    var_e1479b80.alpha = 1;
    var_e1479b80.hidewheninmenu = 1;
    var_ed3ed80e = newclienthudelem(self);
    var_ed3ed80e.x = 0;
    var_ed3ed80e.y = 25;
    var_ed3ed80e setshader("hud_grenadepointer", 50, 25);
    var_ed3ed80e.alignx = "center";
    var_ed3ed80e.aligny = "middle";
    var_ed3ed80e.horzalign = "center";
    var_ed3ed80e.vertalign = "middle";
    var_ed3ed80e.foreground = 1;
    var_ed3ed80e.alpha = 0;
    var_ed3ed80e fadeovertime(1);
    var_ed3ed80e.alpha = 1;
    var_ed3ed80e.hidewheninmenu = 1;
    self thread function_69110cf3(var_e1479b80, var_ed3ed80e);
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x6cf159ab, Offset: 0x2090
// Size: 0x284
function function_d88a3ecf() {
    self endon(#"disconnect");
    wait 0.5;
    var_e1479b80 = newclienthudelem(self);
    var_e1479b80.x = 0;
    var_e1479b80.y = 68;
    var_e1479b80 setshader("hud_monsoon_titus_arrow", 50, 50);
    var_e1479b80.alignx = "center";
    var_e1479b80.aligny = "middle";
    var_e1479b80.horzalign = "center";
    var_e1479b80.vertalign = "middle";
    var_e1479b80.foreground = 1;
    var_e1479b80.alpha = 0;
    var_e1479b80 fadeovertime(1);
    var_e1479b80.alpha = 1;
    var_e1479b80.hidewheninmenu = 1;
    var_ed3ed80e = newclienthudelem(self);
    var_ed3ed80e.x = 0;
    var_ed3ed80e.y = 25;
    var_ed3ed80e setshader("hud_grenadepointer", 50, 25);
    var_ed3ed80e.alignx = "center";
    var_ed3ed80e.aligny = "middle";
    var_ed3ed80e.horzalign = "center";
    var_ed3ed80e.vertalign = "middle";
    var_ed3ed80e.foreground = 1;
    var_ed3ed80e.alpha = 0;
    var_ed3ed80e fadeovertime(1);
    var_ed3ed80e.alpha = 1;
    var_ed3ed80e.hidewheninmenu = 1;
    self thread function_69110cf3(var_e1479b80, var_ed3ed80e);
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x6d01bb59, Offset: 0x2320
// Size: 0x284
function function_a2ec9313() {
    self endon(#"disconnect");
    wait 0.5;
    var_e1479b80 = newclienthudelem(self);
    var_e1479b80.x = 0;
    var_e1479b80.y = 68;
    var_e1479b80 setshader("hud_monsoon_nitrogen_barrel", 50, 50);
    var_e1479b80.alignx = "center";
    var_e1479b80.aligny = "middle";
    var_e1479b80.horzalign = "center";
    var_e1479b80.vertalign = "middle";
    var_e1479b80.foreground = 1;
    var_e1479b80.alpha = 0;
    var_e1479b80 fadeovertime(1);
    var_e1479b80.alpha = 1;
    var_e1479b80.hidewheninmenu = 1;
    var_ed3ed80e = newclienthudelem(self);
    var_ed3ed80e.x = 0;
    var_ed3ed80e.y = 25;
    var_ed3ed80e setshader("hud_grenadepointer", 50, 25);
    var_ed3ed80e.alignx = "center";
    var_ed3ed80e.aligny = "middle";
    var_ed3ed80e.horzalign = "center";
    var_ed3ed80e.vertalign = "middle";
    var_ed3ed80e.foreground = 1;
    var_ed3ed80e.alpha = 0;
    var_ed3ed80e fadeovertime(1);
    var_ed3ed80e.alpha = 1;
    var_ed3ed80e.hidewheninmenu = 1;
    self thread function_69110cf3(var_e1479b80, var_ed3ed80e);
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0xd64e9af, Offset: 0x25b0
// Size: 0x17c
function function_8229d210() {
    self endon(#"disconnect");
    wait 0.5;
    var_e1479b80 = newclienthudelem(self);
    var_e1479b80.x = 0;
    var_e1479b80.y = -10;
    var_e1479b80 setshader("hud_exploding_vehicles", 50, 50);
    var_e1479b80.alignx = "center";
    var_e1479b80.aligny = "middle";
    var_e1479b80.horzalign = "center";
    var_e1479b80.vertalign = "middle";
    var_e1479b80.foreground = 1;
    var_e1479b80.alpha = 0;
    var_e1479b80 fadeovertime(1);
    var_e1479b80.alpha = 1;
    var_e1479b80.hidewheninmenu = 1;
    var_ed3ed80e = newclienthudelem(self);
    self thread function_69110cf3(var_e1479b80, var_ed3ed80e);
}

// Namespace load/load_shared
// Params 2, eflags: 0x0
// Checksum 0x625b74e6, Offset: 0x2738
// Size: 0x5c
function function_69110cf3(var_10b2f152, var_ad2b839c) {
    self endon(#"disconnect");
    self waittill("spawned");
    var_10b2f152 destroy();
    var_ad2b839c destroy();
}

// Namespace load/load_shared
// Params 6, eflags: 0x0
// Checksum 0xd87be4cc, Offset: 0x27a0
// Size: 0x1c4
function function_e152ebb3(shader, iwidth, var_40c0cdd3, fdelay, x, y) {
    if (!isdefined(fdelay)) {
        fdelay = 0.5;
    }
    wait fdelay;
    overlay = newclienthudelem(self);
    if (isdefined(x)) {
        overlay.x = x;
    } else {
        overlay.x = 0;
    }
    if (isdefined(y)) {
        overlay.y = y;
    } else {
        overlay.y = 40;
    }
    overlay setshader(shader, iwidth, var_40c0cdd3);
    overlay.alignx = "center";
    overlay.aligny = "middle";
    overlay.horzalign = "center";
    overlay.vertalign = "middle";
    overlay.foreground = 1;
    overlay.alpha = 0;
    overlay fadeovertime(1);
    overlay.alpha = 1;
    overlay.hidewheninmenu = 1;
    self thread function_90e3bbdb(overlay);
}

// Namespace load/load_shared
// Params 1, eflags: 0x0
// Checksum 0xdeb7a591, Offset: 0x2970
// Size: 0x3c
function function_90e3bbdb(overlay) {
    self endon(#"disconnect");
    self waittill("spawned");
    overlay destroy();
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x7406459a, Offset: 0x29b8
// Size: 0x486
function water_think() {
    assert(isdefined(self.target));
    targeted = getent(self.target, "targetname");
    assert(isdefined(targeted));
    waterheight = targeted.origin[2];
    targeted = undefined;
    level.depth_allow_prone = 8;
    level.depth_allow_crouch = 33;
    level.depth_allow_stand = 50;
    while (true) {
        waitframe(1);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i].inwater) {
                players[i] allowprone(1);
                players[i] allowcrouch(1);
                players[i] allowstand(1);
            }
        }
        waitresult = self waittill("trigger");
        other = waitresult.activator;
        if (!isplayer(other)) {
            continue;
        }
        while (true) {
            players = getplayers();
            players_in_water_count = 0;
            for (i = 0; i < players.size; i++) {
                if (players[i] istouching(self)) {
                    players_in_water_count++;
                    players[i].inwater = 1;
                    playerorg = players[i] getorigin();
                    d = playerorg[2] - waterheight;
                    if (d > 0) {
                        continue;
                    }
                    newspeed = int(level.default_run_speed - abs(d * 5));
                    if (newspeed < 50) {
                        newspeed = 50;
                    }
                    assert(newspeed <= 190);
                    if (abs(d) > level.depth_allow_crouch) {
                        players[i] allowcrouch(0);
                    } else {
                        players[i] allowcrouch(1);
                    }
                    if (abs(d) > level.depth_allow_prone) {
                        players[i] allowprone(0);
                    } else {
                        players[i] allowprone(1);
                    }
                    continue;
                }
                if (players[i].inwater) {
                    players[i].inwater = 0;
                }
            }
            if (players_in_water_count == 0) {
                break;
            }
            wait 0.5;
        }
        waitframe(1);
    }
}

// Namespace load/load_shared
// Params 1, eflags: 0x0
// Checksum 0x64322b52, Offset: 0x2e48
// Size: 0x13c
function indicate_start(start) {
    hudelem = newhudelem();
    hudelem.alignx = "left";
    hudelem.aligny = "middle";
    hudelem.x = 70;
    hudelem.y = 400;
    hudelem.label = start;
    hudelem.alpha = 0;
    hudelem.fontscale = 3;
    wait 1;
    hudelem fadeovertime(1);
    hudelem.alpha = 1;
    wait 5;
    hudelem fadeovertime(1);
    hudelem.alpha = 0;
    wait 1;
    hudelem destroy();
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x9118f888, Offset: 0x2f90
// Size: 0x224
function calculate_map_center() {
    if (!isdefined(level.mapcenter)) {
        nodes = getallnodes();
        if (isdefined(nodes[0])) {
            level.nodesmins = nodes[0].origin;
            level.nodesmaxs = nodes[0].origin;
        } else {
            level.nodesmins = (0, 0, 0);
            level.nodesmaxs = (0, 0, 0);
        }
        for (index = 0; index < nodes.size; index++) {
            if (nodes[index].type == "BAD NODE") {
                println("<dev string:x167>", nodes[index].origin);
                continue;
            }
            origin = nodes[index].origin;
            level.nodesmins = math::expand_mins(level.nodesmins, origin);
            level.nodesmaxs = math::expand_maxs(level.nodesmaxs, origin);
        }
        level.mapcenter = math::find_box_center(level.nodesmins, level.nodesmaxs);
        println("<dev string:x1a9>", level.mapcenter);
        setmapcenter(level.mapcenter);
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0xd61a747b, Offset: 0x31c0
// Size: 0x94
function set_objective_text_colors() {
    my_textbrightness_default = "1.0 1.0 1.0";
    my_textbrightness_90 = "0.9 0.9 0.9";
    var_c875cf40 = "0.85 0.85 0.85";
    if (level.script == "armada") {
        setsaveddvar("con_typewriterColorBase", my_textbrightness_90);
        return;
    }
    setsaveddvar("con_typewriterColorBase", my_textbrightness_default);
}

// Namespace load/load_shared
// Params 4, eflags: 0x0
// Checksum 0x761315dc, Offset: 0x3260
// Size: 0x11a
function lerp_trigger_dvar_value(trigger, dvar, value, time) {
    trigger.lerping_dvar[dvar] = 1;
    steps = time * 20;
    curr_value = getdvarfloat(dvar);
    diff = (curr_value - value) / steps;
    for (i = 0; i < steps; i++) {
        curr_value -= diff;
        setsaveddvar(dvar, curr_value);
        waitframe(1);
    }
    setsaveddvar(dvar, value);
    trigger.lerping_dvar[dvar] = 0;
}

// Namespace load/load_shared
// Params 1, eflags: 0x0
// Checksum 0x45fcff4b, Offset: 0x3388
// Size: 0x104
function set_fog_progress(progress) {
    anti_progress = 1 - progress;
    startdist = self.script_start_dist * anti_progress + self.script_start_dist * progress;
    halfwaydist = self.script_halfway_dist * anti_progress + self.script_halfway_dist * progress;
    color = self.script_color * anti_progress + self.script_color * progress;
    setvolfog(startdist, halfwaydist, self.script_halfway_height, self.script_base_height, color[0], color[1], color[2], 0.4);
}

/#

    // Namespace load/load_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf7ae2e98, Offset: 0x3498
    // Size: 0x24
    function ascii_logo() {
        println("<dev string:x1b6>");
    }

#/

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0xe0d35831, Offset: 0x34c8
// Size: 0x154
function all_players_spawned() {
    level flag::wait_till("all_players_connected");
    waittillframeend();
    level.host = util::gethostplayer();
    while (true) {
        if (getnumconnectedplayers() == 0) {
            waitframe(1);
            continue;
        }
        players = getplayers();
        count = 0;
        for (i = 0; i < players.size; i++) {
            if (players[i].sessionstate == "playing") {
                count++;
            }
        }
        waitframe(1);
        if (count > 0) {
            level flag::set("first_player_spawned");
        }
        if (count == players.size) {
            break;
        }
    }
    level flag::set("all_players_spawned");
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x9cdd4096, Offset: 0x3628
// Size: 0x208
function shock_onpain() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"killonpainmonitor");
    if (getdvarstring("blurpain") == "") {
        setdvar("blurpain", "on");
    }
    while (true) {
        oldhealth = self.health;
        waitresult = self waittill("damage");
        mod = waitresult.mod;
        damage = waitresult.amount;
        if (isdefined(level.shock_onpain) && !level.shock_onpain) {
            continue;
        }
        if (isdefined(self.shock_onpain) && !self.shock_onpain) {
            continue;
        }
        if (self.health < 1) {
            continue;
        }
        if (mod == "MOD_PROJECTILE") {
            continue;
        }
        if (mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH") {
            self shock_onexplosion(damage);
            continue;
        }
        if (getdvarstring("blurpain") == "on") {
            self shellshock("pain", 0.5);
        }
    }
}

// Namespace load/load_shared
// Params 1, eflags: 0x0
// Checksum 0xdd18aab0, Offset: 0x3838
// Size: 0xc6
function shock_onexplosion(damage) {
    time = 0;
    multiplier = self.maxhealth / 100;
    scaled_damage = damage * multiplier;
    if (scaled_damage >= 90) {
        time = 4;
    } else if (scaled_damage >= 50) {
        time = 3;
    } else if (scaled_damage >= 25) {
        time = 2;
    } else if (scaled_damage > 10) {
        time = 1;
    }
    if (time) {
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x78af6dde, Offset: 0x3908
// Size: 0x8a
function shock_ondeath() {
    self waittill("death");
    if (isdefined(level.shock_ondeath) && !level.shock_ondeath) {
        return;
    }
    if (isdefined(self.shock_ondeath) && !self.shock_ondeath) {
        return;
    }
    if (isdefined(self.specialdeath)) {
        return;
    }
    if (getdvarstring("r_texturebits") == "16") {
        return;
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x4ac0cd5, Offset: 0x39a0
// Size: 0x80
function on_spawned() {
    if (!isdefined(self.player_inited) || !self.player_inited) {
        if (sessionmodeiscampaigngame()) {
            self thread shock_ondeath();
            self thread shock_onpain();
        }
        waitframe(1);
        if (isdefined(self)) {
            self.player_inited = 1;
        }
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x39b3b50d, Offset: 0x3a28
// Size: 0xfa
function link_ents() {
    foreach (ent in getentarray()) {
        if (isdefined(ent.linkto)) {
            e_link = getent(ent.linkto, "linkname");
            if (isdefined(e_link)) {
                ent enablelinkto();
                ent linkto(e_link);
            }
        }
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x3aba19c8, Offset: 0x3b30
// Size: 0x252
function art_review() {
    str_dvar = getdvarstring("art_review");
    switch (str_dvar) {
    case #"":
        setdvar("art_review", "0");
        break;
    case #"1":
    case #"2":
        hud = hud::createserverfontstring("objective", 1.2);
        hud hud::setpoint("CENTER", "CENTER", 0, -200);
        hud.sort = 1001;
        hud.color = (1, 0, 0);
        hud settext("ART REVIEW");
        hud.foreground = 0;
        hud.hidewheninmenu = 0;
        if (sessionmodeiszombiesgame()) {
            setdvar("zombie_cheat", "2");
            if (str_dvar == "1") {
                setdvar("zombie_devgui", "power_on");
            }
        } else {
            foreach (trig in trigger::get_all()) {
                trig triggerenable(0);
            }
        }
        level.prematchperiod = 0;
        level waittill("forever");
        break;
    }
}

