#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/trigger_shared;

#namespace cp_mi_sing_biodomes2_fx;

// Namespace cp_mi_sing_biodomes2_fx
// Params 0
// Checksum 0xd9dba999, Offset: 0x170
// Size: 0x22
function main()
{
    clientfields_init();
    precache_scripted_fx();
}

// Namespace cp_mi_sing_biodomes2_fx
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x1a0
// Size: 0x2
function clientfields_init()
{
    
}

// Namespace cp_mi_sing_biodomes2_fx
// Params 0
// Checksum 0xf75c04b9, Offset: 0x1b0
// Size: 0x1b
function precache_scripted_fx()
{
    level._effect[ "underwater_motes" ] = "dirt/fx_dust_motes_player_loop_uw";
}

