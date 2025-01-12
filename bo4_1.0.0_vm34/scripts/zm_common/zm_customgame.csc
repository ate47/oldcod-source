#using script_42409fc24e357285;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;

#namespace zm_customgame;

// Namespace zm_customgame/zm_customgame
// Params 0, eflags: 0x2
// Checksum 0xeb0e8f9c, Offset: 0xe8
// Size: 0xd6
function autoexec function_107d2a00() {
    clientfield::register("clientuimodel", "zmhud.damage_point_shake", 1, 1, "counter", undefined, 0, 0);
    callback::on_localplayer_spawned(&function_4e54e868);
    level.zmGameTimer = zm_game_timer::register("zmGameTimer");
    level.var_25eb7190 = function_5d804236();
    if (getgametypesetting(#"zmhealthdrain")) {
        level.var_b33aa896 = &function_1b6b4701;
    }
}

// Namespace zm_customgame/zm_customgame
// Params 1, eflags: 0x0
// Checksum 0x98b9aa93, Offset: 0x1c8
// Size: 0x27e
function function_4e54e868(localclientnum) {
    localplayer = function_f97e7787(localclientnum);
    switch (getgametypesetting(#"zmhealthstartingbars")) {
    case 3:
    default:
        var_5375bd93 = 0;
        break;
    case 4:
        var_5375bd93 = 1;
        break;
    case 5:
        var_5375bd93 = 2;
        break;
    case 6:
        var_5375bd93 = 3;
        break;
    case 2:
        var_5375bd93 = -1;
        break;
    case 1:
        var_5375bd93 = -2;
        break;
    case 0:
        var_5375bd93 = -3;
        break;
    }
    zmdifficultysettings = getscriptbundle("zm_base_difficulty");
    switch (level.gamedifficulty) {
    case 0:
        str_suffix = "_E";
        break;
    case 1:
    default:
        str_suffix = "_N";
        break;
    case 2:
        str_suffix = "_H";
        break;
    case 3:
        str_suffix = "_I";
        break;
    }
    n_base = zmdifficultysettings.("plyBaseHealth" + str_suffix);
    n_target = int(max(n_base + 50 * var_5375bd93, 1));
    localplayer.var_fdaf1ef6 = n_target;
}

// Namespace zm_customgame/zm_customgame
// Params 0, eflags: 0x0
// Checksum 0x90bd7dbc, Offset: 0x450
// Size: 0xa2
function function_5d804236() {
    var_b23863a9 = getgametypesetting(#"zmlaststandduration");
    switch (var_b23863a9) {
    case 0:
        return undefined;
    case 1:
        return 20;
    case 3:
        return 60;
    }
    return getdvarfloat(#"player_laststandbleedouttime", 0);
}

// Namespace zm_customgame/zm_customgame
// Params 3, eflags: 0x4
// Checksum 0xfbf41f88, Offset: 0x500
// Size: 0x44
function private function_1b6b4701(local_client_num, player, damage) {
    if (int(damage) == 5) {
        return true;
    }
    return false;
}

