#using scripts/codescripts/struct;

#namespace cp_mi_sing_biodomes_sound;

// Namespace cp_mi_sing_biodomes_sound
// Params 0
// Checksum 0xb5925730, Offset: 0x98
// Size: 0x12
function main()
{
    thread party_stop();
}

// Namespace cp_mi_sing_biodomes_sound
// Params 0
// Checksum 0x28e125d0, Offset: 0xb8
// Size: 0xb
function party_stop()
{
    level notify( #"no_party" );
}

