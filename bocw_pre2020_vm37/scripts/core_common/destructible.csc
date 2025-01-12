#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace destructible;

// Namespace destructible/destructible
// Params 0, eflags: 0x6
// Checksum 0xbcd8f288, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"destructible", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace destructible/destructible
// Params 0, eflags: 0x5 linked
// Checksum 0x2e5b661d, Offset: 0x100
// Size: 0x4c
function private function_70a657d8() {
    clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int", &doexplosion, 0, 0);
}

// Namespace destructible/destructible
// Params 7, eflags: 0x1 linked
// Checksum 0xe7ad9cb3, Offset: 0x158
// Size: 0x94
function playgrenaderumble(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    playrumbleonposition(bwastimejump, "grenade_rumble", self.origin);
    earthquake(bwastimejump, 0.5, 0.5, self.origin, 800);
}

// Namespace destructible/destructible
// Params 7, eflags: 0x1 linked
// Checksum 0x6b2efcba, Offset: 0x1f8
// Size: 0x104
function doexplosion(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 0) {
        return;
    }
    physics_explosion = 0;
    if (bwastimejump & 1 << 9) {
        physics_explosion = 1;
        bwastimejump -= 1 << 9;
    }
    physics_force = 0.3;
    if (physics_explosion && bwastimejump > 0) {
        physicsexplosionsphere(fieldname, self.origin, bwastimejump, bwastimejump - 1, physics_force, 25, 400);
    }
    playgrenaderumble(fieldname, self.origin);
}

