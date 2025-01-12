#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;

#namespace gadget_health_regen;

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x2
// Checksum 0xc790ce0, Offset: 0xf0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gadget_health_regen", &__init__, undefined, undefined);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x7f21e868, Offset: 0x138
// Size: 0xbc
function __init__() {
    clientfield::register("toplayer", "healthregen", 1, 1, "int", &function_f622e38a, 0, 0);
    clientfield::register("clientuimodel", "hudItems.healingActive", 1, 1, "int", undefined, 0, 1);
    clientfield::register("clientuimodel", "hudItems.numHealthPickups", 1, 2, "int", undefined, 0, 1);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 7, eflags: 0x0
// Checksum 0x359b4666, Offset: 0x200
// Size: 0x144
function function_f622e38a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        if (newval) {
            if (!(isdefined(self.var_13834005) && self.var_13834005)) {
                self.var_31003e21 = self playloopsound(#"hash_390aa7d4252c46b5", 0.25);
                self.var_13834005 = 1;
                self postfx::playpostfxbundle("pstfx_health_regen");
            }
            return;
        }
        if (isdefined(self.var_13834005) && self.var_13834005) {
            self stoploopsound(self.var_31003e21);
            self.var_13834005 = undefined;
            self postfx::exitpostfxbundle("pstfx_health_regen");
        }
    }
}

