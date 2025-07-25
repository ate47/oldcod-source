#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace fx;

// Namespace fx/fx_shared
// Params 0, eflags: 0x6
// Checksum 0xca68db60, Offset: 0x290
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"fx", &preinit, undefined, undefined, undefined);
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x4
// Checksum 0x8075747f, Offset: 0x2d8
// Size: 0x54
function private preinit() {
    callback::on_localclient_connect(&player_init);
    callback::on_spawned(&on_player_spawned);
    function_1725d99a();
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x48e84702, Offset: 0x338
// Size: 0x64
function on_player_spawned(localclientnum) {
    if (self function_21c0fa55() && getdvarint(#"hash_c11502c9fcc6e8d", 0)) {
        self thread function_3b26f98c(localclientnum);
    }
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x686ad0b0, Offset: 0x3a8
// Size: 0x290
function player_init(clientnum) {
    if (!isdefined(level.createfxent)) {
        return;
    }
    creatingexploderarray = 0;
    if (!isdefined(level.createfxexploders)) {
        creatingexploderarray = 1;
        level.createfxexploders = [];
    }
    for (i = 0; i < level.createfxent.size; i++) {
        ent = level.createfxent[i];
        if (!isdefined(level._createfxforwardandupset)) {
            if (!isdefined(level._createfxforwardandupset)) {
                ent set_forward_and_up_vectors();
            }
        }
        if (ent.v[#"type"] == "loopfx") {
            ent thread loop_thread(clientnum);
        }
        if (ent.v[#"type"] == "oneshotfx") {
            ent thread oneshot_thread(clientnum);
        }
        if (ent.v[#"type"] == "soundfx") {
            ent thread loop_sound(clientnum);
        }
        if (creatingexploderarray && ent.v[#"type"] == "exploder") {
            if (!isdefined(level.createfxexploders[ent.v[#"exploder"]])) {
                level.createfxexploders[ent.v[#"exploder"]] = [];
            }
            ent.v[#"exploder_id"] = exploder::getexploderid(ent);
            level.createfxexploders[ent.v[#"exploder"]][level.createfxexploders[ent.v[#"exploder"]].size] = ent;
        }
    }
    level._createfxforwardandupset = 1;
}

// Namespace fx/fx_shared
// Params 2, eflags: 0x0
// Checksum 0x8e95e15e, Offset: 0x640
// Size: 0x5c
function validate(fxid, origin) {
    /#
        if (!isdefined(level._effect[fxid])) {
            assertmsg("<dev string:x38>" + fxid + "<dev string:x4f>" + origin);
        }
    #/
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0xd2de29b2, Offset: 0x6a8
// Size: 0xfe
function create_loop_sound() {
    ent = spawnstruct();
    if (!isdefined(level.createfxent)) {
        level.createfxent = [];
    }
    level.createfxent[level.createfxent.size] = ent;
    ent.v = [];
    ent.v[#"type"] = "soundfx";
    ent.v[#"fxid"] = "No FX";
    ent.v[#"soundalias"] = "nil";
    ent.v[#"angles"] = (0, 0, 0);
    ent.v[#"origin"] = (0, 0, 0);
    ent.drawn = 1;
    return ent;
}

// Namespace fx/fx_shared
// Params 2, eflags: 0x0
// Checksum 0x5add186c, Offset: 0x7b0
// Size: 0xe6
function create_effect(type, fxid) {
    ent = spawnstruct();
    if (!isdefined(level.createfxent)) {
        level.createfxent = [];
    }
    level.createfxent[level.createfxent.size] = ent;
    ent.v = [];
    ent.v[#"type"] = type;
    ent.v[#"fxid"] = fxid;
    ent.v[#"angles"] = (0, 0, 0);
    ent.v[#"origin"] = (0, 0, 0);
    ent.drawn = 1;
    return ent;
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x6f1e21a9, Offset: 0x8a0
// Size: 0x50
function create_oneshot_effect(fxid) {
    ent = create_effect("oneshotfx", fxid);
    ent.v[#"delay"] = -15;
    return ent;
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x725896ff, Offset: 0x8f8
// Size: 0x50
function create_loop_effect(fxid) {
    ent = create_effect("loopfx", fxid);
    ent.v[#"delay"] = 0.5;
    return ent;
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0x4056b560, Offset: 0x950
// Size: 0x84
function set_forward_and_up_vectors() {
    self.v[#"up"] = anglestoup(self.v[#"angles"]);
    self.v[#"forward"] = anglestoforward(self.v[#"angles"]);
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0xca4395de, Offset: 0x9e0
// Size: 0x5c
function oneshot_thread(clientnum) {
    if (self.v[#"delay"] > 0) {
        wait self.v[#"delay"];
    }
    create_trigger(clientnum);
}

/#

    // Namespace fx/fx_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2af4f180, Offset: 0xa48
    // Size: 0x8
    function report_num_effects() {
        
    }

#/

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x8f4297de, Offset: 0xa58
// Size: 0x154
function loop_sound(clientnum) {
    if (clientnum != 0) {
        return;
    }
    self notify(#"stop_loop");
    if (isdefined(self.v[#"soundalias"]) && self.v[#"soundalias"] != "nil") {
        if (isdefined(self.v[#"stopable"]) && self.v[#"stopable"]) {
            thread sound::loop_fx_sound(clientnum, self.v[#"soundalias"], self.v[#"origin"], "stop_loop");
            return;
        }
        thread sound::loop_fx_sound(clientnum, self.v[#"soundalias"], self.v[#"origin"]);
    }
}

// Namespace fx/fx_shared
// Params 2, eflags: 0x0
// Checksum 0x38611031, Offset: 0xbb8
// Size: 0x46
function lightning(normalfunc, flashfunc) {
    [[ flashfunc ]]();
    wait randomfloatrange(0.05, 0.1);
    [[ normalfunc ]]();
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x5ead8cfd, Offset: 0xc08
// Size: 0xfc
function loop_thread(clientnum) {
    if (isdefined(self.fxstart)) {
        level waittill("start fx" + self.fxstart);
    }
    while (true) {
        create_looper(clientnum);
        if (isdefined(self.timeout)) {
            thread loop_stop(clientnum, self.timeout);
        }
        if (isdefined(self.fxstop)) {
            level waittill("stop fx" + self.fxstop);
        } else {
            return;
        }
        if (isdefined(self.looperfx)) {
            deletefx(clientnum, self.looperfx);
        }
        if (isdefined(self.fxstart)) {
            level waittill("start fx" + self.fxstart);
            continue;
        }
        return;
    }
}

// Namespace fx/fx_shared
// Params 2, eflags: 0x0
// Checksum 0x466f66e5, Offset: 0xd10
// Size: 0x5c
function loop_stop(clientnum, timeout) {
    self endon(#"death");
    wait timeout;
    if (isdefined(self.looper)) {
        deletefx(clientnum, self.looper);
    }
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0xa2b10698, Offset: 0xd78
// Size: 0x3c
function create_looper(clientnum) {
    self thread loop(clientnum);
    loop_sound(clientnum);
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0xb9b73e14, Offset: 0xdc0
// Size: 0x246
function loop(clientnum) {
    validate(self.v[#"fxid"], self.v[#"origin"]);
    self.looperfx = playfx(clientnum, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"], self.v[#"delay"], self.v[#"primlightfrac"], self.v[#"lightoriginoffs"]);
    while (true) {
        if (isdefined(self.v[#"delay"])) {
            wait self.v[#"delay"];
        }
        while (isfxplaying(clientnum, self.looperfx)) {
            wait 0.25;
        }
        self.looperfx = playfx(clientnum, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"], 0, self.v[#"primlightfrac"], self.v[#"lightoriginoffs"]);
    }
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x4a4239e9, Offset: 0x1010
// Size: 0x18c
function create_trigger(clientnum) {
    validate(self.v[#"fxid"], self.v[#"origin"]);
    /#
        if (getdvarint(#"debug_fx", 0) > 0) {
            println("<dev string:x59>" + self.v[#"fxid"]);
        }
    #/
    self.looperfx = playfx(clientnum, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"], self.v[#"delay"], self.v[#"primlightfrac"], self.v[#"lightoriginoffs"]);
    loop_sound(clientnum);
}

// Namespace fx/fx_shared
// Params 4, eflags: 0x0
// Checksum 0x675e9bb8, Offset: 0x11a8
// Size: 0x7c
function function_3539a829(local_client_num, friendly_fx, enemy_fx, tag) {
    if (self function_ca024039()) {
        return util::playfxontag(local_client_num, friendly_fx, self, tag);
    }
    return util::playfxontag(local_client_num, enemy_fx, self, tag);
}

// Namespace fx/fx_shared
// Params 4, eflags: 0x0
// Checksum 0xc6dc66a1, Offset: 0x1230
// Size: 0x74
function function_94d3d1d(local_client_num, friendly_fx, enemy_fx, origin) {
    if (self function_ca024039()) {
        return playfx(local_client_num, friendly_fx, origin);
    }
    return playfx(local_client_num, enemy_fx, origin);
}

// Namespace fx/fx_shared
// Params 4, eflags: 0x0
// Checksum 0xaf6a0361, Offset: 0x12b0
// Size: 0x108
function blinky_light(localclientnum, tagname, friendlyfx, enemyfx) {
    self endon(#"death");
    self endon(#"stop_blinky_light");
    self.lighttagname = tagname;
    self util::waittill_dobj(localclientnum);
    self thread blinky_emp_wait(localclientnum);
    while (true) {
        if (isdefined(self.stunned) && self.stunned) {
            wait 0.1;
            continue;
        }
        if (isdefined(self)) {
            self function_3539a829(localclientnum, friendlyfx, enemyfx, self.lighttagname);
        }
        util::server_wait(localclientnum, 0.5, 0.016);
    }
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0xb18efb06, Offset: 0x13c0
// Size: 0x56
function stop_blinky_light(localclientnum) {
    self notify(#"stop_blinky_light");
    if (!isdefined(self.blinkylightfx)) {
        return;
    }
    stopfx(localclientnum, self.blinkylightfx);
    self.blinkylightfx = undefined;
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x876217fc, Offset: 0x1420
// Size: 0x5c
function blinky_emp_wait(localclientnum) {
    self endon(#"death");
    self endon(#"stop_blinky_light");
    self waittill(#"emp");
    self stop_blinky_light(localclientnum);
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x3509ba45, Offset: 0x1488
// Size: 0x1f8
function function_3b26f98c(localclientnum) {
    self notify(#"hash_348eb868068f5fa3");
    self endon(#"death", #"hash_348eb868068f5fa3");
    while (true) {
        self waittill(#"weapon_fired");
        self postfx::playpostfxbundle(#"hash_6d2d4591d1249a6e");
        n_lerp_time = getdvarint(#"hash_3f9892863b8f6bb0", 50);
        var_cfd68180 = getdvarfloat(#"hash_1e859abbf35194ee", -1);
        self util::lerp_generic(localclientnum, n_lerp_time, &function_29150e99, 0, var_cfd68180, #"hash_31ad23226325090", #"hash_6d2d4591d1249a6e");
        self util::lerp_generic(localclientnum, n_lerp_time, &function_29150e99, var_cfd68180, 0.15, #"hash_31ad23226325090", #"hash_6d2d4591d1249a6e");
        self util::lerp_generic(localclientnum, n_lerp_time, &function_29150e99, 0.15, 0, #"hash_31ad23226325090", #"hash_6d2d4591d1249a6e");
        self codestoppostfxbundle(#"hash_6d2d4591d1249a6e");
    }
}

// Namespace fx/fx_shared
// Params 8, eflags: 0x0
// Checksum 0xc582aba3, Offset: 0x1688
// Size: 0x94
function function_29150e99(*current_time, elapsed_time, *local_client_num, duration, var_8a5c2b54, var_dc3fdb72, constant, postfx) {
    percent = local_client_num / duration;
    amount = var_dc3fdb72 * percent + var_8a5c2b54 * (1 - percent);
    self function_116b95e5(postfx, constant, amount);
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x4
// Checksum 0x61b1b497, Offset: 0x1728
// Size: 0x1fc
function private function_1725d99a() {
    function_5ac4dc99("_internal_dof_i_target_type", -1);
    function_5ac4dc99("_internal_dof_i_target_entnum", -1);
    function_5ac4dc99("_internal_dof_v_target_origin", (-1, -1, -1));
    function_5ac4dc99("_internal_dof_i_playernum", -1);
    function_5ac4dc99("_internal_dof_s_target_tag", "-1");
    function_5ac4dc99("_internal_dof_f_fstop", -1);
    function_5ac4dc99("_internal_dof_f_fstop_time", -1);
    function_5ac4dc99("_internal_dof_f_focus_time", -1);
    function_5ac4dc99("_internal_dof_i_refcounter", 0);
    function_cd140ee9("_internal_dof_i_refcounter", &function_a795470c);
    function_5ac4dc99("_internal_fob_i_playernum", -1);
    function_5ac4dc99("_internal_fob_f_fstop", 1);
    function_5ac4dc99("_internal_fob_f_fstop_time", -1);
    function_5ac4dc99("_internal_fob_i_refcounter", 0);
    function_5ac4dc99("_internal_debug_dof", 0);
    function_cd140ee9("_internal_fob_i_refcounter", &function_5409b584);
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0x58a66f55, Offset: 0x1930
// Size: 0x3a4
function function_a795470c() {
    players = getlocalplayers();
    foreach (player in players) {
        if (player getentitynumber() == getdvarint(#"_internal_dof_i_playernum", -1)) {
            var_1498bcbe = undefined;
            var_3ed74fac = getdvarint(#"_internal_dof_i_target_entnum", -1);
            if (var_3ed74fac == -1) {
                var_3ed74fac = undefined;
            }
            var_dc3df1b8 = getdvarint(#"_internal_dof_i_target_type", -1);
            if (var_dc3df1b8 == -1) {
                var_dc3df1b8 = undefined;
            }
            var_1436aa92 = getdvarstring(#"_internal_dof_s_target_tag", "-1");
            if (var_1436aa92 == "-1") {
                var_1436aa92 = undefined;
            }
            var_486f31cd = getdvarfloat(#"_internal_dof_f_fstop", -1);
            if (var_486f31cd == -1) {
                var_486f31cd = undefined;
            }
            var_e9f7aace = getdvarfloat(#"_internal_dof_f_fstop_time", -1);
            if (var_e9f7aace == -1) {
                var_e9f7aace = undefined;
            }
            var_bef008a5 = getdvarfloat(#"_internal_dof_f_focus_time", -1);
            if (var_bef008a5 == -1) {
                var_bef008a5 = undefined;
            }
            if (var_3ed74fac == -999) {
                var_1498bcbe = getdvarvector(#"hash_7c405920e0b200ee", (-1, -1, -1));
                var_1436aa92 = undefined;
            } else {
                ents = getentarraybytype(0, var_dc3df1b8);
                foreach (ent in ents) {
                    entnum = ent getentitynumber();
                    if (entnum == var_3ed74fac) {
                        var_1498bcbe = ent;
                        break;
                    }
                }
            }
            player thread function_70ba68f1(var_1498bcbe, var_486f31cd, var_bef008a5, var_e9f7aace, var_1436aa92);
            break;
        }
    }
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0x8998bfba, Offset: 0x1ce0
// Size: 0x170
function function_5409b584() {
    players = getlocalplayers();
    foreach (player in players) {
        if (player getentitynumber() == getdvarint(#"_internal_fob_i_playernum", -1)) {
            var_904e61ce = getdvarfloat(#"_internal_fob_f_fstop", 1);
            if (var_904e61ce == -1) {
                var_904e61ce = undefined;
            }
            var_f7259b16 = getdvarfloat(#"_internal_fob_f_fstop_time", -1);
            if (var_f7259b16 == -1) {
                var_f7259b16 = undefined;
            }
            player thread function_82104e32(var_904e61ce, var_f7259b16);
        }
    }
}

// Namespace fx/fx_shared
// Params 3, eflags: 0x0
// Checksum 0x10bbc3a, Offset: 0x1e58
// Size: 0x28c
function function_82104e32(var_904e61ce, var_f7259b16, var_ff9d26ff) {
    self notify(#"hash_1481a83e14539c4");
    self endon(#"hash_1481a83e14539c4");
    self endon(#"death");
    if (!isdefined(var_904e61ce)) {
        var_904e61ce = 1;
    }
    if (!isdefined(var_f7259b16)) {
        var_f7259b16 = 0.1;
    }
    if (!isdefined(var_ff9d26ff)) {
        var_ff9d26ff = var_f7259b16;
    }
    self function_9e574055(2);
    playernum = self getentitynumber();
    self function_1816c600(var_904e61ce, var_f7259b16);
    var_eb618ad5 = 500 / var_ff9d26ff;
    prev_time = undefined;
    while (playernum == getdvarint(#"_internal_fob_i_playernum", -1)) {
        if (isdefined(prev_time)) {
            var_a122c423 = gettime() - prev_time;
            var_56eeee5f = self trace_distance();
            var_99faea6 = self function_78bf7752();
            var_2ae21772 = undefined;
            if (abs(var_56eeee5f - var_99faea6) > 1) {
                var_1957b598 = var_eb618ad5 * var_a122c423 * 0.001;
                if (var_99faea6 > var_56eeee5f) {
                    var_2ae21772 = var_99faea6 - var_1957b598;
                    if (var_2ae21772 < var_56eeee5f) {
                        var_2ae21772 = var_56eeee5f;
                    }
                } else {
                    var_2ae21772 = var_99faea6 + var_1957b598;
                    if (var_2ae21772 > var_56eeee5f) {
                        var_2ae21772 = var_56eeee5f;
                    }
                }
                if (var_2ae21772 < 0) {
                    var_2ae21772 = 0;
                } else if (var_2ae21772 > 500) {
                    var_2ae21772 = 500;
                }
                self function_d7be9a9f(var_2ae21772, 0);
            }
        }
        prev_time = gettime();
        waitframe(1);
    }
    self function_c2856ebd(0.5);
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0x476c61e7, Offset: 0x20f0
// Size: 0x1d8
function trace_distance() {
    tracedist = 500;
    playereye = self geteye();
    var_a6cb20ff = self getplayerangles();
    if (isdefined(self.dof_ref_ent)) {
        playerangles = combineangles(self.dof_ref_ent.angles, var_a6cb20ff);
    } else {
        playerangles = var_a6cb20ff;
    }
    playerforward = vectornormalize(anglestoforward(playerangles));
    trace = bullettrace(playereye, playereye + playerforward * tracedist, 1, self);
    dist = distance(playereye, trace[#"position"]);
    /#
        if (getdvarint(#"_internal_debug_dof", 0) == 1) {
            var_cba8e949 = 1;
            debugstar(trace[#"position"], var_cba8e949, (0, 1, 0));
            print3d(trace[#"position"], "<dev string:x6c>" + dist, (0, 1, 0), 1, 0.2, var_cba8e949);
        }
    #/
    return dist;
}

// Namespace fx/fx_shared
// Params 5, eflags: 0x0
// Checksum 0xd83f3769, Offset: 0x22d0
// Size: 0x32c
function function_70ba68f1(var_e4db2d63, var_904e61ce, var_ff9d26ff, var_f7259b16, tag) {
    self notify(#"hash_1481a83e14539c4");
    self endon(#"hash_1481a83e14539c4");
    self endon(#"death");
    if (!isdefined(var_e4db2d63)) {
        /#
            iprintlnbold("<dev string:x79>");
        #/
        return;
    }
    if (!isdefined(var_ff9d26ff)) {
        var_ff9d26ff = 0.05;
    }
    if (!isdefined(var_f7259b16)) {
        var_f7259b16 = 0.05;
    }
    self function_9e574055(2);
    var_ae5fe668 = max(var_ff9d26ff, var_f7259b16);
    playernum = self getentitynumber();
    while (playernum == getdvarint(#"_internal_dof_i_playernum", -1)) {
        target_origin = undefined;
        if (isdefined(var_e4db2d63)) {
            if (isvec(var_e4db2d63)) {
                target_origin = var_e4db2d63;
                var_608ff588 = distance(self geteye(), target_origin);
            } else if (isdefined(tag)) {
                ent = var_e4db2d63;
                target_origin = ent gettagorigin(tag);
                var_608ff588 = distance(self geteye(), target_origin);
            } else {
                ent = var_e4db2d63;
                target_origin = ent.origin;
                var_608ff588 = distance(self geteye(), target_origin);
            }
        } else {
            var_608ff588 = 500;
        }
        self function_1816c600(var_904e61ce, var_f7259b16);
        self function_d7be9a9f(var_608ff588, var_ff9d26ff);
        /#
            wait_frames = int(ceil(var_ae5fe668 * 50));
            debugstar(target_origin, wait_frames, (0, 1, 0));
            print3d(target_origin, "<dev string:x94>" + var_608ff588, (0, 1, 0), 1, 0.5, wait_frames);
        #/
        wait var_ae5fe668;
    }
    self function_c2856ebd(0.05);
}

