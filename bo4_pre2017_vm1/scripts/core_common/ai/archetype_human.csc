#using scripts/core_common/ai/systems/fx_character;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/util_shared;

#namespace archetype_human;

// Namespace archetype_human/archetype_human
// Params 0, eflags: 0x2
// Checksum 0x80f724d1, Offset: 0x1a0
// Size: 0x4
function autoexec precache() {
    
}

// Namespace archetype_human/archetype_human
// Params 0, eflags: 0x2
// Checksum 0xdda68088, Offset: 0x1b0
// Size: 0x4c
function autoexec main() {
    clientfield::register("actor", "facial_dial", 1, 1, "int", &humanclientutils::facialdialoguehandler, 0, 1);
}

#namespace humanclientutils;

// Namespace humanclientutils/archetype_human
// Params 7, eflags: 0x0
// Checksum 0x516e13b2, Offset: 0x208
// Size: 0x9c
function facialdialoguehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self.facialdialogueactive = 1;
        return;
    }
    if (isdefined(self.facialdialogueactive) && self.facialdialogueactive) {
        self clearanim(generic%faces, 0);
    }
}

