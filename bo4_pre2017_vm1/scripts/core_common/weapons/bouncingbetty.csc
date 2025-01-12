#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace bouncingbetty;

// Namespace bouncingbetty/bouncingbetty
// Params 1, eflags: 0x0
// Checksum 0x273fd9d1, Offset: 0x2f0
// Size: 0x164
function init_shared(localclientnum) {
    level.explode_1st_offset = 55;
    level.explode_2nd_offset = 95;
    level.explode_main_offset = 140;
    level._effect["fx_betty_friendly_light"] = "weapon/fx_betty_light_blue";
    level._effect["fx_betty_enemy_light"] = "weapon/fx_betty_light_orng";
    level._effect["fx_betty_exp"] = "weapon/fx_betty_exp";
    level._effect["fx_betty_exp_death"] = "weapon/fx_betty_exp_death";
    level._effect["fx_betty_launch_dust"] = "weapon/fx_betty_launch_dust";
    clientfield::register("missile", "bouncingbetty_state", 1, 2, "int", &bouncingbetty_state_change, 0, 0);
    clientfield::register("scriptmover", "bouncingbetty_state", 1, 2, "int", &bouncingbetty_state_change, 0, 0);
}

// Namespace bouncingbetty/bouncingbetty
// Params 7, eflags: 0x0
// Checksum 0xf25e8519, Offset: 0x460
// Size: 0xce
function bouncingbetty_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    switch (newval) {
    case 1:
        self thread bouncingbetty_detonating(localclientnum);
        break;
    case 2:
        self thread bouncingbetty_deploying(localclientnum);
        break;
    }
}

// Namespace bouncingbetty/bouncingbetty
// Params 1, eflags: 0x0
// Checksum 0xed4be67a, Offset: 0x538
// Size: 0x6c
function bouncingbetty_deploying(localclientnum) {
    self endon(#"death");
    self useanimtree(#bouncing_betty);
    self setanim(bouncing_betty%o_spider_mine_deploy, 1, 0, 1);
}

// Namespace bouncingbetty/bouncingbetty
// Params 1, eflags: 0x0
// Checksum 0xc0714453, Offset: 0x5b0
// Size: 0x13c
function bouncingbetty_detonating(localclientnum) {
    self endon(#"death");
    up = anglestoup(self.angles);
    forward = anglestoforward(self.angles);
    playfx(localclientnum, level._effect["fx_betty_launch_dust"], self.origin, up, forward);
    self playsound(localclientnum, "wpn_betty_jump");
    self useanimtree(#bouncing_betty);
    self setanim(bouncing_betty%o_spider_mine_detonate, 1, 0, 1);
    self thread watchforexplosionnotetracks(localclientnum, up, forward);
}

// Namespace bouncingbetty/bouncingbetty
// Params 3, eflags: 0x0
// Checksum 0x24a848ed, Offset: 0x6f8
// Size: 0x1e6
function watchforexplosionnotetracks(localclientnum, up, forward) {
    self endon(#"death");
    while (true) {
        notetrack = self waittill("explode_1st", "explode_2nd", "explode_main");
        switch (notetrack._notify) {
        case #"explode_1st":
            playfx(localclientnum, level._effect["fx_betty_exp"], self.origin + up * level.explode_1st_offset, up, forward);
            break;
        case #"explode_2nd":
            playfx(localclientnum, level._effect["fx_betty_exp"], self.origin + up * level.explode_2nd_offset, up, forward);
            break;
        case #"explode_main":
            playfx(localclientnum, level._effect["fx_betty_exp"], self.origin + up * level.explode_main_offset, up, forward);
            playfx(localclientnum, level._effect["fx_betty_exp_death"], self.origin, up, forward);
            break;
        default:
            break;
        }
    }
}

