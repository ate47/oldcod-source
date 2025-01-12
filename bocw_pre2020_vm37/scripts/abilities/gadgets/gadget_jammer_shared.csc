#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace jammer;

// Namespace jammer/gadget_jammer_shared
// Params 0, eflags: 0x6
// Checksum 0x89a1b799, Offset: 0x1b8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gadget_jammer", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace jammer/gadget_jammer_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x3f429e57, Offset: 0x200
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

// Namespace jammer/gadget_jammer_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xa0ea4925, Offset: 0x220
// Size: 0xec
function init_shared() {
    if (!isdefined(level.var_578f7c6d)) {
        level.var_578f7c6d = spawnstruct();
    }
    level.var_578f7c6d.weapon = getweapon(#"gadget_jammer");
    level.var_c20391e9 = getdvarint(#"hash_7f7f1118da837313", level.var_578f7c6d.weapon.explosionradius);
    if (!isdefined(level.var_6d8e6535)) {
        level.var_6d8e6535 = [];
    }
    registerclientfields();
    callback::on_localclient_connect(&on_localplayer_connect);
}

// Namespace jammer/gadget_jammer_shared
// Params 2, eflags: 0x0
// Checksum 0x32920ccc, Offset: 0x318
// Size: 0x22
function register(entity, var_b89c18) {
    entity.var_a19988fc = var_b89c18;
}

// Namespace jammer/gadget_jammer_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xa6cc0530, Offset: 0x348
// Size: 0x244
function private registerclientfields() {
    clientfield::register("scriptmover", "isJammed", 1, 1, "int", &function_43a5b68a, 0, 0);
    clientfield::register("missile", "isJammed", 1, 1, "int", &function_43a5b68a, 0, 0);
    clientfield::register("vehicle", "isJammed", 1, 1, "int", &function_43a5b68a, 0, 0);
    clientfield::register("toplayer", "isJammed", 1, 1, "int", &player_isjammed, 0, 1);
    clientfield::register("allplayers", "isHiddenByFriendlyJammer", 1, 1, "int", &function_b53badf6, 0, 1);
    clientfield::register("missile", "jammer_active", 1, 1, "int", &jammeractive, 0, 0);
    clientfield::register("missile", "jammer_hacked", 1, 1, "counter", &jammerhacked, 0, 0);
    clientfield::register("toplayer", "jammedvehpostfx", 1, 1, "int", &function_4a82368f, 0, 1);
}

// Namespace jammer/gadget_jammer_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xa235569, Offset: 0x598
// Size: 0x5c
function on_localplayer_connect(localclientnum) {
    setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d"), "jammedStrength"), 0);
}

// Namespace jammer/gadget_jammer_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x5d992689, Offset: 0x600
// Size: 0x7c
function jammeractive(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, bwastimejump) {
    if (fieldname == 1) {
        self function_2560e153(binitialsnap, bwastimejump);
        self thread function_5e3d8fe(binitialsnap);
    }
}

// Namespace jammer/gadget_jammer_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x6b5feb1b, Offset: 0x688
// Size: 0xc4
function jammerhacked(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    localplayer = function_5c10bd79(bwastimejump);
    if (util::function_fbce7263(localplayer.team, self.team)) {
        self.var_7ec0e2d1 setcompassicon("ui_hud_minimap_shroud_flipbook");
        return;
    }
    self.var_7ec0e2d1 setcompassicon("ui_hud_minimap_shroud_friendly");
}

// Namespace jammer/gadget_jammer_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xedce7231, Offset: 0x758
// Size: 0x1d8
function function_43a5b68a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.isjammed = undefined;
    if (newval == 1) {
        self.isjammed = 1;
    }
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.var_a19988fc)) {
        self thread [[ self.var_a19988fc ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
    if (!isdefined(self.weapon) || !isdefined(self.weapon.var_96850284)) {
        return;
    }
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval == 1) {
        self.var_4dc44ba4 = playtagfxset(localclientnum, self.weapon.var_96850284, self);
        return;
    }
    if (newval == 0 && oldval == 1 && isdefined(self.var_4dc44ba4)) {
        foreach (fx in self.var_4dc44ba4) {
            stopfx(localclientnum, fx);
        }
    }
}

// Namespace jammer/gadget_jammer_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xb98f4fc0, Offset: 0x938
// Size: 0x11c
function function_b53badf6(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self) || !isplayer(self)) {
        return;
    }
    self util::waittill_dobj(fieldname);
    if (!isdefined(self)) {
        return;
    }
    localplayer = function_5c10bd79(fieldname);
    if (self == localplayer || self.team == localplayer.team) {
        return;
    }
    if (bwastimejump == 1) {
        self function_811196d1(1);
        return;
    }
    if (bwastimejump == 0) {
        self function_811196d1(0);
    }
}

