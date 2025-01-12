#using script_1103c28492840e5f;
#using script_11cc3a9267cf7ac7;
#using script_2c8fd33ddb45e78b;
#using script_31816d064a53f516;
#using script_4e53735256f112ac;
#using script_57f0934f7e3e3b54;
#using script_5ee86fb478309acf;
#using script_7520bf82a814057c;
#using script_eff00f787d80cdf;
#using scripts\core_common\aat_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\scene_shared;
#using scripts\core_common\status_effects\status_effects;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm\perk\zm_perk_deadshot;
#using scripts\zm\perk\zm_perk_juggernaut;
#using scripts\zm\weapons\zm_weap_homunculus;
#using scripts\zm\weapons\zm_weap_mini_turret;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\load;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_demo;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_ffotd;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_hud;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zdraw;

#namespace zm;

// Namespace zm/zm
// Params 0, eflags: 0x2
// Checksum 0xea09a88b, Offset: 0x4e0
// Size: 0x28c
function autoexec ignore_systems() {
    system::ignore(#"gadget_clone");
    system::ignore(#"gadget_armor");
    system::ignore(#"gadget_cleanse");
    system::ignore(#"gadget_heat_wave");
    system::ignore(#"gadget_resurrect");
    system::ignore(#"gadget_health_boost");
    system::ignore(#"gadget_shock_field");
    system::ignore(#"gadget_other");
    system::ignore(#"gadget_camo");
    system::ignore(#"gadget_vision_pulse");
    system::ignore(#"gadget_speed_burst");
    system::ignore(#"gadget_overdrive");
    system::ignore(#"gadget_security_breach");
    system::ignore(#"gadget_combat_efficiency");
    system::ignore(#"gadget_sprint_boost");
    system::ignore(#"spike_charge_siegebot");
    system::ignore(#"gadget_camo_render");
    if (getdvarint(#"splitscreen_playercount", 0) > 2) {
        system::ignore(#"footsteps");
        system::ignore(#"ambient");
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x6
// Checksum 0x86f92f7a, Offset: 0x778
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"zm", &function_70a657d8, undefined, undefined, "renderoverridebundle");
}

// Namespace zm/zm
// Params 0, eflags: 0x5 linked
// Checksum 0xc6e9bc3a, Offset: 0x7c8
// Size: 0x11c
function private function_70a657d8() {
    if (!isdefined(level.zombie_vars)) {
        level.zombie_vars = [];
    }
    level.bgb_in_use = 0;
    level.scr_zm_ui_gametype = util::get_game_type();
    level.scr_zm_ui_gametype_group = "";
    level.scr_zm_map_start_location = "";
    level.gamedifficulty = getgametypesetting(#"zmdifficulty");
    callback::on_laststand(&on_player_laststand);
    renderoverridebundle::function_f72f089c(#"hash_60913f86a5a5a3f1", "rob_sonar_set_friendly_zm", &function_b9c917cc);
    renderoverridebundle::function_f72f089c(#"hash_6844a09875672719", "rob_sonar_set_friendly_zm_ls", &function_a1ab192);
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xa716b82d, Offset: 0x8f0
// Size: 0x42c
function init() {
    println("<dev string:x38>");
    level thread zm_ffotd::main_start();
    level.onlinegame = sessionmodeisonlinegame();
    level.swimmingfeature = 0;
    level.enable_magic = getgametypesetting(#"magic");
    level.headshots_only = getgametypesetting(#"headshotsonly");
    level.disable_equipment_team_object = 1;
    level.clientvoicesetup = &zm_audio::clientvoicesetup;
    level.playerfalldamagesound = &zm_audio::playerfalldamagesound;
    zm_game_over::register();
    println("<dev string:x6b>");
    init_clientfields();
    zm_perks::init();
    zm_powerups::init();
    init_blocker_fx();
    init_riser_fx();
    init_zombie_explode_fx();
    level.var_2f78f66c = 1;
    level.gibresettime = 0.5;
    level.gibmaxcount = 3;
    level.gibtimer = 0;
    level.gibcount = 0;
    level._gibeventcbfunc = &on_gib_event;
    level thread resetgibcounter();
    level thread zpo_listener();
    level thread zpoff_listener();
    level._box_indicator_no_lights = -1;
    level._box_indicator_flash_lights_moving = 99;
    level._box_indicator = level._box_indicator_no_lights;
    util::register_system(#"box_indicator", &box_monitor);
    level._zombie_gib_piece_index_all = 0;
    level._zombie_gib_piece_index_right_arm = 1;
    level._zombie_gib_piece_index_left_arm = 2;
    level._zombie_gib_piece_index_right_leg = 3;
    level._zombie_gib_piece_index_left_leg = 4;
    level._zombie_gib_piece_index_head = 5;
    level._zombie_gib_piece_index_guts = 6;
    level._zombie_gib_piece_index_hat = 7;
    setdvar(#"cg_healthperbar", 50);
    setdvar(#"hash_52a4767bd6da84f1", 0);
    callback::add_callback(#"on_localclient_connect", &basic_player_connect);
    callback::on_spawned(&function_92f0c63);
    scene::function_2e58158b(&function_bbea98ae);
    level.update_aat_hud = &update_aat_hud;
    if (isdefined(level.setupcustomcharacterexerts)) {
        [[ level.setupcustomcharacterexerts ]]();
    }
    level thread zm_ffotd::main_end();
    level thread function_7e3a43c3();
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xfeadac28, Offset: 0xd28
// Size: 0x140
function function_7e3a43c3() {
    level.var_bcb2da96 = 0;
    util::waitforallclients();
    while (true) {
        for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
            player = function_5c10bd79(localclientnum);
            if (isdefined(player)) {
                if (!isdefined(player.last_state)) {
                    player.last_state = 0;
                }
                player.new_state = util::function_cd6c95db(localclientnum);
                if (player.new_state != player.last_state) {
                    if (player.new_state == 1) {
                        player postfx::playpostfxbundle(#"hash_6f0522f3d84f18df");
                    } else {
                        player postfx::stoppostfxbundle(#"hash_6f0522f3d84f18df");
                    }
                }
                player.last_state = player.new_state;
            }
        }
        waitframe(1);
    }
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0xbf5c48d2, Offset: 0xe70
// Size: 0x88
function delay_for_clients_then_execute(func) {
    wait 0.1;
    players = getlocalplayers();
    for (x = 0; x < players.size; x++) {
        while (!clienthassnapshot(x)) {
            waitframe(1);
        }
    }
    wait 0.1;
    level thread [[ func ]]();
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0x65042eac, Offset: 0xf00
// Size: 0x38
function basic_player_connect(localclientnum) {
    if (!isdefined(level._laststand)) {
        level._laststand = [];
    }
    level._laststand[localclientnum] = 0;
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0x4e805ec7, Offset: 0xf40
// Size: 0x64
function force_update_player_clientfields(localclientnum) {
    self endon(#"death");
    while (!clienthassnapshot(localclientnum)) {
        wait 0.25;
    }
    wait 0.25;
    self processclientfieldsasifnew();
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0xfb0
// Size: 0x4
function init_blocker_fx() {
    
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x3e476c1a, Offset: 0xfc0
// Size: 0xec
function init_riser_fx() {
    if (isdefined(level.var_7f632569) && level.var_7f632569) {
    }
    level._effect[#"rise_burst"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect[#"rise_billow"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect[#"rise_dust"] = #"zombie/fx_spawn_dirt_body_dustfalling_zmb";
    if (isdefined(level.riser_type) && level.riser_type == "snow") {
        level._effect[#"rise_billow_snow"] = #"hash_793798659a4b9560";
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x538bc12b, Offset: 0x10b8
// Size: 0x5ec
function init_clientfields() {
    println("<dev string:x91>");
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 1, 1);
    if (is_true(level.use_water_risers)) {
        clientfield::register("actor", "zombie_riser_fx_water", 1, 1, "int", &handle_zombie_risers_water, 1, 1);
    }
    if (is_true(level.use_foliage_risers)) {
        clientfield::register("actor", "zombie_riser_fx_foliage", 1, 1, "int", &handle_zombie_risers_foliage, 1, 1);
    }
    if (is_true(level.use_low_gravity_risers)) {
        clientfield::register("actor", "zombie_riser_fx_lowg", 1, 1, "int", &handle_zombie_risers_lowg, 1, 1);
    }
    clientfield::register("actor", "zombie_ragdoll_explode", 1, 1, "int", &zombie_ragdoll_explode_cb, 0, 1);
    clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int", &zombie_gut_explosion_cb, 0, 1);
    clientfield::register("actor", "zombie_keyline_render", 1, 1, "int", &zombie_zombie_keyline_render_clientfield_cb, 0, 1);
    bits = 4;
    power = struct::get_array("elec_switch_fx", "script_noteworthy");
    if (isdefined(power)) {
        bits = getminbitcountfornum(power.size + 1);
    }
    clientfield::register("world", "zombie_power_on", 1, bits, "int", &zombie_power_clientfield_on, 1, 1);
    clientfield::register("world", "zombie_power_off", 1, bits, "int", &zombie_power_clientfield_off, 1, 1);
    clientfield::register("world", "zesn", 1, 1, "int", &zesn, 1, 1);
    clientfield::register("world", "round_complete_time", 1, 20, "int", &round_complete_time, 0, 1);
    clientfield::register("world", "round_complete_num", 1, 8, "int", &round_complete_num, 0, 1);
    clientfield::register("world", "game_end_time", 1, 20, "int", &game_end_time, 0, 1);
    clientfield::register("world", "quest_complete_time", 1, 20, "int", &quest_complete_time, 0, 1);
    clientfield::register("world", "game_start_time", 1, 20, "int", &game_start_time, 0, 1);
    clientfield::register("scriptmover", "rob_zm_prop_fade", 1, 1, "int", &rob_zm_prop_fade, 0, 0);
    clientfield::register_clientuimodel("ZMInvTalisman.show", #"hash_1bd199f4cd480336", #"show", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.hasBackpack", #"hash_6f4b11a0bee9b73d", #"hasbackpack", 1, 1, "int", undefined, 0, 0);
}

// Namespace zm/zm
// Params 3, eflags: 0x1 linked
// Checksum 0x578595e4, Offset: 0x16b0
// Size: 0x44
function box_monitor(clientnum, state, oldstate) {
    if (isdefined(level._custom_box_monitor)) {
        [[ level._custom_box_monitor ]](clientnum, state, oldstate);
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xb746a205, Offset: 0x1700
// Size: 0x84
function zpo_listener() {
    while (true) {
        int = undefined;
        level waittill(#"zpo", int);
        if (isdefined(int)) {
            level notify(#"power_on", {#is_on:int});
            continue;
        }
        level notify(#"power_on");
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x54380764, Offset: 0x1790
// Size: 0x6c
function zpoff_listener() {
    while (true) {
        int = undefined;
        level waittill(#"zpoff", int);
        if (isdefined(int)) {
            level notify(#"power_off", int);
            continue;
        }
        level notify(#"power_off");
    }
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0xeef2f02d, Offset: 0x1808
// Size: 0x58
function zesn(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        level notify(#"zesn");
    }
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0x54dd0cf, Offset: 0x1868
// Size: 0x58
function zombie_power_clientfield_on(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        level notify(#"zpo", bwastimejump);
    }
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0xadcc424, Offset: 0x18c8
// Size: 0x58
function zombie_power_clientfield_off(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        level notify(#"zpoff", bwastimejump);
    }
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0x28580aad, Offset: 0x1928
// Size: 0x94
function round_complete_time(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    model = createuimodel(function_1df4c3b0(fieldname, #"hash_392aa27a3227c89f"), "round_complete_time");
    setuimodelvalue(model, bwastimejump);
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0x9e32a455, Offset: 0x19c8
// Size: 0x94
function round_complete_num(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    model = createuimodel(function_1df4c3b0(fieldname, #"hash_392aa27a3227c89f"), "round_complete_num");
    setuimodelvalue(model, bwastimejump);
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0xbf8486bd, Offset: 0x1a68
// Size: 0xc4
function game_end_time(localclientnum, *oldval, newval, *bnewent, binitialsnap, *fieldname, *bwastimejump) {
    if (!bwastimejump) {
        level notify(#"end_game");
        level.b_game_ended = 1;
    }
    model = createuimodel(function_1df4c3b0(binitialsnap, #"hash_392aa27a3227c89f"), "game_end_time");
    setuimodelvalue(model, fieldname);
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0x3ca28e9e, Offset: 0x1b38
// Size: 0x94
function quest_complete_time(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    model = createuimodel(function_1df4c3b0(fieldname, #"hash_392aa27a3227c89f"), "quest_complete_time");
    setuimodelvalue(model, bwastimejump);
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0xf7ed478b, Offset: 0x1bd8
// Size: 0x94
function game_start_time(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    model = createuimodel(function_1df4c3b0(fieldname, #"hash_392aa27a3227c89f"), "game_start_time");
    setuimodelvalue(model, bwastimejump);
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0x95bab81d, Offset: 0x1c78
// Size: 0xee
function rob_zm_prop_fade(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self playrenderoverridebundle(#"rob_zm_prop_fade");
        if (!isdefined(self.sndlooper)) {
            self.sndlooper = self playloopsound(#"hash_66df9cab2c64f968");
        }
        return;
    }
    self stoprenderoverridebundle(#"rob_zm_prop_fade");
    if (isdefined(self.sndlooper)) {
        self stoploopsound(self.sndlooper);
        self.sndlooper = undefined;
    }
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0x484fecbc, Offset: 0x1d70
// Size: 0x110
function createzombieeyesinternal(localclientnum) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self._eyearray)) {
        self._eyearray = [];
    }
    if (!isdefined(self._eyearray[localclientnum])) {
        linktag = "j_eyeball_le";
        effect = level._effect[#"eye_glow"];
        if (isdefined(level._override_eye_fx)) {
            effect = level._override_eye_fx;
        }
        if (isdefined(self._eyeglow_fx_override)) {
            effect = self._eyeglow_fx_override;
        }
        if (isdefined(self._eyeglow_tag_override)) {
            linktag = self._eyeglow_tag_override;
        }
        self._eyearray[localclientnum] = util::playfxontag(localclientnum, effect, self, linktag);
    }
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0x6e4e5453, Offset: 0x1e88
// Size: 0x24
function createzombieeyes(localclientnum) {
    self thread createzombieeyesinternal(localclientnum);
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0xa789d88c, Offset: 0x1eb8
// Size: 0x64
function deletezombieeyes(localclientnum) {
    if (isdefined(self._eyearray)) {
        if (isdefined(self._eyearray[localclientnum])) {
            deletefx(localclientnum, self._eyearray[localclientnum], 1);
            self._eyearray[localclientnum] = undefined;
        }
    }
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0x3b0cfe32, Offset: 0x1f28
// Size: 0x72
function zombie_zombie_keyline_render_clientfield_cb(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(bwastimejump)) {
        return;
    }
    if (is_true(level.debug_keyline_zombies)) {
        if (bwastimejump) {
        }
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x6fedfbdf, Offset: 0x1fa8
// Size: 0x24
function get_eyeball_on_luminance() {
    if (isdefined(level.eyeball_on_luminance_override)) {
        return level.eyeball_on_luminance_override;
    }
    return 1;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xaee7ac74, Offset: 0x1fd8
// Size: 0x22
function get_eyeball_off_luminance() {
    if (isdefined(level.eyeball_off_luminance_override)) {
        return level.eyeball_off_luminance_override;
    }
    return 0;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xc5b1c89a, Offset: 0x2008
// Size: 0x4a
function get_eyeball_color() {
    val = 0;
    if (isdefined(level.zombie_eyeball_color_override)) {
        val = level.zombie_eyeball_color_override;
    }
    if (isdefined(self.zombie_eyeball_color_override)) {
        val = self.zombie_eyeball_color_override;
    }
    return val;
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0xcaf44db9, Offset: 0x2060
// Size: 0x5c
function zombie_ragdoll_explode_cb(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self zombie_wait_explode(fieldname);
    }
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0x9aea1885, Offset: 0x20c8
// Size: 0xc4
function zombie_gut_explosion_cb(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (isdefined(level._effect[#"zombie_guts_explosion"])) {
            org = self gettagorigin("J_SpineLower");
            if (isdefined(org)) {
                playfx(fieldname, level._effect[#"zombie_guts_explosion"], org);
            }
        }
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x7dd8f085, Offset: 0x2198
// Size: 0x2c
function init_zombie_explode_fx() {
    level._effect[#"zombie_guts_explosion"] = #"zombie/fx_blood_torso_explo_lg_zmb";
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0x6d8b94ff, Offset: 0x21d0
// Size: 0x114
function zombie_wait_explode(localclientnum) {
    where = self gettagorigin("J_SpineLower");
    if (!isdefined(where)) {
        where = self.origin;
    }
    start = gettime();
    while (gettime() - start < 2000) {
        if (isdefined(self)) {
            where = self gettagorigin("J_SpineLower");
            if (!isdefined(where)) {
                where = self.origin;
            }
        }
        waitframe(1);
    }
    if (isdefined(level._effect[#"zombie_guts_explosion"]) && util::is_mature()) {
        playfx(localclientnum, level._effect[#"zombie_guts_explosion"], where);
    }
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0x8351bbbe, Offset: 0x22f0
// Size: 0x3c
function mark_piece_gibbed(piece_index) {
    if (!isdefined(self.gibbed_pieces)) {
        self.gibbed_pieces = [];
    }
    self.gibbed_pieces[self.gibbed_pieces.size] = piece_index;
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0xc3c127fc, Offset: 0x2338
// Size: 0x62
function has_gibbed_piece(piece_index) {
    if (!isdefined(self.gibbed_pieces)) {
        return false;
    }
    for (i = 0; i < self.gibbed_pieces.size; i++) {
        if (self.gibbed_pieces[i] == piece_index) {
            return true;
        }
    }
    return false;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xb3ea34d1, Offset: 0x23a8
// Size: 0x1c4
function do_headshot_gib_fx() {
    fxtag = "j_neck";
    fxorigin = self gettagorigin(fxtag);
    upvec = anglestoup(self gettagangles(fxtag));
    forwardvec = anglestoforward(self gettagangles(fxtag));
    players = level.localplayers;
    for (i = 0; i < players.size; i++) {
        playfx(i, level._effect[#"headshot"], fxorigin, forwardvec, upvec);
        playfx(i, level._effect[#"headshot_nochunks"], fxorigin, forwardvec, upvec);
    }
    playsound(0, #"zmb_zombie_head_gib", fxorigin);
    wait 0.3;
    if (isdefined(self)) {
        players = level.localplayers;
        for (i = 0; i < players.size; i++) {
            util::playfxontag(i, level._effect[#"bloodspurt"], self, fxtag);
        }
    }
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0x91231a65, Offset: 0x2578
// Size: 0xac
function do_gib_fx(tag) {
    players = level.localplayers;
    for (i = 0; i < players.size; i++) {
        util::playfxontag(i, level._effect[#"animscript_gib_fx"], self, tag);
    }
    playsound(0, #"zmb_death_gibs", self gettagorigin(tag));
}

// Namespace zm/zm
// Params 2, eflags: 0x1 linked
// Checksum 0xe251fa76, Offset: 0x2630
// Size: 0x20c
function do_gib(model, tag) {
    start_pos = self gettagorigin(tag);
    start_angles = self gettagangles(tag);
    wait 0.016;
    end_pos = undefined;
    angles = undefined;
    if (!isdefined(self)) {
        end_pos = start_pos + anglestoforward(start_angles) * 10;
        angles = start_angles;
    } else {
        end_pos = self gettagorigin(tag);
        angles = self gettagangles(tag);
    }
    if (isdefined(self._gib_vel)) {
        forward = self._gib_vel;
        self._gib_vel = undefined;
    } else {
        forward = vectornormalize(end_pos - start_pos);
        forward *= randomfloatrange(0.6, 1);
        forward += (0, 0, randomfloatrange(0.4, 0.7));
    }
    createdynentandlaunch(0, model, end_pos, angles, start_pos, forward, level._effect[#"animscript_gibtrail_fx"], 1);
    if (isdefined(self)) {
        self do_gib_fx(tag);
        return;
    }
    playsound(0, #"zmb_death_gibs", end_pos);
}

// Namespace zm/zm
// Params 2, eflags: 0x1 linked
// Checksum 0x3d2925a0, Offset: 0x2848
// Size: 0xb4
function do_hat_gib(model, tag) {
    start_pos = self gettagorigin(tag);
    start_angles = self gettagangles(tag);
    up_angles = (0, 0, 1);
    force = (0, 0, randomfloatrange(1.4, 1.7));
    createdynentandlaunch(0, model, start_pos, up_angles, start_pos, force);
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x4273806e, Offset: 0x2908
// Size: 0x24
function check_should_gib() {
    if (level.gibcount <= level.gibmaxcount) {
        return true;
    }
    return false;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x6691306f, Offset: 0x2938
// Size: 0x48
function resetgibcounter() {
    self endon(#"disconnect");
    while (true) {
        wait level.gibresettime;
        level.gibtimer = 0;
        level.gibcount = 0;
    }
}

// Namespace zm/zm
// Params 3, eflags: 0x1 linked
// Checksum 0x15f424f6, Offset: 0x2988
// Size: 0x73e
function on_gib_event(localclientnum, type, locations) {
    if (localclientnum != 0) {
        return;
    }
    if (!util::is_mature()) {
        return;
    }
    if (!isdefined(self._gib_def)) {
        return;
    }
    if (isdefined(level._gib_overload_func)) {
        if (self [[ level._gib_overload_func ]](type, locations)) {
            return;
        }
    }
    if (!check_should_gib()) {
        return;
    }
    level.gibcount++;
    for (i = 0; i < locations.size; i++) {
        if (isdefined(self.gibbed) && level._zombie_gib_piece_index_head != locations[i]) {
            continue;
        }
        switch (locations[i]) {
        case 0:
            if (isdefined(self._gib_def.gibspawn1) && isdefined(self._gib_def.gibspawntag1)) {
                self thread do_gib(self._gib_def.gibspawn1, self._gib_def.gibspawntag1);
            }
            if (isdefined(self._gib_def.gibspawn2) && isdefined(self._gib_def.gibspawntag2)) {
                self thread do_gib(self._gib_def.gibspawn2, self._gib_def.gibspawntag2);
            }
            if (isdefined(self._gib_def.gibspawn3) && isdefined(self._gib_def.gibspawntag3)) {
                self thread do_gib(self._gib_def.gibspawn3, self._gib_def.gibspawntag3);
            }
            if (isdefined(self._gib_def.gibspawn4) && isdefined(self._gib_def.gibspawntag4)) {
                self thread do_gib(self._gib_def.gibspawn4, self._gib_def.gibspawntag4);
            }
            if (isdefined(self._gib_def.gibspawn5) && isdefined(self._gib_def.gibspawntag5)) {
                self thread do_hat_gib(self._gib_def.gibspawn5, self._gib_def.gibspawntag5);
            }
            self thread do_headshot_gib_fx();
            self thread do_gib_fx("J_SpineLower");
            mark_piece_gibbed(level._zombie_gib_piece_index_right_arm);
            mark_piece_gibbed(level._zombie_gib_piece_index_left_arm);
            mark_piece_gibbed(level._zombie_gib_piece_index_right_leg);
            mark_piece_gibbed(level._zombie_gib_piece_index_left_leg);
            mark_piece_gibbed(level._zombie_gib_piece_index_head);
            mark_piece_gibbed(level._zombie_gib_piece_index_hat);
            break;
        case 1:
            if (isdefined(self._gib_def.gibspawn1) && isdefined(self._gib_def.gibspawntag1)) {
                self thread do_gib(self._gib_def.gibspawn1, self._gib_def.gibspawntag1);
            } else {
                if (isdefined(self._gib_def.gibspawn1)) {
                }
                if (isdefined(self._gib_def.gibspawntag1)) {
                }
            }
            mark_piece_gibbed(level._zombie_gib_piece_index_right_arm);
            break;
        case 2:
            if (isdefined(self._gib_def.gibspawn2) && isdefined(self._gib_def.gibspawntag2)) {
                self thread do_gib(self._gib_def.gibspawn2, self._gib_def.gibspawntag2);
            } else {
                if (isdefined(self._gib_def.gibspawn2)) {
                }
                if (isdefined(self._gib_def.gibspawntag2)) {
                }
            }
            mark_piece_gibbed(level._zombie_gib_piece_index_left_arm);
            break;
        case 3:
            if (isdefined(self._gib_def.gibspawn3) && isdefined(self._gib_def.gibspawntag3)) {
                self thread do_gib(self._gib_def.gibspawn3, self._gib_def.gibspawntag3);
            }
            mark_piece_gibbed(level._zombie_gib_piece_index_right_leg);
            break;
        case 4:
            if (isdefined(self._gib_def.gibspawn4) && isdefined(self._gib_def.gibspawntag4)) {
                self thread do_gib(self._gib_def.gibspawn4, self._gib_def.gibspawntag4);
            }
            mark_piece_gibbed(level._zombie_gib_piece_index_left_leg);
            break;
        case 5:
            self thread do_headshot_gib_fx();
            mark_piece_gibbed(level._zombie_gib_piece_index_head);
            break;
        case 6:
            self thread do_gib_fx("J_SpineLower");
            break;
        case 7:
            if (isdefined(self._gib_def.gibspawn5) && isdefined(self._gib_def.gibspawntag5)) {
                self thread do_hat_gib(self._gib_def.gibspawn5, self._gib_def.gibspawntag5);
            }
            mark_piece_gibbed(level._zombie_gib_piece_index_hat);
            break;
        }
    }
    self.gibbed = 1;
}

// Namespace zm/zm
// Params 4, eflags: 0x0
// Checksum 0x6b1b3ec2, Offset: 0x30d0
// Size: 0x244
function zombie_vision_set_apply(str_visionset, int_priority, flt_transition_time, int_clientnum) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(self._zombie_visionset_list)) {
        self._zombie_visionset_list = [];
    }
    if (!isdefined(str_visionset) || !isdefined(int_priority)) {
        return;
    }
    if (!isdefined(flt_transition_time)) {
        flt_transition_time = 1;
    }
    if (!isdefined(int_clientnum)) {
        if (self function_21c0fa55()) {
            int_clientnum = self getlocalclientnumber();
        }
        if (!isdefined(int_clientnum)) {
            return;
        }
    }
    already_in_array = 0;
    if (self._zombie_visionset_list.size != 0) {
        for (i = 0; i < self._zombie_visionset_list.size; i++) {
            if (isdefined(self._zombie_visionset_list[i].vision_set) && self._zombie_visionset_list[i].vision_set == str_visionset) {
                already_in_array = 1;
                if (self._zombie_visionset_list[i].priority != int_priority) {
                    self._zombie_visionset_list[i].priority = int_priority;
                }
                break;
            }
        }
    }
    if (!already_in_array) {
        temp_struct = spawnstruct();
        temp_struct.vision_set = str_visionset;
        temp_struct.priority = int_priority;
        array::add(self._zombie_visionset_list, temp_struct, 0);
    }
    vision_to_set = self zombie_highest_vision_set_apply();
    if (isdefined(vision_to_set)) {
        visionsetnaked(int_clientnum, vision_to_set, flt_transition_time);
        return;
    }
    visionsetnaked(int_clientnum, "undefined", flt_transition_time);
}

// Namespace zm/zm
// Params 3, eflags: 0x0
// Checksum 0x53c15cc7, Offset: 0x3320
// Size: 0x1ac
function zombie_vision_set_remove(str_visionset, flt_transition_time, int_clientnum) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(str_visionset)) {
        return;
    }
    if (!isdefined(flt_transition_time)) {
        flt_transition_time = 1;
    }
    if (!isdefined(self._zombie_visionset_list)) {
        self._zombie_visionset_list = [];
    }
    if (!isdefined(int_clientnum)) {
        if (self function_21c0fa55()) {
            int_clientnum = self getlocalclientnumber();
        }
        if (!isdefined(int_clientnum)) {
            return;
        }
    }
    temp_struct = undefined;
    for (i = 0; i < self._zombie_visionset_list.size; i++) {
        if (isdefined(self._zombie_visionset_list[i].vision_set) && self._zombie_visionset_list[i].vision_set == str_visionset) {
            temp_struct = self._zombie_visionset_list[i];
        }
    }
    if (isdefined(temp_struct)) {
        arrayremovevalue(self._zombie_visionset_list, temp_struct);
    }
    vision_to_set = self zombie_highest_vision_set_apply();
    if (isdefined(vision_to_set)) {
        visionsetnaked(int_clientnum, vision_to_set, flt_transition_time);
        return;
    }
    visionsetnaked(int_clientnum, "default", flt_transition_time);
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x803c8c44, Offset: 0x34d8
// Size: 0xbe
function zombie_highest_vision_set_apply() {
    if (!isdefined(self._zombie_visionset_list)) {
        return;
    }
    highest_score = 0;
    highest_score_vision = undefined;
    for (i = 0; i < self._zombie_visionset_list.size; i++) {
        if (isdefined(self._zombie_visionset_list[i].priority) && self._zombie_visionset_list[i].priority > highest_score) {
            highest_score = self._zombie_visionset_list[i].priority;
            highest_score_vision = self._zombie_visionset_list[i].vision_set;
        }
    }
    return highest_score_vision;
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0x44ee2d96, Offset: 0x35a0
// Size: 0x154
function handle_zombie_risers_foliage(*localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    level endon(#"demo_jump");
    self endon(#"death");
    if (!fieldname && bwastimejump) {
        localplayers = level.localplayers;
        playsound(0, #"zmb_zombie_spawn", self.origin);
        burst_fx = level._effect[#"rise_burst_foliage"];
        billow_fx = level._effect[#"rise_billow_foliage"];
        type = "foliage";
        for (i = 0; i < localplayers.size; i++) {
            self thread rise_dust_fx(i, type, billow_fx, burst_fx);
        }
    }
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0x1127db61, Offset: 0x3700
// Size: 0x154
function handle_zombie_risers_water(*localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    level endon(#"demo_jump");
    self endon(#"death");
    if (!fieldname && bwastimejump) {
        localplayers = level.localplayers;
        playsound(0, #"zmb_zombie_spawn_water", self.origin);
        burst_fx = level._effect[#"rise_burst_water"];
        billow_fx = level._effect[#"rise_billow_water"];
        type = "water";
        for (i = 0; i < localplayers.size; i++) {
            self thread rise_dust_fx(i, type, billow_fx, burst_fx);
        }
    }
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0xb1f7544, Offset: 0x3860
// Size: 0x1cc
function handle_zombie_risers(*localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    level endon(#"demo_jump");
    self endon(#"death");
    if (!fieldname && bwastimejump) {
        localplayers = level.localplayers;
        sound = "zmb_zombie_spawn";
        burst_fx = level._effect[#"rise_burst"];
        billow_fx = level._effect[#"rise_billow"];
        type = "dirt";
        if (isdefined(level.riser_type) && level.riser_type == "snow") {
            sound = "zmb_zombie_spawn_snow";
            burst_fx = level._effect[#"rise_burst_snow"];
            billow_fx = level._effect[#"rise_billow_snow"];
            type = "snow";
        }
        playsound(0, sound, self.origin);
        for (i = 0; i < localplayers.size; i++) {
            self thread rise_dust_fx(i, type, billow_fx, burst_fx);
        }
    }
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0xfb0b97e9, Offset: 0x3a38
// Size: 0x1cc
function handle_zombie_risers_lowg(*localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    level endon(#"demo_jump");
    self endon(#"death");
    if (!fieldname && bwastimejump) {
        localplayers = level.localplayers;
        sound = "zmb_zombie_spawn";
        burst_fx = level._effect[#"rise_burst_lg"];
        billow_fx = level._effect[#"rise_billow_lg"];
        type = "dirt";
        if (isdefined(level.riser_type) && level.riser_type == "snow") {
            sound = "zmb_zombie_spawn_snow";
            burst_fx = level._effect[#"rise_burst_snow"];
            billow_fx = level._effect[#"rise_billow_snow"];
            type = "snow";
        }
        playsound(0, sound, self.origin);
        for (i = 0; i < localplayers.size; i++) {
            self thread rise_dust_fx(i, type, billow_fx, burst_fx);
        }
    }
}

// Namespace zm/zm
// Params 4, eflags: 0x1 linked
// Checksum 0x39b35203, Offset: 0x3c10
// Size: 0x300
function rise_dust_fx(clientnum, type, billow_fx, burst_fx) {
    dust_tag = "J_SpineUpper";
    self endon(#"death");
    level endon(#"demo_jump");
    if (isdefined(level.zombie_custom_riser_fx_handler)) {
        s_info = self [[ level.zombie_custom_riser_fx_handler ]]();
        if (isdefined(s_info)) {
            if (isdefined(s_info.burst_fx)) {
                burst_fx = s_info.burst_fx;
            }
            if (isdefined(s_info.billow_fx)) {
                billow_fx = s_info.billow_fx;
            }
            if (isdefined(s_info.type)) {
                type = s_info.type;
            }
        }
    }
    if (isdefined(burst_fx)) {
        playfx(clientnum, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
    }
    wait 0.25;
    if (isdefined(billow_fx)) {
        playfx(clientnum, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
    }
    wait 2;
    dust_time = 5.5;
    dust_interval = 0.3;
    player = level.localplayers[clientnum];
    effect = level._effect[#"rise_dust"];
    if (type == "water") {
        effect = level._effect[#"rise_dust_water"];
    } else if (type == "snow") {
        effect = level._effect[#"rise_dust_snow"];
    } else if (type == "foliage") {
        effect = level._effect[#"rise_dust_foliage"];
    } else if (type == "none") {
        return;
    }
    for (t = 0; t < dust_time; t += dust_interval) {
        if (!isdefined(self)) {
            return;
        }
        util::playfxontag(clientnum, effect, self, dust_tag);
        wait dust_interval;
    }
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0xc6e11903, Offset: 0x3f18
// Size: 0x34
function on_player_laststand(localclientnum) {
    println("<dev string:xbd>" + localclientnum);
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0x6dd9f5da, Offset: 0x3f58
// Size: 0x8c
function end_last_stand(clientnum) {
    self waittill(#"laststandend");
    println("<dev string:xe5>" + clientnum);
    wait 0.7;
    println("<dev string:x106>");
    playsound(clientnum, #"revive_gasp");
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0x2d87cda9, Offset: 0x3ff0
// Size: 0x16e
function last_stand_thread(clientnum) {
    self thread end_last_stand(clientnum);
    self endon(#"laststandend");
    println("<dev string:x10f>" + clientnum);
    pause = 0.5;
    for (vol = 0.5; true; vol = 1) {
        id = playsound(clientnum, #"chr_heart_beat");
        setsoundvolume(id, vol);
        wait pause;
        if (pause < 2) {
            pause *= 1.05;
            if (pause > 2) {
                pause = 2;
            }
        }
        if (vol < 1) {
            vol *= 1.05;
            if (vol > 1) {
            }
        }
    }
}

// Namespace zm/zm
// Params 3, eflags: 0x0
// Checksum 0x521430c9, Offset: 0x4168
// Size: 0x1c0
function last_stand_monitor(clientnum, state, *oldstate) {
    player = level.localplayers[state];
    players = level.localplayers;
    if (!isdefined(player)) {
        return;
    }
    if (oldstate == "1") {
        if (!level._laststand[state]) {
            if (!isdefined(level.lslooper)) {
                level.lslooper = spawn(0, player.origin, "script.origin");
            }
            player thread last_stand_thread(state);
            if (players.size <= 1) {
                level.lslooper playloopsound(#"evt_laststand_loop", 0.3);
            }
            level._laststand[state] = 1;
        }
        return;
    }
    if (level._laststand[state]) {
        if (isdefined(level.lslooper)) {
            level.lslooper stopallloopsounds(0.7);
            playsound(0, #"evt_laststand_in", (0, 0, 0));
        }
        player notify(#"laststandend");
        level._laststand[state] = 0;
    }
}

// Namespace zm/zm
// Params 2, eflags: 0x1 linked
// Checksum 0xc269506f, Offset: 0x4330
// Size: 0x2c
function function_bbea98ae(localclientnum, *b_igc_active) {
    self function_92f0c63(b_igc_active);
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0x681514c6, Offset: 0x4368
// Size: 0x7c
function function_92f0c63(localclientnum) {
    self renderoverridebundle::function_c8d97b8e(localclientnum, #"zm_friendly", #"hash_60913f86a5a5a3f1");
    self renderoverridebundle::function_c8d97b8e(localclientnum, #"zm_friendly_ls", #"hash_60913f86a5a5a3f1");
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0x9f38be59, Offset: 0x43f0
// Size: 0xe4
function laststand(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    function_92f0c63(fieldname);
    if (isplayer(self) && self function_21c0fa55()) {
        laststand_model = createuimodel(function_1df4c3b0(fieldname, #"zm_hud"), "lastStand");
        setuimodelvalue(laststand_model, bwastimejump);
    }
}

// Namespace zm/zm
// Params 2, eflags: 0x5 linked
// Checksum 0x1c4d4526, Offset: 0x44e0
// Size: 0xa6
function private function_b9c917cc(var_6142f944, *str_bundle) {
    if (self function_21c0fa55()) {
        return false;
    }
    if (!self function_ca024039()) {
        return false;
    }
    if (is_true(level.var_dc60105c)) {
        return false;
    }
    if (isigcactive(str_bundle)) {
        return false;
    }
    if (is_true(self.var_74b9b03b)) {
        return false;
    }
    return true;
}

// Namespace zm/zm
// Params 2, eflags: 0x5 linked
// Checksum 0xf64a47f8, Offset: 0x4590
// Size: 0xb6
function private function_a1ab192(var_6142f944, str_bundle) {
    if (!self function_b9c917cc(var_6142f944, str_bundle)) {
        return false;
    }
    if (isplayer(self) || self function_21c0fa55() || isdemoplaying()) {
        return false;
    }
    if (is_true(level.var_dc60105c)) {
        return false;
    }
    if (isigcactive(var_6142f944)) {
        return false;
    }
    return true;
}

// Namespace zm/zm
// Params 7, eflags: 0x1 linked
// Checksum 0xef212351, Offset: 0x4650
// Size: 0x14c
function update_aat_hud(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    str_localized = aat::get_string(bwastimejump);
    icon = aat::get_icon(bwastimejump);
    if (str_localized == "none") {
        str_localized = #"";
    }
    aatmodel = createuimodel(function_1df4c3b0(fieldname, #"zm_hud"), "aat");
    setuimodelvalue(aatmodel, str_localized);
    aaticonmodel = createuimodel(function_1df4c3b0(fieldname, #"zm_hud"), "aatIcon");
    setuimodelvalue(aaticonmodel, icon);
}

