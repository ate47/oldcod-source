#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapon_utils;

#namespace battlechatter;

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x1 linked
// Checksum 0x5723f3c9, Offset: 0x1a8
// Size: 0x80
function dialog_chance(chancekey) {
    dialogchance = mpdialog_value(chancekey);
    if (!isdefined(dialogchance) || dialogchance <= 0) {
        return false;
    } else if (dialogchance >= 100) {
        return true;
    }
    return randomint(100) < dialogchance;
}

// Namespace battlechatter/namespace_7819da81
// Params 2, eflags: 0x1 linked
// Checksum 0xb7d27263, Offset: 0x230
// Size: 0xa2
function mpdialog_value(mpdialogkey, defaultvalue) {
    if (!isdefined(mpdialogkey)) {
        return defaultvalue;
    }
    if (!isdefined(level.var_36301b61)) {
        level.var_36301b61 = getscriptbundle("mpdialog_default");
    }
    mpdialog = level.var_36301b61;
    if (!isdefined(mpdialog)) {
        return defaultvalue;
    }
    structvalue = mpdialog.(mpdialogkey);
    if (!isdefined(structvalue)) {
        return defaultvalue;
    }
    return structvalue;
}

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x1 linked
// Checksum 0x4a0211a0, Offset: 0x2e0
// Size: 0x42
function function_e05060f0(player) {
    playerbundle = function_58c93260(player);
    if (!isdefined(playerbundle)) {
        return undefined;
    }
    return playerbundle.voiceprefix;
}

// Namespace battlechatter/namespace_7819da81
// Params 2, eflags: 0x1 linked
// Checksum 0xedfea870, Offset: 0x330
// Size: 0x130
function function_58c93260(player, meansofdeath) {
    if (!isplayer(player)) {
        return undefined;
    }
    bundlename = player getmpdialogname();
    if (!isdefined(bundlename)) {
        return undefined;
    }
    if (isdefined(meansofdeath) && meansofdeath == "MOD_META" && isdefined(self.pers) && (isdefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0)) {
        bundlename = self.var_89c4a60f;
    }
    if (!isdefined(level.var_acb08231)) {
        level.var_acb08231 = [];
    }
    if (!isdefined(level.var_acb08231[bundlename])) {
        level.var_acb08231[bundlename] = getscriptbundle(bundlename);
    }
    return level.var_acb08231[bundlename];
}

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x1 linked
// Checksum 0xc21220a, Offset: 0x468
// Size: 0xb0
function function_cdd81094(weapon) {
    assert(isdefined(weapon));
    if (!isdefined(weapon.var_5c238c21)) {
        return undefined;
    }
    if (!isdefined(level.var_acb08231)) {
        level.var_acb08231 = [];
    }
    if (!isdefined(level.var_acb08231[weapon.var_5c238c21])) {
        level.var_acb08231[weapon.var_5c238c21] = getscriptbundle(weapon.var_5c238c21);
    }
    return level.var_acb08231[weapon.var_5c238c21];
}

// Namespace battlechatter/namespace_7819da81
// Params 0, eflags: 0x1 linked
// Checksum 0xc36a8a88, Offset: 0x520
// Size: 0x12
function function_e1983f22() {
    return sessionmodeismultiplayergame();
}

