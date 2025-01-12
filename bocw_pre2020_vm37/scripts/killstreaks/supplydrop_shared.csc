#using script_324d329b31b9b4ec;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace supplydrop;

// Namespace supplydrop/supplydrop_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x9bbd3e7b, Offset: 0x1c8
// Size: 0x204
function init_shared() {
    if (!isdefined(level.var_ba8d5308)) {
        level.var_ba8d5308 = {};
        ir_strobe::init_shared();
        params = getscriptbundle("killstreak_helicopter_guard");
        level._effect[#"heli_guard_light"][#"friendly"] = params.var_667eb0de;
        level._effect[#"heli_guard_light"][#"enemy"] = params.var_1d8c24a8;
        clientfield::register("vehicle", "supplydrop_care_package_state", 1, 1, "int", &supplydrop_care_package_state, 0, 0);
        clientfield::register("vehicle", "supplydrop_ai_tank_state", 1, 1, "int", &supplydrop_ai_tank_state, 0, 0);
        clientfield::register("scriptmover", "crate_landed", 1, 1, "int", &function_4559c532, 0, 0);
        if (sessionmodeismultiplayergame()) {
            clientfield::register("scriptmover", "supply_drop_parachute_rob", 1, 1, "int", &supply_drop_parachute, 0, 0);
        }
        level.var_835198ed = getscriptbundle("killstreak_supply_drop");
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xbe2964b9, Offset: 0x3d8
// Size: 0x16c
function function_4559c532(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        localplayer = function_5c10bd79(fieldname);
        if (localplayer != self.owner) {
            self function_1f0c7136(2);
        }
        if (localplayer hasperk(fieldname, #"specialty_showscorestreakicons") || self.team == localplayer.team) {
            self setcompassicon(level.var_835198ed.var_cb98fbf7);
            self function_5e00861(isdefined(level.var_835198ed.var_c3e4af00) ? level.var_835198ed.var_c3e4af00 : 0);
            var_b13727dd = getgametypesetting("compassAnchorScorestreakIcons");
            self function_dce2238(var_b13727dd);
        }
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x11771b4f, Offset: 0x550
// Size: 0x86
function function_724944f0(localclientnum) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0x76ed0510, Offset: 0x5e0
// Size: 0x3c
function setupanimtree() {
    if (self hasanimtree() == 0) {
        self useanimtree("generic");
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x475b3b35, Offset: 0x628
// Size: 0x62
function supplydrop_care_package_state(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    if (bwastimejump == 1) {
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xddf42da7, Offset: 0x698
// Size: 0x76
function supplydrop_ai_tank_state(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    self setupanimtree();
    if (bwastimejump == 1) {
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x8375e1bc, Offset: 0x718
// Size: 0x130
function updatemarkerthread(localclientnum) {
    self endoncallback(&function_724944f0, #"death");
    player = self;
    killstreakcorebundle = getscriptbundle("killstreak_core");
    while (isdefined(player.markerobj)) {
        viewangles = getlocalclientangles(localclientnum);
        forwardvector = vectorscale(anglestoforward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
        results = bullettrace(player geteye(), player geteye() + forwardvector, 0, player);
        player.markerobj.origin = results[#"position"];
        waitframe(1);
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xe078c4ce, Offset: 0x850
// Size: 0x102
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
// Checksum 0x963bd119, Offset: 0x960
// Size: 0x74
function cleanupthrustersthread(localclientnum) {
    crate = self;
    crate notify(#"cleanupthrustersthread_singleton");
    crate endon(#"cleanupthrustersthread_singleton");
    crate waittill(#"death");
    crate stopcrateeffects(localclientnum);
}

// Namespace supplydrop/supplydrop_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xc9e882f6, Offset: 0x9e0
// Size: 0x12c
function supply_drop_parachute(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self playrenderoverridebundle(#"hash_336cece53ae2342f");
        return;
    }
    self stoprenderoverridebundle(#"hash_336cece53ae2342f");
    localplayer = function_5c10bd79(fieldname);
    owner = self getowner(fieldname);
    if (localplayer hasperk(fieldname, #"specialty_showscorestreakicons") || self.team == localplayer.team) {
        self setcompassicon("compass_supply_drop_white");
    }
}

// Namespace supplydrop/supplydrop_shared
// Params 7, eflags: 0x0
// Checksum 0x1621f55a, Offset: 0xb18
// Size: 0x264
function marker_state_changed(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    player = self;
    killstreakcorebundle = getscriptbundle("killstreak_core");
    if (bwastimejump == 1) {
        player.markerfx = killstreakcorebundle.fxvalidlocation;
    } else if (bwastimejump == 2) {
        player.markerfx = killstreakcorebundle.fxinvalidlocation;
    } else {
        player.markerfx = undefined;
    }
    if (isdefined(player.markerobj) && !player.markerobj hasdobj(fieldname)) {
        return;
    }
    if (isdefined(player.markerfxhandle)) {
        killfx(fieldname, player.markerfxhandle);
        player.markerfxhandle = undefined;
    }
    if (isdefined(player.markerfx)) {
        if (!isdefined(player.markerobj)) {
            player.markerobj = spawn(fieldname, (0, 0, 0), "script_model");
            player.markerobj.angles = (270, 0, 0);
            player.markerobj setmodel(#"wpn_t7_none_world");
            player.markerobj util::waittill_dobj(fieldname);
            player thread updatemarkerthread(fieldname);
        }
        player.markerfxhandle = util::playfxontag(fieldname, player.markerfx, player.markerobj, "tag_origin");
        return;
    }
    if (isdefined(player.markerobj)) {
        player.markerobj delete();
    }
}

