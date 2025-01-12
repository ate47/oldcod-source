#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace riotshield;

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0x15b271f9, Offset: 0x288
// Size: 0x8a
function init_shared() {
    clientfield::register("scriptmover", "riotshield_state", 1, 2, "int", &shield_state_change, 0, 0);
    level._effect["riotshield_light"] = "_t6/weapon/riotshield/fx_riotshield_depoly_lights";
    level._effect["riotshield_dust"] = "_t6/weapon/riotshield/fx_riotshield_depoly_dust";
}

// Namespace riotshield/riotshield
// Params 7, eflags: 0x0
// Checksum 0x2d0a7e1d, Offset: 0x320
// Size: 0xbe
function shield_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    switch (newval) {
    case 1:
        instant = oldval == 2;
        self thread riotshield_deploy_anim(localclientnum, instant);
        break;
    case 2:
        self thread riotshield_destroy_anim(localclientnum);
        break;
    }
}

// Namespace riotshield/riotshield
// Params 2, eflags: 0x0
// Checksum 0xa896b3d7, Offset: 0x3e8
// Size: 0x164
function riotshield_deploy_anim(localclientnum, instant) {
    self endon(#"death");
    self thread watch_riotshield_damage();
    self util::waittill_dobj(localclientnum);
    self useanimtree(#mp_riotshield);
    if (instant) {
        self setanimtime(mp_riotshield%o_riot_stand_deploy, 1);
    } else {
        self setanim(mp_riotshield%o_riot_stand_deploy, 1, 0, 1);
        playfxontag(localclientnum, level._effect["riotshield_dust"], self, "tag_origin");
    }
    if (!instant) {
        wait 0.8;
    }
    self.shieldlightfx = playfxontag(localclientnum, level._effect["riotshield_light"], self, "tag_fx");
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0xa95b35a4, Offset: 0x558
// Size: 0x118
function watch_riotshield_damage() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill("damage");
        damage_type = waitresult.mod;
        self useanimtree(#mp_riotshield);
        if (damage_type == "MOD_MELEE" || damage_type == "MOD_MELEE_WEAPON_BUTT" || damage_type == "MOD_MELEE_ASSASSINATE") {
            self setanim(mp_riotshield%o_riot_stand_melee_front, 1, 0, 1);
            continue;
        }
        self setanim(mp_riotshield%o_riot_stand_shot, 1, 0, 1);
    }
}

// Namespace riotshield/riotshield
// Params 1, eflags: 0x0
// Checksum 0x5d33905a, Offset: 0x678
// Size: 0xe4
function riotshield_destroy_anim(localclientnum) {
    self endon(#"death");
    if (isdefined(self.shieldlightfx)) {
        stopfx(localclientnum, self.shieldlightfx);
    }
    waitframe(1);
    self playsound(localclientnum, "wpn_shield_destroy");
    self useanimtree(#mp_riotshield);
    self setanim(mp_riotshield%o_riot_stand_destroyed, 1, 0, 1);
    wait 1;
    self setforcenotsimple();
}

