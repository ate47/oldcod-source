#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace gadget_self_destruct;

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 0, eflags: 0x2
// Checksum 0xe0d71d07, Offset: 0x220
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_self_destruct", &__init__, undefined, undefined);
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 0, eflags: 0x0
// Checksum 0x44a16afb, Offset: 0x260
// Size: 0x134
function __init__() {
    ability_player::register_gadget_activation_callbacks(55, &gadget_self_destruct_on, &gadget_self_destruct_off);
    ability_player::register_gadget_possession_callbacks(55, &gadget_self_destruct_on_give, &gadget_self_destruct_on_take);
    ability_player::register_gadget_flicker_callbacks(55, &gadget_self_destruct_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(55, &gadget_self_destruct_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(55, &gadget_self_destruct_is_flickering);
    callback::on_connect(&gadget_self_destruct_on_connect);
    callback::on_spawned(&on_player_spawned);
    clientfield::register("scriptmover", "death_fx", 1, 1, "int");
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3a0
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 1, eflags: 0x0
// Checksum 0xd4d8f31d, Offset: 0x3b0
// Size: 0x22
function gadget_self_destruct_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 1, eflags: 0x0
// Checksum 0x72d1da2c, Offset: 0x3e0
// Size: 0x22
function gadget_self_destruct_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 2, eflags: 0x0
// Checksum 0xf169276b, Offset: 0x410
// Size: 0x14
function gadget_self_destruct_on_flicker(slot, weapon) {
    
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 2, eflags: 0x0
// Checksum 0x22f7b167, Offset: 0x430
// Size: 0x14
function gadget_self_destruct_on_give(slot, weapon) {
    
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 2, eflags: 0x0
// Checksum 0x142129ac, Offset: 0x450
// Size: 0x14
function gadget_self_destruct_on_take(slot, weapon) {
    
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x470
// Size: 0x4
function gadget_self_destruct_on_connect() {
    
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 2, eflags: 0x0
// Checksum 0x8a980ab7, Offset: 0x480
// Size: 0x44
function gadget_self_destruct_on(slot, weapon) {
    self thread watch_player_self_destruct();
    self thread watch_player_cancel();
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 2, eflags: 0x0
// Checksum 0x53317a25, Offset: 0x4d0
// Size: 0x14
function gadget_self_destruct_off(slot, weapon) {
    
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 0, eflags: 0x0
// Checksum 0x52db9917, Offset: 0x4f0
// Size: 0xd4
function watch_player_self_destruct() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"self_destruct_cancelled");
    self disableweapons();
    self setclientthirdperson(1);
    wait 5;
    origin = self geteye();
    self destruct_fx();
    radiusdamage(origin, 500, 500, 500, self, "MOD_EXPLOSIVE");
    self kill();
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 0, eflags: 0x0
// Checksum 0xbb5b486, Offset: 0x5d0
// Size: 0x174
function destruct_fx() {
    origin = self geteye();
    direction = anglestoforward(self getplayerangles());
    if (direction == (0, 0, 0)) {
        direction = (0, 0, 1);
    }
    dirvec = vectornormalize(direction);
    angles = vectortoangles(dirvec);
    fxorg = spawn("script_model", origin + (0, 0, -30), 0, angles);
    fxorg.angles = angles;
    fxorg setowner(self);
    fxorg setmodel("tag_origin");
    fxorg clientfield::set("death_fx", 1);
    level thread heat_wave_fx_cleanup(fxorg);
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 1, eflags: 0x0
// Checksum 0x511af48a, Offset: 0x750
// Size: 0x54
function heat_wave_fx_cleanup(fxorg) {
    wait 5;
    if (isdefined(fxorg)) {
        fxorg clientfield::set("heatwave_fx", 0);
        fxorg delete();
    }
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 0, eflags: 0x0
// Checksum 0x9d8d0b2e, Offset: 0x7b0
// Size: 0xb8
function watch_player_cancel() {
    self endon(#"death");
    self endon(#"disconnect");
    starttime = gettime();
    while (true) {
        if (!self usebuttonpressed()) {
            starttime = gettime();
        }
        if (starttime + 0.5 < gettime()) {
            self notify(#"self_destruct_cancelled");
            self setclientthirdperson(0);
            self enableweapons();
            return;
        }
        waitframe(1);
    }
}

