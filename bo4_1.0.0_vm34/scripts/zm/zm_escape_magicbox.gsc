#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_escape_pebble;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace zm_escape_magicbox;

// Namespace zm_escape_magicbox/zm_escape_magicbox
// Params 0, eflags: 0x2
// Checksum 0x19690c3b, Offset: 0xf8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_escape_magicbox", &__init__, &__main__, undefined);
}

// Namespace zm_escape_magicbox/zm_escape_magicbox
// Params 0, eflags: 0x0
// Checksum 0x8eeeca3f, Offset: 0x148
// Size: 0x6e
function __init__() {
    level.locked_magic_box_cost = 2000;
    level.custom_magicbox_state_handler = &set_locked_magicbox_state;
    level.var_b954edb = &watch_for_lock;
    level.var_4c4bfda = &clean_up_locked_box;
    level.custom_firesale_box_leave = 1;
}

// Namespace zm_escape_magicbox/zm_escape_magicbox
// Params 0, eflags: 0x0
// Checksum 0xb67e0eca, Offset: 0x1c0
// Size: 0x36
function __main__() {
    level.chest_joker_model = #"hash_4b77dcb67eb0dc91";
    level.chest_joker_custom_movement = &custom_joker_movement;
}

// Namespace zm_escape_magicbox/zm_escape_magicbox
// Params 0, eflags: 0x0
// Checksum 0x4548508c, Offset: 0x200
// Size: 0x240
function custom_joker_movement() {
    v_origin = self.weapon_model.origin - (0, 0, 5);
    self.weapon_model delete();
    mdl_lock = util::spawn_model(level.chest_joker_model, v_origin, self.angles + (0, 180, 0));
    mdl_lock.targetname = "box_lock";
    mdl_lock setcandamage(1);
    level.var_b4b81bee[#"box_lock"] = &pebble::function_c665b7a3;
    level notify(#"hash_219aba01ff2d6de4");
    playsoundatposition(#"hash_7c7d8771a48e8871", mdl_lock.origin);
    wait 0.5;
    level notify(#"weapon_fly_away_start");
    wait 1;
    mdl_lock rotateyaw(3000, 4, 4);
    wait 3;
    mdl_lock movez(20, 0.5, 0.5);
    mdl_lock waittill(#"movedone");
    mdl_lock movez(-100, 0.5, 0.5);
    mdl_lock waittill(#"movedone");
    level notify(#"hash_3698278a3a5d8beb");
    mdl_lock delete();
    self notify(#"box_moving");
    level notify(#"weapon_fly_away_end");
}

// Namespace zm_escape_magicbox/zm_escape_magicbox
// Params 0, eflags: 0x0
// Checksum 0x109a671d, Offset: 0x448
// Size: 0xac
function watch_for_lock() {
    self endon(#"user_grabbed_weapon", #"chest_accessed");
    self waittill(#"box_locked");
    self notify(#"kill_chest_think");
    self.grab_weapon_hint = 0;
    self.chest_user = undefined;
    wait 0.1;
    self thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think);
    self thread zm_magicbox::treasure_chest_think();
}

// Namespace zm_escape_magicbox/zm_escape_magicbox
// Params 0, eflags: 0x0
// Checksum 0xa9fbf54b, Offset: 0x500
// Size: 0xfc
function clean_up_locked_box() {
    self endon(#"box_spin_done");
    self.owner waittill(#"box_locked");
    if (isdefined(self.weapon_model)) {
        self.weapon_model delete();
        self.weapon_model = undefined;
    }
    if (isdefined(self.weapon_model_dw)) {
        self.weapon_model_dw delete();
        self.weapon_model_dw = undefined;
    }
    self hidezbarrierpiece(3);
    self hidezbarrierpiece(4);
    self setzbarrierpiecestate(3, "closed");
    self setzbarrierpiecestate(4, "closed");
}

// Namespace zm_escape_magicbox/zm_escape_magicbox
// Params 0, eflags: 0x0
// Checksum 0xa2ee651f, Offset: 0x608
// Size: 0xce
function magic_box_locks() {
    self.owner.is_locked = 1;
    self.owner notify(#"box_locked");
    self playsound(#"zmb_hellbox_lock");
    self clientfield::set("magicbox_open_fx", 0);
    self setzbarrierpiecestate(5, "closing");
    while (self getzbarrierpiecestate(5) == "closing") {
        wait 0.5;
    }
    self notify(#"locked");
}

// Namespace zm_escape_magicbox/zm_escape_magicbox
// Params 0, eflags: 0x0
// Checksum 0x35d4c3a8, Offset: 0x6e0
// Size: 0xe6
function magic_box_unlocks() {
    self playsound(#"zmb_hellbox_unlock");
    self setzbarrierpiecestate(5, "opening");
    while (self getzbarrierpiecestate(5) == "opening") {
        wait 0.5;
    }
    self setzbarrierpiecestate(2, "closed");
    self showzbarrierpiece(2);
    self hidezbarrierpiece(5);
    self notify(#"unlocked");
    self.owner.is_locked = undefined;
}

// Namespace zm_escape_magicbox/zm_escape_magicbox
// Params 1, eflags: 0x0
// Checksum 0x26344b86, Offset: 0x7d0
// Size: 0xc2
function set_locked_magicbox_state(state) {
    switch (state) {
    case #"locking":
        self showzbarrierpiece(5);
        self thread magic_box_locks();
        self.state = "locking";
        break;
    case #"unlocking":
        self showzbarrierpiece(5);
        self thread magic_box_unlocks();
        self.state = "close";
        break;
    }
}

/#

    // Namespace zm_escape_magicbox/zm_escape_magicbox
    // Params 0, eflags: 0x0
    // Checksum 0x7b679b29, Offset: 0x8a0
    // Size: 0x13c
    function function_53e28451() {
        level flagsys::wait_till("<dev string:x30>");
        e_box = undefined;
        for (i = 0; i < level.chests.size; i++) {
            if (isdefined(level.chests[i].zbarrier.state === "<dev string:x49>") && level.chests[i].zbarrier.state === "<dev string:x49>") {
                e_box = level.chests[i];
                break;
            }
        }
        if (isdefined(e_box)) {
            while (distance(level.players[0].origin, e_box.origin) > 128) {
                wait 1;
            }
            e_box.zbarrier zm_magicbox::set_magic_box_zbarrier_state("<dev string:x51>");
        }
    }

#/
