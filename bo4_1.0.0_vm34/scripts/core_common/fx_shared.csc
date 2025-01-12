#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace fx;

// Namespace fx/fx_shared
// Params 0, eflags: 0x2
// Checksum 0x7e74479f, Offset: 0xd8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"fx", &__init__, undefined, undefined);
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0x776018c6, Offset: 0x120
// Size: 0x24
function __init__() {
    callback::on_localclient_connect(&player_init);
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0xcb505869, Offset: 0x150
// Size: 0x2b2
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
// Checksum 0x640b5f36, Offset: 0x410
// Size: 0x5c
function validate(fxid, origin) {
    /#
        if (!isdefined(level._effect[fxid])) {
            assertmsg("<dev string:x30>" + fxid + "<dev string:x44>" + origin);
        }
    #/
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0x1194763f, Offset: 0x478
// Size: 0x12e
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
// Checksum 0xc7e2338a, Offset: 0x5b0
// Size: 0x106
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
// Checksum 0x5d34d705, Offset: 0x6c0
// Size: 0x56
function create_oneshot_effect(fxid) {
    ent = create_effect("oneshotfx", fxid);
    ent.v[#"delay"] = -15;
    return ent;
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x12f77718, Offset: 0x720
// Size: 0x56
function create_loop_effect(fxid) {
    ent = create_effect("loopfx", fxid);
    ent.v[#"delay"] = 0.5;
    return ent;
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0x5859a1e2, Offset: 0x780
// Size: 0x86
function set_forward_and_up_vectors() {
    self.v[#"up"] = anglestoup(self.v[#"angles"]);
    self.v[#"forward"] = anglestoforward(self.v[#"angles"]);
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0xf327805b, Offset: 0x810
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
    // Checksum 0x6782b259, Offset: 0x878
    // Size: 0x8
    function report_num_effects() {
        
    }

#/

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x8abffca5, Offset: 0x888
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
// Checksum 0x903b6c87, Offset: 0x9e8
// Size: 0x46
function lightning(normalfunc, flashfunc) {
    [[ flashfunc ]]();
    wait randomfloatrange(0.05, 0.1);
    [[ normalfunc ]]();
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x1d61081b, Offset: 0xa38
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
// Checksum 0x13e42a05, Offset: 0xb40
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
// Checksum 0x7854b321, Offset: 0xba8
// Size: 0x3c
function create_looper(clientnum) {
    self thread loop(clientnum);
    loop_sound(clientnum);
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x76b86a7e, Offset: 0xbf0
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
// Checksum 0xde74b02d, Offset: 0xe40
// Size: 0x18c
function create_trigger(clientnum) {
    validate(self.v[#"fxid"], self.v[#"origin"]);
    /#
        if (getdvarint(#"debug_fx", 0) > 0) {
            println("<dev string:x4b>" + self.v[#"fxid"]);
        }
    #/
    self.looperfx = playfx(clientnum, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"], self.v[#"delay"], self.v[#"primlightfrac"], self.v[#"lightoriginoffs"]);
    loop_sound(clientnum);
}

// Namespace fx/fx_shared
// Params 4, eflags: 0x0
// Checksum 0x7c2c7923, Offset: 0xfd8
// Size: 0x7c
function function_b63f5a0e(local_client_num, friendly_fx, enemy_fx, tag) {
    if (self function_31d3dfec()) {
        return util::playfxontag(local_client_num, friendly_fx, self, tag);
    }
    return util::playfxontag(local_client_num, enemy_fx, self, tag);
}

// Namespace fx/fx_shared
// Params 4, eflags: 0x0
// Checksum 0xbeacc074, Offset: 0x1060
// Size: 0x7c
function function_f4d5b085(local_client_num, friendly_fx, enemy_fx, origin) {
    if (self function_31d3dfec()) {
        return playfx(local_client_num, friendly_fx, origin);
    }
    return playfx(local_client_num, enemy_fx, origin);
}

// Namespace fx/fx_shared
// Params 4, eflags: 0x0
// Checksum 0xc14a4cf5, Offset: 0x10e8
// Size: 0x110
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
            self function_b63f5a0e(localclientnum, friendlyfx, enemyfx, self.lighttagname);
        }
        util::server_wait(localclientnum, 0.5, 0.016);
    }
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0xae7f3bc7, Offset: 0x1200
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
// Checksum 0x112e6b1, Offset: 0x1260
// Size: 0x5c
function blinky_emp_wait(localclientnum) {
    self endon(#"death");
    self endon(#"stop_blinky_light");
    self waittill(#"emp");
    self stop_blinky_light(localclientnum);
}

