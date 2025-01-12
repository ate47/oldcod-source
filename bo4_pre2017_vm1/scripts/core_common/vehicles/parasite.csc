#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/filter_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;

#namespace parasite;

// Namespace parasite/parasite
// Params 0, eflags: 0x2
// Checksum 0x9586e221, Offset: 0x2a8
// Size: 0x104
function autoexec main() {
    clientfield::register("vehicle", "parasite_tell_fx", 1, 1, "int", &parasitetellfxhandler, 0, 0);
    clientfield::register("toplayer", "parasite_damage", 1, 1, "counter", &parasite_damage, 0, 0);
    clientfield::register("vehicle", "parasite_secondary_deathfx", 1, 1, "int", &parasitesecondarydeathfxhandler, 0, 0);
    vehicle::add_vehicletype_callback("parasite", &_setup_);
}

// Namespace parasite/parasite
// Params 7, eflags: 0x4
// Checksum 0x8b6e9047, Offset: 0x3b8
// Size: 0x134
function private parasitetellfxhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (isdefined(self.tellfxhandle)) {
        stopfx(localclientnum, self.tellfxhandle);
        self.tellfxhandle = undefined;
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0.1);
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", "parasitesettings");
    if (isdefined(settings)) {
        if (newvalue) {
            self.tellfxhandle = playfxontag(localclientnum, settings.weakspotfx, self, "tag_flash");
            self mapshaderconstant(localclientnum, 0, "scriptVector2", 1);
        }
    }
}

// Namespace parasite/parasite
// Params 7, eflags: 0x4
// Checksum 0x7573f232, Offset: 0x4f8
// Size: 0x64
function private parasite_damage(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self postfx::playpostfxbundle("pstfx_parasite_dmg");
    }
}

// Namespace parasite/parasite
// Params 7, eflags: 0x4
// Checksum 0x786a45a, Offset: 0x568
// Size: 0xe4
function private parasitesecondarydeathfxhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    settings = struct::get_script_bundle("vehiclecustomsettings", "parasitesettings");
    if (isdefined(settings)) {
        if (newvalue) {
            handle = playfx(localclientnum, settings.secondary_death_fx_1, self gettagorigin(settings.secondary_death_tag_1));
            setfxignorepause(localclientnum, handle, 1);
        }
    }
}

// Namespace parasite/parasite
// Params 1, eflags: 0x4
// Checksum 0x68abe346, Offset: 0x658
// Size: 0x8c
function private _setup_(localclientnum) {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0.1);
    if (isdefined(level.debug_keyline_zombies) && level.debug_keyline_zombies) {
        self duplicate_render::set_dr_flag("keyline_active", 1);
        self duplicate_render::update_dr_filters(localclientnum);
    }
}

