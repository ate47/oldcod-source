#using script_35ae72be7b4fec10;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;

#namespace land_mine_placed;

// Namespace land_mine_placed/land_mine_placed
// Params 0, eflags: 0x6
// Checksum 0x211154cc, Offset: 0x110
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"land_mine_placed", undefined, &init_postload, undefined, undefined );
}

// Namespace land_mine_placed/land_mine_placed
// Params 0
// Checksum 0xb3e9f12f, Offset: 0x158
// Size: 0xf4
function init_postload()
{
    var_cdb289d1 = getentarray( "land_mine_placed", "targetname" );
    array::thread_all( var_cdb289d1, &function_9d51d7af );
    level.var_577c9750 = { #weapon:getweapon( #"land_mine" ) };
    level.var_577c9750.var_f46e77d2 = getscriptbundle( level.var_577c9750.weapon.customsettings );
    callback::add_weapon_damage( level.var_577c9750.weapon, &function_72be8a4f );
}

// Namespace land_mine_placed/land_mine_placed
// Params 0
// Checksum 0x9b04dc8a, Offset: 0x258
// Size: 0x124
function function_9d51d7af()
{
    self endon( #"death" );
    self.t_proximity = spawn( "trigger_radius", self.origin, 0, 100, 16 );
    self util::create_cursor_hint( undefined, ( 0, 0, 1 ), #"hash_79be03e00c4c3770", 160, undefined, &function_2371350, undefined, 200, 5 );
    self.var_34a6745 = util::spawn_model( "tag_origin", self gettagorigin( "tag_fx" ) );
    playfxontag( "light/fx8_blink_red_sm", self.var_34a6745, "tag_origin" );
    self thread function_8108fc93();
    self thread function_dfea2d4b();
}

// Namespace land_mine_placed/land_mine_placed
// Params 0
// Checksum 0xff54b0ce, Offset: 0x388
// Size: 0x144
function function_fbf401a1()
{
    self setcandamage( 0 );
    self function_9a72f627( level.var_577c9750.var_f46e77d2.var_d9aa8220 );
    playsoundatposition( level.var_577c9750.var_f46e77d2.var_df4a92e4, self.origin );
    radiusdamage( self.origin, 200, 200, 100, self, "MOD_EXPLOSIVE", level.var_c4703397 );
    physicsexplosionsphere( self.origin, 200, 50, 1 );
    playrumbleonposition( #"hash_718ba886b3205e3f", self.origin );
    
    if ( isdefined( self.var_34a6745 ) )
    {
        self.var_34a6745 delete();
    }
    
    self delete();
}

// Namespace land_mine_placed/land_mine_placed
// Params 5
// Checksum 0x961ba515, Offset: 0x4d8
// Size: 0x6c
function function_72be8a4f( *eattacker, *einflictor, *weapon, *meansofdeath, *damage )
{
    if ( isplayer( self ) )
    {
        self shellshock( #"hash_160e95f6745dddf3", 0.5 );
    }
}

// Namespace land_mine_placed/land_mine_placed
// Params 0
// Checksum 0xdf5b90d3, Offset: 0x550
// Size: 0x9c
function function_dfea2d4b()
{
    self endon( #"death" );
    self setcandamage( 1 );
    self.health = 1000000;
    self waittill( #"damage" );
    self util::remove_cursor_hint( #"use" );
    wait 0.1;
    self thread function_fbf401a1();
}

// Namespace land_mine_placed/land_mine_placed
// Params 0
// Checksum 0x77fa118, Offset: 0x5f8
// Size: 0x16c
function function_8108fc93()
{
    self endoncallback( &function_dc857fe9, #"death", #"disarmed" );
    self.t_proximity waittill( #"trigger" );
    self util::remove_cursor_hint( #"use" );
    playsoundatposition( level.var_577c9750.var_f46e77d2.var_9a29cecd, self.origin );
    uid = scripted_widgets::create_waypoint( "c4", self, #"hud_icon_c4", undefined, ( 0, 0, 1 ), undefined, 0 );
    scripted_widgets::function_fdb73881( uid, 180, 200 );
    scripted_widgets::set_state( uid, 1 );
    self.var_c1286f25 = uid;
    
    if ( isdefined( self.var_34a6745 ) )
    {
        self.var_34a6745 delete();
    }
    
    wait 0.5;
    self function_3a68b759();
}

// Namespace land_mine_placed/land_mine_placed
// Params 0
// Checksum 0x9b7bfc1d, Offset: 0x770
// Size: 0x1ec
function function_3a68b759()
{
    self endon( #"death" );
    self function_9a72f627( level.var_577c9750.var_f46e77d2.var_5afd2a1d );
    playsoundatposition( level.var_577c9750.var_f46e77d2.var_69029368, self.origin );
    scripted_widgets::function_309bf7c2( self.var_c1286f25, #"hud_icon_c4_red" );
    self moveto( self.origin + ( 0, 0, level.var_577c9750.var_f46e77d2.var_1065654c ), level.var_577c9750.var_f46e77d2.var_564c2203, 0, level.var_577c9750.var_f46e77d2.var_564c2203 );
    self waittilltimeout( level.var_577c9750.var_f46e77d2.var_564c2203, #"movedone" );
    self moveto( self.origin - ( 0, 0, level.var_577c9750.var_f46e77d2.var_b140445d ), level.var_577c9750.var_f46e77d2.var_dfc89b2a, level.var_577c9750.var_f46e77d2.var_dfc89b2a, 0 );
    self waittilltimeout( level.var_577c9750.var_f46e77d2.var_dfc89b2a, #"movedone" );
    self function_fbf401a1();
}

// Namespace land_mine_placed/land_mine_placed
// Params 1
// Checksum 0x3471c249, Offset: 0x968
// Size: 0x44
function function_2371350( *s_info )
{
    self notify( #"disarmed" );
    
    if ( isdefined( self.var_34a6745 ) )
    {
        self.var_34a6745 delete();
    }
}

// Namespace land_mine_placed/land_mine_placed
// Params 1
// Checksum 0xa81fd2c8, Offset: 0x9b8
// Size: 0x4c
function function_dc857fe9( *s_notify )
{
    if ( isdefined( self.var_c1286f25 ) )
    {
        level scripted_widgets::remove( self.var_c1286f25 );
    }
    
    self.t_proximity delete();
}

// Namespace land_mine_placed/land_mine_placed
// Params 1
// Checksum 0x17be0b72, Offset: 0xa10
// Size: 0xac
function function_9a72f627( var_7a91115e )
{
    a_trace = groundtrace( self.origin + ( 0, 0, 70 ), self.origin + ( 0, 0, -100 ), 0, self );
    str_fx = self getfxfromsurfacetable( var_7a91115e, a_trace[ #"surfacetype" ] );
    playfx( str_fx, self.origin );
}

