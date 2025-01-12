#using script_3c51754cf708b246;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_utility;

#namespace zm_characters;

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x2
// Checksum 0xa080f328, Offset: 0x860
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_characters", &__init__, undefined, undefined);
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x0
// Checksum 0xd1b6c7fe, Offset: 0x8a8
// Size: 0x6c
function __init__() {
    if (!isdefined(level.var_9976429a)) {
        level.var_9976429a = 0;
    }
    level.precachecustomcharacters = &precachecustomcharacters;
    level.givecustomcharacters = &givecustomcharacters;
    initcharacterstartindex();
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x920
// Size: 0x4
function precachecustomcharacters() {
    
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x0
// Checksum 0xbc262009, Offset: 0x930
// Size: 0x26
function initcharacterstartindex() {
    level.characterstartindex = randomint(4);
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x0
// Checksum 0x4b604780, Offset: 0x960
// Size: 0x4a
function selectcharacterindextouse() {
    if (level.characterstartindex >= 4) {
        level.characterstartindex = 0;
    }
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x0
// Checksum 0xec5763f3, Offset: 0x9b8
// Size: 0x10e
function assign_lowest_unused_character_index() {
    charindexarray = function_e4f999b1();
    players = getplayers();
    if (players.size == 1) {
        return charindexarray[0];
    } else {
        foreach (player in players) {
            if (isdefined(player.characterindex)) {
                arrayremovevalue(charindexarray, player.characterindex, 0);
            }
        }
        if (charindexarray.size > 0) {
            return charindexarray[0];
        }
    }
    return charindexarray[0];
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x0
// Checksum 0x50769043, Offset: 0xad0
// Size: 0x1dc
function givecustomcharacters() {
    if (isdefined(level.var_dbfdd66c) && [[ level.var_dbfdd66c ]]("c_zom_farmgirl_viewhands")) {
        return;
    }
    self detachall();
    select_character = 0;
    function_e4f999b1();
    if (!isdefined(self.characterindex) || !isinarray(level.charindexarray, self.characterindex)) {
        self.characterindex = self function_f5860bc();
        if (!player_role::is_valid(self.characterindex)) {
            self.characterindex = assign_lowest_unused_character_index();
        }
        /#
            if (getdvarstring(#"force_char") != "<dev string:x30>") {
                self.characterindex = getdvarint(#"force_char", 0);
            }
        #/
        self draft::select_character(self.characterindex, 1);
    }
    self.favorite_wall_weapons_list = [];
    self.talks_in_danger = 0;
    self setcharacterbodytype(self.characterindex);
    self setcharacteroutfit(0);
    self function_e0bdda4();
    self thread set_exert_id();
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x0
// Checksum 0x25039ec6, Offset: 0xcb8
// Size: 0x5c
function set_exert_id() {
    self endon(#"disconnect");
    util::wait_network_frame();
    util::wait_network_frame();
    self zm_audio::setexertvoice(self.characterindex);
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x0
// Checksum 0xf711e7b8, Offset: 0xd20
// Size: 0xab2
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
// Params 0, eflags: 0x0
// Checksum 0x1d73da29, Offset: 0x17e0
// Size: 0x22a
function function_e4f999b1() {
    if (!isdefined(level.charindexarray)) {
        level.charindexarray = [];
        fields = zm_maptable::function_b710859c();
        /#
            if (!isdefined(fields) || !isdefined(fields.zmcharacters)) {
                level.charindexarray[0] = 1;
                level.charindexarray[1] = 2;
                level.charindexarray[2] = 3;
                level.charindexarray[3] = 4;
                level.charindexarray = array::randomize(level.charindexarray);
                return arraycopy(level.charindexarray);
            }
        #/
        assert(isdefined(fields));
        assert(isdefined(fields.zmcharacters));
        level.charindexarray[0] = fields.zmcharacters[0].characterindex;
        level.charindexarray[1] = fields.zmcharacters[1].characterindex;
        level.charindexarray[2] = fields.zmcharacters[2].characterindex;
        level.charindexarray[3] = fields.zmcharacters[3].characterindex;
        level.charindexarray = array::randomize(level.charindexarray);
    }
    return arraycopy(level.charindexarray);
}

// Namespace zm_characters/zm_characters
// Params 1, eflags: 0x0
// Checksum 0x4a0a49f7, Offset: 0x1a18
// Size: 0xd6
function get_character_index(character) {
    fields = zm_maptable::function_b710859c();
    foreach (var_6cabb36b in fields.zmcharacters) {
        if (isinarray(character, var_6cabb36b.name)) {
            return var_6cabb36b.characterindex;
        }
    }
    assertmsg("<dev string:x31>");
    return 0;
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x0
// Checksum 0xa6ef11fe, Offset: 0x1af8
// Size: 0xae
function function_82f5ce1a() {
    characterindex = player_role::get();
    if (player_role::is_valid(characterindex)) {
        fields = getplayerrolefields(player_role::get(), currentsessionmode());
        return fields.var_e90d2b03;
    }
    assertmsg("<dev string:x52>" + characterindex);
    return 0;
}

// Namespace zm_characters/zm_characters
// Params 1, eflags: 0x0
// Checksum 0x105715f6, Offset: 0x1bb0
// Size: 0xbe
function is_character(character) {
    assert(isplayer(self));
    characterindex = player_role::get();
    if (player_role::is_valid(characterindex)) {
        name = function_b9650e7f(player_role::get(), currentsessionmode());
        return isinarray(character, name);
    }
    return 0;
}

// Namespace zm_characters/zm_characters
// Params 0, eflags: 0x0
// Checksum 0xad9269b9, Offset: 0x1c78
// Size: 0x60e
function function_e0bdda4() {
    if (is_character(array(#"hash_68255d9ce2a09382", #"hash_1a427f842f175b3c"))) {
        self.revivevox = "scar";
        self.var_89929aa3 = "self";
        self.var_8e64fac1 = "support_scar";
        self.var_5ff87dbe = "surrounded_scar";
        self.var_1bf1952e = "streak_scar";
        return;
    }
    if (is_character(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6"))) {
        self.talks_in_danger = 1;
        level.rich_sq_player = self;
        self.revivevox = "brun";
        self.var_89929aa3 = "self";
        self.var_8e64fac1 = "support_brun";
        self.var_5ff87dbe = "surrounded_brun";
        self.var_1bf1952e = "streak_brun";
        return;
    }
    if (is_character(array(#"hash_f531a8c2df891cc", #"hash_26072a3b34719d22"))) {
        self.revivevox = "dieg";
        self.var_89929aa3 = "self";
        self.var_8e64fac1 = "support_dieg";
        self.var_5ff87dbe = "surrounded_dieg";
        self.var_1bf1952e = "streak_dieg";
        return;
    }
    if (is_character(array(#"hash_3e63362aea484e09", #"hash_5a906d7137467771"))) {
        self.revivevox = "shaw";
        self.var_89929aa3 = "self";
        self.var_8e64fac1 = "support_shaw";
        self.var_5ff87dbe = "surrounded_shaw";
        self.var_1bf1952e = "streak_shaw";
        return;
    }
    if (is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"))) {
        self.revivevox = "rich";
        self.var_89929aa3 = "self";
        self.var_8e64fac1 = "support_rich";
        self.var_5ff87dbe = "surrounded_rich";
        self.var_1bf1952e = "streak_rich";
        return;
    }
    if (is_character(array(#"hash_1aa57ef704f24fa5", #"hash_36bc80636f0fdac4"))) {
        self.talks_in_danger = 1;
        level.rich_sq_player = self;
        self.revivevox = "demp";
        self.var_89929aa3 = "self";
        self.var_8e64fac1 = "support_demp";
        self.var_5ff87dbe = "surrounded_demp";
        self.var_1bf1952e = "streak_demp";
        return;
    }
    if (is_character(array(#"hash_22e6f7e13c3a99ef", #"hash_46b92e1337b43236"))) {
        self.revivevox = "niko";
        self.var_89929aa3 = "self";
        self.var_8e64fac1 = "support_niko";
        self.var_5ff87dbe = "surrounded_niko";
        self.var_1bf1952e = "streak_niko";
        return;
    }
    if (is_character(array(#"hash_305f156156d37e34", #"hash_6df0037e3f390b15"))) {
        self.revivevox = "take";
        self.var_89929aa3 = "self";
        self.var_8e64fac1 = "support_take";
        self.var_5ff87dbe = "surrounded_take";
        self.var_1bf1952e = "streak_take";
        return;
    }
    if (is_character(array(#"hash_3c0932fa55ee6e5b"))) {
        return;
    }
    if (is_character(array(#"hash_5ebf024e1559c04a"))) {
        return;
    }
    if (is_character(array(#"hash_4e8f51ec275a4a38"))) {
        return;
    }
    if (is_character(array(#"hash_515977e191d13967"))) {
    }
}

