#using scripts\core_common\audio_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\vehicle_shared;

#namespace driving_fx;

// Namespace driving_fx/enter_vehicle
// Params 1, eflags: 0x40
// Checksum 0x6d05dd64, Offset: 0x138
// Size: 0x74
function event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
    if (!self isplayer()) {
        return;
    }
    vehicle = eventstruct.vehicle;
    localclientnum = eventstruct.localclientnum;
    self thread vehicle_enter(localclientnum, vehicle);
}

// Namespace driving_fx/driving_fx
// Params 2, eflags: 0x0
// Checksum 0x4788003e, Offset: 0x1b8
// Size: 0x114
function vehicle_enter(localclientnum, vehicle) {
    self endon(#"death");
    vehicle endon(#"death");
    waitframe(1);
    if (vehicle isdrivingvehicle(self)) {
        vehicle thread collision_thread(localclientnum);
        if (vehicle function_bbaf1d59()) {
            vehicle thread jump_landing_thread(localclientnum);
            vehicle thread suspension_thread(localclientnum);
        }
        if (self function_60dbc438()) {
            vehicle thread function_ef089b98(localclientnum, self);
            vehicle thread vehicle::lights_group_toggle(localclientnum, 1, 0);
        }
    }
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0xd5c25fea, Offset: 0x2d8
// Size: 0x300
function collision_thread(localclientnum) {
    self endon(#"death");
    self endon(#"exit_vehicle");
    while (true) {
        waitresult = self waittill(#"veh_collision");
        hip = waitresult.velocity;
        hitn = waitresult.normal;
        hit_intensity = waitresult.intensity;
        player = function_f97e7787(localclientnum);
        if (isdefined(self.driving_fx_collision_override)) {
            if (player function_60dbc438() && self isdrivingvehicle(player)) {
                self [[ self.driving_fx_collision_override ]](localclientnum, player, hip, hitn, hit_intensity);
            }
            continue;
        }
        if (isdefined(player) && isdefined(hit_intensity)) {
            if (hit_intensity > self.heavycollisionspeed) {
                volume = get_impact_vol_from_speed();
                var_98a9bc31 = self.var_98a9bc31;
                if (isdefined(var_98a9bc31)) {
                    alias = var_98a9bc31;
                } else {
                    alias = "veh_default_suspension_lg_hd";
                }
                self playsound(localclientnum, alias, undefined, volume);
                if (isdefined(self.heavycollisionrumble) && player function_60dbc438() && self isdrivingvehicle(player)) {
                    player playrumbleonentity(localclientnum, self.heavycollisionrumble);
                }
                continue;
            }
            if (hit_intensity > self.lightcollisionspeed) {
                volume = get_impact_vol_from_speed();
                var_bb6e1c8 = self.var_bb6e1c8;
                if (isdefined(var_bb6e1c8)) {
                    alias = var_bb6e1c8;
                } else {
                    alias = "veh_default_suspension_lg_lt";
                }
                self playsound(localclientnum, alias, undefined, volume);
                if (isdefined(self.lightcollisionrumble) && player function_60dbc438() && self isdrivingvehicle(player)) {
                    player playrumbleonentity(localclientnum, self.lightcollisionrumble);
                }
            }
        }
    }
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0x68d13917, Offset: 0x5e0
// Size: 0x178
function jump_landing_thread(localclientnum) {
    self endon(#"death");
    self endon(#"exit_vehicle");
    while (true) {
        self waittill(#"veh_landed");
        player = function_f97e7787(localclientnum);
        if (isdefined(player)) {
            if (isdefined(self.driving_fx_jump_landing_override)) {
                self [[ self.driving_fx_jump_landing_override ]](localclientnum, player);
                continue;
            }
            volume = get_impact_vol_from_speed();
            var_98a9bc31 = self.var_98a9bc31;
            if (isdefined(var_98a9bc31)) {
                alias = var_98a9bc31;
            } else {
                alias = "veh_default_suspension_lg_hd";
            }
            self playsound(localclientnum, alias, undefined, volume);
            if (isdefined(self.jumplandingrumble) && player function_60dbc438() && self isdrivingvehicle(player)) {
                player playrumbleonentity(localclientnum, self.jumplandingrumble);
            }
        }
    }
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0xc0a4dcac, Offset: 0x760
// Size: 0x148
function suspension_thread(localclientnum) {
    self endon(#"death");
    self endon(#"exit_vehicle");
    while (true) {
        self waittill(#"veh_suspension_limit_activated");
        player = function_f97e7787(localclientnum);
        if (isdefined(player)) {
            volume = get_impact_vol_from_speed();
            var_bb6e1c8 = self.var_bb6e1c8;
            if (isdefined(var_bb6e1c8)) {
                alias = var_bb6e1c8;
            } else {
                alias = "veh_default_suspension_lg_lt";
            }
            self playsound(localclientnum, alias, undefined, volume);
            if (player function_60dbc438() && self isdrivingvehicle(player)) {
                player playrumbleonentity(localclientnum, "damage_light");
            }
        }
    }
}

// Namespace driving_fx/driving_fx
// Params 0, eflags: 0x0
// Checksum 0x92afece6, Offset: 0x8b0
// Size: 0x86
function get_impact_vol_from_speed() {
    curspeed = self getspeed();
    maxspeed = self getmaxspeed();
    volume = audio::scale_speed(0, maxspeed, 0, 1, curspeed);
    volume = volume * volume * volume;
    return volume;
}

// Namespace driving_fx/driving_fx
// Params 0, eflags: 0x0
// Checksum 0x240f586b, Offset: 0x940
// Size: 0x230
function function_707eb1e4() {
    var_a7bf5e36 = array("front_right", "front_left", "middle_right", "middle_left", "back_right", "back_left");
    surfaces = [];
    foreach (var_68524a40 in var_a7bf5e36) {
        if (self function_c9080748(var_68524a40)) {
            if (!isdefined(surfaces)) {
                surfaces = [];
            } else if (!isarray(surfaces)) {
                surfaces = array(surfaces);
            }
            if (!isinarray(surfaces, function_115b67a9("water"))) {
                surfaces[surfaces.size] = function_115b67a9("water");
            }
        }
        if (!isdefined(surfaces)) {
            surfaces = [];
        } else if (!isarray(surfaces)) {
            surfaces = array(surfaces);
        }
        if (!isinarray(surfaces, function_115b67a9(self getwheelsurface(var_68524a40)))) {
            surfaces[surfaces.size] = function_115b67a9(self getwheelsurface(var_68524a40));
        }
    }
    arrayremovevalue(surfaces, undefined);
    return surfaces;
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0x2f672185, Offset: 0xb78
// Size: 0x6c
function function_115b67a9(surface) {
    switch (surface) {
    case #"dirt":
        return #"hash_69a53e8913317ecf";
    case #"water":
    case #"watershallow":
        return #"hash_7c5d3ac35353f95c";
    }
    return undefined;
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0x688c8428, Offset: 0xbf0
// Size: 0xc6
function stop_postfx_on_exit(var_5aa027a5) {
    self notify("stop_postfx_on_exit_" + var_5aa027a5);
    self endon("stop_postfx_on_exit_" + var_5aa027a5);
    self endon(#"death");
    self waittill(#"exit_vehicle");
    if (isdefined(self.var_c062832b) && isdefined(self.var_c062832b[var_5aa027a5]) && self postfx::function_7348f3a5(var_5aa027a5)) {
        self postfx::stoppostfxbundle(var_5aa027a5);
        self.var_c062832b[var_5aa027a5].exiting = 1;
    }
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0x9348b157, Offset: 0xcc0
// Size: 0x10e
function function_73906e02(var_5aa027a5) {
    if (!isdefined(self.var_c062832b)) {
        self.var_c062832b = [];
    }
    if (!isdefined(self.var_c062832b[var_5aa027a5])) {
        self.var_c062832b[var_5aa027a5] = {#exiting:1, #endtime:0};
    }
    if (self.var_c062832b[var_5aa027a5].exiting && !self postfx::function_7348f3a5(var_5aa027a5)) {
        self postfx::playpostfxbundle(var_5aa027a5);
        self thread stop_postfx_on_exit(var_5aa027a5);
        self.var_c062832b[var_5aa027a5].exiting = 0;
    }
    self.var_c062832b[var_5aa027a5].endtime = gettime() + 1000;
}

// Namespace driving_fx/driving_fx
// Params 2, eflags: 0x0
// Checksum 0x619490a8, Offset: 0xdd8
// Size: 0x10a
function function_484923db(var_31bf8d1f, var_30ef43a9) {
    if (!isdefined(self.var_c062832b)) {
        self.var_c062832b = [];
    }
    foreach (key, postfx in self.var_c062832b) {
        if (postfx.exiting) {
            continue;
        }
        if (!var_30ef43a9 || postfx.endtime <= gettime() && !isinarray(var_31bf8d1f, key)) {
            self postfx::exitpostfxbundle(key);
            self.var_c062832b[key].exiting = 1;
        }
    }
}

// Namespace driving_fx/driving_fx
// Params 2, eflags: 0x0
// Checksum 0x20c7e0d3, Offset: 0xef0
// Size: 0x228
function function_ef089b98(localclientnum, driver) {
    self notify("2845e7cd3f337941");
    self endon("2845e7cd3f337941");
    self endon(#"death", #"exit_vehicle");
    if (isdefined(self.var_f7798571) && self.var_f7798571) {
        return;
    }
    while (true) {
        wait 0.1;
        speed = self getspeed();
        player = function_f97e7787(localclientnum);
        if (isdefined(self.var_425b03d3)) {
            var_5aa027a5 = self [[ self.var_425b03d3 ]](localclientnum, driver);
        } else {
            var_5aa027a5 = self function_707eb1e4();
        }
        var_16cdab8d = 1;
        if (isdefined(self.var_7683471e)) {
            var_16cdab8d = self [[ self.var_7683471e ]](localclientnum, driver);
        }
        if (isdefined(self.var_4887bfe6)) {
            var_30ef43a9 = self [[ self.var_4887bfe6 ]](localclientnum, driver);
        } else {
            var_30ef43a9 = speed > 200;
        }
        if (var_30ef43a9 && var_16cdab8d) {
            foreach (postfx_bundle in var_5aa027a5) {
                player function_73906e02(postfx_bundle);
            }
        }
        player function_484923db(var_5aa027a5, var_30ef43a9);
    }
}

