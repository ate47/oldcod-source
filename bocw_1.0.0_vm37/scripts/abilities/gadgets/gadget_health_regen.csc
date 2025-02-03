#using script_6e0a2f806b25fee3;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace gadget_health_regen;

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x6
// Checksum 0x7bfa8ae4, Offset: 0xe8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gadget_health_regen", &preinit, undefined, undefined, undefined);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x4
// Checksum 0x833c53de, Offset: 0x130
// Size: 0xec
function private preinit() {
    clientfield::register("toplayer", "healthregen", 1, 1, "int", &function_31f57700, 0, 1);
    clientfield::register_clientuimodel("hudItems.healingActive", #"hud_items", #"healingactive", 1, 1, "int", undefined, 0, 1);
    clientfield::register_clientuimodel("hudItems.numHealthPickups", #"hud_items", #"numhealthpickups", 1, 2, "int", undefined, 0, 1);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 7, eflags: 0x0
// Checksum 0xa0618dd7, Offset: 0x228
// Size: 0xd6
function function_31f57700(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame() || sessionmodeiscampaigngame()) {
        if (bwastimejump) {
            if (!is_true(self.var_b072e263)) {
                self.var_b072e263 = 1;
            }
            return;
        }
        if (is_true(self.var_b072e263)) {
            self.var_b072e263 = undefined;
        }
    }
}

