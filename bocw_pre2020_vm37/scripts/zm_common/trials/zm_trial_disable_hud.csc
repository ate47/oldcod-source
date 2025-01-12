#using scripts\core_common\system_shared;
#using scripts\zm\perk\zm_perk_death_perception;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_disable_hud;

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 0, eflags: 0x6
// Checksum 0xf9d80fc7, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_disable_hud", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 0, eflags: 0x4
// Checksum 0xc7c7b237, Offset: 0xc8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"disable_hud", &on_begin, &on_end);
}

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 2, eflags: 0x4
// Checksum 0xd6f98360, Offset: 0x130
// Size: 0x2c
function private on_begin(*local_client_num, *params) {
    level thread function_40349f7c();
}

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 1, eflags: 0x0
// Checksum 0xc155ece1, Offset: 0x168
// Size: 0x1b0
function function_40349f7c(localclientnum) {
    level endon(#"hash_38932f8deb28b470", #"end_game");
    wait 12;
    level.var_dc60105c = 1;
    maxclients = getmaxlocalclients();
    for (localclientnum = 0; localclientnum < maxclients; localclientnum++) {
        if (isdefined(function_5c10bd79(localclientnum))) {
            foreach (player in getplayers(localclientnum)) {
                player zm::function_92f0c63(localclientnum);
            }
            foreach (player in getplayers(localclientnum)) {
                player zm_perk_death_perception::function_25410869(localclientnum);
            }
        }
    }
}

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 1, eflags: 0x4
// Checksum 0xaba21eb1, Offset: 0x320
// Size: 0x198
function private on_end(*local_client_num) {
    level notify(#"hash_38932f8deb28b470");
    level.var_dc60105c = undefined;
    maxclients = getmaxlocalclients();
    for (localclientnum = 0; localclientnum < maxclients; localclientnum++) {
        if (isdefined(function_5c10bd79(localclientnum))) {
            foreach (player in getplayers(localclientnum)) {
                player zm::function_92f0c63(localclientnum);
            }
            foreach (player in getplayers(localclientnum)) {
                player zm_perk_death_perception::function_25410869(localclientnum);
            }
        }
    }
}

