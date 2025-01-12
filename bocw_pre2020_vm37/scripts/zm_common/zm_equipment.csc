#using script_50a49d535160be60;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_equipment;

// Namespace zm_equipment/zm_equipment
// Params 0, eflags: 0x6
// Checksum 0x2f7b3862, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_equipment", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_equipment/zm_equipment
// Params 0, eflags: 0x5 linked
// Checksum 0x7aa570af, Offset: 0x100
// Size: 0x94
function private function_70a657d8() {
    level._equip_activated_callbacks = [];
    level.buildable_piece_count = 24;
    if (!is_true(level._no_equipment_activated_clientfield)) {
        clientfield::register("scriptmover", "equipment_activated", 1, 4, "int", &equipment_activated_clientfield_cb, 1, 0);
    }
    zm_hint_text::register();
}

// Namespace zm_equipment/zm_equipment
// Params 2, eflags: 0x0
// Checksum 0x456b8cab, Offset: 0x1a0
// Size: 0x24
function add_equip_activated_callback_override(model, func) {
    level._equip_activated_callbacks[model] = func;
}

// Namespace zm_equipment/zm_equipment
// Params 7, eflags: 0x1 linked
// Checksum 0x4775850b, Offset: 0x1d0
// Size: 0x11e
function equipment_activated_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.model) && isdefined(level._equip_activated_callbacks[self.model])) {
        [[ level._equip_activated_callbacks[self.model] ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
    if (!newval) {
        if (isdefined(self._equipment_activated_fx)) {
            for (i = 0; i < self._equipment_activated_fx.size; i++) {
                for (j = 0; j < self._equipment_activated_fx[i].size; j++) {
                    deletefx(i, self._equipment_activated_fx[i][j]);
                }
            }
            self._equipment_activated_fx = undefined;
        }
    }
}

// Namespace zm_equipment/zm_equipment
// Params 4, eflags: 0x0
// Checksum 0xe058434, Offset: 0x2f8
// Size: 0x24c
function play_fx_for_all_clients(fx, tag, storehandles = 0, forward = undefined) {
    numlocalplayers = getlocalplayers().size;
    if (!isdefined(self._equipment_activated_fx)) {
        self._equipment_activated_fx = [];
        for (i = 0; i < numlocalplayers; i++) {
            self._equipment_activated_fx[i] = [];
        }
    }
    if (isdefined(tag)) {
        for (i = 0; i < numlocalplayers; i++) {
            if (storehandles) {
                self._equipment_activated_fx[i][self._equipment_activated_fx[i].size] = util::playfxontag(i, fx, self, tag);
                continue;
            }
            self_for_client = getentbynum(i, self getentitynumber());
            if (isdefined(self_for_client)) {
                util::playfxontag(i, fx, self_for_client, tag);
            }
        }
        return;
    }
    for (i = 0; i < numlocalplayers; i++) {
        if (storehandles) {
            if (isdefined(forward)) {
                self._equipment_activated_fx[i][self._equipment_activated_fx[i].size] = playfx(i, fx, self.origin, forward);
            } else {
                self._equipment_activated_fx[i][self._equipment_activated_fx[i].size] = playfx(i, fx, self.origin);
            }
            continue;
        }
        if (isdefined(forward)) {
            playfx(i, fx, self.origin, forward);
            continue;
        }
        playfx(i, fx, self.origin);
    }
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xcaf95bbb, Offset: 0x550
// Size: 0x36
function is_included(equipment) {
    if (!isdefined(level._included_equipment)) {
        return false;
    }
    return isdefined(level._included_equipment[equipment.rootweapon]);
}

// Namespace zm_equipment/zm_equipment
// Params 1, eflags: 0x0
// Checksum 0xb5f5e368, Offset: 0x590
// Size: 0x54
function include(equipment_name) {
    if (!isdefined(level._included_equipment)) {
        level._included_equipment = [];
    }
    equipment = getweapon(equipment_name);
    level._included_equipment[equipment] = equipment;
}

