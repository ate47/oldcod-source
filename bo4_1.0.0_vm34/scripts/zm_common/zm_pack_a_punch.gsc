#using scripts\core_common\aat_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\trials\zm_trial_disable_upgraded_weapons;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_power;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_pack_a_punch;

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x2
// Checksum 0x3023d89f, Offset: 0x398
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_pack_a_punch", &__init__, &__main__, undefined);
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xfcbd4f46, Offset: 0x3e8
// Size: 0xac
function __init__() {
    level flag::init("pap_machine_active");
    zm_pap_util::init_parameters();
    clientfield::register("zbarrier", "pap_working_fx", 1, 1, "int");
    if (!isdefined(level.var_c8913274)) {
        level.var_c8913274 = 3;
    }
    if (zm_utility::get_story() == 2) {
        function_d83a5a88();
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x6168cfc1, Offset: 0x4a0
// Size: 0x18c
function __main__() {
    if (!isdefined(level.pap_zbarrier_state_func)) {
        level.pap_zbarrier_state_func = &process_pap_zbarrier_state;
    }
    if (zm_custom::function_5638f689(#"zmpapenabled") == 0) {
        var_a146747f = getentarray("zm_pack_a_punch", "targetname");
        foreach (var_e1477f5c in var_a146747f) {
            if (isdefined(var_e1477f5c.unitrigger_stub)) {
                zm_unitrigger::unregister_unitrigger(var_e1477f5c.unitrigger_stub);
            }
        }
        return;
    }
    spawn_init();
    old_packs = getentarray("zombie_vending_upgrade", "targetname");
    for (i = 0; i < old_packs.size; i++) {
        var_52a86333[var_52a86333.size] = old_packs[i];
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0xf7cc33f2, Offset: 0x638
// Size: 0x934
function private spawn_init() {
    function_e400fdb2();
    zbarriers = getentarray("zm_pack_a_punch", "targetname");
    for (i = 0; i < zbarriers.size; i++) {
        if (!zbarriers[i] iszbarrier()) {
            continue;
        }
        if (!isdefined(level.pack_a_punch.interaction_height)) {
            level.pack_a_punch.interaction_height = 35;
        }
        if (!isdefined(level.pack_a_punch.var_2ad8bbcd)) {
            level.pack_a_punch.var_2ad8bbcd = 16;
        }
        if (!isdefined(level.pack_a_punch.var_d21f07a1)) {
            level.pack_a_punch.var_d21f07a1 = 64;
        }
        if (!isdefined(level.pack_a_punch.var_e5756dbf)) {
            level.pack_a_punch.var_e5756dbf = 32;
        }
        if (!isdefined(level.pack_a_punch.interaction_trigger_height)) {
            level.pack_a_punch.interaction_trigger_height = 70;
        }
        var_182f7d27 = vectornormalize(anglestoright(zbarriers[i].angles)) * level.pack_a_punch.var_2ad8bbcd;
        if (!isdefined(level.pack_a_punch.var_edac78d2)) {
            level.pack_a_punch.var_edac78d2 = var_182f7d27 + (0, 0, level.pack_a_punch.interaction_height);
        }
        zbarriers[i].unitrigger_stub = spawnstruct();
        zbarriers[i].unitrigger_stub.targetname = "pap_machine_stub";
        zbarriers[i].unitrigger_stub.pap_machine = zbarriers[i];
        zbarriers[i].unitrigger_stub.origin = zbarriers[i].origin + level.pack_a_punch.var_edac78d2;
        zbarriers[i].unitrigger_stub.angles = zbarriers[i].angles;
        zbarriers[i].unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
        zbarriers[i].unitrigger_stub.cursor_hint = "HINT_NOICON";
        zbarriers[i].unitrigger_stub.script_width = level.pack_a_punch.var_e5756dbf;
        zbarriers[i].unitrigger_stub.script_length = level.pack_a_punch.var_d21f07a1;
        zbarriers[i].unitrigger_stub.script_height = level.pack_a_punch.interaction_trigger_height;
        if (isdefined(level.var_fd891dd9) && level.var_fd891dd9) {
            zbarriers[i].unitrigger_stub.require_look_at = 0;
            zbarriers[i].unitrigger_stub.require_look_toward = 0;
        } else {
            zbarriers[i].unitrigger_stub.require_look_at = 1;
            zbarriers[i].unitrigger_stub.require_look_toward = 1;
        }
        zbarriers[i].unitrigger_stub.prompt_and_visibility_func = &zm_pap_util::update_hint_string;
        zbarriers[i] flag::init("Pack_A_Punch_on");
        zbarriers[i] flag::init("Pack_A_Punch_off");
        zbarriers[i] flag::init("pap_waiting_for_user");
        zbarriers[i] flag::init("pap_taking_gun");
        zbarriers[i] flag::init("pap_offering_gun");
        zbarriers[i] flag::init("pap_in_retrigger_delay");
        collision = spawn("script_model", zbarriers[i].origin, 1);
        collision.angles = zbarriers[i].angles;
        collision setmodel(#"zm_collision_perks1");
        collision.script_noteworthy = "clip";
        collision disconnectpaths();
        zbarriers[i].unitrigger_stub.clip = collision;
        zbarriers[i].unitrigger_stub.zbarrier = zbarriers[i];
        packa_rollers = spawn("script_origin", zbarriers[i].unitrigger_stub.origin);
        packa_timer = spawn("script_origin", zbarriers[i].unitrigger_stub.origin);
        packa_rollers linkto(zbarriers[i]);
        packa_timer linkto(zbarriers[i]);
        zbarriers[i].packa_rollers = packa_rollers;
        zbarriers[i].packa_timer = packa_timer;
        zbarriers[i].cost = 5000;
        zbarriers[i].var_ebe0c72f = 4000;
        zbarriers[i].var_2066a653 = 2500;
        zbarriers[i] zbarrierpieceuseattachweapon(3);
        powered_on = get_start_state();
        if (!powered_on) {
            zbarriers[i] thread function_776e2d76();
        } else {
            zbarriers[i] thread pap_power_on_init();
        }
        if (isdefined(level.pack_a_punch.custom_power_think)) {
            zbarriers[i] thread [[ level.pack_a_punch.custom_power_think ]](powered_on);
        } else {
            zbarriers[i].powered = zm_power::add_powered_item(&turn_on, &turn_off, &function_1dcd79f, &function_70d98ebd, 0, powered_on, zbarriers[i]);
            zbarriers[i] thread toggle_think(powered_on);
        }
        if (!isdefined(level.pack_a_punch.trigger_stubs)) {
            level.pack_a_punch.trigger_stubs = [];
        } else if (!isarray(level.pack_a_punch.trigger_stubs)) {
            level.pack_a_punch.trigger_stubs = array(level.pack_a_punch.trigger_stubs);
        }
        level.pack_a_punch.trigger_stubs[level.pack_a_punch.trigger_stubs.size] = zbarriers[i].unitrigger_stub;
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x66503963, Offset: 0xf78
// Size: 0x260
function function_e400fdb2() {
    var_b4dafa8b = getentarray("zm_pack_a_punch", "targetname");
    if (var_b4dafa8b.size == 0) {
        return;
    }
    var_a3f9b544 = [];
    foreach (s_pap in var_b4dafa8b) {
        if (isdefined(s_pap.script_int) && s_pap.script_int > -1) {
            if (!isdefined(var_a3f9b544)) {
                var_a3f9b544 = [];
            } else if (!isarray(var_a3f9b544)) {
                var_a3f9b544 = array(var_a3f9b544);
            }
            var_a3f9b544[var_a3f9b544.size] = s_pap;
        }
    }
    if (var_a3f9b544.size > 1) {
        var_cc5029a3 = array::random(var_a3f9b544);
        if (isdefined(var_cc5029a3)) {
            arrayremovevalue(var_a3f9b544, var_cc5029a3, 0);
        }
        foreach (var_3a9d13a2 in var_a3f9b544) {
            a_s_sound = struct::get_array(var_3a9d13a2.target);
            a_s_sound = arraysortclosest(a_s_sound, var_3a9d13a2.origin, 1);
            if (a_s_sound.size > 0) {
                a_s_sound[0] struct::delete();
            }
            var_3a9d13a2 delete();
        }
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0xfab4a4b6, Offset: 0x11e0
// Size: 0xf6
function private function_d83a5a88() {
    zm_pap_util::set_interaction_height(60);
    zm_pap_util::function_59b7969e(64);
    zm_pap_util::set_interaction_trigger_height(48);
    zm_pap_util::function_2ad8bbcd(48);
    level.var_fa0ea9e7 = &function_f653d44f;
    level.var_b617ab67 = array(#"ar_damage_t8", #"ar_fastfire_t8", #"ar_mg1909_t8", #"shotgun_semiauto_t8", #"tr_longburst_t8", #"tr_midburst_t8");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x96690120, Offset: 0x12e0
// Size: 0x7e
function private get_start_state() {
    if (zm_custom::function_5638f689(#"zmpapenabled") == 0) {
        return false;
    }
    if (isdefined(level.var_6a8290be) && level.var_6a8290be || zm_custom::function_5638f689(#"zmpapenabled") == 2) {
        return true;
    }
    return false;
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xe5892eaa, Offset: 0x1368
// Size: 0x3c
function function_776e2d76() {
    self flag::wait_till("Pack_A_Punch_on");
    self thread pap_power_on_init();
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xb5c55b34, Offset: 0x13b0
// Size: 0x94
function pap_power_on_init() {
    self playloopsound(#"zmb_perks_packa_loop");
    level thread shutoffpapsounds(self, self.packa_rollers, self.packa_timer);
    if (isdefined(level.pack_a_punch.power_on_callback)) {
        self thread [[ level.pack_a_punch.power_on_callback ]]();
    }
    self thread function_45b5c3f2();
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 3, eflags: 0x0
// Checksum 0xacbba2, Offset: 0x1450
// Size: 0xfe
function function_e95839cd(b_on, str_state = "power_on", str_waittill) {
    if (!isdefined(self.powered)) {
        self.powered = spawnstruct();
    }
    if (!b_on) {
        self.powered.power = 1;
        self turn_off();
        self.powered.power = 0;
    }
    self set_pap_zbarrier_state(str_state);
    if (isdefined(str_waittill)) {
        self waittill(str_waittill);
    }
    if (b_on) {
        self.powered.power = 0;
        self turn_on();
        self.powered.power = 1;
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 2, eflags: 0x4
// Checksum 0xd6116a81, Offset: 0x1558
// Size: 0x2b4
function private turn_on(origin, radius) {
    if (isstruct(self) && isdefined(self.target)) {
        pap_machine = self.target;
    } else if (self iszbarrier()) {
        pap_machine = self;
    }
    if (!isdefined(pap_machine)) {
        assert(0, "<dev string:x30>");
    }
    if (isdefined(level.pack_a_punch.custom_power_think)) {
        if (pap_machine is_on()) {
            return;
        }
    }
    println("<dev string:x75>");
    var_182f7d27 = vectornormalize(anglestoright(pap_machine.angles)) * level.pack_a_punch.var_2ad8bbcd;
    level.pack_a_punch.var_edac78d2 = var_182f7d27 + (0, 0, level.pack_a_punch.interaction_height);
    pap_machine.unitrigger_stub.origin = pap_machine.origin + level.pack_a_punch.var_edac78d2;
    pap_machine.unitrigger_stub.angles = pap_machine.angles + (0, -90, 0);
    zm_unitrigger::register_static_unitrigger(pap_machine.unitrigger_stub, &function_a5a7b815);
    zm_unitrigger::function_9946242d(pap_machine.unitrigger_stub, 1);
    pap_machine flag::set("pap_waiting_for_user");
    pap_machine flag::set("Pack_A_Punch_on");
    pap_machine flag::clear("Pack_A_Punch_off");
    pap_machine notify(#"hash_222aa78f79091e7");
    level notify(#"hash_222aa78f79091e7");
    level flag::set("pap_machine_active");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 2, eflags: 0x4
// Checksum 0xc2dfb11e, Offset: 0x1818
// Size: 0x1c4
function private turn_off(origin, radius) {
    if (self iszbarrier()) {
        pap_machine = self;
    } else if (isstruct(self) && isdefined(self.target)) {
        pap_machine = self.target;
    }
    if (!isdefined(pap_machine)) {
        assert(0, "<dev string:x7f>");
    }
    if (isdefined(level.pack_a_punch.custom_power_think)) {
        if (!pap_machine is_on()) {
            return;
        }
    }
    pap_machine flag::wait_till("pap_waiting_for_user");
    println("<dev string:xc5>");
    zm_unitrigger::unregister_unitrigger(pap_machine.unitrigger_stub);
    pap_machine flag::set("Pack_A_Punch_off");
    pap_machine flag::clear("Pack_A_Punch_on");
    pap_machine notify(#"hash_672bc8ddbec0fa33");
    level notify(#"hash_672bc8ddbec0fa33");
    level flag::clear("pap_machine_active");
    pap_machine thread function_776e2d76();
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xa0821083, Offset: 0x19e8
// Size: 0x22
function is_on() {
    if (isdefined(self.powered)) {
        return self.powered.power;
    }
    return 0;
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x56ad33bd, Offset: 0x1a18
// Size: 0x74
function private function_70d98ebd() {
    if (isdefined(self.one_time_cost)) {
        cost = self.one_time_cost;
        self.one_time_cost = undefined;
        return cost;
    }
    if (isdefined(level._power_global) && level._power_global) {
        return 0;
    }
    if (isdefined(self.self_powered) && self.self_powered) {
        return 0;
    }
    return 1;
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0x9bc3427f, Offset: 0x1a98
// Size: 0xf0
function private toggle_think(powered_on) {
    while (!clientfield::can_set()) {
        waitframe(1);
    }
    if (!powered_on) {
        self set_pap_zbarrier_state("initial");
        self flag::wait_till("Pack_A_Punch_on");
    }
    for (;;) {
        self set_pap_zbarrier_state("power_on");
        self flag::wait_till_clear("Pack_A_Punch_on");
        self set_pap_zbarrier_state("power_off");
        self flag::wait_till("Pack_A_Punch_on");
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 3, eflags: 0x4
// Checksum 0x9caa7095, Offset: 0x1b90
// Size: 0xf0
function private function_1dcd79f(delta, origin, radius) {
    if (isdefined(self.target)) {
        paporigin = self.target.origin;
        if (isdefined(self.target.trigger_off) && self.target.trigger_off) {
            paporigin = self.target.realorigin;
        } else if (isdefined(self.target.disabled) && self.target.disabled) {
            paporigin += (0, 0, 10000);
        }
        if (distancesquared(paporigin, origin) < radius * radius) {
            return true;
        }
    }
    return false;
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0xb8d9864e, Offset: 0x1c88
// Size: 0xc4
function function_b4713b3b(b_on) {
    if (b_on) {
        if (isdefined(self.unitrigger_stub.registered) && self.unitrigger_stub.registered) {
            return;
        }
        zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &function_a5a7b815);
        return;
    }
    if (!(isdefined(self.unitrigger_stub.registered) && self.unitrigger_stub.registered)) {
        return;
    }
    self flag::wait_till("pap_waiting_for_user");
    zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0xdfc06abe, Offset: 0x1d58
// Size: 0x45e
function private function_a5a7b815() {
    self endon(#"hash_672bc8ddbec0fa33", #"death");
    pap_machine = self.stub.zbarrier;
    b_power_off = !pap_machine is_on();
    if (b_power_off) {
        self sethintstring(#"zombie/need_power");
        pap_machine flag::wait_till("Pack_A_Punch_on");
    }
    for (;;) {
        if (!pap_machine flag::get("pap_in_retrigger_delay")) {
            if (pap_machine flag::get("pap_waiting_for_user")) {
                player = undefined;
                pap_machine.pack_player = undefined;
                pap_machine.b_weapon_supports_aat = undefined;
                pap_machine.var_ea5395eb = undefined;
                waitresult = self waittill(#"trigger");
                player = waitresult.activator;
                /#
                    iprintlnbold("<dev string:xd0>" + player getentnum());
                #/
                if (!pap_machine flag::get("pap_waiting_for_user") || isdefined(player.var_351ac6c7) && player.var_351ac6c7) {
                    continue;
                }
                current_weapon = player getcurrentweapon();
                current_weapon = player zm_weapons::switch_from_alt_weapon(current_weapon);
                b_result = player function_3147dde6(pap_machine, current_weapon);
                if (!b_result) {
                    continue;
                }
                b_weapon_supports_aat = zm_weapons::weapon_supports_aat(current_weapon) && zm_custom::function_5638f689(#"zmsuperpapenabled");
                pap_machine.b_weapon_supports_aat = b_weapon_supports_aat;
                var_ed7ab451 = pap_machine zm_pap_util::function_3c579d8f(player, current_weapon, pap_machine.b_weapon_supports_aat);
                if (!player zm_score::can_player_purchase(var_ed7ab451)) {
                    self playsound(#"zmb_perks_packa_deny");
                    if (isdefined(level.pack_a_punch.var_43867716)) {
                        player [[ level.pack_a_punch.var_43867716 ]]();
                    } else {
                        player zm_audio::create_and_play_dialog("general", "outofmoney", 0);
                    }
                    continue;
                }
                player thread function_74f7f4ba(current_weapon, pap_machine.packa_rollers, pap_machine, var_ed7ab451);
            } else if (isdefined(pap_machine.pack_player) && pap_machine.pack_player === self.player) {
                pap_machine flag::wait_till("pap_offering_gun");
                if (isdefined(pap_machine.pack_player)) {
                    self setcursorhint("HINT_WEAPON", pap_machine.unitrigger_stub.upgrade_weapon);
                    self wait_for_player_to_take(pap_machine.pack_player, pap_machine.unitrigger_stub.current_weapon, pap_machine.packa_timer, pap_machine.b_weapon_supports_aat, pap_machine.var_ea5395eb);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 2, eflags: 0x4
// Checksum 0x5d585c47, Offset: 0x21c0
// Size: 0x196
function private function_3147dde6(pap_machine, current_weapon) {
    if (isdefined(level.pack_a_punch.custom_validation)) {
        valid = pap_machine [[ level.pack_a_punch.custom_validation ]](self);
        if (!valid) {
            return false;
        }
    }
    if (!self zm_magicbox::can_buy_weapon() || self laststand::player_is_in_laststand() || isdefined(self.intermission) && self.intermission || self isthrowinggrenade() || zm_trial_disable_buys::is_active() || zm_trial_disable_upgraded_weapons::is_active() || !self zm_weapons::can_upgrade_weapon(current_weapon) && !zm_weapons::weapon_supports_aat(current_weapon)) {
        return false;
    }
    if (self isswitchingweapons()) {
        wait 0.1;
        if (!isdefined(self) || isdefined(self) && self isswitchingweapons()) {
            return false;
        }
    }
    if (!zm_weapons::is_weapon_or_base_included(current_weapon)) {
        return false;
    }
    return true;
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 4, eflags: 0x4
// Checksum 0x9ecb1bdd, Offset: 0x2360
// Size: 0x684
function private function_74f7f4ba(current_weapon, packa_rollers, pap_machine, var_ed7ab451) {
    pap_machine.pack_player = self;
    pap_machine.pack_player.var_48044c94 = undefined;
    pap_machine.pack_player.restore_clip = undefined;
    pap_machine.pack_player.restore_stock = undefined;
    pap_machine.pack_player.restore_clip_size = undefined;
    pap_machine.pack_player.restore_max = undefined;
    var_ea5395eb = 0;
    currentaathashid = -1;
    if (pap_machine.b_weapon_supports_aat) {
        var_f360dd32 = pap_machine.pack_player aat::getaatonweapon(current_weapon);
        if (isdefined(var_f360dd32)) {
            currentaathashid = var_f360dd32.hash_id;
        }
        pap_machine.pack_player.var_48044c94 = 1;
        pap_machine.pack_player.restore_clip = pap_machine.pack_player getweaponammoclip(current_weapon);
        pap_machine.pack_player.restore_clip_size = current_weapon.clipsize;
        pap_machine.pack_player.restore_stock = pap_machine.pack_player getweaponammostock(current_weapon);
        pap_machine.pack_player.restore_max = current_weapon.maxammo;
        var_ea5395eb = 1;
    }
    pap_machine.var_ea5395eb = var_ea5395eb;
    pap_machine flag::clear("pap_waiting_for_user");
    pap_machine flag::set("pap_taking_gun");
    pap_machine thread wait_for_disconnect(pap_machine.pack_player);
    pap_machine thread destroy_weapon_in_blackout();
    /#
        iprintlnbold("<dev string:xe9>" + pap_machine.pack_player getentnum());
    #/
    demo::bookmark(#"zm_player_use_packapunch", gettime(), pap_machine.pack_player);
    potm::bookmark(#"zm_player_use_packapunch", gettime(), pap_machine.pack_player);
    pap_machine.pack_player zm_stats::increment_client_stat("use_pap");
    pap_machine.pack_player zm_stats::increment_player_stat("use_pap");
    weaponidx = undefined;
    if (isdefined(current_weapon)) {
        weaponidx = matchrecordgetweaponindex(current_weapon);
    }
    if (isdefined(weaponidx)) {
        if (!pap_machine.var_ea5395eb) {
            pap_machine.pack_player recordmapevent(19, gettime(), pap_machine.pack_player.origin, level.round_number, weaponidx, var_ed7ab451);
            zm_callings::function_7cafbdd3(24);
        } else {
            pap_machine.pack_player recordmapevent(25, gettime(), pap_machine.pack_player.origin, level.round_number, weaponidx, currentaathashid);
        }
    }
    if (!(isdefined(level.var_c4c4e7fb) && level.var_c4c4e7fb)) {
        pap_machine.pack_player zm_score::minus_to_player_score(var_ed7ab451);
    }
    pap_machine.pack_player.var_fd6dd7b1 = pap_machine.pack_player zm_audio::create_and_play_dialog("pap", "wait");
    pap_machine.unitrigger_stub.current_weapon = current_weapon;
    upgrade_weapon = zm_weapons::get_upgrade_weapon(current_weapon, pap_machine.b_weapon_supports_aat);
    pap_machine.pack_player thread function_8b181695();
    pap_machine.pack_player third_person_weapon_upgrade(current_weapon, upgrade_weapon, packa_rollers, pap_machine);
    pap_machine flag::clear("pap_taking_gun");
    pap_machine flag::set("pap_offering_gun");
    pap_machine thread wait_for_timeout(pap_machine.unitrigger_stub.current_weapon, pap_machine.packa_timer, pap_machine.pack_player, pap_machine.var_ea5395eb);
    pap_machine waittill(#"pap_timeout", #"pap_taken");
    pap_machine flag::clear("pap_offering_gun");
    pap_machine flag::set("pap_waiting_for_user");
    pap_machine.unitrigger_stub.current_weapon = level.weaponnone;
    pap_machine.pack_player = undefined;
    if (pap_machine flag::get("Pack_A_Punch_on")) {
        pap_machine set_pap_zbarrier_state("powered");
    }
    pap_machine thread function_8198f0d0();
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 4, eflags: 0x4
// Checksum 0x67226b49, Offset: 0x29f0
// Size: 0x3da
function private third_person_weapon_upgrade(current_weapon, upgrade_weapon, packa_rollers, pap_machine) {
    pap_machine endon(#"hash_672bc8ddbec0fa33");
    current_weapon = self getbuildkitweapon(current_weapon);
    upgrade_weapon = self getbuildkitweapon(upgrade_weapon);
    pap_machine.unitrigger_stub.current_weapon = current_weapon;
    pap_machine.unitrigger_stub.current_weapon_options = self getbuildkitweaponoptions(pap_machine.unitrigger_stub.current_weapon);
    pap_machine.unitrigger_stub.upgrade_weapon = upgrade_weapon;
    upgrade_weapon.var_a61c0755 = zm_weapons::function_11a37a(upgrade_weapon.var_a61c0755);
    pap_machine.unitrigger_stub.upgrade_weapon_options = self getbuildkitweaponoptions(pap_machine.unitrigger_stub.upgrade_weapon, upgrade_weapon.var_a61c0755);
    pap_machine setweapon(pap_machine.unitrigger_stub.current_weapon);
    pap_machine setweaponoptions(pap_machine.unitrigger_stub.current_weapon_options);
    pap_machine set_pap_zbarrier_state("take_gun");
    origin_offset = (0, 0, 0);
    angles_offset = (0, 0, 0);
    origin_base = self.origin;
    angles_base = self.angles;
    origin_offset = level.pack_a_punch.var_edac78d2;
    angles_offset = (0, 90, 0);
    origin_base = pap_machine.origin;
    angles_base = pap_machine.angles;
    forward = anglestoforward(angles_base + angles_offset);
    interact_offset = origin_offset + forward * -25;
    offsetdw = (3, 3, 3);
    if (isdefined(self)) {
        pap_machine playsound(#"zmb_perks_packa_upgrade");
    }
    var_8a113bfa = isdefined(level.var_1964f528) ? level.var_1964f528 : 3.35;
    if (self hasperk(#"specialty_cooldown")) {
        var_8a113bfa = min(var_8a113bfa, 1.25);
    }
    wait var_8a113bfa;
    pap_machine setweapon(pap_machine.unitrigger_stub.upgrade_weapon);
    pap_machine setweaponoptions(pap_machine.unitrigger_stub.upgrade_weapon_options);
    pap_machine set_pap_zbarrier_state("eject_gun");
    if (isdefined(self)) {
        pap_machine playsound(#"zmb_perks_packa_ready");
        return;
    }
    return;
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x59935779, Offset: 0x2dd8
// Size: 0x4c
function private function_8198f0d0() {
    self flag::set("pap_in_retrigger_delay");
    wait level.var_c8913274;
    self flag::clear("pap_in_retrigger_delay");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0xa5797ef6, Offset: 0x2e30
// Size: 0x9e
function private function_45b5c3f2() {
    self endon(#"hash_672bc8ddbec0fa33");
    while (true) {
        level waittill(#"powerup bonfire sale");
        self.cost = 1000;
        self.var_ebe0c72f = 800;
        self.var_2066a653 = 500;
        level waittill(#"bonfire_sale_off");
        self.cost = 5000;
        self.var_ebe0c72f = 4000;
        self.var_2066a653 = 2500;
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 5, eflags: 0x4
// Checksum 0xfa8772e4, Offset: 0x2ed8
// Size: 0x7a4
function private wait_for_player_to_take(player, weapon, packa_timer, b_weapon_supports_aat, var_ea5395eb) {
    self endon(#"death");
    pap_machine = self.stub.zbarrier;
    current_weapon = pap_machine.unitrigger_stub.current_weapon;
    upgrade_weapon = pap_machine.unitrigger_stub.upgrade_weapon;
    assert(isdefined(current_weapon), "<dev string:x103>");
    assert(isdefined(upgrade_weapon), "<dev string:x132>");
    pap_machine endon(#"pap_timeout", #"hash_672bc8ddbec0fa33");
    while (isdefined(player)) {
        packa_timer playloopsound(#"zmb_perks_packa_ticktock");
        waitresult = self waittill(#"trigger");
        trigger_player = waitresult.activator;
        if (level.pack_a_punch.grabbable_by_anyone) {
            player = trigger_player;
        }
        packa_timer stoploopsound(0.05);
        if (trigger_player == player) {
            player zm_stats::increment_client_stat("pap_weapon_grabbed");
            player zm_stats::increment_player_stat("pap_weapon_grabbed");
            current_weapon = player getcurrentweapon();
            /#
                if (level.weaponnone == current_weapon) {
                    iprintlnbold("<dev string:x169>");
                }
            #/
            if (zm_utility::is_player_valid(player) && !player zm_utility::is_drinking() && !zm_loadout::is_placeable_mine(current_weapon) && !zm_equipment::is_equipment(current_weapon) && !player zm_utility::is_player_revive_tool(current_weapon) && level.weaponnone != current_weapon && !player zm_equipment::hacker_active()) {
                demo::bookmark(#"zm_player_grabbed_packapunch", gettime(), player);
                potm::bookmark(#"zm_player_grabbed_packapunch", gettime(), player);
                pap_machine notify(#"pap_taken");
                player notify(#"pap_taken");
                player.pap_used = 1;
                weapon_limit = zm_utility::get_player_weapon_limit(player);
                player zm_weapons::take_fallback_weapon();
                primaries = player getweaponslistprimaries();
                if (isdefined(primaries) && primaries.size >= weapon_limit) {
                    upgrade_weapon = player zm_weapons::weapon_give(upgrade_weapon);
                } else {
                    upgrade_weapon = player zm_weapons::give_build_kit_weapon(upgrade_weapon);
                    player zm_weapons::function_d13d5303(upgrade_weapon);
                }
                player notify(#"weapon_give", upgrade_weapon);
                aatid = -1;
                if (isdefined(b_weapon_supports_aat) && b_weapon_supports_aat) {
                    player thread aat::acquire(upgrade_weapon);
                    aatobj = player aat::getaatonweapon(upgrade_weapon);
                    if (isdefined(aatobj)) {
                        aatid = aatobj.hash_id;
                        player zm_audio::create_and_play_dialog("pap", aatobj.name);
                    }
                }
                weaponidx = undefined;
                if (isdefined(weapon)) {
                    weaponidx = matchrecordgetweaponindex(weapon);
                }
                if (isdefined(weaponidx)) {
                    if (!var_ea5395eb) {
                        player recordmapevent(27, gettime(), player.origin, level.round_number, weaponidx, aatid);
                    } else {
                        player recordmapevent(28, gettime(), player.origin, level.round_number, weaponidx, aatid);
                    }
                }
                player switchtoweapon(upgrade_weapon);
                if (!(isdefined(player.var_fd6dd7b1) && player.var_fd6dd7b1) && !player zm_audio::function_380f9c94("pap", "wait")) {
                    player thread zm_audio::create_and_play_dialog("pap", "pickup");
                    player zm_weapons::play_weapon_vo(upgrade_weapon);
                }
                if (isdefined(player.var_48044c94) && player.var_48044c94 && !(isdefined(pap_machine.var_a8b34199) && pap_machine.var_a8b34199)) {
                    new_clip = player.restore_clip + upgrade_weapon.clipsize - player.restore_clip_size;
                    new_stock = player.restore_stock + upgrade_weapon.maxammo - player.restore_max;
                    player setweaponammostock(upgrade_weapon, new_stock);
                    player setweaponammoclip(upgrade_weapon, new_clip);
                }
                player.var_48044c94 = undefined;
                player.restore_clip = undefined;
                player.restore_stock = undefined;
                player.restore_max = undefined;
                player.restore_clip_size = undefined;
                player callback::callback(#"hash_790b67aca1bf8fc0", upgrade_weapon);
                if (isdefined(level.var_31a184e2)) {
                    self [[ level.var_31a184e2 ]](player);
                }
                return;
            }
        }
        waitframe(1);
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 4, eflags: 0x4
// Checksum 0x3fb1604b, Offset: 0x3688
// Size: 0x214
function private wait_for_timeout(weapon, packa_timer, player, var_ea5395eb) {
    self endon(#"pap_taken");
    wait level.pack_a_punch.timeout;
    self notify(#"pap_timeout");
    packa_timer stoploopsound(0.05);
    packa_timer playsound(#"zmb_perks_packa_deny");
    if (isdefined(player)) {
        player notify(#"pap_timeout");
        if (isdefined(level.var_31a184e2)) {
            self [[ level.var_31a184e2 ]](player);
        }
        player zm_stats::increment_client_stat("pap_weapon_not_grabbed");
        player zm_stats::increment_player_stat("pap_weapon_not_grabbed");
        weaponidx = undefined;
        if (isdefined(weapon)) {
            weaponidx = matchrecordgetweaponindex(weapon);
        }
        if (isdefined(weaponidx)) {
            if (!var_ea5395eb) {
                player recordmapevent(20, gettime(), player.origin, level.round_number, weaponidx);
                return;
            }
            aatonweapon = player aat::getaatonweapon(weapon);
            aathash = -1;
            if (isdefined(aatonweapon)) {
                aathash = aatonweapon.hash_id;
            }
            player recordmapevent(26, gettime(), player.origin, level.round_number, weaponidx, aathash);
        }
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0x677d6aa8, Offset: 0x38a8
// Size: 0x76
function private wait_for_disconnect(player) {
    self endon(#"pap_taken", #"pap_timeout");
    while (isdefined(player)) {
        wait 0.1;
    }
    println("<dev string:x195>");
    self notify(#"pap_player_disconnected");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0xfb4781c, Offset: 0x3928
// Size: 0xd4
function private destroy_weapon_in_blackout() {
    pap_machine = self;
    pap_machine endon(#"pap_timeout", #"pap_taken", #"pap_player_disconnected");
    pap_machine flag::wait_till("Pack_A_Punch_off");
    pap_machine set_pap_zbarrier_state("take_gun");
    pap_machine.pack_player playlocalsound(level.zmb_laugh_alias);
    wait 1.5;
    pap_machine set_pap_zbarrier_state("power_off");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x1a75aba5, Offset: 0x3a08
// Size: 0xf4
function private function_8b181695() {
    original_weapon = self getcurrentweapon();
    if (original_weapon != level.weaponnone && !zm_loadout::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment(original_weapon)) {
        self notify(#"hash_1fdb7e931333fd8b");
        self notify(#"packing_weapon");
        self takeweapon(original_weapon);
    }
    if (!(isdefined(self.intermission) && self.intermission) && !(isdefined(self.is_drinking) && self.is_drinking)) {
        self zm_weapons::switch_back_primary_weapon();
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 3, eflags: 0x4
// Checksum 0x28edba99, Offset: 0x3b08
// Size: 0xe0
function private shutoffpapsounds(pap_machine, var_6a897559, var_ca6d5015) {
    while (true) {
        pap_machine flag::wait_till("Pack_A_Punch_off");
        level thread turnonpapsounds(pap_machine);
        pap_machine stoploopsound(0.1);
        var_6a897559 stoploopsound(0.1);
        var_ca6d5015 stoploopsound(0.1);
        pap_machine flag::wait_till_clear("Pack_A_Punch_off");
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0x61b75733, Offset: 0x3bf0
// Size: 0x4c
function private turnonpapsounds(pap_machine) {
    pap_machine flag::wait_till("Pack_A_Punch_on");
    pap_machine playloopsound(#"zmb_perks_packa_loop");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x3d966fb9, Offset: 0x3c48
// Size: 0x24
function private pap_initial() {
    self setzbarrierpiecestate(0, "closed");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0xcb603342, Offset: 0x3c78
// Size: 0x24
function private pap_power_off() {
    self setzbarrierpiecestate(0, "closing");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x60d23ef4, Offset: 0x3ca8
// Size: 0xa4
function private pap_power_on() {
    self endon(#"zbarrier_state_change");
    self setzbarrierpiecestate(0, "opening");
    while (self getzbarrierpiecestate(0) == "opening") {
        waitframe(1);
    }
    self playsound(#"zmb_perks_power_on");
    self thread set_pap_zbarrier_state("powered");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x391a6dcf, Offset: 0x3d58
// Size: 0x84
function private pap_powered() {
    self endon(#"zbarrier_state_change");
    self setzbarrierpiecestate(4, "closed");
    if (self.classname === "zbarrier_zm_castle_packapunch" || self.classname === "zbarrier_zm_tomb_packapunch") {
        self clientfield::set("pap_working_FX", 0);
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0xf5ce4f8d, Offset: 0x3de8
// Size: 0x94
function private pap_take_gun() {
    self setzbarrierpiecestate(1, "opening");
    self setzbarrierpiecestate(3, "opening");
    wait 0.1;
    if (self.classname === "zbarrier_zm_castle_packapunch" || self.classname === "zbarrier_zm_tomb_packapunch") {
        self clientfield::set("pap_working_FX", 1);
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x20ed371c, Offset: 0x3e88
// Size: 0x44
function private pap_eject_gun() {
    self setzbarrierpiecestate(1, "closing");
    self setzbarrierpiecestate(3, "closing");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0xe8b1bdd8, Offset: 0x3ed8
// Size: 0x86
function private pap_leaving() {
    self setzbarrierpiecestate(5, "closing");
    do {
        waitframe(1);
    } while (self getzbarrierpiecestate(5) == "closing");
    self setzbarrierpiecestate(5, "closed");
    self notify(#"leave_anim_done");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0xbf25562, Offset: 0x3f68
// Size: 0x7c
function private pap_arriving() {
    self endon(#"zbarrier_state_change");
    self setzbarrierpiecestate(0, "opening");
    while (self getzbarrierpiecestate(0) == "opening") {
        waitframe(1);
    }
    self thread set_pap_zbarrier_state("powered");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x227a40e4, Offset: 0x3ff0
// Size: 0xa
function private get_pap_zbarrier_state() {
    return self.state;
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0x69627cca, Offset: 0x4008
// Size: 0xdc
function private set_pap_zbarrier_state(state) {
    for (i = 0; i < self getnumzbarrierpieces(); i++) {
        self hidezbarrierpiece(i);
    }
    self notify(#"zbarrier_state_change");
    b_continue = 1;
    if (isdefined(level.var_fa0ea9e7)) {
        b_continue = self [[ level.var_fa0ea9e7 ]](state);
    }
    if (b_continue) {
        self [[ level.pap_zbarrier_state_func ]](state);
        if (isdefined(level.var_d27b908a)) {
            self thread [[ level.var_d27b908a ]](state);
        }
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0xfb7a7b72, Offset: 0x40f0
// Size: 0x32a
function private process_pap_zbarrier_state(state) {
    switch (state) {
    case #"initial":
        self showzbarrierpiece(0);
        self thread pap_initial();
        self.state = "initial";
        break;
    case #"power_off":
        self showzbarrierpiece(0);
        self thread pap_power_off();
        self.state = "power_off";
        break;
    case #"power_on":
        self showzbarrierpiece(0);
        self thread pap_power_on();
        self.state = "power_on";
        break;
    case #"powered":
        self showzbarrierpiece(4);
        self thread pap_powered();
        self.state = "powered";
        break;
    case #"take_gun":
        self showzbarrierpiece(1);
        self showzbarrierpiece(3);
        self thread pap_take_gun();
        self.state = "take_gun";
        break;
    case #"eject_gun":
        self showzbarrierpiece(1);
        self showzbarrierpiece(3);
        self thread pap_eject_gun();
        self.state = "eject_gun";
        break;
    case #"leaving":
        self showzbarrierpiece(5);
        self thread pap_leaving();
        self.state = "leaving";
        break;
    case #"arriving":
        self showzbarrierpiece(0);
        self thread pap_arriving();
        self.state = "arriving";
        break;
    case #"hidden":
        self.state = "hidden";
        break;
    default:
        if (isdefined(level.var_f61b6c1)) {
            self [[ level.var_f61b6c1 ]](state);
        }
        break;
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0xf80ff1ef, Offset: 0x4428
// Size: 0xea
function function_cb83b6d8(str_state) {
    switch (str_state) {
    case #"powered":
        self thread function_df894170();
        break;
    case #"take_gun":
        self showzbarrierpiece(2);
        self setzbarrierpiecestate(2, "opening");
        break;
    case #"eject_gun":
        self showzbarrierpiece(2);
        self setzbarrierpiecestate(2, "closing");
        break;
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x1319c5f5, Offset: 0x4520
// Size: 0x98
function function_df894170() {
    self endon(#"zbarrier_state_change");
    while (true) {
        wait randomfloatrange(180, 1800);
        self setzbarrierpiecestate(4, "opening");
        wait randomfloatrange(180, 1800);
        self setzbarrierpiecestate(4, "closing");
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0x1e69dbe6, Offset: 0x45c0
// Size: 0x186
function function_f653d44f(str_state) {
    switch (str_state) {
    case #"take_gun":
        self thread function_d5e86490();
        self.state = "take_gun";
        return false;
    case #"eject_gun":
        self thread function_9ca136ae();
        self.state = "eject_gun";
        return false;
    case #"arriving":
        self showzbarrierpiece(4);
        self thread function_c2121cea();
        self.state = "arriving";
        return false;
    case #"leaving":
        self showzbarrierpiece(4);
        self thread function_9dcc539e();
        self.state = "leaving";
        return false;
    case #"powered":
        self setzbarrierpiecestate(3, "closed");
        self setzbarrierpiecestate(5, "closed");
        return true;
    }
    return true;
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x2bdf96b6, Offset: 0x4750
// Size: 0x6c
function private function_d5e86490() {
    self showzbarrierpiece(4);
    var_f64e49e0 = function_3c0c3e2a();
    self showzbarrierpiece(var_f64e49e0);
    self setzbarrierpiecestate(var_f64e49e0, "opening");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0xc6aaa043, Offset: 0x47c8
// Size: 0x6c
function private function_9ca136ae() {
    self showzbarrierpiece(4);
    var_f64e49e0 = function_3c0c3e2a();
    self showzbarrierpiece(var_f64e49e0);
    self setzbarrierpiecestate(var_f64e49e0, "closing");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x20e7fc5, Offset: 0x4840
// Size: 0x128
function private function_3c0c3e2a() {
    var_480d4db0 = weapons::getbaseweapon(self.unitrigger_stub.current_weapon);
    if (isdefined(level.var_b617ab67) && isinarray(level.var_b617ab67, var_480d4db0.name)) {
        self zbarrierpieceuseattachweapon(5);
        return 5;
    }
    switch (self.unitrigger_stub.current_weapon.weapclass) {
    case #"smg":
    case #"rocketlauncher":
    case #"pistol":
        if (!isdefined(level.var_693191cb) || isdefined(level.var_693191cb) && !isinarray(level.var_693191cb, var_480d4db0.name)) {
            self zbarrierpieceuseattachweapon(5);
            return 5;
        }
    default:
        self zbarrierpieceuseattachweapon(3);
        return 3;
    }
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x86090a3c, Offset: 0x49c0
// Size: 0x9c
function function_c2121cea() {
    self setzbarrierpiecestate(4, "closing");
    while (self getzbarrierpiecestate(4) == "closing") {
        waitframe(1);
    }
    self playsound(#"zmb_perks_power_on");
    self notify(#"arrive_anim_done");
    self thread function_8e6e8acc();
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x5b61b9ed, Offset: 0x4a68
// Size: 0x66
function function_9dcc539e() {
    self setzbarrierpiecestate(4, "opening");
    do {
        waitframe(1);
    } while (self getzbarrierpiecestate(4) == "opening");
    self notify(#"leave_anim_done");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xa2dc6219, Offset: 0x4ad8
// Size: 0x24
function set_state_initial() {
    self set_pap_zbarrier_state("initial");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x30d3f760, Offset: 0x4b08
// Size: 0x24
function set_state_leaving() {
    self set_pap_zbarrier_state("leaving");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x4f2e1f37, Offset: 0x4b38
// Size: 0x24
function set_state_arriving() {
    self set_pap_zbarrier_state("arriving");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x5f8e3b80, Offset: 0x4b68
// Size: 0x24
function set_state_power_on() {
    self set_pap_zbarrier_state("power_on");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xf155ff79, Offset: 0x4b98
// Size: 0x24
function function_8e6e8acc() {
    self set_pap_zbarrier_state("powered");
}

// Namespace zm_pack_a_punch/zm_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xbd47154a, Offset: 0x4bc8
// Size: 0x24
function set_state_hidden() {
    self set_pap_zbarrier_state("hidden");
}

