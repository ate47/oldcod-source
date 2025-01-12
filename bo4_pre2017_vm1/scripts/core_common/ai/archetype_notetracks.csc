#using scripts/core_common/ai_shared;
#using scripts/core_common/util_shared;

#namespace notetracks;

// Namespace notetracks/archetype_notetracks
// Params 0, eflags: 0x2
// Checksum 0x11e02338, Offset: 0x150
// Size: 0x8c
function autoexec main() {
    if (sessionmodeiszombiesgame() && getdvarint("splitscreen_playerCount") > 2) {
        return;
    }
    if (sessionmodeiscampaigndeadopsgame() && getdvarint("splitscreen_playerCount") > 2) {
        return;
    }
    ai::add_ai_spawn_function(&initializenotetrackhandlers);
}

// Namespace notetracks/archetype_notetracks
// Params 1, eflags: 0x4
// Checksum 0xbd0e4d6a, Offset: 0x1e8
// Size: 0x84
function private initializenotetrackhandlers(localclientnum) {
    addsurfacenotetrackfxhandler(localclientnum, "jumping", "surfacefxtable_jumping");
    addsurfacenotetrackfxhandler(localclientnum, "landing", "surfacefxtable_landing");
    addsurfacenotetrackfxhandler(localclientnum, "vtol_landing", "surfacefxtable_vtollanding");
}

// Namespace notetracks/archetype_notetracks
// Params 3, eflags: 0x4
// Checksum 0x9bfdf00e, Offset: 0x278
// Size: 0x4c
function private addsurfacenotetrackfxhandler(localclientnum, notetrack, surfacetable) {
    entity = self;
    entity thread handlesurfacenotetrackfx(localclientnum, notetrack, surfacetable);
}

// Namespace notetracks/archetype_notetracks
// Params 3, eflags: 0x4
// Checksum 0x48cf628a, Offset: 0x2d0
// Size: 0xb0
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

