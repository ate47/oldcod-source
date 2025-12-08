#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\cp_common\bb;

#namespace dart_gun;

// Namespace dart_gun/dart_gun
// Params 0, eflags: 0x6
// Checksum 0x99084e40, Offset: 0xa8
// Size: 0x34
function private autoexec __init__system__()
{
    system::register( "dart_gun", &preinit, undefined, undefined, undefined );
}

// Namespace dart_gun/dart_gun
// Params 0, eflags: 0x4
// Checksum 0x9b8c37b1, Offset: 0xe8
// Size: 0x4c
function private preinit()
{
    level.var_fb71a7c4 = getweapon( "eq_dart_gun" );
    callback::add_weapon_damage( level.var_fb71a7c4, &function_bc51baa3 );
}

// Namespace dart_gun/dart_gun
// Params 5, eflags: 0x4
// Checksum 0xc05748fc, Offset: 0x140
// Size: 0xf4
function private function_bc51baa3( eattacker, *einflictor, *weapon, *meansofdeath, *damage )
{
    if ( is_true( self.is_hero ) )
    {
        return;
    }
    
    self notify( #"dart_gunned" );
    
    if ( isplayer( damage ) )
    {
        bb::function_cd497743( "dart_gunned", damage );
    }
    
    self endon( #"death" );
    
    if ( isdefined( self.var_66f1a336 ) )
    {
        self thread [[ self.var_66f1a336 ]]();
        return;
    }
    
    self startragdoll();
    wait 1;
    self kill();
}

// Namespace dart_gun/dart_gun
// Params 1
// Checksum 0xf5b011c7, Offset: 0x240
// Size: 0x1a
function function_adcf633a( callback )
{
    self.var_66f1a336 = callback;
}

