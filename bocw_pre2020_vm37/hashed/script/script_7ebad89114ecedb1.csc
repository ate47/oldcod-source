#using script_2d142c6d365a90a3;
#using script_713f934fea43e1fc;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;

#namespace namespace_6615ea91;

// Namespace namespace_6615ea91/namespace_6615ea91
// Params 0, eflags: 0x6
// Checksum 0xdafd57e2, Offset: 0x1c0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_53f69893eea352cb", &function_70a657d8, undefined, undefined, #"radiation");
}

// Namespace namespace_6615ea91/namespace_6615ea91
// Params 0, eflags: 0x5 linked
// Checksum 0x463a36b3, Offset: 0x210
// Size: 0x194
function private function_70a657d8() {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    level.var_221dcf9 = [];
    clientfield::register_clientuimodel("hudItems.incursion.radiationDamage", #"hash_4f154d6820b7e836", [#"radiationdamage"], 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.incursion.radiationProtection", #"hash_4f154d6820b7e836", [#"hash_6a2df23dda50fd53"], 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.incursion.radiationHealth", #"hash_4f154d6820b7e836", [#"hash_1ea71fd40691443e"], 1, 5, "float", undefined, 0, 0);
    clientfield::register("toplayer", "radiation", 1, 10, "int", &radiation, 0, 0);
    callback::on_localclient_connect(&function_5cb7f849);
}

// Namespace namespace_6615ea91/namespace_6615ea91
// Params 3, eflags: 0x5 linked
// Checksum 0xd2b3a5ee, Offset: 0x3b0
// Size: 0x29c
function private function_9cc6a162(localclientnum, sickness, var_46bdb64c) {
    assert(isplayer(self));
    assert(ishash(sickness) || isstring(sickness));
    assert(isdefined(var_46bdb64c));
    var_5e7fb773 = function_1df4c3b0(localclientnum, #"hash_4f154d6820b7e836");
    var_9ad901c3 = createuimodel(var_5e7fb773, "sickness");
    var_a60a2640 = self.radiation.sickness.size;
    itemuimodel = createuimodel(var_9ad901c3, "item" + var_a60a2640);
    var_1c254c7e = createuimodel(itemuimodel, "endStartFraction");
    setuimodelvalue(var_1c254c7e, 1);
    var_43df2991 = createuimodel(itemuimodel, "info");
    setuimodelvalue(var_43df2991, var_46bdb64c.var_4bd5611f);
    var_8e2253bd = {};
    var_8e2253bd.var_a2c3987d = sickness;
    var_8e2253bd.var_3a94cbe6 = gettime();
    var_8e2253bd.var_cb9fc1f3 = gettime() + var_46bdb64c.duration;
    var_8e2253bd.var_4bd5611f = var_46bdb64c.var_4bd5611f;
    var_8e2253bd.itemuimodel = itemuimodel;
    self.radiation.sickness[self.radiation.sickness.size] = var_8e2253bd;
    var_a25538fb = createuimodel(var_9ad901c3, "count");
    setuimodelvalue(var_a25538fb, self.radiation.sickness.size);
}

// Namespace namespace_6615ea91/namespace_6615ea91
// Params 1, eflags: 0x5 linked
// Checksum 0x31b0401, Offset: 0x658
// Size: 0xd4
function private function_e352066c(localclientnum) {
    assert(isplayer(self));
    var_5e7fb773 = function_1df4c3b0(localclientnum, #"hash_4f154d6820b7e836");
    var_9ad901c3 = createuimodel(var_5e7fb773, "sickness");
    self.radiation.sickness = [];
    var_a25538fb = createuimodel(var_9ad901c3, "count");
    setuimodelvalue(var_a25538fb, 0);
}

// Namespace namespace_6615ea91/namespace_6615ea91
// Params 3, eflags: 0x5 linked
// Checksum 0xe0f1d047, Offset: 0x738
// Size: 0x114
function private function_b200b0ea(*localclientnum, sickness, var_46bdb64c) {
    assert(isplayer(self));
    assert(ishash(sickness) || isstring(sickness));
    assert(isdefined(var_46bdb64c));
    for (index = 0; index < self.radiation.sickness.size; index++) {
        if (self.radiation.sickness[index].var_a2c3987d == sickness) {
            arrayremoveindex(self.radiation.sickness, index, 0);
        }
    }
}

// Namespace namespace_6615ea91/namespace_6615ea91
// Params 1, eflags: 0x5 linked
// Checksum 0x2fd3117c, Offset: 0x858
// Size: 0x1cc
function private function_162db916(localclientnum) {
    if (!isdefined(self) || !isdefined(self.radiation) || !isdefined(self.radiation.sickness)) {
        return;
    }
    var_5e7fb773 = function_1df4c3b0(localclientnum, #"hash_4f154d6820b7e836");
    var_9ad901c3 = createuimodel(var_5e7fb773, "sickness");
    for (var_a60a2640 = 0; var_a60a2640 < self.radiation.sickness.size; var_a60a2640++) {
        var_8e2253bd = self.radiation.sickness[var_a60a2640];
        itemuimodel = createuimodel(var_9ad901c3, "item" + var_a60a2640);
        var_43df2991 = createuimodel(itemuimodel, "info");
        setuimodelvalue(var_43df2991, var_8e2253bd.var_4bd5611f);
        var_8e2253bd.itemuimodel = itemuimodel;
    }
    var_a25538fb = createuimodel(var_9ad901c3, "count");
    setuimodelvalue(var_a25538fb, self.radiation.sickness.size);
    function_5cb7f849(localclientnum);
}

// Namespace namespace_6615ea91/namespace_6615ea91
// Params 7, eflags: 0x5 linked
// Checksum 0xbdeb4943, Offset: 0xa30
// Size: 0x5a4
function private radiation(localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    if (!isdefined(self.radiation)) {
        radiation::function_f45ee99d(binitialsnap);
        function_162db916(binitialsnap);
    }
    var_5e7fb773 = function_1df4c3b0(binitialsnap, #"hash_4f154d6820b7e836");
    var_11a4b47f = createuimodel(var_5e7fb773, "radiationLevel");
    var_66bba724 = bwastimejump & 8 - 1;
    radiationlevel = var_66bba724;
    if (radiationlevel < 0) {
        assert(0);
        radiationlevel = 0;
    }
    setuimodelvalue(var_11a4b47f, var_66bba724);
    var_6efc5d3e = 0;
    if (self.radiation.var_32adf91d != radiationlevel) {
        var_6efc5d3e = 1;
    }
    var_50cd907d = radiationlevel > self.radiation.var_32adf91d;
    self.radiation.var_32adf91d = radiationlevel;
    var_ab5cd23a = fieldname >> 3;
    var_374bf850 = bwastimejump >> 3;
    if (var_6efc5d3e) {
        function_e352066c(binitialsnap);
        if (var_50cd907d) {
            self postfx::playpostfxbundle(#"hash_6f7b55f6e2942122");
        }
        if (radiationlevel == 3) {
            self postfx::playpostfxbundle(#"hash_719edd0aae95bea3");
        } else if (self function_d2cb869e(#"hash_719edd0aae95bea3")) {
            self postfx::stoppostfxbundle(#"hash_719edd0aae95bea3");
        }
        if (is_true(level.var_d91da973)) {
            switch (radiationlevel) {
            case 0:
                function_f80b3e83(binitialsnap);
                break;
            case 1:
                function_f80b3e83(binitialsnap, "evt_radiation_dmg_1");
                break;
            case 2:
                function_f80b3e83(binitialsnap, "evt_radiation_dmg_2");
                break;
            case 3:
                function_f80b3e83(binitialsnap, "evt_radiation_dmg_3");
                break;
            }
        }
    }
    if (var_ab5cd23a == var_374bf850 && !is_true(is_true(level.var_d91da973))) {
        return;
    }
    var_9ad901c3 = createuimodel(var_5e7fb773, "sickness");
    var_7720923c = level.radiation.levels[radiationlevel];
    keys = getarraykeys(var_7720923c.sickness);
    var_8bbfff89 = var_6efc5d3e ? 0 : var_ab5cd23a & ~var_374bf850;
    for (var_a60a2640 = 0; var_8bbfff89 && var_a60a2640 < 7; var_a60a2640++) {
        if (!(var_8bbfff89 & 1 << var_a60a2640)) {
            continue;
        }
        var_63e3e25f = keys[var_a60a2640];
        var_46bdb64c = var_7720923c.sickness[var_63e3e25f];
        function_b200b0ea(binitialsnap, var_63e3e25f, var_46bdb64c);
    }
    if (!var_6efc5d3e && var_8bbfff89) {
        function_162db916(binitialsnap);
    }
    var_82b1c6a8 = var_6efc5d3e ? var_374bf850 : ~var_ab5cd23a & var_374bf850;
    for (var_a60a2640 = 0; var_82b1c6a8 && var_a60a2640 < 7; var_a60a2640++) {
        if (!(var_82b1c6a8 & 1 << var_a60a2640)) {
            continue;
        }
        var_63e3e25f = keys[var_a60a2640];
        if (isdefined(var_63e3e25f)) {
            var_46bdb64c = var_7720923c.sickness[var_63e3e25f];
            function_9cc6a162(binitialsnap, var_63e3e25f, var_46bdb64c);
        }
    }
}

// Namespace namespace_6615ea91/namespace_6615ea91
// Params 2, eflags: 0x5 linked
// Checksum 0x82d65be5, Offset: 0xfe0
// Size: 0x98
function private function_f80b3e83(localclientnum, alias = undefined) {
    var_1155a6d7 = level.var_b0d40a43[localclientnum];
    if (isdefined(var_1155a6d7)) {
        function_d48752e(localclientnum, var_1155a6d7);
        level.var_b0d40a43[localclientnum] = undefined;
    }
    if (isdefined(alias)) {
        level.var_b0d40a43[localclientnum] = function_604c9983(localclientnum, alias);
    }
}

// Namespace namespace_6615ea91/namespace_6615ea91
// Params 1, eflags: 0x5 linked
// Checksum 0xedc53844, Offset: 0x1080
// Size: 0x1a2
function private function_5cb7f849(localclientnum) {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    localplayer = function_5c10bd79(localclientnum);
    while (true) {
        if (!isalive(localplayer)) {
            waitframe(1);
            continue;
        }
        foreach (sickness in localplayer.radiation.sickness) {
            totaltime = sickness.var_cb9fc1f3 - sickness.var_3a94cbe6;
            var_12a91f89 = totaltime;
            if (totaltime > 0) {
                var_12a91f89 = (sickness.var_cb9fc1f3 - gettime()) / (sickness.var_cb9fc1f3 - sickness.var_3a94cbe6);
            }
            var_1c254c7e = createuimodel(sickness.itemuimodel, "endStartFraction");
            setuimodelvalue(var_1c254c7e, max(var_12a91f89, 0));
        }
        waitframe(1);
    }
}

