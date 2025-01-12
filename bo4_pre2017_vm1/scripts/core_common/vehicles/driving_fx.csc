#using scripts/core_common/audio_shared;

#namespace namespace_7db19bba;

// Namespace namespace_7db19bba/driving_fx
// Params 0, eflags: 0x0
// Checksum 0xad7cfa9a, Offset: 0x260
// Size: 0x20
function __constructor() {
    self.id = undefined;
    self.handle = -1;
}

// Namespace namespace_7db19bba/driving_fx
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x288
// Size: 0x4
function __destructor() {
    
}

// Namespace namespace_7db19bba/driving_fx
// Params 4, eflags: 0x0
// Checksum 0x7bd341ac, Offset: 0x298
// Size: 0x15c
function play(localclientnum, vehicle, fx_id, fx_tag) {
    if (!isdefined(fx_id)) {
        if (self.handle > 0) {
            stopfx(localclientnum, self.handle);
        }
        self.id = undefined;
        self.handle = -1;
        return;
    }
    if (!isdefined(self.id)) {
        self.id = fx_id;
        self.handle = playfxontag(localclientnum, self.id, vehicle, fx_tag);
        return;
    }
    if (!isdefined(self.id) || self.id != fx_id) {
        if (self.handle > 0) {
            stopfx(localclientnum, self.handle);
        }
        self.id = fx_id;
        self.handle = playfxontag(localclientnum, self.id, vehicle, fx_tag);
    }
}

// Namespace namespace_7db19bba/driving_fx
// Params 1, eflags: 0x0
// Checksum 0x59ce27e3, Offset: 0x400
// Size: 0x58
function stop(localclientnum) {
    if (self.handle > 0) {
        stopfx(localclientnum, self.handle);
    }
    self.id = undefined;
    self.handle = -1;
}

#namespace driving_fx;

// Namespace driving_fx/driving_fx
// Params 0, eflags: 0x6
// Checksum 0x60c60f7f, Offset: 0x460
// Size: 0xe6
function private autoexec function_7db19bba() {
    classes.var_7db19bba[0] = spawnstruct();
    classes.var_7db19bba[0].__vtable[-51025227] = &namespace_7db19bba::stop;
    classes.var_7db19bba[0].__vtable[1131512199] = &namespace_7db19bba::play;
    classes.var_7db19bba[0].__vtable[1606033458] = &namespace_7db19bba::__destructor;
    classes.var_7db19bba[0].__vtable[-1690805083] = &namespace_7db19bba::__constructor;
}

#namespace namespace_aeb003f6;

// Namespace namespace_aeb003f6/driving_fx
// Params 0, eflags: 0x0
// Checksum 0x92468f28, Offset: 0x550
// Size: 0x24
function __constructor() {
    self.name = "";
    self.tag_name = "";
}

// Namespace namespace_aeb003f6/driving_fx
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x580
// Size: 0x4
function __destructor() {
    
}

// Namespace namespace_aeb003f6/driving_fx
// Params 2, eflags: 0x0
// Checksum 0xb0a93365, Offset: 0x590
// Size: 0xcc
function init(_name, var_4db840da) {
    self.name = _name;
    self.tag_name = var_4db840da;
    self.ground_fx = [];
    [[ new class_7db19bba ]]->__constructor();
    self.ground_fx["skid"] = <error pop>;
    [[ new class_7db19bba ]]->__constructor();
    self.ground_fx["tread"] = <error pop>;
    self.ground_fx["tread"].id = "";
    self.ground_fx["tread"].handle = -1;
}

