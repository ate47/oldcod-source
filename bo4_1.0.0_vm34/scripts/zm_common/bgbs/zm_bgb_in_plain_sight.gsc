#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_in_plain_sight;

// Namespace zm_bgb_in_plain_sight/zm_bgb_in_plain_sight
// Params 0, eflags: 0x2
// Checksum 0xe49c55fb, Offset: 0xd8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_in_plain_sight", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_in_plain_sight/zm_bgb_in_plain_sight
// Params 0, eflags: 0x0
// Checksum 0xf8959c8c, Offset: 0x128
// Size: 0x174
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_in_plain_sight", "activated", 1, undefined, undefined, undefined, &activation);
    bgb::function_4cda71bf(#"zm_bgb_in_plain_sight", 1);
    bgb::function_e1ef21fb(#"zm_bgb_in_plain_sight", 1);
    bgb::function_336ffc4e(#"zm_bgb_in_plain_sight");
    if (!isdefined(level.vsmgr_prio_visionset_zm_bgb_in_plain_sight)) {
        level.vsmgr_prio_visionset_zm_bgb_in_plain_sight = 110;
    }
    visionset_mgr::register_info("visionset", "zm_bgb_in_plain_sight", 1, level.vsmgr_prio_visionset_zm_bgb_in_plain_sight, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
    clientfield::register("toplayer", "" + #"hash_321b58d22755af74", 1, 1, "int");
}

// Namespace zm_bgb_in_plain_sight/zm_bgb_in_plain_sight
// Params 0, eflags: 0x0
// Checksum 0xc2fabcbc, Offset: 0x2a8
// Size: 0x42
function validation() {
    if (self bgb::get_active() || isdefined(self.var_77777c2d) && self.var_77777c2d) {
        return false;
    }
    return true;
}

// Namespace zm_bgb_in_plain_sight/zm_bgb_in_plain_sight
// Params 0, eflags: 0x0
// Checksum 0x1cbeed90, Offset: 0x2f8
// Size: 0x1d6
function activation() {
    self endon(#"disconnect");
    self val::set(#"hash_69d303dd5e34b7b7", "ignoreme");
    self.bgb_in_plain_sight_active = 1;
    self playsound(#"zmb_bgb_plainsight_start");
    self playloopsound(#"zmb_bgb_plainsight_loop", 1);
    self thread bgb::run_timer(10);
    self clientfield::set_to_player("" + #"hash_321b58d22755af74", 1);
    ret = self waittilltimeout(9.5, #"bgb_about_to_take_on_bled_out", #"end_game", #"bgb_update", #"disconnect");
    self stoploopsound(1);
    self playsound(#"zmb_bgb_plainsight_end");
    self clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);
    self val::reset(#"hash_69d303dd5e34b7b7", "ignoreme");
    self.bgb_in_plain_sight_active = undefined;
}

