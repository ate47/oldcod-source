#using scripts\core_common\util_shared;

#namespace sound;

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0x93753f06, Offset: 0x98
// Size: 0x94
function loop_fx_sound(alias, origin, ender) {
    org = spawn("script_origin", (0, 0, 0));
    if (isdefined(ender)) {
        thread loop_delete(ender, org);
        self endon(ender);
    }
    org.origin = origin;
    org playloopsound(alias);
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0xafc38d73, Offset: 0x138
// Size: 0x4c
function loop_delete(ender, ent) {
    ent endon(#"death");
    self waittill(ender);
    ent delete();
}

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0xbcf441d4, Offset: 0x190
// Size: 0xc4
function play_in_space(alias, origin, master) {
    org = spawn("script_origin", (0, 0, 1));
    if (!isdefined(origin)) {
        origin = self.origin;
    }
    org.origin = origin;
    org playsoundwithnotify(alias, "sounddone");
    org waittill(#"sounddone");
    if (isdefined(org)) {
        org delete();
    }
}

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0x7412f847, Offset: 0x260
// Size: 0x154
function loop_on_tag(alias, tag, bstopsoundondeath) {
    org = spawn("script_origin", (0, 0, 0));
    org endon(#"death");
    if (!isdefined(bstopsoundondeath)) {
        bstopsoundondeath = 1;
    }
    if (bstopsoundondeath) {
        thread util::delete_on_death(org);
    }
    if (isdefined(tag)) {
        org linkto(self, tag, (0, 0, 0), (0, 0, 0));
    } else {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto(self);
    }
    org playloopsound(alias);
    self waittill("stop sound" + alias);
    org stoploopsound(alias);
    org delete();
}

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0x3e3a7f54, Offset: 0x3c0
// Size: 0x19c
function play_on_tag(alias, tag, ends_on_death) {
    org = spawn("script_origin", (0, 0, 0));
    org endon(#"death");
    thread delete_on_death_wait(org, "sounddone");
    if (isdefined(tag)) {
        org.origin = self gettagorigin(tag);
        org linkto(self, tag, (0, 0, 0), (0, 0, 0));
    } else {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto(self);
    }
    org playsoundwithnotify(alias, "sounddone");
    if (isdefined(ends_on_death)) {
        assert(ends_on_death, "<dev string:x30>");
        wait_for_sounddone_or_death(org);
        waitframe(1);
    } else {
        org waittill(#"sounddone");
    }
    org delete();
}

// Namespace sound/sound_shared
// Params 1, eflags: 0x0
// Checksum 0x158e3209, Offset: 0x568
// Size: 0x24
function play_on_entity(alias) {
    play_on_tag(alias);
}

// Namespace sound/sound_shared
// Params 1, eflags: 0x0
// Checksum 0x51ec0b74, Offset: 0x598
// Size: 0x34
function wait_for_sounddone_or_death(org) {
    self endon(#"death");
    org waittill(#"sounddone");
}

// Namespace sound/sound_shared
// Params 1, eflags: 0x0
// Checksum 0x67a89e33, Offset: 0x5d8
// Size: 0x20
function stop_loop_on_entity(alias) {
    self notify("stop sound" + alias);
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0xfcf937bb, Offset: 0x600
// Size: 0x14c
function loop_on_entity(alias, offset) {
    org = spawn("script_origin", (0, 0, 0));
    org endon(#"death");
    thread util::delete_on_death(org);
    if (isdefined(offset)) {
        org.origin = self.origin + offset;
        org.angles = self.angles;
        org linkto(self);
    } else {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto(self);
    }
    org playloopsound(alias);
    self waittill("stop sound" + alias);
    org stoploopsound(0.1);
    org delete();
}

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0xa62b39ad, Offset: 0x758
// Size: 0xc4
function loop_in_space(alias, origin, ender) {
    org = spawn("script_origin", (0, 0, 1));
    if (!isdefined(origin)) {
        origin = self.origin;
    }
    org.origin = origin;
    org playloopsound(alias);
    level waittill(ender);
    org stoploopsound();
    wait 0.1;
    org delete();
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0xaea8a93d, Offset: 0x828
// Size: 0x5c
function delete_on_death_wait(ent, sounddone) {
    ent endon(#"death");
    self waittill(#"death");
    if (isdefined(ent)) {
        ent delete();
    }
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0xedb215f4, Offset: 0x890
// Size: 0x17e
function play_on_players(sound, team) {
    assert(isdefined(level.players));
    if (level.splitscreen) {
        if (isdefined(level.players[0])) {
            level.players[0] playlocalsound(sound);
        }
        return;
    }
    if (isdefined(team)) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
                player playlocalsound(sound);
            }
        }
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        level.players[i] playlocalsound(sound);
    }
}

