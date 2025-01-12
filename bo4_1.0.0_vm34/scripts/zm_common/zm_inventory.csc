#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_maptable;

#namespace zm_inventory;

// Namespace zm_inventory/zm_inventory
// Params 4, eflags: 0x4
// Checksum 0xe8187320, Offset: 0x1e0
// Size: 0xb2
function private function_b6517d13(mappingname, internalname, numbits, ispersonal) {
    if (!isdefined(level.var_c67b847b[mappingname])) {
        level.var_c67b847b[mappingname] = spawnstruct();
    }
    level.var_c67b847b[mappingname].var_b98f9b55 = internalname;
    level.var_c67b847b[mappingname].numbits = numbits;
    level.var_c67b847b[mappingname].ispersonal = ispersonal;
}

// Namespace zm_inventory/zm_inventory
// Params 0, eflags: 0x0
// Checksum 0xfbb4cffa, Offset: 0x2a0
// Size: 0x698
function function_8e8bbf18() {
    level.var_c67b847b = [];
    fields = zm_maptable::function_b710859c();
    if (!isdefined(fields) || !isdefined(fields.zm_inventory)) {
        return;
    }
    var_9cfc6132 = getscriptbundle(fields.zm_inventory);
    level.var_c67b847b = [];
    if (isdefined(var_9cfc6132.challenges) && isdefined(var_9cfc6132.var_7d71ea52)) {
        function_b6517d13(var_9cfc6132.var_7d71ea52, "ZMInventoryPersonal.ChallengesInfo.stage", 5, 1);
        if (isdefined(var_9cfc6132.var_f73f1212)) {
            function_b6517d13(var_9cfc6132.var_f73f1212, "ZMInventoryPersonal.ChallengesInfo.currentProgress", 5, 1);
        }
    }
    if (isdefined(var_9cfc6132.sentinelstages) && isdefined(var_9cfc6132.var_b34e1054)) {
        function_b6517d13(var_9cfc6132.var_b34e1054, "ZMInventory.ObjProgInfo.Eye.stage", 2);
    }
    if (isdefined(var_9cfc6132.objprogitems) && isdefined(var_9cfc6132.var_2560677)) {
        function_b6517d13(var_9cfc6132.var_2560677, "ZMInventory.ObjProgInfo.Ring.stage", 4);
    }
    if (isdefined(var_9cfc6132.packapunchitems)) {
        for (i = 0; i < var_9cfc6132.packapunchitems.size; i++) {
            item = var_9cfc6132.packapunchitems[i];
            if (isdefined(item.clientfield)) {
                clientfield = "ZMInventory.PaPItems." + i + 1 + ".stage";
                function_b6517d13(item.clientfield, clientfield, 2);
            }
        }
    }
    if (isdefined(var_9cfc6132.wonderweaponphases)) {
        if (isdefined(var_9cfc6132.var_84735203)) {
            function_b6517d13(var_9cfc6132.var_84735203, "ZMInventory.WonderWeaponPhaseInfo.phase", 1);
        }
        var_35163ee6 = -1;
        var_48d39e6d = -1;
        index = 1;
        for (p = 0; p < var_9cfc6132.wonderweaponphases.size; p++) {
            phase = var_9cfc6132.wonderweaponphases[p];
            for (c = 0; c < phase.components.size; c++) {
                component = phase.components[c];
                if (isdefined(component.clientfield)) {
                    var_9dd15afb = "ZMInventory.WonderWeaponItems." + index + ".stage";
                    function_b6517d13(phase.components[c].clientfield, var_9dd15afb, 2);
                }
                if (isdefined(component.var_db30d9f6)) {
                    var_db30d9f6 = "ZMInventory.WonderWeaponItems." + index + ".numAcquired";
                    function_b6517d13(component.var_db30d9f6, var_db30d9f6, 2);
                }
                index++;
            }
        }
    }
    if (isdefined(var_9cfc6132.shieldpieces)) {
        for (p = 0; p < var_9cfc6132.shieldpieces.size; p++) {
            if (isdefined(var_9cfc6132.shieldpieces[p].clientfield)) {
                clientfield = "ZMInventory.ShieldPieces." + p + 1 + ".stage";
                function_b6517d13(var_9cfc6132.shieldpieces[p].clientfield, clientfield, 1);
            }
        }
    }
    if (isdefined(var_9cfc6132.quests)) {
        for (q = 0; q < var_9cfc6132.quests.size; q++) {
            quest = var_9cfc6132.quests[q];
            if (isdefined(quest.var_de99eb59)) {
                var_cccc9d59 = "ZMInventory.QuestPhaseInfos." + q + 1 + ".phase";
                function_b6517d13(var_9cfc6132.quests[q].var_de99eb59, var_cccc9d59, 1);
            }
            var_fc664c99 = "ZMInventory.Quest" + q + 1;
            index = 1;
            for (p = 0; p < quest.phases.size; p++) {
                phase = quest.phases[p];
                for (i = 0; i < phase.items.size; i++) {
                    if (isdefined(phase.items[i].clientfield)) {
                        var_9dd15afb = var_fc664c99 + "." + index + ".stage";
                        function_b6517d13(phase.items[i].clientfield, var_9dd15afb, 2);
                    }
                    index++;
                }
            }
        }
    }
}

