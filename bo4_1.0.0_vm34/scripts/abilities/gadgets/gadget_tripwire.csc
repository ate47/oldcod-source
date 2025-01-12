#using scripts\core_common\array_shared;
#using scripts\core_common\beam_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace gadget_tripwire;

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x2
// Checksum 0x25b37027, Offset: 0x180
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gadget_tripwire", &__init__, undefined, undefined);
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0xc63355b6, Offset: 0x1c8
// Size: 0x1d4
function __init__() {
    callback::on_localplayer_spawned(&on_local_player_spawned);
    clientfield::register("missile", "tripwire_state", 1, 1, "int", &function_8f72f31c, 1, 1);
    clientfield::register("scriptmover", "tripwire_solo_beam_fx", 1, 1, "int", &function_4e98f699, 0, 0);
    level.tripwireweapon = getweapon("eq_tripwire");
    if (isdefined(level.tripwireweapon.customsettings)) {
        level.var_39fd437f = getscriptbundle(level.tripwireweapon.customsettings);
    } else {
        level.var_39fd437f = getscriptbundle("tripwire_custom_settings");
    }
    if (!isdefined(level.var_93b67b4)) {
        level.var_93b67b4 = [];
    }
    if (!isdefined(level.var_498c9822)) {
        level.var_498c9822 = [];
    }
    if (!isdefined(level.tripwires)) {
        level.tripwires = [];
    }
    for (i = 0; i < getmaxlocalclients(); i++) {
        level.var_498c9822[i] = [];
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x244b5692, Offset: 0x3a8
// Size: 0x54
function on_local_player_spawned(localclientnum) {
    if (!self function_60dbc438()) {
        return;
    }
    self thread function_bd991dd5(localclientnum);
    level thread function_e6201123(localclientnum);
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 7, eflags: 0x0
// Checksum 0xf8016d1b, Offset: 0x408
// Size: 0x112
function function_8f72f31c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (bwastimejump) {
        function_71afa030(localclientnum);
    }
    switch (newval) {
    case 1:
        arrayinsert(level.tripwires, self, level.tripwires.size);
        self callback::on_shutdown(&function_71afa030);
        self thread function_51e9873e();
        break;
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x3904e10a, Offset: 0x528
// Size: 0x2c
function function_71afa030(localclientnum) {
    arrayremovevalue(level.tripwires, self);
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x46d75ab4, Offset: 0x560
// Size: 0x30
function function_39a33da3(trace) {
    if (trace[#"fraction"] < 1) {
        return false;
    }
    return true;
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x76d4a27f, Offset: 0x598
// Size: 0xfa
function function_e6201123(localclientnum) {
    level endon(#"game_ended");
    while (true) {
        level waittill(#"killcam_begin", #"killcam_end");
        foreach (beam_id in level.var_498c9822[localclientnum]) {
            if (isdefined(beam_id)) {
                beamkill(localclientnum, beam_id);
            }
        }
        level.var_498c9822[localclientnum] = [];
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0x44b2e22c, Offset: 0x6a0
// Size: 0x34c
function function_51e9873e() {
    self endon(#"death");
    foreach (tripwire in level.tripwires) {
        if (!isdefined(tripwire)) {
            continue;
        }
        if (self.ownernum != tripwire.ownernum) {
            continue;
        }
        if (self == tripwire) {
            continue;
        }
        if (distancesquared(tripwire.origin, self.origin) >= 100 && distancesquared(tripwire.origin, self.origin) <= level.var_39fd437f.var_60431f90 * level.var_39fd437f.var_60431f90) {
            pos = self gettagorigin("tag_fx");
            otherpos = tripwire gettagorigin("tag_fx");
            trace = beamtrace(pos, otherpos, 0, self, 0, tripwire);
            var_5110ef20 = beamtrace(otherpos, pos, 0, self, 0, tripwire);
            if (self function_39a33da3(trace) && self function_39a33da3(var_5110ef20)) {
                if (isdefined(level.localplayers)) {
                    foreach (player in level.localplayers) {
                        if (isdefined(player)) {
                            if (self.owner.team == player.team) {
                                beamname = "beam8_plyr_equip_ied_frnd";
                            } else {
                                beamname = "beam8_plyr_equip_ied_enmy";
                            }
                            beam_id = player beam::launch(tripwire, "tag_fx", self, "tag_fx", beamname);
                            arrayinsert(level.var_498c9822[player.localclientnum], beam_id, level.var_498c9822[player.localclientnum].size);
                        }
                    }
                }
            }
        }
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 7, eflags: 0x0
// Checksum 0xeb02851f, Offset: 0x9f8
// Size: 0xcc
function function_4e98f699(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self endon(#"death");
        self util::waittill_dobj(localclientnum);
        self.beam_fx = util::playfxontag(localclientnum, #"hash_253c31a9114d6029", self, "tag_origin");
        return;
    }
    if (isdefined(self.beam_fx)) {
        killfx(localclientnum, self.beam_fx);
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x831a0e6a, Offset: 0xad0
// Size: 0x7e
function function_712ca212(localclientnum) {
    currentoffhand = function_3a909b8c(localclientnum);
    if (level.tripwireweapon != currentoffhand) {
        return false;
    }
    if (!function_426e193(localclientnum)) {
        return false;
    }
    if (!function_a1d3de9(localclientnum)) {
        return false;
    }
    return true;
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0xb83bcaa9, Offset: 0xb58
// Size: 0x1ce
function function_bd991dd5(localclientnum) {
    self endon(#"death");
    self thread function_de8fc500(localclientnum);
    var_47135268 = 0;
    var_5e85c3ed = 0;
    var_b8768554 = #"tripwire_placement";
    level.var_3685964a = undefined;
    while (true) {
        var_5e85c3ed = var_47135268;
        var_47135268 = function_712ca212(localclientnum);
        if (var_47135268) {
            if (!isdefined(level.previs_model)) {
                spawn_previs(localclientnum);
            }
            if (!var_5e85c3ed) {
                var_47135268 = 1;
                level.previs_model show();
            }
            update_previs(localclientnum, var_b8768554);
        } else if (var_5e85c3ed && !var_47135268) {
            level.previs_model notify(#"death");
            level.previs_model delete();
            function_3e19f6f8();
            function_6e6376eb(localclientnum);
            if (objective_state(localclientnum, self.var_1a2c2a09) != "invisible") {
                objective_setstate(localclientnum, self.var_1a2c2a09, "invisible");
            }
        }
        waitframe(1);
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x7d396dd6, Offset: 0xd30
// Size: 0x74
function function_de8fc500(localclientnum) {
    self waittill(#"death");
    if (isdefined(level.previs_model)) {
        level.previs_model hide();
    }
    function_c93b984b();
    function_6e6376eb(localclientnum);
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x54ec07bf, Offset: 0xdb0
// Size: 0x6e
function spawn_previs(localclientnum) {
    localplayer = function_f97e7787(localclientnum);
    level.previs_model = spawn(localclientnum, (0, 0, 0), "script_model", localplayer getentitynumber());
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 2, eflags: 0x0
// Checksum 0xacd69389, Offset: 0xe28
// Size: 0x8c
function function_6a12de2f(previs_weapon, validlocation) {
    if (validlocation) {
        level.previs_model setmodel(#"hash_2edbbbe63af8213d");
    } else {
        level.previs_model setmodel(#"hash_6c54a3e97ce636f0");
    }
    level.previs_model notsolid();
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0x5aef3c90, Offset: 0xec0
// Size: 0x5c
function function_30ce9eed() {
    for (i = 0; i < level.var_93b67b4.size; i++) {
        if (level.var_93b67b4[i].shoulddraw == 0) {
            return i;
        }
    }
    return level.var_93b67b4.size;
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 2, eflags: 0x0
// Checksum 0x1b714fdd, Offset: 0xf28
// Size: 0x464
function update_previs(localclientnum, var_b8768554) {
    player = self;
    function_6a12de2f(level.tripwireweapon, 1);
    facing_angles = getlocalclientangles(localclientnum);
    forward = anglestoforward(facing_angles);
    up = anglestoup(facing_angles);
    velocity = function_5b2a9c4f(forward, up, level.tripwireweapon);
    eye_pos = getlocalclienteyepos(localclientnum);
    trace1 = function_3348176f(eye_pos, velocity, 0, level.tripwireweapon, level.var_3685964a);
    level.previs_model.origin = trace1[#"position"];
    level.previs_model.angles = (angleclamp180(vectortoangles(trace1[#"normal"])[0] + 90), vectortoangles(trace1[#"normal"])[1], 0);
    level.previs_model.hitent = trace1[#"entity"];
    if (isdefined(level.previs_model.hitent) && level.previs_model.hitent.weapon == level.tripwireweapon) {
        level.var_3685964a = level.previs_model.hitent;
    }
    if (level.tripwires.size > 0) {
        level.previs_model function_d0db687e(localclientnum);
    } else if (!isdefined(level.previs_model.var_3e94c899)) {
        level.previs_model.var_3e94c899 = util::playfxontag(localclientnum, #"hash_79d94632506eafee", level.previs_model, "tag_fx");
    }
    if (!isdefined(player.var_1a2c2a09)) {
        player.var_1a2c2a09 = util::getnextobjid(localclientnum);
        player thread function_75a48bfa(localclientnum, player.var_1a2c2a09);
    }
    if (isdefined(player.var_1a2c2a09) && !ispc()) {
        obj_id = player.var_1a2c2a09;
        if (function_11d9803d(localclientnum)) {
            objective_add(localclientnum, obj_id, "active", var_b8768554, trace1[#"position"]);
            objective_setgamemodeflags(localclientnum, obj_id, 0);
        } else if (objective_state(localclientnum, obj_id) != "invisible") {
            objective_setstate(localclientnum, obj_id, "invisible");
        }
    }
    function_3e19f6f8();
    function_6e6376eb(localclientnum);
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 3, eflags: 0x0
// Checksum 0xe167fd58, Offset: 0x1398
// Size: 0x11a
function function_4df20c36(tripwire, trace, var_5110ef20) {
    if (isdefined(level.previs_model.hitent) && level.previs_model.hitent isplayer()) {
        return false;
    }
    if (distancesquared(tripwire.origin, self.origin) < 100) {
        return false;
    }
    if (distancesquared(tripwire.origin, self.origin) > level.var_39fd437f.var_60431f90 * level.var_39fd437f.var_60431f90) {
        return false;
    }
    if (!self function_39a33da3(trace) || !self function_39a33da3(var_5110ef20)) {
        return false;
    }
    return true;
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x1af2c4a1, Offset: 0x14c0
// Size: 0x2ca
function function_d0db687e(localclientnum) {
    self.var_25c452f6 = 0;
    for (i = 0; i < level.tripwires.size; i++) {
        tripwire = level.tripwires[i];
        if (!isdefined(tripwire)) {
            continue;
        }
        if (self.ownernum != tripwire.ownernum) {
            continue;
        }
        var_e6e5330d = function_97461e42(self, tripwire);
        pos = self gettagorigin("tag_fx");
        otherpos = tripwire gettagorigin("tag_fx");
        trace = beamtrace(pos, otherpos, 0, self, 0, tripwire);
        var_5110ef20 = beamtrace(otherpos, pos, 0, self, 0, tripwire);
        if (function_4df20c36(tripwire, trace, var_5110ef20)) {
            self.var_25c452f6 = 1;
            if (!isdefined(var_e6e5330d)) {
                newbeam = spawnstruct();
                newbeam.ent1 = self;
                newbeam.ent2 = tripwire;
                newbeam.shoulddraw = 1;
                newbeam.beam_id = undefined;
                level.var_93b67b4[function_30ce9eed()] = newbeam;
            } else if (isdefined(var_e6e5330d) && !var_e6e5330d.shoulddraw) {
                var_e6e5330d.shoulddraw = 1;
            }
            if (isdefined(self.var_3e94c899)) {
                killfx(localclientnum, self.var_3e94c899);
                self.var_3e94c899 = undefined;
            }
            continue;
        }
        if (isdefined(var_e6e5330d)) {
            var_e6e5330d.shoulddraw = 0;
        }
    }
    if (!isdefined(self.var_3e94c899) && !self.var_25c452f6) {
        self.var_3e94c899 = util::playfxontag(localclientnum, #"hash_79d94632506eafee", self, "tag_fx");
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0xc56912ce, Offset: 0x1798
// Size: 0x160
function function_6e6376eb(localclientnum) {
    for (i = 0; i < level.var_93b67b4.size; i++) {
        beam = level.var_93b67b4[i];
        if (beam.shoulddraw && !isdefined(beam.beam_id) && isdefined(beam.ent1) && isdefined(beam.ent2)) {
            level.var_93b67b4[i].beam_id = level beam::function_31f5fd50(localclientnum, beam.ent1, "tag_fx", beam.ent2, "tag_fx", "beam8_plyr_equip_ied_previs");
            continue;
        }
        if (beam.shoulddraw == 0 && isdefined(beam.beam_id)) {
            beam::function_9bf5daf5(localclientnum, beam.beam_id);
            level.var_93b67b4[i].beam_id = undefined;
        }
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0x430e8bd8, Offset: 0x1900
// Size: 0x98
function function_3e19f6f8() {
    for (i = 0; i < level.var_93b67b4.size; i++) {
        beam = level.var_93b67b4[i];
        if (!isdefined(beam) || !isdefined(beam.ent1) || !isdefined(beam.ent2)) {
            level.var_93b67b4[i].shoulddraw = 0;
        }
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0xbb05e73, Offset: 0x19a0
// Size: 0x48
function function_c93b984b() {
    for (i = 0; i < level.var_93b67b4.size; i++) {
        level.var_93b67b4[i].shoulddraw = 0;
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 2, eflags: 0x0
// Checksum 0xf2d9b30b, Offset: 0x19f0
// Size: 0xaa
function function_97461e42(ent1, ent2) {
    foreach (beam in level.var_93b67b4) {
        if (beam.ent1 == ent1 && beam.ent2 == ent2) {
            return beam;
        }
    }
    return undefined;
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 2, eflags: 0x0
// Checksum 0xf737a7df, Offset: 0x1aa8
// Size: 0x6c
function function_75a48bfa(local_client_num, objective_id) {
    self waittill(#"death", #"disconnect", #"team_changed");
    if (isdefined(objective_id)) {
        objective_delete(local_client_num, objective_id);
    }
}

