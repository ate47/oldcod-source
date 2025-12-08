#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/hive_gun;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/mp_common/forward_spawn;

#namespace globallogic;

// Namespace globallogic/globallogic
// Params 0, eflags: 0x2
// Checksum 0x6baf9ae2, Offset: 0x410
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "globallogic", &__init__, undefined, "visionset_mgr" );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xfeb52c9f, Offset: 0x450
// Size: 0x364
function __init__()
{
    visionset_mgr::register_visionset_info( "mpintro", 1, 31, undefined, "mpintro" );
    clientfield::register( "world", "game_ended", 1, 1, "int", &game_ended, 1, 1 );
    clientfield::register( "world", "post_game", 1, 1, "int", &post_game, 1, 1 );
    registerclientfield( "playercorpse", "firefly_effect", 1, 2, "int", &firefly_effect_cb, 0 );
    registerclientfield( "playercorpse", "annihilate_effect", 1, 1, "int", &annihilate_effect_cb, 0 );
    registerclientfield( "playercorpse", "pineapplegun_effect", 1, 1, "int", &pineapplegun_effect_cb, 0 );
    registerclientfield( "actor", "annihilate_effect", 1, 1, "int", &annihilate_effect_cb, 0 );
    registerclientfield( "actor", "pineapplegun_effect", 1, 1, "int", &pineapplegun_effect_cb, 0 );
    clientfield::register( "worlduimodel", "hudItems.alliesRoundsWon", 1, 4, "int", undefined, 0, 0 );
    clientfield::register( "worlduimodel", "hudItems.axisRoundsWon", 1, 4, "int", undefined, 0, 0 );
    clientfield::register( "worlduimodel", "hudItems.alliesLivesCount", 1, 8, "int", undefined, 0, 0 );
    clientfield::register( "worlduimodel", "hudItems.axisLivesCount", 1, 8, "int", undefined, 0, 0 );
    level._effect[ "annihilate_explosion" ] = "weapon/fx_hero_annhilatr_death_blood";
    level._effect[ "pineapplegun_explosion" ] = "weapon/fx_hero_pineapple_death_blood";
    level.gameended = 0;
    level.postgame = 0;
    level.new_health_model = getdvarint( "new_health_model", 1 ) > 0;
}

// Namespace globallogic/globallogic
// Params 7
// Checksum 0x4d021eda, Offset: 0x7c0
// Size: 0x74
function game_ended( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval && !level.gameended )
    {
        level notify( #"game_ended" );
        level.gameended = 1;
    }
}

// Namespace globallogic/globallogic
// Params 7
// Checksum 0x65a3342, Offset: 0x840
// Size: 0x74
function post_game( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval && !level.postgame )
    {
        level notify( #"post_game" );
        level.postgame = 1;
    }
}

// Namespace globallogic/globallogic
// Params 7
// Checksum 0x90844c83, Offset: 0x8c0
// Size: 0x6c
function firefly_effect_cb( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( bnewent && newval )
    {
        self thread hive_gun::function_efe10ed8( localclientnum, newval );
    }
}

// Namespace globallogic/globallogic
// Params 7
// Checksum 0x10b51f0e, Offset: 0x938
// Size: 0x184
function annihilate_effect_cb( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval && !oldval )
    {
        where = self gettagorigin( "J_SpineLower" );
        
        if ( !isdefined( where ) )
        {
            where = self.origin;
        }
        
        where += ( 0, 0, -40 );
        character_index = self getcharacterbodytype();
        fields = getcharacterfields( character_index, currentsessionmode() );
        
        if ( fields.fullbodyexplosion != "" )
        {
            if ( util::is_mature() && !util::is_gib_restricted_build() )
            {
                playfx( localclientnum, fields.fullbodyexplosion, where );
            }
            
            playfx( localclientnum, "explosions/fx_exp_grenade_default", where );
        }
    }
}

// Namespace globallogic/globallogic
// Params 7
// Checksum 0x600b8b98, Offset: 0xac8
// Size: 0xdc
function pineapplegun_effect_cb( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval && !oldval )
    {
        where = self gettagorigin( "J_SpineLower" );
        
        if ( !isdefined( where ) )
        {
            where = self.origin;
        }
        
        if ( isdefined( level._effect[ "pineapplegun_explosion" ] ) )
        {
            playfx( localclientnum, level._effect[ "pineapplegun_explosion" ], where );
        }
    }
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0xa54ad642, Offset: 0xbb0
// Size: 0x48
function function_17f0b9e4( localclientnum )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( "start_plant_sound" );
        self thread play_plant_sound( localclientnum );
    }
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x72ae7b51, Offset: 0xc00
// Size: 0x150
function play_plant_sound( localclientnum )
{
    self notify( #"play_plant_sound" );
    self endon( #"play_plant_sound" );
    self endon( #"death" );
    self endon( #"stop_plant_sound" );
    player = getlocalplayer( localclientnum );
    var_f919f008 = getweapon( "briefcase_bomb" );
    var_26f401f = getweapon( "briefcase_bomb_defuse" );
    wait 0.25;
    
    while ( true )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( player.weapon != var_f919f008 && player.weapon != var_26f401f )
        {
            return;
        }
        
        if ( player != self || isthirdperson( localclientnum ) )
        {
            self playsound( localclientnum, "fly_bomb_buttons_npc" );
        }
        
        wait 0.15;
    }
}

