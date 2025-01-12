#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace destructible;

// Namespace destructible/destructible
// Params 0, eflags: 0x2
// Checksum 0xbb3f0ab9, Offset: 0xb8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"destructible", &__init__, undefined, undefined);
}

// Namespace destructible/destructible
// Params 0, eflags: 0x0
// Checksum 0xec6ee49, Offset: 0x100
// Size: 0x4c
function __init__() {
    clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int", &doexplosion, 0, 0);
}

// Namespace destructible/destructible
// Params 7, eflags: 0x0
// Checksum 0x79e0a37f, Offset: 0x158
// Size: 0x94
function playgrenaderumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playrumbleonposition(localclientnum, "grenade_rumble", self.origin);
    earthquake(localclientnum, 0.5, 0.5, self.origin, 800);
}

// Namespace destructible/destructible
// Params 7, eflags: 0x0
// Checksum 0xffbd76c, Offset: 0x1f8
// Size: 0xfc
function doexplosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        return;
    }
    physics_explosion = 0;
    if (newval & 1 << 9) {
        physics_explosion = 1;
        newval -= 1 << 9;
    }
    physics_force = 0.3;
    if (physics_explosion) {
        physicsexplosionsphere(localclientnum, self.origin, newval, newval - 1, physics_force, 25, 400);
    }
    playgrenaderumble(localclientnum, self.origin);
}

