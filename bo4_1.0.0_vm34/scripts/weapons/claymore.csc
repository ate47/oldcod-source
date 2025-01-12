#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace claymore;

// Namespace claymore/claymore
// Params 0, eflags: 0x2
// Checksum 0xdb71169b, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"claymore", &__init__, undefined, undefined);
}

// Namespace claymore/claymore
// Params 0, eflags: 0x0
// Checksum 0xd42a3118, Offset: 0xd0
// Size: 0x34
function __init__() {
    callback::add_weapon_type(#"claymore", &claymore_spawned);
}

// Namespace claymore/claymore
// Params 1, eflags: 0x0
// Checksum 0xc6c76534, Offset: 0x110
// Size: 0xc8
function claymore_spawned(localclientnum) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    while (true) {
        if (isdefined(self.stunned) && self.stunned) {
            wait 0.1;
            continue;
        }
        self.claymorelaserfxid = util::playfxontag(localclientnum, #"_t6/weapon/claymore/fx_claymore_laser", self, "tag_fx");
        self waittill(#"stunned");
        stopfx(localclientnum, self.claymorelaserfxid);
    }
}

