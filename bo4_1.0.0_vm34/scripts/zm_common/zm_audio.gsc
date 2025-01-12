#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_audio;

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x2
// Checksum 0xe68f6945, Offset: 0xe78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_audio", &__init__, undefined, undefined);
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x3c5566e2, Offset: 0xec0
// Size: 0x144
function __init__() {
    clientfield::register("allplayers", "charindex", 1, 3, "int");
    clientfield::register("toplayer", "isspeaking", 1, 1, "int");
    println("<dev string:x30>");
    level zmbvox();
    callback::on_connect(&init_audio_functions);
    callback::on_ai_spawned(&function_707e74be);
    callback::on_ai_killed(&ai_killed);
    level thread sndannouncer_init();
    level thread function_a6c6d277();
    level thread function_6ce10352();
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x5afd9884, Offset: 0x1010
// Size: 0x24
function ai_killed(s_params) {
    self thread player_zombie_kill_vox(s_params);
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0xb55c54be, Offset: 0x1040
// Size: 0xbc
function function_707e74be() {
    if (isdefined(self.archetype)) {
        switch (self.archetype) {
        case #"brutus":
            n_delay = 5;
            break;
        }
    }
    if (function_6837951d(self.var_ea94c12a)) {
        function_2b96f4d0(self.var_ea94c12a, n_delay);
    }
    if (function_6837951d(self.archetype)) {
        function_2b96f4d0(self.archetype, n_delay);
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x86e3d7ad, Offset: 0x1108
// Size: 0x3c
function setexertvoice(exert_id) {
    self.player_exert_id = exert_id;
    self clientfield::set("charindex", self.player_exert_id);
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x54af4235, Offset: 0x1150
// Size: 0x1f4
function playerexert(exert, notifywait = 0) {
    if (isdefined(self.isspeaking) && self.isspeaking || isdefined(self.isexerting) && self.isexerting) {
        return;
    }
    if (isdefined(self.beastmode) && self.beastmode) {
        return;
    }
    id = level.exert_sounds[0][exert];
    if (isdefined(self.player_exert_id)) {
        if (!isdefined(level.exert_sounds) || !isdefined(level.exert_sounds[self.player_exert_id]) || !isdefined(level.exert_sounds[self.player_exert_id][exert])) {
            return;
        }
        if (isarray(level.exert_sounds[self.player_exert_id][exert])) {
            id = array::random(level.exert_sounds[self.player_exert_id][exert]);
        } else {
            id = level.exert_sounds[self.player_exert_id][exert];
        }
    }
    if (isdefined(id)) {
        self.isexerting = 1;
        if (notifywait) {
            self playsoundwithnotify(id, "done_exerting");
            self waittill(#"done_exerting");
            self.isexerting = 0;
            return;
        }
        self thread exert_timer();
        self playsound(id);
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x71cb1158, Offset: 0x1350
// Size: 0x3e
function exert_timer() {
    self endon(#"disconnect");
    wait randomfloatrange(1.5, 3);
    self.isexerting = 0;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x374e8b49, Offset: 0x1398
// Size: 0x164
function zmbvox() {
    level.votimer = [];
    level.vox = zmbvoxcreate();
    if (isdefined(level._zmbvoxlevelspecific)) {
        level thread [[ level._zmbvoxlevelspecific ]]();
    }
    if (isdefined(level._zmbvoxgametypespecific)) {
        level thread [[ level._zmbvoxgametypespecific ]]();
    }
    announcer_ent = spawn("script_origin", (0, 0, 0));
    level.vox zmbvoxinitspeaker("announcer", "vox_zmba_", announcer_ent);
    level.exert_sounds[0][#"burp"] = "evt_belch";
    level.exert_sounds[0][#"hitmed"] = "null";
    level.exert_sounds[0][#"hitlrg"] = "null";
    if (isdefined(level.setupcustomcharacterexerts)) {
        [[ level.setupcustomcharacterexerts ]]();
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x2cf801ab, Offset: 0x1508
// Size: 0xac
function init_audio_functions() {
    self.isspeaking = 0;
    waitframe(1);
    function_7fc61e0e();
    self thread zombie_behind_vox();
    self thread player_killstreak_timer();
    self thread water_vox();
    if (isdefined(level._custom_zombie_oh_shit_vox_func)) {
        self thread [[ level._custom_zombie_oh_shit_vox_func ]]();
        return;
    }
    self thread oh_shit_vox();
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0xdfdeaa1a, Offset: 0x15c0
// Size: 0x2a6
function oh_shit_vox() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        wait 1;
        players = getplayers();
        zombs = zombie_utility::get_round_enemy_array();
        if (players.size >= 1) {
            var_6c755991 = 0;
            for (i = 0; i < zombs.size; i++) {
                if (isdefined(zombs[i].favoriteenemy) && zombs[i].favoriteenemy == self || !isdefined(zombs[i].favoriteenemy)) {
                    if (distancesquared(zombs[i].origin, self.origin) < 62500) {
                        var_6c755991++;
                    }
                }
            }
            if (var_6c755991 > 9) {
                if (math::cointoss() && level.players.size > 1) {
                    foreach (e_player in level.players) {
                        if (self != e_player && sighttracepassed(self.origin + (0, 0, 30), e_player.origin + (0, 0, 30), 0, undefined)) {
                            e_player create_and_play_dialog("surrounded", "see_" + self zm_vo::function_d70b100f());
                        }
                    }
                } else {
                    self create_and_play_dialog("surrounded", "self");
                }
                wait 4;
            }
        }
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x99cb8b0c, Offset: 0x1870
// Size: 0x9e
function function_a6c6d277() {
    level endon(#"game_over");
    while (true) {
        waitresult = level waittill(#"crawler_created");
        if (isplayer(waitresult.player)) {
            waitresult.player create_and_play_dialog("general", "crawl_spawn");
            wait 1;
        }
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x3e00e365, Offset: 0x1918
// Size: 0xee
function function_6ce10352() {
    level endon(#"game_over");
    while (true) {
        waitresult = level waittill(#"gib");
        if (isplayer(waitresult.attacker) && (waitresult.area === "left_arm" || waitresult.area === "right_arm") && isalive(waitresult.entity)) {
            waitresult.attacker create_and_play_dialog("general", "gib");
            wait 35;
        }
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x2199c38b, Offset: 0x1a10
// Size: 0x228
function player_killstreak_timer() {
    self endon(#"disconnect");
    self endon(#"death");
    if (getdvarstring(#"zombie_kills") == "") {
        setdvar(#"zombie_kills", 10);
    }
    if (getdvarstring(#"zombie_kill_timer") == "") {
        setdvar(#"zombie_kill_timer", 6);
    }
    kills = getdvarint(#"zombie_kills", 0);
    time = getdvarint(#"zombie_kill_timer", 0);
    if (!isdefined(self.timerisrunning)) {
        self.timerisrunning = 0;
        self.killcounter = 0;
    }
    while (true) {
        waitresult = self waittill(#"zom_kill");
        zomb = waitresult.zombie;
        if (isdefined(zomb._black_hole_bomb_collapse_death) && zomb._black_hole_bomb_collapse_death == 1) {
            continue;
        }
        if (isdefined(zomb.microwavegun_death) && zomb.microwavegun_death) {
            continue;
        }
        self.killcounter++;
        if (self.timerisrunning != 1) {
            self.timerisrunning = 1;
            self thread timer_actual(kills, time);
        }
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0xa8f1a1f9, Offset: 0x1c40
// Size: 0x1e4
function player_zombie_kill_vox(params) {
    death = undefined;
    player = undefined;
    if (isstring(params) || ishash(params)) {
        death = params;
        player = self;
    } else if (isstruct(params)) {
        player = params.eattacker;
        zombie = self;
        if (!isplayer(player)) {
            return;
        }
        death = function_c546c9f6(zombie);
        if (!isdefined(death)) {
            instakill = player zm_powerups::is_insta_kill_active();
            dist = distancesquared(player.origin, zombie.origin);
            death = get_mod_kill(params.shitloc, params.smeansofdeath, params.weapon, zombie, instakill, dist, player);
        }
    }
    if (isdefined(death)) {
        player endon(#"death");
        b_played = player create_and_play_dialog("kill", death);
        if (isdefined(b_played) && b_played) {
            wait 2;
            player function_19467f8b(death);
        }
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x86967609, Offset: 0x1e30
// Size: 0x164
function function_19467f8b(event) {
    if (level.players.size <= 1) {
        return;
    }
    var_aa814be0 = array();
    foreach (e_player in level.players) {
        if (e_player != self && zm_vo::function_13f3ccb9(e_player, self)) {
            array::add(var_aa814be0, e_player);
        }
    }
    if (!var_aa814be0.size) {
        return;
    }
    e_speaker = array::random(var_aa814be0);
    str_alias = self zm_vo::function_d70b100f();
    e_speaker create_and_play_dialog("kill", event + "_" + str_alias);
}

// Namespace zm_audio/zm_audio
// Params 7, eflags: 0x0
// Checksum 0x15fa1b0, Offset: 0x1fa0
// Size: 0x2c2
function get_mod_kill(impact, mod, weapon, zombie, instakill, dist, player) {
    close_dist = 4096;
    med_dist = 15376;
    far_dist = 160000;
    str_weapon = function_d762b915(weapon, zombie, mod, player);
    if (isdefined(str_weapon)) {
        if (str_weapon != "novox") {
            return str_weapon;
        } else {
            return undefined;
        }
    }
    if (isdefined(weapon.isheroweapon) && weapon.isheroweapon) {
        return;
    }
    if (level flag::get("special_round")) {
        return "specialround";
    }
    if (mod != "MOD_BURNED" && dist < close_dist) {
        if (player.health < player.maxhealth && isdefined(player.lastdamagetime) && gettime() - player.lastdamagetime < 1500) {
            return "revenge";
        }
    }
    if (mod != "MOD_MELEE" && zombie.missinglegs) {
        return "crawler";
    }
    if (zm_utility::is_headshot(weapon, impact, mod) && dist >= far_dist) {
        return "headshot";
    }
    if (zm_utility::is_explosive_damage(mod) && weapon.name != "ray_gun" && !(isdefined(zombie.is_on_fire) && zombie.is_on_fire)) {
        if (!instakill) {
            return "explosive";
        } else {
            return "weapon_instakill";
        }
    }
    if (mod != "MOD_BURNED" && dist < close_dist) {
        return "close";
    }
    if (mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET") {
        if (!instakill) {
            return "bullet";
        } else {
            return "weapon_instakill";
        }
    }
    if (instakill) {
        return undefined;
    }
    return undefined;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0xc044a9b1, Offset: 0x2270
// Size: 0x94
function function_c546c9f6(ai) {
    if (isdefined(ai.var_ea94c12a) && function_6837951d("kill", ai.var_ea94c12a)) {
        return ai.var_ea94c12a;
    }
    if (isdefined(ai.archetype) && function_6837951d("kill", ai.archetype)) {
        return ai.archetype;
    }
}

// Namespace zm_audio/zm_audio
// Params 4, eflags: 0x0
// Checksum 0x32062312, Offset: 0x2310
// Size: 0x68c
function function_d762b915(weapon, zombie, mod, player) {
    str_weapon = undefined;
    if (weapon.name == zombie.damageweapon.name) {
        if (isdefined(weapon.isheroweapon) && weapon.isheroweapon) {
            str_weapon_name = function_8ff5b3a1(weapon);
            if (!isdefined(str_weapon_name)) {
                str_weapon = undefined;
                return;
            }
            str_weapon = str_weapon_name;
            switch (str_weapon) {
            case #"minigun":
                if (mod != "MOD_RIFLE_BULLET") {
                    return "novox";
                }
                break;
            case #"scepter":
                if (!(isdefined(zombie.var_316424bf) && zombie.var_316424bf)) {
                    return "novox";
                }
                break;
            case #"flamethrower":
                if (mod !== "MOD_BURNED" || isdefined(zombie.var_f75c9d82) && zombie.var_f75c9d82) {
                    return "novox";
                }
                break;
            case #"gravityspikes":
                if (!(isdefined(zombie.var_3a279bb5) && zombie.var_3a279bb5)) {
                    return "novox";
                }
                break;
            case #"katana":
                if (mod !== "MOD_MELEE" || player flagsys::get("katana_dash")) {
                    return "novox";
                }
                break;
            case #"hammer":
                if (mod !== "MOD_MELEE") {
                    return "novox";
                }
                break;
            }
            if (function_ffaa24d6(str_weapon)) {
                if (isdefined(player)) {
                    if ((isdefined(player.var_60157e6a) ? player.var_60157e6a : 0) >= 6) {
                        player notify(#"hash_11cb2504b1e9fd56");
                        player.var_60157e6a = 0;
                        return str_weapon;
                    } else {
                        player thread function_3a5a0a0c();
                        return "novox";
                    }
                } else {
                    return "novox";
                }
            }
            if (str_weapon == "chakram") {
                if (isdefined(player) && isdefined(player.var_809bd952) && player.var_809bd952) {
                    if ((isdefined(player.var_9b4bc2c8) ? player.var_9b4bc2c8 : 0) >= 3) {
                        player notify(#"hash_1863386982d832b6");
                        str_weapon = "chakram_multi";
                        player.var_9b4bc2c8 = 0;
                    } else {
                        player thread function_d4179ca9();
                        return "novox";
                    }
                } else {
                    return "novox";
                }
            }
            if (str_weapon == "sword_pistol") {
                if (mod == "MOD_MELEE") {
                    str_weapon = "sword";
                } else if (mod == "MOD_UNKNOWN" || mod == "MOD_PROJECTILE" || isdefined(zombie.var_1f0a4486) && zombie.var_1f0a4486) {
                    return "novox";
                } else {
                    str_weapon = "pistol";
                }
            }
        } else {
            switch (weapon.name) {
            case #"ray_gun_upgraded":
            case #"ray_gun":
                str_weapon = "raygun";
                break;
            }
            if (!isdefined(str_weapon)) {
                if (isdefined(level.var_e4e95db)) {
                    str_weapon = level thread [[ level.var_e4e95db ]](weapon.name);
                }
            }
        }
    } else {
        str_weapon = undefined;
        switch (zombie.damageweapon.name) {
        case #"homunculus":
        case #"cymbal_monkey":
            str_weapon = "homunculus";
            break;
        case #"sticky_grenade_extra":
        case #"eq_acid_bomb_extra":
        case #"frag_grenade":
        case #"eq_frag_grenade":
        case #"hash_4162e2a10e8a440d":
        case #"claymore_extra":
        case #"eq_acid_bomb":
        case #"sticky_grenade":
        case #"claymore":
            str_weapon = "explosive";
            break;
        case #"bowie_knife":
        case #"knife":
            str_weapon = "melee";
            break;
        case #"eq_wraith_fire":
        case #"molotov_fire":
        case #"eq_molotov_extra":
        case #"wraith_fire_fire":
        case #"eq_molotov":
        case #"eq_wraith_fire_extra":
            str_weapon = "molotov";
            break;
        case #"mini_turret":
            str_weapon = undefined;
            break;
        }
        if (!isdefined(str_weapon)) {
            if (isdefined(level.var_e4e95db)) {
                str_weapon = level thread [[ level.var_e4e95db ]](zombie.damageweapon.name);
            }
        }
    }
    return str_weapon;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x12942acc, Offset: 0x29a8
// Size: 0x54
function function_8de4aa95(w_weapon) {
    str_weapon_name = function_8ff5b3a1(w_weapon);
    if (isdefined(str_weapon_name)) {
        self thread create_and_play_dialog("hero_activate", str_weapon_name);
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0xcc5ab00d, Offset: 0x2a08
// Size: 0xbc
function function_12c67fee(w_weapon) {
    if (!isdefined(self.var_66b1c282)) {
        self.var_66b1c282 = 0;
    }
    str_weapon_name = function_8ff5b3a1(w_weapon);
    n_variant = self.var_4dcf5f7f;
    if (isdefined(str_weapon_name) && isdefined(n_variant)) {
        if (self.var_66b1c282 === n_variant) {
            self.var_66b1c282++;
            self thread create_and_play_dialog("hero_ready", str_weapon_name, n_variant, 1, #"hero_weapon_activated");
        }
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x5d6a3c09, Offset: 0x2ad0
// Size: 0x62
function function_8ff5b3a1(w_weapon) {
    switch (w_weapon.name) {
    case #"hero_scepter_lv3":
    case #"hero_scepter_lv2":
    case #"hero_scepter_lv1":
        return "scepter";
    case #"hero_hammer_lv3":
    case #"hero_hammer_lv2":
    case #"hero_hammer_lv1":
        return "hammer";
    case #"hero_chakram_lv2":
    case #"hero_chakram_lv3":
    case #"hero_chakram_lv1":
        return "chakram";
    case #"hero_sword_pistol_lv2":
    case #"hero_sword_pistol_lv3":
    case #"hero_sword_pistol_lv1":
        return "sword_pistol";
    case #"hero_flamethrower_t8_lv1":
    case #"hero_flamethrower_t8_lv2":
    case #"hero_flamethrower_t8_lv3":
        return "flamethrower";
    case #"hero_minigun_t8_lv1":
    case #"hero_minigun_t8_lv3":
    case #"hero_minigun_t8_lv2":
        return "minigun";
    case #"hero_katana_t8_lv1":
    case #"hero_katana_t8_lv2":
    case #"hero_katana_t8_lv3":
        return "katana";
    case #"hero_gravityspikes_t8_lv3":
    case #"hero_gravityspikes_t8_lv2":
    case #"hero_gravityspikes_t8_lv1":
        return "gravityspikes";
    default:
        return undefined;
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0xb654339a, Offset: 0x2cd8
// Size: 0xa4
function function_d4179ca9() {
    self notify(#"hash_38a86ad7a6657b2f");
    self endon(#"hash_38a86ad7a6657b2f");
    self endon(#"hash_1863386982d832b6");
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(self.var_9b4bc2c8)) {
        self.var_9b4bc2c8 = 0;
    }
    self.var_9b4bc2c8++;
    wait 0.75;
    self.var_9b4bc2c8 = 0;
    self thread player_zombie_kill_vox("hero_chakram");
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x93ed51ae, Offset: 0x2d88
// Size: 0x8a
function function_3a5a0a0c() {
    self notify(#"sndmultikilltracker");
    self endon(#"sndmultikilltracker");
    self endon(#"hash_11cb2504b1e9fd56");
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(self.var_60157e6a)) {
        self.var_60157e6a = 0;
    }
    self.var_60157e6a++;
    wait 5;
    self.var_60157e6a = 0;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0xcf4574f7, Offset: 0x2e20
// Size: 0x7e
function function_ffaa24d6(str_weapon) {
    var_9d06257f = 0;
    switch (str_weapon) {
    case #"gravityspikes":
    case #"flamethrower":
    case #"katana":
    case #"minigun":
        var_9d06257f = 1;
        break;
    }
    return var_9d06257f;
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0xef5db797, Offset: 0x2ea8
// Size: 0x1ea
function timer_actual(kills, time) {
    self endon(#"disconnect");
    self endon(#"death");
    timer = gettime() + time * 1000;
    while (gettime() < timer) {
        if (self.killcounter > kills) {
            if (math::cointoss() && level.players.size > 1 && isdefined(self.var_1bf1952e)) {
                foreach (e_player in level.players) {
                    if (self != e_player && sighttracepassed(self.origin + (0, 0, 30), e_player.origin + (0, 0, 30), 0, undefined)) {
                        e_player create_and_play_dialog("kill", self.var_1bf1952e);
                    }
                }
            } else {
                self create_and_play_dialog("kill", "streak_self");
            }
            wait 10;
            self.killcounter = 0;
            timer = -1;
        }
        wait 0.1;
    }
    self.killcounter = 0;
    self.timerisrunning = 0;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x5c5ae4c9, Offset: 0x30a0
// Size: 0x2e
function zmbvoxcreate() {
    vox = spawnstruct();
    vox.speaker = [];
    return vox;
}

// Namespace zm_audio/zm_audio
// Params 3, eflags: 0x0
// Checksum 0xa659b9f3, Offset: 0x30d8
// Size: 0xb2
function zmbvoxinitspeaker(speaker, prefix, ent) {
    ent.zmbvoxid = speaker;
    if (!isdefined(self.speaker[speaker])) {
        self.speaker[speaker] = spawnstruct();
        self.speaker[speaker].alias = [];
    }
    self.speaker[speaker].prefix = prefix;
    self.speaker[speaker].ent = ent;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x28af104a, Offset: 0x3198
// Size: 0x5e
function custom_kill_damaged_vo(player) {
    self notify(#"sound_damage_player_updated");
    self endon(#"death");
    self endon(#"sound_damage_player_updated");
    self.sound_damage_player = player;
    wait 2;
    self.sound_damage_player = undefined;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x8e609099, Offset: 0x3200
// Size: 0x19a
function loadplayervoicecategories(table) {
    index = 0;
    for (row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index)) {
        category = checkstringvalid(row[0]);
        subcategory = checkstringvalid(row[1]);
        suffix = checkstringvalid(row[2]);
        percentage = int(row[3]);
        if (percentage <= 0) {
            percentage = 100;
        }
        cooldown = checkintvalid(row[4]);
        var_a317fa58 = row[5];
        var_e0cfc86d = row[6];
        zmbvoxadd(category, subcategory, suffix, percentage, cooldown, var_a317fa58, var_e0cfc86d);
        index++;
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x2601d9a5, Offset: 0x33a8
// Size: 0x24
function checkstringvalid(str) {
    if (str != "") {
        return str;
    }
    return undefined;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0xb27f3124, Offset: 0x33d8
// Size: 0x50
function checkstringtrue(str) {
    if (!isdefined(str)) {
        return false;
    }
    if (str != "") {
        if (tolower(str) == "true") {
            return true;
        }
    }
    return false;
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x2fd5a17, Offset: 0x3430
// Size: 0x5a
function checkintvalid(value, defaultvalue = 0) {
    if (!isdefined(value)) {
        return defaultvalue;
    }
    if (value == "") {
        return defaultvalue;
    }
    return int(value);
}

// Namespace zm_audio/zm_audio
// Params 7, eflags: 0x0
// Checksum 0xaa0b6852, Offset: 0x3498
// Size: 0x224
function zmbvoxadd(category, subcategory, suffix, percentage, cooldown = 0, var_a317fa58, var_e0cfc86d) {
    assert(isdefined(category));
    assert(isdefined(subcategory));
    assert(isdefined(suffix));
    assert(isdefined(percentage));
    assert(isdefined(cooldown));
    assert(isdefined(var_a317fa58));
    assert(isdefined(var_e0cfc86d));
    if (!isdefined(level.votimer)) {
        level.votimer = [];
    }
    if (!isdefined(level.sndplayervox)) {
        level.sndplayervox = [];
    }
    vox = level.sndplayervox;
    if (!isdefined(vox[category])) {
        vox[category] = [];
    }
    vox[category][subcategory] = spawnstruct();
    vox[category][subcategory].suffix = suffix;
    vox[category][subcategory].percentage = percentage;
    vox[category][subcategory].cooldown = cooldown;
    vox[category][subcategory].var_a317fa58 = var_a317fa58;
    vox[category][subcategory].var_e0cfc86d = var_e0cfc86d;
    zm_utility::function_a9e0d67d(subcategory);
}

// Namespace zm_audio/zm_audio
// Params 5, eflags: 0x0
// Checksum 0x2f35470c, Offset: 0x36c8
// Size: 0x1fc
function function_2b96f4d0(category, delay = 2, var_d54e8ed3 = -1, n_range = 800, endons) {
    subcategory = #"react";
    if (!function_69c72bdf(category, subcategory)) {
        return 0;
    }
    self endon(#"death");
    if (!isdefined(endons)) {
        endons = [];
    } else if (!isarray(endons)) {
        endons = array(endons);
    }
    foreach (str_endon in endons) {
        self endon(str_endon);
    }
    if (isstring(delay)) {
        self waittill(delay);
    } else if (delay > 0) {
        wait delay;
    }
    player_vo = function_bf260220(var_d54e8ed3, n_range);
    if (isdefined(player_vo)) {
        return player_vo create_and_play_dialog(category, subcategory, undefined, 1);
    }
    return level function_709246c9(category, subcategory, undefined, 1);
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x4
// Checksum 0xf93146a0, Offset: 0x38d0
// Size: 0x1fa
function private function_bf260220(timeout, n_range) {
    __timeout__ = timeout;
    var_6eb52594 = gettime();
    do {
        var_e9387b07 = arraysort(level.activeplayers, self.origin, 1, level.activeplayers.size, n_range);
        var_e9387b07 = array::randomize(var_e9387b07);
        foreach (player in var_e9387b07) {
            if (!player can_speak()) {
                continue;
            }
            if (isstruct(self)) {
                if (player util::is_looking_at(self, 0.65, 1)) {
                    return player;
                }
                continue;
            }
            if (isentity(self)) {
                if (self sightconetrace(player getplayercamerapos(), player, anglestoforward(player.angles)) > 0.3) {
                    return player;
                }
            }
        }
        waitframe(5);
    } while (!(__timeout__ >= 0 && __timeout__ - float(gettime() - var_6eb52594) / 1000 <= 0));
}

// Namespace zm_audio/zm_audio
// Params 4, eflags: 0x0
// Checksum 0x4d3a2b9d, Offset: 0x3ad8
// Size: 0x8e
function function_709246c9(category, subcategory, force_variant, b_wait_if_busy = 0) {
    e_player = array::random(zm_vo::function_9dfc8f57());
    if (isdefined(e_player)) {
        return e_player create_and_play_dialog(category, subcategory, force_variant, b_wait_if_busy);
    }
    return 0;
}

// Namespace zm_audio/zm_audio
// Params 5, eflags: 0x0
// Checksum 0x71f4a2ae, Offset: 0x3b70
// Size: 0x424
function create_and_play_dialog(category, subcategory, force_variant, b_wait_if_busy = 0, var_338d0f99) {
    if (!isplayer(self)) {
        return;
    }
    self endon(#"death");
    if (zm_trial::is_trial_mode() || zm_utility::is_standard()) {
        return 0;
    }
    s_overrides = function_f1d585a7(category, subcategory);
    if (isdefined(s_overrides)) {
        if (!function_6837951d(s_overrides.str_category, s_overrides.var_41750e29)) {
            /#
                if (getdvarint(#"debug_audio", 0)) {
                    println("<dev string:x65>" + category + "<dev string:x80>" + subcategory + "<dev string:x91>");
                }
            #/
        } else {
            category = s_overrides.str_category;
            subcategory = s_overrides.var_41750e29;
        }
    }
    if (!function_69c72bdf(category, subcategory)) {
        return 0;
    }
    var_3f85b997 = subcategory;
    subcategory = function_e867ca55(category, subcategory);
    if (!function_6837951d(category, subcategory)) {
        /#
            if (getdvarint(#"debug_audio", 0)) {
                println("<dev string:x65>" + category + "<dev string:x80>" + subcategory + "<dev string:xbb>");
            }
        #/
        return 0;
    }
    if (b_wait_if_busy) {
        self notify(#"hash_7efd5bdf8133ff7b");
        self endon(#"hash_7efd5bdf8133ff7b");
        if (isdefined(var_338d0f99)) {
            self endon(var_338d0f99);
        }
        while (self.isspeaking || isdefined(self.zmannouncertalking) && self.zmannouncertalking) {
            waitframe(1);
        }
    } else if (sndvoxoverride() || isdefined(self.isspeaking) && self.isspeaking) {
        return 0;
    }
    if (!function_380f9c94(category, subcategory, force_variant)) {
        return 0;
    }
    vox = level.sndplayervox[category][subcategory];
    prefix = shouldplayerspeak(self, category, subcategory, vox.percentage);
    if (!isdefined(prefix)) {
        return 0;
    }
    sound_to_play = self zmbvoxgetlinevariant(prefix, vox.suffix, force_variant);
    if (isdefined(sound_to_play) && can_speak()) {
        self thread do_player_or_npc_playvox(sound_to_play);
        function_35e2dca0(category, var_3f85b997);
    } else {
        /#
            if (getdvarint(#"debug_audio", 0)) {
                iprintln("<dev string:xd1>");
            }
        #/
        return 0;
    }
    return 1;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x7e7e583f, Offset: 0x3fa0
// Size: 0x166
function sndvoxoverride(b_toggle) {
    if (isdefined(b_toggle)) {
        if (self == level) {
            foreach (player in level.players) {
                player sndvoxoverride(b_toggle);
            }
        } else {
            self.sndvoxoverride = b_toggle ? 1 : undefined;
        }
        return;
    }
    if (self == level) {
        foreach (player in level.players) {
            if (player sndvoxoverride()) {
                return 1;
            }
        }
        return 0;
    }
    return isdefined(self.sndvoxoverride) && self.sndvoxoverride;
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0xe9f4a944, Offset: 0x4110
// Size: 0x164
function function_69c72bdf(category, subcategory) {
    if (!isdefined(level.var_8d363ec)) {
        level.var_8d363ec = [];
    } else if (!isarray(level.var_8d363ec)) {
        level.var_8d363ec = array(level.var_8d363ec);
    }
    if (!isdefined(level.var_8d363ec[category])) {
        level.var_8d363ec[category] = [];
    } else if (!isarray(level.var_8d363ec[category])) {
        level.var_8d363ec[category] = array(level.var_8d363ec[category]);
    }
    if (function_6837951d(category, subcategory) && level.sndplayervox[category][subcategory].var_e0cfc86d) {
        if (level.var_8d363ec[category][subcategory] === level.round_number) {
            return false;
        }
    }
    return true;
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x9940f2e1, Offset: 0x4280
// Size: 0x120
function function_35e2dca0(category, subcategory) {
    if (!isdefined(level.var_8d363ec)) {
        level.var_8d363ec = [];
    } else if (!isarray(level.var_8d363ec)) {
        level.var_8d363ec = array(level.var_8d363ec);
    }
    if (!isdefined(level.var_8d363ec[category])) {
        level.var_8d363ec[category] = [];
    } else if (!isarray(level.var_8d363ec[category])) {
        level.var_8d363ec[category] = array(level.var_8d363ec[category]);
    }
    level.var_8d363ec[category][subcategory] = level.round_number;
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0xff04c1cf, Offset: 0x43a8
// Size: 0x1fc
function function_e867ca55(category, subcategory) {
    if (!isdefined(level.var_f7706f55)) {
        level.var_f7706f55 = [];
    } else if (!isarray(level.var_f7706f55)) {
        level.var_f7706f55 = array(level.var_f7706f55);
    }
    if (!isdefined(level.var_f7706f55[category])) {
        level.var_f7706f55[category] = [];
    } else if (!isarray(level.var_f7706f55[category])) {
        level.var_f7706f55[category] = array(level.var_f7706f55[category]);
    }
    if (!isdefined(level.var_f7706f55[category][subcategory])) {
        level.var_f7706f55[category][subcategory] = 0;
    }
    level.var_f7706f55[category][subcategory]++;
    if (level.var_f7706f55[category][subcategory] == 1) {
        var_d2d7e21c = subcategory + "_first";
        if (function_6837951d(category, var_d2d7e21c)) {
            if (!isdefined(level.var_f7706f55[category][var_d2d7e21c])) {
                level.var_f7706f55[category][var_d2d7e21c] = 0;
            }
            if (level.var_f7706f55[category][var_d2d7e21c] < 1) {
                return var_d2d7e21c;
            }
        }
    }
    return subcategory;
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x83bb650e, Offset: 0x45b0
// Size: 0x14c
function function_ad6ddef3(category, subcategory) {
    if (!isdefined(level.var_f7706f55)) {
        level.var_f7706f55 = [];
    } else if (!isarray(level.var_f7706f55)) {
        level.var_f7706f55 = array(level.var_f7706f55);
    }
    if (!isdefined(level.var_f7706f55[category])) {
        level.var_f7706f55[category] = [];
    } else if (!isarray(level.var_f7706f55[category])) {
        level.var_f7706f55[category] = array(level.var_f7706f55[category]);
    }
    if (!isdefined(level.var_f7706f55[category][subcategory])) {
        level.var_f7706f55[category][subcategory] = 0;
    }
    level.var_f7706f55[category][subcategory]++;
}

// Namespace zm_audio/zm_audio
// Params 4, eflags: 0x0
// Checksum 0x2d30e1df, Offset: 0x4708
// Size: 0xac
function function_6a8ba59b(str_category, var_41750e29, var_23791314, var_f99ffd9a) {
    if (!isdefined(self.var_be661745)) {
        self.var_be661745 = [];
    }
    if (!isdefined(self.var_be661745[str_category])) {
        self.var_be661745[str_category] = [];
    }
    s_override = {#str_category:var_23791314, #var_41750e29:var_f99ffd9a};
    self.var_be661745[str_category][var_41750e29] = s_override;
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x515cad50, Offset: 0x47c0
// Size: 0x9a
function function_bb36029(str_category, var_41750e29) {
    if (isdefined(self.var_be661745)) {
        if (isdefined(self.var_be661745[str_category])) {
            if (isdefined(self.var_be661745[str_category][var_41750e29])) {
                self.var_be661745[str_category][var_41750e29] = undefined;
                if (!self.var_be661745[str_category].size) {
                    self.var_be661745[str_category] = undefined;
                }
                if (!self.var_be661745.size) {
                    self.var_be661745 = undefined;
                }
            }
        }
    }
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x4
// Checksum 0x241eafc5, Offset: 0x4868
// Size: 0xbe
function private function_f1d585a7(str_category, var_41750e29) {
    if (isdefined(self.var_be661745)) {
        if (isdefined(self.var_be661745[str_category])) {
            if (isdefined(self.var_be661745[str_category][var_41750e29])) {
                return self.var_be661745[str_category][var_41750e29];
            }
        }
    } else if (isdefined(level.var_be661745)) {
        if (isdefined(level.var_be661745[str_category])) {
            if (isdefined(level.var_be661745[str_category][var_41750e29])) {
                return level.var_be661745[str_category][var_41750e29];
            }
        }
    }
    return undefined;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0xda2f598c, Offset: 0x4930
// Size: 0x5c
function can_speak() {
    if (isdefined(self.isspeaking) && self.isspeaking) {
        return false;
    }
    if (function_bbc477e0() && !(isdefined(self.var_b814918f) && self.var_b814918f)) {
        return false;
    }
    return true;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0xc9b960d1, Offset: 0x4998
// Size: 0x1d4
function do_player_or_npc_playvox(sound_to_play) {
    self endon(#"death");
    self.str_vo_being_spoken = sound_to_play;
    self.isspeaking = 1;
    if (isplayer(self)) {
        self clientfield::set_to_player("isspeaking", 1);
    }
    playbacktime = soundgetplaybacktime(sound_to_play);
    if (isdefined(playbacktime) && playbacktime >= 0) {
        playbacktime *= 0.001;
    } else {
        playbacktime = 1;
    }
    var_6ddc5d8e = float(gettime() - (isdefined(self.last_vo_played_time) ? self.last_vo_played_time : 0)) / 1000;
    if (var_6ddc5d8e < 1) {
        wait 2 - var_6ddc5d8e;
    }
    if (isdefined(level.var_c71571c2)) {
        self thread [[ level.var_c71571c2 ]](sound_to_play, playbacktime);
        wait playbacktime;
    } else {
        self playsoundontag(sound_to_play, "J_Head");
        wait playbacktime;
    }
    self notify(#"hash_6166949aed8ca1a1");
    self.last_vo_played_time = gettime();
    self.isspeaking = 0;
    if (isplayer(self)) {
        self clientfield::set_to_player("isspeaking", 0);
    }
}

// Namespace zm_audio/zm_audio
// Params 4, eflags: 0x0
// Checksum 0x8348e9d2, Offset: 0x4b78
// Size: 0x184
function shouldplayerspeak(player, category, subcategory, percentage) {
    if (!isdefined(player)) {
        return undefined;
    }
    if (!isplayer(player)) {
        return undefined;
    }
    if (isplayer(player)) {
        if (player.sessionstate != "playing") {
            return undefined;
        }
        if (player laststand::player_is_in_laststand() && (subcategory != "revive_down" || subcategory != "revive_up") && category != "revive") {
            return undefined;
        }
        if (player isplayerunderwater()) {
            return undefined;
        }
    }
    if (isdefined(player.dontspeak) && player.dontspeak) {
        return undefined;
    }
    if (percentage < randomintrange(1, 101)) {
        return undefined;
    }
    if (isvoxoncooldown(player, category, subcategory)) {
        return undefined;
    }
    index = player zm_characters::function_82f5ce1a();
    return "vox_plr_" + index + "_";
}

// Namespace zm_audio/zm_audio
// Params 3, eflags: 0x0
// Checksum 0x3bf98552, Offset: 0x4d08
// Size: 0x114
function isvoxoncooldown(player, category, subcategory) {
    if (level.sndplayervox[category][subcategory].cooldown <= 0) {
        return false;
    }
    fullname = category + subcategory;
    if (!isdefined(player.voxtimer)) {
        player.voxtimer = [];
    }
    if (!isdefined(player.voxtimer[fullname])) {
        player.voxtimer[fullname] = gettime();
        return false;
    }
    time = gettime();
    if (time - player.voxtimer[fullname] <= level.sndplayervox[category][subcategory].cooldown * 1000) {
        return true;
    }
    player.voxtimer[fullname] = time;
    return false;
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0xf45f1bae, Offset: 0x4e28
// Size: 0x76
function function_6837951d(category, subcategory) {
    if (isdefined(level.sndplayervox)) {
        if (isdefined(category)) {
            if (isdefined(level.sndplayervox[category])) {
                if (isdefined(subcategory)) {
                    if (isdefined(level.sndplayervox[category][subcategory])) {
                        return true;
                    }
                } else {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0xecbf5cc2, Offset: 0x4ea8
// Size: 0x1da
function function_7fc61e0e() {
    if (!isdefined(level.sndplayervox)) {
        return;
    }
    index = zm_characters::function_82f5ce1a();
    prefix = "vox_plr_" + index + "_";
    foreach (a_category in level.sndplayervox) {
        foreach (vox in a_category) {
            var_c15eb536 = get_number_variants(prefix + vox.suffix);
            self.sound_dialog[vox.suffix] = [];
            self.sound_dialog_available[vox.suffix] = [];
            for (i = 0; i < var_c15eb536; i++) {
                self.sound_dialog[vox.suffix][i] = i;
                self.sound_dialog_available[vox.suffix][i] = i;
            }
        }
    }
}

// Namespace zm_audio/zm_audio
// Params 3, eflags: 0x0
// Checksum 0x6979ba32, Offset: 0x5090
// Size: 0x1d2
function function_380f9c94(category, subcategory, variant) {
    assert(isplayer(self), "<invalid>" + "<dev string:x11b>");
    if (function_6837951d(category, subcategory)) {
        vox = level.sndplayervox[category][subcategory];
        if (!isdefined(self.sound_dialog_available)) {
            self.sound_dialog_available = [];
        }
        if (!isdefined(self.sound_dialog_available[vox.suffix])) {
            self.sound_dialog_available[vox.suffix] = [];
        }
        if (!vox.var_a317fa58) {
            if (!self.sound_dialog_available[vox.suffix].size) {
                for (i = 0; i < self.sound_dialog[vox.suffix].size; i++) {
                    self.sound_dialog_available[vox.suffix][i] = self.sound_dialog[vox.suffix][i];
                }
            }
        }
        if (isdefined(variant)) {
            return isinarray(self.sound_dialog_available[vox.suffix], variant);
        } else {
            return self.sound_dialog_available[vox.suffix].size;
        }
    }
    return 0;
}

// Namespace zm_audio/zm_audio
// Params 3, eflags: 0x0
// Checksum 0xd330debf, Offset: 0x5270
// Size: 0xfe
function zmbvoxgetlinevariant(prefix, suffix, force_variant) {
    if (!self.sound_dialog[suffix].size) {
        /#
            if (getdvarint(#"debug_audio", 0) > 0) {
                println("<dev string:x132>" + prefix + suffix);
            }
        #/
        return undefined;
    }
    if (isdefined(force_variant)) {
        variation = force_variant;
    } else {
        variation = array::random(self.sound_dialog_available[suffix]);
    }
    arrayremovevalue(self.sound_dialog_available[suffix], variation);
    return prefix + suffix + "_" + variation;
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x26fabf82, Offset: 0x5378
// Size: 0x18c
function function_bbc477e0(radius = 1000, var_20bd3ee4 = 0) {
    var_b0cd6f41 = 0;
    foreach (player in util::get_active_players()) {
        if (self == player) {
            continue;
        }
        if (var_20bd3ee4 && isdefined(player.var_f610db2) && player.var_f610db2) {
            continue;
        }
        if ((isdefined(player.var_f610db2) && player.var_f610db2 || isdefined(player.isspeaking) && player.isspeaking) && !(isdefined(self.var_b814918f) && self.var_b814918f)) {
            if (distancesquared(self.origin, player.origin) < radius * radius) {
                var_b0cd6f41 = 1;
                break;
            }
        }
    }
    return var_b0cd6f41;
}

// Namespace zm_audio/zm_audio
// Params 8, eflags: 0x0
// Checksum 0x19f171e8, Offset: 0x5510
// Size: 0x29c
function musicstate_create(statename, playtype = 1, musname1, musname2, musname3, musname4, musname5, musname6) {
    if (!isdefined(level.musicsystem)) {
        level.musicsystem = spawnstruct();
        level.musicsystem.queue = 0;
        level.musicsystem.currentplaytype = 0;
        level.musicsystem.currentset = undefined;
        level.musicsystem.states = [];
    }
    level.musicsystem.states[statename] = spawnstruct();
    level.musicsystem.states[statename].playtype = playtype;
    level.musicsystem.states[statename].musarray = array();
    if (isdefined(musname1)) {
        array::add(level.musicsystem.states[statename].musarray, musname1);
    }
    if (isdefined(musname2)) {
        array::add(level.musicsystem.states[statename].musarray, musname2);
    }
    if (isdefined(musname3)) {
        array::add(level.musicsystem.states[statename].musarray, musname3);
    }
    if (isdefined(musname4)) {
        array::add(level.musicsystem.states[statename].musarray, musname4);
    }
    if (isdefined(musname5)) {
        array::add(level.musicsystem.states[statename].musarray, musname5);
    }
    if (isdefined(musname6)) {
        array::add(level.musicsystem.states[statename].musarray, musname6);
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0xa0b86c9, Offset: 0x57b8
// Size: 0x1fc
function sndmusicsystem_playstate(state) {
    if (zm_trial::is_trial_mode() || zm_utility::is_standard()) {
        return;
    }
    if (!isdefined(level.musicsystem)) {
        return;
    }
    m = level.musicsystem;
    if (!isdefined(m.states[state])) {
        return;
    }
    s = level.musicsystem.states[state];
    playtype = s.playtype;
    if (m.currentplaytype > 0) {
        if (playtype == 1) {
            return;
        } else if (playtype == 2) {
            level thread sndmusicsystem_queuestate(state);
        } else if (playtype > m.currentplaytype || playtype == 3 && m.currentplaytype == 3) {
            if (isdefined(level.musicsystemoverride) && level.musicsystemoverride && playtype != 5) {
                return;
            } else {
                level sndmusicsystem_stopandflush();
                level thread playstate(state);
            }
        }
        return;
    }
    if (!(isdefined(level.musicsystemoverride) && level.musicsystemoverride) || playtype == 5) {
        level thread playstate(state);
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x9765baed, Offset: 0x59c0
// Size: 0x1fe
function playstate(state) {
    level endon(#"sndstatestop");
    m = level.musicsystem;
    musarray = level.musicsystem.states[state].musarray;
    if (musarray.size <= 0) {
        return;
    }
    mustoplay = musarray[randomintrange(0, musarray.size)];
    m.currentplaytype = m.states[state].playtype;
    m.currentstate = state;
    wait 0.1;
    if (isdefined(level.sndplaystateoverride)) {
        perplayer = level [[ level.sndplaystateoverride ]](state);
        if (!(isdefined(perplayer) && perplayer)) {
            music::setmusicstate(mustoplay);
        }
    } else {
        music::setmusicstate(mustoplay);
    }
    aliasname = "mus_" + mustoplay + "_intro";
    playbacktime = soundgetplaybacktime(aliasname);
    if (!isdefined(playbacktime) || playbacktime <= 0) {
        waittime = 1000;
    } else {
        waittime = playbacktime;
    }
    var_9bce694 = gettime() + waittime;
    while (gettime() < var_9bce694) {
        wait 0.1;
    }
    m.currentplaytype = 0;
    m.currentstate = undefined;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0xffc1f954, Offset: 0x5bc8
// Size: 0xe2
function sndmusicsystem_queuestate(state) {
    level endon(#"sndqueueflush");
    m = level.musicsystem;
    count = 0;
    if (isdefined(m.queue) && m.queue) {
        return;
    }
    m.queue = 1;
    while (m.currentplaytype > 0) {
        wait 0.5;
        count++;
        if (count >= 20) {
            m.queue = 0;
            return;
        }
    }
    level thread playstate(state);
    m.queue = 0;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0xf43bc934, Offset: 0x5cb8
// Size: 0x62
function sndmusicsystem_stopandflush() {
    level notify(#"sndqueueflush");
    level.musicsystem.queue = 0;
    level notify(#"sndstatestop");
    level.musicsystem.currentplaytype = 0;
    level.musicsystem.currentstate = undefined;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x7ac61ba6, Offset: 0x5d28
// Size: 0x58
function sndmusicsystem_isabletoplay() {
    if (!isdefined(level.musicsystem)) {
        return false;
    }
    if (!isdefined(level.musicsystem.currentplaytype)) {
        return false;
    }
    if (level.musicsystem.currentplaytype >= 4) {
        return false;
    }
    return true;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0xb6e96d28, Offset: 0x5d88
// Size: 0x3c
function function_4725da2e(str_location) {
    level thread function_eaf6a65(str_location);
    self thread location_vox(str_location);
}

// Namespace zm_audio/zm_audio
// Params 4, eflags: 0x0
// Checksum 0xa0549ecb, Offset: 0x5dd0
// Size: 0x114
function function_105831ac(str_location, var_7a08724, b_repeat = 0, var_54e9ce61 = 2) {
    if (!isdefined(level.var_9c6106df)) {
        level.var_9c6106df = [];
    }
    level.var_9c6106df[str_location] = spawnstruct();
    level.var_9c6106df[str_location].var_7a08724 = var_7a08724;
    level.var_9c6106df[str_location].b_repeat = b_repeat;
    level.var_9c6106df[str_location].var_61093829 = 0;
    level.var_9c6106df[str_location].b_played = 0;
    musicstate_create(var_7a08724, var_54e9ce61, var_7a08724);
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0xced4f411, Offset: 0x5ef0
// Size: 0x54
function function_eaf6a65(str_location) {
    if (!isdefined(level.var_9c6106df)) {
        return;
    }
    if (isdefined(level.var_9c6106df[str_location])) {
        level thread function_dead547e(level.var_9c6106df[str_location]);
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0xd5ed3008, Offset: 0x5f50
// Size: 0x18c
function function_dead547e(var_2e9f4d1a) {
    level notify(#"hash_78615fca09ef53a");
    level endon(#"hash_78615fca09ef53a");
    if (zm_trial::is_trial_mode()) {
        return;
    }
    if (level.musicsystem.currentplaytype > 0) {
        b_success = level function_2536c6cf();
        if (!b_success) {
            return;
        }
    }
    if (var_2e9f4d1a.b_played) {
        if (!var_2e9f4d1a.b_repeat) {
            return;
        } else if (var_2e9f4d1a.var_61093829 >= 3) {
            var_2e9f4d1a.b_played = 0;
        } else {
            return;
        }
    }
    foreach (struct in level.var_9c6106df) {
        if (struct != var_2e9f4d1a) {
            struct.var_61093829++;
        }
    }
    var_2e9f4d1a.b_played = 1;
    var_2e9f4d1a.var_61093829 = 0;
    level thread sndmusicsystem_playstate(var_2e9f4d1a.var_7a08724);
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0xe502e6d1, Offset: 0x60e8
// Size: 0x68
function function_2536c6cf() {
    level endon(#"hash_78615fca09ef53a");
    n_counter = 0;
    while (level.musicsystem.currentplaytype > 0) {
        wait 0.5;
        n_counter++;
        if (n_counter >= 30) {
            return false;
        }
    }
    return true;
}

// Namespace zm_audio/zm_audio
// Params 6, eflags: 0x0
// Checksum 0xf70b6eb0, Offset: 0x6158
// Size: 0x2b0
function sndmusicsystem_eesetup(state, origin1, origin2, origin3, origin4, origin5) {
    sndeearray = array();
    if (isdefined(origin1)) {
        if (!isdefined(sndeearray)) {
            sndeearray = [];
        } else if (!isarray(sndeearray)) {
            sndeearray = array(sndeearray);
        }
        sndeearray[sndeearray.size] = origin1;
    }
    if (isdefined(origin2)) {
        if (!isdefined(sndeearray)) {
            sndeearray = [];
        } else if (!isarray(sndeearray)) {
            sndeearray = array(sndeearray);
        }
        sndeearray[sndeearray.size] = origin2;
    }
    if (isdefined(origin3)) {
        if (!isdefined(sndeearray)) {
            sndeearray = [];
        } else if (!isarray(sndeearray)) {
            sndeearray = array(sndeearray);
        }
        sndeearray[sndeearray.size] = origin3;
    }
    if (isdefined(origin4)) {
        if (!isdefined(sndeearray)) {
            sndeearray = [];
        } else if (!isarray(sndeearray)) {
            sndeearray = array(sndeearray);
        }
        sndeearray[sndeearray.size] = origin4;
    }
    if (isdefined(origin5)) {
        if (!isdefined(sndeearray)) {
            sndeearray = [];
        } else if (!isarray(sndeearray)) {
            sndeearray = array(sndeearray);
        }
        sndeearray[sndeearray.size] = origin5;
    }
    if (sndeearray.size > 0) {
        level.sndeemax = sndeearray.size;
        level.sndeecount = 0;
        foreach (origin in sndeearray) {
            level thread sndmusicsystem_eewait(origin, state);
        }
    }
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0xae189c65, Offset: 0x6410
// Size: 0x164
function sndmusicsystem_eewait(origin, state) {
    temp_ent = spawn("script_origin", origin);
    temp_ent playloopsound(#"zmb_meteor_loop");
    temp_ent thread secretuse("main_music_egg_hit", (0, 255, 0), &sndmusicsystem_eeoverride);
    waitresult = temp_ent waittill(#"main_music_egg_hit");
    temp_ent stoploopsound(1);
    waitresult.player playsound(#"zmb_meteor_activate");
    level.sndeecount++;
    if (level.sndeecount >= level.sndeemax) {
        level notify(#"hash_6499c9075229a517");
        level thread sndmusicsystem_playstate(state);
    }
    temp_ent delete();
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x598f56, Offset: 0x6580
// Size: 0x52
function sndmusicsystem_eeoverride(arg1, arg2) {
    if (isdefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4) {
        return false;
    }
    return true;
}

// Namespace zm_audio/zm_audio
// Params 5, eflags: 0x0
// Checksum 0x74de8769, Offset: 0x65e0
// Size: 0x18c
function secretuse(notify_string, color, qualifier_func, arg1, arg2) {
    waittillframeend();
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        /#
            print3d(self.origin, "<dev string:x15c>", color, 1);
        #/
        players = level.players;
        foreach (player in players) {
            qualifier_passed = 1;
            if (isdefined(qualifier_func)) {
                qualifier_passed = player [[ qualifier_func ]](arg1, arg2);
            }
            if (qualifier_passed && distancesquared(self.origin, player.origin) < 4096) {
                if (player laststand::is_facing(self)) {
                    if (player usebuttonpressed()) {
                        self notify(notify_string, player);
                        return;
                    }
                }
            }
        }
        wait 0.1;
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0xbeab2669, Offset: 0x6778
// Size: 0x144
function function_3aef57a7() {
    if (!isdefined(level.var_7f1833aa)) {
        level.var_7f1833aa = 0;
    }
    var_2fd02d41 = 0;
    var_cf2fc775 = zm_round_spawning::function_e7543004(1);
    if (isdefined(var_cf2fc775)) {
        var_b54144f2 = var_cf2fc775.n_round;
        if (isdefined(var_b54144f2) && level.round_number == var_b54144f2) {
            var_2fd02d41 = 1;
        }
    }
    if (isdefined(level.musicsystem.states[#"round_start_first"]) && level.round_number <= 1) {
        level thread sndmusicsystem_playstate("round_start_first");
        return;
    }
    if (var_2fd02d41) {
        level thread sndmusicsystem_playstate("round_start_special");
        level.var_7f1833aa = 1;
        return;
    }
    level thread sndmusicsystem_playstate("round_start");
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x69975513, Offset: 0x68c8
// Size: 0x5c
function function_a08f940c() {
    if (level.var_7f1833aa) {
        level thread sndmusicsystem_playstate("round_end_special");
        level.var_7f1833aa = 0;
        return;
    }
    level thread sndmusicsystem_playstate("round_end");
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x67884db6, Offset: 0x6930
// Size: 0xa6c
function sndannouncer_init() {
    if (!isdefined(level.zmannouncerprefix)) {
        level.zmannouncerprefix = "vox_" + "zmba" + "_";
    }
    sndannouncervoxadd("carpenter", "powerup_carpenter_0");
    sndannouncervoxadd("insta_kill", "powerup_instakill_0");
    sndannouncervoxadd("double_points", "powerup_doublepoints_0");
    sndannouncervoxadd("nuke", "powerup_nuke_0");
    sndannouncervoxadd("full_ammo", "powerup_max_ammo_0");
    sndannouncervoxadd("fire_sale", "powerup_firesale_0");
    sndannouncervoxadd("minigun", "powerup_death_machine_0");
    sndannouncervoxadd("bonus_points_team", "powerup_bonus_points_team_0");
    sndannouncervoxadd("bonus_points_player", "powerup_bonus_points_team_0");
    sndannouncervoxadd("bonus_points_player_shared", "powerup_bonus_points_team_0");
    sndannouncervoxadd("hero_weapon_power", "powerup_full_power_0");
    sndannouncervoxadd("boxmove", "event_magicbox_0");
    sndannouncervoxadd("dogstart", "event_dogstart_0");
    sndannouncervoxadd("shield_upgrade", "exert_shield_upgrade_2");
    if (zm_utility::is_standard()) {
        sndannouncervoxadd("game_start_0", "rush_game_start_0");
        sndannouncervoxadd("game_start_1", "rush_game_start_1");
        sndannouncervoxadd("game_start_2", "rush_game_start_2");
        sndannouncervoxadd("game_start_3", "rush_game_start_3");
        sndannouncervoxadd("game_start_4", "rush_game_start_4");
        sndannouncervoxadd("points_spawning", "rush_zpoint_spawn_0");
        sndannouncervoxadd("multiplier_rising_0", "rush_mult_rising_0");
        sndannouncervoxadd("multiplier_rising_1", "rush_mult_rising_1");
        sndannouncervoxadd("multiplier_rising_2", "rush_mult_rising_2");
        sndannouncervoxadd("multiplier_rising_3", "rush_mult_rising_3");
        sndannouncervoxadd("multiplier_rising_4", "rush_mult_rising_4");
        sndannouncervoxadd("multiplier_50", "rush_mult_tier_1_0");
        sndannouncervoxadd("multiplier_75", "rush_mult_tier_2_0");
        sndannouncervoxadd("multiplier_100", "rush_mult_tier_3_0");
        sndannouncervoxadd("multiplier_125", "rush_mult_tier_4_0");
        sndannouncervoxadd("multiplier_150", "rush_mult_tier_5_0");
        sndannouncervoxadd("picked_up_key", "rush_key_acquired_0");
        sndannouncervoxadd(#"specialty_berserker", "rush_perk_dying_wish_0");
        sndannouncervoxadd(#"specialty_phdflopper", "rush_perk_phd_0");
        sndannouncervoxadd(#"specialty_cooldown", "rush_perk_timeslip_0");
        sndannouncervoxadd(#"specialty_shield", "rush_perk_turtle_0");
        sndannouncervoxadd(#"specialty_awareness", "rush_perk_death_perc_0");
        sndannouncervoxadd(#"specialty_extraammo", "rush_perk_bandolier_0");
        sndannouncervoxadd(#"specialty_deadshot", "rush_perk_deadshot_0");
        sndannouncervoxadd(#"specialty_quickrevive", "rush_perk_quick_revive_0");
        sndannouncervoxadd(#"specialty_electriccherry", "rush_perk_electric_burst_0");
        sndannouncervoxadd(#"specialty_additionalprimaryweapon", "rush_perk_mule_kick_0");
        sndannouncervoxadd(#"specialty_widowswine", "rush_perk_widows_wail_0");
        sndannouncervoxadd(#"specialty_staminup", "rush_perk_staminup_0");
        sndannouncervoxadd(#"specialty_camper", "rush_perk_stone_cold_0");
        sndannouncervoxadd("perk_generic", "rush_perk_generic_0");
        sndannouncervoxadd("hero_weapon_ready_0", "rush_spec_weapon_ready_0");
        sndannouncervoxadd("hero_weapon_ready_1", "rush_spec_weapon_ready_1");
        sndannouncervoxadd("hero_weapon_ready_2", "rush_spec_weapon_ready_2");
        sndannouncervoxadd("extra_life", "rush_extra_life_0");
        sndannouncervoxadd("incoming_blight_father", "rush_incoming_blight_0");
        sndannouncervoxadd("incoming_stoker", "rush_incoming_stoker_0");
        sndannouncervoxadd("incoming_boss", "rush_incoming_boss_0");
        sndannouncervoxadd("incoming_mini_boss", "rush_incoming_mini_boss_0");
        sndannouncervoxadd("incoming_heavy", "rush_incoming_heavy_0");
        sndannouncervoxadd("power_activated", "rush_power_activated_0");
        sndannouncervoxadd("rush_zone_nag", "rush_zone_nag_0");
        sndannouncervoxadd("defend_start", "rush_defend_start_0");
        sndannouncervoxadd("defend_complete", "rush_defend_complete_0");
        sndannouncervoxadd("player_out", "rush_player_out_0");
        sndannouncervoxadd("player_last_man_standing", "rush_player_last_0");
        sndannouncervoxadd("player_respawn", "rush_player_respawn_0");
        sndannouncervoxadd("timer_10", "rush_timer_10_0");
        sndannouncervoxadd("timer_9", "rush_timer_9_0");
        sndannouncervoxadd("timer_8", "rush_timer_8_0");
        sndannouncervoxadd("timer_7", "rush_timer_7_0");
        sndannouncervoxadd("timer_6", "rush_timer_6_0");
        sndannouncervoxadd("timer_5", "rush_timer_5_0");
        sndannouncervoxadd("timer_4", "rush_timer_4_0");
        sndannouncervoxadd("timer_3", "rush_timer_3_0");
        sndannouncervoxadd("timer_2", "rush_timer_2_0");
        sndannouncervoxadd("timer_1", "rush_timer_1_0");
        sndannouncervoxadd("lead_gained", "rush_lead_gained_0");
        sndannouncervoxadd("lead_lost", "rush_lead_lost_0");
        sndannouncervoxadd("second_place_gained", "rush_second_gained_0");
        sndannouncervoxadd("third_place_gained", "rush_third_gained_0");
        sndannouncervoxadd("dropped_to_third_place", "rush_third_dropped_0");
        sndannouncervoxadd("dropped_to_last_place", "rush_last_dropped_0");
        sndannouncervoxadd("player_down", "rush_player_down_0");
    }
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0xed66398a, Offset: 0x73a8
// Size: 0x56
function sndannouncervoxadd(type, suffix) {
    if (!isdefined(level.zmannouncervox)) {
        level.zmannouncervox = array();
    }
    level.zmannouncervox[type] = suffix;
}

// Namespace zm_audio/zm_audio
// Params 3, eflags: 0x0
// Checksum 0xa210ffc5, Offset: 0x7408
// Size: 0x216
function sndannouncerplayvox(type, player, str_sound) {
    if (!isdefined(str_sound)) {
        prefix = level.zmannouncerprefix;
        suffix = level.zmannouncervox[type];
        if (isdefined(prefix) && isdefined(suffix)) {
            str_sound = array::random(get_valid_lines(prefix + suffix));
        }
    }
    if (!isdefined(str_sound)) {
        return;
    }
    n_wait = float(soundgetplaybacktime(str_sound)) / 1000;
    n_wait = max(n_wait - 0.5, 0.1);
    if (isplayer(player)) {
        player endon(#"disconnect");
        if (!(isdefined(player.zmannouncertalking) && player.zmannouncertalking)) {
            player.zmannouncertalking = 1;
            player playsoundtoplayer(str_sound, player);
            wait n_wait;
            player.zmannouncertalking = undefined;
        }
        return;
    }
    foreach (player in level.players) {
        level thread sndannouncerplayvox(type, player, str_sound);
    }
    wait n_wait;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0xce442b65, Offset: 0x7628
// Size: 0xa8
function sndperksjingles_timer() {
    self endon(#"death");
    if (isdefined(self.sndjinglecooldown)) {
        self.sndjinglecooldown = 0;
    }
    while (true) {
        wait randomfloatrange(30, 60);
        if (randomintrange(0, 100) <= 10 && !(isdefined(self.sndjinglecooldown) && self.sndjinglecooldown)) {
            self thread sndperksjingles_player(0);
        }
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0xd8432d5e, Offset: 0x76d8
// Size: 0x18e
function sndperksjingles_player(type) {
    self endon(#"death");
    if (!isdefined(self.sndjingleactive)) {
        self.sndjingleactive = 0;
    }
    alias = self.stub.script_sound;
    if (type == 1) {
        alias = self.stub.script_label;
    }
    if (isdefined(level.musicsystem) && level.musicsystem.currentplaytype >= 4) {
        return;
    }
    self.str_jingle_alias = alias;
    if (!(isdefined(self.sndjingleactive) && self.sndjingleactive)) {
        self.sndjingleactive = 1;
        self playsoundwithnotify(alias, "sndDone");
        playbacktime = soundgetplaybacktime(alias);
        if (!isdefined(playbacktime) || playbacktime <= 0) {
            waittime = 1;
        } else {
            waittime = playbacktime * 0.001;
        }
        wait waittime;
        if (type == 0) {
            self.sndjinglecooldown = 1;
            self thread sndperksjingles_cooldown();
        }
        self.sndjingleactive = 0;
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x88f70007, Offset: 0x7870
// Size: 0x56
function sndperksjingles_cooldown() {
    self endon(#"death");
    if (isdefined(self.var_1afc1154)) {
        while (isdefined(self.var_1afc1154) && self.var_1afc1154) {
            wait 1;
        }
    }
    wait 45;
    self.sndjinglecooldown = 0;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x60460b7f, Offset: 0x78d0
// Size: 0x190
function water_vox() {
    self endon(#"disconnect");
    level endon(#"end_game");
    self.voxunderwatertime = 0;
    self.voxemergebreath = 0;
    self.voxdrowning = 0;
    while (true) {
        if (!isalive(self)) {
            wait 1;
            continue;
        }
        if (self isplayerunderwater()) {
            if (!self.voxunderwatertime && !self.voxemergebreath) {
                self vo_clear_underwater();
                self.voxunderwatertime = gettime();
            } else if (self.voxunderwatertime) {
                if (gettime() > self.voxunderwatertime + 3000) {
                    self.voxunderwatertime = 0;
                    self.voxemergebreath = 1;
                }
            }
        } else {
            if (self.voxdrowning) {
                self playerexert("underwater_gasp");
                self.voxdrowning = 0;
                self.voxemergebreath = 0;
            }
            if (self.voxemergebreath) {
                self playerexert("underwater_emerge");
                self.voxemergebreath = 0;
            } else {
                self.voxunderwatertime = 0;
            }
        }
        waitframe(1);
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x408fc365, Offset: 0x7a68
// Size: 0xb4
function vo_clear_underwater() {
    if (level flag::exists("abcd_speaking")) {
        if (level flag::get("abcd_speaking")) {
            return;
        }
    }
    if (level flag::exists("shadowman_speaking")) {
        if (level flag::get("shadowman_speaking")) {
            return;
        }
    }
    self stopsounds();
    self zm_vo::vo_stop();
}

// Namespace zm_audio/zm_audio
// Params 6, eflags: 0x0
// Checksum 0xef45e243, Offset: 0x7b28
// Size: 0x14c
function sndplayerhitalert(e_victim, str_meansofdeath, e_inflictor, weapon, shitloc, damage) {
    str_alias = #"zmb_hit_alert";
    if (!isplayer(e_inflictor)) {
        return;
    }
    if (!checkforvalidmod(str_meansofdeath)) {
        return;
    }
    if (!checkforvalidweapon(weapon)) {
        return;
    }
    if (!checkforvalidaitype(e_victim)) {
        return;
    }
    if (isdefined(e_victim.health) && e_victim.health <= 0) {
        return;
    }
    if (zm_utility::is_headshot(weapon, shitloc, str_meansofdeath)) {
        str_alias += "_headshot";
    }
    if (isfatal(e_victim, damage)) {
        str_alias += "_fatal";
    }
    self thread sndplayerhitalert_playsound(str_alias);
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x1071f6b8, Offset: 0x7c80
// Size: 0x6a
function sndplayerhitalert_playsound(str_alias) {
    self endon(#"disconnect");
    if (self.hitsoundtracker) {
        self.hitsoundtracker = 0;
        self playsoundtoplayer(str_alias, self);
        wait 0.05;
        self.hitsoundtracker = 1;
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x2fcd1572, Offset: 0x7cf8
// Size: 0x96
function checkforvalidmod(str_meansofdeath) {
    if (!isdefined(str_meansofdeath)) {
        return false;
    }
    switch (str_meansofdeath) {
    case #"mod_melee_weapon_butt":
    case #"mod_crush":
    case #"mod_hit_by_object":
    case #"mod_grenade_splash":
    case #"mod_melee_assassinate":
    case #"mod_melee":
        return false;
    }
    return true;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x70983d9f, Offset: 0x7d98
// Size: 0x8e
function checkforvalidweapon(weapon) {
    b_isvalid = 1;
    switch (weapon.name) {
    case #"zhield_spectral_dw":
        b_isvalid = 0;
        break;
    case #"hero_flamethrower_t8_lv1":
    case #"hero_flamethrower_t8_lv2":
    case #"hero_flamethrower_t8_lv3":
        b_isvalid = 0;
        break;
    }
    return b_isvalid;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x65dfedc6, Offset: 0x7e30
// Size: 0x10
function checkforvalidaitype(e_victim) {
    return true;
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x1c1cccf4, Offset: 0x7e48
// Size: 0x3a
function isfatal(e_victim, damage) {
    if (isdefined(damage) && damage >= e_victim.health) {
        return true;
    }
    return false;
}

// Namespace zm_audio/bhtn_action_start
// Params 1, eflags: 0x40
// Checksum 0xc10689df, Offset: 0x7e90
// Size: 0x262
function event_handler[bhtn_action_start] function_4ab896ed(eventstruct) {
    notify_string = eventstruct.action;
    switch (notify_string) {
    case #"death":
        if (isdefined(self.bgb_tone_death) && self.bgb_tone_death) {
            level thread zmbaivox_playvox(self, "death_whimsy", 1, 4);
        } else {
            level thread zmbaivox_playvox(self, notify_string, 1, 4);
        }
        break;
    case #"pain":
        level thread zmbaivox_playvox(self, notify_string, 1, 3);
        break;
    case #"behind":
        level thread zmbaivox_playvox(self, notify_string, 1, 3);
        break;
    case #"electrocute":
        level thread zmbaivox_playvox(self, notify_string, 1, 3);
        break;
    case #"attack_melee_notetrack":
        level thread zmbaivox_playvox(self, "attack_melee", 1, 2, 1);
        break;
    case #"sprint":
    case #"ambient":
    case #"crawler":
    case #"teardown":
    case #"taunt":
        level thread zmbaivox_playvox(self, notify_string, 0, 1);
        break;
    case #"attack_melee":
        break;
    default:
        level thread zmbaivox_playvox(self, notify_string, 0, 2);
        break;
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x181594b9, Offset: 0x8100
// Size: 0x64
function zmbaivox_notifyconvert() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    self thread zmbaivox_playdeath();
    self thread zmbaivox_playelectrocution();
}

// Namespace zm_audio/zm_audio
// Params 5, eflags: 0x0
// Checksum 0x3e41caf7, Offset: 0x8170
// Size: 0x386
function zmbaivox_playvox(zombie, type, override, priority, delayambientvox = 0) {
    zombie endon(#"death");
    if (!isdefined(zombie)) {
        return;
    }
    if (!isdefined(zombie.voiceprefix)) {
        return;
    }
    if (!isdefined(priority)) {
        priority = 1;
    }
    if (!isdefined(zombie.talking)) {
        zombie.talking = 0;
    }
    if (!isdefined(zombie.currentvoxpriority)) {
        zombie.currentvoxpriority = 1;
    }
    if (!isdefined(self.delayambientvox)) {
        self.delayambientvox = 0;
    }
    if (isdefined(zombie.var_3780023) && zombie.var_3780023) {
        return;
    }
    if ((type == "ambient" || type == "sprint" || type == "crawler") && isdefined(self.delayambientvox) && self.delayambientvox) {
        return;
    }
    if (delayambientvox) {
        self.delayambientvox = 1;
        self thread zmbaivox_ambientdelay();
    }
    alias = "zmb_vocals_" + zombie.voiceprefix + "_" + type;
    if (sndisnetworksafe()) {
        if (isdefined(override) && override) {
            if (isdefined(zombie.currentvox) && priority > zombie.currentvoxpriority) {
                zombie stopsound(zombie.currentvox);
                waitframe(1);
            }
            if (type == "death" || type == "death_whimsy" || type == "death_nohead") {
                zombie playsound(alias);
                return;
            }
        }
        if (zombie.talking === 1 && (priority < zombie.currentvoxpriority || priority === 1)) {
            return;
        }
        zombie.talking = 1;
        zombie.currentvox = alias;
        zombie.currentvoxpriority = priority;
        zombie playsoundontag(alias, "j_head");
        playbacktime = soundgetplaybacktime(alias);
        if (!isdefined(playbacktime)) {
            playbacktime = 1;
        }
        if (playbacktime >= 0) {
            playbacktime *= 0.001;
        } else {
            playbacktime = 1;
        }
        wait playbacktime;
        zombie.talking = 0;
        zombie.currentvox = undefined;
        zombie.currentvoxpriority = 1;
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x42457485, Offset: 0x8500
// Size: 0xdc
function zmbaivox_playdeath() {
    self endon(#"disconnect");
    self waittill(#"death");
    if (isdefined(self)) {
        if (isdefined(self.bgb_tone_death) && self.bgb_tone_death) {
            level thread zmbaivox_playvox(self, "death_whimsy", 1);
            return;
        }
        if (isdefined(self.head_gibbed) && self.head_gibbed) {
            level thread zmbaivox_playvox(self, "death_nohead", 1);
            return;
        }
        level thread zmbaivox_playvox(self, "death", 1);
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x77137660, Offset: 0x85e8
// Size: 0x10a
function zmbaivox_playelectrocution() {
    self endon(#"disconnect");
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"damage");
        weapon = waitresult.weapon;
        if (weapon.name == #"zombie_beast_lightning_dwl" || weapon.name == #"zombie_beast_lightning_dwl2" || weapon.name == #"zombie_beast_lightning_dwl3") {
            bhtnactionstartevent(self, "electrocute");
            self notify(#"bhtn_action_notify", {#action:"electrocute"});
        }
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0xe64dad8e, Offset: 0x8700
// Size: 0x5a
function zmbaivox_ambientdelay() {
    self notify(#"sndambientdelay");
    self endon(#"sndambientdelay");
    self endon(#"death");
    self endon(#"disconnect");
    wait 2;
    self.delayambientvox = 0;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x69e10647, Offset: 0x8768
// Size: 0x30
function networksafereset() {
    while (true) {
        level._numzmbaivox = 0;
        util::wait_network_frame();
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0xe20f79bf, Offset: 0x87a0
// Size: 0x54
function sndisnetworksafe() {
    if (!isdefined(level._numzmbaivox)) {
        level thread networksafereset();
    }
    if (level._numzmbaivox >= 2) {
        return false;
    }
    level._numzmbaivox++;
    return true;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x2907cf94, Offset: 0x8800
// Size: 0x24
function is_last_zombie() {
    if (zombie_utility::get_current_zombie_count() <= 1) {
        return true;
    }
    return false;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x17ce55c4, Offset: 0x8830
// Size: 0x398
function zombie_behind_vox() {
    level endon(#"unloaded");
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(level._zbv_vox_last_update_time)) {
        level._zbv_vox_last_update_time = 0;
        level._audio_zbv_shared_ent_list = zombie_utility::get_zombie_array();
    }
    while (true) {
        wait 1;
        t = gettime();
        if (t > level._zbv_vox_last_update_time + 1000) {
            level._zbv_vox_last_update_time = t;
            level._audio_zbv_shared_ent_list = zombie_utility::get_zombie_array();
        }
        zombs = level._audio_zbv_shared_ent_list;
        played_sound = 0;
        for (i = 0; i < zombs.size; i++) {
            if (!isdefined(zombs[i])) {
                continue;
            }
            if (zombs[i].isdog) {
                continue;
            }
            dist = 150;
            z_dist = 50;
            alias = level.vox_behind_zombie;
            if (isdefined(zombs[i].zombie_move_speed)) {
                switch (zombs[i].zombie_move_speed) {
                case #"walk":
                    dist = 150;
                    break;
                case #"run":
                    dist = 175;
                    break;
                case #"sprint":
                    dist = 200;
                    break;
                }
            }
            if (distancesquared(zombs[i].origin, self.origin) < dist * dist) {
                yaw = self zm_utility::getyawtospot(zombs[i].origin);
                z_diff = self.origin[2] - zombs[i].origin[2];
                if ((yaw < -95 || yaw > 95) && abs(z_diff) < 50) {
                    wait 0.1;
                    if (isdefined(zombs[i]) && isalive(zombs[i])) {
                        bhtnactionstartevent(zombs[i], "behind");
                        zombs[i] notify(#"bhtn_action_notify", {#action:"behind"});
                        played_sound = 1;
                    }
                    break;
                }
            }
        }
        if (played_sound) {
            wait 2.5;
        }
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x431ca901, Offset: 0x8bd0
// Size: 0x1a0
function play_ambient_zombie_vocals() {
    self endon(#"death");
    while (true) {
        type = "ambient";
        float = 3;
        if (isdefined(self.zombie_move_speed)) {
            switch (self.zombie_move_speed) {
            case #"walk":
                type = "ambient";
                float = 3;
                break;
            case #"run":
                type = "sprint";
                float = 3;
                break;
            case #"sprint":
                type = "sprint";
                float = 3;
                break;
            }
        }
        if (isdefined(self.script_noteworthy) && self.script_noteworthy == "zombie_catalyst_spawner") {
            float = 2.5;
        } else if (isdefined(self.missinglegs) && self.missinglegs) {
            float = 2;
            type = "crawler";
        }
        bhtnactionstartevent(self, type);
        self notify(#"bhtn_action_notify", {#action:type});
        wait randomfloatrange(1, float);
    }
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0xe7c8d7c, Offset: 0x8d78
// Size: 0x6e
function function_83711320(str_location, var_41750e29) {
    if (!isdefined(self.var_852678c9)) {
        self.var_852678c9 = [];
    }
    if (!isdefined(level.var_6f73df7d)) {
        level.var_6f73df7d = [];
    }
    self.var_852678c9[str_location] = var_41750e29;
    level.var_6f73df7d[str_location] = 0;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x33080f5c, Offset: 0x8df0
// Size: 0xbc
function location_vox(str_location) {
    if (!isdefined(self.var_852678c9)) {
        return;
    }
    if (!isdefined(self.var_852678c9[str_location])) {
        return;
    }
    if (!(isdefined(level.var_6f73df7d[str_location]) && level.var_6f73df7d[str_location])) {
        level.var_6f73df7d[str_location] = 1;
        self thread create_and_play_dialog(#"location_enter", self.var_852678c9[str_location], undefined, 1);
        level thread function_2e9116a2(str_location);
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x2b585c46, Offset: 0x8eb8
// Size: 0x26
function function_2e9116a2(str_location) {
    wait 15;
    level.var_6f73df7d[str_location] = 0;
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x28b692d6, Offset: 0x8ee8
// Size: 0x7c
function get_number_variants(aliasprefix) {
    for (i = 0; i < 20; i++) {
        if (!soundexists(aliasprefix + "_" + i)) {
            return i;
        }
    }
    assertmsg("<dev string:x15e>");
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x572d4c51, Offset: 0x8f70
// Size: 0x13a
function get_valid_lines(aliasprefix) {
    a_variants = [];
    for (i = 0; i < 20; i++) {
        str_alias = aliasprefix + "_" + i;
        if (soundexists(str_alias)) {
            if (!isdefined(a_variants)) {
                a_variants = [];
            } else if (!isarray(a_variants)) {
                a_variants = array(a_variants);
            }
            a_variants[a_variants.size] = str_alias;
            continue;
        }
        if (soundexists(aliasprefix)) {
            if (!isdefined(a_variants)) {
                a_variants = [];
            } else if (!isarray(a_variants)) {
                a_variants = array(a_variants);
            }
            a_variants[a_variants.size] = aliasprefix;
            break;
        }
    }
    return a_variants;
}

