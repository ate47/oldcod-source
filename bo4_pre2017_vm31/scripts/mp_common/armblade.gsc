#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/proximity_grenade;

#namespace armblade;

// Namespace armblade/armblade
// Params 0, eflags: 0x2
// Checksum 0xe25ce5d8, Offset: 0x1b8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "armblade", &__init__, undefined, undefined );
}

// Namespace armblade/armblade
// Params 0
// Checksum 0xc8c3a09a, Offset: 0x1f8
// Size: 0x4c
function __init__()
{
    level.var_f14b6bc1 = getweapon( "hero_armblade" );
    callback::on_spawned( &on_player_spawned );
}

// Namespace armblade/armblade
// Params 0
// Checksum 0x21cd9de2, Offset: 0x250
// Size: 0x1c
function on_player_spawned()
{
    self thread function_1a8e90d4();
}

// Namespace armblade/armblade
// Params 0
// Checksum 0x989e2e43, Offset: 0x278
// Size: 0x138
function function_1a8e90d4()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    for ( ;; )
    {
        result = self waittill( "weapon_change", "disconnect" );
        
        if ( result._notify == "weapon_change" && self getcurrentweapon() == level.var_f14b6bc1 )
        {
            if ( !isdefined( self.var_5a11ecea ) )
            {
                self.var_5a11ecea = spawn( "script_origin", self.origin );
                self.var_5a11ecea linkto( self );
            }
            
            self.var_5a11ecea playloopsound( "wpn_armblade_idle", 0.25 );
            continue;
        }
        
        if ( isdefined( self.var_5a11ecea ) )
        {
            self.var_5a11ecea stoploopsound( 0.25 );
        }
    }
}

