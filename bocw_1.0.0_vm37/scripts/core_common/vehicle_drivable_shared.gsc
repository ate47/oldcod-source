#using scripts\core_common\vehicle_shared;

#namespace vehicle;

// Namespace vehicle/level_init
// Params 1, eflags: 0x40
// Checksum 0x635cb32b, Offset: 0x78
// Size: 0x34
function event_handler[level_init] main(*eventstruct) {
    add_main_callback("air_vehicle1", &air_vehicle1_initialize);
}

// Namespace vehicle/vehicle_drivable_shared
// Params 1, eflags: 0x0
// Checksum 0x76956683, Offset: 0xb8
// Size: 0xfe
function weapon_switch_watcher(driver) {
    self endon(#"death");
    driver endon(#"death");
    self endon(#"exit_vehicle");
    while (true) {
        if (driver weaponswitchbuttonpressed()) {
            while (driver weaponswitchbuttonpressed()) {
                waitframe(1);
            }
            current_weapon = self seatgetweapon(0);
            if (current_weapon == self.first_weapon) {
                self setweapon(self.second_weapon);
            } else {
                self setweapon(self.first_weapon);
            }
        }
        waitframe(1);
    }
}

// Namespace vehicle/vehicle_drivable_shared
// Params 0, eflags: 0x0
// Checksum 0xa4b867e7, Offset: 0x1c0
// Size: 0x90
function air_vehicle1_initialize() {
    self.first_weapon = self seatgetweapon(0);
    self.second_weapon = self seatgetweapon(1);
    while (true) {
        waitresult = self waittill(#"enter_vehicle");
        self thread weapon_switch_watcher(waitresult.player);
    }
}

