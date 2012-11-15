#include "ScriptPCH.h"
#include "Chat.h"

class moba_commands : public CommandScript
{
   public:
       moba_commands() : CommandScript("mobacommands") { }


       static bool HandleArenaCommand(ChatHandler* handler, const char* /*args*/)
       {
		    BattlegroundTypeId bgTypeId = BATTLEGROUND_AA;
			handler->GetSession()->SendBattleGroundList(handler->GetSession()->GetPlayer()->GetGUID(), bgTypeId);
			return true;
       }

       static bool HandleBGCommand(ChatHandler* handler, const char* /*args*/)
       {
 			BattlegroundTypeId bgTypeId = BATTLEGROUND_AB;
			handler->GetSession()->SendBattleGroundList(handler->GetSession()->GetPlayer()->GetGUID(), bgTypeId);
			return true;

       }
	   static bool HandleTalentsCommand(ChatHandler* handler, const char* /*args*/)
	   {
		   handler->GetSession()->GetPlayer()->resetTalents(true);
		   handler->GetSession()->GetPlayer()->SendTalentsInfoData(false);
		   ChatHandler(handler->GetSession()->GetPlayer()).PSendSysMessage(LANG_RESET_TALENTS);
		   return true;
	   }

       ChatCommand* GetCommands() const
       {
           static ChatCommand MobaCommands[] =
           {
               { "arena",          SEC_PLAYER,          false, &HandleArenaCommand,  "", NULL },
               { "bg",		       SEC_PLAYER,          false, &HandleBGCommand,     "", NULL },
			   { "talents",         SEC_PLAYER,          false, &HandleTalentsCommand, "", NULL },
               { NULL,             0,			    	false, NULL,		    	 "", NULL }
           };
           return MobaCommands;
       }
};

void AddSC_moba_commands()
{
   new moba_commands();
}
