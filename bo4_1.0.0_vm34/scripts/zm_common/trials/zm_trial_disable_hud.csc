#using scripts\core_common\system_shared;
#using scripts\zm\perk\zm_perk_death_perception;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_disable_hud;

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 0, eflags: 0x2
// Checksum 0x10ffbbe1, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_disable_hud", &__init__, undefined, undefined);
}

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 0, eflags: 0x0
// Checksum 0x5afe4a42, Offset: 0xd0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"disable_hud", &on_begin, &on_end);
}

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 2, eflags: 0x4
// Checksum 0x2070e2d, Offset: 0x138
// Size: 0x182
function private on_begin(local_client_num, params) {
    level.var_fc04f28d = 1;
    maxclients = getmaxlocalclients();
    for (localclientnum = 0; localclientnum < maxclients; localclientnum++) {
        if (isdefined(function_f97e7787(localclientnum))) {
            foreach (player in getplayers(localclientnum)) {
                player zm::function_d262a7c6(localclientnum);
            }
            foreach (player in getplayers(localclientnum)) {
                player zm_perk_death_perception::function_7659b49c(localclientnum);
            }
        }
    }
}

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 1, eflags: 0x4
// Checksum 0xcbf82e0c, Offset: 0x2c8
// Size: 0x17a
function private on_end(local_client_num) {
    level.var_fc04f28d = undefined;
    maxclients = getmaxlocalclients();
    for (localclientnum = 0; localclientnum < maxclients; localclientnum++) {
        if (isdefined(function_f97e7787(localclientnum))) {
            foreach (player in getplayers(localclientnum)) {
                player zm::function_d262a7c6(localclientnum);
            }
            foreach (player in getplayers(localclientnum)) {
                player zm_perk_death_perception::function_7659b49c(localclientnum);
            }
        }
    }
}

