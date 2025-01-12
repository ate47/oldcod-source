#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_power;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_vapor_random;

// Namespace zm_vapor_random/zm_vapor_random
// Params 0, eflags: 0x2
// Checksum 0x40342de0, Offset: 0x228
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_vapor_random", &__init__, undefined, #"load");
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 0, eflags: 0x0
// Checksum 0x241a1453, Offset: 0x278
// Size: 0x64
function __init__() {
    clientfield::register("scriptmover", "random_vapor_altar_available", 1, 1, "int");
    /#
        level thread function_f542d5fa();
    #/
    level thread function_7f578ee2();
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 0, eflags: 0x0
// Checksum 0xdf3db37c, Offset: 0x2e8
// Size: 0xf4
function function_7f578ee2() {
    level flag::wait_till("all_players_connected");
    if (!level.enable_magic || !(isdefined(zm_custom::function_5638f689(#"zmperksactive")) && zm_custom::function_5638f689(#"zmperksactive"))) {
        return;
    }
    level.perk_bottle_weapon_array = arraycombine(level.machine_assets, level._custom_perks, 0, 1);
    level.var_edad48a9 = struct::get_array("vapor_random_altar");
    level.var_d8519f43 = [];
    function_f274084e();
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 0, eflags: 0x0
// Checksum 0x78a66de4, Offset: 0x3e8
// Size: 0x1d2
function function_f274084e() {
    if (isdefined(level.var_b71e6033) && level.var_b71e6033) {
        return;
    }
    foreach (struct in level.var_edad48a9) {
        if (isdefined(struct.var_7ca268a3) && struct.var_7ca268a3) {
            var_295697a8 = struct;
            break;
        }
    }
    array::thread_all(level.var_edad48a9, &function_8af8b87d);
    if (!isdefined(var_295697a8)) {
        var_295697a8 = array::random(level.var_edad48a9);
    }
    if (isdefined(var_295697a8)) {
        if (!isdefined(level.var_d8519f43)) {
            level.var_d8519f43 = [];
        } else if (!isarray(level.var_d8519f43)) {
            level.var_d8519f43 = array(level.var_d8519f43);
        }
        if (!isinarray(level.var_d8519f43, var_295697a8)) {
            level.var_d8519f43[level.var_d8519f43.size] = var_295697a8;
        }
        var_295697a8 thread function_a37c41c();
        var_295697a8.b_is_active = 1;
    }
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 0, eflags: 0x0
// Checksum 0x37e750c8, Offset: 0x5c8
// Size: 0x302
function function_a37c41c() {
    self.var_6abcf0f5 = 0;
    self.var_2115dec7 = randomintrange(3, 7);
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = self.origin;
    unitrigger_stub.angles = self.angles;
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.script_height = 32;
    unitrigger_stub.script_width = 64;
    unitrigger_stub.script_length = 72;
    unitrigger_stub.require_look_at = 0;
    unitrigger_stub.targetname = "random_vapor_altar_stub";
    unitrigger_stub.hint_string = #"zombie/need_power";
    unitrigger_stub.script_struct = self;
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    unitrigger_stub.prompt_and_visibility_func = &function_fe8876ae;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_e42402ea);
    zm_unitrigger::function_9946242d(unitrigger_stub, 1);
    self.unitrigger_stub = unitrigger_stub;
    if (!isdefined(self.mdl_altar)) {
        self.mdl_altar = util::spawn_model("tag_origin", self.origin, self.angles);
    }
    self.mdl_altar clientfield::set("random_vapor_altar_available", 1);
    var_89562eb7 = getentarray(self.target, "targetname");
    array::run_all(var_89562eb7, &show);
    a_s_interacts = struct::get_array(self.target);
    foreach (s_interact in a_s_interacts) {
        if (s_interact.script_int === 3) {
            s_interact.n_cost = 5000;
            continue;
        }
        s_interact.n_cost = 2000;
    }
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 0, eflags: 0x0
// Checksum 0xfa7d33e2, Offset: 0x8d8
// Size: 0x15c
function function_8af8b87d() {
    a_s_interacts = struct::get_array(self.target);
    var_89562eb7 = getentarray(self.target, "targetname");
    var_89562eb7 = getentarray(self.target, "targetname");
    array::run_all(var_89562eb7, &ghost);
    foreach (s_interact in a_s_interacts) {
        zm_unitrigger::unregister_unitrigger(s_interact.unitrigger_stub);
        s_interact.unitrigger_stub = undefined;
    }
    zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
    self.b_is_active = undefined;
    if (isdefined(self.mdl_altar)) {
        self.mdl_altar delete();
    }
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 1, eflags: 0x0
// Checksum 0x1b063bbe, Offset: 0xa40
// Size: 0x578
function function_fe8876ae(player) {
    s_altar = self.stub.script_struct;
    var_f96badc9 = struct::get_array(s_altar.target);
    if (zm_custom::function_f24cfbd2(player)) {
        player.var_7056099e = undefined;
        return false;
    }
    if (!(isdefined(s_altar.b_in_use) && s_altar.b_in_use) && isdefined(player.perks_active) && player.perks_active.size > 4) {
        var_f96badc9 = arraysortclosest(var_f96badc9, player util::get_eye(), undefined, 0, 64);
        foreach (s_interact in var_f96badc9) {
            n_dist = distancesquared(player util::get_eye(), s_interact.origin);
            var_c1e49da3 = player zm_utility::is_player_looking_at(s_interact.origin, 0.94, 0);
            if (n_dist < 4096 && var_c1e49da3) {
                var_e42798a9 = s_interact.script_int;
                break;
            }
        }
        if (isdefined(var_e42798a9)) {
            switch (var_e42798a9) {
            case 0:
                str_altar = #"hash_7e97aa53c3038fb4";
                break;
            case 1:
                str_altar = #"hash_133c9b7b564b707f";
                break;
            case 2:
                str_altar = #"hash_726a5f9b0d18c78b";
                break;
            case 3:
                str_altar = #"hash_228c88065496b9fe";
                break;
            }
            player.var_7056099e = s_interact;
            self sethintstringforplayer(player, str_altar, s_interact.n_cost);
            return true;
        } else {
            player.var_7056099e = undefined;
            return false;
        }
    } else if (!(isdefined(s_altar.b_in_use) && s_altar.b_in_use)) {
        self sethintstringforplayer(player, #"hash_5d7144cc16556865", 4);
        player.var_7056099e = undefined;
        return true;
    } else if (isdefined(s_altar.var_969f0643) && s_altar.var_969f0643 && s_altar.var_3dc6162e === player && isdefined(s_altar.var_109ad3e3)) {
        switch (s_altar.var_109ad3e3) {
        case #"specialty_additionalprimaryweapon":
            var_5b7fa473 = #"hash_481e84e3d5747771";
            break;
        case #"specialty_armorvest":
            var_5b7fa473 = #"hash_514ee426b54c1122";
            break;
        case #"specialty_cooldown":
            var_5b7fa473 = #"hash_c5eaf038e40129b";
            break;
        case #"specialty_deadshot":
            var_5b7fa473 = #"hash_554eba058d6a7c30";
            break;
        case #"specialty_electriccherry":
            var_5b7fa473 = #"hash_2d6886135fa75f38";
            break;
        case #"specialty_fastreload":
            var_5b7fa473 = #"hash_1c530c71188469b5";
            break;
        case #"specialty_quickrevive":
            var_5b7fa473 = #"hash_45143147d543f878";
            break;
        case #"specialty_staminup":
            var_5b7fa473 = #"hash_461fdf40d1afda35";
            break;
        case #"specialty_widowswine":
            var_5b7fa473 = #"hash_62a4738313dcd9c4";
            break;
        }
        self sethintstringforplayer(player, var_5b7fa473);
        return true;
    }
    player.var_7056099e = undefined;
    return false;
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 0, eflags: 0x0
// Checksum 0x26642d9c, Offset: 0xfc0
// Size: 0x4c2
function function_e42402ea() {
    self endon(#"death");
    s_altar = self.stub.script_struct;
    while (true) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        if (!isdefined(player.var_7056099e) || !isdefined(player.var_7056099e.script_int) || !isdefined(player.var_7056099e.n_cost)) {
            waitframe(1);
            continue;
        }
        if (!zm_perks::vending_trigger_can_player_use(player, 1)) {
            waitframe(1);
            continue;
        }
        if (zm_custom::function_f24cfbd2(player)) {
            continue;
        }
        n_slot = player.var_7056099e.script_int;
        n_cost = player.var_7056099e.n_cost;
        if (!player zm_score::can_player_purchase(n_cost)) {
            self playsound(#"evt_perk_deny");
            player zm_audio::create_and_play_dialog("general", "outofmoney");
            continue;
        }
        if (!isdefined(player.perks_active) || isdefined(player.perks_active) && player.perks_active.size < 4) {
            continue;
        }
        s_altar.b_in_use = 1;
        s_altar.var_6abcf0f5++;
        s_altar.var_3dc6162e = player;
        sound = "evt_bottle_dispense";
        playsoundatposition(sound, self.origin);
        player zm_score::minus_to_player_score(n_cost);
        var_8183cdf2 = array::exclude(level.var_3d574fc8, player.perks_active);
        var_109ad3e3 = array::random(var_8183cdf2);
        if (!isdefined(var_109ad3e3)) {
            continue;
        }
        s_altar.var_109ad3e3 = var_109ad3e3;
        s_altar function_2e1d7869(var_109ad3e3);
        var_a97f84a = self function_a5210fb8(player);
        level.bottle_spawn_location setmodel(#"tag_origin");
        if (isdefined(var_a97f84a) && var_a97f84a) {
            if (n_slot == 3 && isdefined(level.var_fb762d80)) {
                player notify(level.var_fb762d80[player.var_871d24d3[n_slot]] + "_stop");
            }
            player notify(player.var_871d24d3[n_slot] + "_stop");
            player thread function_f734e3df(s_altar);
            player.var_871d24d3[n_slot] = var_109ad3e3;
            player notify(#"perk_purchased", {#perk:var_109ad3e3});
            player thread zm_perks::function_25bb08(n_slot, var_109ad3e3);
            self thread zm_perks::function_dbd6062(player, var_109ad3e3, n_slot);
        } else {
            s_altar.b_in_use = 0;
        }
        s_altar.var_3dc6162e = undefined;
        s_altar.var_109ad3e3 = undefined;
        if (s_altar.var_6abcf0f5 >= s_altar.var_2115dec7 && level.var_edad48a9.size > 1) {
            level thread function_a65e8ccd();
            return;
        }
    }
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 0, eflags: 0x0
// Checksum 0x8e15e22d, Offset: 0x1490
// Size: 0x184
function function_a65e8ccd() {
    /#
        iprintlnbold("<dev string:x30>");
    #/
    array::thread_all(level.var_edad48a9, &function_8af8b87d);
    var_89726945 = array::exclude(level.var_edad48a9, level.var_d8519f43);
    if (var_89726945.size) {
        var_295697a8 = array::random(var_89726945);
        var_295697a8 thread function_a37c41c();
        var_295697a8.b_is_active = 1;
        if (!isdefined(level.var_d8519f43)) {
            level.var_d8519f43 = [];
        } else if (!isarray(level.var_d8519f43)) {
            level.var_d8519f43 = array(level.var_d8519f43);
        }
        if (!isinarray(level.var_d8519f43, var_295697a8)) {
            level.var_d8519f43[level.var_d8519f43.size] = var_295697a8;
        }
        return;
    }
    level.var_d8519f43 = [];
    function_f274084e();
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 1, eflags: 0x0
// Checksum 0x109c186a, Offset: 0x1620
// Size: 0x134
function function_2e1d7869(var_b6318641) {
    if (isdefined(level.bottle_spawn_location)) {
        level.bottle_spawn_location delete();
    }
    level.bottle_spawn_location = util::spawn_model("tag_origin", self.origin, self.angles);
    level.bottle_spawn_location.origin += (0, 0, 15);
    wait 1;
    self notify(#"bottle_spawned");
    self thread start_perk_bottle_cycling();
    self thread perk_bottle_motion();
    var_3935fab9 = zm_perks::get_perk_weapon_model(var_b6318641);
    wait 3;
    self notify(#"done_cycling");
    level.bottle_spawn_location setmodel(var_3935fab9);
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 0, eflags: 0x0
// Checksum 0x87bc5cd7, Offset: 0x1760
// Size: 0xfa
function start_perk_bottle_cycling() {
    self endon(#"done_cycling");
    var_bfd477c = level.var_3d574fc8;
    var_bfd477c = array::exclude(var_bfd477c, #"specialty_mystery");
    var_5fe6c920 = undefined;
    while (true) {
        for (i = 0; i < var_bfd477c.size; i++) {
            str_model = zm_perks::get_perk_weapon_model(var_bfd477c[i]);
            if (str_model === var_5fe6c920) {
                continue;
            }
            var_5fe6c920 = str_model;
            if (isdefined(str_model)) {
                level.bottle_spawn_location setmodel(str_model);
            }
            wait 0.1;
        }
    }
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 0, eflags: 0x0
// Checksum 0x6a27d533, Offset: 0x1868
// Size: 0x1bc
function perk_bottle_motion() {
    level.bottle_spawn_location dontinterpolate();
    level.bottle_spawn_location.origin = self.origin;
    level.bottle_spawn_location.angles = self.angles;
    level.bottle_spawn_location moveto(level.bottle_spawn_location.origin + (0, 0, 30), 3, 3 * 0.5);
    level.bottle_spawn_location.angles += (0, 0, 10);
    level.bottle_spawn_location rotateyaw(720, 3, 3 * 0.5);
    self waittill(#"done_cycling");
    level.bottle_spawn_location.angles = self.angles;
    level.bottle_spawn_location moveto(level.bottle_spawn_location.origin - (0, 0, 30), 10, 10 * 0.5);
    level.bottle_spawn_location rotateyaw(90, 10, 10 * 0.5);
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 1, eflags: 0x0
// Checksum 0xa4818c65, Offset: 0x1a30
// Size: 0xa4
function function_a5210fb8(player) {
    s_altar = self.stub.script_struct;
    s_altar.var_969f0643 = 1;
    s_result = self waittilltimeout(10, #"trigger");
    s_altar.var_969f0643 = 0;
    if (s_result._notify == "trigger" && s_result.activator === player) {
        return 1;
    }
    return 0;
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 1, eflags: 0x0
// Checksum 0x4d51f65f, Offset: 0x1ae0
// Size: 0x5e
function function_f734e3df(s_altar) {
    self waittill(#"perk_acquired", #"death", #"disconnect", #"player_downed");
    s_altar.b_in_use = 0;
}

/#

    // Namespace zm_vapor_random/zm_vapor_random
    // Params 0, eflags: 0x4
    // Checksum 0x16475a12, Offset: 0x1b48
    // Size: 0xe4
    function private function_f542d5fa() {
        level waittill(#"start_zombie_round_logic");
        adddebugcommand("<dev string:x49>");
        while (true) {
            cmd = getdvarstring(#"hash_655adfd9dc05d377", "<dev string:xac>");
            setdvar(#"hash_655adfd9dc05d377", "<dev string:xac>");
            switch (cmd) {
            case #"cycle_altar":
                function_a65e8ccd();
                wait 1;
                break;
            }
            waitframe(1);
        }
    }

#/
