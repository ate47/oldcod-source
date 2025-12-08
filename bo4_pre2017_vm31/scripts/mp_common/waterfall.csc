#using scripts/core_common/callbacks_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/water_surface;
#using scripts/mp_common/load;
#using scripts/mp_common/util;

#namespace waterfall;

// Namespace waterfall/waterfall
// Params 1
// Checksum 0xccf57802, Offset: 0x250
// Size: 0xca
function waterfalloverlay( localclientnum )
{
    triggers = getentarray( localclientnum, "waterfall", "targetname" );
    
    foreach ( trigger in triggers )
    {
        trigger thread setupwaterfall( localclientnum );
    }
}

// Namespace waterfall/waterfall
// Params 1
// Checksum 0x8438491, Offset: 0x328
// Size: 0xca
function waterfallmistoverlay( localclientnum )
{
    triggers = getentarray( localclientnum, "waterfall_mist", "targetname" );
    
    foreach ( trigger in triggers )
    {
        trigger thread setupwaterfallmist( localclientnum );
    }
}

// Namespace waterfall/waterfall
// Params 1
// Checksum 0xa3a9da1, Offset: 0x400
// Size: 0x44
function waterfallmistoverlayreset( localclientnum )
{
    localplayer = getlocalplayer( localclientnum );
    localplayer.rainopacity = 0;
}

// Namespace waterfall/waterfall
// Params 1
// Checksum 0x93f0260d, Offset: 0x450
// Size: 0x148
function setupwaterfallmist( localclientnum )
{
    level notify( "setupWaterfallmist_waterfall_csc" + localclientnum );
    level endon( "setupWaterfallmist_waterfall_csc" + localclientnum );
    trigger = self;
    
    for ( ;; )
    {
        waitresult = trigger waittill( "trigger" );
        trigplayer = waitresult.activator;
        
        if ( !trigplayer islocalplayer() )
        {
            continue;
        }
        
        localclientnum = trigplayer getlocalclientnumber();
        
        if ( isdefined( localclientnum ) )
        {
            localplayer = getlocalplayer( localclientnum );
        }
        else
        {
            localplayer = trigplayer;
        }
        
        filter::init_filter_sprite_rain( localplayer );
        trigger thread trigger::function_thread( localplayer, &trig_enter_waterfall_mist, &trig_leave_waterfall_mist );
    }
}

// Namespace waterfall/waterfall
// Params 2
// Checksum 0xdb0e7f69, Offset: 0x5a0
// Size: 0x138
function setupwaterfall( localclientnum, localowner )
{
    level notify( "setupWaterfall_waterfall_csc" + localclientnum );
    level endon( "setupWaterfall_waterfall_csc" + localclientnum );
    trigger = self;
    
    for ( ;; )
    {
        waitresult = trigger waittill( "trigger" );
        trigplayer = waitresult.activator;
        
        if ( !trigplayer islocalplayer() )
        {
            continue;
        }
        
        localclientnum = trigplayer getlocalclientnumber();
        
        if ( isdefined( localclientnum ) )
        {
            localplayer = getlocalplayer( localclientnum );
        }
        else
        {
            localplayer = trigplayer;
        }
        
        trigger thread trigger::function_thread( localplayer, &trig_enter_waterfall, &trig_leave_waterfall );
    }
}

// Namespace waterfall/waterfall
// Params 1
// Checksum 0x3af7c796, Offset: 0x6e0
// Size: 0xb8
function trig_enter_waterfall( localplayer )
{
    trigger = self;
    localclientnum = localplayer.localclientnum;
    localplayer thread postfx::playpostfxbundle( "pstfx_waterfall" );
    playsound( 0, "amb_waterfall_hit", ( 0, 0, 0 ) );
    
    while ( trigger istouching( localplayer ) )
    {
        localplayer playrumbleonentity( localclientnum, "waterfall_rumble" );
        wait 0.1;
    }
}

// Namespace waterfall/waterfall
// Params 1
// Checksum 0xcded5b27, Offset: 0x7a0
// Size: 0x84
function trig_leave_waterfall( localplayer )
{
    trigger = self;
    localclientnum = localplayer.localclientnum;
    localplayer postfx::stoppostfxbundle();
    
    if ( isunderwater( localclientnum ) == 0 )
    {
        localplayer thread water_surface::startwatersheeting();
    }
}

// Namespace waterfall/waterfall
// Params 1
// Checksum 0x2a1c99bc, Offset: 0x830
// Size: 0x1ee
function trig_enter_waterfall_mist( localplayer )
{
    localplayer endon( #"death" );
    trigger = self;
    
    if ( !isdefined( localplayer.rainopacity ) )
    {
        localplayer.rainopacity = 0;
    }
    
    if ( localplayer.rainopacity == 0 )
    {
        filter::set_filter_sprite_rain_seed_offset( localplayer, 0, randomfloat( 1 ) );
    }
    
    filter::enable_filter_sprite_rain( localplayer, 0 );
    
    while ( trigger istouching( localplayer ) )
    {
        localclientnum = trigger.localclientnum;
        
        if ( !isdefined( localclientnum ) )
        {
            localclientnum = localplayer getlocalclientnumber();
        }
        
        if ( isunderwater( localclientnum ) )
        {
            filter::disable_filter_sprite_rain( localplayer, 0 );
            break;
        }
        
        localplayer.rainopacity += 0.003;
        
        if ( localplayer.rainopacity > 1 )
        {
            localplayer.rainopacity = 1;
        }
        
        filter::set_filter_sprite_rain_opacity( localplayer, 0, localplayer.rainopacity );
        filter::set_filter_sprite_rain_elapsed( localplayer, 0, localplayer getclienttime() );
        waitframe( 1 );
    }
}

// Namespace waterfall/waterfall
// Params 1
// Checksum 0x3002f32f, Offset: 0xa28
// Size: 0x174
function trig_leave_waterfall_mist( localplayer )
{
    localplayer endon( #"death" );
    trigger = self;
    
    if ( isdefined( localplayer.rainopacity ) )
    {
        while ( !trigger istouching( localplayer ) && localplayer.rainopacity > 0 )
        {
            localclientnum = trigger.localclientnum;
            
            if ( isunderwater( localclientnum ) )
            {
                filter::disable_filter_sprite_rain( localplayer, 0 );
                break;
            }
            
            localplayer.rainopacity -= 0.005;
            filter::set_filter_sprite_rain_opacity( localplayer, 0, localplayer.rainopacity );
            filter::set_filter_sprite_rain_elapsed( localplayer, 0, localplayer getclienttime() );
            waitframe( 1 );
        }
    }
    
    localplayer.rainopacity = 0;
    filter::disable_filter_sprite_rain( localplayer, 0 );
}

