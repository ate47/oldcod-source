#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace shockrifle;

// Namespace shockrifle/shockrifle
// Params 0, eflags: 0x0
// Checksum 0x47560fbf, Offset: 0x118
// Size: 0xdc
function init_shared() {
    clientfield::register("toplayer", "shock_rifle_shocked", 1, 1, "int", &shock_rifle_shocked, 0, 0);
    clientfield::register("toplayer", "shock_rifle_damage", 1, 1, "int", &shock_rifle_damage, 0, 0);
    clientfield::register("allplayers", "shock_rifle_sound", 1, 1, "int", &shock_rifle_sound, 0, 0);
}

// Namespace shockrifle/shockrifle
// Params 7, eflags: 0x0
// Checksum 0x4ec4d0f8, Offset: 0x200
// Size: 0xcc
function shock_rifle_shocked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.playerIsShocked"), 1);
        return;
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.playerIsShocked"), 0);
}

// Namespace shockrifle/shockrifle
// Params 7, eflags: 0x0
// Checksum 0xe4a4c16d, Offset: 0x2d8
// Size: 0x52
function shock_rifle_damage(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_43a24fe6 = 1;
    }
}

// Namespace shockrifle/shockrifle
// Params 7, eflags: 0x0
// Checksum 0x96546ace, Offset: 0x338
// Size: 0x7c
function shock_rifle_sound(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playloopsound("wpn_shockrifle_electrocution");
        return;
    }
    self stopallloopsounds();
}

