#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_nuke;

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 0, eflags: 0x6
// Checksum 0x4430fa6b, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_nuke", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 0, eflags: 0x5 linked
// Checksum 0x6a691616, Offset: 0x100
// Size: 0xc4
function private function_70a657d8() {
    zm_powerups::include_zombie_powerup("nuke");
    zm_powerups::add_zombie_powerup("nuke");
    clientfield::register("actor", "zm_nuked", 1, 1, "int", &zombie_nuked, 0, 0);
    clientfield::register("vehicle", "zm_nuked", 1, 1, "int", &zombie_nuked, 0, 0);
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 7, eflags: 0x1 linked
// Checksum 0x679d3b2a, Offset: 0x1d0
// Size: 0x54
function zombie_nuked(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self zombie_death::flame_death_fx(bwastimejump);
}

