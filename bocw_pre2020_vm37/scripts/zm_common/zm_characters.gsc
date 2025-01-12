#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_utility;

#namespace zm_characters;

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x6
// Checksum 0x72b31240, Offset: 0xa30
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_characters", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x5 linked
// Checksum 0x63ec9c48, Offset: 0xa78
// Size: 0x7c
function private function_70a657d8() {
    if (!isdefined(level.var_e52a681)) {
        level.var_e52a681 = 0;
    }
    level.var_e824f826 = 1;
    level.precachecustomcharacters = &precachecustomcharacters;
    initcharacterstartindex();
    /#
        zm_devgui::add_custom_devgui_callback(&function_9436b105);
    #/
}

/#

    // Namespace zm_characters/zm_characters
    // Params 1, eflags: 0x4
    // Checksum 0xd16a6407, Offset: 0xb00
    // Size: 0x94
    function private zombie_force_char(n_char) {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        set_character(n_char);
    }

    // Namespace zm_characters/zm_characters
    // Params 1, eflags: 0x4
    // Checksum 0x98cf56b6, Offset: 0xba0
    // Size: 0x104
    function private function_9436b105(cmd) {
        if (issubstr(cmd, "<dev string:x38>")) {
            tokens = strtok(cmd, "<dev string:x48>");
            player = int(getsubstr(tokens[0], "<dev string:x4d>".size));
            character = int(tokens[tokens.size - 1]);
            players = getplayers();
            players[player - 1] thread zombie_force_char(character);
        }
    }