// Namespace namespace_aeb003f6/driving_fx
// Params 3, eflags: 0x0
// Checksum 0x88fb617, Offset: 0x668
// Size: 0x4d4
function update(localclientnum, vehicle, var_53b07afb) {
    if (vehicle.vehicleclass === "boat") {
        var_32b709f3 = 0;
        sliding = 0;
        trace = bullettrace(vehicle.origin + (0, 0, 60), vehicle.origin - (0, 0, 200), 0, vehicle);
        if (trace["fraction"] < 1) {
            surface = trace["surfacetype"];
        } else {
            [[ self.ground_fx["skid"] ]]->stop(localclientnum);
            [[ self.ground_fx["tread"] ]]->stop(localclientnum);
            return;
        }
    } else {
        if (!vehicle iswheelcolliding(self.name)) {
            [[ self.ground_fx["skid"] ]]->stop(localclientnum);
            [[ self.ground_fx["tread"] ]]->stop(localclientnum);
            return;
        }
        var_32b709f3 = vehicle iswheelpeelingout(self.name);
        sliding = vehicle iswheelsliding(self.name);
        surface = vehicle getwheelsurface(self.name);
    }
    origin = vehicle gettagorigin(self.tag_name) + (0, 0, 1);
    angles = vehicle gettagangles(self.tag_name);
    fwd = anglestoforward(angles);
    right = anglestoright(angles);
    rumble = 0;
    if (var_32b709f3) {
        var_7f1577dc = vehicle driving_fx::function_b237cc74("peel", surface);
        if (isdefined(var_7f1577dc)) {
            playfx(localclientnum, var_7f1577dc, origin, fwd * -1);
            rumble = 1;
        }
    }
    if (sliding) {
        var_d93a6469 = vehicle driving_fx::function_b237cc74("skid", surface);
        [[ self.ground_fx["skid"] ]]->play(localclientnum, vehicle, var_d93a6469, self.tag_name);
        vehicle.var_b3bac88c = 1;
        rumble = 1;
    } else {
        [[ self.ground_fx["skid"] ]]->stop(localclientnum);
    }
    if (var_53b07afb > 0.01) {
        var_3a66468c = vehicle driving_fx::function_b237cc74("tread", surface);
        [[ self.ground_fx["tread"] ]]->play(localclientnum, vehicle, var_3a66468c, self.tag_name);
    } else {
        [[ self.ground_fx["tread"] ]]->stop(localclientnum);
    }
    if (rumble) {
        if (vehicle islocalclientdriver(localclientnum)) {
            player = getlocalplayer(localclientnum);
            player playrumbleonentity(localclientnum, "reload_small");
        }
    }
}

#namespace driving_fx;

// Namespace driving_fx/driving_fx
// Params 0, eflags: 0x6
// Checksum 0x9b3bc318, Offset: 0xb48
// Size: 0xe6
function private autoexec function_aeb003f6() {
    classes.var_aeb003f6[0] = spawnstruct();
    classes.var_aeb003f6[0].__vtable[-558052070] = &namespace_aeb003f6::update;
    classes.var_aeb003f6[0].__vtable[-1017222485] = &namespace_aeb003f6::init;
    classes.var_aeb003f6[0].__vtable[1606033458] = &namespace_aeb003f6::__destructor;
    classes.var_aeb003f6[0].__vtable[-1690805083] = &namespace_aeb003f6::__constructor;
}

#namespace namespace_e927da48;

// Namespace namespace_e927da48/driving_fx
// Params 0, eflags: 0x0
// Checksum 0xfbd65265, Offset: 0xc38
// Size: 0x54
function __constructor() {
    self.var_30ff2ea1 = 0.5;
    self.var_dbad56df = 1;
    self.var_356b4f1d = 0.1;
    self.var_b2800d13 = 0.115;
    self.var_2a5a26c8 = "";
}

// Namespace namespace_e927da48/driving_fx
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xc98
// Size: 0x4
function __destructor() {
    
}