// Namespace battlechatter/namespace_7819da81
// Params 3, eflags: 0x1 linked
// Checksum 0x83db6d5f, Offset: 0x540
// Size: 0x196
function function_d804d2f0(speakingplayer, player, allyradiussq) {
    if (!isdefined(player) || !isdefined(player.origin) || !isdefined(speakingplayer) || !isdefined(speakingplayer.origin) || !isalive(player) || player.sessionstate != "playing" || player.playingdialog || player isplayerunderwater() || player isremotecontrolling() || player isinvehicle() || player isweaponviewonlylinked() || player == speakingplayer || player.team != speakingplayer.team || player.playerrole == speakingplayer.playerrole || player hasperk(#"specialty_quieter")) {
        return false;
    }
    distsq = distancesquared(speakingplayer.origin, player.origin);
    if (distsq > allyradiussq) {
        return false;
    }
    return true;
}

// Namespace battlechatter/namespace_7819da81
// Params 2, eflags: 0x1 linked
// Checksum 0x827f5375, Offset: 0x6e0
// Size: 0x152
function function_5d15920e(dialogkey, playerbundle) {
    if (dialogkey === playerbundle.exertdeathdrowned) {
        return "MOD_DROWN";
    }
    if (dialogkey === playerbundle.var_44d86dec) {
        return "MOD_EXPLOSIVE";
    }
    if (dialogkey === playerbundle.exertdeathburned) {
        return "MOD_BURNED";
    }
    if (dialogkey === playerbundle.exertdeathstabbed) {
        return "MOD_MELEE_WEAPON_BUTT";
    }
    if (dialogkey === playerbundle.var_207908de) {
        return "MOD_HEAD_SHOT";
    }
    if (dialogkey === playerbundle.var_1dfcabbd) {
        return "MOD_FALLING";
    }
    if (dialogkey === playerbundle.exertdeath) {
        return "MOD_UNKNOWN";
    }
    if (dialogkey === playerbundle.var_48305ed9) {
        return "MOD_DOT_SELF";
    }
    if (dialogkey === playerbundle.var_f8b4bcc1) {
        return "MOD_DOT";
    }
    if (dialogkey === playerbundle.exertdeathstabbed) {
        return "MOD_MELEE_ASSASSINATE";
    }
    if (dialogkey === playerbundle.exertdeathelectrocuted) {
        return "MOD_ELECTROCUTED";
    }
    if (dialogkey === playerbundle.var_53f25688) {
        return "MOD_MELEE_WEAPON_BUTT";
    }
    if (dialogkey === playerbundle.var_7a45f37b) {
        return "MOD_GAS";
    }
    return "MOD_UNKNOWN";
}

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x1 linked
// Checksum 0xd937fafd, Offset: 0x840
// Size: 0x102
function get_closest_player_ally(teamonly) {
    if (!level.teambased) {
        return undefined;
    }
    players = self get_friendly_players();
    players = arraysort(players, self.origin);
    foreach (player in players) {
        if (player == self || !player can_play_dialog(teamonly)) {
            continue;
        }
        return player;
    }
    return undefined;
}

// Namespace battlechatter/namespace_7819da81
// Params 2, eflags: 0x1 linked
// Checksum 0x5c1ebf55, Offset: 0x950
// Size: 0xee
function get_closest_player_enemy(origin = self.origin, teamonly) {
    players = self get_enemy_players();
    players = arraysort(players, origin);
    foreach (player in players) {
        if (!player can_play_dialog(teamonly)) {
            continue;
        }
        return player;
    }
    return undefined;
}

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x1 linked
// Checksum 0xf1bc265e, Offset: 0xa48
// Size: 0x100
function can_play_dialog(teamonly) {
    if (!isplayer(self) || !isalive(self) || self.playingdialog === 1 || self isplayerunderwater() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked()) {
        return false;
    }
    if (isdefined(teamonly) && !teamonly && self hasperk(#"specialty_quieter")) {
        return false;
    }
    return true;
}

// Namespace battlechatter/namespace_7819da81
// Params 0, eflags: 0x1 linked
// Checksum 0x6ef0160, Offset: 0xb50
// Size: 0xc8
function get_friendly_players() {
    players = [];
    if (level.teambased && isdefined(self.team)) {
        foreach (player in function_a1ef346b(self.team)) {
            players[players.size] = player;
        }
    } else {
        players[0] = self;
    }
    return players;
}

// Namespace battlechatter/namespace_7819da81
// Params 0, eflags: 0x1 linked
// Checksum 0xebeb75e2, Offset: 0xc20
// Size: 0x1be
function get_enemy_players() {
    players = [];
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            if (team == self.team) {
                continue;
            }
            foreach (player in function_a1ef346b(team)) {
                players[players.size] = player;
            }
        }
    } else {
        foreach (player in function_a1ef346b()) {
            if (player != self) {
                players[players.size] = player;
            }
        }
    }
    return players;
}

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x0
// Checksum 0x36e14fc9, Offset: 0xde8
// Size: 0xfa
function function_94b5718c(*entity) {
    selfeye = self geteyeapprox();
    foreach (enemy in get_enemy_players()) {
        if (!isdefined(enemy)) {
            continue;
        }
        enemyeye = enemy geteyeapprox();
        if (sighttracepassed(selfeye, enemyeye, 0, enemy)) {
            return enemy;
        }
    }
    return undefined;
}

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x0
// Checksum 0x29d3b92d, Offset: 0xef0
// Size: 0xb4
function get_random_key(dialogkey) {
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return undefined;
    }
    if (!isdefined(level.var_f53efe5c[bundlename]) || !isdefined(level.var_f53efe5c[bundlename][dialogkey]) || level.var_f53efe5c[bundlename][dialogkey] == 0) {
        return dialogkey;
    }
    return dialogkey + randomint(level.var_f53efe5c[bundlename][dialogkey]);
}

// Namespace battlechatter/namespace_7819da81
// Params 2, eflags: 0x1 linked
// Checksum 0x96b420ce, Offset: 0xfb0
// Size: 0x160
function get_player_dialog_alias(dialogkey, meansofdeath) {
    if (!isplayer(self)) {
        return undefined;
    }
    bundlename = self getmpdialogname();
    if (isdefined(meansofdeath) && meansofdeath == "MOD_META" && (isdefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0)) {
        bundlename = self.var_89c4a60f;
    }
    if (!isdefined(bundlename)) {
        return undefined;
    }
    playerbundle = getscriptbundle(bundlename);
    if (!isdefined(playerbundle)) {
        return undefined;
    }
    if (!isdefined(playerbundle) || !isdefined(dialogkey)) {
        return undefined;
    }
    dialogalias = playerbundle.(dialogkey);
    if (!isdefined(dialogalias)) {
        return;
    }
    voiceprefix = playerbundle.("voiceprefix");
    if (isdefined(voiceprefix)) {
        dialogalias = voiceprefix + dialogalias;
    }
    return dialogalias;
}

// Namespace battlechatter/namespace_7819da81
// Params 2, eflags: 0x0
// Checksum 0xa5a4825d, Offset: 0x1118
// Size: 0x102
function function_db89c38f(speakingplayer, allyradiussq) {
    allies = [];
    foreach (player in level.players) {
        if (!function_d804d2f0(speakingplayer, player, allyradiussq)) {
            continue;
        }
        allies[allies.size] = player;
    }
    allies = arraysort(allies, speakingplayer.origin);
    if (!isdefined(allies) || allies.size == 0) {
        return undefined;
    }
    return allies[0];
}

// Namespace battlechatter/namespace_7819da81
// Params 2, eflags: 0x1 linked
// Checksum 0xf662ac3d, Offset: 0x1228
// Size: 0x6c
function pick_boost_players(player1, player2) {
    player1 clientfield::set("play_boost", 1);
    player2 clientfield::set("play_boost", 2);
    game.boostplayerspicked[player1.team] = 1;
}

