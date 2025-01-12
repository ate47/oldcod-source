#using script_324d329b31b9b4ec;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace supplydrop;

// Namespace supplydrop/supplydrop_shared
// Params 0, eflags: 0x0
// Checksum 0xb4a2c171, Offset: 0x208
// Size: 0x3b4
function init_shared() {
    if (!isdefined(level.var_6d2e2d3f)) {
        level.var_6d2e2d3f = {};
        ir_strobe::init_shared();
        level.chopper_fx[#"damage"][#"light_smoke"] = "destruct/fx8_atk_chppr_smk_trail";
        level.chopper_fx[#"damage"][#"heavy_smoke"] = "destruct/fx8_atk_chppr_exp_trail";
        level._effect[#"qrdrone_prop"] = #"hash_6cd811fe548313ca";
        level._effect[#"heli_guard_light"][#"friendly"] = #"killstreaks/fx_sc_lights_grn";
        level._effect[#"heli_guard_light"][#"enemy"] = #"killstreaks/fx_sc_lights_red";
        level._effect[#"heli_comlink_light"][#"common"] = #"killstreaks/fx_drone_hunter_lights";
        level._effect[#"heli_gunner_light"][#"friendly"] = #"killstreaks/fx_vtol_lights_grn";
        level._effect[#"heli_gunner_light"][#"enemy"] = #"killstreaks/fx_vtol_lights_red";
        level._effect[#"heli_gunner"][#"vtol_fx"] = #"killstreaks/fx_vtol_thruster";
        level._effect[#"heli_gunner"][#"vtol_fx_ft"] = #"killstreaks/fx_vtol_thruster";
        clientfield::register("vehicle", "supplydrop_care_package_state", 1, 1, "int", &supplydrop_care_package_state, 0, 0);
        clientfield::register("vehicle", "supplydrop_ai_tank_state", 1, 1, "int", &supplydrop_ai_tank_state, 0, 0);
        clientfield::register("scriptmover", "supplydrop_thrusters_state", 1, 1, "int", &setsupplydropthrustersstate, 0, 0);
        clientfield::register("scriptmover", "aitank_thrusters_state", 1, 1, "int", &setaitankhrustersstate, 0, 0);
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 1, eflags: 0x0
// Checksum 0x4a842020, Offset: 0x5c8
// Size: 0x8e
function function_41b3c89(localclientnum) {
    player = self;
    player.markerfx = undefined;
    if (isdefined(player.markerobj)) {
        player.markerobj delete();
    }
    if (isdefined(player.markerfxhandle)) {
        killfx(localclientnum, player.markerfxhandle);
        player.markerfxhandle = undefined;
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 0, eflags: 0x0
// Checksum 0xbee6929a, Offset: 0x660
// Size: 0x3c
function setupanimtree() {
    if (self hasanimtree() == 0) {
        self useanimtree("generic");
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 7, eflags: 0x0
// Checksum 0x4c811ace, Offset: 0x6a8
// Size: 0xec
function supplydrop_care_package_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self setupanimtree();
    if (newval == 1) {
        self setanim(#"o_drone_supply_care_idle", 1, 0, 1);
        return;
    }
    self setanim(#"o_drone_supply_care_drop", 1, 0, 0.3);
}

// Namespace supplydrop/supplydrop_shared
// Params 7, eflags: 0x0
// Checksum 0xef79d757, Offset: 0x7a0
// Size: 0x76
function supplydrop_ai_tank_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self setupanimtree();
    if (newval == 1) {
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 1, eflags: 0x0
// Checksum 0x3330c405, Offset: 0x820
// Size: 0x13c
function updatemarkerthread(localclientnum) {
    self endoncallback(&function_41b3c89, #"death");
    player = self;
    killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
    while (isdefined(player.markerobj)) {
        viewangles = getlocalclientangles(localclientnum);
        forwardvector = vectorscale(anglestoforward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
        results = bullettrace(player geteye(), player geteye() + forwardvector, 0, player);
        player.markerobj.origin = results[#"position"];
        waitframe(1);
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 1, eflags: 0x0
// Checksum 0xc18dc42a, Offset: 0x968
// Size: 0x10a
function stopcrateeffects(localclientnum) {
    crate = self;
    if (isdefined(crate.thrusterfxhandle0)) {
        stopfx(localclientnum, crate.thrusterfxhandle0);
    }
    if (isdefined(crate.thrusterfxhandle1)) {
        stopfx(localclientnum, crate.thrusterfxhandle1);
    }
    if (isdefined(crate.thrusterfxhandle2)) {
        stopfx(localclientnum, crate.thrusterfxhandle2);
    }
    if (isdefined(crate.thrusterfxhandle3)) {
        stopfx(localclientnum, crate.thrusterfxhandle3);
    }
    crate.thrusterfxhandle0 = undefined;
    crate.thrusterfxhandle1 = undefined;
    crate.thrusterfxhandle2 = undefined;
    crate.thrusterfxhandle3 = undefined;
}

// Namespace supplydrop/supplydrop_shared
// Params 1, eflags: 0x0
// Checksum 0x5b9e5be2, Offset: 0xa80
// Size: 0x74
function cleanupthrustersthread(localclientnum) {
    crate = self;
    crate notify(#"cleanupthrustersthread_singleton");
    crate endon(#"cleanupthrustersthread_singleton");
    crate waittill(#"death");
    crate stopcrateeffects(localclientnum);
}

// Namespace supplydrop/supplydrop_shared
// Params 7, eflags: 0x0
// Checksum 0x7ed49189, Offset: 0xb00
// Size: 0x1d4
function setsupplydropthrustersstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    crate = self;
    params = struct::get_script_bundle("killstreak", "killstreak_supply_drop");
    if (newval != oldval && isdefined(params.ksthrusterfx)) {
        if (newval == 1) {
            crate stopcrateeffects(localclientnum);
            crate.thrusterfxhandle0 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_01");
            crate.thrusterfxhandle1 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_02");
            crate.thrusterfxhandle2 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_03");
            crate.thrusterfxhandle3 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_04");
            crate thread cleanupthrustersthread(localclientnum);
            return;
        }
        crate stopcrateeffects(localclientnum);
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 7, eflags: 0x0
// Checksum 0xd2965bb, Offset: 0xce0
// Size: 0x1d4
function setaitankhrustersstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    crate = self;
    params = struct::get_script_bundle("killstreak", "killstreak_tank_robot");
    if (newval != oldval && isdefined(params.ksthrusterfx)) {
        if (newval == 1) {
            crate stopcrateeffects(localclientnum);
            crate.thrusterfxhandle0 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_01");
            crate.thrusterfxhandle1 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_02");
            crate.thrusterfxhandle2 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_03");
            crate.thrusterfxhandle3 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_04");
            crate thread cleanupthrustersthread(localclientnum);
            return;
        }
        crate stopcrateeffects(localclientnum);
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 7, eflags: 0x0
// Checksum 0xc769144, Offset: 0xec0
// Size: 0x294
function marker_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    player = self;
    killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
    if (newval == 1) {
        player.markerfx = killstreakcorebundle.fxvalidlocation;
    } else if (newval == 2) {
        player.markerfx = killstreakcorebundle.fxinvalidlocation;
    } else {
        player.markerfx = undefined;
    }
    if (isdefined(player.markerobj) && !player.markerobj hasdobj(localclientnum)) {
        return;
    }
    if (isdefined(player.markerfxhandle)) {
        killfx(localclientnum, player.markerfxhandle);
        player.markerfxhandle = undefined;
    }
    if (isdefined(player.markerfx)) {
        if (!isdefined(player.markerobj)) {
            player.markerobj = spawn(localclientnum, (0, 0, 0), "script_model");
            player.markerobj.angles = (270, 0, 0);
            player.markerobj setmodel(#"wpn_t7_none_world");
            player.markerobj util::waittill_dobj(localclientnum);
            player thread updatemarkerthread(localclientnum);
        }
        player.markerfxhandle = util::playfxontag(localclientnum, player.markerfx, player.markerobj, "tag_origin");
        return;
    }
    if (isdefined(player.markerobj)) {
        player.markerobj delete();
    }
}

