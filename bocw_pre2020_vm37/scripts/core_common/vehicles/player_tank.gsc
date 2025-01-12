#using script_40fc784c60f9fa7b;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_tank;

// Namespace player_tank/player_tank
// Params 0, eflags: 0x6
// Checksum 0xbd9b07fd, Offset: 0x188
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_tank", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_tank/player_tank
// Params 0, eflags: 0x5 linked
// Checksum 0x7348c9d3, Offset: 0x1d8
// Size: 0x5c
function private function_70a657d8() {
    vehicle::add_main_callback("player_tank", &function_c0f1d81b);
    clientfield::register("vehicle", "tank_shellejectfx", 1, 1, "int");
}

// Namespace player_tank/player_tank
// Params 0, eflags: 0x5 linked
// Checksum 0x905f988d, Offset: 0x240
// Size: 0x184
function private function_c0f1d81b() {
    self setmovingplatformenabled(1, 0);
    self.var_84fed14b = 0;
    self.var_d6691161 = 0;
    self.var_5d662124 = 2;
    callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_96f5d31b);
    callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_cd8db309);
    callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_b8458486);
    callback::function_d8abfc3d(#"hash_551381cffdc79048", &function_ed6455e7);
    callback::function_d8abfc3d(#"on_vehicle_damage", &on_vehicle_damage);
    callback::function_d8abfc3d(#"on_vehicle_killed", &function_4366bf50);
    self thread player_vehicle::function_5bce3f3a(1, 100);
}

// Namespace player_tank/player_tank
// Params 1, eflags: 0x5 linked
// Checksum 0x5f4197dd, Offset: 0x3d0
// Size: 0xb4
function private function_ed6455e7(params) {
    if (!isalive(self)) {
        return;
    }
    driver = self getseatoccupant(0);
    if (!isdefined(driver)) {
        return;
    }
    if (isvehicle(params.entity) && params.entity.scriptvehicletype !== "player_tank") {
        array::add(self.var_9be5a571, params.entity, 0);
    }
}

// Namespace player_tank/player_tank
// Params 1, eflags: 0x1 linked
// Checksum 0x51d06dae, Offset: 0x490
// Size: 0x206
function function_53f7a11f(player) {
    self notify("4174fc47d11c2694");
    self endon("4174fc47d11c2694");
    self endon(#"death");
    player endon(#"death", #"exit_vehicle", #"change_seat");
    while (true) {
        self.overridevehicledamage = undefined;
        if (self.var_9be5a571.size > 0) {
            for (i = self.var_9be5a571.size - 1; i >= 0; i--) {
                vehicle = self.var_9be5a571[i];
                if (isvehicle(vehicle)) {
                    dist = distance2dsquared(self.origin, vehicle.origin);
                    if (dist >= 64000) {
                        arrayremovevalue(self.var_9be5a571, vehicle);
                        continue;
                    }
                    z_dist = self.origin[2] - vehicle.origin[2];
                    if (z_dist > 0 && dist <= 9000) {
                        if (isalive(vehicle)) {
                            self.overridevehicledamage = &function_eed77231;
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

// Namespace player_tank/player_tank
// Params 1, eflags: 0x1 linked
// Checksum 0x4f279541, Offset: 0x6a0
// Size: 0xa4
function function_4366bf50(params) {
    eattacker = params.eattacker;
    weapon = params.weapon;
    if (isdefined(self.team) && isdefined(eattacker.team) && util::function_fbce7263(self.team, eattacker.team)) {
        scoreevents::processscoreevent(#"hash_218ad43ea7de500d", eattacker, undefined, weapon);
    }
}

// Namespace player_tank/player_tank
// Params 1, eflags: 0x5 linked
// Checksum 0x34324880, Offset: 0x750
// Size: 0x84
function private function_96f5d31b(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
    if (eventstruct.seat_index === 0) {
        self function_11397df9(player);
    }
    self thread function_2014e301(player);
}

// Namespace player_tank/player_tank
// Params 1, eflags: 0x5 linked
// Checksum 0x12dea8ef, Offset: 0x7e0
// Size: 0x5c
function private function_cd8db309(params) {
    eventstruct = params.eventstruct;
    player = params.player;
    if (eventstruct.seat_index === 0) {
        self function_eba4498a(player);
    }
}

// Namespace player_tank/player_tank
// Params 1, eflags: 0x1 linked
// Checksum 0x95b4dbd4, Offset: 0x848
// Size: 0x9c
function function_b8458486(params) {
    player = params.player;
    eventstruct = params.eventstruct;
    if (!isdefined(player)) {
        return;
    }
    if (eventstruct.seat_index === 0) {
        self function_11397df9(player);
        self thread function_2014e301(player);
        return;
    }
    self function_eba4498a(player);
}

// Namespace player_tank/player_tank
// Params 0, eflags: 0x5 linked
// Checksum 0x99db89f2, Offset: 0x8f0
// Size: 0x104
function private function_44f6c97c() {
    self endon(#"death");
    self notify("219d38f341d816d3");
    self endon("219d38f341d816d3");
    wait 0.5;
    self vehicle::toggle_control_bone_group(1, 1);
    self playsound("veh_tank_shell_hatch_open");
    wait 0.5;
    self clientfield::set("tank_shellejectfx", 1);
    wait 1.25;
    self clientfield::set("tank_shellejectfx", 0);
    self vehicle::toggle_control_bone_group(1, 0);
    self playsound("veh_tank_shell_hatch_close");
}

// Namespace player_tank/player_tank
// Params 1, eflags: 0x5 linked
// Checksum 0x58e41798, Offset: 0xa00
// Size: 0x110
function private function_2014e301(player) {
    player endon(#"hash_27646c99772610b4", #"death", #"exit_vehicle");
    self endon(#"death");
    while (true) {
        self waittill(#"weapon_fired");
        self thread function_44f6c97c();
        var_3212abd9 = self seatgetweapon(0);
        var_610cfafc = int(var_3212abd9.reloadtime * 1000);
        player setvehicleweaponwaitduration(var_610cfafc);
        player setvehicleweaponwaitendtime(gettime() + var_610cfafc);
    }
}

// Namespace player_tank/player_tank
// Params 1, eflags: 0x1 linked
// Checksum 0xdc758ce4, Offset: 0xb18
// Size: 0x54
function function_11397df9(player) {
    if (!isdefined(self.var_9be5a571)) {
        self.var_9be5a571 = [];
    }
    player.overrideplayerdamage = &function_7daf5af2;
    self thread function_53f7a11f(player);
}

// Namespace player_tank/player_tank
// Params 1, eflags: 0x1 linked
// Checksum 0xce8d4909, Offset: 0xb78
// Size: 0x40
function function_eba4498a(player) {
    self.overridevehicledamage = undefined;
    if (isdefined(player)) {
        player.overrideplayerdamage = undefined;
        player notify(#"hash_27646c99772610b4");
    }
}

// Namespace player_tank/player_tank
// Params 1, eflags: 0x5 linked
// Checksum 0xefc551d3, Offset: 0xbc0
// Size: 0x84
function private on_vehicle_damage(params) {
    if (isplayer(params.eattacker) && params.eattacker isinvehicle() && params.smeansofdeath === "MOD_PROJECTILE") {
        self playsound(#"hash_301ede6e928927f2");
    }
}

// Namespace player_tank/player_tank
// Params 15, eflags: 0x5 linked
// Checksum 0x89bd0ccd, Offset: 0xc50
// Size: 0x104
function private function_eed77231(einflictor, eattacker, idamage, *idflags, smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
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

// Namespace player_tank/player_tank
// Params 15, eflags: 0x5 linked
// Checksum 0x18767520, Offset: 0xd60
// Size: 0x120
function private function_7daf5af2(*einflictor, *eattacker, idamage, *idflags, smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
    damage = partname;
    vehicle = self getvehicleoccupied();
    if (!isvehicle(vehicle) || !isalive(vehicle)) {
        return damage;
    }
    if (vsurfacenormal === "MOD_DEATH_CIRCLE") {
        return damage;
    }
    if (vsurfacenormal === "MOD_TRIGGER_HURT") {
        return damage;
    }
    damage = 0;
    return damage;
}

