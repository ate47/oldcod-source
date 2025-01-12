#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_armor;

// Namespace gadget_armor/gadget_armor
// Params 0, eflags: 0x2
// Checksum 0x1cce98d4, Offset: 0x320
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_armor", &__init__, undefined, undefined);
}

// Namespace gadget_armor/gadget_armor
// Params 0, eflags: 0x0
// Checksum 0xc825859b, Offset: 0x360
// Size: 0xfc
function __init__() {
    callback::on_localplayer_spawned(&on_local_player_spawned);
    clientfield::register("allplayers", "armor_status", 1, 5, "int", &function_373db61f, 0, 0);
    clientfield::register("toplayer", "player_damage_type", 1, 1, "int", &function_6cba068c, 0, 0);
    duplicate_render::set_dr_filter_framebuffer_duplicate("armor_pl", 40, "armor_on", undefined, 1, "mc/mtl_power_armor", 0);
    /#
        level thread function_cc0cff2a();
    #/
}

// Namespace gadget_armor/gadget_armor
// Params 1, eflags: 0x0
// Checksum 0xbd270c72, Offset: 0x468
// Size: 0x6c
function on_local_player_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    newval = self clientfield::get("armor_status");
    self function_692ec98e(localclientnum, newval);
}

// Namespace gadget_armor/gadget_armor
// Params 7, eflags: 0x0
// Checksum 0x18d9fbc0, Offset: 0x4e0
// Size: 0x5c
function function_6cba068c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_b465810a(localclientnum, newval);
}

// Namespace gadget_armor/gadget_armor
// Params 7, eflags: 0x0
// Checksum 0x83b202e3, Offset: 0x548
// Size: 0x5c
function function_373db61f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_692ec98e(localclientnum, newval);
}

// Namespace gadget_armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x2ccd3ef8, Offset: 0x5b0
// Size: 0x54
function function_692ec98e(localclientnum, newval) {
    self function_b465810a(localclientnum, newval);
    self function_43f40987(localclientnum, newval);
}

// Namespace gadget_armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x5917de43, Offset: 0x610
// Size: 0x224
function function_43f40987(localclientnum, var_57594972) {
    if (var_57594972) {
        self duplicate_render::update_dr_flag(localclientnum, "armor_on", 1);
        var_279cb0f6 = "scriptVector3";
        var_6936235c = 0.3;
        var_190c23ef = function_19075b3d(var_57594972);
        if (getdvarint("scr_armor_dev")) {
            var_6936235c = getdvarfloat("scr_armor_expand", var_6936235c);
            var_190c23ef = (getdvarfloat("scr_armor_colorR", var_190c23ef[0]), getdvarfloat("scr_armor_colorG", var_190c23ef[1]), getdvarfloat("scr_armor_colorB", var_190c23ef[2]));
        }
        var_f37ae0c5 = var_190c23ef[0];
        var_197d5b2e = var_190c23ef[1];
        var_776218ab = var_190c23ef[2];
        damagestate = "scriptVector4";
        var_966e9c00 = var_57594972 / 5;
        self mapshaderconstant(localclientnum, 0, var_279cb0f6, var_6936235c, var_f37ae0c5, var_197d5b2e, var_776218ab);
        self mapshaderconstant(localclientnum, 0, damagestate, var_966e9c00);
        return;
    }
    self duplicate_render::update_dr_flag(localclientnum, "armor_on", 0);
}

// Namespace gadget_armor/gadget_armor
// Params 1, eflags: 0x0
// Checksum 0x1d45bc47, Offset: 0x840
// Size: 0x36
function function_19075b3d(var_57594972) {
    color = (0.3, 0.3, 0.2);
    return color;
}

// Namespace gadget_armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0xb1a4137e, Offset: 0x880
// Size: 0xac
function function_b465810a(localclientnum, var_1a45af95) {
    if (!self function_9f08a633(localclientnum)) {
        return;
    }
    if (var_1a45af95) {
        self setdamagedirectionindicator(1);
        setsoundcontext("plr_impact", "pwr_armor");
        return;
    }
    self setdamagedirectionindicator(0);
    setsoundcontext("plr_impact", "");
}

// Namespace gadget_armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0xe68d773c, Offset: 0x938
// Size: 0x168
function function_f8f6f7ec(localclientnum, var_57594972) {
    self endon(#"disconnect");
    if (!isdefined(self.var_6b474702)) {
        self.var_6b474702 = 0;
    }
    if (var_57594972 == self.var_6b474702) {
        return;
    }
    self.var_6b474702 = var_57594972;
    if (var_57594972 == 5) {
        return;
    }
    if (isdefined(self.var_a9f82ff9) && self.var_a9f82ff9) {
        return;
    }
    self.var_a9f82ff9 = 1;
    transition = 0;
    var_211baa36 = getrealtime();
    var_51dad171 = getvisionsetnaked(localclientnum);
    visionsetnaked(localclientnum, "taser_mine_shock", transition);
    self playsound(0, "wpn_taser_mine_tacmask");
    wait 0.3;
    visionsetnaked(localclientnum, var_51dad171, transition);
    self.var_a9f82ff9 = 0;
}

// Namespace gadget_armor/gadget_armor
// Params 1, eflags: 0x0
// Checksum 0x1c2c7656, Offset: 0xaa8
// Size: 0x4a
function function_9f08a633(localclientnum) {
    player_view = getlocalplayer(localclientnum);
    var_2389f10a = self == player_view;
    return var_2389f10a;
}

/#

    // Namespace gadget_armor/gadget_armor
    // Params 0, eflags: 0x0
    // Checksum 0x61627685, Offset: 0xb00
    // Size: 0x140
    function function_cc0cff2a() {
        var_72e51998 = 0;
        setdvar("<dev string:x28>", 0);
        while (true) {
            wait 0.1;
            var_57594972 = getdvarint("<dev string:x28>");
            if (var_57594972 != var_72e51998) {
                players = getlocalplayers();
                foreach (i, localplayer in players) {
                    if (!isdefined(localplayer)) {
                        continue;
                    }
                    localplayer function_692ec98e(i, var_57594972);
                }
                var_72e51998 = var_57594972;
            }
        }
    }

#/
