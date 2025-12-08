#using script_27ef3076a14eb66a;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\load;

#namespace snipercam;

// Namespace snipercam/snipercam
// Params 0, eflags: 0x6
// Checksum 0xf6257d5, Offset: 0x110
// Size: 0x34
function private autoexec __init__system__()
{
    system::register( "snipercam", &function_f64316de, undefined, undefined, undefined );
}

// Namespace snipercam/snipercam
// Params 3
// Checksum 0x285ea484, Offset: 0x150
// Size: 0x164
function set_enabled( enabled, on_damage = 0, var_895878e1 = 1 )
{
    assert( isactor( self ) );
    self.var_ca3bd64e = var_895878e1;
    self.var_fa99a047 = on_damage;
    
    if ( is_true( enabled ) )
    {
        if ( !is_true( on_damage ) )
        {
            self callback::on_death( &function_4ad903f4 );
        }
        else
        {
            self callback::function_d8abfc3d( #"on_actor_damage", &function_4ad903f4 );
        }
        
        return;
    }
    
    self callback::remove_on_death( &function_4ad903f4 );
    self callback::function_52ac9652( #"on_actor_damage", &function_4ad903f4, undefined, 1 );
}

// Namespace snipercam/snipercam
// Params 0, eflags: 0x4
// Checksum 0xca8ba221, Offset: 0x2c0
// Size: 0x34
function private function_f64316de()
{
    clientfield::register( "actor", "start_snipercam", 1, 2, "int" );
}

// Namespace snipercam/snipercam
// Params 1, eflags: 0x4
// Checksum 0x3b573337, Offset: 0x300
// Size: 0x1dc
function private function_4ad903f4( damage )
{
    if ( is_true( damage.weapon.isbulletweapon ) && ( isplayer( damage.attacker ) || isplayer( damage.eattacker ) || isplayer( damage.einflictor ) ) )
    {
        if ( !isdefined( damage.mod ) || damage.mod === "MOD_RIFLE_BULLET" || damage.mod === "MOD_PISTOL_BULLET" )
        {
            mindist = 800;
            attacker = damage.attacker;
            
            if ( !isplayer( attacker ) )
            {
                attacker = damage.eattacker;
            }
            
            if ( !isplayer( attacker ) )
            {
                attacker = damage.einflictor;
            }
            
            if ( isdefined( self.var_8a3fb9e2 ) )
            {
                mindist = self.var_8a3fb9e2;
            }
            
            if ( distancesquared( self.origin, attacker.origin ) > sqr( mindist ) )
            {
                var_afe2c3af = !is_true( self.var_fa99a047 );
                self set_enabled( 0, self.var_fa99a047 );
                self thread function_856a28c3( damage, var_afe2c3af );
            }
        }
    }
}

// Namespace snipercam/snipercam
// Params 2, eflags: 0x4
// Checksum 0x29780fab, Offset: 0x4e8
// Size: 0x36c
function private function_856a28c3( damage, var_afe2c3af )
{
    assert( isplayer( damage.attacker ) || isplayer( damage.eattacker ) || isplayer( damage.einflictor ) );
    self notify( #"hash_ae39942308147bf" );
    
    if ( var_afe2c3af )
    {
        self.var_4a438c2b = 1;
        util::magic_bullet_shield( self );
    }
    
    self setentitypaused( 1 );
    
    if ( isplayer( damage.attacker ) )
    {
        player = damage.attacker;
    }
    else if ( isplayer( damage.eattacker ) )
    {
        player = damage.eattacker;
    }
    else
    {
        player = damage.einflictor;
    }
    
    player val::set( "snipercam", "freezecontrols", 1 );
    parms = function_83d35e98( player, player geteye(), player getplayerangles(), self, self.var_ca3bd64e );
    setslowmotion( 1, 0.5, 0 );
    player showcrosshair( 0 );
    self clientfield::set( "start_snipercam", self.var_ca3bd64e );
    var_b487436a = 1.3 * 0.1;
    
    if ( parms.time - 0.1 > 0 )
    {
        wait parms.time - 0.1;
    }
    else
    {
        wait parms.time;
    }
    
    setslowmotion( 0.5, 1, 0.5 );
    self setentitypaused( 0 );
    
    if ( var_afe2c3af )
    {
        util::stop_magic_bullet_shield( self );
        self.var_4a438c2b = 0;
        self.diequietly = 1;
        self setnormalhealth( 1 );
        self kill( player.origin, player, player, damage.weapon );
    }
    
    wait 1;
    wait 0.1;
    player showcrosshair( 1 );
    player val::reset_all( "snipercam" );
}

