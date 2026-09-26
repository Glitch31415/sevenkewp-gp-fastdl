#include "weapon_momslipper"
#include "trigger_observer_proto_20220918"
void RegisterMOM()
{
	RegisterMOMS();
}

void PluginInit()
{
        g_Hooks.RegisterHook(Hooks::Player::PlayerSpawn, @SpawnedMOM); 
}

void MapInit()
{
		RegisterMOMS();
		TriggerObserver::Init();
		g_Scheduler.SetInterval( "ModelChange", 1.0f, g_Scheduler.REPEAT_INFINITE_TIMES );
		g_Game.PrecacheModel( "models/player/pedobear/pedobear.mdl" );
}

HookReturnCode SpawnedMOM(CBasePlayer@ pPlayer)
{
	pPlayer.GiveNamedItem("weapon_momslipper");
    	return HOOK_CONTINUE;
}


void ModelChange()
{
    CBasePlayer@ pPlayer;
    for( int i = 1; i <= g_Engine.maxClients; i++ ) 
    {
        @pPlayer = g_PlayerFuncs.FindPlayerByIndex(i);
        if( pPlayer is null || !pPlayer.IsConnected() ) 
            continue;
        
        InventoryList@ pInvList = @pPlayer.m_pInventory;  
        while( pInvList !is null )
        {
            CItemInventory@ pInvItem = cast<CItemInventory@>( pInvList.hItem.GetEntity() );

            if( pInvItem !is null && pInvItem.m_szItemName == "pedobear" )
            {
				//hahaha le ebin 2008 meme
                pPlayer.SetOverriddenPlayerModel( "pedobear" );
                break;
            }
            @pInvList = @pInvList.pNext;
        } 
        
    }	
}