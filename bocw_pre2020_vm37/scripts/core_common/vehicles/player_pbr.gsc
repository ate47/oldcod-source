#using script_40fc784c60f9fa7b;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_pbr;

// Namespace player_pbr/player_pbr
// Params 0, eflags: 0x6
// Checksum 0x2f2c2293, Offset: 0xc8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_pbr", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_pbr/player_pbr
// Params 0, eflags: 0x5 linked
// Checksum 0x9a7f27b8, Offset: 0x118
// Size: 0x54
function private function_70a657d8() {
    vehicle::add_main_callback("player_pbr", &function_cc0af45d);
    setdvar(#"phys_buoyancy", 1);
}

// Namespace player_pbr/player_pbr
// Params 0, eflags: 0x5 linked
// Checksum 0x163334af, Offset: 0x178
// Size: 0x16c
function private function_cc0af45d() {
    self setmovingplatformenabled(1, 0);
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_b65217f6);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_674b9c5b);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_f2626e5f);
    callback::function_d8abfc3d(#"hash_551381cffdc79048", &function_ca11d4c2);
    self.var_96c0f900 = [];
    self.var_96c0f900[1] = 1000;
    self.var_96c0f900[2] = 1000;
    self thread player_vehicle::function_5bce3f3a(0, 1000);
    self thread player_vehicle::function_5bce3f3a(1, 1000);
    self thread player_vehicle::function_5bce3f3a(2, 1000);
}

// Namespace player_pbr/player_pbr
// Params 1, eflags: 0x1 linked
// Checksum 0x9a234a51, Offset: 0x2f0
// Size: 0x84
function function_b65217f6(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
    if (eventstruct.seat_index === 0) {
        self function_eb39313f(player);
    }
    self thread player_vehicle::function_e8e41bbb();
}

// Namespace player_pbr/player_pbr
// Params 1, eflags: 0x1 linked
// Checksum 0x41b866ce, Offset: 0x380
// Size: 0x5c
function function_674b9c5b(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (eventstruct.seat_index === 0) {
        self function_77fbc7d9(player);
    }
}

// Namespace player_pbr/player_pbr
// Params 1, eflags: 0x1 linked
// Checksum 0x7095b006, Offset: 0x3e8
// Size: 0x84
function function_f2626e5f(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
    if (eventstruct.seat_index === 0) {
        self function_eb39313f(player);
        return;
    }
    self function_77fbc7d9(player);
}

// Namespace player_pbr/player_pbr
// Params 1, eflags: 0x5 linked
// Checksum 0x990afd1, Offset: 0x478
// Size: 0xb4
function private function_ca11d4c2(params) {
    if (!isalive(self)) {
        return;
    }
    driver = self getseatoccupant(0);
    if (!isdefined(driver)) {
        return;
    }
    if (isvehicle(params.entity) && params.entity.scriptvehicletype !== "player_pbr") {
        array::add(self.var_9be5a571, params.entity, 0);
    }
}

// Namespace player_pbr/player_pbr
// Params 1, eflags: 0x1 linked
// Checksum 0x5a6efbaa, Offset: 0x538
// Size: 0x3c
function function_eb39313f(player) {
    if (!isdefined(self.var_9be5a571)) {
        self.var_9be5a571 = [];
    }
    self thread function_53f7a11f(player);
}

// Namespace player_pbr/player_pbr
// Params 1, eflags: 0x1 linked
// Checksum 0x2d850671, Offset: 0x580
// Size: 0x30
function function_77fbc7d9(player) {
    self.overridevehicledamage = undefined;
    if (isdefined(player)) {
        player notify(#"hash_2c76be993516dda2");
    }
}

// Namespace player_pbr/player_pbr
// Params 1, eflags: 0x1 linked
// Checksum 0xbed6c46d, Offset: 0x5b8
// Size: 0x20e
function function_53f7a11f(player) {
    self notify("44ad4cfb73a52baa");
    self endon("44ad4cfb73a52baa");
    self endon(#"death");
    player endon(#"death", #"exit_vehicle", #"change_seat");
    while (true) {
        self.overridevehicledamage = undefined;
        if (self.var_9be5a571.size > 0) {
            for (i = self.var_9be5a571.size - 1; i >= 0; i--) {
                vehicle = self.var_9be5a571[i];
                if (isvehicle(vehicle)) {
                    dist = distance2dsquared(self.origin, vehicle.origin);
                    if (dist >= 80000) {
                        arrayremovevalue(self.var_9be5a571, vehicle);
                        continue;
                    }
                    z_dist = self.origin[2] - vehicle.origin[2];
                    if (z_dist > 0 && dist <= 9000) {
                        if (isalive(vehicle)) {
                            self.overridevehicledamage = &function_786eff5d;
                            vehicle dodamage(vehicle.health, self.origin, player, self);
                        }
                        arrayremovevalue(self.var_9be5a571, vehicle);
                    }
                }
            }
        }
        waitframe(1);
    }
}

// Namespace player_pbr/player_pbr
// Params 15, eflags: 0x5 linked
// Checksum 0x59288c9e, Offset: 0x7d0
// Size: 0x104
function private function_786eff5d(einflictor, eattacker, idamage, *idflags, smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
    damage = partname;
    if (isplayer(modelindex)) {
        var_284da85d = modelindex getvehicleoccupied();
        if (var_284da85d === self) {
            if (isvehicle(damagefromunderneath) && vsurfacenormal === "MOD_EXPLOSIVE") {
                damage = 0;
            }
        }
    }
    return damage;
}

