#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace wz_supply_stash;

// Namespace wz_supply_stash/wz_supply_stash
// Params 0, eflags: 0x6
// Checksum 0x182429d, Offset: 0xf0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_supply_stash", &preinit, undefined, undefined, undefined);
}

// Namespace wz_supply_stash/wz_supply_stash
// Params 0, eflags: 0x4
// Checksum 0xa0b47a8f, Offset: 0x138
// Size: 0x34
function private preinit() {
    level.var_cee10b49 = [];
    callback::on_localclient_connect(&on_localclient_connect);
}

// Namespace wz_supply_stash/wz_supply_stash
// Params 1, eflags: 0x4
// Checksum 0xd2892ff2, Offset: 0x178
// Size: 0x54
function private on_localclient_connect(localclientnum) {
    if (is_true(getgametypesetting(#"wzenablebountyhuntervehicles"))) {
        level thread function_53d906fd(localclientnum);
    }
}

// Namespace wz_supply_stash/wz_supply_stash
// Params 1, eflags: 0x4
// Checksum 0xea5ab731, Offset: 0x1d8
// Size: 0x2c4
function private function_53d906fd(localclientnum) {
    while (true) {
        player = function_5c10bd79(localclientnum);
        playfx = 0;
        if (isdefined(player) && isalive(player)) {
            vehicle = getplayervehicle(player);
            playfx = isdefined(vehicle) && vehicle.scriptvehicletype === "player_muscle";
        }
        foreach (stash in level.item_spawn_stashes) {
            if (function_8a8a409b(stash)) {
                if (stash.var_aa9f8f87 === #"supply_stash_parent_dlc1" || stash.var_aa9f8f87 === #"supply_stash_parent") {
                    stash update_fx(localclientnum, playfx, function_ffdbe8c2(stash));
                }
            }
        }
        foreach (drop in level.var_624588d5) {
            if (isdefined(drop) && is_true(drop.var_3a55f5cf)) {
                state = 0;
                if (drop getanimtime("p9_fxanim_mp_care_package_open_anim") > 0) {
                    state = 2;
                } else if (drop getanimtime("p8_fxanim_wz_supply_stash_04_open_anim") > 0) {
                    state = 1;
                }
                drop update_fx(localclientnum, playfx, state);
            }
        }
        wait 0.2;
    }
}

// Namespace wz_supply_stash/wz_supply_stash
// Params 3, eflags: 0x0
// Checksum 0x41b4f885, Offset: 0x4a8
// Size: 0xae
function update_fx(localclientnum, playfx, state) {
    if (playfx && state == 0) {
        if (!isdefined(self.var_d3d42148)) {
            self.var_d3d42148 = playfx(localclientnum, #"hash_6bcc939010112ea", self.origin);
        }
        return;
    }
    if (isdefined(self.var_d3d42148)) {
        stopfx(localclientnum, self.var_d3d42148);
        self.var_d3d42148 = undefined;
    }
}

