#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace turret;

// Namespace turret/turret_shared
// Params 0, eflags: 0x2
// Checksum 0xa9413557, Offset: 0x198
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("turret", &__init__, undefined, undefined);
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x0
// Checksum 0xdb469db7, Offset: 0x1d8
// Size: 0x4c
function __init__() {
    clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int", &field_toggle_lensflare, 0, 0);
}

// Namespace turret/turret_shared
// Params 7, eflags: 0x0
// Checksum 0x4c8c318e, Offset: 0x230
// Size: 0x130
function field_toggle_lensflare(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (!isdefined(settings)) {
        return;
    }
    if (isdefined(self.turret_lensflare_id)) {
        deletefx(localclientnum, self.turret_lensflare_id);
        self.turret_lensflare_id = undefined;
    }
    if (newval) {
        if (isdefined(settings.lensflare_fx) && isdefined(settings.lensflare_tag)) {
            self.turret_lensflare_id = playfxontag(localclientnum, settings.lensflare_fx, self, settings.lensflare_tag);
        }
    }
}

