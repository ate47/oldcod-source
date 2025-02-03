#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\laststand;

#namespace vip;

// Namespace vip/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x6e8dceb0, Offset: 0x100
// Size: 0x10c
function event_handler[gametype_init] main(*eventstruct) {
    clientfield::function_5b7d846d("hudItems.war.attackingTeam", #"war_data", #"attackingteam", 1, 2, "int", undefined, 0, 1);
    clientfield::register("allplayers", "vip_keyline", 1, 1, "int", &vip_keyline, 0, 1);
    clientfield::register("toplayer", "vip_ascend_postfx", 1, 1, "int", &vip_ascend_postfx, 0, 0);
    callback::on_localclient_connect(&on_localclient_connect);
}

// Namespace vip/vip
// Params 1, eflags: 0x0
// Checksum 0xf5c79a52, Offset: 0x218
// Size: 0x5c
function on_localclient_connect(*localclientnum) {
    setuimodelvalue(createuimodel(function_5f72e972(#"hash_410fe12a68d6e801"), "vipClientNum"), -1);
}

// Namespace vip/vip
// Params 7, eflags: 0x0
// Checksum 0x6662620, Offset: 0x280
// Size: 0x1d4
function vip_keyline(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death", #"disconnect");
    self util::waittill_dobj(fieldname);
    var_5f682f83 = function_9b3f0ed1(fieldname);
    localplayer = function_5c10bd79(fieldname);
    if (bwastimejump) {
        var_c4c5aa27 = getuimodel(function_5f72e972(#"hash_410fe12a68d6e801"), "vipClientNum");
        setuimodelvalue(var_c4c5aa27, self getentitynumber());
        if (self.team == var_5f682f83 && self != localplayer && !self function_d2503806(#"hash_aa2ba3bf66e25d2")) {
            self playrenderoverridebundle(#"hash_aa2ba3bf66e25d2");
        }
        return;
    }
    if (self function_d2503806(#"hash_aa2ba3bf66e25d2")) {
        self stoprenderoverridebundle(#"hash_aa2ba3bf66e25d2");
    }
}

// Namespace vip/vip
// Params 7, eflags: 0x0
// Checksum 0x88bec5ee, Offset: 0x460
// Size: 0xb4
function vip_ascend_postfx(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death", #"disconnect");
    if (bwastimejump) {
        self postfx::playpostfxbundle(#"hash_19450de64ead5f8e");
        return;
    }
    self postfx::stoppostfxbundle(#"hash_19450de64ead5f8e");
}

