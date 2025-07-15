#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_safehouse;
#using scripts/cp/_util;
#using scripts/cp/cp_sh_singapore_fx;
#using scripts/cp/cp_sh_singapore_sound;
#using scripts/shared/util_shared;

#namespace cp_sh_singapore;

// Namespace cp_sh_singapore
// Params 0
// Checksum 0xeef1fa92, Offset: 0x138
// Size: 0x42
function main()
{
    cp_sh_singapore_fx::main();
    cp_sh_singapore_sound::main();
    load::main();
    util::waitforclient( 0 );
}

