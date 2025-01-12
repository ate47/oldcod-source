#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace namespace_13b01f59;

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x2
// Checksum 0x22d0af32, Offset: 0x188
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_4b6aad59587b2b51", &__init__, undefined, undefined);
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0x614bd4dd, Offset: 0x1d0
// Size: 0x12c
function __init__() {
    level.var_53022701 = isdefined(getgametypesetting(#"deathzones")) && getgametypesetting(#"deathzones");
    level.deathzones = [];
    level.var_5e1da61a = [];
    if (!level.var_53022701) {
        return;
    }
    clientfield::register("toplayer", "deathzonepostfx", 1, 1, "int", &function_90fd06c4, 0, 1);
    clientfield::register("toplayer", "deathzonewarningsound", 1, 2, "int", &function_5cdb5442, 0, 1);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 1, eflags: 0x0
// Checksum 0x831d2d6f, Offset: 0x308
// Size: 0x290
function function_302b7c90(localclientnum) {
    self endon(#"death");
    var_e95fa7e5 = createuimodel(getuimodelforcontroller(localclientnum), "locationText");
    var_a0534f4f = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.deathZones");
    var_b1862515 = createuimodel(var_a0534f4f, "towerIndex");
    var_6ecf939c = createuimodel(var_a0534f4f, "floorIndex");
    var_d1c2cd05 = undefined;
    while (isdefined(self)) {
        var_bd8e7ad0 = 0;
        foreach (targetname, zone in level.deathzones) {
            if (istouching(self.origin, zone.ent)) {
                if (var_d1c2cd05 !== targetname) {
                    setuimodelvalue(var_e95fa7e5, zone.displayname);
                    setuimodelvalue(var_b1862515, zone.towerindex);
                    setuimodelvalue(var_6ecf939c, zone.floorIndex);
                    var_d1c2cd05 = targetname;
                }
                var_bd8e7ad0 = 1;
                self function_983c4ea1(zone);
                break;
            }
        }
        if (!var_bd8e7ad0) {
            setuimodelvalue(var_e95fa7e5, #"");
            setuimodelvalue(var_b1862515, 0);
            setuimodelvalue(var_6ecf939c, 0);
            var_d1c2cd05 = undefined;
        }
        wait 0.5;
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 1, eflags: 0x0
// Checksum 0x2d62e99b, Offset: 0x5a0
// Size: 0x34
function on_localplayer_spawned(localclientnum) {
    if (self.localclientnum === localclientnum) {
        self thread function_302b7c90(localclientnum);
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 7, eflags: 0x4
// Checksum 0x4e2fe0aa, Offset: 0x5e0
// Size: 0x84
function private function_90fd06c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self codeplaypostfxbundle("pstfx_impending_collapse");
        return;
    }
    self codestoppostfxbundle("pstfx_impending_collapse");
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 7, eflags: 0x4
// Checksum 0xf57e030e, Offset: 0x670
// Size: 0xe4
function private function_5cdb5442(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self function_27c0de81();
        self function_f425054c();
        return;
    }
    if (newval == 2) {
        self function_27c0de81();
        self function_a71ff4e6();
        return;
    }
    self function_b1ae60fb();
    self function_f425054c();
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0xa4fdaa67, Offset: 0x760
// Size: 0x42
function function_27c0de81() {
    if (!isdefined(self.var_a4408f28)) {
        self.var_a4408f28 = self playloopsound(#"hash_4a7f02fe3ed6b2e3", 0.5);
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0x387c0056, Offset: 0x7b0
// Size: 0x42
function function_a71ff4e6() {
    if (!isdefined(self.var_92de59b7)) {
        self.var_92de59b7 = self playloopsound(#"hash_225b6927fd97685c", 0.5);
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0x907fd561, Offset: 0x800
// Size: 0x3e
function function_b1ae60fb() {
    if (isdefined(self.var_a4408f28)) {
        self stoploopsound(self.var_a4408f28, 2);
        self.var_a4408f28 = undefined;
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0xc176406c, Offset: 0x848
// Size: 0x3e
function function_f425054c() {
    if (isdefined(self.var_92de59b7)) {
        self stoploopsound(self.var_92de59b7, 2);
        self.var_92de59b7 = undefined;
    }
}

// Namespace namespace_13b01f59/event_fecce913
// Params 1, eflags: 0x40
// Checksum 0xb58862c9, Offset: 0x890
// Size: 0x1a4
function event_handler[event_fecce913] function_facc1cf2(eventstruct) {
    if (!level.var_53022701) {
        return;
    }
    foreach (zone in level.deathzones) {
        if (zone.index == eventstruct.index) {
            setuimodelvalue(zone.var_7648e78f, eventstruct.state);
            if (eventstruct.state == 1) {
                zone.var_1b652cf4 = function_b71db9cf(eventstruct.localclientnum, zone);
            }
            foreach (player in getlocalplayers()) {
                if (istouching(player.origin, zone.ent)) {
                    player function_983c4ea1(zone);
                }
            }
        }
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 1, eflags: 0x0
// Checksum 0x35387705, Offset: 0xa40
// Size: 0x202
function function_983c4ea1(zone) {
    if (isdefined(self.var_e8e77de) && self.var_bd04cab !== zone) {
        foreach (exit in self.var_e8e77de) {
            exit delete();
        }
        self.var_e8e77de = undefined;
    }
    self.var_bd04cab = zone;
    if (!isdefined(zone.var_1b652cf4) || isdefined(self.var_e8e77de)) {
        return;
    }
    self.var_e8e77de = [];
    localclientnum = self getlocalclientnumber();
    foreach (point in zone.var_1b652cf4) {
        exit = spawn(localclientnum, point, "script_model");
        exit setmodel("p8_plaster_stucco_doorframe_01_56x96");
        exit playrenderoverridebundle(#"hash_1c90592671f4c6e9");
        exit thread bounce();
        self.var_e8e77de[self.var_e8e77de.size] = exit;
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0x54b9fe5, Offset: 0xc50
// Size: 0x9e
function bounce() {
    self endon(#"death");
    bottompos = self.origin;
    toppos = self.origin + (0, 0, 50);
    while (true) {
        self rotateyaw(180, 1);
        wait 1;
        self rotateyaw(180, 1);
        wait 1;
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 7, eflags: 0x0
// Checksum 0xead8c481, Offset: 0xcf8
// Size: 0x29c
function init(targetname, displayname = #"", var_717ae355 = #"", var_19c57490, towerindex, floorIndex, var_7609462b) {
    ent = getent(0, targetname, "targetName");
    if (!isdefined(ent)) {
        /#
            level.var_7acdf658 = (isdefined(level.var_7acdf658) ? level.var_7acdf658 : 0) + 1;
            level.var_29a44241 = (isdefined(level.var_29a44241) ? level.var_29a44241 : "<dev string:x30>") + targetname + "<dev string:x31>";
        #/
        return;
    }
    var_5776c240 = createuimodel(var_7609462b, floorIndex);
    setuimodelvalue(createuimodel(var_5776c240, "floorIndex"), floorIndex);
    var_7648e78f = createuimodel(var_5776c240, "state");
    setuimodelvalue(var_7648e78f, 0);
    zone = {#ent:ent, #index:level.deathzones.size, #links:[], #displayname:displayname, #var_717ae355:var_717ae355, #towerindex:towerindex, #var_7648e78f:var_7648e78f, #floorIndex:floorIndex, #var_19c57490:var_19c57490};
    level.deathzones[targetname] = zone;
    if (isdefined(var_19c57490)) {
        level.deathzones[var_19c57490].var_3f5ebc94 = targetname;
    }
    function_c7277786(zone);
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 2, eflags: 0x0
// Checksum 0xf5078bc9, Offset: 0xfa0
// Size: 0xe6
function link(var_d12d8e58, var_4334fd93) {
    var_d94ee2bc = level.deathzones[var_d12d8e58];
    var_4b5651f7 = level.deathzones[var_4334fd93];
    if (!isdefined(var_d94ee2bc) || !isdefined(var_4b5651f7)) {
        return;
    }
    if (!isinarray(var_d94ee2bc.links, var_4b5651f7)) {
        var_d94ee2bc.links[var_d94ee2bc.links.size] = var_4b5651f7;
    }
    if (!isinarray(var_4b5651f7.links, var_d94ee2bc)) {
        var_4b5651f7.links[var_4b5651f7.links.size] = var_d94ee2bc;
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 1, eflags: 0x0
// Checksum 0x9330a1f3, Offset: 0x1090
// Size: 0x11a
function function_c7277786(zone) {
    targets = struct::get_array(zone.ent.target, "targetname");
    targetpoints = [];
    foreach (target in targets) {
        targetpoints[targetpoints.size] = target.origin;
        arrayremovevalue(level.struct, target, 1);
    }
    arrayremovevalue(level.struct, undefined, 0);
    zone.targetpoints = targetpoints;
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 0, eflags: 0x0
// Checksum 0x63d60de7, Offset: 0x11b8
// Size: 0x36c
function init_zones() {
    var_648e4b40 = createuimodel(getglobaluimodel(), "hudItems.deathZones");
    towerindex = 0;
    foreach (tower in level.var_7045f0c9.var_83ddbbac) {
        linkAdjacentFloors = isdefined(tower.linkAdjacentFloors) ? tower.linkAdjacentFloors : 0;
        towerindex += 1;
        var_7609462b = createuimodel(var_648e4b40, towerindex);
        setuimodelvalue(createuimodel(var_7609462b, "displayName"), tower.var_717ae355);
        setuimodelvalue(createuimodel(var_7609462b, "linkAdjacentFloors"), linkAdjacentFloors);
        setuimodelvalue(createuimodel(var_7609462b, "numFloors"), tower.var_f232f67f.size);
        var_69901428 = undefined;
        for (i = 0; i < tower.var_f232f67f.size; i++) {
            floor = tower.var_f232f67f[i];
            init(floor.targetname, floor.displayname, tower.var_717ae355, var_69901428, towerindex, tower.var_f232f67f.size - i, var_7609462b);
            if (linkAdjacentFloors && isdefined(var_69901428)) {
                link(var_69901428, floor.targetname);
            }
            var_69901428 = floor.targetname;
        }
    }
    foreach (var_fec0ded7 in level.var_7045f0c9.var_2bf81182) {
        link(var_fec0ded7.var_f1a48208, var_fec0ded7.var_63abf143);
    }
    /#
        if (isdefined(level.var_7acdf658)) {
            errormsg(level.var_7acdf658 + "<dev string:x34>" + level.var_29a44241);
        }
    #/
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 1, eflags: 0x0
// Checksum 0x493624a2, Offset: 0x1530
// Size: 0xb2
function function_b5dcecdd(targetname) {
    targets = getentarray(0, targetname, "targetname");
    foreach (target in targets) {
        level.var_5e1da61a[level.var_5e1da61a.size] = target;
    }
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 2, eflags: 0x0
// Checksum 0x55eedde8, Offset: 0x15f0
// Size: 0xe0
function function_b71db9cf(localclientnum, zone) {
    points = [];
    foreach (var_76648ef0 in level.var_5e1da61a) {
        point = function_7162d244(localclientnum, zone, var_76648ef0);
        if (function_bf2cf692(localclientnum, zone, var_76648ef0, point)) {
            points[points.size] = point;
        }
    }
    return points;
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 3, eflags: 0x0
// Checksum 0xc19d2604, Offset: 0x16d8
// Size: 0xbc
function function_7162d244(localclientnum, zone, var_76648ef0) {
    var_bb1ad81f = zone.ent getabsmins()[2] + 1;
    point = (var_76648ef0.origin[0], var_76648ef0.origin[1], var_bb1ad81f);
    point += vectornormalize(zone.ent.origin - point);
    return point;
}

// Namespace namespace_13b01f59/namespace_13b01f59
// Params 4, eflags: 0x0
// Checksum 0x8c9418e6, Offset: 0x17a0
// Size: 0x164
function function_bf2cf692(localclientnum, zone, var_76648ef0, exitpoint) {
    if (!istouching(exitpoint, zone.ent) || !istouching(exitpoint, var_76648ef0)) {
        return false;
    }
    foreach (var_8563d934 in zone.links) {
        if (function_fc3ab3fc(localclientnum, var_8563d934.index) == 2) {
            continue;
        }
        point = function_7162d244(localclientnum, var_8563d934, var_76648ef0);
        if (istouching(point, var_8563d934.ent) && istouching(point, var_76648ef0)) {
            return true;
        }
    }
    return false;
}

