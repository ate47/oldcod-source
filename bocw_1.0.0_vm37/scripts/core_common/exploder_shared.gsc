#using scripts\core_common\fx_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;

#namespace exploder;

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x6
// Checksum 0x354c348c, Offset: 0x180
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"exploder", &preinit, &postinit, undefined, undefined);
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x4
// Checksum 0x32bdae87, Offset: 0x1d8
// Size: 0x1c
function private preinit() {
    level._client_exploders = [];
    level._client_exploder_ids = [];
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x4
// Checksum 0x97e5da81, Offset: 0x200
// Size: 0xd38
function private postinit() {
    level.exploders = [];
    ents = getentarray("script_brushmodel", "classname");
    smodels = getentarray("script_model", "classname");
    for (i = 0; i < smodels.size; i++) {
        ents[ents.size] = smodels[i];
    }
    for (i = 0; i < ents.size; i++) {
        if (isdefined(ents[i].script_prefab_exploder)) {
            ents[i].script_exploder = ents[i].script_prefab_exploder;
        }
        if (isdefined(ents[i].script_exploder)) {
            if (ents[i].script_exploder < 10000) {
                level.exploders[ents[i].script_exploder] = 1;
            }
            if (ents[i].model == "fx" && (!isdefined(ents[i].targetname) || ents[i].targetname != "exploderchunk")) {
                ents[i] hide();
                continue;
            }
            if (isdefined(ents[i].targetname) && ents[i].targetname == "exploder") {
                ents[i] hide();
                ents[i] notsolid();
                if (isdefined(ents[i].script_disconnectpaths)) {
                    ents[i] connectpaths();
                }
                continue;
            }
            if (isdefined(ents[i].targetname) && ents[i].targetname == "exploderchunk") {
                ents[i] hide();
                ents[i] notsolid();
                if (isdefined(ents[i].spawnflags) && (ents[i].spawnflags & 1) == 1) {
                    ents[i] connectpaths();
                }
            }
        }
    }
    script_exploders = [];
    potentialexploders = getentarray("script_brushmodel", "classname");
    for (i = 0; i < potentialexploders.size; i++) {
        if (isdefined(potentialexploders[i].script_prefab_exploder)) {
            potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
        }
        if (isdefined(potentialexploders[i].script_exploder)) {
            script_exploders[script_exploders.size] = potentialexploders[i];
        }
    }
    println("<dev string:x38>" + potentialexploders.size);
    potentialexploders = getentarray("script_model", "classname");
    for (i = 0; i < potentialexploders.size; i++) {
        if (isdefined(potentialexploders[i].script_prefab_exploder)) {
            potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
        }
        if (isdefined(potentialexploders[i].script_exploder)) {
            script_exploders[script_exploders.size] = potentialexploders[i];
        }
    }
    println("<dev string:x6a>" + potentialexploders.size);
    potentialexploders = getentarray("item_health", "classname");
    for (i = 0; i < potentialexploders.size; i++) {
        if (isdefined(potentialexploders[i].script_prefab_exploder)) {
            potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
        }
        if (isdefined(potentialexploders[i].script_exploder)) {
            script_exploders[script_exploders.size] = potentialexploders[i];
        }
    }
    println("<dev string:x9d>" + potentialexploders.size);
    if (!isdefined(level.createfxent)) {
        level.createfxent = [];
    }
    acceptabletargetnames = [];
    acceptabletargetnames[#"exploderchunk visible"] = 1;
    acceptabletargetnames[#"exploderchunk"] = 1;
    acceptabletargetnames[#"exploder"] = 1;
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
        ent.v[#"earthquake"] = exploder.script_earthquake;
        ent.v[#"damage"] = exploder.script_damage;
        ent.v[#"damage_radius"] = exploder.script_radius;
        ent.v[#"soundalias"] = exploder.script_soundalias;
        ent.v[#"repeat"] = exploder.script_repeat;
        ent.v[#"delay_min"] = exploder.script_delay_min;
        ent.v[#"delay_max"] = exploder.script_delay_max;
        ent.v[#"target"] = exploder.target;
        ent.v[#"ender"] = exploder.script_ender;
        ent.v[#"type"] = "exploder";
        if (!isdefined(exploder.script_fxid)) {
            ent.v[#"fxid"] = "No FX";
        } else {
            ent.v[#"fxid"] = exploder.script_fxid;
        }
        ent.v[#"exploder"] = exploder.script_exploder;
        assert(isdefined(exploder.script_exploder), "<dev string:xcf>" + exploder.origin + "<dev string:xe6>");
        if (!isdefined(ent.v[#"delay"])) {
            ent.v[#"delay"] = 0;
        }
        if (isdefined(exploder.target)) {
            e_target = getent(ent.v[#"target"], "targetname");
            if (!isdefined(e_target)) {
                e_target = struct::get(ent.v[#"target"], "targetname");
            }
            org = e_target.origin;
            ent.v[#"angles"] = vectortoangles(org - ent.v[#"origin"]);
        }
        if (exploder.classname == "script_brushmodel" || isdefined(exploder.model)) {
            ent.model = exploder;
            ent.model.disconnect_paths = exploder.script_disconnectpaths;
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
    level.radiantexploders = [];
    reportexploderids();
    foreach (trig in trigger::get_all()) {
        if (isdefined(trig.script_prefab_exploder)) {
            trig.script_exploder = trig.script_prefab_exploder;
        }
        if (isdefined(trig.script_exploder)) {
            level thread exploder_trigger(trig, trig.script_exploder);
        }
        if (isdefined(trig.script_exploder_radiant)) {
            level thread exploder_trigger(trig, trig.script_exploder_radiant);
        }
        if (isdefined(trig.script_stop_exploder)) {
            level trigger::add_function(trig, undefined, &stop_exploder, trig.script_stop_exploder);
        }
        if (isdefined(trig.script_stop_exploder_radiant)) {
            level trigger::add_function(trig, undefined, &stop_exploder, trig.script_stop_exploder_radiant);
        }
    }
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xcc59ba77, Offset: 0xf40
// Size: 0x24
function exploder_before_load(num) {
    waittillframeend();
    waittillframeend();
    exploder(num);
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xf1e251b0, Offset: 0xf70
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
// Checksum 0xc0c572ac, Offset: 0xfd0
// Size: 0x64
function function_993369d6(exploder_string) {
    if (isstring(exploder_string)) {
        activate_radiant_exploder(exploder_string, 1);
        return;
    }
    assertmsg("<dev string:x101>");
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0x2456e75c, Offset: 0x1040
// Size: 0x24
function exploder_stop(num) {
    stop_exploder(num);
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x387af3d7, Offset: 0x1070
// Size: 0x3c
function exploder_sound() {
    if (isdefined(self.script_delay)) {
        wait self.script_delay;
    }
    self playsound(level.scr_sound[self.script_sound]);
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x69cf98ba, Offset: 0x10b8
// Size: 0x1e4
function cannon_effect() {
    if (isdefined(self.v[#"repeat"])) {
        for (i = 0; i < self.v[#"repeat"]; i++) {
            playfx(level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"]);
            self exploder_delay();
        }
        return;
    }
    self exploder_delay();
    if (isdefined(self.looper)) {
        self.looper delete();
    }
    self.looper = spawnfx(fx::get(self.v[#"fxid"]), self.v[#"origin"], self.v[#"forward"], self.v[#"up"]);
    triggerfx(self.looper);
    exploder_playsound();
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x3b58ffae, Offset: 0x12a8
// Size: 0x1a4
function fire_effect() {
    forward = self.v[#"forward"];
    up = self.v[#"up"];
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
    if (isdefined(firefxsound)) {
        level thread sound::loop_fx_sound(firefxsound, origin, ender);
    }
    playfx(level._effect[firefx], self.v[#"origin"], forward, up);
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x815ffc3, Offset: 0x1458
// Size: 0x1c
function sound_effect() {
    self effect_soundalias();
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x25dbde23, Offset: 0x1480
// Size: 0x74
function effect_soundalias() {
    origin = self.v[#"origin"];
    alias = self.v[#"soundalias"];
    self exploder_delay();
    sound::play_in_space(alias, origin);
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x69e578fc, Offset: 0x1500
// Size: 0x304
function trail_effect() {
    self exploder_delay();
    if (!isdefined(self.v[#"trailfxtag"])) {
        self.v[#"trailfxtag"] = "tag_origin";
    }
    temp_ent = undefined;
    if (self.v[#"trailfxtag"] == "tag_origin") {
        playfxontag(level._effect[self.v[#"trailfx"]], self.model, self.v[#"trailfxtag"]);
    } else {
        temp_ent = spawn("script_model", self.model.origin);
        temp_ent.targetname = "exploder_fx";
        temp_ent setmodel(#"tag_origin");
        temp_ent linkto(self.model, self.v[#"trailfxtag"]);
        playfxontag(level._effect[self.v[#"trailfx"]], temp_ent, "tag_origin");
    }
    if (isdefined(self.v[#"trailfxsound"])) {
        if (!isdefined(temp_ent)) {
            self.model playloopsound(self.v[#"trailfxsound"]);
        } else {
            temp_ent playloopsound(self.v[#"trailfxsound"]);
        }
    }
    if (isdefined(self.v[#"ender"]) && isdefined(temp_ent)) {
        level thread trail_effect_ender(temp_ent, self.v[#"ender"]);
    }
    if (!isdefined(self.v[#"trailfxtimeout"])) {
        return;
    }
    wait self.v[#"trailfxtimeout"];
    if (isdefined(temp_ent)) {
        temp_ent delete();
    }
}

// Namespace exploder/exploder_shared
// Params 2, eflags: 0x0
// Checksum 0xace55f51, Offset: 0x1810
// Size: 0x4c
function trail_effect_ender(ent, ender) {
    ent endon(#"death");
    self waittill(ender);
    ent delete();
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0xc9e9ed39, Offset: 0x1868
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
// Checksum 0xc750ec8d, Offset: 0x1990
// Size: 0x8c
function exploder_playsound() {
    if (!isdefined(self.v[#"soundalias"]) || self.v[#"soundalias"] == "nil") {
        return;
    }
    sound::play_in_space(self.v[#"soundalias"], self.v[#"origin"]);
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x268d84a7, Offset: 0x1a28
// Size: 0x114
function brush_delete() {
    num = self.v[#"exploder"];
    if (isdefined(self.v[#"delay"])) {
        wait self.v[#"delay"];
    } else {
        wait 0.05;
    }
    if (!isdefined(self.model)) {
        return;
    }
    assert(isdefined(self.model));
    if (!isdefined(self.v[#"fxid"]) || self.v[#"fxid"] == "No FX") {
        self.v[#"exploder"] = undefined;
    }
    waittillframeend();
    self.model delete();
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x9a2b5105, Offset: 0x1b48
// Size: 0x8c
function brush_show() {
    if (isdefined(self.v[#"delay"])) {
        wait self.v[#"delay"];
    }
    assert(isdefined(self.model));
    self.model show();
    self.model solid();
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x2cadd327, Offset: 0x1be0
// Size: 0x21c
function brush_throw() {
    if (isdefined(self.v[#"delay"])) {
        wait self.v[#"delay"];
    }
    ent = undefined;
    if (isdefined(self.v[#"target"])) {
        ent = getent(self.v[#"target"], "targetname");
    }
    if (!isdefined(ent)) {
        self.model delete();
        return;
    }
    self.model show();
    startorg = self.v[#"origin"];
    startang = self.v[#"angles"];
    org = ent.origin;
    temp_vec = org - self.v[#"origin"];
    x = temp_vec[0];
    y = temp_vec[1];
    z = temp_vec[2];
    self.model rotatevelocity((x, y, z), 12);
    self.model movegravity((x, y, z), 12);
    self.v[#"exploder"] = undefined;
    wait 6;
    self.model delete();
}

// Namespace exploder/exploder_shared
// Params 2, eflags: 0x0
// Checksum 0x9bcbd053, Offset: 0x1e08
// Size: 0xfa
function exploder_trigger(trigger, script_value) {
    trigger endon(#"death");
    level endon("killexplodertridgers" + script_value);
    trigger trigger::wait_till();
    if (isdefined(trigger.script_chance) && randomfloat(1) > trigger.script_chance) {
        if (isdefined(trigger.script_delay)) {
            wait trigger.script_delay;
        } else {
            wait 4;
        }
        level thread exploder_trigger(trigger, script_value);
        return;
    }
    exploder(script_value);
    level notify("killexplodertridgers" + script_value);
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x70269b4e, Offset: 0x1f10
// Size: 0xc8
function reportexploderids() {
    /#
        if (!isdefined(level._exploder_ids)) {
            return;
        }
        println("<dev string:x140>");
        foreach (k, v in level._exploder_ids) {
            println(k + "<dev string:x161>" + v);
        }
    #/
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0x444c95c4, Offset: 0x1fe0
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
// Params 1, eflags: 0x0
// Checksum 0x757eff83, Offset: 0x20a0
// Size: 0x80
function createexploder(fxid) {
    ent = fx::create_effect("exploder", fxid);
    ent.v[#"delay"] = 0;
    ent.v[#"exploder"] = 1;
    ent.v[#"exploder_type"] = "normal";
    return ent;
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0x60760415, Offset: 0x2128
// Size: 0x11c
function activate_exploder(num) {
    num = int(num);
    level notify("exploder" + num);
    client_send = 1;
    if (isdefined(level.createfxexploders[num])) {
        for (i = 0; i < level.createfxexploders[num].size; i++) {
            if (client_send && isdefined(level.createfxexploders[num][i].v[#"exploder_server"])) {
                client_send = 0;
            }
            level.createfxexploders[num][i] activate_individual_exploder(num);
        }
    }
    if (level.clientscripts) {
        if (client_send == 1) {
            activate_exploder_on_clients(num);
        }
    }
}

// Namespace exploder/exploder_shared
// Params 2, eflags: 0x0
// Checksum 0x9c720325, Offset: 0x2250
// Size: 0x6c
function activate_radiant_exploder(string, immediate) {
    level notify("exploder" + string);
    if (is_true(immediate)) {
        function_2f822355(string);
        return;
    }
    activateclientradiantexploder(string);
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0x6c6b7947, Offset: 0x22c8
// Size: 0x304
function activate_individual_exploder(*num) {
    level notify("exploder" + self.v[#"exploder"]);
    if (!level.clientscripts || !isdefined(level._exploder_ids[int(self.v[#"exploder"])]) || isdefined(self.v[#"exploder_server"])) {
        println("<dev string:x168>" + self.v[#"exploder"] + "<dev string:x175>");
        if (isdefined(self.v[#"firefx"])) {
            self thread fire_effect();
        }
        if (isdefined(self.v[#"fxid"]) && self.v[#"fxid"] != "No FX") {
            self thread cannon_effect();
        } else if (isdefined(self.v[#"soundalias"])) {
            self thread sound_effect();
        }
        if (isdefined(self.v[#"earthquake"])) {
            self thread earthquake();
        }
        if (isdefined(self.v[#"rumble"])) {
            self thread rumble();
        }
    }
    if (isdefined(self.v[#"trailfx"])) {
        self thread trail_effect();
    }
    if (isdefined(self.v[#"damage"])) {
        self thread exploder_damage();
    }
    if (self.v[#"exploder_type"] == "exploder") {
        self thread brush_show();
        return;
    }
    if (self.v[#"exploder_type"] == "exploderchunk" || self.v[#"exploder_type"] == "exploderchunk visible") {
        self thread brush_throw();
        return;
    }
    self thread brush_delete();
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xc3bb5646, Offset: 0x25d8
// Size: 0x94
function activate_exploder_on_clients(num) {
    if (!isdefined(level._exploder_ids[num])) {
        return;
    }
    if (!isdefined(level._client_exploders[num])) {
        level._client_exploders[num] = 1;
    }
    if (!isdefined(level._client_exploder_ids[num])) {
        level._client_exploder_ids[num] = 1;
    }
    activateclientexploder(level._exploder_ids[num]);
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0x6de473c6, Offset: 0x2678
// Size: 0xbc
function stop_exploder(num) {
    if (level.clientscripts) {
        delete_exploder_on_clients(num);
    }
    if (isdefined(level.createfxexploders[num])) {
        for (i = 0; i < level.createfxexploders[num].size; i++) {
            if (!isdefined(level.createfxexploders[num][i].looper)) {
                continue;
            }
            level.createfxexploders[num][i].looper delete();
        }
    }
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xe4158904, Offset: 0x2740
// Size: 0xac
function delete_exploder_on_clients(exploder_id) {
    if (isstring(exploder_id)) {
        deactivateclientradiantexploder(exploder_id);
        return;
    }
    if (!isdefined(level._exploder_ids[exploder_id])) {
        return;
    }
    if (!isdefined(level._client_exploders[exploder_id])) {
        return;
    }
    level._client_exploders[exploder_id] = undefined;
    level._client_exploder_ids[exploder_id] = undefined;
    deactivateclientexploder(level._exploder_ids[exploder_id]);
}

// Namespace exploder/exploder_shared
// Params 1, eflags: 0x0
// Checksum 0xd65012b2, Offset: 0x27f8
// Size: 0x5c
function kill_exploder(exploder_string) {
    if (isstring(exploder_string)) {
        killclientradiantexploder(exploder_string);
        return;
    }
    assertmsg("<dev string:x101>");
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0x67e8d716, Offset: 0x2860
// Size: 0x114
function exploder_damage() {
    if (isdefined(self.v[#"delay"])) {
        delay = self.v[#"delay"];
    } else {
        delay = 0;
    }
    if (isdefined(self.v[#"damage_radius"])) {
        radius = self.v[#"damage_radius"];
    } else {
        radius = 128;
    }
    damage = self.v[#"damage"];
    origin = self.v[#"origin"];
    wait delay;
    self.model radiusdamage(origin, radius, damage, damage / 3);
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0xbde6569d, Offset: 0x2980
// Size: 0x10c
function earthquake() {
    earthquake_name = self.v[#"earthquake"];
    assert(isdefined(level.earthquake) && isdefined(level.earthquake[earthquake_name]), "<dev string:x18c>" + earthquake_name + "<dev string:x19f>");
    self exploder_delay();
    eq = level.earthquake[earthquake_name];
    earthquake(eq[#"magnitude"], eq[#"duration"], self.v[#"origin"], eq[#"radius"]);
}

// Namespace exploder/exploder_shared
// Params 0, eflags: 0x0
// Checksum 0xf1160623, Offset: 0x2a98
// Size: 0x17c
function rumble() {
    self exploder_delay();
    a_players = getplayers();
    if (isdefined(self.v[#"damage_radius"])) {
        n_rumble_threshold_squared = self.v[#"damage_radius"] * self.v[#"damage_radius"];
    } else {
        println("<dev string:x1e7>" + self.v[#"exploder"] + "<dev string:x1f5>");
        n_rumble_threshold_squared = 16384;
    }
    for (i = 0; i < a_players.size; i++) {
        n_player_dist_squared = distancesquared(a_players[i].origin, self.v[#"origin"]);
        if (n_player_dist_squared < n_rumble_threshold_squared) {
            a_players[i] playrumbleonentity(self.v[#"rumble"]);
        }
    }
}

// Namespace exploder/exploder_shared
// Params 2, eflags: 0x0
// Checksum 0xf824b3e9, Offset: 0x2c20
// Size: 0x2c
function stop_after_duration(name, duration) {
    wait duration;
    stop_exploder(name);
}

// Namespace exploder/exploder_shared
// Params 2, eflags: 0x0
// Checksum 0xa6a14857, Offset: 0x2c58
// Size: 0x64
function exploder_duration(name, duration) {
    if (!is_true(duration)) {
        return;
    }
    exploder(name);
    level thread stop_after_duration(name, duration);
}

