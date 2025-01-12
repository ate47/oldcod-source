#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_nuke;

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 0, eflags: 0x2
// Checksum 0xdaf41090, Offset: 0xb0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_nuke", &__init__, undefined, undefined);
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 0, eflags: 0x0
// Checksum 0x53470dfd, Offset: 0xf8
// Size: 0xc4
function __init__() {
    zm_powerups::include_zombie_powerup("nuke");
    zm_powerups::add_zombie_powerup("nuke");
    clientfield::register("actor", "zm_nuked", 1, 1, "int", &zombie_nuked, 0, 0);
    clientfield::register("vehicle", "zm_nuked", 1, 1, "int", &zombie_nuked, 0, 0);
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 7, eflags: 0x0
// Checksum 0x84f65b03, Offset: 0x1c8
// Size: 0x54
function zombie_nuked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self zombie_death::flame_death_fx(localclientnum);
}

