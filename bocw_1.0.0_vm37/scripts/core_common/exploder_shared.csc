#using scripts\core_common\callbacks_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace exploder;

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x6
// Checksum 0x66a4488d, Offset: 0x108
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"exploder", &preinit, undefined, undefined, undefined);
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x4
// Checksum 0xbe0aeeac, Offset: 0x150
// Size: 0x34
function private preinit() {
    if (sessionmodeiscampaigngame()) {
        callback::on_localclient_connect(&player_init);
    }
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0x5ea3a44f, Offset: 0x190
// Size: 0xb14
function player_init(*clientnum) {
    script_exploders = [];
    ents = struct::get_array("script_brushmodel", "classname");
    smodels = struct::get_array("script_model", "classname");
    for (i = 0; i < smodels.size; i++) {
        ents[ents.size] = smodels[i];
    }
    for (i = 0; i < ents.size; i++) {
        if (isdefined(ents[i].script_prefab_exploder)) {
            ents[i].script_exploder = ents[i].script_prefab_exploder;
        }
    }
    potentialexploders = struct::get_array("script_brushmodel", "classname");
    for (i = 0; i < potentialexploders.size; i++) {
        if (isdefined(potentialexploders[i].script_prefab_exploder)) {
            potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
        }
        if (isdefined(potentialexploders[i].script_exploder)) {
            script_exploders[script_exploders.size] = potentialexploders[i];
        }
    }
    potentialexploders = struct::get_array("script_model", "classname");
    for (i = 0; i < potentialexploders.size; i++) {
        if (isdefined(potentialexploders[i].script_prefab_exploder)) {
            potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
        }
        if (isdefined(potentialexploders[i].script_exploder)) {
            script_exploders[script_exploders.size] = potentialexploders[i];
        }
    }
    if (isdefined(level.struct)) {
        for (i = 0; i < level.struct.size; i++) {
            if (isdefined(level.struct[i].script_prefab_exploder)) {
                level.struct[i].script_exploder = level.struct[i].script_prefab_exploder;
            }
            if (isdefined(level.struct[i].script_exploder)) {
                script_exploders[script_exploders.size] = level.struct[i];
            }
        }
    }
    if (!isdefined(level.createfxent)) {
        level.createfxent = [];
    }
    acceptabletargetnames = [];
    acceptabletargetnames[#"exploderchunk visible"] = 1;
    acceptabletargetnames[#"exploderchunk"] = 1;
    acceptabletargetnames[#"exploder"] = 1;
    exploder_id = 1;
    for (i = 0; i < script_exploders.size; i++) {
        exploder = script_exploders[i];
        ent = createexploder(exploder.script_fxid);
        ent.v = [];
        ent.v[#"origin"] = exploder.origin;
        ent.v[#"angles"] = exploder.angles;
        ent.v[#"delay"] = exploder.script_delay;
        ent.v[#"firefx"] = exploder.script_firefx;
        ent.v[#"firefxdelay"] = exploder.script_firefxdelay;
        ent.v[#"firefxsound"] = exploder.script_firefxsound;
        ent.v[#"firefxtimeout"] = exploder.script_firefxtimeout;
        ent.v[#"trailfx"] = exploder.script_trailfx;
        ent.v[#"trailfxtag"] = exploder.script_trailfxtag;
        ent.v[#"trailfxdelay"] = exploder.script_trailfxdelay;
        ent.v[#"trailfxsound"] = exploder.script_trailfxsound;
        ent.v[#"trailfxtimeout"] = exploder.script_firefxtimeout;
        ent.v[#"earthquake"] = exploder.script_earthquake;
        ent.v[#"rumble"] = exploder.script_rumble;
        ent.v[#"damage"] = exploder.script_damage;
        ent.v[#"damage_radius"] = exploder.script_radius;
        ent.v[#"repeat"] = exploder.script_repeat;
        ent.v[#"delay_min"] = exploder.script_delay_min;
        ent.v[#"delay_max"] = exploder.script_delay_max;
        ent.v[#"target"] = exploder.target;
        ent.v[#"ender"] = exploder.script_ender;
        ent.v[#"physics"] = exploder.script_physics;
        ent.v[#"type"] = "exploder";
        if (!isdefined(exploder.script_fxid)) {
            ent.v[#"fxid"] = "No FX";
        } else {
            ent.v[#"fxid"] = exploder.script_fxid;
        }
        ent.v[#"exploder"] = exploder.script_exploder;
        if (!isdefined(ent.v[#"delay"])) {
            ent.v[#"delay"] = 0;
        }
        if (isdefined(exploder.script_sound)) {
            ent.v[#"soundalias"] = exploder.script_sound;
        } else if (ent.v[#"fxid"] != "No FX") {
            if (isdefined(level.scr_sound) && isdefined(level.scr_sound[ent.v[#"fxid"]])) {
                ent.v[#"soundalias"] = level.scr_sound[ent.v[#"fxid"]];
            }
        }
        fixup_set = 0;
        if (isdefined(ent.v[#"target"])) {
            ent.needs_fixup = exploder_id;
            exploder_id++;
            fixup_set = 1;
            temp_ent = struct::get(ent.v[#"target"], "targetname");
            if (isdefined(temp_ent)) {
                org = temp_ent.origin;
            }
            if (isdefined(org)) {
                ent.v[#"angles"] = vectortoangles(org - ent.v[#"origin"]);
            }
            if (isdefined(ent.v[#"angles"])) {
                ent fx::set_forward_and_up_vectors();
            }
        }
        if (isdefined(exploder.classname) && exploder.classname == "script_brushmodel" || isdefined(exploder.model)) {
            ent.model = exploder;
            if (fixup_set == 0) {
                ent.needs_fixup = exploder_id;
                exploder_id++;
            }
        }
        if (isdefined(exploder.targetname) && isdefined(acceptabletargetnames[exploder.targetname])) {
            ent.v[#"exploder_type"] = exploder.targetname;
            continue;
        }
        ent.v[#"exploder_type"] = "normal";
    }
    level.createfxexploders = [];
    for (i = 0; i < level.createfxent.size; i++) {
        ent = level.createfxent[i];
        if (ent.v[#"type"] != "exploder") {
            continue;
        }
        ent.v[#"exploder_id"] = getexploderid(ent);
        if (!isdefined(level.createfxexploders[ent.v[#"exploder"]])) {
            level.createfxexploders[ent.v[#"exploder"]] = [];
        }
        level.createfxexploders[ent.v[#"exploder"]][level.createfxexploders[ent.v[#"exploder"]].size] = ent;
    }
    reportexploderids();
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xa0b6635, Offset: 0xcb0
// Size: 0xb8
function getexploderid(ent) {
    if (!isdefined(level._exploder_ids)) {
        level._exploder_ids = [];
        level._exploder_id = 1;
    }
    if (!isdefined(level._exploder_ids[ent.v[#"exploder"]])) {
        level._exploder_ids[ent.v[#"exploder"]] = level._exploder_id;
        level._exploder_id++;
    }
    return level._exploder_ids[ent.v[#"exploder"]];
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xd70
// Size: 0x4
function reportexploderids() {
    
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0x6934de22, Offset: 0xd80
// Size: 0x54
function exploder(exploder_id) {
    if (isint(exploder_id)) {
        activate_exploder(exploder_id);
        return;
    }
    activate_radiant_exploder(exploder_id);
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0x281ba970, Offset: 0xde0
// Size: 0x84
function function_993369d6(exploder_id) {
    if (isstring(exploder_id) || ishash(exploder_id)) {
        activate_radiant_exploder(exploder_id, 1);
        return;
    }
    assertmsg("<dev string:x38>" + exploder_id);
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xfe8c529, Offset: 0xe70
// Size: 0xfc
function activate_exploder(num) {
    num = int(num);
    if (isdefined(level.createfxexploders) && isdefined(level.createfxexploders[num])) {
        for (i = 0; i < level.createfxexploders[num].size; i++) {
            level.createfxexploders[num][i] activate_individual_exploder();
        }
    }
    if (exploder_is_lightning_exploder(num)) {
        if (isdefined(level.lightningnormalfunc) && isdefined(level.lightningflashfunc)) {
            thread fx::lightning(level.lightningnormalfunc, level.lightningflashfunc);
        }
    }
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x76f0b1f0, Offset: 0xf78
// Size: 0x10c
function activate_individual_exploder() {
    if (!isdefined(self.v[#"angles"])) {
        self.v[#"angles"] = (0, 0, 0);
        self fx::set_forward_and_up_vectors();
    }
    if (isdefined(self.v[#"firefx"])) {
        self thread fire_effect();
    }
    if (isdefined(self.v[#"fxid"]) && self.v[#"fxid"] != "No FX") {
        self thread cannon_effect();
    }
    if (isdefined(self.v[#"earthquake"])) {
        self thread exploder_earthquake();
    }
}

// Namespace exploder/exploder_shared
// Params 2, eflags: 0x0
// Checksum 0x8eabdded, Offset: 0x1090
// Size: 0xb4
function activate_radiant_exploder(string, immediate) {
    if (is_true(immediate)) {
        for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
            function_87ed546d(localclientnum, string);
        }
        return;
    }
    for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
        playradiantexploder(localclientnum, string);
    }
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xbcec1cd1, Offset: 0x1150
// Size: 0x186
function stop_exploder(exploder_id) {
    if (isstring(exploder_id) || ishash(exploder_id)) {
        for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
            stopradiantexploder(localclientnum, exploder_id);
        }
        return;
    }
    num = int(exploder_id);
    if (isdefined(level.createfxexploders[exploder_id])) {
        for (i = 0; i < level.createfxexploders[exploder_id].size; i++) {
            ent = level.createfxexploders[exploder_id][i];
            if (isdefined(ent.loopfx)) {
                for (j = 0; j < ent.loopfx.size; j++) {
                    if (isdefined(ent.loopfx[j])) {
                        stopfx(j, ent.loopfx[j]);
                        ent.loopfx[j] = undefined;
                    }
                }
                ent.loopfx = [];
            }
        }
    }
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xe29659c3, Offset: 0x12e0
// Size: 0xac
function kill_exploder(exploder_id) {
    if (isstring(exploder_id) || ishash(exploder_id)) {
        for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
            killradiantexploder(localclientnum, exploder_id);
        }
        return;
    }
    assertmsg("<dev string:x38>" + exploder_id);
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0xceb587f4, Offset: 0x1398
// Size: 0x11c
function exploder_delay() {
    if (!isdefined(self.v[#"delay"])) {
        self.v[#"delay"] = 0;
    }
    min_delay = self.v[#"delay"];
    max_delay = self.v[#"delay"] + 0.001;
    if (isdefined(self.v[#"delay_min"])) {
        min_delay = self.v[#"delay_min"];
    }
    if (isdefined(self.v[#"delay_max"])) {
        max_delay = self.v[#"delay_max"];
    }
    if (min_delay > 0) {
        wait randomfloatrange(min_delay, max_delay);
    }
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x2c392237, Offset: 0x14c0
// Size: 0x8c
function exploder_playsound() {
    if (!isdefined(self.v[#"soundalias"]) || self.v[#"soundalias"] == "nil") {
        return;
    }
    sound::play_in_space(0, self.v[#"soundalias"], self.v[#"origin"]);
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0xe82a28b1, Offset: 0x1558
// Size: 0xb4
function exploder_earthquake() {
    self exploder_delay();
    eq = level.earthquake[self.v[#"earthquake"]];
    if (isdefined(eq)) {
        earthquake(0, eq[#"magnitude"], eq[#"duration"], self.v[#"origin"], eq[#"radius"]);
    }
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xe16c2c5, Offset: 0x1618
// Size: 0x66
function exploder_is_lightning_exploder(num) {
    if (isdefined(level.lightningexploder)) {
        for (i = 0; i < level.lightningexploder.size; i++) {
            if (level.lightningexploder[i] == num) {
                return true;
            }
        }
    }
    return false;
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xa7bff071, Offset: 0x1688
// Size: 0x15e
function stoplightloopexploder(exploderindex) {
    num = int(exploderindex);
    if (isdefined(level.createfxexploders[num])) {
        for (i = 0; i < level.createfxexploders[num].size; i++) {
            ent = level.createfxexploders[num][i];
            if (!isdefined(ent.looperfx)) {
                ent.looperfx = [];
            }
            for (clientnum = 0; clientnum < level.max_local_clients; clientnum++) {
                if (localclientactive(clientnum)) {
                    if (isdefined(ent.looperfx[clientnum])) {
                        for (looperfxcount = 0; looperfxcount < ent.looperfx[clientnum].size; looperfxcount++) {
                            deletefx(clientnum, ent.looperfx[clientnum][looperfxcount]);
                        }
                    }
                }
                ent.looperfx[clientnum] = [];
            }
            ent.looperfx = [];
        }
    }
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xce81fffb, Offset: 0x17f0
// Size: 0x13a
function playlightloopexploder(exploderindex) {
    num = int(exploderindex);
    if (isdefined(level.createfxexploders[num])) {
        for (i = 0; i < level.createfxexploders[num].size; i++) {
            ent = level.createfxexploders[num][i];
            if (!isdefined(ent.looperfx)) {
                ent.looperfx = [];
            }
            for (clientnum = 0; clientnum < level.max_local_clients; clientnum++) {
                if (localclientactive(clientnum)) {
                    if (!isdefined(ent.looperfx[clientnum])) {
                        ent.looperfx[clientnum] = [];
                    }
                    ent.looperfx[clientnum][ent.looperfx[clientnum].size] = ent playexploderfx(clientnum);
                }
            }
        }
    }
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xbf981e0f, Offset: 0x1938
// Size: 0x68
function createexploder(fxid) {
    ent = fx::create_effect("exploder", fxid);
    ent.v[#"delay"] = 0;
    ent.v[#"exploder_type"] = "normal";
    return ent;
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x487184b7, Offset: 0x19a8
// Size: 0x30c
function cannon_effect() {
    if (isdefined(self.v[#"repeat"])) {
        for (i = 0; i < self.v[#"repeat"]; i++) {
            players = getlocalplayers();
            for (player = 0; player < players.size; player++) {
                playfx(player, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"]);
            }
            self exploder_delay();
        }
        return;
    }
    self exploder_delay();
    players = getlocalplayers();
    if (isdefined(self.loopfx)) {
        for (i = 0; i < self.loopfx.size; i++) {
            stopfx(i, self.loopfx[i]);
        }
        self.loopfx = [];
    }
    if (!isdefined(self.loopfx)) {
        self.loopfx = [];
    }
    if (!isdefined(level._effect[self.v[#"fxid"]])) {
        assertmsg("<dev string:x79>" + self.v[#"fxid"] + "<dev string:x91>");
        return;
    }
    for (i = 0; i < players.size; i++) {
        if (isdefined(self.v[#"fxid"])) {
            self.loopfx[i] = playfx(i, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"]);
        }
    }
    self exploder_playsound();
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x6351d254, Offset: 0x1cc0
// Size: 0x284
function fire_effect() {
    forward = self.v[#"forward"];
    if (!isdefined(forward)) {
        forward = anglestoforward(self.v[#"angles"]);
    }
    up = self.v[#"up"];
    if (!isdefined(up)) {
        up = anglestoup(self.v[#"angles"]);
    }
    firefxsound = self.v[#"firefxsound"];
    origin = self.v[#"origin"];
    firefx = self.v[#"firefx"];
    ender = self.v[#"ender"];
    if (!isdefined(ender)) {
        ender = "createfx_effectStopper";
    }
    firefxdelay = 0.5;
    if (isdefined(self.v[#"firefxdelay"])) {
        firefxdelay = self.v[#"firefxdelay"];
    }
    self exploder_delay();
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(firefxsound)) {
            level thread sound::loop_fx_sound(i, firefxsound, origin, ender);
        }
        playfx(i, level._effect[firefx], self.v[#"origin"], forward, up, 0, self.v[#"primlightfrac"], self.v[#"lightoriginoffs"]);
    }
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0x68d56c19, Offset: 0x1f50
// Size: 0x11a
function playexploderfx(clientnum) {
    /#
        if (!isdefined(self.v[#"origin"])) {
            return;
        }
        if (!isdefined(self.v[#"forward"])) {
            return;
        }
        if (!isdefined(self.v[#"up"])) {
            return;
        }
    #/
    return playfx(clientnum, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"], 0, self.v[#"primlightfrac"], self.v[#"lightoriginoffs"]);
}

// Namespace exploder/exploder_shared
// Params 2, eflags: 0x0
// Checksum 0xa217ee1e, Offset: 0x2078
// Size: 0x2c
function stop_after_duration(name, duration) {
    wait duration;
    stop_exploder(name);
}

// Namespace exploder/exploder_shared
// Params 2, eflags: 0x0
// Checksum 0xd3f816a7, Offset: 0x20b0
// Size: 0x64
function exploder_duration(name, duration) {
    if (!is_true(duration)) {
        return;
    }
    exploder(name);
    level thread stop_after_duration(name, duration);
}