// Namespace jammer/gadget_jammer_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x45e8e5a9, Offset: 0xa60
// Size: 0x266
function player_isjammed(localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, bwastimejump) {
    if (!isdefined(self) || !isplayer(self)) {
        return;
    }
    self util::waittill_dobj(bnewent);
    if (!isdefined(self)) {
        return;
    }
    var_da91b79d = getuimodel(function_1df4c3b0(bnewent, #"hash_6f4b11a0bee9b73d"), "jammedStrength");
    if (fieldname == 1) {
        self notify(#"stop_sounds");
        playsound(bnewent, #"hash_4a43757dd4b02977");
        level.var_6d8e6535[bnewent] = function_604c9983(bnewent, #"hash_3330b85ee1abeb2b");
        self thread function_e9e14905(bnewent);
        setuimodelvalue(var_da91b79d, 1);
        self notify(#"hash_55123a0e484012d5");
        return;
    }
    if (fieldname == 0) {
        if (isdefined(level.var_6d8e6535[bnewent]) && !bwastimejump) {
            playsound(bnewent, #"hash_112352517abf5b11");
        }
        self notify(#"stop_sounds");
        if (binitialsnap == 1 && isalive(self) && self function_da43934d()) {
            self thread function_b47f94f(bnewent, var_da91b79d);
            return;
        }
        setuimodelvalue(var_da91b79d, 0);
        self notify(#"hash_55123a0e484012d5");
    }
}

// Namespace jammer/gadget_jammer_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xb4950972, Offset: 0xcd0
// Size: 0xd4
function function_b47f94f(*localclientnum, var_da91b79d) {
    self endon(#"hash_55123a0e484012d5");
    endtime = 0.25;
    for (progress = 0; progress < endtime; progress += 0.1) {
        percent = 1 - min(1, progress / endtime);
        setuimodelvalue(var_da91b79d, percent);
        wait 0.15;
    }
    setuimodelvalue(var_da91b79d, 0);
}

// Namespace jammer/gadget_jammer_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x20f98502, Offset: 0xdb0
// Size: 0x244
function function_2560e153(localclientnum, bwastimejump) {
    localplayer = function_5c10bd79(localclientnum);
    if (bwastimejump === 1) {
        if (isdefined(self.var_7ec0e2d1)) {
            return;
        }
    } else if (isdefined(self.var_7ec0e2d1)) {
        self.var_7ec0e2d1 delete();
    }
    self.var_7ec0e2d1 = spawn(localclientnum, self.origin, "script_model", localplayer getentitynumber(), self.team);
    self.var_7ec0e2d1 setmodel(#"tag_origin");
    self.var_7ec0e2d1 linkto(self);
    self.var_7ec0e2d1 setcompassicon("ui_hud_minimap_shroud_flipbook");
    self.var_7ec0e2d1 function_a5edb367(#"neutral");
    self.var_7ec0e2d1 enableonradar();
    if (localplayer.team == self.team) {
        self.var_7ec0e2d1 setcompassicon("ui_hud_minimap_shroud_friendly");
    } else {
        self.var_7ec0e2d1 setcompassicon("ui_hud_minimap_shroud_flipbook");
    }
    diameter = getdvarint(#"hash_7f7f1118da837313", level.var_578f7c6d.weapon.explosionradius) * 2;
    self.var_7ec0e2d1 function_5e00861(diameter, 1);
    self thread function_fc59d60e(localclientnum);
}

// Namespace jammer/gadget_jammer_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x1811f3ca, Offset: 0x1000
// Size: 0x13e
function function_5e3d8fe(localclientnum) {
    self notify("319e293754b3da61");
    self endon("319e293754b3da61");
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    var_df1b3b55 = 0.6;
    var_8288805c = 0.2;
    if (isdefined(self.weapon.customsettings)) {
        var_966a1350 = getscriptbundle(self.weapon.customsettings);
        if (isdefined(var_966a1350.var_b941081f) && isdefined(var_966a1350.var_40772cbe)) {
            while (isdefined(self)) {
                self.fx = util::playfxontag(localclientnum, var_966a1350.var_b941081f, self, var_966a1350.var_40772cbe);
                wait var_8288805c;
                stopfx(localclientnum, self.fx);
                wait var_df1b3b55;
            }
        }
    }
}

// Namespace jammer/gadget_jammer_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x315106da, Offset: 0x1148
// Size: 0x7c
function function_e9e14905(localclientnum) {
    self waittill(#"death", #"stop_sounds");
    if (isdefined(level.var_6d8e6535[localclientnum])) {
        function_d48752e(localclientnum, level.var_6d8e6535[localclientnum]);
        level.var_6d8e6535[localclientnum] = undefined;
    }
}

// Namespace jammer/gadget_jammer_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x8e34549f, Offset: 0x11d0
// Size: 0xcc
function function_4a82368f(*local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self postfx::playpostfxbundle(#"hash_68b6dee9bf4fbfbe");
        return;
    }
    if (bwastimejump == 0 && self postfx::function_556665f2(#"hash_68b6dee9bf4fbfbe")) {
        self postfx::stoppostfxbundle(#"hash_68b6dee9bf4fbfbe");
    }
}

// Namespace jammer/gadget_jammer_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x16f092e, Offset: 0x12a8
// Size: 0x4c
function private function_fc59d60e(*localclientnum) {
    self waittill(#"death");
    if (isdefined(self.var_7ec0e2d1)) {
        self.var_7ec0e2d1 delete();
    }
}

