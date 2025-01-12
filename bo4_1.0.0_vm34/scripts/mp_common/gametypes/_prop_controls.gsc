#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\mp\killstreaks;
#using scripts\mp_common\gametypes\_prop_dev;
#using scripts\mp_common\gametypes\dogtags;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\prop;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\gametypes\spawnlogic;
#using scripts\mp_common\util;

#namespace prop_controls;

// Namespace prop_controls/_prop_controls
// Params 2, eflags: 0x0
// Checksum 0x6d1bbde7, Offset: 0x3a0
// Size: 0x54
function notifyonplayercommand(command, key) {
    assert(isplayer(self));
    self thread function_e17a8f06(command, key);
}

// Namespace prop_controls/_prop_controls
// Params 2, eflags: 0x0
// Checksum 0x9d5504, Offset: 0x400
// Size: 0x2a
function notifyonplayercommandremove(command, key) {
    self notify(command + "_" + key);
}

// Namespace prop_controls/_prop_controls
// Params 2, eflags: 0x0
// Checksum 0x9af187fd, Offset: 0x438
// Size: 0x43a
function function_e17a8f06(command, key) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(command + "_" + key);
    self endon(command + "_" + key);
    switch (key) {
    case #"+attack":
        function_c6639fc9(&attackbuttonpressed, command);
        break;
    case #"+toggleads_throw":
        function_c6639fc9(&adsbuttonpressed, command);
        break;
    case #"weapnext":
        function_c6639fc9(&weaponswitchbuttonpressed, command);
        break;
    case #"+usereload":
        function_c6639fc9(&usebuttonpressed, command);
        break;
    case #"+smoke":
        function_c6639fc9(&secondaryoffhandbuttonpressed, command);
        break;
    case #"+frag":
        function_c6639fc9(&fragbuttonpressed, command);
        break;
    case #"+actionslot 1":
        function_c6639fc9(&actionslotonebuttonpressed, command);
        break;
    case #"+actionslot 2":
        function_c6639fc9(&actionslottwobuttonpressed, command);
        break;
    case #"+actionslot 3":
        function_c6639fc9(&actionslotthreebuttonpressed, command);
        break;
    case #"+actionslot 4":
        function_c6639fc9(&actionslotfourbuttonpressed, command);
        break;
    case #"-actionslot 1":
        function_b01c4bcb(&actionslotonebuttonpressed, command);
        break;
    case #"-actionslot 2":
        function_b01c4bcb(&actionslottwobuttonpressed, command);
        break;
    case #"-actionslot 3":
        function_b01c4bcb(&actionslotthreebuttonpressed, command);
        break;
    case #"-actionslot 4":
        function_b01c4bcb(&actionslotfourbuttonpressed, command);
        break;
    case #"+stance":
        function_b01c4bcb(&stancebuttonpressed, command);
        break;
    case #"+breath_sprint":
        function_b01c4bcb(&sprintbuttonpressed, command);
        break;
    case #"+melee":
        function_b01c4bcb(&meleebuttonpressed, command);
        break;
    }
}

