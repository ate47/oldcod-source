#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;

#namespace ir_strobe;

// Namespace ir_strobe/namespace_f0840611
// Params 0, eflags: 0x0
// Checksum 0xd4ffb69f, Offset: 0x128
// Size: 0xb4
function init_shared() {
    if (!isdefined(level.var_90058911)) {
        level.var_90058911 = {};
        clientfield::register("toplayer", "marker_state", 1, 2, "int", &marker_state_changed, 0, 0);
        level.var_9c4cdb79 = [];
    }
    forcestreamxmodel(#"hash_10ff865a98af3c24");
    forcestreamxmodel(#"hash_636502941be19df3");
}

// Namespace ir_strobe/namespace_f0840611
// Params 1, eflags: 0x0
// Checksum 0x74101550, Offset: 0x1e8
// Size: 0x150
function updatemarkerthread(localclientnum) {
    self endon(#"death");
    player = self;
    localplayer = function_27673a7(localclientnum);
    if (player != localplayer) {
        return;
    }
    killstreakcorebundle = getscriptbundle("killstreak_core");
    while (isdefined(player.markerobj)) {
        viewangles = getlocalclientangles(localclientnum);
        forwardvector = vectorscale(anglestoforward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
        results = bullettrace(player geteye(), player geteye() + forwardvector, 0, player);
        player.markerobj.origin = results[#"position"];
        waitframe(1);
    }
}

// Namespace ir_strobe/namespace_f0840611
// Params 7, eflags: 0x0
// Checksum 0xaf13cb9c, Offset: 0x340
// Size: 0x12c
function marker_state_changed(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    player = self;
    killstreakcorebundle = getscriptbundle("killstreak_core");
    if (bwastimejump > 0) {
        if (!isdefined(level.var_9c4cdb79[fieldname])) {
            spawn_previs(fieldname);
        }
    }
    if (bwastimejump > 0) {
        player thread previs(fieldname, bwastimejump - 1);
    } else {
        player notify(#"stop_previs");
    }
    if (isdefined(player.markerobj) && !player.markerobj hasdobj(fieldname)) {
        return;
    }
}

// Namespace ir_strobe/namespace_f0840611
// Params 1, eflags: 0x0
// Checksum 0xd8b78728, Offset: 0x478
// Size: 0x94
function function_6f798989(*var_a27f7ab4) {
    if (function_4e3684f2(self.localclientnum)) {
        localclientnum = self.localclientnum;
    } else {
        localclientnum = self getlocalclientnumber();
    }
    if (isdefined(localclientnum) && isdefined(level.var_9c4cdb79[localclientnum])) {
        level.var_9c4cdb79[localclientnum] hide();
    }
}

// Namespace ir_strobe/namespace_f0840611
// Params 2, eflags: 0x0
// Checksum 0x26e56ccd, Offset: 0x518
// Size: 0xce
function previs(localclientnum, invalid) {
    self notify(#"stop_previs");
    self endoncallback(&function_6f798989, #"death", #"weapon_change", #"stop_previs");
    level.var_9c4cdb79[localclientnum] show();
    function_3e8d9b27(!invalid, localclientnum);
    while (true) {
        update_previs(localclientnum, invalid);
        waitframe(1);
    }
}

// Namespace ir_strobe/namespace_f0840611
// Params 1, eflags: 0x0
// Checksum 0x6ad0fe40, Offset: 0x5f0
// Size: 0x70
function spawn_previs(localclientnum) {
    localplayer = function_5c10bd79(localclientnum);
    level.var_9c4cdb79[localclientnum] = spawn(localclientnum, (0, 0, 0), "script_model", localplayer getentitynumber());
}

// Namespace ir_strobe/namespace_f0840611
// Params 2, eflags: 0x0
// Checksum 0xb15e637e, Offset: 0x668
// Size: 0x2e4
function update_previs(localclientnum, invalid) {
    player = self;
    facing_angles = getlocalclientangles(localclientnum);
    forward = anglestoforward(facing_angles);
    up = anglestoup(facing_angles);
    weapon = getweapon("ir_strobe");
    velocity = function_711c258(forward, up, weapon);
    eye_pos = getlocalclienteyepos(localclientnum);
    if (is_true(level.var_4970b0af)) {
        radius = 10;
        trace1 = bullettrace(eye_pos, eye_pos + vectorscale(forward, 300), 0, player, 1);
        if (trace1[#"fraction"] >= 1) {
            trace1 = bullettrace(trace1[#"position"], trace1[#"position"] + (0, 0, -1000), 0, player, 1);
        }
    } else {
        trace1 = function_e6ba3ec9(eye_pos, velocity, 0, weapon);
    }
    level.var_9c4cdb79[localclientnum].origin = trace1[#"position"] + vectorscale(trace1[#"normal"], 7);
    level.var_9c4cdb79[localclientnum].angles = (0, vectortoangles(forward)[1] + 90, 0);
    level.var_9c4cdb79[localclientnum].hitent = trace1[#"entity"];
    if (invalid) {
        player function_bf191832(0, (0, 0, 0), (0, 0, 0));
        return;
    }
    player function_bf191832(1, level.var_9c4cdb79[localclientnum].origin, level.var_9c4cdb79[localclientnum].angles);
}

// Namespace ir_strobe/namespace_f0840611
// Params 2, eflags: 0x0
// Checksum 0xc27fc124, Offset: 0x958
// Size: 0x174
function function_3e8d9b27(validlocation, localclientnum) {
    if (validlocation) {
        level.var_9c4cdb79[localclientnum] setmodel(#"hash_10ff865a98af3c24");
        if (isdefined(level.var_5af693e8)) {
            stopfx(localclientnum, level.var_5af693e8);
        }
        level.var_5af693e8 = function_239993de(localclientnum, "killstreaks/fx8_tankrobot_previs_valid", level.var_9c4cdb79[localclientnum], "tag_fx");
    } else {
        level.var_9c4cdb79[localclientnum] setmodel(#"hash_636502941be19df3");
        if (isdefined(level.var_5af693e8)) {
            stopfx(localclientnum, level.var_5af693e8);
        }
        level.var_5af693e8 = function_239993de(localclientnum, "killstreaks/fx8_tankrobot_previs_invalid", level.var_9c4cdb79[localclientnum], "tag_fx");
    }
    level.var_9c4cdb79[localclientnum] notsolid();
}

