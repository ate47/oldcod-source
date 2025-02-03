#using scripts\core_common\clientfield_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;

#namespace battletracks;

// Namespace battletracks/battletracks
// Params 0, eflags: 0x6
// Checksum 0x17a99d7a, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"battletracks", &preinit, undefined, undefined, undefined);
}

// Namespace battletracks/battletracks
// Params 0, eflags: 0x4
// Checksum 0xd34736ce, Offset: 0x128
// Size: 0x6c
function private preinit() {
    serverfield::register("battletrack_command", 1, 8, "int", &battletrack_command);
    clientfield::register("toplayer", "battletrack_query", 1, 1, "counter");
}

// Namespace battletracks/battletracks
// Params 2, eflags: 0x4
// Checksum 0x3b421113, Offset: 0x1a0
// Size: 0xa4
function private battletrack_command(*oldval, newval) {
    if (self isinvehicle()) {
        vehicle = self getvehicleoccupied();
        vehicle function_fe45d0ae();
        index = newval >> 1;
        if (index != 0) {
            self function_afb0648d(vehicle, index);
        }
    }
}

// Namespace battletracks/enter_vehicle
// Params 1, eflags: 0x44
// Checksum 0x775abdd9, Offset: 0x250
// Size: 0x54
function private event_handler[enter_vehicle] function_860f46d6(eventstruct) {
    if (isplayer(self)) {
        if (eventstruct.seat_index == 0) {
            self clientfield::increment_to_player("battletrack_query");
        }
    }
}

// Namespace battletracks/exit_vehicle
// Params 1, eflags: 0x44
// Checksum 0x3bdbbea1, Offset: 0x2b0
// Size: 0x54
function private event_handler[exit_vehicle] function_c8e0f88d(eventstruct) {
    if (isplayer(self)) {
        if (eventstruct.seat_index == 0) {
            eventstruct.vehicle function_982d5b1();
        }
    }
}

// Namespace battletracks/change_seat
// Params 1, eflags: 0x44
// Checksum 0x7e64c0d1, Offset: 0x310
// Size: 0xa4
function private event_handler[change_seat] function_63d4043f(eventstruct) {
    if (isplayer(self)) {
        if (eventstruct.seat_index == 0) {
            eventstruct.vehicle function_fe45d0ae();
            self clientfield::increment_to_player("battletrack_query");
            return;
        }
        if (eventstruct.old_seat_index == 0) {
            eventstruct.vehicle function_982d5b1();
        }
    }
}

// Namespace battletracks/battletracks
// Params 0, eflags: 0x4
// Checksum 0x2dc1f7ac, Offset: 0x3c0
// Size: 0x76
function private function_982d5b1() {
    if (!sessionmodeiscampaigngame()) {
        self endon(#"death");
        self endon(#"hash_10f5e7a492971517");
        wait 5;
        if (isdefined(self.battletrack_active)) {
            self stopsound(self.battletrack_active);
            self.battletrack_active = undefined;
        }
    }
}

// Namespace battletracks/battletracks
// Params 0, eflags: 0x4
// Checksum 0x8a261a60, Offset: 0x440
// Size: 0x5e
function private function_fe45d0ae() {
    if (!sessionmodeiscampaigngame()) {
        self notify(#"hash_10f5e7a492971517");
        if (isdefined(self.battletrack_active)) {
            self stopsound(self.battletrack_active);
            self.battletrack_active = undefined;
        }
    }
}

// Namespace battletracks/battletracks
// Params 2, eflags: 0x4
// Checksum 0xc601a455, Offset: 0x4a8
// Size: 0x94
function private function_afb0648d(vehicle, *index) {
    if (!sessionmodeiscampaigngame()) {
        if (self isinvehicle()) {
            index function_fe45d0ae();
            index.battletrack_active = undefined;
            if (isdefined(index.battletrack_active)) {
                index playsoundwithnotify(index.battletrack_active, "battletrack_complete");
            }
        }
    }
}

