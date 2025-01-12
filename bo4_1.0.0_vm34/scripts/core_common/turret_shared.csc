#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace turret;

// Namespace turret/turret_shared
// Params 0, eflags: 0x2
// Checksum 0xdea5a365, Offset: 0xc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"turret", &__init__, undefined, undefined);
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x0
// Checksum 0x6ecaad2a, Offset: 0x108
// Size: 0x4c
function __init__() {
    clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int", &field_toggle_lensflare, 0, 0);
}

// Namespace turret/turret_shared
// Params 7, eflags: 0x0
// Checksum 0x5843ab3, Offset: 0x160
// Size: 0x116
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
            self.turret_lensflare_id = util::playfxontag(localclientnum, settings.lensflare_fx, self, settings.lensflare_tag);
        }
    }
}
