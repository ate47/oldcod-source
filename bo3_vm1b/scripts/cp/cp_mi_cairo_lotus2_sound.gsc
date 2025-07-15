#using scripts/codescripts/struct;
#using scripts/shared/music_shared;

#namespace cp_mi_cairo_lotus2_sound;

// Namespace cp_mi_cairo_lotus2_sound
// Params 0
// Checksum 0xa471ad83, Offset: 0x178
// Size: 0x22
function main()
{
    level thread lotus2_sound::function_82e83534();
    level thread lotus2_sound::function_cd6d8f17();
}

#namespace lotus2_sound;

// Namespace lotus2_sound
// Params 0
// Checksum 0xbd38f719, Offset: 0x1a8
// Size: 0x1a
function function_8836c025()
{
    music::setmusicstate( "lotus2_intro" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0xabc50299, Offset: 0x1d0
// Size: 0x1a
function function_fd00a4f2()
{
    music::setmusicstate( "breach_stinger" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x318cc9f7, Offset: 0x1f8
// Size: 0x1a
function function_51e72857()
{
    music::setmusicstate( "battle_two" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x5bcd4b11, Offset: 0x220
// Size: 0x1a
function function_614dc783()
{
    music::setmusicstate( "elevator_tension" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0xb6699bc7, Offset: 0x248
// Size: 0x1a
function function_8ca46216()
{
    music::setmusicstate( "post_elevator_battle" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x282274d2, Offset: 0x270
// Size: 0x1a
function function_a3388bcf()
{
    music::setmusicstate( "pre_igc" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0xa51b6359, Offset: 0x298
// Size: 0x1a
function function_c954e9a2()
{
    music::setmusicstate( "post_igc_drama" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0xeb7469a5, Offset: 0x2c0
// Size: 0x1a
function function_208b0a38()
{
    music::setmusicstate( "robot_hole_stinger" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x909be6d, Offset: 0x2e8
// Size: 0x1a
function function_1d1fd3af()
{
    music::setmusicstate( "epic_reveal_stinger" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0xaa0258ab, Offset: 0x310
// Size: 0x1a
function function_12202095()
{
    music::setmusicstate( "battle_three" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x696a0732, Offset: 0x338
// Size: 0x1a
function function_beaa78ac()
{
    music::setmusicstate( "post_vtol_crash" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x965dd514, Offset: 0x360
// Size: 0x1a
function function_973b77f9()
{
    music::setmusicstate( "none" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0xa8045b17, Offset: 0x388
// Size: 0x22
function function_cd6d8f17()
{
    level waittill( #"hash_d77cf6d0" );
    music::setmusicstate( "none" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0xf0c76dbc, Offset: 0x3b8
// Size: 0x22
function function_82e83534()
{
    level waittill( #"hash_23be1ef" );
    music::setmusicstate( "frozen_forest" );
}

