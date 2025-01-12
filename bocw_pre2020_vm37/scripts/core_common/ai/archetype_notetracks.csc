#using scripts\core_common\ai_shared;

#namespace notetracks;

// Namespace notetracks/archetype_notetracks
// Params 0, eflags: 0x2
// Checksum 0xeb6af14, Offset: 0xe0
// Size: 0x6c
function autoexec main() {
    if (sessionmodeiszombiesgame() && getdvarint(#"splitscreen_playercount", 0) > 2) {
        return;
    }
    ai::add_ai_spawn_function(&initializenotetrackhandlers);
}

// Namespace notetracks/archetype_notetracks
// Params 1, eflags: 0x5 linked
// Checksum 0x29e64b69, Offset: 0x158
// Size: 0x84
function private initializenotetrackhandlers(localclientnum) {
    addsurfacenotetrackfxhandler(localclientnum, "jumping", "surfacefxtable_jumping");
    addsurfacenotetrackfxhandler(localclientnum, "landing", "surfacefxtable_landing");
    addsurfacenotetrackfxhandler(localclientnum, "vtol_landing", "surfacefxtable_vtollanding");
}

// Namespace notetracks/archetype_notetracks
// Params 3, eflags: 0x5 linked
// Checksum 0x9d248ef5, Offset: 0x1e8
// Size: 0x44
function private addsurfacenotetrackfxhandler(localclientnum, notetrack, surfacetable) {
    entity = self;
    entity thread handlesurfacenotetrackfx(localclientnum, notetrack, surfacetable);
}

// Namespace notetracks/archetype_notetracks
// Params 3, eflags: 0x5 linked
// Checksum 0x14c27a36, Offset: 0x238
// Size: 0xa0
function private handlesurfacenotetrackfx(localclientnum, notetrack, surfacetable) {
    entity = self;
    entity endon(#"death");
    while (true) {
        entity waittill(notetrack);
        fxname = entity getaifxname(localclientnum, surfacetable);
        if (isdefined(fxname)) {
            playfx(localclientnum, fxname, entity.origin);
        }
    }
}

