#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\zm_common\callbacks;

#namespace namespace_c3c0ef6f;

// Namespace namespace_c3c0ef6f/namespace_c3c0ef6f
// Params 0, eflags: 0x1 linked
// Checksum 0x532f4035, Offset: 0x140
// Size: 0xcc
function init() {
    callback::on_connect(&function_95b24959);
    callback::on_ai_killed(&function_df8c20ce);
    callback::on_player_damage(&function_43404d65);
    callback::function_74872db6(&function_4f3de675);
    level.var_d8104f84 = 100;
    level.var_2a5adcff = 14;
    level.var_4b8d723f = getent("zone_kill_achievement", "script_noteworthy");
}

// Namespace namespace_c3c0ef6f/namespace_c3c0ef6f
// Params 1, eflags: 0x1 linked
// Checksum 0x26a43039, Offset: 0x218
// Size: 0x282
function function_df8c20ce(s_params) {
    e_player = s_params.eattacker;
    weapon = s_params.weapon;
    ai_type = self.aitype;
    if (isplayer(e_player)) {
        if (!isdefined(e_player.var_f96ce53f)) {
            e_player.var_f96ce53f = 0;
        }
        if (isdefined(weapon) && weapon.inventorytype != #"offhand" && !is_true(e_player.var_df6978da)) {
            if (!is_true(e_player.var_f96ce53f)) {
                if (ai_type === "spawner_zm_steiner_split_radiation_bomb" || ai_type === "spawner_zm_steiner_split_radiation_blast") {
                    switch (ai_type) {
                    case #"spawner_zm_steiner_split_radiation_bomb":
                        e_player.var_287dbab8 = "spawner_zm_steiner_split_radiation_blast";
                        break;
                    case #"spawner_zm_steiner_split_radiation_blast":
                        e_player.var_287dbab8 = "spawner_zm_steiner_split_radiation_bomb";
                        break;
                    }
                    e_player.var_f96ce53f = 1;
                    e_player thread function_735fa731();
                }
            } else if (e_player.var_287dbab8 === ai_type) {
                /#
                    e_player iprintlnbold("<dev string:x38>");
                #/
                e_player.var_dde46629 = 1;
            }
        }
        if (!isdefined(e_player.kill_count)) {
            e_player.kill_count = 0;
        }
        if (!is_true(e_player.var_12445983)) {
            if (e_player.kill_count < level.var_d8104f84 && e_player istouching(level.var_4b8d723f)) {
                e_player.kill_count++;
            }
            if (e_player.kill_count >= level.var_d8104f84) {
                /#
                    e_player iprintlnbold("<dev string:x50>");
                #/
                e_player.var_12445983 = 1;
            }
        }
    }
}

// Namespace namespace_c3c0ef6f/namespace_c3c0ef6f
// Params 1, eflags: 0x1 linked
// Checksum 0x8bc7b782, Offset: 0x4a8
// Size: 0x66
function function_43404d65(params) {
    amount = params.idamage;
    if (isdefined(amount) && (!isdefined(self.var_6616d107) || self.var_6616d107 != level.round_number)) {
        self.var_6616d107 = level.round_number;
    }
}

// Namespace namespace_c3c0ef6f/namespace_c3c0ef6f
// Params 0, eflags: 0x1 linked
// Checksum 0x4e7a8774, Offset: 0x518
// Size: 0x84
function function_95b24959() {
    self.var_df6978da = 0;
    self.var_12445983 = 0;
    self.var_d7073519 = 0;
    if (!isdefined(self.var_6616d107)) {
        self.var_6616d107 = 0;
    }
    self thread function_e361ce1b();
    self thread function_ceba8321();
    self thread function_9a4f865b();
}

// Namespace namespace_c3c0ef6f/namespace_c3c0ef6f
// Params 0, eflags: 0x1 linked
// Checksum 0x2c2f6178, Offset: 0x5a8
// Size: 0x64
function function_e361ce1b() {
    self endon(#"disconnect");
    level endon(#"end_game");
    level flag::wait_till("pap_quest_completed");
    /#
        self iprintlnbold("<dev string:x8b>");
    #/
}

// Namespace namespace_c3c0ef6f/namespace_c3c0ef6f
// Params 0, eflags: 0x1 linked
// Checksum 0xd053f379, Offset: 0x618
// Size: 0x64
function function_9a4f865b() {
    self endon(#"disconnect");
    level endon(#"end_game");
    level waittill(#"main_quest_completed");
    /#
        self iprintlnbold("<dev string:x9a>");
    #/
}

// Namespace namespace_c3c0ef6f/namespace_c3c0ef6f
// Params 0, eflags: 0x1 linked
// Checksum 0x1bab8288, Offset: 0x688
// Size: 0x64
function function_ceba8321() {
    self endon(#"disconnect");
    level endon(#"end_game");
    level flag::wait_till("ww_quest_completed");
    /#
        self iprintlnbold("<dev string:xab>");
    #/
}

// Namespace namespace_c3c0ef6f/namespace_c3c0ef6f
// Params 0, eflags: 0x1 linked
// Checksum 0x82ee6d61, Offset: 0x6f8
// Size: 0x84
function function_735fa731() {
    self notify("4109974bcd63cde4");
    self endon("4109974bcd63cde4");
    self endon(#"end_game", #"disconnect", #"death");
    waitframe(10);
    self.var_f96ce53f = 0;
    /#
        self iprintlnbold("<dev string:xc6>");
    #/
}

// Namespace namespace_c3c0ef6f/namespace_c3c0ef6f
// Params 0, eflags: 0x1 linked
// Checksum 0x55249f18, Offset: 0x788
// Size: 0xfe
function function_4f3de675() {
    foreach (player in getplayers()) {
        if (!is_true(player.var_d7073519)) {
            var_71f16302 = level.round_number - player.var_6616d107;
            if (var_71f16302 >= level.var_2a5adcff) {
                /#
                    player iprintlnbold("<dev string:xdc>");
                #/
                player.var_d7073519 = 1;
            }
        }
    }
}

