#using scripts/core_common/struct;

#namespace perplayer;

// Namespace perplayer/perplayer
// Params 3
// Checksum 0xc453e864, Offset: 0xf8
// Size: 0xc0
function init( id, playerbegincallback, playerendcallback )
{
    handler = spawnstruct();
    handler.id = id;
    handler.playerbegincallback = playerbegincallback;
    handler.playerendcallback = playerendcallback;
    handler.enabled = 0;
    handler.players = [];
    thread onplayerconnect( handler );
    level.handlerglobalflagval = 0;
    return handler;
}

// Namespace perplayer/perplayer
// Params 1
// Checksum 0xa0c4ebd7, Offset: 0x1c0
// Size: 0x156
function enable( handler )
{
    if ( handler.enabled )
    {
        return;
    }
    
    handler.enabled = 1;
    level.handlerglobalflagval++;
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ].handlerflagval = level.handlerglobalflagval;
    }
    
    players = handler.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ].handlerflagval != level.handlerglobalflagval )
        {
            continue;
        }
        
        if ( players[ i ].handlers[ handler.id ].ready )
        {
            players[ i ] handleplayer( handler );
        }
    }
}

// Namespace perplayer/perplayer
// Params 1
// Checksum 0x70d1ed0c, Offset: 0x320
// Size: 0x156
function disable( handler )
{
    if ( !handler.enabled )
    {
        return;
    }
    
    handler.enabled = 0;
    level.handlerglobalflagval++;
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ].handlerflagval = level.handlerglobalflagval;
    }
    
    players = handler.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ].handlerflagval != level.handlerglobalflagval )
        {
            continue;
        }
        
        if ( players[ i ].handlers[ handler.id ].ready )
        {
            players[ i ] unhandleplayer( handler, 0, 0 );
        }
    }
}

// Namespace perplayer/perplayer
// Params 1
// Checksum 0x40b6ab46, Offset: 0x480
// Size: 0x1a0
function onplayerconnect( handler )
{
    for ( ;; )
    {
        waitresult = level waittill( "connecting" );
        player = waitresult.player;
        
        if ( !isdefined( player.handlers ) )
        {
            player.handlers = [];
        }
        
        player.handlers[ handler.id ] = spawnstruct();
        player.handlers[ handler.id ].ready = 0;
        player.handlers[ handler.id ].handled = 0;
        player.handlerflagval = -1;
        handler.players[ handler.players.size ] = player;
        player thread onplayerdisconnect( handler );
        player thread onplayerspawned( handler );
        player thread onjoinedteam( handler );
        player thread onjoinedspectators( handler );
        player thread onplayerkilled( handler );
    }
}

// Namespace perplayer/perplayer
// Params 1
// Checksum 0xb46b36ae, Offset: 0x628
// Size: 0xcc
function onplayerdisconnect( handler )
{
    self waittill( "disconnect" );
    newplayers = [];
    
    for ( i = 0; i < handler.players.size ; i++ )
    {
        if ( handler.players[ i ] != self )
        {
            newplayers[ newplayers.size ] = handler.players[ i ];
        }
    }
    
    handler.players = newplayers;
    self thread unhandleplayer( handler, 1, 1 );
}

// Namespace perplayer/perplayer
// Params 1
// Checksum 0xcdd2824, Offset: 0x700
// Size: 0x48
function onjoinedteam( handler )
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        self waittill( "joined_team" );
        self thread unhandleplayer( handler, 1, 0 );
    }
}

// Namespace perplayer/perplayer
// Params 1
// Checksum 0xa8ea90f0, Offset: 0x750
// Size: 0x48
function onjoinedspectators( handler )
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        self waittill( "joined_spectators" );
        self thread unhandleplayer( handler, 1, 0 );
    }
}

// Namespace perplayer/perplayer
// Params 1
// Checksum 0xf507b6da, Offset: 0x7a0
// Size: 0x40
function onplayerspawned( handler )
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        self waittill( "spawned_player" );
        self thread handleplayer( handler );
    }
}

// Namespace perplayer/perplayer
// Params 1
// Checksum 0xabbacb0, Offset: 0x7e8
// Size: 0x48
function onplayerkilled( handler )
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        self waittill( "killed_player" );
        self thread unhandleplayer( handler, 1, 0 );
    }
}

// Namespace perplayer/perplayer
// Params 1
// Checksum 0x403538de, Offset: 0x838
// Size: 0xb0
function handleplayer( handler )
{
    self.handlers[ handler.id ].ready = 1;
    
    if ( !handler.enabled )
    {
        return;
    }
    
    if ( self.handlers[ handler.id ].handled )
    {
        return;
    }
    
    self.handlers[ handler.id ].handled = 1;
    self thread [[ handler.playerbegincallback ]]();
}

// Namespace perplayer/perplayer
// Params 3
// Checksum 0xcfd69784, Offset: 0x8f0
// Size: 0xc4
function unhandleplayer( handler, unsetready, disconnected )
{
    if ( !disconnected && unsetready )
    {
        self.handlers[ handler.id ].ready = 0;
    }
    
    if ( !self.handlers[ handler.id ].handled )
    {
        return;
    }
    
    if ( !disconnected )
    {
        self.handlers[ handler.id ].handled = 0;
    }
    
    self thread [[ handler.playerendcallback ]]( disconnected );
}

