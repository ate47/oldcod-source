#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/weapons/spike_charge_siegebot;

#namespace siegebot;

// Namespace siegebot/siegebot
// Params 0, eflags: 0x2
// Checksum 0x80e5ee97, Offset: 0x198
// Size: 0x2c
function autoexec main() {
    vehicle::add_vehicletype_callback("siegebot", &_setup_);
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0x71996fa7, Offset: 0x1d0
// Size: 0x54
function _setup_(localclientnum) {
    if (isdefined(self.scriptbundlesettings)) {
        settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    }
    if (!isdefined(settings)) {
        return;
    }
}

