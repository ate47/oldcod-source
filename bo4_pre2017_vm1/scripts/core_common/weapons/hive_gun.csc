#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace namespace_5cffdc90;

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0x76d6cd1, Offset: 0x3c0
// Size: 0x1c
function init_shared() {
    level thread register();
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0xc7bc314d, Offset: 0x3e8
// Size: 0xdc
function register() {
    clientfield::register("scriptmover", "firefly_state", 1, 3, "int", &function_4dc1ebd, 0, 0);
    clientfield::register("toplayer", "fireflies_attacking", 1, 1, "int", &function_2d29dc1d, 0, 1);
    clientfield::register("toplayer", "fireflies_chasing", 1, 1, "int", &function_917da836, 0, 1);
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x4132b1fb, Offset: 0x4d0
// Size: 0x4c
function getotherteam(team) {
    if (team == "allies") {
        return "axis";
    }
    if (team == "axis") {
        return "allies";
    }
    return "free";
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 7, eflags: 0x0
// Checksum 0x3f4aaa5f, Offset: 0x528
// Size: 0x116
function function_2d29dc1d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        self notify(#"stop_player_fx");
        if (self islocalplayer() && !self getinkillcam(localclientnum)) {
            fx = playfxoncamera(localclientnum, "weapon/fx_ability_firefly_attack_1p", (0, 0, 0), (1, 0, 0), (0, 0, 1));
            self thread function_38574d7c(localclientnum, fx);
        }
        return;
    }
    self notify(#"stop_player_fx");
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 7, eflags: 0x0
// Checksum 0x3eb79b6d, Offset: 0x648
// Size: 0x166
function function_917da836(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        self notify(#"stop_player_fx");
        if (self islocalplayer() && !self getinkillcam(localclientnum)) {
            fx = playfxoncamera(localclientnum, "weapon/fx_ability_firefly_chase_1p", (0, 0, 0), (1, 0, 0), (0, 0, 1));
            sound = self playloopsound("wpn_gelgun_hive_hunt_lp");
            self playrumblelooponentity(localclientnum, "firefly_chase_rumble_loop");
            self thread function_38574d7c(localclientnum, fx, sound);
        }
        return;
    }
    self notify(#"stop_player_fx");
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 3, eflags: 0x0
// Checksum 0x7cfe0633, Offset: 0x7b8
// Size: 0xac
function function_38574d7c(localclientnum, fx, sound) {
    self waittill("death", "stop_player_fx");
    if (isdefined(self)) {
        self stoprumble(localclientnum, "firefly_chase_rumble_loop");
    }
    if (isdefined(fx)) {
        stopfx(localclientnum, fx);
    }
    if (isdefined(sound) && isdefined(self)) {
        self stoploopsound(sound);
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 7, eflags: 0x0
// Checksum 0xc3564c46, Offset: 0x870
// Size: 0x15e
function function_4dc1ebd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.var_80262773)) {
        self thread function_40245849(localclientnum);
        self.var_80262773 = 1;
    }
    switch (newval) {
    case 0:
        break;
    case 1:
        self function_231d32d6(localclientnum);
        break;
    case 2:
        self function_3115859c(localclientnum);
        break;
    case 3:
        self function_c0c4f0d9(localclientnum);
        break;
    case 4:
        self function_c2dd71e6(localclientnum);
        break;
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 2, eflags: 0x0
// Checksum 0x8e51f684, Offset: 0x9d8
// Size: 0xbc
function on_shutdown(localclientnum, ent) {
    if (isdefined(ent) && isdefined(ent.origin) && self === ent && !(isdefined(self.var_98cbe294) && self.var_98cbe294)) {
        fx = playfx(localclientnum, "weapon/fx_hero_firefly_death", ent.origin, (0, 0, 1));
        setfxteam(localclientnum, fx, ent.team);
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x644cc9de, Offset: 0xaa0
// Size: 0x2c
function function_40245849(localclientnum) {
    self callback::on_shutdown(&on_shutdown, self);
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x3ad50816, Offset: 0xad8
// Size: 0x7c
function function_231d32d6(localclientnum) {
    fx = playfx(localclientnum, "weapon/fx_hero_firefly_start", self.origin, anglestoup(self.angles));
    setfxteam(localclientnum, fx, self.team);
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x6337b57, Offset: 0xb60
// Size: 0x84
function function_3115859c(localclientnum) {
    fx = playfxontag(localclientnum, "weapon/fx_hero_firefly_hunting", self, "tag_origin");
    setfxteam(localclientnum, fx, self.team);
    self thread function_e7ff9fa6(localclientnum, fx);
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 2, eflags: 0x0
// Checksum 0xc8c9250c, Offset: 0xbf0
// Size: 0x4c
function function_e7ff9fa6(localclientnum, fx) {
    self waittill("death", "stop_effects");
    if (isdefined(fx)) {
        stopfx(localclientnum, fx);
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x6eecd755, Offset: 0xc48
// Size: 0x28
function function_c0c4f0d9(localclientnum) {
    self notify(#"hash_b2f94bca");
    self.var_98cbe294 = 1;
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x44ab3cb3, Offset: 0xc78
// Size: 0x98
function function_c2dd71e6(localclientnum) {
    fx = playfx(localclientnum, "weapon/fx_hero_firefly_start_entity", self.origin, anglestoup(self.angles));
    setfxteam(localclientnum, fx, self.team);
    self notify(#"hash_b2f94bca");
    self.var_98cbe294 = 1;
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 3, eflags: 0x0
// Checksum 0x4a666602, Offset: 0xd18
// Size: 0xac
function gib_fx(localclientnum, fxfilename, gibflag) {
    fxtag = gibclientutils::playergibtag(localclientnum, gibflag);
    if (isdefined(fxtag)) {
        fx = playfxontag(localclientnum, fxfilename, self, fxtag);
        setfxteam(localclientnum, fx, getotherteam(self.team));
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 2, eflags: 0x0
// Checksum 0x6057d879, Offset: 0xdd0
// Size: 0x3c
function function_efe10ed8(localclientnum, value) {
    self endon(#"death");
    self thread function_e802f658(localclientnum);
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x4a21e47f, Offset: 0xe18
// Size: 0x346
function function_e802f658(localclientnum) {
    self endon(#"death");
    if (!util::is_mature() || util::is_gib_restricted_build()) {
        return;
    }
    fxfilename = "weapon/fx_hero_firefly_attack_limb";
    bodytype = self getcharacterbodytype();
    if (bodytype >= 0) {
        var_f99f1882 = getcharacterfields(bodytype, currentsessionmode());
        if (isdefined(var_f99f1882.digitalblood) ? var_f99f1882.digitalblood : 0) {
            fxfilename = "weapon/fx_hero_firefly_attack_limb_reaper";
        }
    }
    var_eeee776 = 0;
    var_52fa99e0 = 0;
    while (true) {
        notetrack = self waittill("gib_leftarm", "gib_leftleg", "gib_rightarm", "gib_rightleg", "death");
        switch (notetrack._notify) {
        case #"gib_rightarm":
            var_eeee776 |= 1;
            gib_fx(localclientnum, fxfilename, 16);
            self gibclientutils::playergibleftarm(localclientnum);
            self setcorpsegibstate(var_52fa99e0, var_eeee776);
            break;
        case #"gib_leftarm":
            var_eeee776 |= 2;
            gib_fx(localclientnum, fxfilename, 32);
            self gibclientutils::playergibleftarm(localclientnum);
            self setcorpsegibstate(var_52fa99e0, var_eeee776);
            break;
        case #"gib_rightleg":
            var_52fa99e0 |= 1;
            gib_fx(localclientnum, fxfilename, 128);
            self gibclientutils::playergibleftleg(localclientnum);
            self setcorpsegibstate(var_52fa99e0, var_eeee776);
            break;
        case #"gib_leftleg":
            var_52fa99e0 |= 2;
            gib_fx(localclientnum, fxfilename, 256);
            self gibclientutils::playergibleftleg(localclientnum);
            self setcorpsegibstate(var_52fa99e0, var_eeee776);
            break;
        default:
            break;
        }
    }
}

