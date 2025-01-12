#using scripts\core_common\clientfield_shared;

#namespace archetype_human;

// Namespace archetype_human/archetype_human
// Params 0, eflags: 0x2
// Checksum 0x80f724d1, Offset: 0x88
// Size: 0x4
function autoexec precache() {
    
}

// Namespace archetype_human/archetype_human
// Params 0, eflags: 0x2
// Checksum 0x69618471, Offset: 0x98
// Size: 0x4c
function autoexec main() {
    clientfield::register("actor", "facial_dial", 1, 1, "int", &humanclientutils::facialdialoguehandler, 0, 1);
}

#namespace humanclientutils;

// Namespace humanclientutils/archetype_human
// Params 7, eflags: 0x0
// Checksum 0x30f1b59a, Offset: 0xf0
// Size: 0x94
function facialdialoguehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self.facialdialogueactive = 1;
        return;
    }
    if (isdefined(self.facialdialogueactive) && self.facialdialogueactive) {
        self clearanim(#"faces", 0);
    }
}

