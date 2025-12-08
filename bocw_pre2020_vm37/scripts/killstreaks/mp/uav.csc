#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace uav;

// Namespace uav/uav
// Params 0, eflags: 0x6
// Checksum 0x88339b9d, Offset: 0xc0
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"uav", &preinit, undefined, undefined, #"killstreaks" );
}

// Namespace uav/uav
// Params 0, eflags: 0x4
// Checksum 0xffd9a79, Offset: 0x110
// Size: 0xc4
function private preinit()
{
    clientfield::register( "scriptmover", "uav", 1, 1, "int", &spawned, 0, 0 );
    clientfield::register( "scriptmover", "uav_fx", 1, 1, "int", &function_5a528883, 0, 0 );
    level.uav_bundle = getscriptbundle( function_6fe2ffad() );
}

// Namespace uav/uav
// Params 7
// Checksum 0x895ff21b, Offset: 0x1e0
// Size: 0xe6
function spawned( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        self function_1f0c7136( 2 );
        function_1877b7a1( fieldname, self getentitynumber(), level.uav_bundle.var_dd0e1146, level.uav_bundle.var_dd0e1146 );
        self thread uav_think( fieldname );
        self.killstreakbundle = level.uav_bundle;
        return;
    }
    
    self notify( #"uav_off" );
}

// Namespace uav/uav
// Params 0, eflags: 0x4
// Checksum 0xae2e7f05, Offset: 0x2d0
// Size: 0x2c
function private function_6fe2ffad()
{
    if ( sessionmodeiswarzonegame() )
    {
        return "killstreak_uav_wz";
    }
    
    return "killstreak_uav";
}

// Namespace uav/uav
// Params 1
// Checksum 0xad7891f3, Offset: 0x308
// Size: 0x5c
function uav_think( localclientnum )
{
    self waittill( #"death", #"uav_off" );
    function_74ef482c( localclientnum, self getentitynumber() );
}

// Namespace uav/uav
// Params 7
// Checksum 0x75dbbc62, Offset: 0x370
// Size: 0xd6
function function_5a528883( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !isdefined( self.killstreakbundle ) )
    {
        self.killstreakbundle = level.uav_bundle;
    }
    
    if ( !self function_ca024039() )
    {
        if ( bwastimejump )
        {
            self.var_2695439d = self playloopsound( #"veh_uav_engine_loop", 1 );
            self thread fx_think( fieldname );
            return;
        }
        
        self notify( #"hash_780b1fb5c050cdc0" );
    }
}

// Namespace uav/uav
// Params 1
// Checksum 0x3fd9c2b8, Offset: 0x450
// Size: 0x4c
function fx_think( *localclientnum )
{
    self waittill( #"death", #"hash_780b1fb5c050cdc0" );
    self stoploopsound( self.var_2695439d );
}

