#using script_25c09ccacf057919;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\delete;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\telemetry;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace load;

// Namespace load/load_shared
// Params 0, eflags: 0x6
// Checksum 0x6420c876, Offset: 0x260
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"load", &preinit, undefined, undefined, undefined);
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0xd778290e, Offset: 0x2a8
// Size: 0x34
function main() {
    assert(isdefined(level.var_f18a6bd6));
    [[ level.var_f18a6bd6 ]]();
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0xe3be1ffc, Offset: 0x2e8
// Size: 0x64
function init_flags() {
    level flag::init("all_players_connected");
    level flag::init("all_players_spawned");
    level flag::init("first_player_spawned");
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0xbb63c7c4, Offset: 0x358
// Size: 0x34
function first_frame() {
    level.first_frame = 1;
    waitframe(1);
    level.first_frame = undefined;
    level.var_22944a63 = 1;
}

// Namespace load/load_shared
// Params 0, eflags: 0x4
// Checksum 0x39f7eb74, Offset: 0x398
// Size: 0x3a4
function private preinit() {
    if (!isdefined(level.animation)) {
        level.animation = spawnstruct();
    }
    init_flags();
    thread first_frame();
    /#
        level thread level_notify_listener();
        level thread client_notify_listener();
        level thread load_checkpoint_on_notify();
        level thread save_checkpoint_on_notify();
    #/
    level.var_8a3a9ca4 = spawnstruct();
    defaultaspectratio = 1;
    if (sessionmodeiscampaigngame()) {
        level.game_mode_suffix = "_cp";
        defaultaspectratio = 1.77778;
    } else if (sessionmodeiszombiesgame()) {
        level.game_mode_suffix = "_zm";
    } else {
        level.game_mode_suffix = "_mp";
        defaultaspectratio = 1.77778;
    }
    level.script = util::get_map_name();
    level.clientscripts = getdvarstring(#"cg_usingclientscripts") != "";
    level.clientscripts = getdvarstring(#"cg_usingclientscripts") != "";
    if (!isdefined(level.timeofday)) {
        level.timeofday = "day";
    }
    if (getdvarstring(#"scr_requiredmapaspectratio") == "") {
        setdvar(#"scr_requiredmapaspectratio", defaultaspectratio);
    }
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
    hide_ents();
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x1ad04f02, Offset: 0x748
// Size: 0x48
function count_network_frames() {
    level.network_frame = 0;
    while (true) {
        util::wait_network_frame();
        level.network_frame++;
        level.var_58bc5d04 = gettime();
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x3efa5379, Offset: 0x798
// Size: 0x22
function keep_time() {
    while (true) {
        level.time = gettime();
        waitframe(1);
    }
}

/#

    // Namespace load/load_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf688c6ef, Offset: 0x7c8
    // Size: 0x148
    function level_notify_listener() {
        while (true) {
            val = getdvarstring(#"level_notify");
            if (val != "<dev string:x38>") {
                toks = strtok(val, "<dev string:x3c>");
                if (toks.size == 3) {
                    level notify(toks[0], {#param1:toks[1], #param2:toks[2]});
                } else if (toks.size == 2) {
                    level notify(toks[0], {#param1:toks[1]});
                } else {
                    level notify(toks[0]);
                }
                setdvar(#"level_notify", "<dev string:x38>");
            }
            wait 0.2;
        }
    }

    // Namespace load/load_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2cf2621, Offset: 0x918
    // Size: 0x98
    function client_notify_listener() {
        while (true) {
            val = getdvarstring(#"client_notify");
            if (val != "<dev string:x38>") {
                util::clientnotify(val);
                setdvar(#"client_notify", "<dev string:x38>");
            }
            wait 0.2;
        }
    }

    // Namespace load/load_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd54869d2, Offset: 0x9b8
    // Size: 0x48
    function save_checkpoint_on_notify() {
        while (true) {
            level waittill(#"save");
            checkpointcreate();
            checkpointcommit();
        }
    }

    // Namespace load/load_shared
    // Params 0, eflags: 0x0
    // Checksum 0x622e581c, Offset: 0xa08
    // Size: 0x68
    function load_checkpoint_on_notify() {
        while (true) {
            level waittill(#"load");
            if (isdefined(level.var_36a4cf75)) {
                [[ level.var_36a4cf75 ]]();
            }
            level.var_5be43b2d = 1;
            function_f31af5ab();
        }
    }

#/

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x8b0c8b77, Offset: 0xa78
// Size: 0x254
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
            if (is_true(weap.var_d99dd379)) {
                clip = weap.item.clipsize;
                change_ammo = 1;
            }
            if (is_true(weap.var_38a11c38)) {
                extra = weap.item.maxammo;
                change_ammo = 1;
            }
            if (change_ammo) {
                if (!isdefined(clip)) {
                    assertmsg("<dev string:x41>" + weap.classname + "<dev string:x4d>" + weap.origin + "<dev string:x52>");
                }
                if (!isdefined(extra)) {
                    assertmsg("<dev string:x41>" + weap.classname + "<dev string:x4d>" + weap.origin + "<dev string:x86>");
                }
                weap itemweaponsetammo(clip, extra);
                weap itemweaponsetammo(clip, extra, 1);
            }
        }
    }
}

// Namespace load/load_shared
// Params 1, eflags: 0x0
// Checksum 0x158da4b2, Offset: 0xcd8
// Size: 0x15c
function badplace_think(badplace) {
    if (!isdefined(level.badplaces)) {
        level.badplaces = 0;
    }
    level.badplaces++;
    if (isdefined(badplace.radius)) {
        badplace_box("badplace" + level.badplaces, -1, badplace.origin, badplace.radius, "all");
        return;
    }
    aabb_max = badplace getpointinbounds(1, 1, 1);
    aabb_min = badplace getpointinbounds(-1, -1, -1);
    var_9a490e0c = badplace getpointinbounds(0, 0, 0);
    var_856c0347 = (aabb_max - aabb_min) * 0.5;
    badplace_box("badplace" + level.badplaces, -1, var_9a490e0c, var_856c0347, "all");
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x6e94a51, Offset: 0xe40
// Size: 0x58
function playerdamagerumble() {
    while (true) {
        self waittill(#"damage");
        if (isdefined(self.specialdamage)) {
            continue;
        }
        self playrumbleonentity("damage_heavy");
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x4873399b, Offset: 0xea0
// Size: 0x72
function map_is_early_in_the_game() {
    /#
        if (isdefined(level.testmap)) {
            return 1;
        }
    #/
    /#
        if (!isdefined(level.early_level[level.script])) {
            level.early_level[level.script] = 0;
        }
    #/
    return is_true(level.early_level[level.script]);
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0xacbe2588, Offset: 0xf20
// Size: 0x90
function player_throwgrenade_timer() {
    self endon(#"death", #"disconnect");
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
// Checksum 0x7ee0d209, Offset: 0xfb8
// Size: 0x40a
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
        waitresult = self waittill(#"trigger");
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
// Params 0, eflags: 0x0
// Checksum 0x3f931549, Offset: 0x13d0
// Size: 0x9c
function set_objective_text_colors() {
    if (isdedicated()) {
        return;
    }
    my_textbrightness_default = "1.0 1.0 1.0";
    my_textbrightness_90 = "0.9 0.9 0.9";
    if (level.script == "armada") {
        setsaveddvar(#"con_typewritercolorbase", my_textbrightness_90);
        return;
    }
    setsaveddvar(#"con_typewritercolorbase", my_textbrightness_default);
}

// Namespace load/load_shared
// Params 4, eflags: 0x0
// Checksum 0x9d99a446, Offset: 0x1478
// Size: 0xf4
function lerp_trigger_dvar_value(trigger, dvar, value, time) {
    trigger.lerping_dvar[dvar] = 1;
    steps = time * 20;
    curr_value = getdvarfloat(dvar, 0);
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
// Checksum 0xc8fa7134, Offset: 0x1578
// Size: 0xdc
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
    // Checksum 0x1fb16848, Offset: 0x1660
    // Size: 0x24
    function ascii_logo() {
        println("<dev string:xba>");
    }

#/

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x7b1c754c, Offset: 0x1690
// Size: 0x174
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
            if (players[i].sessionstate == "playing" || players[i].team == #"spectator" && players[i].sessionstate == "spectator") {
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
// Checksum 0x6822115e, Offset: 0x1810
// Size: 0x238
function shock_onpain() {
    self endon(#"death", #"disconnect", #"killonpainmonitor");
    if (getdvarstring(#"blurpain") == "") {
        setdvar(#"blurpain", "on");
    }
    while (true) {
        oldhealth = self.health;
        waitresult = self waittill(#"damage");
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
        if (mod === "MOD_PROJECTILE") {
            continue;
        }
        if (mod === "MOD_GRENADE_SPLASH" || mod === "MOD_GRENADE" || mod === "MOD_EXPLOSIVE" || mod === "MOD_PROJECTILE_SPLASH") {
            self shock_onexplosion(damage);
            continue;
        }
        if (getdvarstring(#"blurpain") == "on") {
            self shellshock(#"pain", 0.5);
        }
    }
}

// Namespace load/load_shared
// Params 1, eflags: 0x0
// Checksum 0x1723d83e, Offset: 0x1a50
// Size: 0xb0
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
// Checksum 0x4781751, Offset: 0x1b08
// Size: 0x96
function shock_ondeath() {
    self waittill(#"death");
    if (isdefined(level.shock_ondeath) && !level.shock_ondeath) {
        return;
    }
    if (isdefined(self.shock_ondeath) && !self.shock_ondeath) {
        return;
    }
    if (isdefined(self.specialdeath)) {
        return;
    }
    if (getdvarint(#"r_texturebits", 0) == 16) {
        return;
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0xa75638a4, Offset: 0x1ba8
// Size: 0x9e
function on_spawned() {
    if (!isdefined(self.player_inited) || !self.player_inited) {
        if (sessionmodeiscampaigngame()) {
            self thread shock_ondeath();
            self thread shock_onpain();
            self flag::init("player_is_invulnerable");
        }
        waitframe(1);
        if (isdefined(self)) {
            self.player_inited = 1;
        }
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x8be0a709, Offset: 0x1c50
// Size: 0xe8
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
// Checksum 0xd8b426cd, Offset: 0x1d40
// Size: 0xc8
function hide_ents() {
    foreach (ent in getentarray()) {
        if (is_true(ent.script_hide)) {
            ent val::set(#"script_hide", "hide", 1);
        }
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0xc3b98d92, Offset: 0x1e10
// Size: 0x23a
function art_review() {
    dvarvalue = getdvarint(#"art_review", 0);
    switch (dvarvalue) {
    case 1:
    case 2:
        /#
            hud = hud::function_f5a689d("<dev string:xcc>", 1.2);
            hud hud::setpoint("<dev string:xd9>", "<dev string:xd9>", 0, -200);
            hud.sort = 1001;
            hud.color = (1, 0, 0);
            hud settext("<dev string:xe3>");
            hud.foreground = 0;
            hud.hidewheninmenu = 0;
        #/
        if (sessionmodeiszombiesgame()) {
            /#
                setdvar(#"zombie_cheat", 2);
                if (dvarvalue == 1) {
                    setdvar(#"zombie_devgui", "<dev string:xf1>");
                }
            #/
        } else {
            foreach (trig in trigger::get_all()) {
                trig triggerenable(0);
            }
        }
        level.prematchperiod = 0;
        level waittill(#"forever");
        break;
    }
}

