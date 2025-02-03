#using script_6167e26342be354b;
#using script_7a8059ca02b7b09e;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_a77a81df;

// Namespace namespace_a77a81df/namespace_a77a81df
// Params 0, eflags: 0x6
// Checksum 0x2d3b24cb, Offset: 0x98
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_ac6037cb01da0d4", &preinit, undefined, undefined, #"hash_53528dbbf6cd15c4");
}

// Namespace namespace_a77a81df/namespace_a77a81df
// Params 0, eflags: 0x4
// Checksum 0xcb1c4337, Offset: 0xe8
// Size: 0x184
function private preinit() {
    telemetry::add_callback(#"on_game_playing", &function_72c32279);
    telemetry::add_callback(#"hash_3ca80e35288a78d0", &function_d519e318);
    telemetry::add_callback(#"on_end_game", &function_f0ffff28);
    telemetry::add_callback(#"on_player_connect", &on_player_connect);
    telemetry::add_callback(#"on_player_disconnect", &on_player_disconnect);
    telemetry::add_callback(#"on_player_spawned", &on_player_spawned);
    telemetry::function_98df8818(#"hash_6602db5bc859fcd9", &function_55a7ded6);
    telemetry::function_98df8818(#"hash_fc0d1250fc48d49", &function_607901f4);
}

// Namespace namespace_a77a81df/namespace_a77a81df
// Params 0, eflags: 0x0
// Checksum 0xa3780cea, Offset: 0x278
// Size: 0x254
function function_72c32279() {
    if (util::isfirstround()) {
        /#
            println("<dev string:x38>" + getutc());
            println("<dev string:x63>" + util::get_map_name());
            println("<dev string:x8e>" + level.gametype);
            println("<dev string:xbe>" + sessionmodeisprivateonlinegame());
            println("<dev string:xf4>" + sessionmodeissystemlink());
            println("<dev string:x127>" + isdedicated());
            println("<dev string:x15b>");
        #/
        utc = getutc();
        if (isdefined(game.telemetry)) {
            game.telemetry.var_dc73ada2 = utc;
        }
        matchstart = {};
        matchstart.var_dc73ada2 = utc;
        matchstart.map = hash(util::get_map_name());
        matchstart.game_type = hash(level.gametype);
        matchstart.var_c8019fa4 = sessionmodeisprivateonlinegame();
        matchstart.var_137fea24 = sessionmodeissystemlink();
        matchstart.is_dedicated = isdedicated();
        function_92d1707f(#"hash_2d8b6733f192c69b", matchstart);
    }
}

// Namespace namespace_a77a81df/namespace_a77a81df
// Params 0, eflags: 0x0
// Checksum 0xe197fee, Offset: 0x4d8
// Size: 0x3d4
function function_d519e318() {
    if (util::isoneround() || util::waslastround()) {
        util::function_64ebd94d();
        /#
            println("<dev string:x197>" + function_f8d53445());
            println("<dev string:x1cb>" + gettime());
            println("<dev string:x1f9>" + util::get_map_name());
            println("<dev string:x222>" + level.gametype);
            println("<dev string:x250>" + getutc());
        #/
        utc = getutc();
        matchend = {};
        matchend.var_dc73ada2 = 0;
        matchend.var_44be7e07 = utc;
        matchend.map = hash(util::get_map_name());
        matchend.game_type = hash(level.gametype);
        matchend.var_c8019fa4 = sessionmodeisprivateonlinegame();
        matchend.var_137fea24 = sessionmodeissystemlink();
        matchend.is_dedicated = isdedicated();
        matchend.player_count = 0;
        matchend.life_count = 0;
        if (isdefined(game.telemetry.var_dc73ada2)) {
            time_seconds = utc - game.telemetry.var_dc73ada2;
            println("<dev string:x279>" + time_seconds);
            matchend.var_dc73ada2 = game.telemetry.var_dc73ada2;
        }
        match_duration = function_f8d53445() / 1000;
        println("<dev string:x2b3>" + match_duration);
        if (isdefined(game.telemetry.player_count)) {
            println("<dev string:x2f0>" + game.telemetry.player_count);
            matchend.player_count = game.telemetry.player_count;
        }
        if (isdefined(game.telemetry.life_count)) {
            println("<dev string:x322>" + game.telemetry.life_count);
            matchend.life_count = game.telemetry.life_count;
        }
        function_92d1707f(#"hash_1b52f03009c8c97e", matchend);
        println("<dev string:x352>");
    }
}

// Namespace namespace_a77a81df/namespace_a77a81df
// Params 0, eflags: 0x0
// Checksum 0x6d5ef41d, Offset: 0x8b8
// Size: 0x324
function on_player_connect() {
    if (!is_true(self.pers[#"telemetry"].connected)) {
        /#
            println("<dev string:x38c>" + gettime());
            println("<dev string:x3bf>" + getutc());
            println("<dev string:x3f5>" + self.name);
        #/
        if (!isdefined(self.pers[#"telemetry"])) {
            self.pers[#"telemetry"] = {};
        }
        self.pers[#"telemetry"].utc_connect_time_s = getutc();
        self.pers[#"telemetry"].connected = 1;
        self.pers[#"telemetry"].xp_at_start = self rank::getrankxp();
        self.pers[#"telemetry"].var_9f177532 = self rank::getrank();
        if (isdefined(game.telemetry.player_count)) {
            self.pers[#"telemetry"].var_6ba64843 = game.telemetry.player_count;
            game.telemetry.player_count++;
            println("<dev string:x425>" + game.telemetry.player_count);
        } else {
            println("<dev string:x45d>");
            return;
        }
        println("<dev string:x4bb>");
        playerdata = {};
        playerdata.utc_connect_time_s = self.pers[#"telemetry"].utc_connect_time_s;
        playerdata.var_6ba64843 = isdefined(self.pers[#"telemetry"].var_6ba64843) ? self.pers[#"telemetry"].var_6ba64843 : 0;
        self function_678f57c8(#"hash_2d1a41c5bbfe18dd", playerdata);
    }
}

// Namespace namespace_a77a81df/namespace_a77a81df
// Params 0, eflags: 0x0
// Checksum 0x870e0907, Offset: 0xbe8
// Size: 0x7cc
function on_player_disconnect() {
    if (!is_true(self.pers[#"telemetry"].connected)) {
        return;
    }
    self.pers[#"telemetry"].connected = 0;
    playerdata = {};
    /#
        println("<dev string:x500>" + self.name);
        println("<dev string:x533>" + gettime());
    #/
    playerdata.utc_connect_time_s = 0;
    playerdata.utc_disconnect_time_s = 0;
    playerdata.var_37b8e421 = 0;
    utc = getutc();
    if (isdefined(self.pers[#"telemetry"].utc_connect_time_s)) {
        playerdata.utc_connect_time_s = self.pers[#"telemetry"].utc_connect_time_s;
        playerdata.utc_disconnect_time_s = utc;
        playerdata.var_37b8e421 = utc - playerdata.utc_connect_time_s;
    }
    playerdata.var_6ba64843 = isdefined(self.pers[#"telemetry"].var_6ba64843) ? self.pers[#"telemetry"].var_6ba64843 : 0;
    if (isdefined(self.pers)) {
        playerdata.score = isdefined(self.pers[#"score"]) ? self.pers[#"score"] : 0;
        playerdata.kills = isdefined(self.pers[#"kills"]) ? self.pers[#"kills"] : 0;
        playerdata.deaths = isdefined(self.pers[#"deaths"]) ? self.pers[#"deaths"] : 0;
        playerdata.headshots = isdefined(self.pers[#"headshots"]) ? self.pers[#"headshots"] : 0;
        playerdata.assists = isdefined(self.pers[#"assists"]) ? self.pers[#"assists"] : 0;
        playerdata.damage_dealt = isdefined(self.pers[#"damagedone"]) ? self.pers[#"damagedone"] : 0;
        playerdata.suicides = isdefined(self.pers[#"suicides"]) ? self.pers[#"suicides"] : 0;
        playerdata.shots = isdefined(self.pers[#"shots"]) ? self.pers[#"shots"] : 0;
        playerdata.hits = isdefined(self.pers[#"hits"]) ? self.pers[#"hits"] : 0;
        playerdata.time_played_alive = isdefined(self.pers[#"time_played_alive"]) ? self.pers[#"time_played_alive"] : 0;
        playerdata.var_ef5017c7 = isdefined(self.pers[#"best_kill_streak"]) ? self.pers[#"best_kill_streak"] : 0;
        playerdata.multikills = isdefined(self.pers[#"hash_104ec9727c3d4ef7"]) ? self.pers[#"hash_104ec9727c3d4ef7"] : 0;
        playerdata.var_fc1e4ef3 = isdefined(self.pers[#"highestmultikill"]) ? self.pers[#"highestmultikill"] : 0;
    }
    playerdata.xp_at_start = isdefined(self.pers[#"telemetry"].xp_at_start) ? self.pers[#"telemetry"].xp_at_start : 0;
    playerdata.xp_at_end = self rank::getrankxp();
    playerdata.var_9f177532 = isdefined(self.pers[#"telemetry"].var_9f177532) ? self.pers[#"telemetry"].var_9f177532 : 0;
    playerdata.var_735f5996 = self rank::getrank();
    if (!is_true(level.disablestattracking)) {
        playerdata.var_9ffd4086 = self stats::get_stat_global(#"kills");
        playerdata.var_56c22769 = self stats::get_stat_global(#"deaths");
        playerdata.var_3c57e59 = self stats::get_stat_global(#"wins");
        playerdata.var_e42ad7c9 = self stats::get_stat_global(#"losses");
        playerdata.var_270e8e42 = self stats::get_stat_global(#"ties");
        playerdata.var_4c4d425a = self stats::get_stat_global(#"hits");
        playerdata.var_5197016d = self stats::get_stat_global(#"misses");
        playerdata.var_359ee86a = self stats::get_stat_global(#"time_played_total");
        playerdata.var_4ab9220a = self stats::get_stat_global(#"score");
    }
    self function_678f57c8(#"hash_4a80e3ea4f031ba4", playerdata);
}

// Namespace namespace_a77a81df/namespace_a77a81df
// Params 0, eflags: 0x0
// Checksum 0x4bd10402, Offset: 0x13c0
// Size: 0x1a4
function on_player_spawned() {
    if (!isdefined(self.pers[#"telemetry"])) {
        self.pers[#"telemetry"] = {};
    }
    self.pers[#"telemetry"].life = {};
    self.pers[#"telemetry"].life.var_62c7b24e = function_f8d53445();
    self.pers[#"telemetry"].life.spawn_origin = self.origin;
    if (isdefined(game.telemetry.life_count)) {
        self.pers[#"telemetry"].life.life_index = game.telemetry.life_count;
        game.telemetry.life_count++;
        /#
            println("<dev string:x569>" + self.name);
            println("<dev string:x599>" + game.telemetry.life_count);
        #/
    }
    println("<dev string:x5cf>");
}

// Namespace namespace_a77a81df/namespace_a77a81df
// Params 0, eflags: 0x0
// Checksum 0xf18ec9dd, Offset: 0x1570
// Size: 0x14c
function function_f0ffff28() {
    if (util::isoneround() || util::waslastround()) {
    }
    var_87e50fa8 = function_f8d53445();
    var_a7dd086f = isalive(self);
    telemetry::function_f397069a();
    if (var_a7dd086f && isdefined(self)) {
        data = {};
        data.victim = self;
        data.attacker = undefined;
        data.weapon = undefined;
        data.victimweapon = undefined;
        data.died = 0;
        if (isdefined(data.victim.pers[#"telemetry"].life)) {
            data.victim.pers[#"telemetry"].life.var_75cd3884 = var_87e50fa8;
        }
        function_607901f4(data);
    }
}

// Namespace namespace_a77a81df/namespace_a77a81df
// Params 1, eflags: 0x0
// Checksum 0x88947666, Offset: 0x16c8
// Size: 0x114
function function_55a7ded6(data) {
    if (!isdefined(data.victim) || !isplayer(data.victim)) {
        return;
    }
    if (isdefined(data.victim.pers[#"telemetry"].life)) {
        data.victim.pers[#"telemetry"].life.var_75cd3884 = function_f8d53445();
    }
    /#
        println("<dev string:x615>" + data.victim.name);
        println("<dev string:x615>" + function_f8d53445());
    #/
}

// Namespace namespace_a77a81df/namespace_a77a81df
// Params 1, eflags: 0x0
// Checksum 0xb77079b1, Offset: 0x17e8
// Size: 0xb44
function function_607901f4(data) {
    if (!isdefined(data.victim) || !isplayer(data.victim)) {
        return;
    }
    /#
        println("<dev string:x647>" + data.victim.name);
        println("<dev string:x678>" + function_f8d53445());
    #/
    died = 1;
    if (isdefined(data.died)) {
        died = data.died;
    }
    deathdata = {};
    deathdata.died = died;
    deathdata.var_62c7b24e = 0;
    deathdata.var_75cd3884 = 0;
    deathdata.var_39872854 = 0;
    if (isdefined(data.victim.pers[#"telemetry"].life.var_62c7b24e)) {
        deathdata.var_62c7b24e = data.victim.pers[#"telemetry"].life.var_62c7b24e;
        if (isdefined(data.victim.pers[#"telemetry"].life.var_75cd3884)) {
            deathdata.var_75cd3884 = data.victim.pers[#"telemetry"].life.var_75cd3884;
            deathdata.var_39872854 = deathdata.var_75cd3884 - deathdata.var_62c7b24e;
        }
    }
    deathdata.var_5b58152b = isdefined(data.victim.var_6fd69072) ? data.victim.var_6fd69072 : 0;
    deathdata.var_41d1b088 = isdefined(data.victim.var_8cb03411) ? data.victim.var_8cb03411 : 0;
    deathdata.var_f079a94e = 0;
    if (squad_spawn::function_d072f205()) {
        deathdata.var_f079a94e = 1;
    }
    deathdata.spawn_type = isdefined(data.victim.spawn.var_a9914487) ? data.victim.spawn.var_a9914487 : 0;
    deathdata.var_d5eb9cb8 = isdefined(data.victim.spawn.var_4db23b) ? data.victim.spawn.var_4db23b : 0;
    deathdata.life_index = -1;
    if (isdefined(data.victim.pers[#"telemetry"].life.life_index)) {
        deathdata.life_index = data.victim.pers[#"telemetry"].life.life_index;
    }
    if (isdefined(data.victim.pers[#"telemetry"].life.spawn_origin)) {
        deathdata.var_8b82b087 = data.victim.pers[#"telemetry"].life.spawn_origin[0];
        deathdata.var_9d3f5400 = data.victim.pers[#"telemetry"].life.spawn_origin[1];
        deathdata.var_ab1e6fbe = data.victim.pers[#"telemetry"].life.spawn_origin[2];
    }
    if (died) {
        deathdata.var_a8ffa14f = data.victimorigin[0];
        deathdata.var_e6a11c91 = data.victimorigin[1];
        deathdata.var_d4717832 = data.victimorigin[2];
        victimangles = isdefined(data.victimangles) ? data.victimangles : data.victim getplayerangles();
        deathdata.var_7c125af5 = victimangles[0];
        deathdata.var_8d9bfe08 = victimangles[1];
        deathdata.var_506d83ac = victimangles[2];
        deathdata.var_873aa898 = hash(data.victimstance);
        deathdata.means_of_death = hash(data.smeansofdeath);
        deathdata.hit_location = hash(isdefined(data.shitloc) ? data.shitloc : "");
        deathdata.var_144a7f3 = data.var_f0b3c772;
        if (isdefined(data.victimweapon)) {
            deathdata.victim_weapon = data.victimweapon.name;
            var_7336c848 = data.victimweapon.attachments;
            if (var_7336c848.size > 0) {
                var_4d60586 = [];
                for (i = 0; i < var_7336c848.size; i++) {
                    var_4d60586[i] = hash(var_7336c848[i]);
                }
                deathdata.var_fcdf958f = var_4d60586;
            }
        }
        if (isdefined(data.attacker) && isplayer(data.attacker)) {
            attackerpos = isdefined(data.attackerorigin) ? data.attackerorigin : data.attacker.origin;
            attackerangles = isdefined(data.attackerangles) ? data.attackerangles : data.attacker getplayerangles();
            deathdata.var_47f53c15 = attackerpos[0];
            deathdata.var_1a44e0b5 = attackerpos[1];
            deathdata.var_ed820730 = attackerpos[2];
            deathdata.var_f202c401 = attackerangles[0];
            deathdata.var_72c6458a = attackerangles[1];
            deathdata.var_840c6816 = attackerangles[2];
            deathdata.var_4d858e3d = hash(isdefined(data.attackerstance) ? data.attackerstance : "");
            deathdata.var_1ec9deac = data.attacker playerads();
            deathdata.var_11737fc2 = util::within_fov(attackerpos, attackerangles, data.victimorigin, 0.5);
            deathdata.var_cc3e142b = util::within_fov(data.victimorigin, victimangles, attackerpos, 0.5);
        }
        if (isdefined(data.weapon)) {
            deathdata.attacker_weapon = data.weapon.name;
            weapon_attachments = data.weapon.attachments;
            if (weapon_attachments.size > 0) {
                var_4e00795d = [];
                for (i = 0; i < weapon_attachments.size; i++) {
                    var_4e00795d[i] = hash(weapon_attachments[i]);
                }
                deathdata.var_f5205237 = var_4e00795d;
            }
        }
    }
    if (isdefined(data.victim.class_num)) {
        if (!isdefined(data.victim.pers[#"telemetry"].var_728f5d7d)) {
            data.victim.pers[#"telemetry"].var_728f5d7d = [];
        }
        var_6165a2d8 = data.victim function_13f24803(data.victim.class_num);
        if (isdefined(var_6165a2d8)) {
            var_75000956 = data.victim.pers[#"telemetry"].var_728f5d7d;
            sent = 0;
            for (i = 0; i < var_75000956.size; i++) {
                if (var_75000956[i] == var_6165a2d8) {
                    sent = 1;
                    break;
                }
            }
            if (!sent) {
                var_75000956[var_75000956.size] = var_6165a2d8;
                println("<dev string:x6b7>" + var_6165a2d8);
            }
        }
    }
    /#
        if (isdefined(deathdata.life_index)) {
            println("<dev string:x6f6>" + deathdata.life_index);
        } else {
            println("<dev string:x749>");
        }
    #/
    if (isdefined(data.attacker) && isplayer(data.attacker)) {
        data.victim function_678f57c8(#"hash_56b3bb4a34717783", deathdata, #"attacker", data.attacker);
        return;
    }
    data.victim function_678f57c8(#"hash_56b3bb4a34717783", deathdata);
}

