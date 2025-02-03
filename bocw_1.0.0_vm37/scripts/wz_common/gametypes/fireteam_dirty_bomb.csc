#using script_2b1dbe0f618068f7;
#using script_3d0f36632dad12df;
#using script_6741a9edbcf6c25e;
#using script_680dddbda86931fa;
#using script_7222862da5baa189;
#using script_72587ba89a212e22;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\struct;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;

#namespace fireteam_dirty_bomb;

// Namespace fireteam_dirty_bomb/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x5b85afbe, Offset: 0x340
// Size: 0x55c
function event_handler[gametype_init] main(*eventstruct) {
    if (util::get_game_type() != "fireteam_dirty_bomb") {
        return;
    }
    setdvar(#"cg_aggressivecullradius", 100);
    setdvar(#"hash_53f625ed150e7700", 12000);
    setdvar(#"hash_394141aabb847427", 2000);
    setdvar(#"hash_72e6bad547b219c4", 800);
    namespace_2938acdc::init();
    dirtybomb_usebar::register();
    clientfield::register("toplayer", "using_bomb", 1, 2, "int", &function_18272d54, 0, 0);
    clientfield::register_clientuimodel("hudItems.uraniumCarryCount", #"hud_items", #"hash_556b3df8ae964e7c", 1, 4, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.uraniumMaxCarry", #"hud_items", #"hash_1879fbcae78c5417", 1, 4, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.uraniumFullCarry", #"hud_items", #"hash_451ab3abde68434a", 1, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "ftdb_inZone", 1, 1, "int", &function_c76638c, 0, 1);
    clientfield::register("allplayers", "carryingUranium", 1, 1, "int", &function_46afac0, 0, 1);
    clientfield::register("scriptmover", "ftdb_zoneCircle", 1, 3, "int", &function_f4d234f9, 0, 0);
    clientfield::function_5b7d846d("hud_items_dirty_bomb.bomb_respawn_disabled", #"hash_1115137708f64303", #"hash_611630c939ad1b67", 1, 1, "int", undefined, 0, 0);
    level.var_b637a0c0 = &function_e99f251a;
    level.var_75f7e612 = &function_218c0417;
    level.var_977ee0c2 = &function_a2807fc5;
    level.var_d91da973 = 1;
    level.dirtybombs = struct::get_array("fireteam_dirty_bomb", "variantname");
    if (!isdefined(level.var_cfdf3928)) {
        level.var_99266dd4 = new class_c6c0e94();
        [[ level.var_99266dd4 ]]->initialize("radiation_compass", 2, 0.016);
    }
    namespace_681edb36::function_dd83b835();
    level.circleradius = 800;
    level.var_cd139dc0 = max(isdefined(getgametypesetting(#"hash_7f837b709840950")) ? getgametypesetting(#"hash_7f837b709840950") : 1, 1) * 100;
    level.var_60693fca = (isdefined(getgametypesetting(#"hash_37aefeabeef0ec6c")) ? getgametypesetting(#"hash_37aefeabeef0ec6c") : 0) * 100;
    level.var_2200e558 = [];
    level.var_e7fd1b8f = [];
    level.var_53b9c763 = [];
    callback::on_localclient_connect(&on_localclient_connect);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xbfae36f2, Offset: 0x8a8
// Size: 0x94
function on_localclient_connect(localclientnum) {
    var_2612e01d = function_1df4c3b0(localclientnum, #"hash_950d3dccba39e08");
    var_1e885680 = getuimodel(var_2612e01d, "count");
    setuimodelvalue(var_1e885680, 4);
    level thread function_bb2f717e(localclientnum);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x2dd81d5c, Offset: 0x948
// Size: 0x2e6
function private function_bb2f717e(localclientnum) {
    self endon(#"shutdown");
    var_61efd7d9 = [];
    for (index = 0; index < 5; index++) {
        model = spawn(localclientnum, (0, 0, 0), "script_model");
        model setmodel(#"tag_origin");
        model hide();
        model notsolid();
        var_61efd7d9[var_61efd7d9.size] = model;
    }
    while (true) {
        if (!isdefined(level.item_spawn_stashes)) {
            wait 1;
            continue;
        }
        draworigin = getcamposbylocalclientnum(localclientnum);
        containers = arraysortclosest(level.item_spawn_stashes, draworigin, 5, 0, 1500);
        var_7dcc7dd4 = [];
        for (index = 0; index < containers.size; index++) {
            if (!function_8a8a409b(containers[index])) {
                continue;
            }
            if (function_ffdbe8c2(containers[index]) != 2) {
                var_7dcc7dd4[var_7dcc7dd4.size] = containers[index];
            }
        }
        containers = var_7dcc7dd4;
        for (index = 0; index < containers.size; index++) {
            var_61efd7d9[index].origin = containers[index].origin;
            if (isdefined(var_61efd7d9[index].var_95f008e)) {
                continue;
            }
            var_61efd7d9[index].var_95f008e = var_61efd7d9[index] playloopsound("amb_dirtybomb_container_amb");
            var_61efd7d9[index] show();
        }
        for (index = containers.size; index < 5; index++) {
            if (!isdefined(var_61efd7d9[index].var_95f008e)) {
                continue;
            }
            var_61efd7d9[index] stoploopsound(var_61efd7d9[index].var_95f008e);
            var_61efd7d9[index].var_95f008e = undefined;
            var_61efd7d9[index] hide();
        }
        wait 1;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x4
// Checksum 0x97ec96c3, Offset: 0xc38
// Size: 0x60
function private function_e99f251a(*localclientnum, itementry) {
    if (itementry.itemtype == #"generic") {
        return false;
    } else if (itementry.itemtype == #"armor_shard") {
        return false;
    }
    return true;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x4
// Checksum 0x51a42d4f, Offset: 0xca0
// Size: 0xd6
function private function_218c0417(*localclientnum, itementry) {
    if (itementry.itemtype == #"generic") {
        var_e3483afe = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
        if (var_e3483afe >= self clientfield::get_player_uimodel("hudItems.uraniumMaxCarry")) {
            return false;
        }
    } else if (itementry.itemtype == #"armor_shard") {
        currentcount = self clientfield::get_player_uimodel("hudItems.armorPlateCount");
        return (currentcount < 5);
    }
    return true;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x4
// Checksum 0xe61630b9, Offset: 0xd80
// Size: 0x12a
function private function_a2807fc5(localclientnum, itementry) {
    if (itementry.itemtype == #"scorestreak") {
        weapons = self getweaponslist();
        foreach (weapon in weapons) {
            var_16f12c31 = item_world_util::function_3531b9ba(weapon.name);
            if (!isdefined(var_16f12c31)) {
                continue;
            }
            hasammo = self getweaponammostock(localclientnum, weapon) > 0;
            if (hasammo) {
                return true;
            }
        }
        return false;
    }
    return false;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 7, eflags: 0x4
// Checksum 0xbcaf6e03, Offset: 0xeb8
// Size: 0x13e
function private function_18272d54(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump > 0) {
        if (bwastimejump == 1) {
            self.var_a1aa992c = function_604c9983(fieldname, "fly_uranium_deposit_lp");
        } else if (bwastimejump == 2) {
            self.var_53f712e3 = function_604c9983(fieldname, "fly_uranium_priming_lp");
        }
        self thread function_6e9e7ead(fieldname);
        return;
    }
    if (isdefined(self.var_a1aa992c)) {
        function_d48752e(fieldname, self.var_a1aa992c);
        self.var_a1aa992c = undefined;
    }
    if (isdefined(self.var_53f712e3)) {
        function_d48752e(fieldname, self.var_53f712e3);
        self.var_53f712e3 = undefined;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 7, eflags: 0x4
// Checksum 0x6abf89b6, Offset: 0x1000
// Size: 0x290
function private function_c76638c(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    level.var_2200e558[fieldname] = bwastimejump;
    ambientroom = "";
    foreach (val in level.var_2200e558) {
        if (val > 0) {
            ambientroom = "wz_radiation";
            break;
        }
    }
    if (function_52a9d718() != ambientroom) {
        forceambientroom(ambientroom);
    }
    if (bwastimejump) {
        while (isdefined(self) && !self hasdobj(fieldname)) {
            waitframe(1);
        }
        if (!isdefined(self)) {
            return;
        }
        if (squad_spawn::function_21b773d5(fieldname)) {
            return;
        }
        if (!isarray(level.var_e7fd1b8f[fieldname])) {
            level.var_e7fd1b8f[fieldname] = playtagfxset(fieldname, "tagfx9_camfx_gametype_dirtybomb_ash", self);
        }
        return;
    }
    if (isarray(level.var_e7fd1b8f[fieldname])) {
        foreach (fx in level.var_e7fd1b8f[fieldname]) {
            stopfx(fieldname, fx);
        }
        level.var_e7fd1b8f[fieldname] = undefined;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xde764093, Offset: 0x1298
// Size: 0xc6
function private function_6e9e7ead(localclientnum) {
    if (is_true(self.var_16778c9b)) {
        return;
    }
    self.var_16778c9b = 1;
    self waittill(#"death");
    self.var_16778c9b = 0;
    if (isdefined(self.var_a1aa992c)) {
        function_d48752e(localclientnum, self.var_a1aa992c);
        self.var_a1aa992c = undefined;
    }
    if (isdefined(self.var_53f712e3)) {
        function_d48752e(localclientnum, self.var_53f712e3);
        self.var_53f712e3 = undefined;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 7, eflags: 0x4
// Checksum 0x75527e96, Offset: 0x1368
// Size: 0xde
function private function_46afac0(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        localplayer = getlocalplayers()[fieldname];
        if (self.team != localplayer.team) {
            self.var_1ae360e = self playloopsound("fly_uranium_carry_3p");
        }
        return;
    }
    if (isdefined(self.var_1ae360e)) {
        self stoploopsound(self.var_1ae360e);
        self.var_1ae360e = undefined;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 7, eflags: 0x4
// Checksum 0x74d81b98, Offset: 0x1450
// Size: 0x26c
function private function_f4d234f9(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self notify(#"hash_41a7922ed68f0877");
    if (bwastimejump == 3) {
        compassicon = "ui_icon_minimap_radiation_intensity_3";
        self setcompassicon(compassicon);
        self function_811196d1(0);
        self function_95bc465d(1);
        self function_60212003(0);
        self function_5e00861(level.var_60693fca);
        self thread function_9a8b2c86();
        level thread function_81784679(self, fieldname);
        return;
    }
    if (bwastimejump == 4) {
        self function_1cfa2520(fieldname);
        return;
    }
    if (bwastimejump > 0) {
        self function_6856257d(fieldname);
        compassicon = "ui_icon_minimap_radiation_cloud";
        self setcompassicon(compassicon);
        self function_811196d1(0);
        self function_95bc465d(1);
        self function_60212003(0);
        self function_ce541a6(1);
        if (bwastimejump == 1) {
            self thread function_1ef0dbb2();
        } else if (bwastimejump == 2) {
            self thread function_88008fc3();
        }
        level thread function_81784679(self, fieldname);
        return;
    }
    self function_811196d1(1);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xa1c5240b, Offset: 0x16c8
// Size: 0x74
function private function_6856257d(localclientnum) {
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.zonefx)) {
        return;
    }
    self.zonefx = playfx(localclientnum, "wz/fx9_dirtybomb_radiation_zone", self.origin + (0, 0, 80));
    level.var_53b9c763[self.zonefx] = self;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x4db8df43, Offset: 0x1748
// Size: 0x7e
function private function_1cfa2520(localclientnum) {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.zonefx)) {
        return;
    }
    level.var_53b9c763[self.zonefx] = undefined;
    arrayremovevalue(level.var_53b9c763, undefined);
    stopfx(localclientnum, self.zonefx);
    self.zonefx = undefined;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x942801aa, Offset: 0x17d0
// Size: 0x148
function private function_1ef0dbb2() {
    self endon(#"death", #"hash_41a7922ed68f0877");
    while (isdefined(self) && isdefined(self.scale)) {
        if (!isdefined(level.circleradius) || !(isint(level.circleradius) || isfloat(level.circleradius))) {
            waitframe(1);
            continue;
        }
        if (!isdefined(self.scale) || !(isint(self.scale) || isfloat(self.scale))) {
            waitframe(1);
            continue;
        }
        compassscale = level.circleradius * self.scale * 3;
        self function_5e00861(compassscale, 1);
        [[ level.var_99266dd4 ]]->waitinqueue(self);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0xf9d651e5, Offset: 0x1920
// Size: 0x90
function private function_88008fc3() {
    self endon(#"death", #"hash_41a7922ed68f0877");
    while (isdefined(self.scale)) {
        compassscale = level.var_cd139dc0 * self.scale * 3;
        self function_5e00861(compassscale, 1);
        [[ level.var_99266dd4 ]]->waitinqueue(self);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0xaa6e5385, Offset: 0x19b8
// Size: 0xa8
function private function_9a8b2c86() {
    self endon(#"death", #"hash_41a7922ed68f0877");
    maxscale = level.var_60693fca * 2;
    scale = maxscale - 200;
    while (true) {
        scale += 100;
        if (scale >= maxscale) {
            scale = 100;
        }
        self function_5e00861(scale, 1);
        wait 0.05;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x4
// Checksum 0xd46d255c, Offset: 0x1a68
// Size: 0x5c
function private function_81784679(ent, localclientnum) {
    ent waittill(#"death");
    ent function_811196d1(1);
    ent function_1cfa2520(localclientnum);
}

