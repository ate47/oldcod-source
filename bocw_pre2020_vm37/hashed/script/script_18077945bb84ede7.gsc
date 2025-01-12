#using script_113dd7f0ea2a1d4f;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace sr_scrap;

// Namespace sr_scrap/sr_scrap
// Params 0, eflags: 0x1 linked
// Checksum 0x93abcd87, Offset: 0xc8
// Size: 0x5c
function init() {
    callback::on_connect(&on_player_connect);
    callback::on_item_pickup(&on_item_pickup);
    /#
        level thread add_devgui();
    #/
}

// Namespace sr_scrap/sr_scrap
// Params 0, eflags: 0x1 linked
// Checksum 0x20e745b9, Offset: 0x130
// Size: 0xe
function on_player_connect() {
    self.var_595a11bc = 0;
}

// Namespace sr_scrap/sr_scrap
// Params 1, eflags: 0x1 linked
// Checksum 0xde269aae, Offset: 0x148
// Size: 0xb4
function on_item_pickup(s_params) {
    var_a6762160 = s_params.item.var_a6762160;
    if (var_a6762160.itemtype === #"survival_scrap") {
        if (isplayer(self)) {
            e_player = self;
        } else {
            e_player = s_params.player;
        }
        var_595a11bc = 50 * var_a6762160.amount;
        e_player function_afab250a(var_595a11bc);
    }
}

// Namespace sr_scrap/sr_scrap
// Params 0, eflags: 0x1 linked
// Checksum 0x902607db, Offset: 0x208
// Size: 0xa
function function_6f3fd157() {
    return self.var_595a11bc;
}

// Namespace sr_scrap/sr_scrap
// Params 1, eflags: 0x1 linked
// Checksum 0x23212315, Offset: 0x220
// Size: 0x5c
function function_afab250a(var_595a11bc) {
    if (isdefined(self.var_595a11bc)) {
        self.var_595a11bc = int(self.var_595a11bc + var_595a11bc);
        self function_2128756d(var_595a11bc);
    }
}

// Namespace sr_scrap/sr_scrap
// Params 1, eflags: 0x1 linked
// Checksum 0x70111a10, Offset: 0x288
// Size: 0x64
function function_3610299b(var_595a11bc) {
    var_595a11bc = self.var_595a11bc - var_595a11bc;
    var_595a11bc = max(var_595a11bc, 0);
    self.var_595a11bc = int(var_595a11bc);
    self function_b802c7fc();
}

// Namespace sr_scrap/sr_scrap
// Params 1, eflags: 0x1 linked
// Checksum 0xb820c33, Offset: 0x2f8
// Size: 0x146
function function_30398155(var_595a11bc) {
    var_f791b58e = int(var_595a11bc);
    switch (var_f791b58e) {
    case 10:
        id = 1;
        break;
    case 20:
        id = 2;
        break;
    case 50:
        id = 3;
        break;
    case 100:
        id = 4;
        break;
    case 250:
        id = 5;
        break;
    case 500:
        id = 6;
        break;
    case 1000:
        id = 7;
        break;
    case 5000:
        id = 8;
        break;
    default:
        id = 0;
        break;
    }
    return id;
}

// Namespace sr_scrap/sr_scrap
// Params 1, eflags: 0x1 linked
// Checksum 0x4f99d6ae, Offset: 0x448
// Size: 0x152
function function_2128756d(var_595a11bc) {
    self notify("4cf2a9ab49e81531");
    self endon("4cf2a9ab49e81531");
    self endon(#"disconnect");
    if (!isdefined(level.var_31028c5d)) {
        return;
    }
    self function_b802c7fc();
    if (!isdefined(self.var_74c51508)) {
        self.var_74c51508 = 0;
    }
    self.var_74c51508 = int(self.var_74c51508 + var_595a11bc);
    var_bc7a2972 = function_30398155(var_595a11bc);
    level.var_31028c5d prototype_hud::function_50510f94(self, var_bc7a2972);
    if (!is_true(self.var_df5f7742)) {
        level.var_31028c5d prototype_hud::function_9c9e8623(self, 1);
        self.var_df5f7742 = 1;
    }
    wait 1;
    level.var_31028c5d prototype_hud::function_9c9e8623(self, 0);
    self.var_74c51508 = 0;
    self.var_df5f7742 = 0;
}

// Namespace sr_scrap/sr_scrap
// Params 1, eflags: 0x1 linked
// Checksum 0x38fa6697, Offset: 0x5a8
// Size: 0x54
function function_c29a8aa1(cost) {
    var_88daa75e = self function_6f3fd157();
    var_ee2422c5 = var_88daa75e - cost;
    if (var_ee2422c5 >= 0) {
        return true;
    }
    return false;
}

// Namespace sr_scrap/sr_scrap
// Params 0, eflags: 0x1 linked
// Checksum 0x51832231, Offset: 0x608
// Size: 0x6c
function function_b802c7fc() {
    if (!isalive(self)) {
        return;
    }
    self function_fd1eb350();
    self clientfield::set_player_uimodel("hudItems.scrap", isdefined(self.var_595a11bc) ? self.var_595a11bc : 0);
}

// Namespace sr_scrap/sr_scrap
// Params 0, eflags: 0x1 linked
// Checksum 0x73cbfe55, Offset: 0x680
// Size: 0x8c
function function_fd1eb350() {
    self notify("40d4bce47f17186a");
    self endon("40d4bce47f17186a");
    self endon(#"death");
    var_863f2651 = level.var_31028c5d prototype_hud::is_open(self);
    if (!is_true(var_863f2651)) {
        level.var_31028c5d prototype_hud::open(self, 0);
    }
}

/#

    // Namespace sr_scrap/sr_scrap
    // Params 0, eflags: 0x0
    // Checksum 0xc5804025, Offset: 0x718
    // Size: 0x5c
    function add_devgui() {
        util::waittill_can_add_debug_command();
        level thread function_27fca01f();
        cmd = "<dev string:x38>";
        adddebugcommand(cmd);
    }

    // Namespace sr_scrap/sr_scrap
    // Params 0, eflags: 0x0
    // Checksum 0x5843a243, Offset: 0x780
    // Size: 0xa8
    function function_27fca01f() {
        while (true) {
            if (getdvarint(#"hash_5499eefe1f37aa95", 0)) {
                setdvar(#"hash_5499eefe1f37aa95", 0);
                array::thread_all(function_a1ef346b(), &function_afab250a, 5000);
            }
            wait 0.1;
        }
    }

#/
