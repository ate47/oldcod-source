#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace turret;

// Namespace turret/turret_shared
// Params 0, eflags: 0x6
// Checksum 0x2757741c, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"turret", &preinit, undefined, undefined, undefined);
}

// Namespace turret/turret_shared
// Params 0, eflags: 0x4
// Checksum 0x9eedb4da, Offset: 0xf0
// Size: 0x4c
function private preinit() {
    clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int", &field_toggle_lensflare, 0, 0);
}

// Namespace turret/turret_shared
// Params 7, eflags: 0x0
// Checksum 0x79a937d1, Offset: 0x148
// Size: 0x10e
function field_toggle_lensflare(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = getscriptbundle(self.scriptbundlesettings);
    if (!isdefined(settings)) {
        return;
    }
    if (isdefined(self.turret_lensflare_id)) {
        deletefx(fieldname, self.turret_lensflare_id);
        self.turret_lensflare_id = undefined;
    }
    if (bwastimejump) {
        if (isdefined(settings.lensflare_fx) && isdefined(settings.lensflare_tag)) {
            self.turret_lensflare_id = util::playfxontag(fieldname, settings.lensflare_fx, self, settings.lensflare_tag);
        }
    }
}

