#using script_39eae6a6b493fe9e;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\trials\zm_trial_disable_bgbs;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace bgb_pack;

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x2
// Checksum 0x6e241111, Offset: 0x238
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"bgb_pack", &__init__, &__main__, undefined);
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x4
// Checksum 0x700afccb, Offset: 0x288
// Size: 0x20e
function private __init__() {
    /#
        function_8465a726();
    #/
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    clientfield::register("clientuimodel", "zmhud.bgb_carousel.global_cooldown", 1, 5, "float");
    for (i = 0; i < 4; i++) {
        clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".state", 1, 2, "int");
        clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".gum_idx", 1, 7, "int");
        clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".cooldown_perc", 1, 5, "float");
        clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".lockdown", 1, 1, "float");
        clientfield::register("clientuimodel", "zmhud.bgb_carousel." + i + ".unavailable", 1, 1, "float");
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x4
// Checksum 0x9b30795a, Offset: 0x4a0
// Size: 0x44
function private __main__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    /#
        level thread setup_devgui();
    #/
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x4
// Checksum 0xefcb2f5d, Offset: 0x4f0
// Size: 0x44
function private on_player_connect() {
    self.var_51e4a372 = [];
    for (x = 0; x < 4; x++) {
        self.var_51e4a372[x] = 0;
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x4
// Checksum 0x3c3e03a9, Offset: 0x540
// Size: 0xb4
function private on_player_spawned() {
    self endon(#"disconnect");
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    if (isbot(self)) {
        return;
    }
    level flagsys::wait_till("start_zombie_round_logic");
    waitframe(1);
    self thread function_b0f7d628();
    self thread function_6966aca2();
    self function_64c575f7(1);
}

// Namespace bgb_pack/zm_bgb_pack
// Params 3, eflags: 0x0
// Checksum 0x55fd8456, Offset: 0x600
// Size: 0xb6
function function_b3d251d5(name, var_cfaa65d8, var_305841af) {
    assert(isdefined(level.bgb[name]), "<dev string:x30>" + name + "<dev string:x59>");
    assert(isdefined(var_cfaa65d8), "<dev string:x70>");
    level.bgb[name].var_cfaa65d8 = var_cfaa65d8;
    level.bgb[name].var_305841af = var_305841af;
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0xe1db7e45, Offset: 0x6c0
// Size: 0x6a
function function_aa090e8(name) {
    assert(isdefined(level.bgb[name]), "<dev string:x30>" + name + "<dev string:x59>");
    level.bgb[name].var_91bd251 = 1;
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0xa3b674e3, Offset: 0x738
// Size: 0x6a
function function_25ede233(name) {
    assert(isdefined(level.bgb[name]), "<dev string:x30>" + name + "<dev string:x59>");
    level.bgb[name].var_add03ca7 = 1;
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0x76ed041b, Offset: 0x7b0
// Size: 0x6a
function function_fe5ee859(name) {
    assert(isdefined(level.bgb[name]), "<dev string:x30>" + name + "<dev string:x59>");
    level.bgb[name].var_59f5ec4 = 1;
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x0
// Checksum 0x9824abbb, Offset: 0x828
// Size: 0x2b0
function function_6966aca2() {
    self endon(#"disconnect");
    self notify(#"hash_67100af32a422470");
    self endon(#"hash_67100af32a422470");
    self.var_40c54861 = 0;
    self.var_845ef18a = 0;
    self.var_13bfa6f6 = 0;
    for (;;) {
        if (function_7d4a1097()) {
            if (self meleebuttonpressed() || self sprintbuttonpressed() || self isinmovemode("ufo", "noclip") || level flagsys::get(#"menu_open")) {
                self.var_90635d4b = 1;
                wait 0.05;
                continue;
            } else if (isdefined(self.var_90635d4b) && self.var_90635d4b) {
                self.var_90635d4b = undefined;
                wait 0.05;
            }
        }
        n_index = 0;
        if (self actionslotonebuttonpressed() && !self function_8fd12cfc(n_index)) {
            self function_458eb29b(n_index);
        }
        n_index = 1;
        if (self actionslotfourbuttonpressed() && !self function_8fd12cfc(n_index)) {
            self function_458eb29b(n_index);
        }
        n_index = 2;
        if (self actionslottwobuttonpressed() && !self function_8fd12cfc(n_index)) {
            self function_458eb29b(n_index);
        }
        n_index = 3;
        if (self actionslotthreebuttonpressed() && !self function_8fd12cfc(n_index)) {
            self function_458eb29b(n_index);
        }
        wait 0.05;
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0xb9c90123, Offset: 0xae0
// Size: 0x54
function function_458eb29b(n_index) {
    if (self function_fbed925d(n_index)) {
        self thread function_61a5ecfd(n_index);
        return;
    }
    self activate_elixir(n_index);
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0x1512e99d, Offset: 0xb40
// Size: 0x2d0
function activate_elixir(n_index) {
    self endon(#"disconnect");
    level endon(#"end_game");
    has_succeeded = 0;
    if (isdefined(level.var_ec8913c8) && level.var_ec8913c8 != n_index) {
        return has_succeeded;
    }
    if (self function_feb6479c(n_index) == 0 && !self zm_utility::is_drinking() && !self laststand::player_is_in_laststand()) {
        has_succeeded = 0;
        str_bgb = self.bgb_pack[n_index];
        if (!isdefined(str_bgb) || str_bgb == "") {
            self thread function_61a5ecfd(n_index);
            return 0;
        }
        if (!self bgb::function_b616fe7a(0, str_bgb)) {
            self thread function_61a5ecfd(n_index);
            return 0;
        }
        self function_e91f026e();
        if (level.bgb[str_bgb].limit_type == "activated") {
            if (isdefined(level.bgb[str_bgb].var_7ea552f4) && level.bgb[str_bgb].var_7ea552f4 || self bgb::function_b616fe7a(1, str_bgb)) {
                has_succeeded = self function_8e5a7297(str_bgb, n_index);
                if (has_succeeded) {
                    self notify(#"hash_27b238d082f65849", str_bgb);
                    self bgb::activation_start();
                    self thread bgb::run_activation_func(str_bgb);
                }
            } else {
                self thread function_61a5ecfd(n_index);
                has_succeeded = 0;
            }
        } else {
            self function_8e5a7297(str_bgb, n_index);
        }
        self.var_845ef18a = 0;
        if (has_succeeded) {
            self notify(#"bgb_activation", str_bgb);
        }
    } else {
        self thread function_61a5ecfd(n_index);
    }
    return has_succeeded;
}

// Namespace bgb_pack/zm_bgb_pack
// Params 2, eflags: 0x0
// Checksum 0x2e2e9a3b, Offset: 0xe18
// Size: 0x108
function function_8e5a7297(str_bgb, n_index) {
    b_succeed = self bgb::bgb_gumball_anim(str_bgb, 0);
    if (b_succeed) {
        if (isdefined(self.bgb_pack[n_index]) && isdefined(level.bgb[self.bgb_pack[n_index]]) && !(isdefined(level.bgb[self.bgb_pack[n_index]].var_add03ca7) && level.bgb[self.bgb_pack[n_index]].var_add03ca7)) {
            self.var_fb99aed++;
        }
        self function_b9f68e70(n_index, 1);
        self thread function_78cec371(n_index);
    }
    return b_succeed;
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0x3fa73735, Offset: 0xf28
// Size: 0x16e
function function_61a5ecfd(n_index) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!(isdefined(self.var_b027ca2f) && self.var_b027ca2f)) {
        self.var_b027ca2f = 1;
        self playlocalsound(#"hash_678b4eee9797e94f");
        switch (n_index) {
        case 0:
            while (self actionslotonebuttonpressed()) {
                waitframe(1);
            }
            break;
        case 1:
            while (self actionslotfourbuttonpressed()) {
                waitframe(1);
            }
            break;
        case 2:
            while (self actionslottwobuttonpressed()) {
                waitframe(1);
            }
            break;
        case 3:
            while (self actionslotthreebuttonpressed()) {
                waitframe(1);
            }
            break;
        }
        self.var_b027ca2f = 0;
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x0
// Checksum 0xa2498ea4, Offset: 0x10a0
// Size: 0x13e
function function_793e3eab() {
    self disableweaponcycling();
    self allowjump(0);
    str_stance = self getstance();
    switch (str_stance) {
    case #"crouch":
        self allowstand(0);
        self allowprone(0);
        break;
    case #"prone":
        self allowstand(0);
        self allowcrouch(0);
        break;
    default:
        self allowcrouch(0);
        self allowprone(0);
        break;
    }
    self.var_13bfa6f6 = 1;
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x0
// Checksum 0x7ba8b928, Offset: 0x11e8
// Size: 0x86
function function_e91f026e() {
    self enableweaponcycling();
    self allowjump(1);
    self allowstand(1);
    self allowcrouch(1);
    self allowprone(1);
    self.var_13bfa6f6 = 0;
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x0
// Checksum 0xfde3dcb5, Offset: 0x1278
// Size: 0xae
function function_8c246e14() {
    self endon(#"disconnect");
    self notify(#"hash_25f0b773a3164732");
    self endon(#"hash_25f0b773a3164732");
    for (;;) {
        if (!self secondaryoffhandbuttonpressed()) {
            wait 0.05;
            continue;
        }
        self.var_845ef18a = 1;
        for (;;) {
            wait 0.05;
            if (!self secondaryoffhandbuttonpressed()) {
                break;
            }
        }
        self.var_845ef18a = 0;
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x0
// Checksum 0xa6ff0566, Offset: 0x1330
// Size: 0xb6
function function_2fb57c76() {
    self endon(#"disconnect");
    self notify(#"hash_2ee12d1cd927db0c");
    self endon(#"hash_2ee12d1cd927db0c");
    self.var_cf57e813 = 0;
    for (;;) {
        if (!self secondaryoffhandbuttonpressed()) {
            wait 0.05;
            continue;
        }
        self.var_cf57e813 = 1;
        for (;;) {
            wait 0.05;
            if (!self secondaryoffhandbuttonpressed()) {
                break;
            }
        }
        self.var_cf57e813 = 0;
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x0
// Checksum 0xb88ed2e9, Offset: 0x13f0
// Size: 0xb6
function function_b1c2cecd() {
    self endon(#"disconnect");
    self notify(#"hash_5f9bde10649db4f9");
    self endon(#"hash_5f9bde10649db4f9");
    self.var_2b9c086 = 0;
    for (;;) {
        if (!self actionslotfourbuttonpressed()) {
            wait 0.05;
            continue;
        }
        self.var_2b9c086 = 1;
        for (;;) {
            wait 0.05;
            if (!self actionslotfourbuttonpressed()) {
                break;
            }
        }
        self.var_2b9c086 = 0;
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x0
// Checksum 0x6610007d, Offset: 0x14b0
// Size: 0xa0
function function_b0f7d628() {
    self endon(#"disconnect");
    self notify(#"hash_5d9f5eee2722843a");
    self endon(#"hash_5d9f5eee2722843a");
    self.var_fb99aed = 0;
    for (;;) {
        level waittill(#"end_of_round");
        self.var_fb99aed = 0;
        if (!zm_trial_disable_bgbs::is_active()) {
            self function_f27f6f96(0);
        }
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0xcac8a436, Offset: 0x1558
// Size: 0x3c
function function_78cec371(n_index) {
    self thread global_cooldown(n_index);
    self thread slot_cooldown(n_index);
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0x89edb47, Offset: 0x15a0
// Size: 0x216
function global_cooldown(n_index) {
    self notify("6ade946bf04f018f");
    self endon("6ade946bf04f018f");
    self endon(#"disconnect");
    self.var_40c54861 = 1;
    self function_95601d64(1, n_index);
    n_cooldown = 30;
    if (self hasperk(#"specialty_mod_cooldown")) {
        n_cooldown *= 0.85;
    }
    switch (zm_custom::function_5638f689(#"zmelixirscooldown")) {
    case 1:
    default:
        break;
    case 2:
        n_cooldown = floor(n_cooldown / 2);
        break;
    case 0:
        n_cooldown *= 2;
        break;
    }
    /#
    #/
    result = self waittilltimeout(n_cooldown, #"hash_738988561a113fac");
    /#
        if (result._notify === "<dev string:xb5>") {
            var_566eb49d = 1;
        }
    #/
    self function_95601d64(0, undefined, var_566eb49d);
    if (self.var_fb99aed >= 3) {
        self function_f27f6f96(1);
    } else {
        self playlocalsound(#"hash_2a9d100a5cbc7dbe");
    }
    self.var_40c54861 = 0;
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0xf17e84df, Offset: 0x17c0
// Size: 0xbc
function function_8fd12cfc(n_index) {
    if (self.var_40c54861 && isdefined(self.bgb_pack[n_index]) && isdefined(level.bgb[self.bgb_pack[n_index]]) && !(isdefined(level.bgb[self.bgb_pack[n_index]].var_59f5ec4) && level.bgb[self.bgb_pack[n_index]].var_59f5ec4)) {
        self thread function_61a5ecfd(n_index);
        return true;
    }
    return false;
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0x58a1329e, Offset: 0x1888
// Size: 0x3a4
function slot_cooldown(n_index) {
    self endon(#"disconnect");
    str_elixir = self.bgb_pack[n_index];
    self waittill("bgb_update_take_" + str_elixir);
    self function_b9f68e70(n_index, 2);
    self function_76271859(n_index, 1);
    function_c49a8fc5(n_index, 0);
    n_rarity = level.bgb[str_elixir].rarity;
    switch (n_rarity) {
    case 2:
        n_cooldown = 300;
        break;
    case 3:
        n_cooldown = 600;
        break;
    case 4:
        n_cooldown = 900;
        break;
    case 5:
        n_cooldown = 1200;
        break;
    case 6:
        n_cooldown = 1500;
        break;
    default:
        n_cooldown = 180;
        break;
    }
    switch (zm_custom::function_5638f689(#"zmelixirscooldown")) {
    case 1:
    default:
        break;
    case 2:
        n_cooldown = floor(n_cooldown / 2);
        break;
    case 0:
        n_cooldown *= 2;
        break;
    }
    if (self hasperk(#"specialty_mod_cooldown")) {
        n_cooldown *= 0.85;
    }
    if (isdefined(level.bgb[str_elixir].var_cfaa65d8)) {
        n_cooldown = level.bgb[str_elixir].var_cfaa65d8;
    }
    /#
    #/
    self thread function_16ba92de(n_index, n_cooldown);
    wait 0.05;
    result = self waittilltimeout(n_cooldown, #"hash_738988561a113fac");
    /#
        if (result._notify === "<dev string:xb5>") {
            var_566eb49d = 1;
        }
    #/
    if (self.var_51e4a372[n_index] <= 0 || isdefined(var_566eb49d) && var_566eb49d) {
        self playsoundtoplayer(#"hash_78bd6c84a567b714", self);
        self notify("end_slot_cooldown" + n_index);
        self function_c49a8fc5(n_index, 1);
        self function_b9f68e70(n_index, 0);
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 2, eflags: 0x0
// Checksum 0xb9c7ba1c, Offset: 0x1c38
// Size: 0x16a
function function_16ba92de(n_index, n_cooldown) {
    self endon(#"disconnect");
    self endon(#"hash_738988561a113fac");
    self notify("end_slot_cooldown" + n_index);
    self endon("end_slot_cooldown" + n_index);
    if (n_cooldown > 0) {
        n_percentage = 0.01 * n_cooldown / 20;
        n_step = 1 / n_cooldown * 20;
        var_78583fae = 0;
        n_count = 0;
        while (var_78583fae <= 1) {
            wait 0.05;
            n_count++;
            var_78583fae += n_step;
            var_78583fae = math::clamp(var_78583fae, 0, 1);
            self.var_51e4a372[n_index] = n_cooldown - n_cooldown * var_78583fae;
            if (!self.var_40c54861) {
                self function_c49a8fc5(n_index, var_78583fae);
            }
        }
    }
    self.var_51e4a372[n_index] = 0;
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x4
// Checksum 0x9b6354d4, Offset: 0x1db0
// Size: 0x164
function private function_24326a9c(var_ec5a078c) {
    self endon(#"disconnect", #"hash_738988561a113fac");
    n_cooldown = 30;
    if (self hasperk(#"specialty_mod_cooldown")) {
        n_cooldown *= 0.85;
    }
    if (n_cooldown > 0 && var_ec5a078c) {
        n_percentage = 0.01 * n_cooldown / 20;
        n_step = 1 / n_cooldown * 20;
        var_78583fae = 0;
        n_count = 0;
        while (var_78583fae <= 1) {
            wait 0.05;
            n_count++;
            var_78583fae += n_step;
            var_78583fae = math::clamp(var_78583fae, 0, 1);
            self function_1a5aebc7(var_78583fae);
        }
    }
    self function_1a5aebc7(0);
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0x36de3aec, Offset: 0x1f20
// Size: 0xc
function function_64c575f7(visible) {
    
}

// Namespace bgb_pack/zm_bgb_pack
// Params 2, eflags: 0x0
// Checksum 0xfa8e6a42, Offset: 0x1f38
// Size: 0x3c
function function_4805408e(slot_index, item_index) {
    self clientfield::set_player_uimodel("zmhud.bgb_carousel." + slot_index + ".gum_idx", item_index);
}

// Namespace bgb_pack/zm_bgb_pack
// Params 2, eflags: 0x0
// Checksum 0x5a39e75, Offset: 0x1f80
// Size: 0x3c
function function_c49a8fc5(slot_index, cooldown_perc) {
    self clientfield::set_player_uimodel("zmhud.bgb_carousel." + slot_index + ".cooldown_perc", cooldown_perc);
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0xfbe1648f, Offset: 0x1fc8
// Size: 0x2c
function function_1a5aebc7(cooldown_perc) {
    self clientfield::set_player_uimodel("zmhud.bgb_carousel.global_cooldown", cooldown_perc);
}

// Namespace bgb_pack/zm_bgb_pack
// Params 2, eflags: 0x0
// Checksum 0xc101ccba, Offset: 0x2000
// Size: 0xbc
function function_76271859(slot_index, var_28a3786e) {
    if (isdefined(self.bgb_pack[slot_index]) && isdefined(level.bgb[self.bgb_pack[slot_index]]) && !(isdefined(level.bgb[self.bgb_pack[slot_index]].var_91bd251) && level.bgb[self.bgb_pack[slot_index]].var_91bd251)) {
        self clientfield::set_player_uimodel("zmhud.bgb_carousel." + slot_index + ".lockdown", var_28a3786e);
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0x29c838d6, Offset: 0x20c8
// Size: 0x32
function function_fbed925d(slot_index) {
    return self clientfield::get_player_uimodel("zmhud.bgb_carousel." + slot_index + ".lockdown");
}

// Namespace bgb_pack/zm_bgb_pack
// Params 2, eflags: 0x0
// Checksum 0x324f0f40, Offset: 0x2108
// Size: 0xbc
function function_7dc4cba2(slot_index, var_28a3786e) {
    if (isdefined(self.bgb_pack[slot_index]) && isdefined(level.bgb[self.bgb_pack[slot_index]]) && !(isdefined(level.bgb[self.bgb_pack[slot_index]].var_91bd251) && level.bgb[self.bgb_pack[slot_index]].var_91bd251)) {
        self clientfield::set_player_uimodel("zmhud.bgb_carousel." + slot_index + ".unavailable", var_28a3786e);
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0x7e941cbb, Offset: 0x21d0
// Size: 0x32
function function_26f8b25e(slot_index) {
    return self clientfield::get_player_uimodel("zmhud.bgb_carousel." + slot_index + ".unavailable");
}

// Namespace bgb_pack/zm_bgb_pack
// Params 2, eflags: 0x0
// Checksum 0xa5578905, Offset: 0x2210
// Size: 0x3c
function function_b9f68e70(slot_index, state) {
    self clientfield::set_player_uimodel("zmhud.bgb_carousel." + slot_index + ".state", state);
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0x1245e389, Offset: 0x2258
// Size: 0x32
function function_feb6479c(slot_index) {
    return self clientfield::get_player_uimodel("zmhud.bgb_carousel." + slot_index + ".state");
}

// Namespace bgb_pack/zm_bgb_pack
// Params 3, eflags: 0x0
// Checksum 0x6d48e310, Offset: 0x2298
// Size: 0x1cc
function function_95601d64(var_ec5a078c, n_index, var_566eb49d) {
    for (x = 0; x < 4; x++) {
        if (var_ec5a078c) {
            if (self.var_51e4a372[x] < 30 && x != n_index && isdefined(self.bgb_pack[x]) && isdefined(level.bgb[self.bgb_pack[x]]) && !(isdefined(level.bgb[self.bgb_pack[x]].var_59f5ec4) && level.bgb[self.bgb_pack[x]].var_59f5ec4)) {
                self function_b9f68e70(x, 2);
                self function_c49a8fc5(x, 0);
            }
            continue;
        }
        if ((self.var_51e4a372[x] <= 0 || isdefined(var_566eb49d) && var_566eb49d) && self function_feb6479c(x) != 1) {
            self notify("end_slot_cooldown" + x);
            self function_c49a8fc5(x, 1);
            self function_b9f68e70(x, 0);
        }
    }
    self thread function_24326a9c(var_ec5a078c);
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0x554b76ac, Offset: 0x2470
// Size: 0x13e
function function_f27f6f96(var_ded948b3) {
    if (var_ded948b3) {
        self playsoundtoplayer(#"hash_54adb87d474be3d2", self);
    } else {
        self playsoundtoplayer(#"hash_686b41e25622cb04", self);
    }
    for (x = 0; x < 4; x++) {
        if (isdefined(self.bgb_pack[x]) && isdefined(level.bgb[self.bgb_pack[x]]) && !(isdefined(level.bgb[self.bgb_pack[x]].var_91bd251) && level.bgb[self.bgb_pack[x]].var_91bd251)) {
            self clientfield::set_player_uimodel("zmhud.bgb_carousel." + x + ".lockdown", var_ded948b3 ? 1 : 0);
        }
    }
}

// Namespace bgb_pack/zm_bgb_pack
// Params 1, eflags: 0x0
// Checksum 0xe3bf6018, Offset: 0x25b8
// Size: 0xc
function function_ff79216d(slot_index) {
    
}

// Namespace bgb_pack/zm_bgb_pack
// Params 0, eflags: 0x0
// Checksum 0x54519e42, Offset: 0x25d0
// Size: 0x6
function function_f9e81461() {
    return false;
}

/#

    // Namespace bgb_pack/zm_bgb_pack
    // Params 0, eflags: 0x0
    // Checksum 0x83b16f11, Offset: 0x25e0
    // Size: 0x136
    function function_8465a726() {
        level.var_8a709287 = [];
        level.var_8a709287[0] = array("<dev string:xc5>", "<dev string:xdf>", "<dev string:xf5>", "<dev string:x107>", "<dev string:x11b>");
        level.var_8a709287[1] = array("<dev string:x12d>", "<dev string:x142>", "<dev string:x154>", "<dev string:x166>", "<dev string:x179>");
        level.var_8a709287[2] = array("<dev string:x192>", "<dev string:x1a4>", "<dev string:x1c2>", "<dev string:x1d5>", "<dev string:x1ee>");
        level.var_8a709287[3] = array("<dev string:x202>", "<dev string:x213>", "<dev string:x229>", "<dev string:x23b>", "<dev string:x255>");
    }

    // Namespace bgb_pack/zm_bgb_pack
    // Params 0, eflags: 0x4
    // Checksum 0xa0add428, Offset: 0x2720
    // Size: 0x208
    function private setup_devgui() {
        level flagsys::wait_till("<dev string:x269>");
        wait 1;
        bgb_devgui_base = "<dev string:x282>";
        keys = getarraykeys(level.bgb);
        zm_devgui::add_custom_devgui_callback(&function_dba6017a);
        adddebugcommand(bgb_devgui_base + "<dev string:x296>");
        adddebugcommand(bgb_devgui_base + "<dev string:x2cf>" + "<dev string:x2e8>");
        adddebugcommand(bgb_devgui_base + "<dev string:x2f1>" + "<dev string:x30d>");
        adddebugcommand(bgb_devgui_base + "<dev string:x316>" + "<dev string:x331>");
        adddebugcommand(bgb_devgui_base + "<dev string:x33a>" + "<dev string:x355>");
        foreach (key in keys) {
            name = function_15979fa9(level.bgb[key].name);
            adddebugcommand(bgb_devgui_base + name + "<dev string:x35e>" + name + "<dev string:x37b>");
        }
    }

    // Namespace bgb_pack/zm_bgb_pack
    // Params 2, eflags: 0x4
    // Checksum 0xb30622ab, Offset: 0x2930
    // Size: 0x34c
    function private function_dba6017a(str_cmd, key) {
        var_565c0834 = getdvarint(#"hash_7877ee182ba11433", 0);
        a_players = getplayers();
        keys = getarraykeys(level.bgb);
        var_c533fd32 = 0;
        switch (str_cmd) {
        case #"reset_cooldown":
            if (str_cmd == "<dev string:x37f>") {
                for (i = 0; i < a_players.size; i++) {
                    if (var_565c0834 != -1 && var_565c0834 != i) {
                        continue;
                    }
                    a_players[i] notify(#"hash_738988561a113fac");
                }
                return 1;
            }
            break;
        case #"slot0":
            level.var_3a4af1cf = 0;
            break;
        case #"slot1":
            level.var_3a4af1cf = 1;
            break;
        case #"slot2":
            level.var_3a4af1cf = 2;
            break;
        case #"slot3":
            level.var_3a4af1cf = 3;
            break;
        }
        if (!isdefined(level.var_3a4af1cf)) {
            level.var_3a4af1cf = 0;
        }
        a_keys = getarraykeys(level.bgb);
        b_found = 0;
        foreach (key in a_keys) {
            if (key == str_cmd) {
                b_found = 1;
            }
        }
        if (b_found) {
            for (i = 0; i < a_players.size; i++) {
                if (var_565c0834 != -1 && var_565c0834 != i) {
                    continue;
                }
                a_players[i].bgb_pack[level.var_3a4af1cf] = hash(str_cmd);
                a_players[i] function_4805408e(level.var_3a4af1cf, level.bgb[str_cmd].item_index);
            }
            var_c533fd32 = 1;
        }
        return var_c533fd32;
    }

#/
