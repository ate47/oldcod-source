#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace explode;

// Namespace explode/explode
// Params 0, eflags: 0x6
// Checksum 0x1d72818e, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"explode", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace explode/explode
// Params 0, eflags: 0x5 linked
// Checksum 0x1d0df724, Offset: 0xf0
// Size: 0xcc
function private function_70a657d8() {
    level.dirt_enable_explosion = getdvarint(#"scr_dirt_enable_explosion", 1);
    level.dirt_enable_slide = getdvarint(#"scr_dirt_enable_slide", 1);
    level.dirt_enable_fall_damage = getdvarint(#"scr_dirt_enable_fall_damage", 1);
    callback::on_localplayer_spawned(&localplayer_spawned);
    /#
        level thread updatedvars();
    #/
}

/#

    // Namespace explode/explode
    // Params 0, eflags: 0x0
    // Checksum 0x80af55e9, Offset: 0x1c8
    // Size: 0xb0
    function updatedvars() {
        while (true) {
            level.dirt_enable_explosion = getdvarint(#"scr_dirt_enable_explosion", level.dirt_enable_explosion);
            level.dirt_enable_slide = getdvarint(#"scr_dirt_enable_slide", level.dirt_enable_slide);
            level.dirt_enable_fall_damage = getdvarint(#"scr_dirt_enable_fall_damage", level.dirt_enable_fall_damage);
            wait 1;
        }
    }

#/

// Namespace explode/explode
// Params 1, eflags: 0x1 linked
// Checksum 0x8e26df86, Offset: 0x280
// Size: 0xcc
function localplayer_spawned(localclientnum) {
    if (!self function_21c0fa55()) {
        return;
    }
    if (level.dirt_enable_explosion || level.dirt_enable_slide || level.dirt_enable_fall_damage) {
        if (level.dirt_enable_explosion) {
            self thread watchforexplosion(localclientnum);
        }
        if (level.dirt_enable_slide) {
            self thread watchforplayerslide(localclientnum);
        }
        if (level.dirt_enable_fall_damage) {
            self thread watchforplayerfalldamage(localclientnum);
        }
    }
}

// Namespace explode/explode
// Params 1, eflags: 0x1 linked
// Checksum 0x6e7083ad, Offset: 0x358
// Size: 0xa0
function watchforplayerfalldamage(localclientnum) {
    self endon(#"death");
    seed = 0;
    xdir = 0;
    ydir = 270;
    while (true) {
        self waittill(#"fall_damage");
        self thread dothedirty(localclientnum, xdir, ydir, 1, 1000, 500);
    }
}

// Namespace explode/explode
// Params 1, eflags: 0x1 linked
// Checksum 0x4f8a6528, Offset: 0x400
// Size: 0x124
function watchforplayerslide(localclientnum) {
    self endon(#"death");
    seed = 0;
    self.wasplayersliding = 0;
    xdir = 0;
    ydir = 6000;
    while (true) {
        self.isplayersliding = self isplayersliding();
        if (self.isplayersliding) {
            if (!self.wasplayersliding) {
                self notify(#"endthedirty");
                seed = randomfloatrange(0, 1);
            }
        } else if (self.wasplayersliding) {
            self thread dothedirty(localclientnum, xdir, ydir, 1, 300, 300);
        }
        self.wasplayersliding = self.isplayersliding;
        waitframe(1);
    }
}

// Namespace explode/explode
// Params 6, eflags: 0x1 linked
// Checksum 0xb1b9952c, Offset: 0x530
// Size: 0xac
function dothedirty(localclientnum, right, up, distance, dirtduration, dirtfadetime) {
    self endon(#"death");
    self notify(#"dothedirty");
    self endon(#"dothedirty");
    self endon(#"endthedirty");
    util::lerp_generic(localclientnum, dirtduration, &do_the_dirty_lerp_helper, right, up, distance, dirtfadetime);
}

// Namespace explode/explode
// Params 8, eflags: 0x1 linked
// Checksum 0x44a63559, Offset: 0x5e8
// Size: 0x44
function do_the_dirty_lerp_helper(*currenttime, *elapsedtime, *localclientnum, *dirtduration, *right, *up, *distance, *dirtfadetime) {
    
}

// Namespace explode/explode
// Params 1, eflags: 0x1 linked
// Checksum 0x4a0d1bd3, Offset: 0x638
// Size: 0x388
function watchforexplosion(localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = level waittill(#"explode");
        mod = waitresult.mod;
        position = waitresult.position;
        localclientnum = waitresult.localclientnum;
        explosiondistance = distance(self.origin, position);
        if ((mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE_SPLASH") && explosiondistance < 600 && !function_1cbf351b(localclientnum) && !isthirdperson(localclientnum)) {
            cameraangles = self getcamangles();
            if (!isdefined(cameraangles)) {
                continue;
            }
            forwardvec = vectornormalize(anglestoforward(cameraangles));
            upvec = vectornormalize(anglestoup(cameraangles));
            rightvec = vectornormalize(anglestoright(cameraangles));
            explosionvec = vectornormalize(position - self getcampos());
            if (vectordot(forwardvec, explosionvec) > 0) {
                trace = bullettrace(getlocalclienteyepos(localclientnum), position, 0, self);
                if (trace[#"fraction"] >= 0.9) {
                    udot = -1 * vectordot(explosionvec, upvec);
                    rdot = vectordot(explosionvec, rightvec);
                    udotabs = abs(udot);
                    rdotabs = abs(rdot);
                    if (udotabs > rdotabs) {
                        if (udot > 0) {
                            udot = 1;
                        } else {
                            udot = -1;
                        }
                    } else if (rdot > 0) {
                        rdot = 1;
                    } else {
                        rdot = -1;
                    }
                    self thread dothedirty(localclientnum, rdot, udot, 1 - explosiondistance / 600, 2000, 500);
                }
            }
        }
    }
}

