#using script_2b1dbe0f618068f7;
#using script_680dddbda86931fa;
#using script_7222862da5baa189;
#using script_72587ba89a212e22;
#using script_78825cbb1ab9f493;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\struct;

#namespace fireteam_dirty_bomb;

// Namespace fireteam_dirty_bomb/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xd5b66549, Offset: 0x220
// Size: 0x314
function event_handler[gametype_init] main(*eventstruct) {
    namespace_17baa64d::init();
    dirtybomb_usebar::register();
    clientfield::register("toplayer", "using_bomb", 1, 2, "int", &function_18272d54, 0, 0);
    clientfield::register_clientuimodel("hudItems.uraniumCarryCount", #"hash_6f4b11a0bee9b73d", #"hash_556b3df8ae964e7c", 1, 4, "int", undefined, 0, 0);
    clientfield::register("toplayer", "ftdb_inZone", 1, 1, "int", &function_c76638c, 0, 0);
    clientfield::register("allplayers", "carryingUranium", 1, 1, "int", &function_46afac0, 0, 1);
    clientfield::register("scriptmover", "ftdb_zoneCircle", 1, 2, "int", &function_f4d234f9, 0, 0);
    level.var_b637a0c0 = &function_e99f251a;
    level.var_75f7e612 = &function_218c0417;
    level.var_977ee0c2 = &function_a2807fc5;
    level.var_d91da973 = 1;
    level.dirtybombs = struct::get_array("fireteam_dirty_bomb", "variantname");
    namespace_681edb36::function_dd83b835();
    level.circleradius = 800;
    level.var_cd139dc0 = max(isdefined(getgametypesetting(#"hash_7f837b709840950")) ? getgametypesetting(#"hash_7f837b709840950") : 1, 1);
    level.var_60693fca = (isdefined(getgametypesetting(#"hash_37aefeabeef0ec6c")) ? getgametypesetting(#"hash_37aefeabeef0ec6c") : 0) * 100;
    level.var_2200e558 = [];
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x4
// Checksum 0x96ec4e43, Offset: 0x540
// Size: 0x60
function private function_e99f251a(*localclientnum, var_a6762160) {
    if (var_a6762160.itemtype == #"generic") {
        return false;
    } else if (var_a6762160.itemtype == #"armor_shard") {
        return false;
    }
    return true;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x4
// Checksum 0x657be3b2, Offset: 0x5a8
// Size: 0xbe
function private function_218c0417(*localclientnum, var_a6762160) {
    if (var_a6762160.itemtype == #"generic") {
        var_e3483afe = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
        if (var_e3483afe >= 5) {
            return false;
        }
    } else if (var_a6762160.itemtype == #"armor_shard") {
        currentcount = self clientfield::get_player_uimodel("hudItems.armorPlateCount");
        return (currentcount < 5);
    }
    return true;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x4
// Checksum 0xd1b5c009, Offset: 0x670
// Size: 0x12a
function private function_a2807fc5(localclientnum, var_a6762160) {
    if (var_a6762160.itemtype == #"scorestreak") {
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
// Checksum 0x63d3caff, Offset: 0x7a8
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
// Checksum 0x5731923d, Offset: 0x8f0
// Size: 0x11c
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
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xb331d109, Offset: 0xa18
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
// Checksum 0x4cfe6559, Offset: 0xae8
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
// Checksum 0x4c0807d4, Offset: 0xbd0
// Size: 0x27c
function private function_f4d234f9(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self notify(#"hash_41a7922ed68f0877");
    if (bwastimejump == 3) {
        compassicon = "ui_icon_minimap_radiation_intensity_3";
        self setcompassicon(compassicon);
        self function_811196d1(0);
        self function_95bc465d(1);
        self function_60212003(0);
        self function_5e00861(level.var_60693fca);
        self thread function_9a8b2c86();
        level thread function_927d81fb(self);
        return;
    }
    if (bwastimejump > 0) {
        compassicon = "ui_icon_minimap_radiation_cloud";
        self setcompassicon(compassicon);
        self function_811196d1(0);
        self function_95bc465d(1);
        self function_60212003(0);
        compassscale = 1;
        if (bwastimejump == 1) {
            compassscale = level.circleradius * self.scale * 2;
            self thread updatecircle();
        } else if (bwastimejump == 2) {
            compassscale = level.var_cd139dc0 * self.scale * 2;
            self thread function_88008fc3();
        }
        self function_5e00861(compassscale, 1);
        level thread function_927d81fb(self);
        return;
    }
    self function_811196d1(1);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0xfecce20, Offset: 0xe58
// Size: 0x136
function private updatecircle() {
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
        compassscale = level.circleradius * self.scale * 2;
        self function_5e00861(compassscale, 1);
        waitframe(1);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x7de55b95, Offset: 0xf98
// Size: 0x7e
function private function_88008fc3() {
    self endon(#"death", #"hash_41a7922ed68f0877");
    while (isdefined(self.scale)) {
        compassscale = level.var_cd139dc0 * self.scale * 2;
        self function_5e00861(compassscale, 1);
        waitframe(1);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0xff1dcf26, Offset: 0x1020
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
// Params 1, eflags: 0x4
// Checksum 0xb25e9e4e, Offset: 0x10d0
// Size: 0x3c
function private function_927d81fb(ent) {
    ent waittill(#"death");
    ent function_811196d1(1);
}

