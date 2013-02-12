#include "ScriptPCH.h"
#include "Chat.h"
#include "Language.h"

class neva_commands : public CommandScript
{
   public:
       neva_commands() : CommandScript("nevacommands") { }

       static bool HandleArenaCommand(ChatHandler* handler, const char* /*args*/)
       {
		    BattlegroundTypeId bgTypeId = BATTLEGROUND_AA;
			handler->GetSession()->SendBattleGroundList(handler->GetSession()->GetPlayer()->GetGUID(), bgTypeId);
			return true;
       }

       static bool HandleBGCommand(ChatHandler* handler, const char* /*args*/)
       {
 			BattlegroundTypeId bgTypeId = BATTLEGROUND_WS;
			handler->GetSession()->SendBattleGroundList(handler->GetSession()->GetPlayer()->GetGUID(), bgTypeId);
			return true;

       }
	   static bool HandleTalentsCommand(ChatHandler* handler, const char* /*args*/)
	   {
		   Player* player = handler->GetSession()->GetPlayer();
		   if( !player->HasAuraType(SPELL_AURA_ARENA_PREPARATION)
			   && player->InArena()
			   || player->isInCombat() )
		   {
			   handler->SendSysMessage(LANG_YOU_IN_COMBAT);
			   handler->SetSentErrorMessage(true);
			   return false;
		   }
		   
		   player->resetTalents(true);
		   player->CastSpell(player, 14867, true);
		   player->SendTalentsInfoData(false);
		   ChatHandler(player).PSendSysMessage(LANG_RESET_TALENTS);
		   return true;
	   }

       ChatCommand* GetCommands() const
       {
           static ChatCommand NevaCommands[] =
           {
               { "arena",          SEC_PLAYER,          false, &HandleArenaCommand,		 "", NULL },
               { "bg",		       SEC_PLAYER,          false, &HandleBGCommand,		 "", NULL },
			   { "talents",        SEC_PLAYER,          false, &HandleTalentsCommand,	 "", NULL },
               { NULL,             0,			    	false, NULL,		    	     "", NULL }
           };
           return NevaCommands;
       }
};

void AddSC_neva_commands()
{
   new neva_commands();
}