// Namespace namespace_e927da48/driving_fx
// Params 5, eflags: 0x0
// Checksum 0xd3e14d9c, Offset: 0xca8
// Size: 0xb0
function init(var_b1d0498a, var_c4748824, var_edd22bf1, var_5b4a0a4f, rumble) {
    if (!isdefined(rumble)) {
        rumble = "";
    }
    self.var_30ff2ea1 = var_b1d0498a;
    self.var_dbad56df = var_c4748824;
    self.var_356b4f1d = var_edd22bf1;
    self.var_b2800d13 = var_5b4a0a4f;
    self.var_2a5a26c8 = rumble != "" ? rumble : self.var_2a5a26c8;
}

// Namespace namespace_e927da48/driving_fx
// Params 3, eflags: 0x0
// Checksum 0x54ec14c6, Offset: 0xd60
// Size: 0x15c
function update(localclientnum, vehicle, var_53b07afb) {
    if (vehicle islocalclientdriver(localclientnum)) {
        player = getlocalplayer(localclientnum);
        if (var_53b07afb > 0) {
            strength = randomfloatrange(self.var_356b4f1d, self.var_b2800d13) * var_53b07afb;
            time = randomfloatrange(self.var_30ff2ea1, self.var_dbad56df);
            player earthquake(strength, time, player.origin, 500);
            if (self.var_2a5a26c8 != "" && var_53b07afb > 0.5) {
                if (randomint(100) < 10) {
                    player playrumbleonentity(localclientnum, self.var_2a5a26c8);
                }
            }
        }
    }
}

#namespace driving_fx;

