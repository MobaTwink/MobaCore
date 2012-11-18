#include "ScriptPCH.h"
#include "Chat.h"
#include "Language.h"

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

	   static bool HandleAdminChatCommand(ChatHandler* handler, char const* args)
	   {
		   if (!*args)
			   return false;
		   
		   std::string rank("|cff01b2f1<Admin>|r");
		   
		   sWorld->SendWorldText(MOBA_CHATBOX, rank.c_str(), args);
		   return true;
		}

	   static bool HandleModChatCommand(ChatHandler* handler, char const* args)
	   {
		   if (!*args)
			   return false;
		   
		   std::string rank("|cff9ffd43<Mod>|r");
		   
		   sWorld->SendWorldText(MOBA_CHATBOX, rank.c_str(), args);
		   return true;
		}

	   static bool HandleHelpChatCommand(ChatHandler* handler, char const* args)
	   {
		   if (!*args)
			   return false;
		   
		   std::string rank("|cffc784ff<Helper>|r");
		   
		   sWorld->SendWorldText(MOBA_CHATBOX, rank.c_str(), args);
		   return true;
		}

	   static bool HandleMemberChatCommand(ChatHandler* handler, char const* args)
	   {
		   if (!*args)
			   return false;
		   
		   std::string rank("|cffefc9a0<Member>|r");
		   
		   sWorld->SendWorldText(MOBA_CHATBOX, rank.c_str(), args);
		   return true;
		}

	   static bool HandleNoobChatCommand(ChatHandler* handler, char const* args)
	   {
		   if (!*args)
			   return false;
		   
		   std::string rank("|cff939393<Noob>|r");
		   
		   sWorld->SendWorldText(MOBA_CHATBOX, rank.c_str(), args);
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
               { "arena",          SEC_PLAYER,          false, &HandleArenaCommand,		 "", NULL },
               { "bg",		       SEC_PLAYER,          false, &HandleBGCommand,		 "", NULL },
			   { "talents",        SEC_PLAYER,          false, &HandleTalentsCommand,	 "", NULL },
               { "chatad",		   SEC_ADMINISTRATOR,   false, &HandleAdminChatCommand,  "", NULL },
               { "chatmo",	       SEC_ADMINISTRATOR,   false, &HandleModChatCommand,    "", NULL },
               { "chathe",		   SEC_ADMINISTRATOR,   false, &HandleHelpChatCommand,   "", NULL },
               { "chatme",	       SEC_ADMINISTRATOR,   false, &HandleMemberChatCommand, "", NULL },
               { "chatno",	       SEC_ADMINISTRATOR,   false, &HandleNoobChatCommand,   "", NULL },
               { NULL,             0,			    	false, NULL,		    	     "", NULL }
           };
           return MobaCommands;
       }
};

void AddSC_moba_commands()
{
   new moba_commands();
}
