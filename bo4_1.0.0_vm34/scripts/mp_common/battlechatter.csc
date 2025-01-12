#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dialog_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace battlechatter;

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x2
// Checksum 0xdeb4ece3, Offset: 0xc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"battlechatter", &__init__, undefined, undefined);
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0x70014cab, Offset: 0x108
// Size: 0xe2
function __init__() {
    level.var_ee00187e = &function_b03e7fd2;
    level.allowbattlechatter[#"bc"] = isdefined(getgametypesetting(#"allowbattlechatter")) && getgametypesetting(#"allowbattlechatter");
    level.allowspecialistdialog = dialog_shared::mpdialog_value("enableHeroDialog", 0) && isdefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"];
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x0
// Checksum 0xf650507f, Offset: 0x1f8
// Size: 0x19a
function function_ea793aac(localclientnum, speakingplayer, player, allyradiussq) {
    if (!isdefined(player)) {
        return false;
    }
    if (!isdefined(player.origin)) {
        return false;
    }
    if (!isalive(player)) {
        return false;
    }
    if (player underwater()) {
        return false;
    }
    if (player isdriving(localclientnum)) {
        return false;
    }
    if (function_8e3213c5(localclientnum)) {
        return false;
    }
    if (!isdefined(speakingplayer)) {
        return false;
    }
    if (!isdefined(speakingplayer.origin)) {
        return false;
    }
    if (player == speakingplayer || player.team != speakingplayer.team) {
        return false;
    }
    if (!isdefined(player.playerrole) || !isdefined(speakingplayer.playerrole)) {
        return false;
    }
    if (player function_d26a9de8(speakingplayer)) {
        return false;
    }
    distsq = distancesquared(speakingplayer.origin, player.origin);
    if (distsq > allyradiussq) {
        return false;
    }
    return true;
}

// Namespace battlechatter/battlechatter
// Params 3, eflags: 0x0
// Checksum 0xeb24a2f4, Offset: 0x3a0
// Size: 0x114
function function_18e49eb8(localclientnum, speakingplayer, allyradiussq) {
    allies = [];
    foreach (player in getplayers(localclientnum)) {
        if (!function_ea793aac(localclientnum, speakingplayer, player, allyradiussq)) {
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

// Namespace battlechatter/battlechatter
// Params 5, eflags: 0x0
// Checksum 0x490ac00e, Offset: 0x4c0
// Size: 0xb4
function function_1c6bcb2e(localclientnum, successplayer, var_ab2f958e, var_487d1298, seed) {
    while (soundplaying(var_ab2f958e)) {
        waitframe(1);
    }
    wait 0.4;
    if (!isdefined(successplayer)) {
        return;
    }
    var_6c8f4df5 = function_18e49eb8(localclientnum, successplayer, 250000);
    if (!isdefined(var_6c8f4df5)) {
        return;
    }
    var_6c8f4df5 function_3af6cab3(0, var_487d1298, seed);
}

// Namespace battlechatter/battlechatter
// Params 3, eflags: 0x0
// Checksum 0xd4c35858, Offset: 0x580
// Size: 0x3bc
function function_b03e7fd2(attacker, weapon, seed) {
    bundlename = attacker getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    switch (weapon.name) {
    case #"hero_annihilator":
        var_345657b = playerbundle.annihilatorweaponsuccess;
        var_17194950 = playerbundle.var_399b874e;
        break;
    case #"sig_buckler_dw":
    case #"sig_buckler_turret":
        var_345657b = playerbundle.var_221ad365;
        var_17194950 = playerbundle.var_40c4f27c;
        break;
    case #"claymore":
        var_345657b = playerbundle.var_3cca61ae;
        break;
    case #"dog_ai_defaultmelee":
        var_345657b = playerbundle.var_5ef9848e;
        var_17194950 = playerbundle.var_bbe88cd7;
        break;
    case #"hero_flamethrower":
        var_345657b = playerbundle.purifierweaponsuccess;
        var_17194950 = playerbundle.var_fbe832f7;
        break;
    case #"eq_gravityslam":
        var_345657b = playerbundle.var_a1dfe247;
        var_17194950 = playerbundle.var_8664cd22;
        break;
    case #"gun_mini_turret":
        var_345657b = playerbundle.var_b6f4b797;
        var_17194950 = playerbundle.var_4ba2ddf2;
        break;
    case #"sig_bow_quickshot4":
        var_345657b = playerbundle.sparrowweaponsuccess;
        var_17194950 = playerbundle.var_3bb09f41;
        break;
    case #"hash_5a4932f4b8d8b37a":
        var_345657b = playerbundle.var_818ac305;
        var_17194950 = playerbundle.var_1cf4a61c;
        break;
    case #"shock_rifle":
    case #"hero_lightninggun":
        var_345657b = playerbundle.tempestweaponsuccess;
        var_17194950 = playerbundle.var_7b005fe3;
        break;
    case #"eq_tripwire":
        var_345657b = playerbundle.var_30a6194c;
        var_17194950 = playerbundle.var_b511fc39;
        break;
    case #"hero_pineapplegun":
        var_345657b = playerbundle.warmachineweaponsuccess;
        var_17194950 = playerbundle.var_c6a01b6c;
        break;
    default:
        break;
    }
    wait 0.85;
    if (!isdefined(attacker) || !isdefined(var_345657b)) {
        return;
    }
    var_1b8b3aa3 = attacker function_3af6cab3(0, var_345657b, seed);
    if (isdefined(var_17194950) && isdefined(var_1b8b3aa3)) {
        thread function_1c6bcb2e(0, attacker, var_1b8b3aa3, var_17194950, seed);
    }
}

