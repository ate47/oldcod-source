#using script_35ae72be7b4fec10;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\globallogic_ui;

#namespace helicopter;

// Namespace helicopter/namespace_dd60787e
// Params 0, eflags: 0x6
// Checksum 0x1aaa3c98, Offset: 0x100
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"chopper", &_preload, undefined, undefined, undefined );
}

// Namespace helicopter/namespace_dd60787e
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x148
// Size: 0x4
function private _preload()
{
    
}

// Namespace helicopter/namespace_dd60787e
// Params 0
// Checksum 0xbeeb8087, Offset: 0x158
// Size: 0x104
function function_2b057725()
{
    level.player = isdefined( level.player ) ? level.player : getplayers()[ 0 ];
    
    if ( !scripted_widgets::exists( #"chopper_display" ) )
    {
        scripted_widgets::create( #"chopper_display", #"chopper" );
    }
    
    level.player val::set( #"helicopter", "show_crosshair", 0 );
    level.player val::set( #"helicopter", "show_weapon_hud", 0 );
    thread function_3cc2b159();
}

// Namespace helicopter/namespace_dd60787e
// Params 0
// Checksum 0xebf1650f, Offset: 0x268
// Size: 0x124
function function_437dfc97()
{
    level.player = isdefined( level.player ) ? level.player : getplayers()[ 0 ];
    self notify( "2b6b069ecfd8e071" );
    self endon( "2b6b069ecfd8e071" );
    
    if ( scripted_widgets::exists( #"chopper_display" ) )
    {
        scripted_widgets::remove( #"chopper_display" );
    }
    
    level.player val::set( #"helicopter", "show_crosshair", 1 );
    level.player val::set( #"helicopter", "show_weapon_hud", 1 );
    level.player notify( #"hash_6f1306832c75c68f" );
}

// Namespace helicopter/namespace_dd60787e
// Params 0, eflags: 0x4
// Checksum 0xc54f6bf2, Offset: 0x398
// Size: 0xd6
function private function_3cc2b159()
{
    self endon( #"hash_6f1306832c75c68f", #"death" );
    
    while ( true )
    {
        if ( isdefined( level.var_7466d419 ) )
        {
            weaponheat = level.var_7466d419 getturretheatvalue( 3 );
            weaponoverheating = level.var_7466d419 isvehicleturretoverheating( 3 );
            globallogic_ui::function_9ed5232e( "cp_chopper_hud.weaponHeat", weaponheat, 0 );
            globallogic_ui::function_9ed5232e( "cp_chopper_hud.weaponOverheating", weaponoverheating, 0 );
        }
        
        waitframe( 1 );
    }
}

