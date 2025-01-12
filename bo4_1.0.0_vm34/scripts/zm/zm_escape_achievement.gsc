#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_escape_achievement;

// Namespace zm_escape_achievement/zm_escape_achievement
// Params 0, eflags: 0x0
// Checksum 0xd39118dd, Offset: 0x250
// Size: 0x3c
function init() {
    level thread function_cb7c0798();
    callback::on_connect(&function_5adaf1ef);
}

// Namespace zm_escape_achievement/zm_escape_achievement
// Params 0, eflags: 0x0
// Checksum 0xcd775310, Offset: 0x298
// Size: 0xc4
function function_5adaf1ef() {
    self thread function_72771887();
    self thread function_fb45c3e3();
    self thread function_fc9eddfa();
    self thread function_7473c0cc();
    self thread function_4682dd2b();
    self thread function_564b4b83();
    self thread function_cb253b7();
    self thread function_7c587831();
}

// Namespace zm_escape_achievement/zm_escape_achievement
// Params 0, eflags: 0x4
// Checksum 0x35dfa50c, Offset: 0x368
// Size: 0x3c
function private function_cb7c0798() {
    level waittill(#"hash_108cb6aa18caf726");
    zm_utility::giveachievement_wrapper("zm_escape_most_escape", 1);
}

// Namespace zm_escape_achievement/zm_escape_achievement
// Params 0, eflags: 0x4
// Checksum 0xcdfc9370, Offset: 0x3b0
// Size: 0x44
function private function_72771887() {
    self endon(#"disconnect");
    self waittill(#"hash_6db9af45fe6345fc");
    self zm_utility::giveachievement_wrapper("zm_escape_patch_up");
}

// Namespace zm_escape_achievement/zm_escape_achievement
// Params 0, eflags: 0x4
// Checksum 0xcc8899d7, Offset: 0x400
// Size: 0x44
function private function_fb45c3e3() {
    self endon(#"disconnect");
    self waittill(#"hash_6e0a27b37f225a25");
    self zm_utility::giveachievement_wrapper("zm_escape_hot_stuff");
}

// Namespace zm_escape_achievement/zm_escape_achievement
// Params 0, eflags: 0x4
// Checksum 0x4af1afdc, Offset: 0x450
// Size: 0x2d4
function private function_fc9eddfa() {
    self endon(#"disconnect");
    w_blundergat = getweapon(#"ww_blundergat_t8");
    w_blundergat_upgraded = getweapon(#"ww_blundergat_t8_upgraded");
    w_tomahawk = getweapon(#"tomahawk_t8");
    var_2d10a9a2 = getweapon(#"tomahawk_t8_upgraded");
    w_spoon = getweapon(#"spoon_alcatraz");
    w_spork = getweapon(#"spork_alcatraz");
    var_291bb185 = getweapon(#"spknifeork");
    w_thompson = getweapon(#"smg_thompson_t8");
    w_thompson_upgraded = getweapon(#"smg_thompson_t8_upgraded");
    b_continue = 1;
    while (true) {
        self waittill(#"weapon_change");
        if (isalive(self)) {
            if ((self hasweapon(w_blundergat) || self hasweapon(w_blundergat_upgraded)) && (self hasweapon(w_tomahawk) || self hasweapon(var_2d10a9a2)) && (self hasweapon(w_spoon) || self hasweapon(w_spork) || self hasweapon(var_291bb185)) && (self hasweapon(w_thompson) || self hasweapon(w_thompson_upgraded))) {
                break;
            }
        }
    }
    self zm_utility::giveachievement_wrapper("zm_escape_hist_reenact");
}

// Namespace zm_escape_achievement/zm_escape_achievement
// Params 0, eflags: 0x4
// Checksum 0x6c2eb3d4, Offset: 0x730
// Size: 0x44
function private function_7473c0cc() {
    self endon(#"disconnect");
    self waittill(#"hash_7af72088379d7ac6");
    self zm_utility::giveachievement_wrapper("zm_escape_match_made");
}

// Namespace zm_escape_achievement/zm_escape_achievement
// Params 0, eflags: 0x4
// Checksum 0x1f7fcf64, Offset: 0x780
// Size: 0x1ec
function private function_4682dd2b() {
    self endon(#"disconnect", #"hash_b5d3534da3f4508");
    level endon(#"end_game", #"activate_catwalk");
    if (level flag::get("activate_catwalk")) {
        return;
    }
    if (zm_custom::function_5638f689(#"startround") > 1) {
        return;
    }
    if (zm_custom::function_5638f689(#"zmpowerdoorstate") != 2) {
        while (level.round_number < 20) {
            level waittill(#"end_of_round");
        }
    } else {
        var_21fd4693 = array("zone_model_industries", "zone_model_industries_upper", "zone_west_side_exterior_upper", "zone_west_side_exterior_upper_02", "zone_west_side_exterior_lower", "zone_powerhouse", "zone_west_side_exterior_tunnel", "zone_new_industries", "zone_new_industries_transverse_tunnel");
        while (level.round_number < 20) {
            str_zone = self zm_zonemgr::get_player_zone();
            if (!isdefined(str_zone) || !isinarray(var_21fd4693, str_zone)) {
                self notify(#"hash_b5d3534da3f4508");
            }
            wait 1;
        }
    }
    self zm_utility::giveachievement_wrapper("zm_escape_west_side");
}

// Namespace zm_escape_achievement/zm_escape_achievement
// Params 0, eflags: 0x4
// Checksum 0xb116905a, Offset: 0x978
// Size: 0xaa
function private function_564b4b83() {
    self endon(#"disconnect", #"hash_1410cda9f15ef1c3");
    while (true) {
        s_result = self waittill(#"hash_3669499a148a6d6e");
        if (s_result.weapon == getweapon(#"tomahawk_t8_upgraded")) {
            self zm_utility::giveachievement_wrapper("zm_escape_senseless");
            self notify(#"hash_1410cda9f15ef1c3");
        }
    }
}

// Namespace zm_escape_achievement/zm_escape_achievement
// Params 0, eflags: 0x4
// Checksum 0xe1f6ce4c, Offset: 0xa30
// Size: 0x21c
function private function_cb253b7() {
    self endon(#"disconnect");
    self.var_865f4ba0 = 0;
    self.var_5ae3d169 = 0;
    self.var_6d737de1 = 0;
    while (!self.var_865f4ba0 || !self.var_5ae3d169 || !self.var_6d737de1) {
        s_result = self waittill(#"hash_2e36f5f4d9622bb3");
        if (s_result.weapon == getweapon(#"ww_blundergat_t8") || s_result.weapon == getweapon(#"ww_blundergat_t8_upgraded")) {
            self.var_865f4ba0 = 1;
        }
        if (s_result.weapon == getweapon(#"ww_blundergat_fire_t8") || s_result.weapon == getweapon(#"ww_blundergat_fire_t8_upgraded")) {
            self.var_5ae3d169 = 1;
        }
        if (s_result.weapon == getweapon(#"ww_blundergat_acid_t8") || s_result.weapon == getweapon(#"ww_blundergat_acid_t8_upgraded") || s_result.weapon == getweapon(#"hash_494f5501b3f8e1e9")) {
            self.var_6d737de1 = 1;
        }
    }
    self zm_utility::giveachievement_wrapper("zm_escape_gat");
}

// Namespace zm_escape_achievement/zm_escape_achievement
// Params 0, eflags: 0x4
// Checksum 0x4ca3b043, Offset: 0xc58
// Size: 0x1ac
function private function_7c587831() {
    level endon(#"soul_catchers_charged");
    self endon(#"disconnect");
    if (level flag::get(#"soul_catchers_charged")) {
        return;
    }
    self.var_42fadf7d = 0;
    self.var_e5137097 = 0;
    self.var_2264a1f9 = 0;
    while (!self.var_42fadf7d || !self.var_e5137097 || !self.var_2264a1f9) {
        s_result = self waittill(#"hash_2706d6137c04adf4");
        str_zone = self zm_zonemgr::get_player_zone();
        if (!isdefined(str_zone)) {
            continue;
        }
        switch (str_zone) {
        case #"zone_model_industries_upper":
            self.var_2264a1f9 = 1;
            break;
        case #"zone_gondola_ride":
            self.var_42fadf7d = 1;
            break;
        case #"zone_citadel":
        case #"zone_citadel_shower":
        case #"zone_citadel_warden":
            self.var_e5137097 = 1;
            break;
        }
    }
    self zm_utility::giveachievement_wrapper("zm_escape_throw_dog");
}

