#using script_39eae6a6b493fe9e;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\drown;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effects;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\weapons\weapon_utils;
#using scripts\zm_common\bb;
#using scripts\zm_common\bots\zm_bot;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_scriptmover;
#using scripts\zm_common\gametypes\globallogic_spawn;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_player;

// Namespace zm_player/zm_player
// Params 0, eflags: 0x2
// Checksum 0x55fdd75c, Offset: 0x620
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_player", &__init__, undefined, undefined);
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x668
// Size: 0x4
function __init__() {
    
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x25aa6244, Offset: 0x678
// Size: 0xb2
function getallotherplayers() {
    aliveplayers = [];
    for (i = 0; i < level.players.size; i++) {
        if (!isdefined(level.players[i])) {
            continue;
        }
        player = level.players[i];
        if (player.sessionstate != "playing" || player == self) {
            continue;
        }
        aliveplayers[aliveplayers.size] = player;
    }
    return aliveplayers;
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0x6256ec30, Offset: 0x738
// Size: 0xd6
function updateplayernum(player) {
    if (!isdefined(player.playernum)) {
        if (player.team == #"allies") {
            if (!isdefined(game._team1_num)) {
                game._team1_num = 0;
            }
            player.playernum = game._team1_num;
            game._team1_num = player.playernum + 1;
            return;
        }
        if (!isdefined(game._team2_num)) {
            game._team2_num = 0;
        }
        player.playernum = game._team2_num;
        game._team2_num = player.playernum + 1;
    }
}

// Namespace zm_player/zm_player
// Params 2, eflags: 0x0
// Checksum 0xade863c, Offset: 0x818
// Size: 0x43e
function getfreespawnpoint(spawnpoints, player) {
    if (!isdefined(spawnpoints)) {
        /#
            iprintlnbold("<dev string:x30>");
        #/
        return undefined;
    }
    if (!isdefined(game.spawns_randomized)) {
        game.spawns_randomized = 1;
        spawnpoints = array::randomize(spawnpoints);
        random_chance = randomint(100);
        if (random_chance > 50) {
            game.side_selection = 1;
        } else {
            game.side_selection = 2;
        }
    }
    side_selection = game.side_selection;
    if (game.switchedsides) {
        if (side_selection == 2) {
            side_selection = 1;
        } else if (side_selection == 1) {
            side_selection = 2;
        }
    }
    if (isdefined(player) && isdefined(player.team)) {
        for (i = 0; isdefined(spawnpoints) && i < spawnpoints.size; i++) {
            if (side_selection == 1) {
                if (player.team != #"allies" && isdefined(spawnpoints[i].script_int) && spawnpoints[i].script_int == 1) {
                    arrayremovevalue(spawnpoints, spawnpoints[i]);
                    i = 0;
                } else if (player.team == #"allies" && isdefined(spawnpoints[i].script_int) && spawnpoints[i].script_int == 2) {
                    arrayremovevalue(spawnpoints, spawnpoints[i]);
                    i = 0;
                } else {
                    i++;
                }
                continue;
            }
            if (player.team == #"allies" && isdefined(spawnpoints[i].script_int) && spawnpoints[i].script_int == 1) {
                arrayremovevalue(spawnpoints, spawnpoints[i]);
                i = 0;
                continue;
            }
            if (player.team != #"allies" && isdefined(spawnpoints[i].script_int) && spawnpoints[i].script_int == 2) {
                arrayremovevalue(spawnpoints, spawnpoints[i]);
                i = 0;
                continue;
            }
        }
    }
    updateplayernum(player);
    for (j = 0; j < spawnpoints.size; j++) {
        if (!isdefined(spawnpoints[j].en_num)) {
            for (m = 0; m < spawnpoints.size; m++) {
                spawnpoints[m].en_num = m;
            }
        }
        if (spawnpoints[j].en_num == player.playernum) {
            return spawnpoints[j];
        }
    }
    return spawnpoints[0];
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x2bcab237, Offset: 0xc60
// Size: 0x244
function player_track_ammo_count() {
    self notify(#"stop_ammo_tracking");
    self endon(#"disconnect", #"stop_ammo_tracking");
    ammolowcount = 0;
    ammooutcount = 0;
    while (true) {
        wait 0.5;
        weapon = self getcurrentweapon();
        if (weapon == level.weaponnone || weapon.skiplowammovox) {
            continue;
        }
        if (isdefined(weapon.isheroweapon) && weapon.isheroweapon) {
            continue;
        }
        if (weapon.type == "grenade") {
            continue;
        }
        ammocount = self getammocount(weapon);
        var_4d9ad178 = min(5, floor((weapon.clipsize + weapon.maxammo) / 2));
        if (ammocount > var_4d9ad178 || self laststand::player_is_in_laststand()) {
            ammooutcount = 0;
            ammolowcount = 0;
            continue;
        }
        if (ammocount > 0) {
            if (ammolowcount < 1) {
                self zm_audio::create_and_play_dialog("ammo", "low");
                ammolowcount++;
            }
        } else if (ammooutcount < 1) {
            wait 0.5;
            if (self getcurrentweapon() !== weapon) {
                continue;
            }
            self zm_audio::create_and_play_dialog("ammo", "out");
            ammooutcount++;
        }
        wait 20;
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x53f2a8ae, Offset: 0xeb0
// Size: 0x94
function spawn_vo() {
    wait 1;
    players = getplayers();
    if (players.size > 1) {
        player = array::random(players);
        index = zm_utility::get_player_index(player);
        player thread spawn_vo_player(index, players.size);
    }
}

// Namespace zm_player/zm_player
// Params 2, eflags: 0x0
// Checksum 0x9c50c984, Offset: 0xf50
// Size: 0x7a
function spawn_vo_player(index, num) {
    sound = "plr_" + index + "_vox_" + num + "play";
    self playsoundwithnotify(sound, "sound_done");
    self waittill(#"sound_done");
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x275ee21, Offset: 0xfd8
// Size: 0x28
function precache_models() {
    if (isdefined(level.precachecustomcharacters)) {
        self [[ level.precachecustomcharacters ]]();
    }
}

// Namespace zm_player/zm_player
// Params 9, eflags: 0x0
// Checksum 0x1b7d3e08, Offset: 0x1008
// Size: 0x94
function callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    self endon(#"disconnect");
    zm_laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
}

// Namespace zm_player/zm_player
// Params 3, eflags: 0x0
// Checksum 0xc31a5880, Offset: 0x10a8
// Size: 0x6c
function breakafter(time, damage, piece) {
    self notify(#"breakafter");
    self endon(#"breakafter");
    wait time;
    self dodamage(damage, self.origin, undefined, undefined);
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x805539f3, Offset: 0x1120
// Size: 0x98
function function_7668acc6() {
    if (self isinvehicle()) {
        vehicle = self getvehicleoccupied();
        if (isdefined(vehicle) && isdefined(vehicle.overrideplayerdamage)) {
            return vehicle.overrideplayerdamage;
        }
    }
    if (isdefined(self.overrideplayerdamage)) {
        return self.overrideplayerdamage;
    }
    if (isdefined(level.overrideplayerdamage)) {
        return level.overrideplayerdamage;
    }
}

// Namespace zm_player/zm_player
// Params 13, eflags: 0x0
// Checksum 0xdc2587a3, Offset: 0x11c0
// Size: 0x8ac
function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    if (self getinvulnerability()) {
        return;
    }
    if (isdefined(eattacker) && isplayer(eattacker) && !weapon_utils::ismeleemod(smeansofdeath)) {
        var_5af68402 = function_59c97a77(weapon, shitloc);
        idamage *= var_5af68402;
    }
    startedinlaststand = 0;
    if (isplayer(self)) {
        startedinlaststand = self laststand::player_is_in_laststand();
    }
    println("<dev string:x52>" + idamage + "<dev string:x6d>");
    if (isdefined(eattacker) && isplayer(eattacker) && eattacker.sessionteam == self.sessionteam && !eattacker hasperk(#"specialty_playeriszombie") && !(isdefined(self.is_zombie) && self.is_zombie)) {
        idamage = self process_friendly_fire_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
        if (self != eattacker && !level.friendlyfire) {
            println("<dev string:x6f>");
            return;
        } else if (self == eattacker && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_PROJECTILE" && smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_BURNED" && smeansofdeath != "MOD_SUICIDE" && smeansofdeath != "MOD_DOT") {
            println("<dev string:x98>");
            return;
        }
    }
    overrideplayerdamage = function_7668acc6();
    if (isdefined(overrideplayerdamage)) {
        idamage = self [[ overrideplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    }
    assert(isdefined(idamage), "<dev string:xb9>");
    if (isdefined(level.zm_bots_scale) && level.zm_bots_scale && isbot(self) && isdefined(einflictor) && isactor(einflictor)) {
        idamage = int(idamage / zm_bot::function_c68c1b9f(einflictor));
    }
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = eattacker;
    params.idamage = idamage;
    params.idflags = idflags;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vpoint = vpoint;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.vdamageorigin = vdamageorigin;
    params.psoffsettime = psoffsettime;
    self callback::callback(#"on_player_damage", params);
    if (isdefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
        maxhealth = self.maxhealth;
        self.health += idamage;
        self.maxhealth = maxhealth;
    }
    if (isdefined(level.prevent_player_damage) && !level.friendlyfire) {
        if (self [[ level.prevent_player_damage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)) {
            return;
        }
    }
    idflags |= level.idflags_no_knockback;
    if (idamage > 0 && shitloc == "riotshield") {
        shitloc = "torso_upper";
    }
    println("<dev string:xf2>");
    var_87cdb53f = 0;
    if (isplayer(self)) {
        var_87cdb53f = !startedinlaststand && self laststand::player_is_in_laststand();
    }
    /#
        if (isdefined(eattacker)) {
            record3dtext("<dev string:x10e>" + idamage + "<dev string:x111>" + self.health + "<dev string:x116>" + eattacker getentitynumber(), self.origin, (1, 0, 0), "<dev string:x11b>", self);
        } else {
            record3dtext("<dev string:x10e>" + idamage + "<dev string:x111>" + self.health + "<dev string:x122>", self.origin, (1, 0, 0), "<dev string:x11b>", self);
        }
    #/
    idamage = function_e25f1a70(eattacker, idamage);
    if (idamage > 0) {
        if (isdefined(level.var_1c3ca9f2)) {
            zm_custom::function_c5892a26();
            self zm_score::player_reduce_points("points_lost_on_hit_percent", level.var_1c3ca9f2);
        } else if (isdefined(level.var_132a7f92)) {
            zm_custom::function_c5892a26();
            self zm_score::player_reduce_points("points_lost_on_hit_value", level.var_132a7f92);
        }
        if (isdefined(eattacker) && eattacker.team == level.zombie_team) {
            self zm_stats::increment_player_stat("hits_taken");
        }
    }
    self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    bb::logdamage(eattacker, self, weapon, idamage, smeansofdeath, shitloc, self.health <= 0, var_87cdb53f);
}

// Namespace zm_player/zm_player
// Params 13, eflags: 0x0
// Checksum 0x389f9235, Offset: 0x1a78
// Size: 0xb4
function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
}

// Namespace zm_player/zm_player
// Params 2, eflags: 0x0
// Checksum 0x99adc7e0, Offset: 0x1b38
// Size: 0x2da
function function_e25f1a70(eattacker, idamage) {
    if (!isdefined(eattacker)) {
        return idamage;
    }
    if (eattacker.archetype === "zombie" && isdefined(level.var_29b03f64)) {
        idamage *= level.var_29b03f64;
    }
    if (eattacker.archetype === "catalyst" && isdefined(level.var_2ca00c83)) {
        idamage *= level.var_2ca00c83;
    }
    if (isdefined(eattacker.archetype) && isinarray(array(hash("blight_father")), eattacker.archetype) && isdefined(level.var_64928180)) {
        idamage *= level.var_64928180;
    }
    if (isdefined(eattacker.archetype) && isinarray(array(hash("stoker"), hash("brutus"), hash("gladiator"), hash("gladiator_marauder"), hash("gladiator_destroyer")), eattacker.archetype) && isdefined(level.var_5952ea6b)) {
        idamage *= level.var_5952ea6b;
    }
    if (isdefined(eattacker.archetype) && isinarray(array(hash("bat"), hash("dog"), hash("nosferatu"), hash("tiger")), eattacker.archetype) && isdefined(level.var_49ea6ed)) {
        idamage *= level.var_49ea6ed;
    }
    return int(idamage);
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0x7a212d44, Offset: 0x1e20
// Size: 0x44
function function_a4e9154d(callback) {
    if (!isdefined(level.player_friendly_fire_callbacks)) {
        level.player_friendly_fire_callbacks = [];
    }
    arrayremovevalue(level.player_friendly_fire_callbacks, callback);
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0x9bbe946f, Offset: 0x1e70
// Size: 0xaa
function register_player_friendly_fire_callback(callback) {
    if (!isdefined(level.player_friendly_fire_callbacks)) {
        level.player_friendly_fire_callbacks = [];
    }
    if (!isdefined(level.player_friendly_fire_callbacks)) {
        level.player_friendly_fire_callbacks = [];
    } else if (!isarray(level.player_friendly_fire_callbacks)) {
        level.player_friendly_fire_callbacks = array(level.player_friendly_fire_callbacks);
    }
    level.player_friendly_fire_callbacks[level.player_friendly_fire_callbacks.size] = callback;
}

// Namespace zm_player/zm_player
// Params 11, eflags: 0x0
// Checksum 0x4edc28a7, Offset: 0x1f28
// Size: 0x10e
function process_friendly_fire_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    if (isdefined(level.player_friendly_fire_callbacks)) {
        foreach (callback in level.player_friendly_fire_callbacks) {
            idamage = self [[ callback ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
        }
    }
    return idamage;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x9919ccd0, Offset: 0x2040
// Size: 0xcc
function onplayerconnect_clientdvars() {
    self setclientcompass(0);
    self setclientthirdperson(0);
    self resetfov();
    self setclientthirdpersonangle(0);
    self setclientuivisibilityflag("weapon_hud_visible", 1);
    self setclientminiscoreboardhide(1);
    self setclienthudhardcore(0);
    self setclientplayerpushamount(0);
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0x22e4f7e1, Offset: 0x2118
// Size: 0x180
function function_cb9259f5(var_3c529a41) {
    if (!function_46ac3ba0(var_3c529a41) && !zm_utility::function_322da1e0()) {
        if (zm_trial::is_trial_mode()) {
            var_9fb91af5 = [];
            a_e_players = getplayers();
            foreach (e_player in a_e_players) {
                if (var_3c529a41 === e_player) {
                    continue;
                }
                array::add(var_9fb91af5, e_player, 0);
            }
            if (var_9fb91af5.size > 1) {
                zm_trial::fail(#"hash_61d8fe81f9fe9e9c", var_9fb91af5);
            } else {
                zm_trial::fail(#"hash_272fae998263208b", var_9fb91af5);
            }
            return;
        }
        level notify(#"end_game");
    }
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0xaf8b260c, Offset: 0x22a0
// Size: 0x100
function function_46ac3ba0(var_3c529a41) {
    a_e_players = getplayers();
    foreach (e_player in a_e_players) {
        if (var_3c529a41 === e_player) {
            continue;
        }
        if (e_player.is_zombie || e_player.sessionstate == "spectator") {
            continue;
        }
        if (!e_player laststand::player_is_in_laststand() || e_player zm_laststand::function_d75050c0() > 0) {
            return true;
        }
    }
    return false;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x10da92a, Offset: 0x23a8
// Size: 0x452
function onplayerspawned() {
    self notify(#"stop_onplayerspawned");
    self endon(#"stop_onplayerspawned", #"disconnect");
    for (;;) {
        self waittill(#"spawned_player");
        self.hits = 0;
        self recordplayerrevivezombies(self);
        /#
            if (getdvarint(#"zombie_cheat", 0) >= 1 && getdvarint(#"zombie_cheat", 0) <= 3) {
                self val::set(#"zombie_devgui", "<dev string:x130>", 0);
            }
        #/
        self setactionslot(3, "altMode");
        self playerknockback(0);
        self setclientthirdperson(0);
        self resetfov();
        self setclientthirdpersonangle(0);
        self cameraactivate(0);
        self.num_perks = 0;
        self.on_lander_last_stand = undefined;
        self setblur(0, 0.1);
        self.zmbdialogqueue = [];
        self.zmbdialogactive = 0;
        self.zmbdialoggroups = [];
        self.zmbdialoggroup = "";
        self.firstspawn = 0;
        if (isdefined(level.player_out_of_playable_area_monitor) && level.player_out_of_playable_area_monitor) {
            self thread player_out_of_playable_area_monitor();
        }
        if (isdefined(level.var_67a71cec) && level.var_67a71cec) {
            self thread [[ level.var_a3e1b821 ]]();
        }
        if (isdefined(level.player_too_many_players_check) && level.player_too_many_players_check) {
            level thread [[ level.player_too_many_players_check_func ]]();
        }
        self.var_9fff94cd = [];
        if (isdefined(self.player_initialized)) {
            if (self.player_initialized == 0) {
                self.player_initialized = 1;
                self setclientuivisibilityflag("weapon_hud_visible", 1);
                self setclientminiscoreboardhide(0);
                if (!isdefined(self.is_drinking)) {
                    self.is_drinking = 0;
                }
                self thread player_monitor_travel_dist();
                self thread player_monitor_time_played();
                if (getdvarint(#"hash_139191929bda93cd", 0) == 1) {
                    self thread zm_breadcrumbs();
                }
                if (isdefined(level.custom_player_track_ammo_count)) {
                    self thread [[ level.custom_player_track_ammo_count ]]();
                } else {
                    self thread player_track_ammo_count();
                }
                self thread zm_utility::shock_onpain();
                self thread player_grenade_watcher();
                self laststand::revive_hud_create();
                if (isdefined(level.zm_gamemodule_spawn_func)) {
                    self thread [[ level.zm_gamemodule_spawn_func ]]();
                }
                self thread player_spawn_protection();
            }
        }
        self notify(#"perks_initialized");
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x503f9b19, Offset: 0x2808
// Size: 0x94
function player_spawn_protection() {
    self endon(#"disconnect");
    self val::set(#"player_spawn_protection", "ignoreme");
    x = 0;
    while (x < 60) {
        x++;
        waitframe(1);
    }
    self val::reset(#"player_spawn_protection", "ignoreme");
}

// Namespace zm_player/zm_player
// Params 3, eflags: 0x0
// Checksum 0x806c5e16, Offset: 0x28a8
// Size: 0x66
function spawn_life_brush(origin, radius, height) {
    life_brush = spawn("trigger_radius", origin, 0, radius, height);
    life_brush.script_noteworthy = "life_brush";
    return life_brush;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0xb13c6df9, Offset: 0x2918
// Size: 0x98
function in_life_brush() {
    life_brushes = getentarray("life_brush", "script_noteworthy");
    if (!isdefined(life_brushes) || !isdefined(self)) {
        return false;
    }
    for (i = 0; i < life_brushes.size; i++) {
        if (self istouching(life_brushes[i])) {
            return true;
        }
    }
    return false;
}

// Namespace zm_player/zm_player
// Params 3, eflags: 0x0
// Checksum 0xdf4a2c5, Offset: 0x29b8
// Size: 0x66
function spawn_kill_brush(origin, radius, height) {
    kill_brush = spawn("trigger_radius", origin, 0, radius, height);
    kill_brush.script_noteworthy = "kill_brush";
    return kill_brush;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x6f5bf02c, Offset: 0x2a28
// Size: 0xa4
function in_kill_brush() {
    kill_brushes = getentarray("kill_brush", "script_noteworthy");
    self.kill_brush = undefined;
    if (!isdefined(kill_brushes)) {
        return false;
    }
    for (i = 0; i < kill_brushes.size; i++) {
        if (self istouching(kill_brushes[i])) {
            self.kill_brush = kill_brushes[i];
            return true;
        }
    }
    return false;
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0xff9a9798, Offset: 0x2ad8
// Size: 0x242
function in_enabled_playable_area(var_f9bb25f4 = 500) {
    zm_zonemgr::wait_zone_flags_updating();
    if (!isdefined(self)) {
        return false;
    }
    if (zm_utility::function_be4cf12d()) {
        if (!isdefined(level.var_4b530519)) {
            level.var_4b530519 = getnodearray("player_region", "script_noteworthy");
        }
        node = function_e910fb8c(self.origin, level.var_4b530519, var_f9bb25f4);
        if (isdefined(node) && zm_zonemgr::zone_is_enabled(node.targetname)) {
            return true;
        }
        queryresult = function_d840de0c(self.origin, 0, self getpathfindingradius(), self function_5c52d4ac() * 0.5, 2, 1, undefined, undefined, level.var_b4c5832b);
        if (queryresult.data.size > 0) {
            return true;
        }
    }
    if (zm_utility::function_a70772a9()) {
        playable_area = getentarray("player_volume", "script_noteworthy");
        if (!isdefined(playable_area)) {
            return false;
        }
        for (i = 0; i < playable_area.size; i++) {
            if (zm_zonemgr::zone_is_enabled(playable_area[i].targetname) && self istouching(playable_area[i])) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x2c744f98, Offset: 0x2d28
// Size: 0x34
function get_player_out_of_playable_area_monitor_wait_time() {
    /#
        if (isdefined(level.check_kill_thread_every_frame) && level.check_kill_thread_every_frame) {
            return 0.05;
        }
    #/
    return 3;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x79c3a81e, Offset: 0x2d68
// Size: 0x390
function player_out_of_playable_area_monitor() {
    self notify(#"stop_player_out_of_playable_area_monitor");
    self endon(#"stop_player_out_of_playable_area_monitor", #"disconnect");
    level endon(#"end_game");
    while (!isdefined(self.characterindex)) {
        waitframe(1);
    }
    wait 0.15 * self.characterindex;
    while (true) {
        if (self.sessionstate == "spectator") {
            wait get_player_out_of_playable_area_monitor_wait_time();
            continue;
        }
        if (isdefined(level.var_c303b23b) && level.var_c303b23b) {
            wait get_player_out_of_playable_area_monitor_wait_time();
            continue;
        }
        if (self.var_fa6d2a24 === 1) {
            wait get_player_out_of_playable_area_monitor_wait_time();
            continue;
        }
        if (!self in_life_brush() && (self in_kill_brush() || !self in_enabled_playable_area() || isdefined(level.player_out_of_playable_area_override) && isdefined(self [[ level.player_out_of_playable_area_override ]]()) && self [[ level.player_out_of_playable_area_override ]]())) {
            if (!isdefined(level.player_out_of_playable_area_monitor_callback) || self [[ level.player_out_of_playable_area_monitor_callback ]]()) {
                /#
                    iprintlnbold("<dev string:x13b>" + self.origin);
                #/
                /#
                    if (isdefined(level.kill_thread_test_mode) && level.kill_thread_test_mode) {
                        wait get_player_out_of_playable_area_monitor_wait_time();
                        continue;
                    }
                    if (self isinmovemode("<dev string:x152>", "<dev string:x156>") || isdefined(level.disable_kill_thread) && level.disable_kill_thread || getdvarint(#"zombie_cheat", 0) > 0) {
                        wait get_player_out_of_playable_area_monitor_wait_time();
                        continue;
                    }
                #/
                self zm_stats::increment_map_cheat_stat("cheat_out_of_playable");
                self zm_stats::increment_client_stat("cheat_out_of_playable", 0);
                self zm_stats::increment_client_stat("cheat_total", 0);
                self playlocalsound(#"zmb_player_outofbounds");
                if (self.health <= 50) {
                    self zm_laststand::function_7996dd34(0);
                    self.bleedout_time = 0;
                }
                self dodamage(50, self.origin);
            }
        }
        wait get_player_out_of_playable_area_monitor_wait_time();
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x68e2e98, Offset: 0x3100
// Size: 0x8
function function_201bdf19() {
    return 3;
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0xecf81b90, Offset: 0x3110
// Size: 0x12e
function function_7cbf152c(var_2dbc495) {
    self endon(#"hash_765a487a00a06e37");
    self waittill(#"player_downed", #"replace_weapon_powerup");
    for (i = 0; i < var_2dbc495.size; i++) {
        self takeweapon(var_2dbc495[i]);
    }
    self zm_score::player_reduce_points("take_all");
    self zm_loadout::give_start_weapon(0);
    if (!self laststand::player_is_in_laststand()) {
        self zm_utility::decrement_is_drinking();
    } else if (level flag::get("solo_game")) {
        self.score_lost_when_downed = 0;
    }
    self notify(#"hash_765a487a00a06e37");
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0xebe5ee70, Offset: 0x3248
// Size: 0x1ce
function function_b730d298(var_2dbc495) {
    self thread function_7cbf152c(var_2dbc495);
    self endon(#"player_downed", #"replace_weapon_powerup");
    self zm_utility::increment_is_drinking();
    var_166fb977 = zm_utility::round_up_to_ten(int(self.score / (var_2dbc495.size + 1)));
    for (i = 0; i < var_2dbc495.size; i++) {
        self playlocalsound(level.zmb_laugh_alias);
        self switchtoweapon(var_2dbc495[i]);
        self zm_score::player_reduce_points("take_specified", var_166fb977);
        wait 3;
        self takeweapon(var_2dbc495[i]);
    }
    self playlocalsound(level.zmb_laugh_alias);
    self zm_score::player_reduce_points("take_all");
    wait 1;
    self zm_loadout::give_start_weapon(1);
    self zm_utility::decrement_is_drinking();
    self notify(#"hash_765a487a00a06e37");
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x22188423, Offset: 0x3420
// Size: 0x330
function function_67a71cec() {
    self notify(#"hash_7ef674ea24701fbb");
    self endon(#"hash_7ef674ea24701fbb", #"disconnect");
    level endon(#"end_game");
    scalar = self.characterindex;
    if (!isdefined(scalar)) {
        scalar = self getentitynumber();
    }
    wait 0.15 * scalar;
    while (true) {
        if (self zm_loadout::has_powerup_weapon() || self laststand::player_is_in_laststand() || self.sessionstate == "spectator" || isdefined(self.laststandpistol)) {
            wait function_201bdf19();
            continue;
        }
        /#
            if (getdvarint(#"zombie_cheat", 0) > 0) {
                wait function_201bdf19();
                continue;
            }
        #/
        weapon_limit = zm_utility::get_player_weapon_limit(self);
        primaryweapons = self getweaponslistprimaries();
        if (primaryweapons.size > weapon_limit) {
            self zm_weapons::take_fallback_weapon();
            primaryweapons = self getweaponslistprimaries();
        }
        var_2dbc495 = [];
        for (i = 0; i < primaryweapons.size; i++) {
            if (zm_weapons::is_weapon_included(primaryweapons[i]) || zm_weapons::is_weapon_upgraded(primaryweapons[i])) {
                var_2dbc495[var_2dbc495.size] = primaryweapons[i];
            }
        }
        if (var_2dbc495.size > weapon_limit) {
            if (!isdefined(level.var_9abdcf26) || self [[ level.var_9abdcf26 ]](var_2dbc495)) {
                self zm_stats::increment_map_cheat_stat("cheat_too_many_weapons");
                self zm_stats::increment_client_stat("cheat_too_many_weapons", 0);
                self zm_stats::increment_client_stat("cheat_total", 0);
                self thread function_b730d298(var_2dbc495);
                self waittill(#"hash_765a487a00a06e37");
            }
        }
        wait function_201bdf19();
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x902e0329, Offset: 0x3758
// Size: 0xb6
function player_monitor_travel_dist() {
    self notify(#"stop_player_monitor_travel_dist");
    self endon(#"stop_player_monitor_travel_dist", #"disconnect");
    for (prevpos = self.origin; true; prevpos = self.origin) {
        wait 0.1;
        self.pers[#"distance_traveled"] = self.pers[#"distance_traveled"] + distance(self.origin, prevpos);
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0xd5e437a0, Offset: 0x3818
// Size: 0x78
function player_monitor_time_played() {
    self notify(#"stop_player_monitor_time_played");
    self endon(#"stop_player_monitor_time_played", #"disconnect");
    level flag::wait_till("start_zombie_round_logic");
    for (;;) {
        wait 1;
        zm_stats::increment_client_stat("time_played_total");
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x25377c14, Offset: 0x3898
// Size: 0xbe
function zm_breadcrumbs() {
    self endon(#"disconnect");
    level endon(#"end_game");
    waittime = getdvarfloat(#"hash_46009edd5032b8cc", 2);
    level flag::wait_till("start_zombie_round_logic");
    while (true) {
        if (isalive(self)) {
            recordbreadcrumbdataforplayer(self);
        }
        wait waittime;
    }
}

// Namespace zm_player/zm_player
// Params 2, eflags: 0x0
// Checksum 0xa87b2949, Offset: 0x3960
// Size: 0x36a
function player_grenade_multiattack_bookmark_watcher(grenade, weapon) {
    self endon(#"disconnect");
    waittillframeend();
    if (!isdefined(grenade)) {
        return;
    }
    inflictorentnum = grenade getentitynumber();
    inflictorenttype = grenade getentitytype();
    inflictorbirthtime = 0;
    if (isdefined(grenade.birthtime)) {
        inflictorbirthtime = grenade.birthtime;
    }
    killcam_entity_info = killcam::get_killcam_entity_info(self, grenade, weapon);
    einflictor = grenade;
    ret_val = grenade waittilltimeout(15, #"explode", #"death", #"disconnect");
    if (!isdefined(self) || isdefined(ret_val) && "timeout" == ret_val._notify) {
        return;
    }
    self.grenade_multiattack_count = 0;
    self.grenade_multiattack_ent = undefined;
    self.grenade_multikill_count = 0;
    waittillframeend();
    if (!isdefined(self)) {
        return;
    }
    count = level.grenade_multiattack_bookmark_count;
    if (isdefined(grenade.grenade_multiattack_bookmark_count) && grenade.grenade_multiattack_bookmark_count) {
        count = grenade.grenade_multiattack_bookmark_count;
    }
    var_bc570fbd = #"zm_player_grenade_multiattack";
    if (isdefined(grenade.use_grenade_special_long_bookmark) && grenade.use_grenade_special_long_bookmark) {
        var_bc570fbd = #"zm_player_grenade_special_long";
    } else if (isdefined(grenade.use_grenade_special_bookmark) && grenade.use_grenade_special_bookmark) {
        var_bc570fbd = #"zm_player_grenade_special_long";
    }
    if (count <= self.grenade_multiattack_count && isdefined(self.grenade_multiattack_ent)) {
        deathtime = gettime();
        perks = [];
        killstreaks = [];
        demo::bookmark(var_bc570fbd, gettime(), self, undefined, 0);
        potm::bookmark(var_bc570fbd, gettime(), self, undefined, 0);
        potm::function_da7a6757(var_bc570fbd, self getentitynumber(), self getxuid(), self.grenade_multiattack_ent, killcam_entity_info, weapon, "MOD_GRENADE", deathtime, 0, 0, perks, killstreaks, self, einflictor);
    }
    if (5 <= self.grenade_multikill_count) {
        self zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_EXPLOSION_MULTIKILL");
    }
    self.grenade_multiattack_count = 0;
    self.grenade_multikill_count = 0;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0xe40563c, Offset: 0x3cd8
// Size: 0x118
function player_grenade_watcher() {
    self notify(#"stop_player_grenade_watcher");
    self endon(#"stop_player_grenade_watcher", #"disconnect");
    self.grenade_multiattack_count = 0;
    self.grenade_multikill_count = 0;
    while (true) {
        waitresult = self waittill(#"grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        if (isdefined(grenade) && isalive(grenade)) {
            grenade.team = self.team;
        }
        self thread player_grenade_multiattack_bookmark_watcher(grenade, weapon);
        if (isdefined(level.grenade_watcher)) {
            self [[ level.grenade_watcher ]](grenade, weapon);
        }
    }
}

// Namespace zm_player/zm_player
// Params 10, eflags: 0x0
// Checksum 0xdbc76e94, Offset: 0x3df8
// Size: 0x2e8
function player_prevent_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isai(eattacker) && self.ignoreme && smeansofdeath === "MOD_MELEE") {
        return true;
    }
    /#
        if (isai(eattacker) && self.ignoreme) {
            println("<dev string:x15d>" + function_15979fa9(eattacker.archetype) + "<dev string:x194>" + smeansofdeath);
        }
        if (isdefined(self.bgb_in_plain_sight_active) && self.bgb_in_plain_sight_active) {
            str = "<dev string:x19b>";
            if (isai(eattacker)) {
                str += function_15979fa9(eattacker.archetype);
            } else if (isdefined(eattacker)) {
                str = str + "<dev string:x1c8>" + eattacker getentitynumber();
            } else {
                str += "<dev string:x1d0>";
            }
            println(str);
            println("<dev string:x1e6>" + (isdefined(self.ignoreme) && self.ignoreme ? "<dev string:x1fb>" : "<dev string:x200>"));
            println("<dev string:x206>" + smeansofdeath);
            println("<dev string:x218>" + idamage + "<dev string:x21d>");
        }
    #/
    if (!isdefined(einflictor) || !isdefined(eattacker)) {
        return false;
    }
    if (einflictor == self || eattacker == self) {
        return false;
    }
    if (isdefined(einflictor) && isdefined(einflictor.team)) {
        if (!(isdefined(einflictor.damage_own_team) && einflictor.damage_own_team)) {
            if (einflictor.team == self.team) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x1306707, Offset: 0x40e8
// Size: 0x290
function player_revive_monitor() {
    self notify(#"stop_player_revive_monitor");
    self endon(#"stop_player_revive_monitor", #"disconnect");
    while (true) {
        waitresult = self waittill(#"player_revived");
        reviver = waitresult.reviver;
        self playsoundtoplayer(#"zmb_character_revived", self);
        if (isdefined(level.isresetting_grief) && level.isresetting_grief) {
            continue;
        }
        if (isdefined(reviver)) {
            if (reviver != self) {
                if (math::cointoss()) {
                    self zm_audio::create_and_play_dialog("revive", "up");
                } else {
                    reviver zm_audio::create_and_play_dialog("revive", "support");
                }
            } else {
                self zm_audio::create_and_play_dialog("revive", "up");
            }
            points = self.score_lost_when_downed;
            if (!isdefined(points) || self == reviver || zm_custom::function_5638f689(#"zmpointlossondown")) {
                points = 0;
            } else if (points > 2500) {
                points = 2500 + (points - 2500) * 0.5;
            }
            println("<dev string:x225>" + points);
            reviver zm_score::player_add_points("reviver", points);
            self.score_lost_when_downed = 0;
            if (isplayer(reviver) && reviver != self) {
                reviver zm_stats::increment_challenge_stat("SURVIVALIST_REVIVE");
                reviver zm_callings::function_7cafbdd3(23);
            }
        }
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x18daf822, Offset: 0x4380
// Size: 0x26e
function spawnspectator() {
    self endon(#"disconnect", #"spawned_spectator");
    self notify(#"spawned");
    self notify(#"end_respawn");
    if (level.intermission) {
        return;
    }
    if (isdefined(level.no_spectator) && level.no_spectator) {
        wait 3;
        exitlevel();
    }
    self.is_zombie = 1;
    self notify(#"zombified");
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    self.zombification_time = gettime();
    resettimeout();
    self stopshellshock();
    self stoprumble("damage_heavy");
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.maxhealth = self.health;
    self.shellshocked = 0;
    self.inwater = 0;
    self.friendlydamage = undefined;
    self.hasspawned = 1;
    self.spawntime = gettime();
    self.afk = 0;
    println("<dev string:x242>");
    self detachall();
    if (isdefined(level.var_586a584f)) {
        self [[ level.var_586a584f ]]();
    } else {
        self setspectatepermissions(1);
    }
    self thread function_128dd783();
    self spawn(self.origin, self.angles);
    self notify(#"spawned_spectator");
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0x6d7e2045, Offset: 0x45f8
// Size: 0xcc
function setspectatepermissions(ison) {
    self allowspectateteam(#"allies", ison && self.team == #"allies");
    self allowspectateteam(#"axis", ison && self.team == #"axis");
    self allowspectateteam("freelook", 0);
    self allowspectateteam("none", 0);
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x58c1f4e3, Offset: 0x46d0
// Size: 0x28
function function_128dd783() {
    self endon(#"disconnect", #"spawned_player");
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x234edafa, Offset: 0x4700
// Size: 0x44
function spectator_toggle_3rd_person() {
    self endon(#"disconnect", #"spawned_player");
    self set_third_person(1);
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0x538d343b, Offset: 0x4750
// Size: 0x8c
function set_third_person(value) {
    if (value) {
        self setclientthirdperson(1);
        self setclientthirdpersonangle(354);
    } else {
        self setclientthirdperson(0);
        self setclientthirdpersonangle(0);
    }
    self resetfov();
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x1dfa4245, Offset: 0x47e8
// Size: 0x156
function last_stand_revive() {
    level endon(#"between_round_over");
    players = getplayers();
    laststand_count = 0;
    foreach (player in players) {
        if (!zm_utility::is_player_valid(player)) {
            laststand_count++;
        }
    }
    if (laststand_count == players.size) {
        for (i = 0; i < players.size; i++) {
            if (players[i] laststand::player_is_in_laststand() && players[i].revivetrigger.beingrevived == 0) {
                players[i] zm_laststand::auto_revive(players[i]);
            }
        }
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x2cdf279, Offset: 0x4948
// Size: 0x100
function spectators_respawn() {
    level endon(#"between_round_over");
    level endon(#"end_game");
    if (!isdefined(zombie_utility::get_zombie_var(#"spectators_respawn")) || !zombie_utility::get_zombie_var(#"spectators_respawn")) {
        return;
    }
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            e_player = players[i];
            e_player spectator_respawn_player();
        }
        wait 1;
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x67c5667e, Offset: 0x4a50
// Size: 0xda
function spectator_respawn_player() {
    if (self.sessionstate == "spectator" && isdefined(self.spectator_respawn)) {
        if (!isdefined(level.custom_spawnplayer)) {
            level.custom_spawnplayer = &spectator_respawn;
        }
        self [[ level.spawnplayer ]]();
        if (isdefined(level.script) && level.round_number > 6 && self.score < 1500) {
            self.old_score = self.score;
            if (isdefined(level.var_f30bf142)) {
                self [[ level.var_f30bf142 ]]();
            }
            self.score = 1500;
        }
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x4c6a513e, Offset: 0x4b38
// Size: 0x2c8
function spectator_respawn() {
    println("<dev string:x26f>");
    assert(isdefined(self.spectator_respawn));
    origin = self.spectator_respawn.origin;
    angles = self.spectator_respawn.angles;
    self setspectatepermissions(0);
    new_origin = undefined;
    if (isdefined(level.var_75eda423)) {
        new_origin = [[ level.var_75eda423 ]](self);
    }
    if (!isdefined(new_origin)) {
        new_origin = check_for_valid_spawn_near_team(self, 1);
    }
    if (isdefined(new_origin)) {
        if (!isdefined(new_origin.angles)) {
            angles = (0, 0, 0);
        } else {
            angles = new_origin.angles;
        }
        self spawn(new_origin.origin, angles);
    } else {
        self spawn(origin, angles);
    }
    if (isdefined(self zm_loadout::get_player_placeable_mine())) {
        self takeweapon(self zm_loadout::get_player_placeable_mine());
        self zm_loadout::set_player_placeable_mine(level.weaponnone);
    }
    self zm_equipment::take();
    self.is_burning = undefined;
    self.abilities = [];
    self.is_zombie = 0;
    val::reset(#"laststand", "ignoreme");
    self clientfield::set("zmbLastStand", 0);
    self reviveplayer();
    if (isdefined(level._zombiemode_post_respawn_callback)) {
        self thread [[ level._zombiemode_post_respawn_callback ]]();
    }
    self zm_score::player_reduce_points("died");
    self zm_melee_weapon::spectator_respawn_all();
    self thread zm_perks::function_87304102();
    return true;
}

// Namespace zm_player/zm_player
// Params 2, eflags: 0x0
// Checksum 0xf5f755f6, Offset: 0x4e08
// Size: 0x2f2
function check_for_valid_spawn_near_team(revivee, return_struct) {
    if (isdefined(level.check_for_valid_spawn_near_team_callback)) {
        spawn_location = [[ level.check_for_valid_spawn_near_team_callback ]](revivee, return_struct);
        return spawn_location;
    }
    players = getplayers();
    spawn_points = zm_gametype::get_player_spawns_for_gametype();
    closest_group = undefined;
    closest_distance = 100000000;
    backup_group = undefined;
    backup_distance = 100000000;
    if (spawn_points.size == 0) {
        return undefined;
    }
    a_enabled_zone_entities = zm_zonemgr::get_active_zones_entities();
    for (i = 0; i < players.size; i++) {
        if (zm_utility::is_player_valid(players[i], undefined, 1) && (players[i] != self || players.size == 1)) {
            for (j = 0; j < spawn_points.size; j++) {
                if (isdefined(spawn_points[j].script_int)) {
                    ideal_distance = spawn_points[j].script_int;
                } else {
                    ideal_distance = 1000;
                }
                if (zm_utility::check_point_in_enabled_zone(spawn_points[j].origin, 0, a_enabled_zone_entities) == 0) {
                    continue;
                }
                if (spawn_points[j].locked == 0) {
                    plyr_dist = distancesquared(players[i].origin, spawn_points[j].origin);
                    if (plyr_dist < ideal_distance * ideal_distance) {
                        if (plyr_dist < closest_distance) {
                            closest_distance = plyr_dist;
                            closest_group = j;
                        }
                        continue;
                    }
                    if (plyr_dist < backup_distance) {
                        backup_group = j;
                        backup_distance = plyr_dist;
                    }
                }
            }
        }
        if (!isdefined(closest_group)) {
            closest_group = backup_group;
        }
        if (isdefined(closest_group)) {
            spawn_location = get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct);
            if (isdefined(spawn_location)) {
                return spawn_location;
            }
        }
    }
    return undefined;
}

// Namespace zm_player/zm_player
// Params 4, eflags: 0x0
// Checksum 0xab8e5132, Offset: 0x5108
// Size: 0x2f2
function get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct) {
    spawn_array = struct::get_array(spawn_points[closest_group].target, "targetname");
    if (level flag::get("round_reset")) {
        spawn_point_index = revivee getentitynumber();
        assert(spawn_point_index >= 0 && spawn_point_index < spawn_array.size);
        if (isdefined(return_struct) && return_struct) {
            return spawn_array[spawn_point_index];
        } else {
            return spawn_array[spawn_point_index].origin;
        }
    }
    spawn_array = array::randomize(spawn_array);
    for (k = 0; k < spawn_array.size; k++) {
        if (isdefined(spawn_array[k].plyr) && spawn_array[k].plyr == revivee getentitynumber()) {
            if (positionwouldtelefrag(spawn_array[k].origin)) {
                spawn_array[k].plyr = undefined;
                break;
            }
            if (isdefined(return_struct) && return_struct) {
                return spawn_array[k];
            }
            return spawn_array[k].origin;
        }
    }
    for (k = 0; k < spawn_array.size; k++) {
        if (positionwouldtelefrag(spawn_array[k].origin)) {
            continue;
        }
        if (!isdefined(spawn_array[k].plyr) || spawn_array[k].plyr == revivee getentitynumber()) {
            spawn_array[k].plyr = revivee getentitynumber();
            if (isdefined(return_struct) && return_struct) {
                return spawn_array[k];
            }
            return spawn_array[k].origin;
        }
    }
    if (isdefined(return_struct) && return_struct) {
        return spawn_array[0];
    }
    return spawn_array[0].origin;
}

// Namespace zm_player/zm_player
// Params 3, eflags: 0x0
// Checksum 0x9a5e7645, Offset: 0x5408
// Size: 0x1d6
function check_for_valid_spawn_near_position(revivee, v_position, return_struct) {
    spawn_points = zm_gametype::get_player_spawns_for_gametype();
    if (spawn_points.size == 0) {
        return undefined;
    }
    closest_group = undefined;
    closest_distance = 100000000;
    backup_group = undefined;
    backup_distance = 100000000;
    for (i = 0; i < spawn_points.size; i++) {
        if (isdefined(spawn_points[i].script_int)) {
            ideal_distance = spawn_points[i].script_int;
        } else {
            ideal_distance = 1000;
        }
        if (spawn_points[i].locked == 0) {
            dist = distancesquared(v_position, spawn_points[i].origin);
            if (dist < ideal_distance * ideal_distance) {
                if (dist < closest_distance) {
                    closest_distance = dist;
                    closest_group = i;
                }
            } else if (dist < backup_distance) {
                backup_group = i;
                backup_distance = dist;
            }
        }
        if (!isdefined(closest_group)) {
            closest_group = backup_group;
        }
    }
    if (isdefined(closest_group)) {
        spawn_location = get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct);
        if (isdefined(spawn_location)) {
            return spawn_location;
        }
    }
    return undefined;
}

// Namespace zm_player/zm_player
// Params 5, eflags: 0x0
// Checksum 0xd663ae18, Offset: 0x55e8
// Size: 0x166
function check_for_valid_spawn_within_range(revivee, v_position, return_struct, min_distance, max_distance) {
    spawn_points = zm_gametype::get_player_spawns_for_gametype();
    if (spawn_points.size == 0) {
        return undefined;
    }
    closest_group = undefined;
    closest_distance = 100000000;
    for (i = 0; i < spawn_points.size; i++) {
        if (spawn_points[i].locked == 0) {
            dist = distance(v_position, spawn_points[i].origin);
            if (dist >= min_distance && dist <= max_distance) {
                if (dist < closest_distance) {
                    closest_distance = dist;
                    closest_group = i;
                }
            }
        }
    }
    if (isdefined(closest_group)) {
        spawn_location = get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct);
        if (isdefined(spawn_location)) {
            return spawn_location;
        }
    }
    return undefined;
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0x4c42b8a0, Offset: 0x5758
// Size: 0xc8
function get_players_on_team(exclude) {
    teammates = [];
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i].spawn_side == self.spawn_side && !isdefined(players[i].revivetrigger) && players[i] != exclude) {
            teammates[teammates.size] = players[i];
        }
    }
    return teammates;
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0x8ba9d977, Offset: 0x5828
// Size: 0x164
function get_safe_breadcrumb_pos(player) {
    players = getplayers();
    valid_players = [];
    for (i = 0; i < players.size; i++) {
        if (!zm_utility::is_player_valid(players[i])) {
            continue;
        }
        valid_players[valid_players.size] = players[i];
    }
    for (i = 0; i < valid_players.size; i++) {
        count = 0;
        for (q = 1; q < player.zombie_breadcrumbs.size; q++) {
            if (distancesquared(player.zombie_breadcrumbs[q], valid_players[i].origin) < 22500) {
                continue;
            }
            count++;
            if (count == valid_players.size) {
                return player.zombie_breadcrumbs[q];
            }
        }
    }
    return undefined;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0xf90fcc9f, Offset: 0x5998
// Size: 0x17c
function play_door_dialog() {
    self endon(#"warning_dialog");
    timer = 0;
    while (true) {
        waitframe(1);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            dist = distancesquared(players[i].origin, self.origin);
            if (dist > 4900) {
                timer = 0;
                continue;
            }
            while (dist < 4900 && timer < 3) {
                wait 0.5;
                timer++;
            }
            if (dist > 4900 && timer >= 3) {
                self playsound(#"door_deny");
                players[i] zm_audio::create_and_play_dialog("general", "outofmoney");
                wait 3;
                self notify(#"warning_dialog");
            }
        }
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0xa50c2460, Offset: 0x5b20
// Size: 0x6e
function remove_ignore_attacker() {
    self notify(#"new_ignore_attacker");
    self endon(#"new_ignore_attacker", #"disconnect");
    if (!isdefined(level.ignore_enemy_timer)) {
        level.ignore_enemy_timer = 0.4;
    }
    wait level.ignore_enemy_timer;
    self.ignoreattacker = undefined;
}

// Namespace zm_player/zm_player
// Params 10, eflags: 0x0
// Checksum 0xf744bcd7, Offset: 0x5b98
// Size: 0x8e
function player_damage_override_cheat(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    return false;
}

// Namespace zm_player/zm_player
// Params 10, eflags: 0x0
// Checksum 0xd36a06ac, Offset: 0x5c30
// Size: 0xd5a
function player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    idamage = self check_player_damage_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    if (self.scene_takedamage === 0) {
        return 0;
    }
    if (isdefined(eattacker) && isdefined(eattacker.b_aat_fire_works_weapon) && eattacker.b_aat_fire_works_weapon) {
        return 0;
    }
    if (isdefined(self.use_adjusted_grenade_damage) && self.use_adjusted_grenade_damage) {
        self.use_adjusted_grenade_damage = undefined;
        if (self.health > idamage) {
            return idamage;
        }
    }
    if (!idamage) {
        return 0;
    }
    if (self laststand::player_is_in_laststand()) {
        return 0;
    }
    if (isdefined(einflictor)) {
        if (isdefined(einflictor.water_damage) && einflictor.water_damage) {
            return 0;
        }
    }
    if (isdefined(eattacker)) {
        if (eattacker.owner === self) {
            return 0;
        }
        if (isdefined(self.ignoreattacker) && self.ignoreattacker == eattacker) {
            return 0;
        }
        if (isdefined(self.is_zombie) && self.is_zombie && isdefined(eattacker.is_zombie) && eattacker.is_zombie) {
            return 0;
        }
        if (isdefined(eattacker.is_zombie) && eattacker.is_zombie) {
            self.ignoreattacker = eattacker;
            self thread remove_ignore_attacker();
            if (isdefined(eattacker.custom_damage_func)) {
                idamage = eattacker [[ eattacker.custom_damage_func ]](self);
            }
        }
        eattacker notify(#"hit_player");
        if (isdefined(eattacker) && isdefined(eattacker.func_mod_damage_override)) {
            smeansofdeath = eattacker [[ eattacker.func_mod_damage_override ]](einflictor, smeansofdeath, weapon);
        }
        if (smeansofdeath != "MOD_FALLING") {
            if (isdefined(eattacker.is_zombie) && eattacker.is_zombie || isplayer(eattacker)) {
                self playrumbleonentity("damage_heavy");
            }
            if (isdefined(eattacker.is_zombie) && eattacker.is_zombie) {
                self zm_audio::create_and_play_dialog("general", "attacked");
            }
            if (randomintrange(0, 1) == 0) {
                self thread zm_audio::playerexert("hitmed");
            } else {
                self thread zm_audio::playerexert("hitlrg");
            }
        }
    }
    if (isdefined(smeansofdeath) && smeansofdeath == "MOD_DROWN") {
        self thread zm_audio::playerexert("drowning", 1);
        self.voxdrowning = 1;
    }
    if (isdefined(level.perk_damage_override)) {
        foreach (func in level.perk_damage_override) {
            n_damage = self [[ func ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
            if (isdefined(n_damage)) {
                idamage = n_damage;
            }
        }
    }
    if (zm_loadout::is_placeable_mine(weapon)) {
        return 0;
    }
    if (isdefined(self.player_damage_override)) {
        self thread [[ self.player_damage_override ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    }
    if (isdefined(einflictor) && isdefined(einflictor.archetype) && einflictor.archetype == "zombie_quad") {
        if (smeansofdeath == "MOD_EXPLOSIVE") {
            if (self.health > 75) {
                return 75;
            }
        }
    }
    if (smeansofdeath == "MOD_SUICIDE" && self bgb::is_enabled(#"zm_bgb_danger_closest")) {
        return 0;
    }
    if (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE") {
        if (self bgb::is_enabled(#"zm_bgb_danger_closest")) {
            return 0;
        }
        if (!(isdefined(self.is_zombie) && self.is_zombie)) {
            if (!isdefined(eattacker) || !(isdefined(eattacker.is_zombie) && eattacker.is_zombie) && !(isdefined(eattacker.b_override_explosive_damage_cap) && eattacker.b_override_explosive_damage_cap)) {
                if (isdefined(weapon.name) && (weapon.name == #"ray_gun" || weapon.name == #"ray_gun_upgraded")) {
                    if (self.health > 25 && idamage > 25) {
                        return 25;
                    }
                } else if (self.health > 75 && idamage > 75) {
                    return 75;
                }
            }
        }
    }
    idamage = self zm_utility::damage_armor(idamage, smeansofdeath, eattacker);
    if (isdefined(level.var_125645fc)) {
        for (i = 0; i < level.var_125645fc.size; i++) {
            var_37b88152 = self [[ level.var_125645fc[i] ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
            if (-1 != var_37b88152) {
                idamage = var_37b88152;
            }
        }
    }
    finaldamage = idamage;
    if (idamage < self.health) {
        if (isdefined(eattacker)) {
            if (isdefined(level.custom_kill_damaged_vo)) {
                eattacker thread [[ level.custom_kill_damaged_vo ]](self);
            } else {
                eattacker.sound_damage_player = self;
            }
            if (isdefined(eattacker.missinglegs) && eattacker.missinglegs) {
                self zm_audio::create_and_play_dialog("general", "crawl_hit");
            }
        }
        return idamage;
    }
    if (isdefined(level.player_death_override) && self [[ level.player_death_override ]]()) {
        return 0;
    }
    if (isdefined(eattacker)) {
        self zm_stats::handle_death(einflictor, eattacker, weapon, smeansofdeath);
    }
    self thread clear_path_timers();
    if (level.intermission) {
        level waittill(#"forever");
    }
    if (level.scr_zm_ui_gametype == "zcleansed" && idamage > 0) {
        if (isdefined(eattacker) && isplayer(eattacker) && eattacker.team != self.team && (!(isdefined(self.laststand) && self.laststand) && !self laststand::player_is_in_laststand() || !isdefined(self.last_player_attacker))) {
            if (isdefined(eattacker.maxhealth) && isdefined(eattacker.is_zombie) && eattacker.is_zombie) {
                eattacker.health = eattacker.maxhealth;
            }
            if (isdefined(level.player_kills_player)) {
                self thread [[ level.player_kills_player ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
            }
        }
    }
    if (self hasperk(#"specialty_whoswho") && self zm_laststand::function_d75050c0() > 0) {
        self zm_laststand::function_edd56797();
        if (isdefined(level.whoswho_laststand_func)) {
            self thread [[ level.whoswho_laststand_func ]]();
            return 0;
        }
    }
    if (self zm_laststand::function_d75050c0() > 0) {
        var_b89b38ab = 1;
    } else {
        var_b89b38ab = function_46ac3ba0(self);
    }
    if (var_b89b38ab || zm_utility::function_322da1e0()) {
        return finaldamage;
    }
    if (isdefined(level.var_63f29efd) && [[ level.var_63f29efd ]](self)) {
        return finaldamage;
    }
    if (getplayers().size == 1 && level flag::get("solo_game")) {
        if (isdefined(level.var_4cf8bbbd) && [[ level.var_4cf8bbbd ]]()) {
            return finaldamage;
        } else {
            self.intermission = 1;
        }
    }
    level notify(#"stop_suicide_trigger");
    self allowprone(1);
    self thread zm_laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    if (!isdefined(vdir)) {
        vdir = (1, 0, 0);
    }
    self fakedamagefrom(vdir);
    level notify(#"last_player_died");
    if (isdefined(level.custom_player_fake_death)) {
        self thread [[ level.custom_player_fake_death ]](vdir, smeansofdeath);
    } else {
        self thread player_fake_death();
    }
    level notify(#"pre_end_game");
    util::wait_network_frame();
    if (level flag::get("dog_round")) {
        zm::increment_dog_round_stat("lost");
    }
    level notify(#"end_game");
    return 0;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0xd0c07069, Offset: 0x6998
// Size: 0xb6
function clear_path_timers() {
    zombies = getaiteamarray(level.zombie_team);
    foreach (zombie in zombies) {
        if (isdefined(zombie.favoriteenemy) && zombie.favoriteenemy == self) {
            zombie.zombie_path_timer = 0;
        }
    }
}

// Namespace zm_player/zm_player
// Params 10, eflags: 0x0
// Checksum 0x990eb0, Offset: 0x6a58
// Size: 0x172
function check_player_damage_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isdefined(level.var_dfd138e3)) {
        for (i = 0; i < level.var_dfd138e3.size; i++) {
            newdamage = self [[ level.var_dfd138e3[i] ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
            if (-1 != newdamage) {
                return newdamage;
            }
        }
    }
    if (isdefined(level.player_damage_callbacks)) {
        for (i = 0; i < level.player_damage_callbacks.size; i++) {
            newdamage = self [[ level.player_damage_callbacks[i] ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
            if (-1 != newdamage) {
                return newdamage;
            }
        }
    }
    return idamage;
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0x6a8bea2d, Offset: 0x6bd8
// Size: 0x46
function function_ae6c9a30(func) {
    if (!isdefined(level.var_dfd138e3)) {
        level.var_dfd138e3 = [];
    }
    level.var_dfd138e3[level.var_dfd138e3.size] = func;
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0x3b499527, Offset: 0x6c28
// Size: 0x46
function register_player_damage_callback(func) {
    if (!isdefined(level.player_damage_callbacks)) {
        level.player_damage_callbacks = [];
    }
    level.player_damage_callbacks[level.player_damage_callbacks.size] = func;
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0x290c379c, Offset: 0x6c78
// Size: 0x46
function function_c78e5a5(func) {
    if (!isdefined(level.var_125645fc)) {
        level.var_125645fc = [];
    }
    level.var_125645fc[level.var_125645fc.size] = func;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x992d83cb, Offset: 0x6cc8
// Size: 0x12c
function player_fake_death() {
    level notify(#"fake_death");
    self notify(#"fake_death");
    self takeallweapons();
    self allowstand(0);
    self allowcrouch(0);
    self allowprone(1);
    self allowsprint(0);
    self val::set(#"fake_death", "ignoreme", 1);
    self val::set(#"fake_death", "takedamage", 0);
    wait 1;
    self val::set(#"fake_death", "freezecontrols", 1);
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0xd99120b1, Offset: 0x6e00
// Size: 0x4c
function player_exit_level() {
    self allowstand(1);
    self allowcrouch(0);
    self allowprone(0);
}

// Namespace zm_player/zm_player
// Params 9, eflags: 0x0
// Checksum 0x3136e536, Offset: 0x6e58
// Size: 0x64
function player_killed_override(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    level waittill(#"forever");
}

// Namespace zm_player/zm_player
// Params 3, eflags: 0x0
// Checksum 0x7ab4d262, Offset: 0x6ec8
// Size: 0x4a
function screen_fade_in(n_time, v_color, str_menu_id) {
    lui::screen_fade(n_time, 0, 1, v_color, 0, str_menu_id);
    wait n_time;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0xae4c1a3, Offset: 0x6f20
// Size: 0x434
function player_intermission() {
    self closeingamemenu();
    self closemenu("StartMenu_Main");
    self notify(#"player_intermission");
    self endon(#"player_intermission", #"disconnect", #"death");
    level endon(#"stop_intermission");
    self notify(#"_zombie_game_over");
    if (!isdefined(self.score_total)) {
        self.score_total = 0;
    }
    self.score = self.score_total;
    points = struct::get_array("intermission", "targetname");
    if (!isdefined(points) || points.size == 0) {
        points = getentarray("info_intermission", "classname");
        if (points.size < 1) {
            println("<dev string:x29d>");
            return;
        }
    }
    if (isdefined(level.b_show_single_intermission) && level.b_show_single_intermission) {
        a_s_temp_points = array::randomize(points);
        points = [];
        points[0] = array::random(a_s_temp_points);
    } else {
        points = array::randomize(points);
    }
    self zm_utility::create_streamer_hint(points[0].origin, points[0].angles, 0.9);
    wait 5;
    self lui::screen_fade_out(1);
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    if (isdefined(level.player_intemission_spawn_callback)) {
        self thread [[ level.player_intemission_spawn_callback ]](points[0].origin, points[0].angles);
    }
    while (true) {
        for (i = 0; i < points.size; i++) {
            point = points[i];
            nextpoint = points[i + 1];
            self setorigin(point.origin);
            self setplayerangles(point.angles);
            wait 0.15;
            self notify(#"player_intermission_spawned");
            if (isdefined(nextpoint)) {
                self zm_utility::create_streamer_hint(nextpoint.origin, nextpoint.angles, 0.9);
                self screen_fade_in(2);
                wait 3;
                self lui::screen_fade_out(2);
                continue;
            }
            self screen_fade_in(2);
            if (points.size == 1) {
                return;
            }
        }
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x3fa3a4cb, Offset: 0x7360
// Size: 0x8c
function zm_on_player_connect() {
    if (level.var_46df529e) {
        self setclientuivisibilityflag("hud_visible", 1);
        self setclientuivisibilityflag("weapon_hud_visible", 1);
    }
    self thread watchdisconnect();
    self.hitsoundtracker = 1;
    thread update_is_player_valid();
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x73f8
// Size: 0x4
function function_ea9f4cdf() {
    
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x2a1c546, Offset: 0x7408
// Size: 0x4c
function watchdisconnect() {
    self notify(#"watchdisconnect");
    self endon(#"watchdisconnect");
    self waittill(#"disconnect");
    function_ea9f4cdf();
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x7c8f6561, Offset: 0x7460
// Size: 0x8c
function zm_on_player_spawned() {
    self setperk("specialty_sprint");
    self setperk("specialty_sprintreload");
    self setperk("specialty_slide");
    thread zm_utility::update_zone_name();
    self thread function_644aea5c();
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x66eecc43, Offset: 0x74f8
// Size: 0x6c
function update_is_player_valid() {
    self notify("6c77f45dcb6f2112");
    self endon("6c77f45dcb6f2112");
    self endon(#"disconnect");
    self.am_i_valid = 0;
    while (isdefined(self)) {
        self.am_i_valid = zm_utility::is_player_valid(self, 1);
        waitframe(1);
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x119a7949, Offset: 0x7570
// Size: 0x14a
function function_644aea5c() {
    if (!zm_custom::function_5638f689(#"zmstartingweaponenabled")) {
        return;
    }
    waitframe(1);
    if (isdefined(self.talisman_weapon_start)) {
        var_95c796fd = getweapon(self.talisman_weapon_start);
        if (isdefined(var_95c796fd) && var_95c796fd != getweapon(#"none")) {
            w_pistol = getweapon(#"pistol_topbreak_t8");
            if (self hasweapon(w_pistol)) {
                self takeweapon(w_pistol);
            }
            self giveweapon(var_95c796fd);
            wait 0.5;
            if (isalive(self) && self hasweapon(var_95c796fd)) {
                self.talisman_weapon_start = undefined;
            }
        }
    }
}

