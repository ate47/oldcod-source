#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;

#namespace ir_strobe;

// Namespace ir_strobe/namespace_e9f92442
// Params 0, eflags: 0x0
// Checksum 0x72993eaf, Offset: 0xc8
// Size: 0x64
function init_shared() {
    if (!isdefined(level.var_7d66aa14)) {
        level.var_7d66aa14 = {};
        clientfield::register("toplayer", "marker_state", 1, 2, "int", &marker_state_changed, 0, 0);
    }
}

// Namespace ir_strobe/namespace_e9f92442
// Params 1, eflags: 0x0
// Checksum 0x140f45c7, Offset: 0x138
// Size: 0x12c
function updatemarkerthread(localclientnum) {
    self endon(#"death");
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

// Namespace ir_strobe/namespace_e9f92442
// Params 7, eflags: 0x0
// Checksum 0x829db52c, Offset: 0x270
// Size: 0x134
function marker_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    player = self;
    killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
    if (newval > 0) {
        if (!isdefined(level.previs_model)) {
            spawn_previs(localclientnum);
        }
    }
    if (newval > 0) {
        player thread previs(localclientnum, newval - 1);
    } else {
        player notify(#"stop_previs");
    }
    if (isdefined(player.markerobj) && !player.markerobj hasdobj(localclientnum)) {
        return;
    }
}

// Namespace ir_strobe/namespace_e9f92442
// Params 2, eflags: 0x0
// Checksum 0x466c0ef4, Offset: 0x3b0
// Size: 0xae
function previs(localclientnum, invalid) {
    self notify(#"stop_previs");
    self endoncallback(&function_710a4dea, #"death", #"weapon_change", #"stop_previs");
    level.previs_model show();
    while (true) {
        update_previs(localclientnum, invalid);
        waitframe(1);
    }
}

// Namespace ir_strobe/namespace_e9f92442
// Params 1, eflags: 0x0
// Checksum 0xe0aec00, Offset: 0x468
// Size: 0x6e
function spawn_previs(localclientnum) {
    localplayer = function_f97e7787(localclientnum);
    level.previs_model = spawn(localclientnum, (0, 0, 0), "script_model", localplayer getentitynumber());
}

// Namespace ir_strobe/namespace_e9f92442
// Params 2, eflags: 0x0
// Checksum 0xae0d3be0, Offset: 0x4e0
// Size: 0x26c
function update_previs(localclientnum, invalid) {
    player = self;
    function_6a12de2f(!invalid);
    facing_angles = getlocalclientangles(localclientnum);
    forward = anglestoforward(facing_angles);
    up = anglestoup(facing_angles);
    weapon = getweapon("ir_strobe");
    velocity = function_5b2a9c4f(forward, up, weapon);
    eye_pos = getlocalclienteyepos(localclientnum);
    trace1 = function_3348176f(eye_pos, velocity, 0, weapon);
    level.previs_model.origin = trace1[#"position"] + vectorscale(trace1[#"normal"], 3);
    level.previs_model.angles = (angleclamp180(vectortoangles(trace1[#"normal"])[0]), vectortoangles(forward)[1] + 90, 0);
    level.previs_model.hitent = trace1[#"entity"];
    if (invalid) {
        player function_d83e9f0e(0, (0, 0, 0), (0, 0, 0));
        return;
    }
    player function_d83e9f0e(1, level.previs_model.origin, level.previs_model.angles);
}

// Namespace ir_strobe/namespace_e9f92442
// Params 1, eflags: 0x0
// Checksum 0xf58c82bf, Offset: 0x758
// Size: 0x34
function function_710a4dea(var_6f5fb30e) {
    if (isdefined(level.previs_model)) {
        level.previs_model hide();
    }
}

// Namespace ir_strobe/namespace_e9f92442
// Params 1, eflags: 0x0
// Checksum 0x126336e9, Offset: 0x798
// Size: 0x84
function function_6a12de2f(validlocation) {
    if (validlocation) {
        level.previs_model setmodel(#"hash_5f05548d8aa53dc1");
    } else {
        level.previs_model setmodel(#"hash_5770a33506bee5a4");
    }
    level.previs_model notsolid();
}

