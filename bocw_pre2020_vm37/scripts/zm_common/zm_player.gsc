#using script_3751b21462a54a7d;
#using script_4194df57536e11ed;
#using script_6167e26342be354b;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\armor;
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
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
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
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_scriptmover;
#using scripts\zm_common\gametypes\globallogic_spawn;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\scoreevents;
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
// Params 0, eflags: 0x6
// Checksum 0x745138e3, Offset: 0x658
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_player", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x5 linked
// Checksum 0x4bbc9a30, Offset: 0x6a0
// Size: 0x24
function private function_70a657d8() {
    callback::on_spawned(&function_34c2aeb5);
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x5 linked
// Checksum 0xc83d54b1, Offset: 0x6d0
// Size: 0xd2
function private function_34c2aeb5() {
    n_target = int(max(zombie_utility::function_d2dfacfd(#"player_base_health"), 1));
    self.var_66cb03ad = n_target;
    self setmaxhealth(self.var_66cb03ad);
    self zm_utility::set_max_health();
    self.n_regen_delay = zombie_utility::function_d2dfacfd("player_health_regen_delay");
    self.n_regen_rate = zombie_utility::function_d2dfacfd("player_health_regen_rate");
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x2ad92825, Offset: 0x7b0
// Size: 0xaa
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
// Params 1, eflags: 0x1 linked
// Checksum 0x7ff2878, Offset: 0x868
// Size: 0xcc
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
// Params 2, eflags: 0x1 linked
// Checksum 0x198025fc, Offset: 0x940
// Size: 0x3da
function getfreespawnpoint(spawnpoints, player) {
    if (!isdefined(spawnpoints)) {
        /#
            iprintlnbold("<dev string:x38>");
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
// Params 0, eflags: 0x1 linked
// Checksum 0x50fcc869, Offset: 0xd28
// Size: 0x382
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
        if (is_true(weapon.isheroweapon)) {
            continue;
        }
        if (weapon.type == "grenade") {
            continue;
        }
        ammocount = self getammocount(weapon);
        ammoclip = self getweaponammoclip(weapon);
        ammostock = self getweaponammostock(weapon);
        if (weapon.clipsize > 3) {
            var_6814b80a = mapfloat(1, 200, 1, 0.3, weapon.clipsize);
            var_89557197 = ceil(var_6814b80a * weapon.clipsize);
            if (isdefined(level.var_142dc1b8) && isdefined(level.var_142dc1b8[weapon.name])) {
                var_89557197 = level.var_142dc1b8[weapon.name];
            } else if (ammostock < 1) {
                var_89557197 += 10;
            }
            if (ammocount > var_89557197 || self laststand::player_is_in_laststand()) {
                ammooutcount = 0;
                ammolowcount = 0;
                continue;
            }
        } else {
            var_89557197 = min(5, floor((weapon.clipsize + weapon.maxammo) / 2));
            if (ammocount > var_89557197 || self laststand::player_is_in_laststand()) {
                ammooutcount = 0;
                ammolowcount = 0;
                continue;
            }
        }
        if (ammocount > 0) {
            if (ammolowcount < 1) {
                self zm_audio::create_and_play_dialog(#"ammo", #"low");
                ammolowcount++;
            }
        } else if (ammooutcount < 1) {
            wait 0.5;
            if (self getcurrentweapon() !== weapon) {
                continue;
            }
            self zm_audio::create_and_play_dialog(#"ammo", #"out");
            ammooutcount++;
        }
        wait 20;
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x46825596, Offset: 0x10b8
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
// Params 2, eflags: 0x1 linked
// Checksum 0x5efa8ff7, Offset: 0x1158
// Size: 0x7a
function spawn_vo_player(index, num) {
    sound = "plr_" + index + "_vox_" + num + "play";
    self playsoundwithnotify(sound, "sound_done");
    self waittill(#"sound_done");
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x83b30522, Offset: 0x11e0
// Size: 0x28
function precache_models() {
    if (isdefined(level.precachecustomcharacters)) {
        self [[ level.precachecustomcharacters ]]();
    }
}

// Namespace zm_player/zm_player
// Params 9, eflags: 0x1 linked
// Checksum 0xf0a913c5, Offset: 0x1210
// Size: 0x84
function callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    self endon(#"disconnect");
    zm_laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
}

// Namespace zm_player/zm_player
// Params 3, eflags: 0x0
// Checksum 0x296e7fad, Offset: 0x12a0
// Size: 0x6c
function breakafter(time, damage, *piece) {
    self notify(#"breakafter");
    self endon(#"breakafter");
    wait damage;
    self dodamage(piece, self.origin, undefined, undefined);
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x2f9bcfbd, Offset: 0x1318
// Size: 0x90
function function_7681dccc() {
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
// Params 13, eflags: 0x1 linked
// Checksum 0x1802bfa8, Offset: 0x13b0
// Size: 0x95c
function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    if (self getinvulnerability()) {
        return;
    }
    eattacker = player::figure_out_attacker(eattacker);
    if (isplayer(eattacker) && !weapons::ismeleemod(smeansofdeath)) {
        var_8f516911 = function_b576d3d(weapon, shitloc);
        idamage *= var_8f516911;
    }
    idamage = function_182d09fd(eattacker, idamage);
    startedinlaststand = 0;
    if (isplayer(self)) {
        startedinlaststand = self laststand::player_is_in_laststand();
    }
    println("<dev string:x5d>" + idamage + "<dev string:x7b>");
    if (isplayer(eattacker) && eattacker.sessionteam == self.sessionteam && !eattacker hasperk(#"specialty_playeriszombie") && !is_true(self.is_zombie)) {
        idamage = self process_friendly_fire_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
        if (self != eattacker && !level.friendlyfire) {
            println("<dev string:x80>");
            return;
        } else if (self == eattacker && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_PROJECTILE" && smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_BURNED" && smeansofdeath != "MOD_SUICIDE" && smeansofdeath != "MOD_DOT") {
            println("<dev string:xac>");
            return;
        }
    }
    overrideplayerdamage = function_7681dccc();
    if (isdefined(overrideplayerdamage)) {
        idamage = self [[ overrideplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    }
    assert(isdefined(idamage), "<dev string:xd0>");
    if (is_true(level.zm_bots_scale) && isbot(self) && isdefined(einflictor) && isactor(einflictor)) {
        idamage = int(idamage / zm_bot::function_e16b5033(einflictor));
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
    if (is_true(self.magic_bullet_shield)) {
        maxhealth = self.maxhealth;
        self.health += int(idamage);
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
    /#
        if (isdefined(eattacker)) {
            record3dtext("<dev string:x10c>" + idamage + "<dev string:x112>" + self.health + "<dev string:x11a>" + eattacker getentitynumber(), self.origin, (1, 0, 0), "<dev string:x122>", self);
        } else {
            record3dtext("<dev string:x10c>" + idamage + "<dev string:x112>" + self.health + "<dev string:x12c>", self.origin, (1, 0, 0), "<dev string:x122>", self);
        }
    #/
    if (idamage > 0) {
        if (isdefined(level.var_a2d8b7eb)) {
            zm_custom::function_db030433();
            self zm_score::player_reduce_points("points_lost_on_hit_percent", level.var_a2d8b7eb);
        } else if (isdefined(level.var_39e18a71)) {
            zm_custom::function_db030433();
            self zm_score::player_reduce_points("points_lost_on_hit_value", level.var_39e18a71);
            if (zm_trial::is_trial_mode()) {
                self playsoundtoplayer(#"hash_3109126d3731f3d2", self);
            }
        }
        if (isdefined(eattacker) && eattacker.team == level.zombie_team) {
            self zm_stats::increment_player_stat("hits_taken");
            self zm_stats::function_8f10788e("boas_hits_taken");
        }
    }
    idamage = int(idamage);
    self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    println("<dev string:x13d>");
    var_ca70d16a = 0;
    if (isplayer(self)) {
        var_ca70d16a = !startedinlaststand && self laststand::player_is_in_laststand();
    }
    bb::logdamage(eattacker, self, weapon, idamage, smeansofdeath, shitloc, self.health <= 0, var_ca70d16a);
    if (isplayer(eattacker) && idamage > 0 && !is_true(self.var_265cb589) && !is_true(level.var_dc60105c)) {
        eattacker util::show_hit_marker(var_ca70d16a);
    }
    if (isai(params.eattacker)) {
        scoreevents::function_46e3cf42(params.eattacker, self);
    }
}

// Namespace zm_player/zm_player
// Params 13, eflags: 0x1 linked
// Checksum 0x78f01ee2, Offset: 0x1d18
// Size: 0x9c
function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
}

// Namespace zm_player/zm_player
// Params 2, eflags: 0x1 linked
// Checksum 0x82873bb0, Offset: 0x1dc0
// Size: 0x2aa
function function_182d09fd(eattacker, idamage) {
    if (!isdefined(eattacker)) {
        return int(idamage);
    }
    if (eattacker.archetype === #"zombie" && isdefined(level.var_c739ead9)) {
        idamage *= level.var_c739ead9;
    }
    if (isdefined(eattacker.archetype) && isinarray(array(#"blight_father", #"brutus", #"gegenees", #"mechz", #"hash_7c0d83ac1e845ac2"), eattacker.archetype) && isdefined(level.var_5a59b382)) {
        idamage *= level.var_5a59b382;
    }
    if (isdefined(eattacker.archetype) && isinarray(array(#"stoker", #"gladiator", #"gladiator_marauder", #"gladiator_destroyer", #"werewolf", #"avogadro", #"raz"), eattacker.archetype) && isdefined(level.var_cfbc34ae)) {
        idamage *= level.var_cfbc34ae;
    }
    if (isdefined(eattacker.archetype) && isinarray(array(#"bat", #"dog", #"zombie_dog", #"zombie"), eattacker.archetype) && isdefined(level.var_97850f30)) {
        idamage *= level.var_97850f30;
    }
    return int(idamage);
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x1 linked
// Checksum 0xd39790d9, Offset: 0x2078
// Size: 0x44
function function_a8846426(callback) {
    if (!isdefined(level.player_friendly_fire_callbacks)) {
        level.player_friendly_fire_callbacks = [];
    }
    arrayremovevalue(level.player_friendly_fire_callbacks, callback);
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x1 linked
// Checksum 0x231d45e8, Offset: 0x20c8
// Size: 0xa8
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
// Params 11, eflags: 0x1 linked
// Checksum 0xcf28f2a2, Offset: 0x2178
// Size: 0x108
function process_friendly_fire_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    if (isdefined(level.player_friendly_fire_callbacks)) {
        foreach (callback in level.player_friendly_fire_callbacks) {
            idamage = self [[ callback ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
        }
    }
    return idamage;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x8f225a51, Offset: 0x2288
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
// Params 2, eflags: 0x1 linked
// Checksum 0xbbcff0c8, Offset: 0x2360
// Size: 0x1b0
function function_8ef51109(var_fb6fa3e1, var_bbbf9a69) {
    if (!function_3799b373(var_fb6fa3e1, var_bbbf9a69) && !zm_utility::function_91403f47()) {
        if (zm_trial::is_trial_mode()) {
            var_57807cdc = [];
            a_e_players = getplayers();
            foreach (e_player in a_e_players) {
                if (var_fb6fa3e1 === e_player) {
                    continue;
                }
                array::add(var_57807cdc, e_player, 0);
            }
            if (var_57807cdc.size > 1) {
                zm_trial::fail(#"hash_61d8fe81f9fe9e9c", var_57807cdc);
            } else {
                zm_trial::fail(#"hash_272fae998263208b", var_57807cdc);
            }
            return;
        }
        level notify(#"end_game", {#reason:#"all_players_dead"});
    }
}

// Namespace zm_player/zm_player
// Params 2, eflags: 0x1 linked
// Checksum 0xa4fc75d7, Offset: 0x2518
// Size: 0x224
function function_3799b373(var_fb6fa3e1, var_bbbf9a69 = 0) {
    if (!level flag::get("start_zombie_round_logic")) {
        return true;
    }
    a_e_players = getplayers();
    var_7ff2e79a = 0;
    var_2af2f14d = 0;
    foreach (e_player in a_e_players) {
        if (!isdefined(e_player)) {
            continue;
        }
        if (var_fb6fa3e1 === e_player) {
            continue;
        }
        if (is_true(e_player.is_zombie) || e_player.sessionstate === "spectator") {
            continue;
        }
        if (var_bbbf9a69 && isbot(e_player)) {
            if (!e_player laststand::player_is_in_laststand()) {
                var_7ff2e79a = 1;
            }
            continue;
        }
        if (e_player laststand::player_is_in_laststand() && e_player zm_laststand::function_618fd37e() <= 0 && !e_player namespace_791d0451::function_56cedda7(#"hash_504b3df717f88c4e") && !is_true(e_player.var_5f465b1)) {
            var_2af2f14d = 1;
            continue;
        }
        return true;
    }
    if (var_bbbf9a69 && var_2af2f14d && var_7ff2e79a) {
        return true;
    }
    return false;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0xc5e079b9, Offset: 0x2748
// Size: 0x43a
function onplayerspawned() {
    self notify(#"stop_onplayerspawned");
    self endon(#"stop_onplayerspawned", #"disconnect");
    for (;;) {
        self waittill(#"spawned_player");
        self setclientuivisibilityflag("hud_visible", 1);
        self.hits = 0;
        self recordplayerrevivezombies(self);
        /#
            if (getdvarint(#"zombie_cheat", 0) >= 1 && getdvarint(#"zombie_cheat", 0) <= 3) {
                self val::set(#"zombie_devgui", "<dev string:x15c>", 0);
            }
        #/
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
        if (is_true(level.player_out_of_playable_area_monitor)) {
            self thread player_out_of_playable_area_monitor();
        }
        if (is_true(level.player_too_many_players_check)) {
            level thread [[ level.player_too_many_players_check_func ]]();
        }
        self.var_c4890291 = [];
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
                self thread val::set_for_time(3, #"player_spawn_protection", "ignoreme");
            }
        }
        self notify(#"perks_initialized");
    }
}

// Namespace zm_player/zm_player
// Params 3, eflags: 0x0
// Checksum 0x8df85f, Offset: 0x2b90
// Size: 0x62
function spawn_life_brush(origin, radius, height) {
    life_brush = spawn("trigger_radius", origin, 0, radius, height);
    life_brush.script_noteworthy = "life_brush";
    return life_brush;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0xebd55f85, Offset: 0x2c00
// Size: 0x8e
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
// Checksum 0x83c47cfb, Offset: 0x2c98
// Size: 0x62
function spawn_kill_brush(origin, radius, height) {
    kill_brush = spawn("trigger_radius", origin, 0, radius, height);
    kill_brush.script_noteworthy = "kill_brush";
    return kill_brush;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0xf6a9f306, Offset: 0x2d08
// Size: 0x96
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
// Params 1, eflags: 0x1 linked
// Checksum 0x1e73f18c, Offset: 0x2da8
// Size: 0x218
function in_enabled_playable_area(var_22a4c702 = 500) {
    if (zm_utility::function_21f4ac36()) {
        if (!isdefined(level.var_a2a9b2de)) {
            level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
        }
        node = function_52c1730(self.origin, level.var_a2a9b2de, var_22a4c702);
        if (isdefined(node) && zm_zonemgr::zone_is_enabled(node.targetname)) {
            return true;
        }
        queryresult = function_72ce47bb(self.origin, 0, self getpathfindingradius(), self function_6a9ae71() * 0.5, 2, 1, undefined, undefined, level.var_e046d333);
        if (queryresult.data.size > 0) {
            return true;
        }
    }
    if (zm_utility::function_c85ebbbc()) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0x42769529, Offset: 0x2fc8
// Size: 0x34
function get_player_out_of_playable_area_monitor_wait_time() {
    /#
        if (is_true(level.check_kill_thread_every_frame)) {
            return 0.05;
        }
    #/
    return 3;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0xcd5a61f9, Offset: 0x3008
// Size: 0x408
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
        if (is_true(self.hostmigrationcontrolsfrozen)) {
            wait get_player_out_of_playable_area_monitor_wait_time();
            continue;
        }
        if (self.var_f22c83f5 === 1) {
            wait get_player_out_of_playable_area_monitor_wait_time();
            continue;
        }
        if (!self in_life_brush() && (self in_kill_brush() || !self in_enabled_playable_area() || isdefined(level.player_out_of_playable_area_override) && is_true(self [[ level.player_out_of_playable_area_override ]]())) && !is_true(self.var_2c27f919)) {
            if (!isdefined(level.player_out_of_playable_area_monitor_callback) || self [[ level.player_out_of_playable_area_monitor_callback ]]()) {
                /#
                    iprintlnbold("<dev string:x16a>" + self.origin);
                #/
                /#
                    if (is_true(level.kill_thread_test_mode)) {
                        wait get_player_out_of_playable_area_monitor_wait_time();
                        continue;
                    }
                    if (self isinmovemode("<dev string:x184>", "<dev string:x18b>") || is_true(level.disable_kill_thread) || getdvarint(#"zombie_cheat", 0) > 0) {
                        wait get_player_out_of_playable_area_monitor_wait_time();
                        continue;
                    }
                #/
                self zm_stats::increment_map_cheat_stat("cheat_out_of_playable");
                self zm_stats::increment_client_stat("cheat_out_of_playable", 0);
                self zm_stats::increment_client_stat("cheat_total", 0);
                self playlocalsound(#"zmb_player_outofbounds");
                if (isdefined(self.maxhealth) && self.maxhealth > 0) {
                    n_damage = self.maxhealth / 3 + 1;
                } else {
                    n_damage = 51;
                }
                if (self.health <= n_damage) {
                    self zm_laststand::function_3d685b5f(0);
                    self.var_39c78617 = 1;
                }
                self.var_dad8bef6 = 1;
                self dodamage(n_damage, self.origin);
                self.var_dad8bef6 = undefined;
            }
        }
        wait get_player_out_of_playable_area_monitor_wait_time();
    }
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x0
// Checksum 0x6472397a, Offset: 0x3418
// Size: 0x2ac
function function_de3936f8(var_ffb1863c) {
    self notify(#"hash_639868d8cfc48f96");
    self endon(#"disconnect", #"hash_639868d8cfc48f96");
    self waittilltimeout(1, #"weapon_change_complete");
    if (self zm_loadout::has_powerup_weapon() || self laststand::player_is_in_laststand() || self.sessionstate == "spectator" || isdefined(self.laststandpistol)) {
        return;
    }
    var_287a8343 = zm_utility::get_player_weapon_limit(self);
    var_3ba4bf7d = self getweaponslistprimaries();
    if (var_3ba4bf7d.size > var_287a8343) {
        self zm_melee_weapon::take_fallback_weapon();
        var_3ba4bf7d = self getweaponslistprimaries();
        if (var_3ba4bf7d.size > var_287a8343) {
            self zm_stats::increment_map_cheat_stat("cheat_too_many_weapons");
            self zm_stats::increment_client_stat("cheat_too_many_weapons", 0);
            self zm_stats::increment_client_stat("cheat_total", 0);
            self playlocalsound(level.zmb_laugh_alias);
            if (isdefined(var_ffb1863c) && self hasweapon(var_ffb1863c) && isinarray(var_3ba4bf7d, var_ffb1863c)) {
                self takeweapon(var_ffb1863c);
            } else if (isinarray(var_3ba4bf7d, self.currentweapon)) {
                self takeweapon(self.currentweapon);
            } else {
                self takeweapon(var_3ba4bf7d[0]);
            }
            wait 1;
            if (!self getweaponslistprimaries().size) {
                self zm_loadout::give_start_weapon(1);
            }
        }
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0xfb3cd093, Offset: 0x36d0
// Size: 0x16e
function player_monitor_travel_dist() {
    self notify(#"stop_player_monitor_travel_dist");
    self endon(#"stop_player_monitor_travel_dist", #"disconnect");
    n_current_distance = 0;
    for (prevpos = self.origin; isdefined(self); prevpos = self.origin) {
        wait 0.1;
        if (self.var_16735873 !== 1) {
            n_distance = distance(self.origin, prevpos);
            self.pers[#"distance_traveled"] = self.pers[#"distance_traveled"] + n_distance;
            if (n_distance > 1 && int(self.pers[#"distance_traveled"]) > n_current_distance) {
                self zm_stats::function_301c4be2("boas_distanceSprinted", int(n_distance));
                n_current_distance = self.pers[#"distance_traveled"];
            }
        }
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0xcd3e7f51, Offset: 0x3848
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
// Params 0, eflags: 0x1 linked
// Checksum 0xcc92e989, Offset: 0x38c8
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
// Params 2, eflags: 0x1 linked
// Checksum 0x5c3e07f7, Offset: 0x3990
// Size: 0x35a
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
    if (is_true(grenade.grenade_multiattack_bookmark_count)) {
        count = grenade.grenade_multiattack_bookmark_count;
    }
    var_7b841aa9 = #"zm_player_grenade_multiattack";
    if (is_true(grenade.use_grenade_special_long_bookmark)) {
        var_7b841aa9 = #"zm_player_grenade_special_long";
    } else if (is_true(grenade.use_grenade_special_bookmark)) {
        var_7b841aa9 = #"zm_player_grenade_special_long";
    }
    if (count <= self.grenade_multiattack_count && isdefined(self.grenade_multiattack_ent)) {
        deathtime = gettime();
        perks = [];
        killstreaks = [];
        demo::bookmark(var_7b841aa9, gettime(), self, undefined, 0);
        potm::bookmark(var_7b841aa9, gettime(), self, undefined, 0);
        potm::function_5523a49a(var_7b841aa9, self getentitynumber(), self getxuid(), self.grenade_multiattack_ent, killcam_entity_info, weapon, "MOD_GRENADE", deathtime, 0, 0, perks, killstreaks, self, einflictor);
    }
    if (5 <= self.grenade_multikill_count) {
        self zm_stats::increment_challenge_stat(#"zombie_hunter_explosion_multikill");
    }
    self.grenade_multiattack_count = 0;
    self.grenade_multikill_count = 0;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x2f9c1b4d, Offset: 0x3cf8
// Size: 0x120
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
// Params 10, eflags: 0x1 linked
// Checksum 0x8f6ca120, Offset: 0x3e20
// Size: 0x2e4
function player_prevent_damage(einflictor, eattacker, idamage, *idflags, smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime) {
    if (isai(vdir) && self.ignoreme && psoffsettime === "MOD_MELEE") {
        return true;
    }
    /#
        if (isai(vdir) && self.ignoreme) {
            println("<dev string:x195>" + function_9e72a96(vdir.archetype) + "<dev string:x1cf>" + psoffsettime);
        }
        if (is_true(self.bgb_in_plain_sight_active)) {
            str = "<dev string:x1d9>";
            if (isai(vdir)) {
                str += function_9e72a96(vdir.archetype);
            } else if (isdefined(vdir)) {
                str = str + "<dev string:x209>" + vdir getentitynumber();
            } else {
                str += "<dev string:x214>";
            }
            println(str);
            println("<dev string:x22d>" + (is_true(self.ignoreme) ? "<dev string:x245>" : "<dev string:x24d>"));
            println("<dev string:x256>" + psoffsettime);
            println("<dev string:x26b>" + shitloc + "<dev string:x273>");
        }
    #/
    if (!isdefined(vpoint) || !isdefined(vdir)) {
        return false;
    }
    if (vpoint == self || vdir == self) {
        return false;
    }
    if (isdefined(vpoint) && isdefined(vpoint.team)) {
        if (!is_true(vpoint.damage_own_team)) {
            if (vpoint.team == self.team) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x6b214bd9, Offset: 0x4110
// Size: 0x300
function player_revive_monitor() {
    self notify(#"stop_player_revive_monitor");
    self endon(#"stop_player_revive_monitor", #"disconnect");
    while (true) {
        waitresult = self waittill(#"player_revived");
        reviver = waitresult.reviver;
        self playsound(#"zmb_character_revived");
        if (is_true(level.isresetting_grief)) {
            continue;
        }
        if (isdefined(reviver)) {
            if (reviver != self) {
                if (math::cointoss()) {
                    self zm_audio::create_and_play_dialog(#"revive", #"up");
                } else {
                    reviver zm_audio::create_and_play_dialog(#"revive", #"support");
                }
            } else {
                self zm_audio::create_and_play_dialog(#"revive", #"up");
            }
            points = self.score_lost_when_downed;
            if (!isdefined(points) || self == reviver || zm_custom::function_901b751c(#"zmpointlossondown")) {
                points = 0;
            } else if (points > 2500) {
                points = 2500 + (points - 2500) * 0.5;
            }
            println("<dev string:x27e>" + points);
            reviver zm_score::player_add_points("reviver", points);
            self.score_lost_when_downed = 0;
            if (isplayer(reviver) && reviver != self) {
                reviver zm_stats::increment_challenge_stat(#"survivalist_revive", undefined, 1);
                reviver zm_stats::increment_challenge_stat(#"hash_79ba5b62b95a7eb6", undefined, 1);
                reviver zm_stats::function_c0c6ab19(#"revives", 1, 1);
            }
        }
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x4fd26190, Offset: 0x4418
// Size: 0x23e
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
    println("<dev string:x29e>");
    self detachall();
    if (isdefined(level.var_7abfc4ea)) {
        self [[ level.var_7abfc4ea ]]();
    } else {
        self setspectatepermissions(1);
    }
    self spawn(self.origin, self.angles);
    self notify(#"spawned_spectator");
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x1 linked
// Checksum 0x7629a6cf, Offset: 0x4660
// Size: 0xcc
function setspectatepermissions(ison) {
    self allowspectateteam(#"allies", ison && self.team == #"allies");
    self allowspectateteam(#"axis", ison && self.team == #"axis");
    self allowspectateteam("freelook", 0);
    self allowspectateteam("none", 0);
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0x6c17dacc, Offset: 0x4738
// Size: 0x44
function spectator_toggle_3rd_person() {
    self endon(#"disconnect", #"spawned_player");
    self set_third_person(1);
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x1 linked
// Checksum 0x466f4bb, Offset: 0x4788
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
// Checksum 0x4a3b421, Offset: 0x4820
// Size: 0x154
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
// Params 0, eflags: 0x1 linked
// Checksum 0x91f9e21a, Offset: 0x4980
// Size: 0xee
function spectators_respawn() {
    level endon(#"between_round_over", #"end_game");
    if (!isdefined(zombie_utility::function_d2dfacfd(#"spectators_respawn")) || !zombie_utility::function_d2dfacfd(#"spectators_respawn")) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0xad16aabc, Offset: 0x4a78
// Size: 0xfc
function spectator_respawn_player() {
    if (self.sessionstate == "spectator" && isdefined(self.spectator_respawn)) {
        if (!isdefined(level.custom_spawnplayer)) {
            level.custom_spawnplayer = &spectator_respawn;
        }
        self [[ level.spawnplayer ]]();
        if (isdefined(level.script) && level.round_number > 6 && self.score < 1500) {
            self.old_score = self.score;
            if (isdefined(level.var_cf66a6f6)) {
                self [[ level.var_cf66a6f6 ]]();
            }
            self.score = 1500;
        }
        if (isdefined(level.var_857878e6)) {
            self [[ level.var_857878e6 ]]();
        }
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x4460109c, Offset: 0x4b80
// Size: 0x380
function spectator_respawn() {
    println("<dev string:x2ce>");
    assert(isdefined(self.spectator_respawn));
    if (!isdefined(self) || !isdefined(self.spectator_respawn)) {
        return;
    }
    origin = self.spectator_respawn.origin;
    angles = self.spectator_respawn.angles;
    self setspectatepermissions(0);
    new_origin = undefined;
    if (isdefined(level.var_5816975b)) {
        new_origin = [[ level.var_5816975b ]](self);
    }
    if (!isdefined(new_origin)) {
        new_origin = check_for_valid_spawn_near_team(self, 1);
    }
    if (!isdefined(new_origin)) {
        if (isdefined(self.var_f4710251)) {
            targetplayer = getentbynum(self.var_f4710251);
            if (isdefined(targetplayer) && isplayer(targetplayer) && isalive(targetplayer)) {
                new_origin = squad_spawn::function_e402b74e(self, targetplayer);
            }
        }
    }
    if (isdefined(new_origin)) {
        if (!isdefined(new_origin.angles)) {
            angles = (0, 0, 0);
        } else {
            angles = new_origin.angles;
        }
        self spawn(new_origin.origin, angles);
    } else if (isvec(origin) && isvec(angles)) {
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
    return 1;
}

// Namespace zm_player/zm_player
// Params 2, eflags: 0x1 linked
// Checksum 0xf2f094f3, Offset: 0x4f08
// Size: 0x2b8
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
                if (zm_utility::check_point_in_enabled_zone(spawn_points[j].origin, 1, a_enabled_zone_entities) == 0) {
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
// Params 4, eflags: 0x1 linked
// Checksum 0x4599fe6a, Offset: 0x51c8
// Size: 0x2c2
function get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct) {
    spawn_array = struct::get_array(spawn_points[closest_group].target, "targetname");
    if (level flag::get("round_reset")) {
        spawn_point_index = revivee getentitynumber();
        assert(spawn_point_index >= 0 && spawn_point_index < spawn_array.size);
        if (is_true(return_struct)) {
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
            if (is_true(return_struct)) {
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
            if (is_true(return_struct)) {
                return spawn_array[k];
            }
            return spawn_array[k].origin;
        }
    }
    if (is_true(return_struct)) {
        return spawn_array[0];
    }
    return spawn_array[0].origin;
}

// Namespace zm_player/zm_player
// Params 3, eflags: 0x0
// Checksum 0x2250a3c5, Offset: 0x5498
// Size: 0x1b6
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
// Checksum 0xf283811a, Offset: 0x5658
// Size: 0x14e
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
// Checksum 0xf7925a70, Offset: 0x57b0
// Size: 0xb0
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
// Checksum 0x666db72f, Offset: 0x5868
// Size: 0x138
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
// Checksum 0xc74f7474, Offset: 0x59a8
// Size: 0x17a
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
                players[i] zm_audio::create_and_play_dialog(#"general", #"outofmoney");
                wait 3;
                self notify(#"warning_dialog");
            }
        }
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x93a6380, Offset: 0x5b30
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
// Checksum 0x10acc889, Offset: 0x5ba8
// Size: 0x7e
function player_damage_override_cheat(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    return false;
}

// Namespace zm_player/zm_player
// Params 10, eflags: 0x1 linked
// Checksum 0x2e1ab340, Offset: 0x5c30
// Size: 0xe7a
function player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    idamage = self check_player_damage_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    if (self.scene_takedamage === 0) {
        return 0;
    }
    if (isdefined(level.prevent_player_damage) && !level.friendlyfire) {
        if (self [[ level.prevent_player_damage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)) {
            return 0;
        }
    }
    if (isdefined(eattacker) && is_true(eattacker.b_aat_fire_works_weapon)) {
        return 0;
    }
    if (is_true(self.use_adjusted_grenade_damage)) {
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
        if (is_true(einflictor.water_damage)) {
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
        if (is_true(self.is_zombie) && is_true(eattacker.is_zombie)) {
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
            if (is_true(eattacker.is_zombie) || isplayer(eattacker)) {
                self playrumbleonentity("damage_heavy");
            }
            if (eattacker.archetype === #"zombie") {
                self zm_audio::create_and_play_dialog(#"general", #"attacked");
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
    if (isdefined(einflictor) && isdefined(einflictor.archetype) && einflictor.archetype == #"zombie_quad") {
        if (smeansofdeath == "MOD_EXPLOSIVE") {
            if (self.health > 75) {
                return 75;
            }
        }
    }
    if (smeansofdeath == "MOD_SUICIDE" && self bgb::is_enabled(#"zm_bgb_danger_closest")) {
        return 0;
    }
    if (zm_utility::is_explosive_damage(smeansofdeath)) {
        if (self bgb::is_enabled(#"zm_bgb_danger_closest")) {
            return 0;
        }
        if (!is_true(self.is_zombie)) {
            if (!isdefined(eattacker) || !is_true(eattacker.is_zombie) && !is_true(eattacker.b_override_explosive_damage_cap)) {
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
    armor = self armor::get_armor();
    gear_armor = self.armor;
    self.var_426947c4 = undefined;
    idamage = self armor::apply_damage(weapon, idamage, smeansofdeath, eattacker, shitloc);
    idamage = self armor::function_a77114f2(einflictor, eattacker, idamage, smeansofdeath, weapon, shitloc);
    var_8da1698b = armor != self armor::get_armor();
    if (var_8da1698b) {
        idflags |= 2048;
        if (gear_armor > 0 && self.armor <= 0) {
            self.var_426947c4 = 1;
        }
    }
    if (is_true(self.power_armor_took_damage)) {
        idflags |= 1024;
    }
    if (isdefined(level.var_ccdc4ca6)) {
        for (i = 0; i < level.var_ccdc4ca6.size; i++) {
            var_36da0ddb = self [[ level.var_ccdc4ca6[i] ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
            if (isdefined(var_36da0ddb) && var_36da0ddb != -1) {
                idamage = var_36da0ddb;
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
            if (is_true(eattacker.missinglegs)) {
                self zm_audio::create_and_play_dialog(#"general", #"crawl_hit");
            }
        }
        return idamage;
    }
    if (isgodmode(self)) {
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
        if (isdefined(eattacker) && isplayer(eattacker) && eattacker.team != self.team && (!is_true(self.laststand) && !self laststand::player_is_in_laststand() || !isdefined(self.last_player_attacker))) {
            if (isdefined(eattacker.maxhealth) && is_true(eattacker.is_zombie)) {
                eattacker.health = eattacker.maxhealth;
            }
            if (isdefined(level.player_kills_player)) {
                self thread [[ level.player_kills_player ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
            }
        }
    }
    if (self hasperk(#"specialty_whoswho") && self zm_laststand::function_618fd37e() > 0) {
        self zm_laststand::function_409dc98e();
        if (isdefined(level.whoswho_laststand_func)) {
            self thread [[ level.whoswho_laststand_func ]]();
            return 0;
        }
    }
    if (self zm_laststand::function_618fd37e() > 0 || is_true(self.var_5f465b1) || self namespace_791d0451::function_56cedda7(#"hash_504b3df717f88c4e")) {
        var_228d944 = 1;
    } else {
        var_228d944 = function_3799b373(self);
    }
    if (var_228d944 || zm_utility::function_91403f47()) {
        return finaldamage;
    }
    if (isdefined(level.var_57cc29f3) && [[ level.var_57cc29f3 ]](self)) {
        return finaldamage;
    }
    if (getplayers().size == 1 && level flag::get("solo_game")) {
        if (isdefined(level.var_fb697fca) && [[ level.var_fb697fca ]]()) {
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
    level notify(#"end_game", {#reason:#"last_player_died"});
    return 0;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x1d27a06d, Offset: 0x6ab8
// Size: 0xbe
function clear_path_timers() {
    zombies = getaiteamarray(level.zombie_team);
    foreach (zombie in zombies) {
        if (isdefined(zombie.favoriteenemy) && zombie.favoriteenemy == self) {
            zombie.zombie_path_timer = 0;
        }
    }
}

// Namespace zm_player/zm_player
// Params 10, eflags: 0x1 linked
// Checksum 0xd46e7b9b, Offset: 0x6b80
// Size: 0x150
function check_player_damage_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isdefined(level.var_5391c404)) {
        for (i = 0; i < level.var_5391c404.size; i++) {
            newdamage = self [[ level.var_5391c404[i] ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
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
// Checksum 0x455bbf27, Offset: 0x6cd8
// Size: 0x44
function function_57301eaf(func) {
    if (!isdefined(level.var_5391c404)) {
        level.var_5391c404 = [];
    }
    level.var_5391c404[level.var_5391c404.size] = func;
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x1 linked
// Checksum 0x12ce1371, Offset: 0x6d28
// Size: 0x44
function register_player_damage_callback(func) {
    if (!isdefined(level.player_damage_callbacks)) {
        level.player_damage_callbacks = [];
    }
    level.player_damage_callbacks[level.player_damage_callbacks.size] = func;
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x1 linked
// Checksum 0x92b77110, Offset: 0x6d78
// Size: 0x44
function function_a827358a(func) {
    if (!isdefined(level.var_ccdc4ca6)) {
        level.var_ccdc4ca6 = [];
    }
    level.var_ccdc4ca6[level.var_ccdc4ca6.size] = func;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x43e72768, Offset: 0x6dc8
// Size: 0x164
function player_fake_death() {
    self endon(#"death");
    level notify(#"fake_death");
    self notify(#"fake_death");
    self takeallweapons();
    self allowstand(0);
    self allowcrouch(0);
    self allowprone(1);
    self allowsprint(0);
    self setstance("prone");
    self val::set(#"fake_death", "ignoreme", 1);
    self val::set(#"fake_death", "takedamage", 0);
    wait 1;
    self val::set(#"fake_death", "freezecontrols", 1);
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x89b85a82, Offset: 0x6f38
// Size: 0x4c
function player_exit_level() {
    self allowstand(1);
    self allowcrouch(0);
    self allowprone(0);
}

// Namespace zm_player/zm_player
// Params 9, eflags: 0x1 linked
// Checksum 0x2bc48ce4, Offset: 0x6f90
// Size: 0x64
function player_killed_override(*einflictor, *attacker, *idamage, *smeansofdeath, *weapon, *vdir, *shitloc, *psoffsettime, *deathanimduration) {
    level waittill(#"forever");
}

// Namespace zm_player/zm_player
// Params 4, eflags: 0x1 linked
// Checksum 0x18223153, Offset: 0x7000
// Size: 0x62
function screen_fade_in(n_time, v_color, str_menu_id, var_b675738a = 0) {
    lui::screen_fade(n_time, 0, 1, v_color, 0, str_menu_id, var_b675738a);
    wait n_time;
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x6269a470, Offset: 0x7070
// Size: 0x42a
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
            println("<dev string:x2ff>");
            return;
        }
    }
    if (is_true(level.b_show_single_intermission)) {
        a_s_temp_points = array::randomize(points);
        points = [];
        points[0] = array::random(a_s_temp_points);
    } else {
        points = array::randomize(points);
    }
    self zm_utility::create_streamer_hint(points[0].origin, points[0].angles, 0.9);
    wait 5;
    self lui::screen_fade_out(1, undefined, undefined, 1);
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
                self screen_fade_in(2, undefined, undefined, 1);
                wait 3;
                self lui::screen_fade_out(2, undefined, undefined, 1);
                continue;
            }
            self screen_fade_in(2, undefined, undefined, 1);
            if (points.size == 1) {
                return;
            }
        }
    }
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x3d4c17cb, Offset: 0x74a8
// Size: 0x6c
function zm_on_player_connect() {
    self.hitsoundtracker = 1;
    thread update_is_player_valid();
    characterindex = self getcharacterbodytype();
    self stats::function_7a850245(#"characterindex", characterindex);
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0x5f207bff, Offset: 0x7520
// Size: 0x74
function zm_on_player_spawned() {
    self setperk("specialty_sprint");
    self setperk("specialty_sprintreload");
    self setperk("specialty_slide");
    thread zm_utility::update_zone_name();
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x1 linked
// Checksum 0xe55bb6d8, Offset: 0x75a0
// Size: 0x6c
function update_is_player_valid() {
    self notify("9ac822f5ea4e5df");
    self endon("9ac822f5ea4e5df");
    self endon(#"disconnect");
    self.am_i_valid = 0;
    while (isdefined(self)) {
        self.am_i_valid = zm_utility::is_player_valid(self, 1);
        waitframe(1);
    }
}

// Namespace zm_player/zm_player
// Params 3, eflags: 0x0
// Checksum 0x83a3ec9d, Offset: 0x7618
// Size: 0xca
function register_slowdown(str_type, n_rate, n_duration) {
    if (!isdefined(level.var_f27112f9)) {
        level.var_f27112f9 = [];
    } else if (!isarray(level.var_f27112f9)) {
        level.var_f27112f9 = array(level.var_f27112f9);
    }
    level.var_f27112f9[str_type] = spawnstruct();
    level.var_f27112f9[str_type].n_rate = n_rate;
    level.var_f27112f9[str_type].n_duration = n_duration;
}

// Namespace zm_player/zm_player
// Params 2, eflags: 0x0
// Checksum 0xa96b3053, Offset: 0x76f0
// Size: 0x334
function slowdown(str_type, var_a47cf2b2) {
    if (is_true(self.var_7b0667d9)) {
        return;
    }
    self notify(#"hash_31eac0065ba118f5");
    self endoncallback(&function_fe7a7d5b, #"hash_31eac0065ba118f5", #"death", #"hash_28af7943f07d93e2");
    assert(isdefined(level.var_f27112f9[str_type]), "<dev string:x325>" + str_type + "<dev string:x333>");
    if (!isdefined(self.a_n_slowdown_timeouts)) {
        self.a_n_slowdown_timeouts = [];
    }
    n_time = gettime();
    if (isdefined(level.var_f27112f9[str_type].n_duration)) {
        n_timeout = n_time + level.var_f27112f9[str_type].n_duration;
        if (!isdefined(self.a_n_slowdown_timeouts[str_type]) || self.a_n_slowdown_timeouts[str_type] < n_timeout) {
            self.a_n_slowdown_timeouts[str_type] = n_timeout;
        }
    } else {
        self.a_n_slowdown_timeouts[str_type] = -1;
    }
    while (self.a_n_slowdown_timeouts.size) {
        str_lowest_type = undefined;
        n_lowest_rate = 10;
        foreach (str_index, n_slowdown_timeout in self.a_n_slowdown_timeouts) {
            if (isdefined(n_timeout) && n_slowdown_timeout <= n_time) {
                self.a_n_slowdown_timeouts[str_index] = undefined;
                continue;
            }
            if (str_index == str_type && isdefined(var_a47cf2b2)) {
                n_rate = var_a47cf2b2;
            } else {
                n_rate = level.var_f27112f9[str_index].n_rate;
            }
            if (n_rate < n_lowest_rate) {
                str_lowest_type = str_index;
                n_lowest_rate = n_rate;
            }
        }
        if (isdefined(str_lowest_type)) {
            self setmovespeedscale(n_lowest_rate);
            if (!isdefined(n_timeout)) {
                self waittill(#"hash_28af7943f07d93e2");
                return;
            }
            n_duration = self.a_n_slowdown_timeouts[str_lowest_type] - n_time;
            wait n_duration;
            self.a_n_slowdown_timeouts[str_lowest_type] = undefined;
        }
    }
    self setmovespeedscale(1);
}

// Namespace zm_player/zm_player
// Params 0, eflags: 0x0
// Checksum 0xf12455ff, Offset: 0x7a30
// Size: 0x16
function function_520f4da5() {
    self notify(#"hash_28af7943f07d93e2");
}

// Namespace zm_player/zm_player
// Params 1, eflags: 0x5 linked
// Checksum 0xd7f299c5, Offset: 0x7a50
// Size: 0x2c
function private function_fe7a7d5b(*str_notify) {
    self setmovespeedscale(1);
}

