#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\load;

#namespace zm_aoe;

// Namespace zm_aoe
// Method(s) 2 Total 2
class class_2be88390 {

}

// Namespace zm_aoe/zm_aoe
// Params 0, eflags: 0x2
// Checksum 0xe96bb66c, Offset: 0xf8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_aoe", &__init__, &__main__, undefined);
}

// Namespace zm_aoe/zm_aoe
// Params 0, eflags: 0x0
// Checksum 0x5f8d5180, Offset: 0x1f8
// Size: 0xb4
function __init__() {
    clientfield::register("scriptmover", "aoe_state", 1, getminbitcountfornum(4), "int", &function_9991b86c, 0, 0);
    clientfield::register("scriptmover", "aoe_id", 1, getminbitcountfornum(5), "int", &function_3ccca06a, 0, 0);
}

// Namespace zm_aoe/zm_aoe
// Params 0, eflags: 0x4
// Checksum 0xddfdc682, Offset: 0x2b8
// Size: 0x7c
function private __main__() {
    function_83d921cc(1, "zm_aoe_spear", "zm_aoe_spear");
    function_83d921cc(2, "zm_aoe_spear_small", "zm_aoe_spear_small");
    function_83d921cc(3, "zm_aoe_spear_big", "zm_aoe_spear_big");
}

// Namespace zm_aoe/zm_aoe
// Params 1, eflags: 0x4
// Checksum 0xa77bcba4, Offset: 0x340
// Size: 0xcc
function private function_dd7e9c0d(aoeid) {
    assert(isdefined(level.var_c0a905a3));
    foreach (var_61cc2b88 in level.var_c0a905a3) {
        assert(isdefined(var_61cc2b88.aoeid));
        if (var_61cc2b88.aoeid == aoeid) {
            return var_61cc2b88;
        }
    }
    return undefined;
}

// Namespace zm_aoe/zm_aoe
// Params 3, eflags: 0x0
// Checksum 0xc3ca8706, Offset: 0x418
// Size: 0x246
function function_83d921cc(aoeid, type, var_dccd947a) {
    assert(isdefined(var_dccd947a));
    var_8ec206e7 = getscriptbundle(var_dccd947a);
    if (!isdefined(var_8ec206e7)) {
        return;
    }
    if (!isdefined(level.var_c0a905a3)) {
        level.var_c0a905a3 = [];
    }
    arraykeys = getarraykeys(level.var_c0a905a3);
    assert(!isinarray(arraykeys, hash(type)));
    var_61cc2b88 = new class_2be88390();
    level.var_c0a905a3[type] = var_61cc2b88;
    var_61cc2b88.startfx = var_8ec206e7.start_effect;
    var_61cc2b88.endfx = var_8ec206e7.end_effect;
    var_61cc2b88.loopfx = var_8ec206e7.loop_effect;
    var_61cc2b88.startsound = var_8ec206e7.var_81fbbca7;
    var_61cc2b88.endsound = var_8ec206e7.var_6d312da7;
    var_61cc2b88.loopsound = var_8ec206e7.var_45f15dd4;
    var_61cc2b88.startrumble = var_8ec206e7.startrumble;
    var_61cc2b88.endrumble = var_8ec206e7.endrumble;
    var_61cc2b88.var_2c560988 = var_8ec206e7.var_2c560988;
    var_61cc2b88.earthquakescale = var_8ec206e7.earthquakescale;
    var_61cc2b88.earthquakeduration = var_8ec206e7.earthquakeduration;
    var_61cc2b88.effectradius = var_8ec206e7.effectradius;
    var_61cc2b88.aoeid = aoeid;
}

// Namespace zm_aoe/zm_aoe
// Params 7, eflags: 0x4
// Checksum 0x56138b37, Offset: 0x668
// Size: 0x3ec
function private function_9991b86c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (!isdefined(self.aoeid)) {
        return;
    }
    player = function_f97e7787(localclientnum);
    aoeorigin = self.origin;
    distsq = distancesquared(player.origin, aoeorigin);
    var_61cc2b88 = function_dd7e9c0d(self.aoeid);
    if (!isdefined(var_61cc2b88)) {
        return;
    }
    if (newval == 1) {
        if (isdefined(var_61cc2b88.startfx)) {
            playfx(localclientnum, var_61cc2b88.startfx, self.origin, (0, 0, 1));
        }
        if (isdefined(var_61cc2b88.startsound)) {
            playsound(localclientnum, var_61cc2b88.startsound, self.origin);
        }
        if (isdefined(var_61cc2b88.effectradius) && distsq <= var_61cc2b88.effectradius * var_61cc2b88.effectradius) {
            if (isdefined(var_61cc2b88.earthquakescale)) {
                earthquake(localclientnum, var_61cc2b88.earthquakescale, var_61cc2b88.earthquakeduration, self.origin, var_61cc2b88.effectradius);
            }
            if (isdefined(var_61cc2b88.startrumble)) {
                function_d2913e3e(localclientnum, var_61cc2b88.startrumble);
            }
        }
        return;
    }
    if (newval == 2) {
        if (isdefined(var_61cc2b88.loopfx)) {
            self.aoefx = playfx(localclientnum, var_61cc2b88.loopfx, self.origin, (0, 0, 1));
        }
        if (isdefined(var_61cc2b88.loopsound)) {
            self.var_dccfe67 = playsound(localclientnum, var_61cc2b88.loopsound, self.origin);
        }
        return;
    }
    if (newval == 3) {
        if (isdefined(self.aoefx)) {
            stopfx(localclientnum, self.aoefx);
        }
        if (isdefined(self.var_dccfe67)) {
            stopsound(self.var_dccfe67);
        }
        if (isdefined(var_61cc2b88.endfx)) {
            playfx(localclientnum, var_61cc2b88.endfx, self.origin, (0, 0, 1));
        }
        if (isdefined(var_61cc2b88.endsound)) {
            playsound(localclientnum, var_61cc2b88.endsound, self.origin);
        }
        if (isdefined(var_61cc2b88.effectradius) && distsq <= var_61cc2b88.effectradius * var_61cc2b88.effectradius) {
            if (isdefined(var_61cc2b88.startrumble)) {
                function_d2913e3e(localclientnum, var_61cc2b88.endrumble);
            }
        }
    }
}

// Namespace zm_aoe/zm_aoe
// Params 7, eflags: 0x4
// Checksum 0xd7f1cd1c, Offset: 0xa60
// Size: 0x4a
function private function_3ccca06a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.aoeid = newval;
}

