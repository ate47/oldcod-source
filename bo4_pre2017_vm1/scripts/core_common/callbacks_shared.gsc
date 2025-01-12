#using scripts/core_common/array_shared;
#using scripts/core_common/audio_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/hud_shared;
#using scripts/core_common/simple_hostmigration;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace callback;

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x1e23ef24, Offset: 0x260
// Size: 0x148
function callback(event, params) {
    if (isdefined(level._callbacks) && isdefined(level._callbacks[event])) {
        for (i = 0; i < level._callbacks[event].size; i++) {
            callback = level._callbacks[event][i][0];
            obj = level._callbacks[event][i][1];
            if (!isdefined(callback)) {
                continue;
            }
            if (isdefined(obj)) {
                if (isdefined(params)) {
                    obj thread [[ callback ]](self, params);
                } else {
                    obj thread [[ callback ]](self);
                }
                continue;
            }
            if (isdefined(params)) {
                self thread [[ callback ]](params);
                continue;
            }
            self thread [[ callback ]]();
        }
    }
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x0
// Checksum 0x35cc66ca, Offset: 0x3b0
// Size: 0x19c
function add_callback(event, func, obj) {
    /#
        assert(isdefined(event), "<dev string:x28>");
    #/
    if (!isdefined(level._callbacks) || !isdefined(level._callbacks[event])) {
        level._callbacks[event] = [];
    }
    foreach (callback in level._callbacks[event]) {
        if (callback[0] == func) {
            if (!isdefined(obj) || callback[1] == obj) {
                return;
            }
        }
    }
    array::add(level._callbacks[event], array(func, obj), 0);
    if (isdefined(obj)) {
        obj thread remove_callback_on_death(event, func);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x5b45d861, Offset: 0x558
// Size: 0x5c
function remove_callback_on_death(event, func) {
    self util::waittill_either("death", "remove_callbacks");
    remove_callback(event, func, self);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x0
// Checksum 0xf17aed75, Offset: 0x5c0
// Size: 0x146
function remove_callback(event, func, obj) {
    /#
        assert(isdefined(event), "<dev string:x58>");
    #/
    /#
        assert(isdefined(level._callbacks[event]), "<dev string:x8b>");
    #/
    foreach (index, func_group in level._callbacks[event]) {
        if (func_group[0] == func) {
            if (func_group[1] === obj) {
                arrayremoveindex(level._callbacks[event], index, 0);
                break;
            }
        }
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xef623220, Offset: 0x710
// Size: 0x34
function on_finalize_initialization(func, obj) {
    add_callback(#"hash_36fb1b1a", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xde15a0ab, Offset: 0x750
// Size: 0x34
function on_connect(func, obj) {
    add_callback(#"hash_eaffea17", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xc262d4e8, Offset: 0x790
// Size: 0x34
function remove_on_connect(func, obj) {
    remove_callback(#"hash_eaffea17", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd1b514f5, Offset: 0x7d0
// Size: 0x34
function on_connecting(func, obj) {
    add_callback(#"hash_fefe13f5", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf025f5bc, Offset: 0x810
// Size: 0x34
function remove_on_connecting(func, obj) {
    remove_callback(#"hash_fefe13f5", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe0396ef2, Offset: 0x850
// Size: 0x34
function on_disconnect(func, obj) {
    add_callback(#"hash_aebdd257", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x82667654, Offset: 0x890
// Size: 0x34
function remove_on_disconnect(func, obj) {
    remove_callback(#"hash_aebdd257", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x54470d79, Offset: 0x8d0
// Size: 0x34
function on_spawned(func, obj) {
    add_callback(#"hash_bc12b61f", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xebba2265, Offset: 0x910
// Size: 0x34
function remove_on_spawned(func, obj) {
    remove_callback(#"hash_bc12b61f", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xcc069899, Offset: 0x950
// Size: 0x34
function function_301fb71c(func, obj) {
    add_callback(#"hash_5bd9c78a", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x69ea2692, Offset: 0x990
// Size: 0x34
function function_5930314d(func, obj) {
    remove_callback(#"hash_5bd9c78a", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xabc331c9, Offset: 0x9d0
// Size: 0x34
function on_deleted(func, obj) {
    add_callback(#"hash_ebc37b54", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa91f182e, Offset: 0xa10
// Size: 0x34
function remove_on_deleted(func, obj) {
    remove_callback(#"hash_ebc37b54", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x28c33310, Offset: 0xa50
// Size: 0x34
function on_loadout(func, obj) {
    add_callback(#"hash_33bba039", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x1b17d5a6, Offset: 0xa90
// Size: 0x34
function remove_on_loadout(func, obj) {
    remove_callback(#"hash_33bba039", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb9965e5c, Offset: 0xad0
// Size: 0x34
function on_player_damage(func, obj) {
    add_callback(#"hash_ab5ecf6c", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x9e0b6911, Offset: 0xb10
// Size: 0x34
function remove_on_player_damage(func, obj) {
    remove_callback(#"hash_ab5ecf6c", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x5b75c6ba, Offset: 0xb50
// Size: 0x34
function on_start_gametype(func, obj) {
    add_callback(#"hash_cc62acca", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x775d7c99, Offset: 0xb90
// Size: 0x34
function on_joined_team(func, obj) {
    add_callback(#"hash_95a6c4c0", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x2ebc6268, Offset: 0xbd0
// Size: 0x34
function on_joined_spectate(func, obj) {
    add_callback(#"hash_4c5ae192", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x590d2be9, Offset: 0xc10
// Size: 0x34
function on_player_killed(func, obj) {
    add_callback(#"hash_bc435202", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf6ea283, Offset: 0xc50
// Size: 0x34
function on_player_killed_with_params(func, obj) {
    add_callback(#"hash_79a54ce0", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa8e29bf4, Offset: 0xc90
// Size: 0x34
function on_player_corpse(func, obj) {
    add_callback(#"hash_aa09fd19", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7bd596b7, Offset: 0xcd0
// Size: 0x34
function remove_on_player_killed(func, obj) {
    remove_callback(#"hash_bc435202", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x3a51b3f2, Offset: 0xd10
// Size: 0x34
function on_ai_killed(func, obj) {
    add_callback(#"hash_fc2ec5ff", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd5c0fd17, Offset: 0xd50
// Size: 0x34
function remove_on_ai_killed(func, obj) {
    remove_callback(#"hash_fc2ec5ff", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa4f95be8, Offset: 0xd90
// Size: 0x34
function on_actor_killed(func, obj) {
    add_callback(#"hash_8c38c12e", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb6015ef9, Offset: 0xdd0
// Size: 0x34
function remove_on_actor_killed(func, obj) {
    remove_callback(#"hash_8c38c12e", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x19097a7a, Offset: 0xe10
// Size: 0x34
function on_vehicle_spawned(func, obj) {
    add_callback(#"hash_bae82b92", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb72fa307, Offset: 0xe50
// Size: 0x34
function remove_on_vehicle_spawned(func, obj) {
    remove_callback(#"hash_bae82b92", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x57107592, Offset: 0xe90
// Size: 0x34
function on_vehicle_killed(func, obj) {
    add_callback(#"hash_acb66515", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x2b25791b, Offset: 0xed0
// Size: 0x34
function remove_on_vehicle_killed(func, obj) {
    remove_callback(#"hash_acb66515", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x53a7218f, Offset: 0xf10
// Size: 0x34
function on_ai_damage(func, obj) {
    add_callback(#"hash_eb4a4369", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa7500ca5, Offset: 0xf50
// Size: 0x34
function remove_on_ai_damage(func, obj) {
    remove_callback(#"hash_eb4a4369", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x21c6b6a4, Offset: 0xf90
// Size: 0x34
function on_ai_spawned(func, obj) {
    add_callback(#"hash_f96ca9bc", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x964ecc80, Offset: 0xfd0
// Size: 0x34
function remove_on_ai_spawned(func, obj) {
    remove_callback(#"hash_f96ca9bc", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x96dccd83, Offset: 0x1010
// Size: 0x34
function on_actor_damage(func, obj) {
    add_callback(#"hash_7b543e98", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x55f0390e, Offset: 0x1050
// Size: 0x34
function remove_on_actor_damage(func, obj) {
    remove_callback(#"hash_7b543e98", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x4ea55eec, Offset: 0x1090
// Size: 0x34
function on_vehicle_damage(func, obj) {
    add_callback(#"hash_9bd1e27f", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb2ca1d15, Offset: 0x10d0
// Size: 0x34
function remove_on_vehicle_damage(func, obj) {
    remove_callback(#"hash_9bd1e27f", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa6a322c2, Offset: 0x1110
// Size: 0x34
function on_laststand(func, obj) {
    add_callback(#"hash_6751ab5b", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb83fac8e, Offset: 0x1150
// Size: 0x34
function on_bleedout(func, obj) {
    add_callback(#"hash_622afee1", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd0de5bb7, Offset: 0x1190
// Size: 0x34
function on_revived(func, obj) {
    add_callback(#"hash_56e431c2", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7bb5322d, Offset: 0x11d0
// Size: 0x34
function on_mission_failed(func, obj) {
    add_callback(#"hash_dccd9d87", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x792a356b, Offset: 0x1210
// Size: 0x34
function on_challenge_complete(func, obj) {
    add_callback(#"hash_b286c65c", func, obj);
}

// Namespace callback/level_preinit
// Params 1, eflags: 0x40
// Checksum 0x38b5d562, Offset: 0x1250
// Size: 0x34
function event_handler[level_preinit] codecallback_preinitialization(eventstruct) {
    callback(#"hash_ecc6aecf");
    system::run_pre_systems();
}

// Namespace callback/level_finalizeinit
// Params 1, eflags: 0x40
// Checksum 0xa423112d, Offset: 0x1290
// Size: 0x34
function event_handler[level_finalizeinit] codecallback_finalizeinitialization(eventstruct) {
    system::run_post_systems();
    callback(#"hash_36fb1b1a");
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf1a8fa8a, Offset: 0x12d0
// Size: 0x4a
function add_weapon_damage(weapontype, callback) {
    if (!isdefined(level.weapon_damage_callback_array)) {
        level.weapon_damage_callback_array = [];
    }
    level.weapon_damage_callback_array[weapontype] = callback;
}

// Namespace callback/callbacks_shared
// Params 5, eflags: 0x0
// Checksum 0xd78fb198, Offset: 0x1328
// Size: 0xee
function callback_weapon_damage(eattacker, einflictor, weapon, meansofdeath, damage) {
    if (isdefined(level.weapon_damage_callback_array)) {
        if (isdefined(level.weapon_damage_callback_array[weapon])) {
            self thread [[ level.weapon_damage_callback_array[weapon] ]](eattacker, einflictor, weapon, meansofdeath, damage);
            return true;
        } else if (isdefined(level.weapon_damage_callback_array[weapon.rootweapon])) {
            self thread [[ level.weapon_damage_callback_array[weapon.rootweapon] ]](eattacker, einflictor, weapon, meansofdeath, damage);
            return true;
        }
    }
    return false;
}

// Namespace callback/callbacks_shared
// Params 1, eflags: 0x0
// Checksum 0xcd0da979, Offset: 0x1420
// Size: 0x4c
function function_367a33a8(callback) {
    if (!isdefined(level.var_1a51bc10)) {
        level.var_1a51bc10 = [];
    }
    array::add(level.var_1a51bc10, callback);
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0x509cc925, Offset: 0x1478
// Size: 0x60
function function_25419ce() {
    if (isdefined(level.var_1a51bc10)) {
        for (x = 0; x < level.var_1a51bc10.size; x++) {
            self [[ level.var_1a51bc10[x] ]]();
        }
    }
}

// Namespace callback/gametype_start
// Params 1, eflags: 0x40
// Checksum 0xcb5f4257, Offset: 0x14e0
// Size: 0x54
function event_handler[gametype_start] codecallback_startgametype(eventstruct) {
    if (!isdefined(level.gametypestarted) || !level.gametypestarted) {
        [[ level.callbackstartgametype ]]();
        level.gametypestarted = 1;
    }
}

// Namespace callback/player_connect
// Params 1, eflags: 0x40
// Checksum 0xcea4e276, Offset: 0x1540
// Size: 0x2c
function event_handler[player_connect] codecallback_playerconnect(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayerconnect ]]();
}

// Namespace callback/player_disconnect
// Params 1, eflags: 0x40
// Checksum 0xf4c3cc19, Offset: 0x1578
// Size: 0x74
function event_handler[player_disconnect] codecallback_playerdisconnect(eventstruct) {
    self notify(#"death");
    self.player_disconnected = 1;
    self notify(#"disconnect");
    level notify(#"disconnect", self);
    [[ level.callbackplayerdisconnect ]]();
    callback(#"hash_aebdd257");
}

// Namespace callback/hostmigration_setupgametype
// Params 0, eflags: 0x40
// Checksum 0x883708cc, Offset: 0x15f8
// Size: 0x34
function event_handler[hostmigration_setupgametype] codecallback_migration_setupgametype() {
    /#
        println("<dev string:xb8>");
    #/
    simple_hostmigration::migration_setupgametype();
}

// Namespace callback/hostmigration
// Params 1, eflags: 0x40
// Checksum 0x89e234e, Offset: 0x1638
// Size: 0x40
function event_handler[hostmigration] codecallback_hostmigration(eventstruct) {
    /#
        println("<dev string:xe5>");
    #/
    [[ level.callbackhostmigration ]]();
}

// Namespace callback/hostmigration_save
// Params 1, eflags: 0x40
// Checksum 0x535a6c21, Offset: 0x1680
// Size: 0x40
function event_handler[hostmigration_save] codecallback_hostmigrationsave(eventstruct) {
    /#
        println("<dev string:x108>");
    #/
    [[ level.callbackhostmigrationsave ]]();
}

// Namespace callback/hostmigration_premigrationsave
// Params 1, eflags: 0x40
// Checksum 0x522c2eaf, Offset: 0x16c8
// Size: 0x40
function event_handler[hostmigration_premigrationsave] codecallback_prehostmigrationsave(eventstruct) {
    /#
        println("<dev string:x12f>");
    #/
    [[ level.callbackprehostmigrationsave ]]();
}

// Namespace callback/hostmigration_playermigrated
// Params 1, eflags: 0x40
// Checksum 0xf94235f2, Offset: 0x1710
// Size: 0x40
function event_handler[hostmigration_playermigrated] codecallback_playermigrated(eventstruct) {
    /#
        println("<dev string:x159>");
    #/
    [[ level.callbackplayermigrated ]]();
}

// Namespace callback/player_damage
// Params 1, eflags: 0x40
// Checksum 0x8c29d73d, Offset: 0x1758
// Size: 0xc8
function event_handler[player_damage] codecallback_playerdamage(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayerdamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.normal);
}

// Namespace callback/player_killed
// Params 1, eflags: 0x40
// Checksum 0x6ccb75c1, Offset: 0x1828
// Size: 0x98
function event_handler[player_killed] codecallback_playerkilled(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayerkilled ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.death_anim_duration);
}

// Namespace callback/player_laststand
// Params 1, eflags: 0x40
// Checksum 0x52738723, Offset: 0x18c8
// Size: 0xac
function event_handler[player_laststand] codecallback_playerlaststand(eventstruct) {
    self endon(#"disconnect");
    self stopanimscripted();
    [[ level.callbackplayerlaststand ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.delay);
}

// Namespace callback/player_melee
// Params 1, eflags: 0x40
// Checksum 0x881c232b, Offset: 0x1980
// Size: 0x8c
function event_handler[player_melee] codecallback_playermelee(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayermelee ]](eventstruct.attacker, eventstruct.amount, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.bone_index, eventstruct.is_shieldhit, eventstruct.is_frombehind);
}

// Namespace callback/actor_spawned
// Params 1, eflags: 0x40
// Checksum 0x11199f77, Offset: 0x1a18
// Size: 0x2c
function event_handler[actor_spawned] codecallback_actorspawned(eventstruct) {
    self [[ level.callbackactorspawned ]](eventstruct.entity);
}

// Namespace callback/actor_damage
// Params 1, eflags: 0x40
// Checksum 0x4f3dd3e, Offset: 0x1a50
// Size: 0xd4
function event_handler[actor_damage] codecallback_actordamage(eventstruct) {
    [[ level.callbackactordamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.surface_type, eventstruct.normal);
}

// Namespace callback/actor_killed
// Params 1, eflags: 0x40
// Checksum 0x46955cbe, Offset: 0x1b30
// Size: 0x80
function event_handler[actor_killed] codecallback_actorkilled(eventstruct) {
    [[ level.callbackactorkilled ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

// Namespace callback/actor_cloned
// Params 1, eflags: 0x40
// Checksum 0x26e2f377, Offset: 0x1bb8
// Size: 0x2c
function event_handler[actor_cloned] codecallback_actorcloned(eventstruct) {
    [[ level.callbackactorcloned ]](eventstruct.clone);
}

// Namespace callback/vehicle_spawned
// Params 1, eflags: 0x40
// Checksum 0xb954110, Offset: 0x1bf0
// Size: 0x3c
function event_handler[vehicle_spawned] codecallback_vehiclespawned(eventstruct) {
    if (isdefined(level.callbackvehiclespawned)) {
        [[ level.callbackvehiclespawned ]](eventstruct.spawner);
    }
}

// Namespace callback/vehicle_killed
// Params 1, eflags: 0x40
// Checksum 0xd215e9a5, Offset: 0x1c38
// Size: 0x80
function event_handler[vehicle_killed] codecallback_vehiclekilled(eventstruct) {
    [[ level.callbackvehiclekilled ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

// Namespace callback/vehicle_damage
// Params 1, eflags: 0x40
// Checksum 0xc62f4134, Offset: 0x1cc0
// Size: 0xd4
function event_handler[vehicle_damage] codecallback_vehicledamage(eventstruct) {
    [[ level.callbackvehicledamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.damage_from_underneath, eventstruct.model_index, eventstruct.part_name, eventstruct.normal);
}

// Namespace callback/vehicle_radiusdamage
// Params 1, eflags: 0x40
// Checksum 0x5d639f69, Offset: 0x1da0
// Size: 0xbc
function event_handler[vehicle_radiusdamage] codecallback_vehicleradiusdamage(eventstruct) {
    [[ level.callbackvehicleradiusdamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.inner_damage, eventstruct.outer_damage, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.outer_radius, eventstruct.cone_angle, eventstruct.cone_direction, eventstruct.time_offset);
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0xabf21632, Offset: 0x1e68
// Size: 0x92
function finishcustomtraversallistener() {
    self endon(#"death");
    self waittillmatch({#notetrack:"end"}, "custom_traversal_anim_finished");
    self finishtraversal();
    self unlink();
    self.usegoalanimweight = 0;
    self.blockingpain = 0;
    self.customtraverseendnode = undefined;
    self.customtraversestartnode = undefined;
    self notify(#"custom_traversal_cleanup");
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0xc6c799a5, Offset: 0x1f08
// Size: 0x6c
function killedcustomtraversallistener() {
    self endon(#"custom_traversal_cleanup");
    self waittill("death");
    if (isdefined(self)) {
        self finishtraversal();
        self stopanimscripted();
        self unlink();
    }
}

// Namespace callback/entity_playcustomtraversal
// Params 1, eflags: 0x40
// Checksum 0x84b19fd0, Offset: 0x1f80
// Size: 0x1f4
function event_handler[entity_playcustomtraversal] codecallback_playcustomtraversal(eventstruct) {
    entity = eventstruct.entity;
    endparent = eventstruct.end_entity;
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity.customtraverseendnode = entity.traverseendnode;
    entity.customtraversestartnode = entity.traversestartnode;
    entity animmode("noclip", 0);
    entity orientmode("face angle", eventstruct.direction[1]);
    if (isdefined(endparent)) {
        offset = entity.origin - endparent.origin;
        entity linkto(endparent, "", offset);
    }
    entity animscripted("custom_traversal_anim_finished", eventstruct.location, eventstruct.direction, eventstruct.animation, eventstruct.anim_mode, undefined, eventstruct.playback_speed, eventstruct.goal_time, eventstruct.lerp_time);
    entity thread finishcustomtraversallistener();
    entity thread killedcustomtraversallistener();
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xfb1d3e4, Offset: 0x2180
// Size: 0xa4
function codecallback_faceeventnotify(notify_msg, ent) {
    if (isdefined(ent) && isdefined(ent.do_face_anims) && ent.do_face_anims) {
        if (isdefined(level.face_event_handler) && isdefined(level.face_event_handler.events[notify_msg])) {
            ent sendfaceevent(level.face_event_handler.events[notify_msg]);
        }
    }
}

// Namespace callback/ui_menuresponse
// Params 1, eflags: 0x40
// Checksum 0xeb5306f7, Offset: 0x2230
// Size: 0x10c
function event_handler[ui_menuresponse] codecallback_menuresponse(eventstruct) {
    if (!isdefined(level.menuresponsequeue)) {
        level.menuresponsequeue = [];
        level thread menu_response_queue_pump();
    }
    index = level.menuresponsequeue.size;
    level.menuresponsequeue[index] = spawnstruct();
    level.menuresponsequeue[index].action = eventstruct.name;
    level.menuresponsequeue[index].arg = eventstruct.response;
    level.menuresponsequeue[index].ent = self;
    level notify(#"menuresponse_queue");
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0xff79e60d, Offset: 0x2348
// Size: 0xcc
function menu_response_queue_pump() {
    while (true) {
        level waittill("menuresponse_queue");
        do {
            level.menuresponsequeue[0].ent notify(#"menuresponse", {#menu:level.menuresponsequeue[0].action, #response:level.menuresponsequeue[0].arg});
            arrayremoveindex(level.menuresponsequeue, 0, 0);
            waitframe(1);
        } while (level.menuresponsequeue.size > 0);
    }
}

// Namespace callback/notetrack_callserverscript
// Params 1, eflags: 0x40
// Checksum 0x422c9ec8, Offset: 0x2420
// Size: 0x7a
function event_handler[notetrack_callserverscript] codecallback_callserverscript(eventstruct) {
    if (!isdefined(level._animnotifyfuncs)) {
        return;
    }
    if (isdefined(level._animnotifyfuncs[eventstruct.label])) {
        eventstruct.entity [[ level._animnotifyfuncs[eventstruct.label] ]](eventstruct.param);
    }
}

// Namespace callback/notetrack_callserverscriptonlevel
// Params 1, eflags: 0x40
// Checksum 0x1d00b95e, Offset: 0x24a8
// Size: 0x72
function event_handler[notetrack_callserverscriptonlevel] codecallback_callserverscriptonlevel(eventstruct) {
    if (!isdefined(level._animnotifyfuncs)) {
        return;
    }
    if (isdefined(level._animnotifyfuncs[eventstruct.label])) {
        level [[ level._animnotifyfuncs[eventstruct.label] ]](eventstruct.param);
    }
}

// Namespace callback/sidemission_launch
// Params 1, eflags: 0x40
// Checksum 0x93dc46e0, Offset: 0x2528
// Size: 0x9c
function event_handler[sidemission_launch] codecallback_launchsidemission(eventstruct) {
    switchmap_preload(eventstruct.name, eventstruct.game_type, eventstruct.lighting);
    luinotifyevent(%open_side_mission_countdown, 1, eventstruct.list_index);
    wait 10;
    luinotifyevent(%close_side_mission_countdown);
    switchmap_switch();
}

// Namespace callback/ui_fadeblackscreen
// Params 1, eflags: 0x40
// Checksum 0xc2b8a381, Offset: 0x25d0
// Size: 0x64
function event_handler[ui_fadeblackscreen] codecallback_fadeblackscreen(eventstruct) {
    if (isplayer(self)) {
        self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend, eventstruct.blend);
    }
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0x6ea66b6d, Offset: 0x2640
// Size: 0x1dc
function abort_level() {
    /#
        println("<dev string:x17d>");
    #/
    level.callbackstartgametype = &callback_void;
    level.callbackplayerconnect = &callback_void;
    level.callbackplayerdisconnect = &callback_void;
    level.callbackplayerdamage = &callback_void;
    level.callbackplayerkilled = &callback_void;
    level.callbackplayerlaststand = &callback_void;
    level.callbackplayermelee = &callback_void;
    level.callbackactordamage = &callback_void;
    level.callbackactorkilled = &callback_void;
    level.callbackvehicledamage = &callback_void;
    level.callbackvehiclekilled = &callback_void;
    level.callbackactorspawned = &callback_void;
    level.callbackbotentereduseredge = &callback_void;
    level.callbackbotcreateplayerbot = &callback_void;
    level.callbackbotshutdown = &callback_void;
    if (isdefined(level._gametype_default)) {
        setdvar("g_gametype", level._gametype_default);
    }
    exitlevel(0);
}

// Namespace callback/glass_smash
// Params 1, eflags: 0x40
// Checksum 0xe8239b0, Offset: 0x2828
// Size: 0x4c
function event_handler[glass_smash] codecallback_glasssmash(eventstruct) {
    level notify(#"glass_smash", {#position:eventstruct.position, #direction:eventstruct.direction});
}

// Namespace callback/entity_deleted
// Params 1, eflags: 0x40
// Checksum 0x3f6443b9, Offset: 0x2880
// Size: 0x2c
function event_handler[entity_deleted] codecallback_entitydeleted(eventstruct) {
    self callback(#"hash_ebc37b54");
}

// Namespace callback/bot_enteruseredge
// Params 1, eflags: 0x40
// Checksum 0x974f0235, Offset: 0x28b8
// Size: 0x44
function event_handler[bot_enteruseredge] codecallback_botentereduseredge(eventstruct) {
    [[ level.callbackbotentereduseredge ]](eventstruct.start_node, eventstruct.end_node, eventstruct.end_location);
}

// Namespace callback/bot_create_player_bot
// Params 1, eflags: 0x40
// Checksum 0xefdb606f, Offset: 0x2908
// Size: 0x20
function event_handler[bot_create_player_bot] codecallback_botcreateplayerbot(eventstruct) {
    self [[ level.callbackbotcreateplayerbot ]]();
}

// Namespace callback/bot_stop_update
// Params 1, eflags: 0x40
// Checksum 0xbada5624, Offset: 0x2930
// Size: 0x20
function event_handler[bot_stop_update] codecallback_botstopupdate(eventstruct) {
    self [[ level.callbackbotshutdown ]]();
}

// Namespace callback/player_decoration
// Params 1, eflags: 0x40
// Checksum 0x73819bb7, Offset: 0x2958
// Size: 0xe0
function event_handler[player_decoration] codecallback_decoration(eventstruct) {
    a_decorations = self getdecorations(1);
    if (!isdefined(a_decorations)) {
        return;
    }
    if (a_decorations.size == 12) {
        self notify(#"give_achievement", {#id:"CP_ALL_DECORATIONS"});
    }
    var_be5507da = self getdecorations();
    if (a_decorations.size == var_be5507da.size - 1) {
        self givedecoration("cp_medal_all_decorations");
    }
    level notify(#"decoration_awarded");
    [[ level.callbackdecorationawarded ]]();
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2a40
// Size: 0x4
function callback_void() {
    
}