#/

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0xcb0
// Size: 0x4
function precachecustomcharacters() {
    
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x1 linked
// Checksum 0xc5b44f3c, Offset: 0xcc0
// Size: 0x24
function initcharacterstartindex() {
    level.characterstartindex = randomint(4);
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x0
// Checksum 0xcc7f0638, Offset: 0xcf0
// Size: 0x46
function selectcharacterindextouse() {
    if (level.characterstartindex >= 4) {
        level.characterstartindex = 0;
    }
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x1 linked
// Checksum 0xf94ca65b, Offset: 0xd40
// Size: 0x212
function function_b04c6f1f() {
    playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());
    var_36918d27 = [];
    var_e7d30c12 = undefined;
    for (i = 0; i < playerroletemplatecount; i++) {
        /#
            if (isbot(self)) {
                if (function_f4bf7e3f(i, currentsessionmode())) {
                    if (!isdefined(var_36918d27)) {
                        var_36918d27 = [];
                    } else if (!isarray(var_36918d27)) {
                        var_36918d27 = array(var_36918d27);
                    }
                    var_36918d27[var_36918d27.size] = i;
                }
                continue;
            }
        #/
        rf = getplayerrolefields(i, currentsessionmode());
        if (isdefined(rf) && is_true(rf.isdefaultcharacter)) {
            if (!isdefined(var_36918d27)) {
                var_36918d27 = [];
            } else if (!isarray(var_36918d27)) {
                var_36918d27 = array(var_36918d27);
            }
            var_36918d27[var_36918d27.size] = i;
        }
        if (isdefined(rf)) {
            if (!isdefined(var_e7d30c12)) {
                var_e7d30c12 = i;
            }
        }
    }
    var_72964a59 = isdefined(array::random(var_36918d27)) ? array::random(var_36918d27) : 0;
    if (var_72964a59 == 0) {
        return var_e7d30c12;
    }
    return var_72964a59;
}

// Namespace zm_characters/zm_characters
// Params 1, eflags: 0x1 linked
// Checksum 0x18ee662e, Offset: 0xf60
// Size: 0x2bc
function set_character(character) {
    self detachall();
    if (isdefined(character)) {
        if (isarray(character)) {
            self.characterindex = function_9004475c(character);
        } else {
            self.characterindex = character;
        }
    }
    if (!isdefined(self.characterindex) || !player_role::is_valid(self.characterindex)) {
        self.characterindex = self function_b3a116a1();
        /#
            if (self ishost() && getdvarstring(#"force_char") != "<dev string:x57>") {
                self.characterindex = getdvarint(#"force_char", 0);
            }
        #/
        if (self.characterindex == 0) {
            self.characterindex = function_b04c6f1f();
        }
        self.pers[#"characterindex"] = self.characterindex;
    }
    player_role::set(self.characterindex);
    self.favorite_wall_weapons_list = [];
    self.talks_in_danger = 0;
    self setcharacterbodytype(self.characterindex);
    self setcharacteroutfit(0);
    function_50b1ae32();
    if (!isdefined(level.var_6f14e9e1)) {
        level.var_6f14e9e1 = [];
    } else if (!isarray(level.var_6f14e9e1)) {
        level.var_6f14e9e1 = array(level.var_6f14e9e1);
    }
    if (!isinarray(level.var_6f14e9e1, self)) {
        level.var_6f14e9e1[level.var_6f14e9e1.size] = self;
    }
    characterindex = function_dc232a80();
    if (isdefined(characterindex)) {
        zm_audio::setexertvoice(characterindex);
    }
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x0
// Checksum 0x3d9693c3, Offset: 0x1228
// Size: 0x8ec
function setup_personality_character_exerts() {
    level.exert_sounds[1][#"burp"][0] = "vox_plr_0_exert_burp_0";
    level.exert_sounds[1][#"burp"][1] = "vox_plr_0_exert_burp_1";
    level.exert_sounds[1][#"burp"][2] = "vox_plr_0_exert_burp_2";
    level.exert_sounds[1][#"burp"][3] = "vox_plr_0_exert_burp_3";
    level.exert_sounds[1][#"burp"][4] = "vox_plr_0_exert_burp_4";
    level.exert_sounds[1][#"burp"][5] = "vox_plr_0_exert_burp_5";
    level.exert_sounds[1][#"burp"][6] = "vox_plr_0_exert_burp_6";
    level.exert_sounds[2][#"burp"][0] = "vox_plr_1_exert_burp_0";
    level.exert_sounds[2][#"burp"][1] = "vox_plr_1_exert_burp_1";
    level.exert_sounds[2][#"burp"][2] = "vox_plr_1_exert_burp_2";
    level.exert_sounds[2][#"burp"][3] = "vox_plr_1_exert_burp_3";
    level.exert_sounds[3][#"burp"][0] = "vox_plr_2_exert_burp_0";
    level.exert_sounds[3][#"burp"][1] = "vox_plr_2_exert_burp_1";
    level.exert_sounds[3][#"burp"][2] = "vox_plr_2_exert_burp_2";
    level.exert_sounds[3][#"burp"][3] = "vox_plr_2_exert_burp_3";
    level.exert_sounds[3][#"burp"][4] = "vox_plr_2_exert_burp_4";
    level.exert_sounds[3][#"burp"][5] = "vox_plr_2_exert_burp_5";
    level.exert_sounds[3][#"burp"][6] = "vox_plr_2_exert_burp_6";
    level.exert_sounds[4][#"burp"][0] = "vox_plr_3_exert_burp_0";
    level.exert_sounds[4][#"burp"][1] = "vox_plr_3_exert_burp_1";
    level.exert_sounds[4][#"burp"][2] = "vox_plr_3_exert_burp_2";
    level.exert_sounds[4][#"burp"][3] = "vox_plr_3_exert_burp_3";
    level.exert_sounds[4][#"burp"][4] = "vox_plr_3_exert_burp_4";
    level.exert_sounds[4][#"burp"][5] = "vox_plr_3_exert_burp_5";
    level.exert_sounds[4][#"burp"][6] = "vox_plr_3_exert_burp_6";
    level.exert_sounds[1][#"hitmed"][0] = "vox_plr_0_exert_pain_medium_0";
    level.exert_sounds[1][#"hitmed"][1] = "vox_plr_0_exert_pain_medium_1";
    level.exert_sounds[1][#"hitmed"][2] = "vox_plr_0_exert_pain_medium_2";
    level.exert_sounds[1][#"hitmed"][3] = "vox_plr_0_exert_pain_medium_3";
    level.exert_sounds[2][#"hitmed"][0] = "vox_plr_1_exert_pain_medium_0";
    level.exert_sounds[2][#"hitmed"][1] = "vox_plr_1_exert_pain_medium_1";
    level.exert_sounds[2][#"hitmed"][2] = "vox_plr_1_exert_pain_medium_2";
    level.exert_sounds[2][#"hitmed"][3] = "vox_plr_1_exert_pain_medium_3";
    level.exert_sounds[3][#"hitmed"][0] = "vox_plr_2_exert_pain_medium_0";
    level.exert_sounds[3][#"hitmed"][1] = "vox_plr_2_exert_pain_medium_1";
    level.exert_sounds[3][#"hitmed"][2] = "vox_plr_2_exert_pain_medium_2";
    level.exert_sounds[3][#"hitmed"][3] = "vox_plr_2_exert_pain_medium_3";
    level.exert_sounds[4][#"hitmed"][0] = "vox_plr_3_exert_pain_medium_0";
    level.exert_sounds[4][#"hitmed"][1] = "vox_plr_3_exert_pain_medium_1";
    level.exert_sounds[4][#"hitmed"][2] = "vox_plr_3_exert_pain_medium_2";
    level.exert_sounds[4][#"hitmed"][3] = "vox_plr_3_exert_pain_medium_3";
    level.exert_sounds[1][#"hitlrg"][0] = "vox_plr_0_exert_pain_high_0";
    level.exert_sounds[1][#"hitlrg"][1] = "vox_plr_0_exert_pain_high_1";
    level.exert_sounds[1][#"hitlrg"][2] = "vox_plr_0_exert_pain_high_2";
    level.exert_sounds[1][#"hitlrg"][3] = "vox_plr_0_exert_pain_high_3";
    level.exert_sounds[2][#"hitlrg"][0] = "vox_plr_1_exert_pain_high_0";
    level.exert_sounds[2][#"hitlrg"][1] = "vox_plr_1_exert_pain_high_1";
    level.exert_sounds[2][#"hitlrg"][2] = "vox_plr_1_exert_pain_high_2";
    level.exert_sounds[2][#"hitlrg"][3] = "vox_plr_1_exert_pain_high_3";
    level.exert_sounds[3][#"hitlrg"][0] = "vox_plr_2_exert_pain_high_0";
    level.exert_sounds[3][#"hitlrg"][1] = "vox_plr_2_exert_pain_high_1";
    level.exert_sounds[3][#"hitlrg"][2] = "vox_plr_2_exert_pain_high_2";
    level.exert_sounds[3][#"hitlrg"][3] = "vox_plr_2_exert_pain_high_3";
    level.exert_sounds[4][#"hitlrg"][0] = "vox_plr_3_exert_pain_high_0";
    level.exert_sounds[4][#"hitlrg"][1] = "vox_plr_3_exert_pain_high_1";
    level.exert_sounds[4][#"hitlrg"][2] = "vox_plr_3_exert_pain_high_2";
    level.exert_sounds[4][#"hitlrg"][3] = "vox_plr_3_exert_pain_high_3";
}

// Namespace zm_characters/zm_characters
// Params 1, eflags: 0x1 linked
// Checksum 0xfa32bbff, Offset: 0x1b20
// Size: 0xce
function function_9004475c(character) {
    var_ba015ed = getplayerroletemplatecount(currentsessionmode());
    for (i = 0; i < var_ba015ed; i++) {
        name = function_ac0419ac(i, currentsessionmode());
        if (isinarray(character, name)) {
            return i;
        }
    }
    assertmsg("<dev string:x5b>");
    return 0;
}

// Namespace zm_characters/zm_characters
// Params 2, eflags: 0x0
// Checksum 0xd40e1f24, Offset: 0x1bf8
// Size: 0x12a
function function_d35e4c92(characterindex, var_fdf0f13d = 0) {
    if (isdefined(characterindex)) {
        if (var_fdf0f13d || player_role::is_valid(characterindex)) {
            fields = getplayerrolefields(characterindex, currentsessionmode());
            if (isdefined(fields)) {
                return fields.var_2a42c5e0;
            }
        }
    } else if (isdefined(self) && isplayer(self)) {
        characterindex = player_role::get();
        if (player_role::is_valid(characterindex)) {
            fields = getplayerrolefields(player_role::get(), currentsessionmode());
            if (isdefined(fields)) {
                return fields.var_2a42c5e0;
            }
        }
    }
    return 0;
}

// Namespace zm_characters/zm_characters
// Params 1, eflags: 0x1 linked
// Checksum 0xea0d5b84, Offset: 0x1d30
// Size: 0x126
function function_dc232a80(character) {
    if (isdefined(self) && isplayer(self)) {
        characterindex = player_role::get();
    } else if (isarray(character)) {
        characterindex = function_9004475c(character);
    }
    if (isdefined(characterindex)) {
        if (player_role::is_valid(characterindex)) {
            fields = getplayerrolefields(player_role::get(), currentsessionmode());
            if (isdefined(fields.var_3e570307)) {
                return fields.var_3e570307;
            } else {
                return 0;
            }
        }
        assertmsg("<dev string:x7f>" + characterindex);
    }
    return 0;
}

// Namespace zm_characters/zm_characters
// Params 1, eflags: 0x1 linked
// Checksum 0x182d4341, Offset: 0x1e60
// Size: 0xe6
function is_character(character) {
    assert(isplayer(self));
    if (isdefined(self) && isplayer(self)) {
        characterindex = player_role::get();
        if (player_role::is_valid(characterindex)) {
            name = function_b14806c6(player_role::get(), currentsessionmode());
            return isinarray(character, name);
        }
    }
    return 0;
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x1 linked
// Checksum 0x838c5b9a, Offset: 0x1f50
// Size: 0x78e
function function_50b1ae32() {
    if (is_character(array(#"hash_68255d9ce2a09382", #"hash_1a427f842f175b3c"))) {
        self.revivevox = "scar";
        self.var_ff5f8752 = "self";
        self.var_c107ed3 = "support_scar";
        self.var_d10fb794 = "surrounded_scar";
        self.var_eee02beb = "streak_scar";
        return;
    }
    if (is_character(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6"))) {
        self.talks_in_danger = 1;
        level.rich_sq_player = self;
        self.revivevox = "brun";
        self.var_ff5f8752 = "self";
        self.var_c107ed3 = "support_brun";
        self.var_d10fb794 = "surrounded_brun";
        self.var_eee02beb = "streak_brun";
        return;
    }
    if (is_character(array(#"hash_f531a8c2df891cc", #"hash_26072a3b34719d22"))) {
        self.revivevox = "dieg";
        self.var_ff5f8752 = "self";
        self.var_c107ed3 = "support_dieg";
        self.var_d10fb794 = "surrounded_dieg";
        self.var_eee02beb = "streak_dieg";
        return;
    }
    if (is_character(array(#"hash_3e63362aea484e09", #"hash_5a906d7137467771"))) {
        self.revivevox = "shaw";
        self.var_ff5f8752 = "self";
        self.var_c107ed3 = "support_shaw";
        self.var_d10fb794 = "surrounded_shaw";
        self.var_eee02beb = "streak_shaw";
        return;
    }
    if (is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_73d71ff1e886bbe9"))) {
        self.revivevox = "rich";
        self.var_ff5f8752 = "self";
        self.var_c107ed3 = "support_rich";
        self.var_d10fb794 = "surrounded_rich";
        self.var_eee02beb = "streak_rich";
        return;
    }
    if (is_character(array(#"hash_1aa57ef704f24fa5", #"hash_36bc80636f0fdac4", #"hash_4cb4663e341a940"))) {
        self.talks_in_danger = 1;
        level.rich_sq_player = self;
        self.revivevox = "demp";
        self.var_ff5f8752 = "self";
        self.var_c107ed3 = "support_demp";
        self.var_d10fb794 = "surrounded_demp";
        self.var_eee02beb = "streak_demp";
        return;
    }
    if (is_character(array(#"hash_22e6f7e13c3a99ef", #"hash_46b92e1337b43236", #"hash_78aa6812c38263ba"))) {
        self.revivevox = "niko";
        self.var_ff5f8752 = "self";
        self.var_c107ed3 = "support_niko";
        self.var_d10fb794 = "surrounded_niko";
        self.var_eee02beb = "streak_niko";
        return;
    }
    if (is_character(array(#"hash_305f156156d37e34", #"hash_6df0037e3f390b15", #"hash_1fd4157dcafc6e45"))) {
        self.revivevox = "take";
        self.var_ff5f8752 = "self";
        self.var_c107ed3 = "support_take";
        self.var_d10fb794 = "surrounded_take";
        self.var_eee02beb = "streak_take";
        return;
    }
    if (is_character(array(#"hash_3c0932fa55ee6e5b"))) {
        self.revivevox = "brig";
        self.var_ff5f8752 = "self";
        self.var_c107ed3 = "support_brig";
        self.var_d10fb794 = "surrounded_brig";
        self.var_eee02beb = "streak_brig";
        return;
    }
    if (is_character(array(#"hash_5ebf024e1559c04a"))) {
        self.revivevox = "butl";
        self.var_ff5f8752 = "self";
        self.var_c107ed3 = "support_butl";
        self.var_d10fb794 = "surrounded_butl";
        self.var_eee02beb = "streak_butl";
        return;
    }
    if (is_character(array(#"hash_4e8f51ec275a4a38"))) {
        self.revivevox = "guns";
        self.var_ff5f8752 = "self";
        self.var_c107ed3 = "support_guns";
        self.var_d10fb794 = "surrounded_guns";
        self.var_eee02beb = "streak_guns";
        return;
    }
    if (is_character(array(#"hash_515977e191d13967"))) {
        self.revivevox = "psyc";
        self.var_ff5f8752 = "self";
        self.var_c107ed3 = "support_psyc";
        self.var_d10fb794 = "surrounded_psyc";
        self.var_eee02beb = "streak_psyc";
    }
}

