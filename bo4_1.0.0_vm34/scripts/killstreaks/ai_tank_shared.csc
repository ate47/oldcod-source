#using script_324d329b31b9b4ec;
#using script_6ae78a9592670fa2;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace ai_tank;

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x8bb09352, Offset: 0x368
// Size: 0x3f4
function init_shared(bundlename) {
    if (!isdefined(level.var_e5eeac3a)) {
        level.var_e5eeac3a = {};
        ir_strobe::init_shared();
        if (!isdefined(bundlename)) {
            bundlename = "killstreak_tank_robot";
        }
        bundle = struct::get_script_bundle("killstreak", bundlename);
        level.var_e5eeac3a.aitankkillstreakbundle = bundle;
        level.var_e5eeac3a._ai_tank_fx = [];
        level.var_e5eeac3a._ai_tank_fx[#"light_green"] = "killstreaks/fx_agr_vlight_eye_grn";
        level.var_e5eeac3a._ai_tank_fx[#"light_red"] = "killstreaks/fx_agr_vlight_eye_red";
        level.var_e5eeac3a._ai_tank_fx[#"immobile"] = "killstreaks/fx8_drone_tank_stun";
        level.var_e5eeac3a._ai_tank_fx[#"stun"] = "killstreaks/fx_agr_emp_stun";
        clientfield::register("vehicle", "ai_tank_death", 1, 1, "int", &death, 0, 0);
        clientfield::register("vehicle", "ai_tank_immobile", 1, 1, "int", &tank_immobile, 0, 0);
        clientfield::register("vehicle", "ai_tank_change_control", 1, 1, "int", &tank_change_control, 0, 0);
        clientfield::register("toplayer", "ai_tank_update_hud", 1, 1, "counter", &update_hud, 0, 0);
        clientfield::register("clientuimodel", "hudItems.tankState", 1, 3, "int", undefined, 0, 0);
        if (!(isdefined(level.var_db13f6c8) && level.var_db13f6c8)) {
            multi_stage_target_lockon::register("multi_stage_target_lockon0");
            multi_stage_target_lockon::register("multi_stage_target_lockon1");
            multi_stage_target_lockon::register("multi_stage_target_lockon2");
            multi_stage_target_lockon::register("multi_stage_target_lockon3");
            multi_stage_target_lockon::register("multi_stage_target_lockon4");
        }
        vehicle::add_vehicletype_callback("ai_tank_drone_mp", &spawned);
        vehicle::add_vehicletype_callback("spawner_bo3_ai_tank_mp", &spawned);
        vehicle::add_vehicletype_callback("spawner_bo3_ai_tank_mp_player", &spawned);
        vehicle::add_vehicletype_callback("archetype_mini_quadtank_mp", &spawned);
        visionset_mgr::register_visionset_info("agr_visionset", 1, 16, undefined, "mp_vehicles_agr");
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x4447e55f, Offset: 0x768
// Size: 0x9c
function spawned(localclientnum, killstreak_duration) {
    self thread play_driving_rumble(localclientnum);
    self.killstreakbundle = level.var_e5eeac3a.aitankkillstreakbundle;
    var_5c7a822d = self.killstreakbundle.var_52891e09;
    self.var_f7798571 = 1;
    if (isdefined(var_5c7a822d) && var_5c7a822d != 0) {
        self enablevisioncircle(localclientnum, var_5c7a822d);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 7, eflags: 0x0
// Checksum 0x98fb3fae, Offset: 0x810
// Size: 0xd4
function missile_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (self hasanimtree() == 0) {
        self useanimtree("generic");
    }
    missiles_loaded = newval;
    if (missiles_loaded <= 4) {
        update_ui_ammo_count(localclientnum, missiles_loaded);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 7, eflags: 0x0
// Checksum 0x4cf398f7, Offset: 0x8f0
// Size: 0x86
function update_hud(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"disconnect");
    waitframe(1);
    if (isdefined(self)) {
        vehicle = getplayervehicle(self);
        if (isdefined(vehicle)) {
        }
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x25d079ec, Offset: 0x980
// Size: 0x64
function update_ui_ammo_count(localclientnum, missiles_loaded) {
    if (self function_2a8c9709() || function_9a47ed7f(localclientnum)) {
        update_ui_model_ammo_count(localclientnum, missiles_loaded);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x44adcfa7, Offset: 0x9f0
// Size: 0x6c
function update_ui_model_ammo_count(localclientnum, missiles_loaded) {
    ammo_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.rocketAmmo");
    if (isdefined(ammo_ui_data_model)) {
        setuimodelvalue(ammo_ui_data_model, missiles_loaded);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 7, eflags: 0x0
// Checksum 0x2c36c331, Offset: 0xa68
// Size: 0xb4
function tank_immobile(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (newval) {
        self notify(#"light_disable");
        self function_b8bb931d(localclientnum);
        self function_bc03ef93(localclientnum);
        return;
    }
    self function_b8bb931d(localclientnum);
}

// Namespace ai_tank/ai_tank_shared
// Params 7, eflags: 0x0
// Checksum 0xda69dda9, Offset: 0xb28
// Size: 0x15c
function tank_change_control(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (newval) {
        self function_9019beea("tag_turret_constrained_barrel_lower", 0);
        self function_9019beea("tag_turret_base_pivot", 1);
        self function_9019beea("tag_turret_constraint_base", 1);
        self function_9019beea("tag_turret_constrained_barrel", 1);
        return;
    }
    self function_9019beea("tag_turret_constrained_barrel_lower", 1);
    self function_9019beea("tag_turret_base_pivot", 0);
    self function_9019beea("tag_turret_constraint_base", 0);
    self function_9019beea("tag_turret_constrained_barrel", 0);
}

// Namespace ai_tank/ai_tank_shared
// Params 7, eflags: 0x0
// Checksum 0x48604549, Offset: 0xc90
// Size: 0x86
function death(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (function_1fe374eb(localclientnum)) {
        return;
    }
    if (newval) {
        self function_b8bb931d(localclientnum);
        self notify(#"light_disable");
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x2d274a89, Offset: 0xd20
// Size: 0x7c
function function_bc03ef93(localclientnum) {
    self.immobile_fx = util::playfxontag(localclientnum, level.var_e5eeac3a._ai_tank_fx[#"immobile"], self, "tag_body");
    playsound(localclientnum, #"veh_talon_shutdown", self.origin);
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x9996d859, Offset: 0xda8
// Size: 0x3e
function function_b8bb931d(localclientnum) {
    if (isdefined(self.immobile_fx)) {
        stopfx(localclientnum, self.immobile_fx);
        self.immobile_fx = undefined;
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x779f53e3, Offset: 0xdf0
// Size: 0xf0
function play_driving_rumble(localclientnum) {
    self notify(#"driving_rumble");
    self endon(#"death");
    self endon(#"driving_rumble");
    for (;;) {
        if (isinvehicle(localclientnum, self)) {
            speed = self getspeed();
            if (speed >= 40 || speed <= -40) {
                earthquake(localclientnum, 0.1, 0.1, self.origin, 200);
            }
        }
        util::server_wait(localclientnum, 0.05);
    }
}

