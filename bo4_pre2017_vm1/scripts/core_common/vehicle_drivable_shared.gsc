#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;

#namespace vehicle;

// Namespace vehicle/level_init
// Params 1, eflags: 0x40
// Checksum 0x292ee4a4, Offset: 0x248
// Size: 0x34
function event_handler[level_init] main(eventstruct) {
    add_main_callback("air_vehicle1", &air_vehicle1_initialize);
}

// Namespace vehicle/vehicle_drivable_shared
// Params 1, eflags: 0x0
// Checksum 0x1f9acdc5, Offset: 0x288
// Size: 0xf6
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
// Checksum 0xaad8d5dd, Offset: 0x388
// Size: 0x90
function air_vehicle1_initialize() {
    self.first_weapon = self seatgetweapon(0);
    self.second_weapon = self seatgetweapon(1);
    while (true) {
        waitresult = self waittill("enter_vehicle");
        self thread weapon_switch_watcher(waitresult.player);
    }
}

