#using script_1cd690a97dfca36e;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_utility;

#namespace cp_ger_stakeout_fx;

// Namespace cp_ger_stakeout_fx/cp_ger_stakeout_fx
// Params 0, eflags: 0x6
// Checksum 0xdea7a425, Offset: 0x2f8
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"cp_ger_stakeout_fx", &_preload, &function_fa076c68, undefined, undefined );
}

// Namespace cp_ger_stakeout_fx/cp_ger_stakeout_fx
// Params 0, eflags: 0x4
// Checksum 0xa0b7d433, Offset: 0x350
// Size: 0x34
function private _preload()
{
    if ( !isdefined( level._fx ) )
    {
        level._fx = {};
    }
    
    function_bc948200();
}

// Namespace cp_ger_stakeout_fx/cp_ger_stakeout_fx
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x390
// Size: 0x4
function private function_fa076c68()
{
    
}

// Namespace cp_ger_stakeout_fx/cp_ger_stakeout_fx
// Params 0, eflags: 0x4
// Checksum 0x2f72b800, Offset: 0x3a0
// Size: 0xdc
function private function_bc948200()
{
    clientfield::register( "actor", "umbrella_drips", 1, 2, "int", &umbrella_drips, 0, 0 );
    clientfield::register( "scriptmover", "police_headlights", 1, 1, "int", &police_headlights, 0, 0 );
    clientfield::register( "scriptmover", "police_sirens", 1, 1, "int", &police_sirens, 0, 0 );
}

// Namespace cp_ger_stakeout_fx/cp_ger_stakeout_fx
// Params 7
// Checksum 0xa0a70fc1, Offset: 0x488
// Size: 0x11e
function umbrella_drips( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump === 1 )
    {
        self.var_b2c18fb3 = util::playfxontag( fieldname, "maps/cp_stakeout/fx9_rain_drips_umbrella", self, "tag_accessory_left" );
        self waittill( #"death" );
    }
    else if ( bwastimejump === 2 )
    {
        self.var_b2c18fb3 = util::playfxontag( fieldname, "maps/cp_stakeout/fx9_rain_drips_umbrella", self, "tag_accessory_right" );
        self waittill( #"death" );
    }
    else
    {
        waitframe( 1 );
    }
    
    if ( isdefined( self.var_b2c18fb3 ) )
    {
        stopfx( fieldname, self.var_b2c18fb3 );
        self.var_b2c18fb3 = undefined;
    }
}

// Namespace cp_ger_stakeout_fx/cp_ger_stakeout_fx
// Params 7
// Checksum 0xfbddafc7, Offset: 0x5b0
// Size: 0x252
function police_headlights( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !isdefined( self.lights ) )
    {
        self.lights = spawnstruct();
    }
    
    if ( isdefined( self.lights.var_9e97f891 ) )
    {
        stopfx( fieldname, self.lights.var_9e97f891 );
        self.lights.var_9e97f891 = undefined;
    }
    
    if ( isdefined( self.lights.var_f1119d87 ) )
    {
        stopfx( fieldname, self.lights.var_f1119d87 );
        self.lights.var_f1119d87 = undefined;
    }
    
    if ( isdefined( self.lights.var_f5005d7f ) )
    {
        stopfx( fieldname, self.lights.var_f5005d7f );
        self.lights.var_f5005d7f = undefined;
    }
    
    if ( isdefined( self.lights.var_a3c2bacd ) )
    {
        stopfx( fieldname, self.lights.var_a3c2bacd );
        self.lights.var_a3c2bacd = undefined;
    }
    
    if ( bwastimejump === 1 )
    {
        self.lights.var_9e97f891 = util::playfxontag( fieldname, "maps/cp_stakeout/fx9_headlight_yellow_car_l", self, "tag_fx_headlight_left" );
        self.lights.var_f1119d87 = util::playfxontag( fieldname, "maps/cp_stakeout/fx9_headlight_yellow_car_r", self, "tag_fx_headlight_right" );
        self.lights.var_f5005d7f = util::playfxontag( fieldname, "vehicle/fx9_taillight_civ_rus_gaz", self, "tag_fx_tail_light_left" );
        self.lights.var_a3c2bacd = util::playfxontag( fieldname, "vehicle/fx9_taillight_civ_rus_gaz", self, "tag_fx_tail_light_right" );
    }
}

// Namespace cp_ger_stakeout_fx/cp_ger_stakeout_fx
// Params 7
// Checksum 0x596fdc83, Offset: 0x810
// Size: 0x1fa
function police_sirens( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !isdefined( self.lights ) )
    {
        self.lights = spawnstruct();
    }
    
    if ( bwastimejump === 1 )
    {
        if ( isdefined( self.lights.var_765beb37 ) )
        {
            stopfx( fieldname, self.lights.var_765beb37 );
            self.lights.var_765beb37 = undefined;
        }
        
        if ( isdefined( self.lights.var_8ce0ffd ) )
        {
            stopfx( fieldname, self.lights.var_8ce0ffd );
            self.lights.var_8ce0ffd = undefined;
        }
        
        self.lights.var_765beb37 = util::playfxontag( fieldname, "maps/cp_stakeout/fx9_police_light_blue_ccw_rnr", self, "tag_fx_light_beacon_left_light_1" );
        self.lights.var_8ce0ffd = util::playfxontag( fieldname, "maps/cp_stakeout/fx9_police_light_blue_rnr", self, "tag_fx_light_beacon_right_light_1" );
        return;
    }
    
    if ( isdefined( self.lights.var_765beb37 ) )
    {
        stopfx( fieldname, self.lights.var_765beb37 );
        self.lights.var_765beb37 = undefined;
    }
    
    if ( isdefined( self.lights.var_8ce0ffd ) )
    {
        stopfx( fieldname, self.lights.var_8ce0ffd );
        self.lights.var_8ce0ffd = undefined;
    }
}