// Namespace driving_fx/driving_fx
// Params 0, eflags: 0x6
// Checksum 0xf9e5b737, Offset: 0xec8
// Size: 0xe6
function private autoexec function_e927da48() {
    classes.var_e927da48[0] = spawnstruct();
    classes.var_e927da48[0].__vtable[-558052070] = &namespace_e927da48::update;
    classes.var_e927da48[0].__vtable[-1017222485] = &namespace_e927da48::init;
    classes.var_e927da48[0].__vtable[1606033458] = &namespace_e927da48::__destructor;
    classes.var_e927da48[0].__vtable[-1690805083] = &namespace_e927da48::__constructor;
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0x7bc971b7, Offset: 0xfb8
// Size: 0xa8
function vehicle_enter(localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill("enter_vehicle");
        user = waitresult.player;
        if (isdefined(user) && user isplayer()) {
            self thread collision_thread(localclientnum);
            self thread jump_landing_thread(localclientnum);
        }
    }
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0x3bfbb795, Offset: 0x1068
// Size: 0xc
function function_eda821cb(localclientnum) {
    
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0x6f80189a, Offset: 0x1080
// Size: 0x43c
function function_789b5418(localclientnum) {
    self endon(#"death");
    self thread vehicle_enter(localclientnum);
    if (self.surfacefxdeftype == "") {
        return;
    }
    if (!isdefined(self.var_250efb17)) {
        var_8b6aab6b = array("front_left", "front_right", "back_left", "back_right");
        var_6b26776a = array("tag_wheel_front_left", "tag_wheel_front_right", "tag_wheel_back_left", "tag_wheel_back_right");
        if (isdefined(self.scriptvehicletype) && self.scriptvehicletype == "raps") {
            var_8b6aab6b = array("front_left");
            var_6b26776a = array("tag_origin");
        } else if (self.vehicleclass == "boat") {
            var_8b6aab6b = array("tag_origin");
            var_6b26776a = array("tag_origin");
        }
        self.var_250efb17 = [];
        for (i = 0; i < var_8b6aab6b.size; i++) {
            [[ new class_aeb003f6 ]]->__constructor();
            self.var_250efb17[i] = <error pop>;
            [[ self.var_250efb17[i] ]]->init(var_8b6aab6b[i], var_6b26776a[i]);
        }
        self.var_aa924851 = [];
        [[ new class_e927da48 ]]->__constructor();
        self.var_aa924851["speed"] = <error pop>;
        [[ self.var_aa924851["speed"] ]]->init(0.5, 1, 0.1, 0.115, "reload_small");
        [[ new class_e927da48 ]]->__constructor();
        self.var_aa924851["skid"] = <error pop>;
        [[ self.var_aa924851["skid"] ]]->init(0.25, 0.35, 0.1, 0.115);
    }
    self.var_560fa114 = 0;
    self.var_414f019b = 0;
    var_53b07afb = 0;
    while (true) {
        speed = length(self getvelocity());
        max_speed = speed < 0 ? self getmaxreversespeed() : self getmaxspeed();
        var_53b07afb = max_speed > 0 ? abs(speed) / max_speed : 0;
        self.var_b3bac88c = 0;
        for (i = 0; i < self.var_250efb17.size; i++) {
            [[ self.var_250efb17[i] ]]->update(localclientnum, self, var_53b07afb);
        }
        wait 0.1;
    }
}

// Namespace driving_fx/driving_fx
// Params 2, eflags: 0x0
// Checksum 0x94da10f7, Offset: 0x14c8
// Size: 0xa4
function function_b237cc74(type, surface) {
    fxarray = undefined;
    if (type == "tread") {
        fxarray = self.treadfxnamearray;
    } else if (type == "peel") {
        fxarray = self.peelfxnamearray;
    } else if (type == "skid") {
        fxarray = self.skidfxnamearray;
    }
    if (isdefined(fxarray)) {
        return fxarray[surface];
    }
    return undefined;
}

// Namespace driving_fx/driving_fx
// Params 3, eflags: 0x0
// Checksum 0xf0f5b7d3, Offset: 0x1578
// Size: 0x1bc
function function_8185750c(localclientnum, speed, var_53b07afb) {
    if (speed > 0 && var_53b07afb >= 0.25) {
        viewangles = getlocalclientangles(localclientnum);
        pitch = angleclamp180(viewangles[0]);
        if (pitch > -10) {
            var_9b1a25f8 = 0;
            if (pitch < 10) {
                var_9b1a25f8 = 1000 * (pitch - 10) / (-10 - 10);
            }
            if (self.var_560fa114 + self.var_414f019b + var_9b1a25f8 < getrealtime()) {
                var_7ef93455 = self function_7f884b2c();
                if (var_7ef93455 == "dirt") {
                    function_3e13e5c5(localclientnum);
                } else {
                    function_ba7b10a6(localclientnum);
                }
                self.var_560fa114 = getrealtime();
                self.var_414f019b = randomintrange(250, 500);
            }
        }
    }
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0xf8b3755d, Offset: 0x1740
// Size: 0x2d0
function collision_thread(localclientnum) {
    self endon(#"death");
    self endon(#"exit_vehicle");
    while (true) {
        waitresult = self waittill("veh_collision");
        hip = waitresult.velocity;
        hitn = waitresult.normal;
        hit_intensity = waitresult.intensity;
        if (self islocalclientdriver(localclientnum)) {
            player = getlocalplayer(localclientnum);
            if (isdefined(self.driving_fx_collision_override)) {
                self [[ self.driving_fx_collision_override ]](localclientnum, player, hip, hitn, hit_intensity);
                continue;
            }
            if (isdefined(player) && isdefined(hit_intensity)) {
                if (hit_intensity > self.heavycollisionspeed) {
                    volume = get_impact_vol_from_speed();
                    if (isdefined(self.sounddef)) {
                        alias = self.sounddef + "_suspension_lg_hd";
                    } else {
                        alias = "veh_default_suspension_lg_hd";
                    }
                    id = playsound(0, alias, self.origin, volume);
                    if (isdefined(self.heavycollisionrumble)) {
                        player playrumbleonentity(localclientnum, self.heavycollisionrumble);
                    }
                    continue;
                }
                if (hit_intensity > self.lightcollisionspeed) {
                    volume = get_impact_vol_from_speed();
                    if (isdefined(self.sounddef)) {
                        alias = self.sounddef + "_suspension_lg_lt";
                    } else {
                        alias = "veh_default_suspension_lg_lt";
                    }
                    id = playsound(0, alias, self.origin, volume);
                    if (isdefined(self.lightcollisionrumble)) {
                        player playrumbleonentity(localclientnum, self.lightcollisionrumble);
                    }
                }
            }
        }
    }
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0xe792200b, Offset: 0x1a18
// Size: 0x180
function jump_landing_thread(localclientnum) {
    self endon(#"death");
    self endon(#"exit_vehicle");
    while (true) {
        self waittill("veh_landed");
        if (self islocalclientdriver(localclientnum)) {
            player = getlocalplayer(localclientnum);
            if (isdefined(player)) {
                if (isdefined(self.driving_fx_jump_landing_override)) {
                    self [[ self.driving_fx_jump_landing_override ]](localclientnum, player);
                    continue;
                }
                volume = get_impact_vol_from_speed();
                if (isdefined(self.sounddef)) {
                    alias = self.sounddef + "_suspension_lg_hd";
                } else {
                    alias = "veh_default_suspension_lg_hd";
                }
                id = playsound(0, alias, self.origin, volume);
                if (isdefined(self.jumplandingrumble)) {
                    player playrumbleonentity(localclientnum, self.jumplandingrumble);
                }
            }
        }
    }
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0x1a81554, Offset: 0x1ba0
// Size: 0x140
function suspension_thread(localclientnum) {
    self endon(#"death");
    self endon(#"exit_vehicle");
    while (true) {
        self waittill("veh_suspension_limit_activated");
        if (self islocalclientdriver(localclientnum)) {
            player = getlocalplayer(localclientnum);
            if (isdefined(player)) {
                volume = get_impact_vol_from_speed();
                if (isdefined(self.sounddef)) {
                    alias = self.sounddef + "_suspension_lg_lt";
                } else {
                    alias = "veh_default_suspension_lg_lt";
                }
                id = playsound(0, alias, self.origin, volume);
                player playrumbleonentity(localclientnum, "damage_light");
            }
        }
    }
}

// Namespace driving_fx/driving_fx
// Params 0, eflags: 0x0
// Checksum 0x1330a823, Offset: 0x1ce8
// Size: 0x92
function get_impact_vol_from_speed() {
    curspeed = self getspeed();
    maxspeed = self getmaxspeed();
    volume = audio::scale_speed(0, maxspeed, 0, 1, curspeed);
    volume = volume * volume * volume;
    return volume;
}

// Namespace driving_fx/driving_fx
// Params 0, eflags: 0x0
// Checksum 0xbe437336, Offset: 0x1d88
// Size: 0x82
function function_556fe27b() {
    return self iswheelcolliding("front_left") || self iswheelcolliding("front_right") || self iswheelcolliding("back_left") || self iswheelcolliding("back_right");
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0x5279e931, Offset: 0x1e18
// Size: 0x64
function function_2bf1fe21(surface_type) {
    switch (surface_type) {
    case #"dirt":
    case #"foliage":
    case #"grass":
    case #"gravel":
    case #"mud":
    case #"sand":
    case #"snow":
    case #"water":
        return true;
    }
    return false;
}

// Namespace driving_fx/driving_fx
// Params 0, eflags: 0x0
// Checksum 0x963d5aa9, Offset: 0x1e88
// Size: 0x9e
function function_7f884b2c() {
    var_1f075c86 = self getwheelsurface("back_right");
    var_192c57b = self getwheelsurface("back_left");
    if (function_2bf1fe21(var_1f075c86)) {
        return "dirt";
    }
    if (function_2bf1fe21(var_192c57b)) {
        return "dirt";
    }
    return "dust";
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0xadd227b0, Offset: 0x1f30
// Size: 0xc
function function_3e13e5c5(localclientnum) {
    
}

// Namespace driving_fx/driving_fx
// Params 1, eflags: 0x0
// Checksum 0xe053cd95, Offset: 0x1f48
// Size: 0xc
function function_ba7b10a6(localclientnum) {
    
}

