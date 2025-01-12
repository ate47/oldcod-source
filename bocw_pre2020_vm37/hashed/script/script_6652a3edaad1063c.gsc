#using script_164ba4a711296dd5;
#using scripts\core_common\callbacks_shared;
#using scripts\wz_common\util;

#namespace insertion;

// Namespace insertion/insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x81165ecc, Offset: 0xd0
// Size: 0xdc
function init() {
    level.insertionpassenger = insertion_passenger_count::register();
    level.var_a3c0d635 = &insertion_passenger_count::is_open;
    level.var_f3320ad2 = &insertion_passenger_count::open;
    level.var_81b39a59 = &insertion_passenger_count::close;
    level.var_ce84dde9 = &insertion_passenger_count::set_count;
    callback::add_callback(#"hash_1634199a59f10727", &function_dd98c073);
    callback::add_callback(#"hash_20fcd06900f62558", &function_ddce9055);
}

// Namespace insertion/insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x29e70b5e, Offset: 0x1b8
// Size: 0x194
function function_dd98c073() {
    var_31a37076 = [];
    for (index = 0; index < self.players.size; index++) {
        player = self.players[index];
        if (!isdefined(player) || isdefined(var_31a37076[player.team])) {
            continue;
        }
        var_31a37076[player.team] = 1;
        if (is_true(getgametypesetting(#"wzspectrerising"))) {
            util::function_8076d591("warSpectreRisingInfiltration", {#team:player.team});
            continue;
        }
        if (is_true(getgametypesetting(#"wzhardcore"))) {
            util::function_8076d591("hcWarBoostInfiltration", {#team:player.team});
            continue;
        }
        util::function_8076d591("warBoostInfiltration", {#team:player.team});
    }
}

// Namespace insertion/insertion
// Params 0, eflags: 0x1 linked
// Checksum 0x746f4623, Offset: 0x358
// Size: 0x118
function function_ddce9055() {
    var_e8d63736 = array(#"hash_780a85992e00c556", #"hash_1669c4b328d5e163", #"hash_67baa029914d2410", #"hash_3f71a3968fd86875");
    var_1f1b9efb = var_e8d63736[randomint(var_e8d63736.size)];
    if (isdefined(self)) {
        foreach (player in self.players) {
            if (isdefined(player)) {
                player playlocalsound(var_1f1b9efb);
            }
        }
    }
}

