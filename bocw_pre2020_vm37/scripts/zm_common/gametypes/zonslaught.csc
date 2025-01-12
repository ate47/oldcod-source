#using script_45f6af07fe906785;
#using script_59153c36a5817904;
#using script_60793766a26de8df;
#using script_6243781aa5394e62;
#using script_62c40d9a3acec9b1;
#using script_67f5308f28bd01b6;
#using script_7759896b3d4ee753;
#using script_78e418df6f2f20f6;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\oob;
#using scripts\core_common\util_shared;
#using scripts\zm\weapons\zm_weap_cymbal_monkey;

#namespace zonslaught;

// Namespace zonslaught/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x8687e501, Offset: 0x398
// Size: 0x604
function event_handler[gametype_init] main(*eventstruct) {
    level._zombie_gamemodeprecache = &onprecachegametype;
    level._zombie_gamemodemain = &onstartgametype;
    println("<dev string:x38>");
    level.var_36a81b25 = 1;
    clientfield::register("actor", "enemy_on_radar", 1, 1, "int", &enemy_on_radar, 0, 1);
    clientfield::register("scriptmover", "boss_zone_on_radar", 1, 2, "int", &boss_zone_on_radar, 0, 0);
    clientfield::register_clientuimodel("hudItems.onslaught.wave_number", #"hash_6f4b11a0bee9b73d", [#"onslaught", #"hash_32acff8a008c0f5c"], 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.onslaught.bosskill_count", #"hash_6f4b11a0bee9b73d", [#"onslaught", #"hash_2ec97775399a0680"], 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.onslaught.zombie_count", #"hash_6f4b11a0bee9b73d", [#"onslaught", #"zombie_count"], 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.onslaught.time_min", #"hash_6f4b11a0bee9b73d", [#"onslaught", #"hash_5e9e69449abc885b"], 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.onslaught.time_sec", #"hash_6f4b11a0bee9b73d", [#"onslaught", #"hash_11954244b7517b3e"], 1, 6, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.onslaught.death_circle_countdown", #"hash_6f4b11a0bee9b73d", [#"onslaught", #"hash_4f76cc32e9dac8a"], 1, 6, "int", undefined, 0, 0);
    clientfield::register("toplayer", "onslaught_timer", 1, getminbitcountfornum(540), "int", &function_bb753058, 0, 1);
    level.othervisuals = [];
    clientfield::register("scriptmover", "orb_spawn", 1, 1, "int", &orb_spawn, 0, 0);
    clientfield::register("scriptmover", "bot_claim_fx", 1, 2, "int", &bot_claim_fx, 0, 0);
    clientfield::register("actor", "orb_soul_capture_fx", 1, 3, "int", &orb_soul_capture_fx, 0, 0);
    level.mp_gamemode_onslaught_bossalert_msg = mp_gamemode_onslaught_bossalert_msg::register();
    level.mp_gamemode_onslaught_msg = mp_gamemode_onslaught_msg::register();
    level.mp_gamemode_onslaught_2nd_msg = mp_gamemode_onslaught_2nd_msg::register();
    level.mp_gamemode_onslaught_score_msg = mp_gamemode_onslaught_score_msg::register();
    level.var_cb513044 = namespace_cb513044::register();
    level._effect[#"hash_30f998a8b281bea0"] = "wz/fx8_zm_box_marker_red";
    level._effect[#"hash_78e041fbc245e0d2"] = "wz/fx8_magicbox_marker_fl_red";
    level._effect[#"hash_d7a655f41aa4b03"] = "zombie/fx9_aether_tear_portal";
    level.var_cb450873 = #"hash_4bfee97440e2b6f2";
    callback::on_localclient_connect(&on_localplayer_connect);
    println("<dev string:x66>");
}

// Namespace zonslaught/zonslaught
// Params 0, eflags: 0x0
// Checksum 0x625915c6, Offset: 0x9a8
// Size: 0x24
function onprecachegametype() {
    println("<dev string:x92>");
}

// Namespace zonslaught/zonslaught
// Params 0, eflags: 0x0
// Checksum 0x1553a20c, Offset: 0x9d8
// Size: 0x24
function onstartgametype() {
    println("<dev string:xb7>");
}

// Namespace zonslaught/zonslaught
// Params 1, eflags: 0x4
// Checksum 0x87f5bed3, Offset: 0xa08
// Size: 0x6a
function private function_c8b7588d(localclientnum) {
    return getuimodel(getuimodel(function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d"), #"onslaught"), #"timer");
}

// Namespace zonslaught/zonslaught
// Params 7, eflags: 0x4
// Checksum 0x552d69, Offset: 0xa80
// Size: 0xc4
function private function_bb753058(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!function_65b9eb0f(fieldname)) {
        timer_model = function_c8b7588d(fieldname);
        duration_msec = bwastimejump * 1000;
        setuimodelvalue(timer_model, getservertime(fieldname, 1) + duration_msec);
    }
}

// Namespace zonslaught/zonslaught
// Params 1, eflags: 0x4
// Checksum 0xc8f41a, Offset: 0xb50
// Size: 0x44
function private on_localplayer_connect(localclientnum) {
    timer_model = function_c8b7588d(localclientnum);
    setuimodelvalue(timer_model, 0);
}

// Namespace zonslaught/zonslaught
// Params 7, eflags: 0x0
// Checksum 0xda3423b9, Offset: 0xba0
// Size: 0x74
function enemy_on_radar(*local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self enableonradar();
        return;
    }
    self disableonradar();
}

// Namespace zonslaught/zonslaught
// Params 7, eflags: 0x0
// Checksum 0x9d20ae75, Offset: 0xc20
// Size: 0x2c6
function boss_zone_on_radar(local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self setcompassicon("icon_minimap_onslaught_boss");
        self function_bc95cd57(1);
        self enableonradar();
        self function_811196d1(0);
        self.fx1 = playfx(fieldname, level._effect[#"hash_30f998a8b281bea0"], self.origin);
        self.var_97887ef = playfx(fieldname, level._effect[#"hash_78e041fbc245e0d2"], self.origin);
        return;
    }
    if (bwastimejump == 2) {
        self.var_31a246b5 = playfx(fieldname, level._effect[#"hash_d7a655f41aa4b03"], self.origin);
        return;
    }
    if (bwastimejump == 3) {
        if (isdefined(self.var_31a246b5)) {
            stopfx(fieldname, self.var_31a246b5);
            self.var_31a246b5 = undefined;
        }
        return;
    }
    self setcompassicon("icon_minimap_onslaught_boss");
    self function_bc95cd57(0);
    self disableonradar();
    self function_811196d1(1);
    if (isdefined(self.fx1)) {
        stopfx(fieldname, self.fx1);
        self.fx1 = undefined;
    }
    if (isdefined(self.var_97887ef)) {
        stopfx(fieldname, self.var_97887ef);
        self.var_97887ef = undefined;
    }
    if (isdefined(self.var_31a246b5)) {
        stopfx(fieldname, self.var_31a246b5);
        self.var_31a246b5 = undefined;
    }
}

// Namespace zonslaught/zonslaught
// Params 7, eflags: 0x0
// Checksum 0x82d2dda2, Offset: 0xef0
// Size: 0x50
function orb_spawn(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self)) {
        level.var_df7b46d1 = self;
    }
}

// Namespace zonslaught/zonslaught
// Params 7, eflags: 0x0
// Checksum 0xf85d3e00, Offset: 0xf48
// Size: 0x254
function bot_claim_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self.fxid = function_239993de(fieldname, "zombie/fx9_onslaught_orb_trail", self, "tag_origin");
        if (!isdefined(self.var_94ebeb0a)) {
            self.var_94ebeb0a = self playloopsound(#"hash_6d2c4c09332d861b");
        }
        self.var_58e905a8 = playfx(fieldname, "sr/fx9_safehouse_orb_activate", self.origin);
        self playsound(fieldname, #"hash_5b633dca9e743dfa");
        return;
    }
    if (bwastimejump == 2) {
        self.var_58e905a8 = playfx(fieldname, "sr/fx9_safehouse_orb_activate", self.origin);
        self playsound(fieldname, #"hash_4f9c3e88b1452da8");
        return;
    }
    if (isdefined(self.fxid)) {
        killfx(fieldname, self.fxid);
    }
    if (isdefined(self.var_94ebeb0a)) {
        self playsound(fieldname, #"hash_6d9d2d30feed5bad");
        self stoploopsound(self.var_94ebeb0a);
        self.var_94ebeb0a = undefined;
    }
    if (isdefined(self.var_58e905a8)) {
        killfx(fieldname, self.var_58e905a8);
        self.var_58e905a8 = undefined;
    }
    playfx(fieldname, "sr/fx9_safehouse_orb_activate", self.origin);
}

// Namespace zonslaught/zonslaught
// Params 3, eflags: 0x0
// Checksum 0xfaac2a8, Offset: 0x11a8
// Size: 0x130
function fake_physicslaunch(target_pos, power, var_4862f668) {
    start_pos = self.origin;
    gravity = getdvarint(#"bg_gravity", 0) * -1;
    gravity *= var_4862f668;
    dist = distance(start_pos, target_pos);
    time = dist / power;
    delta = target_pos - start_pos;
    drop = 0.5 * gravity * time * time;
    velocity = (delta[0] / time, delta[1] / time, (delta[2] - drop) / time);
    self movegravity(velocity, time);
    return time;
}

// Namespace zonslaught/zonslaught
// Params 7, eflags: 0x0
// Checksum 0xf8e7ef89, Offset: 0x12e0
// Size: 0x244
function orb_soul_capture_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    self endon(#"death");
    if (bwasdemojump && isdefined(level.var_df7b46d1)) {
        e_fx = spawn(fieldname, self.origin, "script_model");
        e_fx setmodel(#"tag_origin");
        e_fx playsound(fieldname, "zmb_onslaught_zsouls_start");
        e_fx.sfx_id = e_fx playloopsound(#"hash_58d856545ecf5e28");
        util::playfxontag(fieldname, "maps/zm_red/fx8_soul_purple", e_fx, "tag_origin");
        wait 0.3;
        power = distance(e_fx.origin, level.var_df7b46d1.origin);
        n_time = e_fx fake_physicslaunch(level.var_df7b46d1.origin + (0, 0, 60), power, 0.85);
        wait n_time;
        playsound(fieldname, "zmb_onslaught_zsouls_end", level.var_df7b46d1.origin);
        e_fx stoploopsound(e_fx.sfx_id);
        util::playfxontag(fieldname, "maps/zm_red/fx8_soul_charge_purple", e_fx, "tag_origin");
        wait 0.3;
        e_fx delete();
    }
}

