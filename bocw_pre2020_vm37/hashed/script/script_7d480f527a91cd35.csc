#using script_2009cc4c4ecc010f;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_2b492b5d;

// Namespace namespace_2b492b5d/namespace_2b492b5d
// Params 0, eflags: 0x6
// Checksum 0x24aa9858, Offset: 0xa8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_53bffc80a49d74a7", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace namespace_2b492b5d/namespace_2b492b5d
// Params 1, eflags: 0x5 linked
// Checksum 0x157d6763, Offset: 0xf8
// Size: 0x54
function private function_70a657d8(*localclientnum) {
    vehicle::add_vehicletype_callback("player_muscle", &function_610f61d4);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace namespace_2b492b5d/namespace_2b492b5d
// Params 1, eflags: 0x5 linked
// Checksum 0x89545d71, Offset: 0x158
// Size: 0xc
function private function_610f61d4(*localclientnum) {
    
}

// Namespace namespace_2b492b5d/namespace_2b492b5d
// Params 1, eflags: 0x5 linked
// Checksum 0x10bed022, Offset: 0x170
// Size: 0x74
function private on_localplayer_spawned(localclientnum) {
    if (self function_21c0fa55()) {
        if (is_true(getgametypesetting(#"wzenablebountyhuntervehicles"))) {
            level thread function_8fd2e04f(localclientnum);
        }
    }
}

// Namespace namespace_2b492b5d/namespace_2b492b5d
// Params 1, eflags: 0x5 linked
// Checksum 0xf6bb0379, Offset: 0x1f0
// Size: 0x280
function private function_8fd2e04f(localclientnum) {
    while (true) {
        if (isarray(level.allvehicles)) {
            player = function_5c10bd79(localclientnum);
            playfx = isdefined(player) && isalive(player) && player player_vehicle::function_3ec2efae(localclientnum);
            foreach (vehicle in level.allvehicles) {
                var_5d188f8a = 0;
                foreach (occupant in vehicle getvehoccupants(localclientnum)) {
                    if (util::function_fbce7263(occupant.team, player.team)) {
                        var_5d188f8a = 1;
                        break;
                    }
                }
                if (playfx && vehicle.scriptvehicletype === "player_muscle" && var_5d188f8a) {
                    if (!isdefined(vehicle.var_2dc49011)) {
                        vehicle.var_2dc49011 = vehicle util::playfxontag(localclientnum, #"hash_77086882cbd57674", vehicle, "tag_origin");
                    }
                    continue;
                }
                if (isdefined(vehicle.var_2dc49011)) {
                    stopfx(localclientnum, vehicle.var_2dc49011);
                    vehicle.var_2dc49011 = undefined;
                }
            }
        }
        wait 0.2;
    }
}

