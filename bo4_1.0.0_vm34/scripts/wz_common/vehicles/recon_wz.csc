#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\filter_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace recon_wz;

// Namespace recon_wz/recon_wz
// Params 0, eflags: 0x2
// Checksum 0x3efb38f7, Offset: 0xe0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"recon_wz", &__init__, undefined, undefined);
}

// Namespace recon_wz/recon_wz
// Params 0, eflags: 0x0
// Checksum 0xfa7fbfa, Offset: 0x128
// Size: 0xbc
function __init__() {
    clientfield::register("toplayer", "recon_out_of_circle", 1, 5, "int", &function_6d387e39, 0, 0);
    clientfield::register("toplayer", "recon_static_postfx", 1, 1, "int", &function_84df06f4, 0, 0);
    vehicle::add_vehicletype_callback("recon_wz", &_setup_);
}

// Namespace recon_wz/recon_wz
// Params 1, eflags: 0x0
// Checksum 0x8f9dd1e5, Offset: 0x1f0
// Size: 0x24
function _setup_(localclientnum) {
    self thread vehicle::boost_think(localclientnum);
}

// Namespace recon_wz/recon_wz
// Params 7, eflags: 0x0
// Checksum 0x67bf22ce, Offset: 0x220
// Size: 0x7e
function function_6d387e39(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        if (isdefined(self.var_ca294530) && self.var_ca294530) {
            filter::disable_filter_vehicle_hijack_oor(self, 0);
            self.var_ca294530 = undefined;
        }
    }
}

// Namespace recon_wz/recon_wz
// Params 7, eflags: 0x0
// Checksum 0xa1285585, Offset: 0x2a8
// Size: 0xae
function function_84df06f4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_58a75259(localclientnum);
        return;
    }
    self notify(#"hash_16c59bda348653cd");
    if (isdefined(self.var_ca294530) && self.var_ca294530) {
        filter::disable_filter_vehicle_hijack_oor(self, 0);
        self.var_ca294530 = undefined;
    }
}

// Namespace recon_wz/recon_wz
// Params 1, eflags: 0x4
// Checksum 0x8bb0e3be, Offset: 0x360
// Size: 0x226
function private function_58a75259(localclientnum) {
    self notify("69bfc78faf1772b8");
    self endon("69bfc78faf1772b8");
    self endon(#"death");
    self endon(#"exit_vehicle");
    self endon(#"hash_16c59bda348653cd");
    while (true) {
        vehicle = getplayervehicle(self);
        if (isdefined(vehicle)) {
            break;
        }
        waitframe(1);
    }
    vehicle endon(#"death");
    filter::init_filter_vehicle_hijack_oor(self);
    while (true) {
        var_7d19c76b = self clientfield::get_to_player("recon_out_of_circle") / 31;
        var_e93135f2 = distance(self.origin, vehicle.origin);
        if (var_e93135f2 < 7000 && var_7d19c76b <= 0) {
            if (isdefined(self.var_ca294530) && self.var_ca294530) {
                filter::disable_filter_vehicle_hijack_oor(self, 0);
                self.var_ca294530 = undefined;
            }
        } else {
            staticamount = mapfloat(7000, 8000, 0, 1, var_e93135f2);
            staticamount = max(staticamount, var_7d19c76b);
            if (!(isdefined(self.var_ca294530) && self.var_ca294530)) {
                filter::enable_filter_vehicle_hijack_oor(self, 0);
                self.var_ca294530 = 1;
            }
            filter::set_filter_vehicle_hijack_oor_amount(self, 0, staticamount);
        }
        waitframe(1);
    }
}

