#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_bgb_pack;
#using scripts\zm_common\zm_score;

#namespace zm_bgb_point_drops;

// Namespace zm_bgb_point_drops/zm_bgb_point_drops
// Params 0, eflags: 0x2
// Checksum 0x747b7e8, Offset: 0xb0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_point_drops", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_point_drops/zm_bgb_point_drops
// Params 0, eflags: 0x0
// Checksum 0x964200ea, Offset: 0x100
// Size: 0xfc
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_point_drops", "activated", 1, undefined, undefined, &validation, &activation);
    bgb_pack::function_b3d251d5(#"zm_bgb_point_drops", 5);
    bgb_pack::function_aa090e8(#"zm_bgb_point_drops");
    bgb_pack::function_25ede233(#"zm_bgb_point_drops");
    bgb_pack::function_fe5ee859(#"zm_bgb_point_drops");
}

// Namespace zm_bgb_point_drops/zm_bgb_point_drops
// Params 0, eflags: 0x0
// Checksum 0x36831bd, Offset: 0x208
// Size: 0x3c
function activation() {
    self zm_score::minus_to_player_score(500);
    self thread bgb::function_dea74fb0("bonus_points_player_shared");
}

// Namespace zm_bgb_point_drops/zm_bgb_point_drops
// Params 0, eflags: 0x0
// Checksum 0x6f0aeaa8, Offset: 0x250
// Size: 0x26
function validation() {
    if (self zm_score::can_player_purchase(500)) {
        return true;
    }
    return false;
}