// Namespace prop_controls/_prop_controls
// Params 2, eflags: 0x0
// Checksum 0xc0642ffb, Offset: 0x880
// Size: 0x5c
function function_c6639fc9(buttonfunc, command) {
    while (true) {
        while (!self [[ buttonfunc ]]()) {
            waitframe(1);
        }
        self notify(command);
        while (self [[ buttonfunc ]]()) {
            waitframe(1);
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 2, eflags: 0x0
// Checksum 0x8308268c, Offset: 0x8e8
// Size: 0x5c
function function_b01c4bcb(buttonfunc, command) {
    while (true) {
        while (!self [[ buttonfunc ]]()) {
            waitframe(1);
        }
        while (self [[ buttonfunc ]]()) {
            waitframe(1);
        }
        self notify(command);
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xb7e01b73, Offset: 0x950
// Size: 0x184
function setupkeybindings() {
    if (isai(self)) {
        return;
    }
    self notifyonplayercommand("lock", "+attack");
    self notifyonplayercommand("spin", "+toggleads_throw");
    self notifyonplayercommand("changeProp", "weapnext");
    self notifyonplayercommand("setToSlope", "+usereload");
    self notifyonplayercommand("propAbility", "+smoke");
    self notifyonplayercommand("cloneProp", "+actionslot 2");
    self notifyonplayercommand("zoomin", "+actionslot 3");
    self notifyonplayercommand("zoomout", "+actionslot 4");
    self notifyonplayercommand("hide", "+melee");
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x47df026b, Offset: 0xae0
// Size: 0x184
function function_3122ae57() {
    if (isai(self)) {
        return;
    }
    self notifyonplayercommandremove("lock", "+attack");
    self notifyonplayercommandremove("spin", "+toggleads_throw");
    self notifyonplayercommandremove("changeProp", "+weapnext");
    self notifyonplayercommandremove("setToSlope", "+usereload");
    self notifyonplayercommandremove("propAbility", "+smoke");
    self notifyonplayercommandremove("cloneProp", "+actionslot 2");
    self notifyonplayercommandremove("zoomin", "+actionslot 3");
    self notifyonplayercommandremove("zoomout", "+actionslot 4");
    self notifyonplayercommandremove("hide", "+melee");
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x1a80cb95, Offset: 0xc70
// Size: 0x1a
function is_player_gamepad_enabled() {
    return self gamepadusedlast();
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0x220ed6c2, Offset: 0xc98
// Size: 0x1a
function setvalue(value) {
    self.value = value;
}

// Namespace prop_controls/_prop_controls
// Params 4, eflags: 0x0
// Checksum 0xb801963e, Offset: 0xcc0
// Size: 0x1de
function addupperrighthudelem(label, value, text, labelpc) {
    hudelem = spawnstruct();
    hudelem.x = -15;
    hudelem.y = self.currenthudy;
    hudelem.alignx = "right";
    hudelem.aligny = "bottom";
    hudelem.horzalign = "right";
    hudelem.vertalign = "bottom";
    hudelem.archived = 1;
    hudelem.alpha = 1;
    hudelem.glowalpha = 0;
    hudelem.hidewheninmenu = 1;
    hudelem.hidewheninkillcam = 1;
    hudelem.startfontscale = hudelem.fontscale;
    if (isdefined(label) && isdefined(labelpc)) {
        if (self is_player_gamepad_enabled()) {
            hudelem.label = label;
        } else {
            hudelem.label = labelpc;
        }
    } else if (isdefined(label)) {
        hudelem.label = label;
    } else if (isdefined(text)) {
        /#
            hudelem settext(text);
        #/
    }
    if (isdefined(value)) {
        hudelem setvalue(value);
    }
    self.currenthudy -= 20;
    return hudelem;
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x9617a424, Offset: 0xea8
// Size: 0x1e4
function propcontrolshud() {
    assert(!isdefined(self.changepropkey));
    if (self issplitscreen()) {
        self.currenthudy = -10;
    } else {
        self.currenthudy = -80;
    }
    self.abilitykey = addupperrighthudelem();
    self.clonekey = addupperrighthudelem(#"hash_2f560292a2fb7eab");
    self.changepropkey = addupperrighthudelem(#"mp_ph_change", 0);
    self.currenthudy -= 20;
    self.var_6f16621b = addupperrighthudelem(#"hash_fb73fdc2aff963f");
    self.matchslopekey = addupperrighthudelem(#"hash_7f59350f5f223501", undefined, undefined, #"hash_4c7fbb5c1ccd5107");
    self.lockpropkey = addupperrighthudelem(#"mp_ph_lock");
    self.spinpropkey = addupperrighthudelem(#"mp_ph_spin", undefined, undefined, #"hash_39e61050ab8d325e");
    self setnewabilityhud();
    self.zoomkey = addupperrighthudelem(#"mp_ph_zoom");
    self thread updatetextongamepadchange();
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xda2edaf7, Offset: 0x1098
// Size: 0x6c
function cleanuppropcontrolshudondeath() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self waittill(#"death");
    self thread function_3122ae57();
    self thread cleanuppropcontrolshud();
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0x8d48ffb, Offset: 0x1110
// Size: 0x2c
function safedestroy(hudelem) {
    if (isdefined(hudelem)) {
        /#
            hudelem destroy();
        #/
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1148
// Size: 0x4
function cleanuppropcontrolshud() {
    
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xe3607de1, Offset: 0x1158
// Size: 0x1ac
function updatetextongamepadchange() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    if (level.console) {
        return;
    }
    waittillframeend();
    var_85e0f0fe = self is_player_gamepad_enabled();
    while (true) {
        var_521408c = self is_player_gamepad_enabled();
        if (var_521408c != var_85e0f0fe) {
            var_85e0f0fe = var_521408c;
            if (var_521408c) {
                if (!(isdefined(self.slopelocked) && self.slopelocked)) {
                    self.matchslopekey.label = #"hash_7f59350f5f223501";
                } else {
                    self.matchslopekey.label = #"hash_6ca8e1ea720ba9f";
                }
                self.spinpropkey.label = #"mp_ph_spin";
            } else {
                if (!(isdefined(self.slopelocked) && self.slopelocked)) {
                    self.matchslopekey.label = #"hash_4c7fbb5c1ccd5107";
                } else {
                    self.matchslopekey.label = #"hash_3cd8ecbf9f39b3e9";
                }
                self.spinpropkey.label = #"hash_39e61050ab8d325e";
            }
        }
        waitframe(1);
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x81d4516f, Offset: 0x1310
// Size: 0x280
function propinputwatch() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    if (isai(self)) {
        return;
    }
    self.lock = 0;
    self.slopelocked = 0;
    prop::function_45c842e9();
    self thread propmoveunlock();
    self thread propcamerazoom();
    self.debugnextpropindex = 1;
    while (true) {
        waitresult = self waittill(#"lock", #"spin", #"changeprop", #"settoslope", #"propability", #"cloneprop", #"hide");
        msg = waitresult._notify;
        if (!isdefined(msg)) {
            continue;
        }
        waittillframeend();
        if (msg == "lock") {
            self proplockunlock();
            continue;
        }
        if (msg == "spin") {
            self propspin();
            continue;
        }
        if (msg == "changeProp") {
            self propchange();
            continue;
        }
        if (msg == "setToSlope") {
            self propmatchslope();
            continue;
        }
        if (msg == "propAbility") {
            self propability();
            continue;
        }
        if (msg == "cloneProp") {
            self propclonepower();
            continue;
        }
        if (msg == "hide") {
            self function_8b7be7e3();
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x72da10d3, Offset: 0x1598
// Size: 0x54
function proplockunlock() {
    if (self ismantling()) {
        return;
    }
    if (self.lock) {
        self unlockprop();
        return;
    }
    self lockprop();
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x10f5242c, Offset: 0x15f8
// Size: 0xd4
function propspin() {
    self.propent unlink();
    self.propent.angles += (0, 45, 0);
    self.propent.origin = self.propanchor.origin;
    if (self.slopelocked && isdefined(self.lock) && self.lock) {
        self.propent set_pitch_roll_for_ground_normal(self.prop);
    }
    self.propent linkto(self.propanchor);
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0x3a385e22, Offset: 0x16d8
// Size: 0x9a
function registerpreviousprop(inplayer) {
    var_771596a5 = 3;
    if (!isdefined(inplayer.usedpropsindex)) {
        inplayer.usedpropsindex = 0;
    }
    inplayer.usedprops[inplayer.usedpropsindex] = inplayer.prop.info;
    inplayer.usedpropsindex++;
    if (inplayer.usedpropsindex >= var_771596a5) {
        inplayer.usedpropsindex = 0;
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xfe51bab4, Offset: 0x1780
// Size: 0x2b4
function propchange() {
    if (!self prophaschangesleft()) {
        return;
    }
    if (!level.console) {
        var_6f5743e8 = 300;
        if (isdefined(self.lastpropchangetime) && gettime() - self.lastpropchangetime < var_6f5743e8) {
            return;
        }
        self.lastpropchangetime = gettime();
    }
    self notify(#"changed_prop");
    registerpreviousprop(self);
    self.prop.info = prop::getnextprop(self);
    /#
        if (getdvarint(#"hash_1463efb6c1a55cd3", 0) != 0) {
            self.prop.info = level.proplist[self.debugnextpropindex];
            self.debugnextpropindex++;
            if (self.debugnextpropindex >= level.proplist.size) {
                self.debugnextpropindex = 0;
            }
        }
    #/
    self propchangeto(self.prop.info);
    if (level.phsettings.var_e332c699) {
        playfxontag("player/fx_plyr_clone_reaper_appear", self.prop, "tag_origin");
    }
    self.maxhealth = int(prop::getprophealth(self.prop.info));
    self setnormalhealth(1);
    self setnewabilitycount(self.currentability);
    self setnewabilitycount("CLONE");
    if (prop::useprophudserver()) {
        self.abilitykey.alpha = 1;
        self.clonekey.alpha = 1;
    }
    /#
        if (getdvarint(#"hash_1463efb6c1a55cd3", 0) != 0) {
            return;
        }
    #/
    self propdeductchange();
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xfd289bed, Offset: 0x1a40
// Size: 0x32
function prophaschangesleft() {
    /#
        if (isdefined(self.var_c4494f8d) && self.var_c4494f8d) {
            return true;
        }
    #/
    return self.changesleft > 0;
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x929e93f9, Offset: 0x1a80
// Size: 0x44
function propdeductchange() {
    /#
        if (isdefined(self.var_c4494f8d) && self.var_c4494f8d) {
            return;
        }
    #/
    propsetchangesleft(self.changesleft - 1);
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0xbd6c4880, Offset: 0x1ad0
// Size: 0x72
function propsetchangesleft(newvalue) {
    self.changesleft = newvalue;
    if (prop::useprophudserver()) {
        self.changepropkey setvalue(self.changesleft);
        if (self.changesleft <= 0) {
            self.changepropkey.alpha = 0.5;
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0xba0ee948, Offset: 0x1b50
// Size: 0x34c
function propchangeto(info) {
    self.prop.info = info;
    self.propinfo = info;
    if (level.phsettings.var_e332c699) {
        var_5e63b8b5 = self.propent.angles;
        var_345eaa38 = self.prop.angles;
        var_9b6a4a66 = self.angles;
    }
    self.prop setmodel(info.modelname);
    self.prop.xyzoffset = info.xyzoffset;
    self.prop.anglesoffset = info.anglesoffset;
    self.prop setscale(info.propscale);
    self.prop unlink();
    self.propent unlink();
    self.propent.origin = self.propanchor.origin;
    self.prop.origin = self.propent.origin;
    self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
    self.prop.angles = self.propent.angles;
    if (isdefined(self.isangleoffset) && self.isangleoffset) {
        self.prop.angles = self.angles;
        self.isangleoffset = 0;
    }
    self prop::applyxyzoffset();
    self prop::applyanglesoffset();
    if (level.phsettings.var_e332c699) {
        self.propent.angles = var_5e63b8b5;
        self.prop.angles = var_345eaa38;
        self.angles = var_9b6a4a66;
    }
    self.prop linkto(self.propent);
    if (self.slopelocked && isdefined(self.lock) && self.lock) {
        self.propent set_pitch_roll_for_ground_normal(self.prop);
    }
    self.propent linkto(self.propanchor);
    self.thirdpersonrange = info.proprange;
    self.thirdpersonheightoffset = info.propheight;
    self setclientthirdperson(1);
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x8920f09a, Offset: 0x1ea8
// Size: 0x22a
function propmatchslope() {
    if (!(isdefined(self.slopelocked) && self.slopelocked)) {
        self.slopelocked = 1;
        if (isdefined(self.lock) && self.lock) {
            self.propent unlink();
            self.propent set_pitch_roll_for_ground_normal(self.prop);
            self.propent linkto(self.propanchor);
        }
        if (prop::useprophudserver()) {
            if (self is_player_gamepad_enabled()) {
                self.matchslopekey.label = #"hash_6ca8e1ea720ba9f";
            } else {
                self.matchslopekey.label = #"hash_3cd8ecbf9f39b3e9";
            }
        }
        return;
    }
    self.slopelocked = 0;
    if (isdefined(self.lock) && self.lock) {
        self.propent unlink();
        self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
        self.propent.origin = self.propanchor.origin;
        self.propent linkto(self.propanchor);
    }
    if (prop::useprophudserver()) {
        if (self is_player_gamepad_enabled()) {
            self.matchslopekey.label = #"hash_7f59350f5f223501";
            return;
        }
        self.matchslopekey.label = #"hash_4c7fbb5c1ccd5107";
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xf4446e25, Offset: 0x20e0
// Size: 0x6c
function propability() {
    if (!level flag::get("props_hide_over")) {
        return;
    }
    if (self prophasflashesleft()) {
        self thread flashenemies();
        self propdeductflash();
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x5d35d63c, Offset: 0x2158
// Size: 0x44
function propclonepower() {
    if (prophasclonesleft()) {
        self thread cloneprop();
        self thread propdeductclonechange();
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xcbf5d6cc, Offset: 0x21a8
// Size: 0x32
function prophasclonesleft() {
    /#
        if (isdefined(self.var_b53602f4) && self.var_b53602f4) {
            return true;
        }
    #/
    return self.clonesleft > 0;
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x41f63395, Offset: 0x21e8
// Size: 0x44
function propdeductclonechange() {
    /#
        if (isdefined(self.var_b53602f4) && self.var_b53602f4) {
            return;
        }
    #/
    propsetclonesleft(self.clonesleft - 1);
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0x262d47cb, Offset: 0x2238
// Size: 0xba
function propsetclonesleft(newvalue) {
    self.clonesleft = newvalue;
    if (prop::useprophudserver() && isdefined(self) && isalive(self) && isdefined(self.clonekey)) {
        self.clonekey setvalue(self.clonesleft);
        if (self.clonesleft <= 0) {
            self.clonekey.alpha = 0.5;
            return;
        }
        self.clonekey.alpha = 1;
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x849be417, Offset: 0x2300
// Size: 0x32
function prophasflashesleft() {
    /#
        if (isdefined(self.var_2f1101f4) && self.var_2f1101f4) {
            return true;
        }
    #/
    return self.abilityleft > 0;
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x7ad44a93, Offset: 0x2340
// Size: 0x44
function propdeductflash() {
    /#
        if (isdefined(self.var_2f1101f4) && self.var_2f1101f4) {
            return;
        }
    #/
    propsetflashesleft(self.abilityleft - 1);
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0x8ff8d75b, Offset: 0x2390
// Size: 0x72
function propsetflashesleft(newvalue) {
    self.abilityleft = newvalue;
    if (prop::useprophudserver()) {
        self.abilitykey setvalue(self.abilityleft);
        if (self.abilityleft <= 0) {
            self.abilitykey.alpha = 0.5;
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0x2c210bf8, Offset: 0x2410
// Size: 0x1ba
function set_pitch_roll_for_ground_normal(traceignore) {
    groundnormal = get_ground_normal(traceignore, 0);
    if (!isdefined(groundnormal)) {
        return;
    }
    ovf = anglestoforward(self.angles);
    ovr = anglestoright(self.angles);
    new_angles = vectortoangles(groundnormal);
    pitch = angleclamp180(new_angles[0] + 90);
    new_angles = (0, new_angles[1], 0);
    var_7001e881 = anglestoforward(new_angles);
    mod = vectordot(var_7001e881, ovr);
    if (mod < 0) {
        mod = -1;
    } else {
        mod = 1;
    }
    dot = vectordot(var_7001e881, ovf);
    newpitch = dot * pitch;
    newroll = (1 - abs(dot)) * pitch * mod;
    self.angles = (newpitch, self.angles[1], newroll);
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0xb304c063, Offset: 0x25d8
// Size: 0xc0
function function_b811663a(shouldignore) {
    foreach (player in level.players) {
        if (isdefined(player.prop)) {
            if (shouldignore) {
                player.prop notsolid();
                continue;
            }
            player.prop solid();
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0xb7858924, Offset: 0x26a0
// Size: 0x124
function function_af3207f6(shouldignore) {
    foreach (player in level.players) {
        if (isdefined(player.propclones)) {
            foreach (clone in player.propclones) {
                if (isdefined(clone)) {
                    if (shouldignore) {
                        clone notsolid();
                        continue;
                    }
                    clone solid();
                }
            }
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 2, eflags: 0x0
// Checksum 0x6801df8b, Offset: 0x27d0
// Size: 0x3c0
function get_ground_normal(traceignore, debug) {
    if (!isdefined(traceignore)) {
        ignore = self;
    } else {
        ignore = traceignore;
    }
    tracepoints = array(self.origin);
    if (getdvarint(#"hash_32aee631b4444f90", 1)) {
        for (i = -1; i <= 1; i += 2) {
            for (j = -1; j <= 1; j += 2) {
                corner = ignore getpointinbounds(i, j, 0);
                corner = (corner[0], corner[1], self.origin[2]);
                tracepoints[tracepoints.size] = corner;
            }
        }
    }
    function_b811663a(1);
    avgnormal = (0, 0, 0);
    tracehitcount = 0;
    foreach (point in tracepoints) {
        trace = bullettrace(point + (0, 0, 4), point + (0, 0, -16), 0, ignore);
        tracehit = trace[#"fraction"] > 0 && trace[#"fraction"] < 1;
        if (tracehit) {
            avgnormal += trace[#"normal"];
            tracehitcount++;
        }
        /#
            if (debug) {
                if (tracehit) {
                    line(point, point + trace[#"normal"] * 30, (0, 1, 0));
                    continue;
                }
                sphere(point, 3, (1, 0, 0));
            }
        #/
    }
    function_b811663a(0);
    if (tracehitcount > 0) {
        avgnormal /= tracehitcount;
        /#
            if (debug) {
                line(self.origin, self.origin + avgnormal * 20, (1, 1, 1));
            }
        #/
        return avgnormal;
    }
    /#
        if (debug) {
            sphere(self.origin, 5, (1, 0, 0));
        }
    #/
    return undefined;
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xd13b6a69, Offset: 0x2b98
// Size: 0x192
function propmoveunlock() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    var_f98cbcda = 0;
    var_bc31618a = 0;
    var_449744f5 = 0;
    while (true) {
        waitframe(1);
        movement = self getnormalizedmovement();
        jumping = self jumpbuttonpressed();
        if (!isdefined(movement)) {
            continue;
        }
        ismoving = movement[0] != 0 || movement[1] != 0 || jumping;
        if (self.lock && var_449744f5 && !ismoving) {
            var_449744f5 = 0;
        } else if (self.lock && !var_f98cbcda && ismoving) {
            var_449744f5 = 1;
        } else if (self.lock && ismoving && !var_449744f5) {
            self unlockprop();
        }
        var_f98cbcda = self.lock;
        var_bc31618a = ismoving;
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x665317c8, Offset: 0x2d38
// Size: 0x13c
function unlockprop() {
    self unlink();
    self resetdoublejumprechargetime();
    if (self.slopelocked) {
        self.propent unlink();
        self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
        self.propent.origin = self.propanchor.origin;
        self.propent linkto(self.propanchor);
    }
    self.propanchor linkto(self);
    self.lock = 0;
    if (prop::useprophudserver()) {
        self.lockpropkey.label = #"mp_ph_lock";
        self thread flashlockpropkey();
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x940723c2, Offset: 0x2e80
// Size: 0x144
function lockprop() {
    if (!canlock()) {
        return;
    }
    self.propanchor unlink();
    self.propanchor.origin = self.origin;
    self playerlinkto(self.propanchor);
    if (self.slopelocked) {
        self.propent unlink();
        self.propent set_pitch_roll_for_ground_normal(self.prop);
        self.propent.origin = self.origin;
        self.propent linkto(self.propanchor);
    }
    self.lock = 1;
    self notify(#"locked");
    if (prop::useprophudserver()) {
        self.lockpropkey.label = #"mp_ph_locked";
        self thread flashlockpropkey();
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x82303ea1, Offset: 0x2fd0
// Size: 0xf6
function flashlockpropkey() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"flashlockpropkey");
    self endon(#"flashlockpropkey");
    if (!isdefined(self.lockpropkey.startfontscale)) {
        self.lockpropkey.startfontscale = 1;
    }
    newscale = self.lockpropkey.startfontscale + 0.75;
    self.lockpropkey.fontscale = newscale;
    wait 0.1;
    if (isdefined(self.lockpropkey)) {
        self.lockpropkey.fontscale = self.lockpropkey.startfontscale;
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xc32d489d, Offset: 0x30d0
// Size: 0x72
function function_fd824ee5() {
    assert(isplayer(self));
    start = self.origin;
    end = start + (0, 0, -2000);
    return playerphysicstrace(start, end);
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x80438603, Offset: 0x3150
// Size: 0x92
function function_b9733d59() {
    assert(isplayer(self));
    start = self.origin;
    end = start + (0, 0, -2000);
    trace = bullettrace(start, end, 0, self.prop);
    return trace;
}

/#

    // Namespace prop_controls/_prop_controls
    // Params 9, eflags: 0x0
    // Checksum 0x8ed24060, Offset: 0x31f0
    // Size: 0x19a
    function function_2dff88ca(success, type, player, origin1, text1, origin2, text2, origin3, text3) {
        if (!isdefined(level.var_ec1690fd)) {
            level.var_ec1690fd = spawnstruct();
        }
        level.var_ec1690fd.success = success;
        level.var_ec1690fd.type = type;
        level.var_ec1690fd.playerorg = player.origin;
        level.var_ec1690fd.playerangles = player.angles;
        level.var_ec1690fd.playermins = player getmins();
        level.var_ec1690fd.playermaxs = player getmaxs();
        level.var_ec1690fd.origin1 = origin1;
        level.var_ec1690fd.text1 = text1;
        level.var_ec1690fd.origin2 = origin2;
        level.var_ec1690fd.text2 = text2;
        level.var_ec1690fd.origin3 = origin3;
        level.var_ec1690fd.text3 = text3;
    }

#/

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xe6816d87, Offset: 0x3398
// Size: 0x672
function canlock() {
    killtriggers = getentarray("trigger_hurt", "classname");
    oobtriggers = getentarray("trigger_out_of_bounds", "classname");
    triggers = arraycombine(killtriggers, oobtriggers, 0, 0);
    var_40aa9cbd = getentarray("prop_no_lock", "targetname");
    if (var_40aa9cbd.size > 0) {
        triggers = arraycombine(triggers, var_40aa9cbd, 0, 0);
    }
    foreach (trigger in triggers) {
        if (trigger istouchingvolume(self.origin, self getmins(), self getmaxs())) {
            /#
                function_2dff88ca(0, "<dev string:x30>", self, trigger.origin, trigger.classname);
            #/
            return 0;
        }
    }
    if (self isplayerswimming()) {
        /#
            function_2dff88ca(1, "<dev string:x36>", self);
        #/
        return 1;
    }
    if (!self isonground() || self iswallrunning()) {
        trace1 = self function_b9733d59();
        frac = trace1[#"fraction"];
        org1 = trace1[#"position"];
        if (frac == 1) {
            /#
                function_2dff88ca(0, "<dev string:x3b>", self, org1, "<dev string:x42>");
            #/
            return 0;
        }
        foreach (trigger in triggers) {
            if (trigger istouchingvolume(org1, self getmins(), self getmaxs())) {
                /#
                    function_2dff88ca(0, "<dev string:x43>", self, trigger.origin, trigger.classname);
                #/
                return 0;
            }
        }
        point = getnearestpathpoint(org1, 256);
        if (!isdefined(point)) {
            /#
                function_2dff88ca(0, "<dev string:x4a>", self, org1);
            #/
            return 0;
        }
        distz = point[2] - org1[2];
        if (distz > 50) {
            point2 = getnearestpathpoint(org1, 50);
            if (!isdefined(point2)) {
                /#
                    function_2dff88ca(0, "<dev string:x4f>", self, org1, "<dev string:x59>", point, "<dev string:x4a>");
                #/
                return 0;
            }
        }
        dist2d = distance2d(point, org1);
        if (dist2d > 100) {
            /#
                function_2dff88ca(0, "<dev string:x5f>", self, org1, "<dev string:x59>", point, "<dev string:x4a>");
            #/
            return 0;
        }
        org2 = self function_fd824ee5();
        foreach (trigger in triggers) {
            if (trigger istouchingvolume(org2, self getmins(), self getmaxs())) {
                /#
                    function_2dff88ca(0, "<dev string:x66>", self, trigger.origin, trigger.classname);
                #/
                return 0;
            }
        }
        /#
            function_2dff88ca(1, "<dev string:x6a>", self, org1, "<dev string:x43>", org2, "<dev string:x66>", point, "<dev string:x6e>" + distance(org1, point));
        #/
        return 1;
    }
    /#
        function_2dff88ca(1, "<dev string:x74>", self);
    #/
    return 1;
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x5d91bc3b, Offset: 0x3a18
// Size: 0x1c0
function propcamerazoom() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    var_8ea3acea = 10;
    self.thirdpersonrange = self.prop.info.proprange;
    while (true) {
        waitresult = self waittill(#"zoomin", #"zoomout");
        zoom = waitresult._notify;
        if (!isdefined(zoom)) {
            continue;
        }
        if (zoom == "zoomin") {
            if (self.thirdpersonrange - var_8ea3acea < 50) {
                continue;
            }
            self.thirdpersonrange -= var_8ea3acea;
            self setclientthirdperson(1);
            continue;
        }
        if (zoom == "zoomout") {
            var_b751fa63 = math::clamp(self.prop.info.proprange + 50, 50, 360);
            if (self.thirdpersonrange + var_8ea3acea > var_b751fa63) {
                continue;
            }
            self.thirdpersonrange += var_8ea3acea;
            self setclientthirdperson(1);
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x48e1d538, Offset: 0x3be0
// Size: 0x82
function setnewabilityhud() {
    switch (self.currentability) {
    case #"flash":
        self.abilitykey.label = #"mp_ph_flash";
        break;
    default:
        assertmsg("<dev string:x7b>");
        break;
    }
}

// Namespace prop_controls/_prop_controls
// Params 2, eflags: 0x0
// Checksum 0x59f7317f, Offset: 0x3c70
// Size: 0xea
function setnewabilitycount(var_9c968389, count) {
    switch (var_9c968389) {
    case #"flash":
        if (!isdefined(count)) {
            count = level.phsettings.propnumflashes;
        }
        propsetflashesleft(count);
        break;
    case #"clone":
        if (!isdefined(count)) {
            count = level.phsettings.propnumclones;
        }
        propsetclonesleft(count);
        break;
    default:
        assertmsg("<dev string:x93>" + var_9c968389);
        break;
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x82fbd8f3, Offset: 0x3d68
// Size: 0x2e
function endondeath() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"end_explode");
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0xf7a7b0cf, Offset: 0x3da0
// Size: 0xb4
function flashtheprops(var_e967d644) {
    level endon(#"game_ended");
    var_e967d644 endon(#"disconnect");
    self thread endondeath();
    self endon(#"end_explode");
    res = self waittill(#"explode");
    position = res.position;
    if (!isdefined(var_e967d644)) {
        return;
    }
    flashenemies(var_e967d644, position);
}

// Namespace prop_controls/_prop_controls
// Params 2, eflags: 0x0
// Checksum 0xdb1698bd, Offset: 0x3e60
// Size: 0x2f0
function flashenemies(var_e967d644 = self, position = self.origin) {
    playfx(fx::get("propFlash"), position + (0, 0, 4));
    playsoundatposition("mpl_emp_equip_stun", position);
    foreach (otherplayer in level.players) {
        if (otherplayer == var_e967d644) {
            continue;
        }
        if (isdefined(otherplayer.flashimmune) && otherplayer.flashimmune) {
            continue;
        }
        if (!isdefined(otherplayer) || !isalive(otherplayer) || !isdefined(otherplayer.team) || otherplayer.team != game.attackers) {
            continue;
        }
        vec = position + (0, 0, 4) - otherplayer geteye();
        dist = length(vec);
        radius_max = 500;
        radius_min = 150;
        if (dist <= radius_max) {
            if (dist <= radius_min) {
                var_bdf6b2ee = 1;
            } else {
                var_bdf6b2ee = 1 - (dist - radius_min) / (radius_max - radius_min);
            }
            dir = vectornormalize(vec);
            fwd = anglestoforward(otherplayer getplayerangles());
            var_b02fb38d = vectordot(fwd, dir);
            otherplayer notify(#"flashbang", var_bdf6b2ee);
            var_e967d644 thread damagefeedback::update();
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xc9e92bd3, Offset: 0x4158
// Size: 0x1ba
function deletepropsifatmax() {
    var_b793211e = 9;
    if (level.phsettings.var_78280ce0) {
        var_b793211e = 27;
    }
    if (self.propclones.size + 1 <= var_b793211e) {
        return;
    }
    var_b76d0af5 = 0;
    foreach (clone in self.propclones) {
        if (isdefined(clone)) {
            var_b76d0af5++;
        }
    }
    if (var_b76d0af5 + 1 <= var_b793211e) {
        return;
    }
    clones = [];
    var_1292f83e = undefined;
    for (i = 0; i < self.propclones.size; i++) {
        clone = self.propclones[i];
        if (!isdefined(clone)) {
            continue;
        }
        if (!isdefined(var_1292f83e)) {
            var_1292f83e = clone;
            continue;
        }
        clones[clones.size] = clone;
    }
    assert(isdefined(var_1292f83e));
    var_1292f83e notify(#"maxdelete");
    var_1292f83e delete();
    self.propclones = clones;
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xea69e538, Offset: 0x4320
// Size: 0x25e
function cloneprop() {
    if (!isdefined(self.propclones)) {
        self.propclones = [];
    } else {
        deletepropsifatmax();
    }
    var_a20cbf64 = spawn("script_model", self.prop.origin);
    var_a20cbf64.targetname = "propClone";
    var_a20cbf64 setmodel(self.prop.model);
    var_a20cbf64 setscale(self.prop.info.propscale);
    var_a20cbf64.angles = self.prop.angles;
    var_a20cbf64 setcandamage(1);
    var_a20cbf64.fakehealth = 50;
    var_a20cbf64.health = 99999;
    var_a20cbf64.maxhealth = 99999;
    var_a20cbf64.playerowner = self;
    var_a20cbf64 thread prop::function_500dc7d9(&damageclonewatch);
    var_a20cbf64 setplayercollision(0);
    var_a20cbf64 makesentient();
    var_a20cbf64 setteam(self.team);
    var_a20cbf64 clientfield::set("enemyequip", 2);
    if (prop::function_503c9413()) {
        var_a20cbf64 hidefromteam(game.attackers);
        var_a20cbf64 notsolid();
    }
    if (level.phsettings.var_78280ce0) {
        var_a20cbf64.fakehealth = 100;
    }
    self.propclones[self.propclones.size] = var_a20cbf64;
}

// Namespace prop_controls/_prop_controls
// Params 10, eflags: 0x0
// Checksum 0x61ebf143, Offset: 0x4588
// Size: 0x17e
function damageclonewatch(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, weapon, idflags) {
    if (!isdefined(attacker)) {
        return;
    }
    if (isplayer(attacker)) {
        if (isdefined(self.isdying) && self.isdying) {
            return;
        }
        if (isdefined(weapon) && weapon.rootweapon.name == "concussion_grenade" && isdefined(meansofdeath) && meansofdeath != "MOD_IMPACT") {
            function_770b4cfa(attacker, undefined, meansofdeath, damage, point, weapon);
        }
        attacker thread damagefeedback::update();
        self.lastattacker = attacker;
        self.fakehealth -= damage;
        if (self.fakehealth <= 0) {
            self function_a40d8853();
            return;
        }
    }
    self.health += damage;
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x4710
// Size: 0x4
function function_8e6b5244() {
    
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x4720
// Size: 0x4
function function_de01cce2() {
    
}

// Namespace prop_controls/_prop_controls
// Params 2, eflags: 0x0
// Checksum 0xf92828cd, Offset: 0x4730
// Size: 0xa4
function function_7a923efa(var_8847a584, attacker) {
    if (isdefined(var_8847a584)) {
        if (!isdefined(var_8847a584.var_86fdc107)) {
            var_8847a584 function_de01cce2();
        }
        var_8847a584 function_8e6b5244();
    }
    if (isdefined(attacker)) {
        if (!isdefined(attacker.var_86fdc107)) {
            attacker function_de01cce2();
        }
        attacker function_8e6b5244();
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xdb930517, Offset: 0x47e0
// Size: 0x17c
function function_a40d8853() {
    if (level.phsettings.var_78280ce0) {
        thread function_7a923efa(self.playerowner, self.lastattacker);
        if (isdefined(self.playerowner)) {
            self.playerowner propsetclonesleft(self.playerowner.clonesleft + 1);
        }
    } else if (isdefined(self.lastattacker)) {
        scoreevents::processscoreevent("clone_destroyed", self.lastattacker);
        if (isdefined(self.playerowner)) {
            scoreevents::processscoreevent("clone_was_destroyed", self.playerowner);
        }
    }
    if (!isdefined(self.isdying)) {
        self.isdying = 1;
    }
    playsoundatposition("wpn_flash_grenade_explode", self.origin + (0, 0, 4));
    playfx(fx::get("propDeathFX"), self.origin + (0, 0, 4));
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace prop_controls/_prop_controls
// Params 3, eflags: 0x0
// Checksum 0x98ed7e18, Offset: 0x4968
// Size: 0x272
function function_7244ebc6(var_ad5f9a75, fade_in_time, fade_out_time) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    if (!isdefined(var_ad5f9a75)) {
        var_ad5f9a75 = 5;
    }
    if (!isdefined(fade_in_time)) {
        fade_in_time = 1;
    }
    if (!isdefined(fade_out_time)) {
        fade_out_time = 1;
    }
    assert(fade_out_time + fade_in_time < var_ad5f9a75);
    overlay = spawnstruct();
    overlay.foreground = 0;
    overlay.x = 0;
    overlay.y = 0;
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = 0;
    waitframe(1);
    if (fade_in_time < 0) {
    }
    overlay.alpha = 1;
    self setclientuivisibilityflag("hud_visible", 0);
    self prop::function_da184fd(fade_in_time);
    self useservervisionset(1);
    self setvisionsetforplayer("blackout_ph", fade_in_time);
    self prop::function_da184fd(var_ad5f9a75 - fade_out_time - fade_in_time);
    if (fade_out_time < 0) {
    }
    overlay.alpha = 0;
    self useservervisionset(0);
    self setvisionsetforplayer("blackout_ph", fade_out_time);
    self prop::function_da184fd(fade_out_time);
    self setclientuivisibilityflag("hud_visible", 1);
    waitframe(1);
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xbd5ce535, Offset: 0x4be8
// Size: 0xe6
function watchspecialgrenadethrow() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"watchspecialgrenadethrow");
    self endon(#"watchspecialgrenadethrow");
    while (true) {
        res = self waittill(#"grenade_fire");
        grenade = res.projectile;
        weapon = res.weapon;
        self thread trackgrenade(grenade, weapon);
        self.thrownspecialcount += 1;
    }
}

// Namespace prop_controls/_prop_controls
// Params 2, eflags: 0x0
// Checksum 0x34c7650b, Offset: 0x4cd8
// Size: 0x11c
function trackgrenade(grenade, weapon) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    res = grenade waittill(#"explode");
    damageorigin = res.position;
    if (!isdefined(level.var_56d3e86e)) {
        level.var_56d3e86e = [];
    }
    index = function_913d23(damageorigin);
    if (!isdefined(index)) {
        index = function_141daf3d(self, damageorigin, weapon, 1, "MOD_GRENADE_SPLASH");
    }
    waitframe(1);
    waitframe(1);
    self function_af4e8351(index);
    waitframe(1);
    level.var_56d3e86e[index] = undefined;
}

// Namespace prop_controls/_prop_controls
// Params 5, eflags: 0x0
// Checksum 0x8871d582, Offset: 0x4e00
// Size: 0x112
function function_141daf3d(attacker, damageorigin, weapon, damage, meansofdeath) {
    index = level.var_56d3e86e.size;
    level.var_56d3e86e[index] = spawnstruct();
    level.var_56d3e86e[index].players = [];
    level.var_56d3e86e[index].attacker = self;
    level.var_56d3e86e[index].damageorigin = damageorigin;
    level.var_56d3e86e[index].damage = damage;
    level.var_56d3e86e[index].meansofdeath = meansofdeath;
    level.var_56d3e86e[index].weapon = weapon;
    return index;
}

// Namespace prop_controls/_prop_controls
// Params 6, eflags: 0x0
// Checksum 0xc517b618, Offset: 0x4f20
// Size: 0xee
function function_770b4cfa(attacker, var_bf500123, meansofdeath, damage, damageorigin, weapon) {
    if (!isdefined(level.var_56d3e86e)) {
        level.var_56d3e86e = [];
    }
    index = function_913d23(damageorigin);
    if (!isdefined(index)) {
        index = function_141daf3d(attacker, damageorigin, weapon, damage, meansofdeath);
    }
    if (isdefined(var_bf500123)) {
        playerindex = level.var_56d3e86e[index].players.size;
        level.var_56d3e86e[index].players[playerindex] = var_bf500123;
    }
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0x6894818d, Offset: 0x5018
// Size: 0x9a
function function_913d23(damageorigin) {
    if (!isdefined(level.var_56d3e86e)) {
        return;
    }
    foreach (index, event in level.var_56d3e86e) {
        if (event.damageorigin == damageorigin) {
            return index;
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0xc963e23f, Offset: 0x50c0
// Size: 0x2f4
function function_af4e8351(index) {
    if (!isdefined(level.var_56d3e86e) || !isdefined(level.var_56d3e86e[index].attacker)) {
        return;
    }
    weapon = level.var_56d3e86e[index].weapon;
    damageorigin = level.var_56d3e86e[index].damageorigin;
    expradius = weapon.explosionradius;
    var_6a573904 = expradius * expradius;
    foreach (player in level.players) {
        if (!player util::isprop() || !isalive(player) || player function_fde936b5(index)) {
            continue;
        }
        distsq = distancesquared(damageorigin, player.origin);
        if (distsq <= var_6a573904) {
            function_73052bdb(0);
            function_564fbbef(0);
            function_b7d2b256(1);
            function_56938929(0);
            damage = level.var_56d3e86e[index].damage;
            attacker = level.var_56d3e86e[index].attacker;
            meansofdeath = level.var_56d3e86e[index].meansofdeath;
            attacker radiusdamage(damageorigin, expradius, damage, damage, attacker, meansofdeath, weapon);
            function_73052bdb(1);
            function_564fbbef(1);
            function_b7d2b256(0);
            function_56938929(1);
            break;
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0xd8c4d81, Offset: 0x53c0
// Size: 0x170
function function_73052bdb(issolid) {
    foreach (player in level.players) {
        if (isdefined(player.prop)) {
            if (issolid) {
                if (isdefined(player.prop.var_42c57e68)) {
                    player.prop setcontents(player.prop.var_42c57e68);
                }
                player.prop solid();
                continue;
            }
            if (!isdefined(player.prop.var_42c57e68)) {
                player.prop.var_42c57e68 = player.prop setcontents(0);
            } else {
                player.prop setcontents(0);
            }
            player.prop notsolid();
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0x28548b08, Offset: 0x5538
// Size: 0x1ac
function function_564fbbef(issolid) {
    foreach (player in level.players) {
        if (isdefined(player.propclones)) {
            foreach (clone in player.propclones) {
                if (isdefined(clone)) {
                    if (issolid) {
                        if (isdefined(clone.var_edad31da)) {
                            clone setcontents(clone.var_edad31da);
                        }
                        clone solid();
                        continue;
                    }
                    if (!isdefined(clone.var_edad31da)) {
                        clone.var_edad31da = clone setcontents(0);
                    } else {
                        clone setcontents(0);
                    }
                    clone notsolid();
                }
            }
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0x94ccec67, Offset: 0x56f0
// Size: 0x128
function function_b7d2b256(issolid) {
    foreach (player in level.players) {
        if (!player util::isprop() || !isalive(player)) {
            continue;
        }
        if (issolid) {
            player setcontents(level.phsettings.playercontents);
            player solid();
            continue;
        }
        player setcontents(0);
        player notsolid();
    }
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0x5ec2e504, Offset: 0x5820
// Size: 0x128
function function_56938929(issolid) {
    foreach (player in level.players) {
        if (!player prop::function_e4b2f23() || !isalive(player)) {
            continue;
        }
        if (issolid) {
            player setcontents(level.phsettings.playercontents);
            player solid();
            continue;
        }
        player setcontents(0);
        player notsolid();
    }
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0xc47754cd, Offset: 0x5950
// Size: 0x4e
function function_94e1618c(damageorigin) {
    index = function_913d23(damageorigin);
    if (isdefined(index)) {
        return self function_fde936b5(index);
    }
    return 0;
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0xd6d269da, Offset: 0x59a8
// Size: 0x9a
function function_fde936b5(index) {
    foreach (var_f07e80d9 in level.var_56d3e86e[index].players) {
        if (isdefined(var_f07e80d9) && var_f07e80d9 == self) {
            return true;
        }
    }
    return false;
}

// Namespace prop_controls/_prop_controls
// Params 2, eflags: 0x0
// Checksum 0xdab1c0c3, Offset: 0x5a50
// Size: 0x2a
function safesetalpha(hudelem, var_9a1ea53a) {
    if (isdefined(hudelem)) {
        hudelem.alpha = var_9a1ea53a;
    }
}

// Namespace prop_controls/_prop_controls
// Params 2, eflags: 0x0
// Checksum 0x2944ca7a, Offset: 0x5a88
// Size: 0x164
function propabilitykeysvisible(visible, override) {
    if (isdefined(visible) && visible) {
        alphavalue = 1;
    } else {
        alphavalue = 0;
    }
    if (prop::useprophudserver() || isdefined(override) && override) {
        safesetalpha(self.changepropkey, alphavalue);
        safesetalpha(self.spinpropkey, alphavalue);
        safesetalpha(self.lockpropkey, alphavalue);
        safesetalpha(self.matchslopekey, alphavalue);
        safesetalpha(self.abilitykey, alphavalue);
        safesetalpha(self.clonekey, alphavalue);
        safesetalpha(self.zoomkey, alphavalue);
        safesetalpha(self.var_6f16621b, alphavalue);
        if (!(isdefined(level.nopropsspectate) && level.nopropsspectate)) {
            safesetalpha(self.spectatekey, alphavalue);
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x7dfdd9b8, Offset: 0x5bf8
// Size: 0xea
function function_8b7be7e3() {
    if (!isdefined(self.var_4a35819e)) {
        self.var_4a35819e = 1;
    } else {
        self.var_4a35819e = !self.var_4a35819e;
    }
    if (self.var_4a35819e) {
        self.prop clientfield::set("retrievable", 1);
        if (prop::useprophudserver()) {
            self.var_6f16621b.label = #"hash_54ba1311175de71e";
        }
        return;
    }
    self.prop clientfield::set("retrievable", 0);
    if (prop::useprophudserver()) {
        self.var_6f16621b.label = #"hash_fb73fdc2aff963f";
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xad1f2610, Offset: 0x5cf0
// Size: 0x82
function function_bf45ce54() {
    assert(!isdefined(self.var_b47d9b7e));
    if (self issplitscreen()) {
        self.currenthudy = -50;
    } else {
        self.currenthudy = -100;
    }
    self.var_b47d9b7e = addupperrighthudelem(#"mp_ph_ping");
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x4ed49381, Offset: 0x5d80
// Size: 0x6c
function function_227409a5() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self waittill(#"death");
    self thread function_b4c19c50();
    self thread function_7fd4f3ae();
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x5df8
// Size: 0x4
function function_7fd4f3ae() {
    
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xdca8e918, Offset: 0x5e08
// Size: 0x44
function function_b6740059() {
    if (isai(self)) {
        return;
    }
    self notifyonplayercommand("ping", "+smoke");
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xfe03920e, Offset: 0x5e58
// Size: 0x44
function function_b4c19c50() {
    if (isai(self)) {
        return;
    }
    self notifyonplayercommandremove("ping", "+smoke");
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xf6988139, Offset: 0x5ea8
// Size: 0x32
function function_5951cacf() {
    /#
        if (isdefined(self.var_74ca9cd1) && self.var_74ca9cd1) {
            return true;
        }
    #/
    return self.var_292246d3 > 0;
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x2b379d8d, Offset: 0x5ee8
// Size: 0x44
function function_2c53f5e6() {
    /#
        if (isdefined(self.var_74ca9cd1) && self.var_74ca9cd1) {
            return;
        }
    #/
    function_afeda2bf(self.var_292246d3 - 1);
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0xee640cb2, Offset: 0x5f38
// Size: 0x72
function function_afeda2bf(newvalue) {
    self.var_292246d3 = newvalue;
    if (prop::useprophudserver()) {
        self.var_b47d9b7e setvalue(self.var_292246d3);
        if (self.var_292246d3 <= 0) {
            self.var_b47d9b7e.alpha = 0.5;
        }
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xdf75d51c, Offset: 0x5fb8
// Size: 0x98
function function_1abcc66() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    if (isai(self)) {
        return;
    }
    prop::function_45c842e9();
    while (true) {
        self waittill(#"ping");
        self function_38543493();
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x94bee55c, Offset: 0x6058
// Size: 0x84
function function_38543493() {
    if (!level flag::get("props_hide_over")) {
        return;
    }
    if (isdefined(self.var_ad7b9a66) && self.var_ad7b9a66) {
        return;
    }
    if (self function_5951cacf()) {
        self thread function_aac4667c();
        self function_2c53f5e6();
    }
}

// Namespace prop_controls/_prop_controls
// Params 0, eflags: 0x0
// Checksum 0x4aca4888, Offset: 0x60e8
// Size: 0x25e
function function_aac4667c() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self.var_ad7b9a66 = 1;
    if (prop::useprophudserver()) {
        self.var_b47d9b7e.alpha = 0.5;
    }
    var_6f71e4e9 = gameobjects::get_next_obj_id();
    objective_add(var_6f71e4e9, "active");
    objective_onentity(var_6f71e4e9, self);
    self thread function_41584b4b(var_6f71e4e9);
    self clientfield::set("pingHighlight", 1);
    foreach (player in level.players) {
        if (isalive(player) && player.team == self.team) {
            player playlocalsound("evt_hacker_raise");
        }
    }
    hostmigration::waitlongdurationwithhostmigrationpause(4);
    self clientfield::set("pingHighlight", 0);
    gameobjects::release_obj_id(var_6f71e4e9);
    if (prop::useprophudserver() && isdefined(self.var_b47d9b7e)) {
        self.var_b47d9b7e.alpha = 1;
    }
    self.var_ad7b9a66 = 0;
    self notify(#"hash_6cf294ccb4526d36");
}

// Namespace prop_controls/_prop_controls
// Params 1, eflags: 0x0
// Checksum 0x50a5e24a, Offset: 0x6350
// Size: 0x74
function function_41584b4b(var_6f71e4e9) {
    level endon(#"game_ended");
    self endon(#"hash_6cf294ccb4526d36");
    self util::waittill_either("disconnect", "death");
    gameobjects::release_obj_id(var_6f71e4e9);
}

