#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;

#namespace gadget_radiation_field;

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0x382281a8, Offset: 0x268
// Size: 0x190
function init_shared() {
    clientfield::register("scriptmover", "cf_overclock_fx", 1, 1, "int", &function_b76867c3, 0, 0);
    clientfield::register("scriptmover", "self_destruct_start", 1, 1, "int", &self_destruct_start, 0, 0);
    clientfield::register("scriptmover", "self_destruct_end", 1, 1, "int", &self_destruct_end, 0, 0);
    level.var_ea1e23ea = getscriptbundle("radiation_field_bundle");
    callback::on_localplayer_spawned(&function_99c86759);
    level.var_37252d08 = [];
    level.var_b710266e = [];
    for (i = 0; i < getmaxlocalclients(); i++) {
        level.var_37252d08[i] = [];
        level.var_b710266e[i] = [];
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 7, eflags: 0x0
// Checksum 0x63371b03, Offset: 0x400
// Size: 0x42e
function self_destruct_start(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    isfirstperson = function_5459d334(localclientnum);
    var_70ff8f94 = self.owner getentitynumber();
    var_3c38d6ec = self getentitynumber();
    function_1efc517e(localclientnum, var_70ff8f94, var_3c38d6ec);
    if (newval) {
        self notify(#"stop_sounds");
        if (isdefined(isfirstperson) && isfirstperson) {
            sound = self playloopsound("mpl_rad_field_critical_loop");
            self thread function_166f798b(localclientnum, sound);
            if (isdefined(level.var_ea1e23ea.var_28355121)) {
                self stoprumble(localclientnum, level.var_ea1e23ea.var_28355121);
            }
            if (isdefined(level.var_ea1e23ea.var_44e6a33e)) {
                player = function_f97e7787(localclientnum);
                if (player getentitynumber() === var_70ff8f94) {
                    function_74354648(localclientnum, level.var_ea1e23ea.var_44e6a33e);
                }
            }
        } else {
            sound = self playloopsound("mpl_rad_field_critical_loop_3d");
            self thread function_166f798b(localclientnum, sound);
        }
        self.owner util::waittill_dobj(localclientnum);
        self function_48fe09d7(localclientnum, var_70ff8f94, 1);
        /#
            function_535b4cbb(localclientnum, "<dev string:x30>" + self getentitynumber());
        #/
        player = function_f97e7787(localclientnum);
        if (isdefined(player.var_e2f59f51)) {
            function_71255a66(localclientnum, player.var_e2f59f51);
            player.var_e2f59f51 = undefined;
        }
        player.var_e2f59f51 = earthquake(localclientnum, level.var_ea1e23ea.var_1e526668, 100000, self.owner.origin, level.var_ea1e23ea.var_c365e3c4, 0);
        level thread function_391be252(localclientnum, var_70ff8f94, self);
        return;
    }
    self notify(#"stop_sounds");
    if (isdefined(isfirstperson) && isfirstperson && isdefined(self)) {
        self function_d6ffb220(localclientnum);
    }
    player = function_f97e7787(localclientnum);
    if (isdefined(player.var_e2f59f51)) {
        function_71255a66(localclientnum, player.var_e2f59f51);
        player.var_e2f59f51 = undefined;
    }
}

/#

    // Namespace gadget_radiation_field/gadget_radiation_field
    // Params 2, eflags: 0x0
    // Checksum 0x5387cf2e, Offset: 0x838
    // Size: 0x9c
    function function_535b4cbb(localclientnum, text) {
        if (getdvarint(#"hash_4e684995fef4afd7", 0) != 0) {
            inkillcam = function_1fe374eb(localclientnum);
            println("<dev string:x60>" + text + (inkillcam ? "<dev string:x91>" : "<dev string:x9f>"));
        }
    }

#/

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 2, eflags: 0x0
// Checksum 0x8763b5b4, Offset: 0x8e0
// Size: 0x64
function function_166f798b(localclientnum, sound) {
    self waittill(#"death", #"stop_sounds");
    if (isdefined(self) && isdefined(sound)) {
        self stoploopsound(sound);
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 7, eflags: 0x0
// Checksum 0xf8b249c5, Offset: 0x950
// Size: 0x216
function self_destruct_end(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    isfirstperson = function_5459d334(localclientnum);
    if (newval) {
        if (isdefined(self.owner)) {
            var_70ff8f94 = self.owner getentitynumber();
            var_3c38d6ec = self getentitynumber();
            self.owner.nobloodoverlay = 0;
            function_1efc517e(localclientnum, var_70ff8f94, var_3c38d6ec);
        }
        self notify(#"stop_sounds");
        if (isdefined(isfirstperson) && isfirstperson) {
            playsound(localclientnum, "mpl_rad_field_meltdown_2d");
        } else {
            self endon(#"death");
            self util::waittill_dobj(localclientnum);
            playsound(localclientnum, "mpl_rad_field_meltdown_3d", self.origin + (0, 0, 30));
        }
        return;
    }
    if (isdefined(isfirstperson) && isfirstperson && isdefined(self)) {
        self function_d6ffb220(localclientnum);
    }
    player = function_f97e7787(localclientnum);
    if (isdefined(player.var_e2f59f51)) {
        function_71255a66(localclientnum, player.var_e2f59f51);
        player.var_e2f59f51 = undefined;
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0x7dda3a25, Offset: 0xb70
// Size: 0x2e8
function function_fa8596ce(localclientnum) {
    self notify(#"hash_31934c905f88261b");
    self endon(#"hash_31934c905f88261b");
    self endon(#"death");
    var_8ec2423d = level.var_ea1e23ea.var_95643a29 * level.var_ea1e23ea.var_95643a29;
    var_314c1153 = level.var_ea1e23ea.var_fc6c2739 * level.var_ea1e23ea.var_fc6c2739;
    var_d8407370 = #"hash_1a49fb45be903460";
    var_6173e786 = #"hash_1cc8ef91832fa038";
    while (true) {
        player = function_f97e7787(localclientnum);
        if (!isdefined(player) || !isalive(player)) {
            break;
        }
        dist2 = distance2dsquared(player.origin, self.origin);
        if (dist2 > var_8ec2423d) {
            if (isdefined(player.var_905167eb)) {
                player stoploopsound(player.var_905167eb);
                player.var_905167eb = undefined;
                player.var_f40e5042 = undefined;
            }
        } else if (dist2 < var_314c1153) {
            if (!isdefined(player.var_f40e5042) || player.var_f40e5042 != var_d8407370) {
                if (isdefined(player.var_905167eb)) {
                    player stoploopsound(player.var_905167eb);
                }
                player.var_905167eb = player playloopsound(#"hash_1a49fb45be903460");
                player.var_f40e5042 = var_d8407370;
            }
        } else if (!isdefined(player.var_f40e5042) || player.var_f40e5042 != var_6173e786) {
            if (isdefined(player.var_905167eb)) {
                player stoploopsound(player.var_905167eb);
            }
            player.var_905167eb = player playloopsound(#"hash_1cc8ef91832fa038");
            player.var_f40e5042 = var_6173e786;
        }
        waitframe(1);
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0x21bc9b56, Offset: 0xe60
// Size: 0x1ec
function function_99c86759(localclientnum) {
    self function_d6ffb220(localclientnum);
    if (isdefined(self) && isdefined(self.var_e2f59f51)) {
        function_71255a66(localclientnum, self.var_e2f59f51);
        self.var_e2f59f51 = undefined;
    }
    if (self postfx::function_7348f3a5("pstfx_radiation_dot")) {
        self postfx::exitpostfxbundle("pstfx_radiation_dot");
    }
    thread function_37eb5642(localclientnum);
    if (self function_40efd9db()) {
        var_70ff8f94 = self getentitynumber();
        if (isdefined(self.var_7bb17604)) {
            stopfx(localclientnum, self.var_7bb17604);
            self.var_7bb17604 = undefined;
        }
        if (isdefined(level.var_37252d08[localclientnum][var_70ff8f94])) {
            stopfx(localclientnum, level.var_37252d08[localclientnum][var_70ff8f94]);
        }
        if (isdefined(level.var_b710266e[localclientnum][var_70ff8f94])) {
            level.var_b710266e[localclientnum][var_70ff8f94] delete();
        }
        if (self postfx::function_7348f3a5("pstfx_burn_loop")) {
            self postfx::exitpostfxbundle("pstfx_burn_loop");
        }
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0x5e3761bc, Offset: 0x1058
// Size: 0x6c
function function_1d5d42b(localclientnum) {
    self postfx::playpostfxbundle("pstfx_radiation_dot");
    self.var_7bb17604 = util::playfxontag(localclientnum, #"hash_66860bac9e69a693", self, "j_spinelower");
    self thread function_312a1c2d();
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0xd6d0d4d7, Offset: 0x10d0
// Size: 0x84
function function_312a1c2d() {
    self notify(#"hash_1493843137e99d87");
    self endon(#"hash_1493843137e99d87");
    level waittill(#"game_ended");
    if (isdefined(self) && self postfx::function_7348f3a5("pstfx_radiation_dot")) {
        self postfx::stoppostfxbundle("pstfx_radiation_dot");
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0x9345de30, Offset: 0x1160
// Size: 0x1a0
function function_37eb5642(localclientnum) {
    self endon(#"death");
    var_2ef1abb2 = 0;
    var_8ec2423d = level.var_ea1e23ea.var_95643a29 * level.var_ea1e23ea.var_95643a29;
    var_314c1153 = level.var_ea1e23ea.var_fc6c2739 * level.var_ea1e23ea.var_fc6c2739;
    while (true) {
        dist2 = function_cb428eba(localclientnum);
        if (dist2 > var_8ec2423d) {
            if (var_2ef1abb2) {
                self postfx::exitpostfxbundle("pstfx_radiation_dot");
                if (isdefined(self.var_7bb17604)) {
                    stopfx(localclientnum, self.var_7bb17604);
                    self.var_7bb17604 = undefined;
                }
                var_2ef1abb2 = 0;
            }
        } else if (dist2 < var_314c1153) {
            if (!(isdefined(var_2ef1abb2) && var_2ef1abb2) && !isthirdperson(localclientnum) && !self isremotecontrolling(localclientnum)) {
                function_1d5d42b(localclientnum);
                var_2ef1abb2 = 1;
            }
        }
        wait 0.1;
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0x4a5f2bbe, Offset: 0x1308
// Size: 0x74
function function_1293015e(owner) {
    self endon(#"death");
    while (true) {
        if (isdefined(owner)) {
            tagorigin = owner gettagorigin("tag_fx");
            if (isdefined(tagorigin)) {
                self.origin = tagorigin;
            }
        }
        waitframe(1);
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 3, eflags: 0x0
// Checksum 0x7af8dc77, Offset: 0x1388
// Size: 0x354
function function_48fe09d7(localclientnum, var_70ff8f94, phase2) {
    startpos = self.owner gettagorigin("tag_fx");
    if (!isdefined(startpos)) {
        startpos = self.owner.origin;
    }
    if (!isdefined(level.var_b710266e[localclientnum][var_70ff8f94])) {
        level.var_b710266e[localclientnum][var_70ff8f94] = spawn(localclientnum, startpos, "script_model");
        level.var_b710266e[localclientnum][var_70ff8f94] setmodel("tag_origin");
    }
    if (isdefined(level.var_b710266e[localclientnum][var_70ff8f94])) {
        level.var_b710266e[localclientnum][var_70ff8f94] util::waittill_dobj(localclientnum);
    }
    if (phase2) {
        if (self function_55a8b32b()) {
            level.var_37252d08[localclientnum][var_70ff8f94] = util::playfxontag(localclientnum, "weapon/fx8_hero_sig_radiation_phase2_friend_v4", level.var_b710266e[localclientnum][var_70ff8f94], "tag_origin");
        } else {
            level.var_37252d08[localclientnum][var_70ff8f94] = util::playfxontag(localclientnum, "weapon/fx8_hero_sig_radiation_phase2_foe_v4", level.var_b710266e[localclientnum][var_70ff8f94], "tag_origin");
        }
    } else if (self function_55a8b32b()) {
        level.var_37252d08[localclientnum][var_70ff8f94] = util::playfxontag(localclientnum, "weapon/fx8_hero_sig_radiation_phase1_friend_v4", level.var_b710266e[localclientnum][var_70ff8f94], "tag_origin");
    } else {
        level.var_37252d08[localclientnum][var_70ff8f94] = util::playfxontag(localclientnum, "weapon/fx8_hero_sig_radiation_phase1_foe_v4", level.var_b710266e[localclientnum][var_70ff8f94], "tag_origin");
    }
    setfxteam(localclientnum, level.var_37252d08[localclientnum][var_70ff8f94], self.team);
    level.var_b710266e[localclientnum][var_70ff8f94] thread function_1293015e(self.owner);
    level.var_b710266e[localclientnum][var_70ff8f94] thread cleanup_fx(localclientnum, level.var_37252d08[localclientnum][var_70ff8f94]);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 2, eflags: 0x0
// Checksum 0x10eb3493, Offset: 0x16e8
// Size: 0x5c
function cleanup_fx(localclientnum, fx) {
    self waittill(#"delete", #"death");
    if (isdefined(fx)) {
        stopfx(localclientnum, fx);
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 7, eflags: 0x0
// Checksum 0xe9426d14, Offset: 0x1750
// Size: 0x3ec
function function_b76867c3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_70ff8f94 = self.owner getentitynumber();
    var_3c38d6ec = self getentitynumber();
    function_1efc517e(localclientnum, var_70ff8f94, var_3c38d6ec);
    /#
        function_535b4cbb(localclientnum, "<dev string:xa0>" + self getentitynumber());
    #/
    if (newval) {
        wait 0.2;
        if (isdefined(self) && isdefined(self.owner)) {
            self.owner.nobloodoverlay = 1;
            self.owner util::waittill_dobj(localclientnum);
            if (isdefined(self) && isdefined(self.owner)) {
                if (!self function_55a8b32b()) {
                    self thread function_fa8596ce(localclientnum);
                }
                self function_48fe09d7(localclientnum, var_70ff8f94, 0);
                /#
                    function_535b4cbb(localclientnum, "<dev string:xc3>" + self getentitynumber());
                #/
                player = function_f97e7787(localclientnum);
                if (isdefined(player.var_e2f59f51)) {
                    function_71255a66(localclientnum, player.var_e2f59f51);
                    player.var_e2f59f51 = undefined;
                }
                player.var_e2f59f51 = earthquake(localclientnum, level.var_ea1e23ea.var_60715133, 100000, self.owner.origin, level.var_ea1e23ea.var_65e19b8d, 0);
                level thread function_391be252(localclientnum, var_70ff8f94, self);
            }
        }
        if (isdefined(level.var_ea1e23ea.var_28355121)) {
            player = function_f97e7787(localclientnum);
            if (player getentitynumber() === var_70ff8f94) {
                function_74354648(localclientnum, level.var_ea1e23ea.var_28355121);
            }
        }
        return;
    }
    self notify(#"stop_sounds");
    player = function_f97e7787(localclientnum);
    if (isdefined(player)) {
        if (player getentitynumber() == var_70ff8f94) {
            player function_d6ffb220(localclientnum);
        }
        if (isdefined(player.var_e2f59f51)) {
            function_71255a66(localclientnum, player.var_e2f59f51);
            player.var_e2f59f51 = undefined;
        }
    }
    /#
        function_535b4cbb(localclientnum, "<dev string:xf0>" + self getentitynumber());
    #/
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 3, eflags: 0x0
// Checksum 0x3dfc4ee6, Offset: 0x1b48
// Size: 0x184
function function_1efc517e(localclientnum, var_70ff8f94, var_3c38d6ec) {
    inkillcam = function_1fe374eb(localclientnum);
    /#
        function_535b4cbb(localclientnum, "<dev string:x126>" + var_3c38d6ec);
    #/
    if (isdefined(level.var_b710266e[localclientnum][var_70ff8f94])) {
        /#
            function_535b4cbb(localclientnum, "<dev string:x14b>" + var_3c38d6ec);
        #/
        level.var_b710266e[localclientnum][var_70ff8f94] delete();
    }
    if (isdefined(level.var_37252d08[localclientnum][var_70ff8f94])) {
        /#
            function_535b4cbb(localclientnum, "<dev string:x186>" + var_3c38d6ec);
        #/
        stopfx(localclientnum, level.var_37252d08[localclientnum][var_70ff8f94]);
        level.var_37252d08[localclientnum][var_70ff8f94] = undefined;
        return;
    }
    /#
        function_535b4cbb(localclientnum, "<dev string:x1b9>" + var_3c38d6ec);
    #/
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0x54a25d61, Offset: 0x1cd8
// Size: 0x8c
function function_d6ffb220(localclientnum) {
    if (isdefined(level.var_ea1e23ea.var_28355121)) {
        self stoprumble(localclientnum, level.var_ea1e23ea.var_28355121);
    }
    if (isdefined(level.var_ea1e23ea.var_44e6a33e)) {
        self stoprumble(localclientnum, level.var_ea1e23ea.var_44e6a33e);
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 3, eflags: 0x0
// Checksum 0xad463cca, Offset: 0x1d70
// Size: 0x216
function function_391be252(localclientnum, var_70ff8f94, script_mover) {
    event = #"hash_5eb05b2054c53425" + var_70ff8f94;
    /#
        function_535b4cbb(localclientnum, "<dev string:x1f1>" + script_mover getentitynumber());
    #/
    level notify(event);
    level endon(event);
    var_3c38d6ec = script_mover getentitynumber();
    var_70ff8f94 = script_mover.owner getentitynumber();
    script_mover waittill(#"death");
    function_1efc517e(localclientnum, var_70ff8f94, var_3c38d6ec);
    player = function_f97e7787(localclientnum);
    if (isdefined(player.var_905167eb)) {
        player stoploopsound(player.var_905167eb);
        player.var_905167eb = undefined;
        player.var_f40e5042 = undefined;
    }
    if (isdefined(player) && isdefined(player getentitynumber() == var_70ff8f94) && player getentitynumber() == var_70ff8f94) {
        player function_d6ffb220(localclientnum);
        player.nobloodoverlay = 0;
    }
    if (isdefined(player) && isdefined(player.var_e2f59f51)) {
        function_71255a66(localclientnum, player.var_e2f59f51);
        player.var_e2f59f51 = undefined;
    }
}

