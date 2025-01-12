#using scripts/core_common/callbacks_shared;
#using scripts/core_common/exploder_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace fx;

// Namespace fx/fx_shared
// Params 0, eflags: 0x2
// Checksum 0xead4e52b, Offset: 0x1f0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("fx", &__init__, undefined, undefined);
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0x8093a38f, Offset: 0x230
// Size: 0x24
function __init__() {
    callback::on_localclient_connect(&player_init);
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0xf928418a, Offset: 0x260
// Size: 0x284
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
        if (ent.v["type"] == "loopfx") {
            ent thread loop_thread(clientnum);
        }
        if (ent.v["type"] == "oneshotfx") {
            ent thread oneshot_thread(clientnum);
        }
        if (ent.v["type"] == "soundfx") {
            ent thread loop_sound(clientnum);
        }
        if (creatingexploderarray && ent.v["type"] == "exploder") {
            if (!isdefined(level.createfxexploders[ent.v["exploder"]])) {
                level.createfxexploders[ent.v["exploder"]] = [];
            }
            ent.v["exploder_id"] = exploder::getexploderid(ent);
            level.createfxexploders[ent.v["exploder"]][level.createfxexploders[ent.v["exploder"]].size] = ent;
        }
    }
    level._createfxforwardandupset = 1;
}

// Namespace fx/fx_shared
// Params 2, eflags: 0x0
// Checksum 0x8fb5b15f, Offset: 0x4f0
// Size: 0x5c
function validate(fxid, origin) {
    /#
        if (!isdefined(level._effect[fxid])) {
            assertmsg("<dev string:x28>" + fxid + "<dev string:x3c>" + origin);
        }
    #/
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0x20457301, Offset: 0x558
// Size: 0x11c
function create_loop_sound() {
    ent = spawnstruct();
    if (!isdefined(level.createfxent)) {
        level.createfxent = [];
    }
    level.createfxent[level.createfxent.size] = ent;
    ent.v = [];
    ent.v["type"] = "soundfx";
    ent.v["fxid"] = "No FX";
    ent.v["soundalias"] = "nil";
    ent.v["angles"] = (0, 0, 0);
    ent.v["origin"] = (0, 0, 0);
    ent.drawn = 1;
    return ent;
}

// Namespace fx/fx_shared
// Params 2, eflags: 0x0
// Checksum 0x956f9f6d, Offset: 0x680
// Size: 0x104
function create_effect(type, fxid) {
    ent = spawnstruct();
    if (!isdefined(level.createfxent)) {
        level.createfxent = [];
    }
    level.createfxent[level.createfxent.size] = ent;
    ent.v = [];
    ent.v["type"] = type;
    ent.v["fxid"] = fxid;
    ent.v["angles"] = (0, 0, 0);
    ent.v["origin"] = (0, 0, 0);
    ent.drawn = 1;
    return ent;
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x5c3b371c, Offset: 0x790
// Size: 0x56
function create_oneshot_effect(fxid) {
    ent = create_effect("oneshotfx", fxid);
    ent.v["delay"] = -15;
    return ent;
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0xb9e67d91, Offset: 0x7f0
// Size: 0x5a
function create_loop_effect(fxid) {
    ent = create_effect("loopfx", fxid);
    ent.v["delay"] = 0.5;
    return ent;
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0x858b267a, Offset: 0x858
// Size: 0x76
function set_forward_and_up_vectors() {
    self.v["up"] = anglestoup(self.v["angles"]);
    self.v["forward"] = anglestoforward(self.v["angles"]);
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0xaf772eef, Offset: 0x8d8
// Size: 0x4c
function oneshot_thread(clientnum) {
    if (self.v["delay"] > 0) {
        wait self.v["delay"];
    }
    create_trigger(clientnum);
}

/#

    // Namespace fx/fx_shared
    // Params 0, eflags: 0x0
    // Checksum 0xefa80f39, Offset: 0x930
    // Size: 0x8
    function report_num_effects() {
        
    }

#/

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x9bb5a609, Offset: 0x940
// Size: 0x10c
function loop_sound(clientnum) {
    if (clientnum != 0) {
        return;
    }
    self notify(#"stop_loop");
    if (isdefined(self.v["soundalias"]) && self.v["soundalias"] != "nil") {
        if (isdefined(self.v["stopable"]) && self.v["stopable"]) {
            thread sound::loop_fx_sound(clientnum, self.v["soundalias"], self.v["origin"], "stop_loop");
            return;
        }
        thread sound::loop_fx_sound(clientnum, self.v["soundalias"], self.v["origin"]);
    }
}

// Namespace fx/fx_shared
// Params 2, eflags: 0x0
// Checksum 0x5f92650, Offset: 0xa58
// Size: 0x50
function lightning(normalfunc, flashfunc) {
    [[ flashfunc ]]();
    wait randomfloatrange(0.05, 0.1);
    [[ normalfunc ]]();
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0xeef1a999, Offset: 0xab0
// Size: 0x118
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
// Checksum 0x738e9026, Offset: 0xbd0
// Size: 0x54
function loop_stop(clientnum, timeout) {
    self endon(#"death");
    wait timeout;
    if (isdefined(self.looper)) {
        deletefx(clientnum, self.looper);
    }
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x3a29b475, Offset: 0xc30
// Size: 0x3c
function create_looper(clientnum) {
    self thread loop(clientnum);
    loop_sound(clientnum);
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x3276fa42, Offset: 0xc78
// Size: 0x1d8
function loop(clientnum) {
    validate(self.v["fxid"], self.v["origin"]);
    self.looperfx = playfx(clientnum, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], self.v["delay"], self.v["primlightfrac"], self.v["lightoriginoffs"]);
    while (true) {
        if (isdefined(self.v["delay"])) {
            wait self.v["delay"];
        }
        while (isfxplaying(clientnum, self.looperfx)) {
            wait 0.25;
        }
        self.looperfx = playfx(clientnum, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], 0, self.v["primlightfrac"], self.v["lightoriginoffs"]);
    }
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x3d901c3a, Offset: 0xe58
// Size: 0x14c
function create_trigger(clientnum) {
    validate(self.v["fxid"], self.v["origin"]);
    /#
        if (getdvarint("<dev string:x43>") > 0) {
            println("<dev string:x4c>" + self.v["<dev string:x5c>"]);
        }
    #/
    self.looperfx = playfx(clientnum, level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"], self.v["delay"], self.v["primlightfrac"], self.v["lightoriginoffs"]);
    loop_sound(clientnum);
}

// Namespace fx/fx_shared
// Params 4, eflags: 0x0
// Checksum 0xc42643a5, Offset: 0xfb0
// Size: 0x158
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
            if (util::friend_not_foe(localclientnum)) {
                self.blinkylightfx = playfxontag(localclientnum, friendlyfx, self, self.lighttagname);
            } else {
                self.blinkylightfx = playfxontag(localclientnum, enemyfx, self, self.lighttagname);
            }
        }
        util::server_wait(localclientnum, 0.5, 0.016);
    }
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x361f0180, Offset: 0x1110
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
// Checksum 0xd5fc9943, Offset: 0x1170
// Size: 0x4c
function blinky_emp_wait(localclientnum) {
    self endon(#"death");
    self endon(#"stop_blinky_light");
    self waittill("emp");
    self stop_blinky_light(localclientnum);
}

