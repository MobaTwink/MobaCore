/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Map.h"
#include "MapManager.h"
#include "Group.h"
#include "WorldPacket.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"
#include "CreatureTextMgr.h"
#include "GroupMgr.h"

Battlefield::Battlefield()
{
    m_Timer = 0;
    m_IsEnabled = true;
    m_isActive = false;
    m_DefenderTeam = TEAM_NEUTRAL;

    m_TypeId = 0;
    m_BattleId = 0;
    m_ZoneId = 0;
    m_MapId = 0;
    m_MaxPlayer = 0;
    m_MinPlayer = 0;
    m_BattleTime = 0;
    m_NoWarBattleTime = 0;
    m_TimeForAcceptInvite = 20;
    m_uiKickDontAcceptTimer = 1000;

    m_uiKickAfkPlayersTimer = 1000;
	
  //  m_LastResurectTimerHorde = 13000;
    m_LastResurectTimerAlliance = 10000;
    m_StartGroupingTimer = 0;
    m_StartGrouping = false;
    StalkerGuid = 0;
}

Battlefield::~Battlefield()
{
    for (GraveyardVect::const_iterator itr = m_GraveyardList.begin(); itr != m_GraveyardList.end(); ++itr)
        delete *itr;
}

// Called when a player enters the zone
void Battlefield::HandlePlayerEnterZone(Player* player, uint32 /*zone*/)
{
    // If battle is started,
    // If not full of players > invite player to join the war
    // If full of players > announce to player that BF is full and kick him after a few second if he desn't leave
    if (IsWarTime())
    {
        if (m_PlayersInWar[player->GetTeamId()].size() + m_InvitedPlayers[player->GetTeamId()].size() < m_MaxPlayer) // Vacant spaces
            InvitePlayerToWar(player);
        else // No more vacant places
        {
            // TODO: Send a packet to announce it to player
            m_PlayersWillBeKick[player->GetTeamId()][player->GetGUID()] = time(NULL) + 10;
            InvitePlayerToQueue(player);
        }
    }
    else
    {
        // If time left is < 15 minutes invite player to join queue
        if (m_Timer <= m_StartGroupingTimer)
            InvitePlayerToQueue(player);
    }

    // Add player in the list of player in zone
    m_players[player->GetTeamId()].insert(player->GetGUID());
    OnPlayerEnterZone(player);
}

// Called when a player leave the zone
void Battlefield::HandlePlayerLeaveZone(Player* player, uint32 /*zone*/)
{
    if (IsWarTime())
    {
        // If the player is participating to the battle
        if (m_PlayersInWar[player->GetTeamId()].find(player->GetGUID()) != m_PlayersInWar[player->GetTeamId()].end())
        {
            m_PlayersInWar[player->GetTeamId()].erase(player->GetGUID());
            player->GetSession()->SendBfLeaveMessage(m_BattleId);
            if (Group* group = player->GetGroup()) // Remove the player from the raid group
                group->RemoveMember(player->GetGUID());

            OnPlayerLeaveWar(player);
        }
    }

    for (BfCapturePointMap::iterator itr = m_capturePoints.begin(); itr != m_capturePoints.end(); ++itr)
        itr->second->HandlePlayerLeave(player);

    m_InvitedPlayers[player->GetTeamId()].erase(player->GetGUID());
    m_PlayersWillBeKick[player->GetTeamId()].erase(player->GetGUID());
    m_players[player->GetTeamId()].erase(player->GetGUID());
    SendRemoveWorldStates(player);
    RemovePlayerFromResurrectQueue(player->GetGUID());
    OnPlayerLeaveZone(player);
}

bool Battlefield::Update(uint32 diff)
{
    if (m_LastResurectTimerAlliance <= diff)
    {
		m_GraveyardList[0]->Resurrect(TEAM_ALLIANCE);
		m_LastResurectTimerAlliance = 30000 ;
    }
    else
		m_LastResurectTimerAlliance -= diff;

    return false; 
}

void Battlefield::InvitePlayersInZoneToQueue()
{
}

void Battlefield::InvitePlayerToQueue(Player* player)
{
}

void Battlefield::InvitePlayersInQueueToWar()
{
}

void Battlefield::InvitePlayersInZoneToWar()
{
}

void Battlefield::InvitePlayerToWar(Player* player)
{
}

void Battlefield::InitStalker(uint32 entry, float x, float y, float z, float o)
{
}

void Battlefield::KickAfkPlayers()
{
}

void Battlefield::KickPlayerFromBattlefield(uint64 guid)
{
}
void Battlefield::EndBattle(bool endByTimer)
{
}

void Battlefield::DoPlaySoundToAll(uint32 SoundID)
{
    WorldPacket data;
    data.Initialize(SMSG_PLAY_SOUND, 4);
    data << uint32(SoundID);

    for (int team = 0; team < BG_TEAMS_COUNT; team++)
        for (GuidSet::const_iterator itr = m_PlayersInWar[team].begin(); itr != m_PlayersInWar[team].end(); ++itr)
            if (Player* player = sObjectAccessor->FindPlayer(*itr))
                player->GetSession()->SendPacket(&data);
}

bool Battlefield::HasPlayer(Player* player) const
{
    return m_players[player->GetTeamId()].find(player->GetGUID()) != m_players[player->GetTeamId()].end();
}

// Called in WorldSession::HandleBfQueueInviteResponse
void Battlefield::PlayerAcceptInviteToQueue(Player* player)
{
}

// Called in WorldSession::HandleBfExitRequest
void Battlefield::AskToLeaveQueue(Player* player)
{
}

// Called in WorldSession::HandleBfEntryInviteResponse
void Battlefield::PlayerAcceptInviteToWar(Player* player)
{
}

void Battlefield::TeamCastSpell(TeamId team, int32 spellId)
{
    if (spellId > 0)
        for (GuidSet::const_iterator itr = m_PlayersInWar[team].begin(); itr != m_PlayersInWar[team].end(); ++itr)
            if (Player* player = sObjectAccessor->FindPlayer(*itr))
                player->CastSpell(player, uint32(spellId), true);
    else
        for (GuidSet::const_iterator itr = m_PlayersInWar[team].begin(); itr != m_PlayersInWar[team].end(); ++itr)
            if (Player* player = sObjectAccessor->FindPlayer(*itr))
                player->RemoveAuraFromStack(uint32(-spellId));
}

void Battlefield::BroadcastPacketToZone(WorldPacket& data) const
{
    for (uint8 team = 0; team < BG_TEAMS_COUNT; ++team)
        for (GuidSet::const_iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
            if (Player* player = sObjectAccessor->FindPlayer(*itr))
                player->GetSession()->SendPacket(&data);
}

void Battlefield::BroadcastPacketToQueue(WorldPacket& data) const
{
    for (uint8 team = 0; team < BG_TEAMS_COUNT; ++team)
        for (GuidSet::const_iterator itr = m_PlayersInQueue[team].begin(); itr != m_PlayersInQueue[team].end(); ++itr)
            if (Player* player = sObjectAccessor->FindPlayer(*itr))
                player->GetSession()->SendPacket(&data);
}

void Battlefield::BroadcastPacketToWar(WorldPacket& data) const
{
    for (uint8 team = 0; team < BG_TEAMS_COUNT; ++team)
        for (GuidSet::const_iterator itr = m_PlayersInWar[team].begin(); itr != m_PlayersInWar[team].end(); ++itr)
            if (Player* player = sObjectAccessor->FindPlayer(*itr))
                player->GetSession()->SendPacket(&data);
}

WorldPacket Battlefield::BuildWarningAnnPacket(std::string const& msg)
{
    WorldPacket data(SMSG_MESSAGECHAT, 200);

    data << uint8(CHAT_MSG_RAID_BOSS_EMOTE);
    data << uint32(LANG_UNIVERSAL);
    data << uint64(0);
    data << uint32(0);                                      // 2.1.0
    data << uint32(1);
    data << uint8(0);
    data << uint64(0);
    data << uint32(msg.length() + 1);
    data << msg;
    data << uint8(0);

    return data;
}

void Battlefield::SendWarningToAllInZone(uint32 entry)
{
    if (Unit* unit = sObjectAccessor->FindUnit(StalkerGuid))
        if (Creature* stalker = unit->ToCreature())
            // FIXME: replaced CHAT_TYPE_END with CHAT_MSG_BG_SYSTEM_NEUTRAL to fix compile, it's a guessed change :/
            sCreatureTextMgr->SendChat(stalker, (uint8) entry, 0, CHAT_MSG_BG_SYSTEM_NEUTRAL, LANG_ADDON, TEXT_RANGE_ZONE);
}

void Battlefield::SendWarningToPlayer(Player* player, uint32 entry)
{
    if (player)
        if (Unit* unit = sObjectAccessor->FindUnit(StalkerGuid))
            if (Creature* stalker = unit->ToCreature())
                sCreatureTextMgr->SendChat(stalker, (uint8)entry, player->GetGUID());
}

void Battlefield::SendUpdateWorldState(uint32 field, uint32 value)
{
    for (uint8 i = 0; i < BG_TEAMS_COUNT; ++i)
        for (GuidSet::iterator itr = m_players[i].begin(); itr != m_players[i].end(); ++itr)
            if (Player* player = sObjectAccessor->FindPlayer(*itr))
                player->SendUpdateWorldState(field, value);
}

void Battlefield::RegisterZone(uint32 zoneId)
{
    sBattlefieldMgr->AddZone(zoneId, this);
}

void Battlefield::HideNpc(Creature* creature)
{
    creature->CombatStop();
    creature->SetReactState(REACT_PASSIVE);
    creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
    creature->SetPhaseMask(2, true);
    creature->DisappearAndDie();
    creature->SetVisible(false);
}

void Battlefield::ShowNpc(Creature* creature, bool aggressive)
{
    creature->SetPhaseMask(1, true);
    creature->SetVisible(true);
    creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
    if (!creature->isAlive())
        creature->Respawn(true);
    if (aggressive)
        creature->SetReactState(REACT_AGGRESSIVE);
    else
    {
        creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        creature->SetReactState(REACT_PASSIVE);
    }
}

// ****************************************************
// ******************* Group System *******************
// ****************************************************
Group* Battlefield::GetFreeBfRaid(TeamId TeamId)
{
    return NULL;
}

Group* Battlefield::GetGroupPlayer(uint64 guid, TeamId TeamId)
{
    return NULL;
}

bool Battlefield::AddOrSetPlayerToCorrectBfGroup(Player* player)
{
   return false;
}

//***************End of Group System*******************

//*****************************************************
//***************Spirit Guide System*******************
//*****************************************************

//--------------------
//-Battlefield Method-
//--------------------
BfGraveyard* Battlefield::GetGraveyardById(uint32 id)
{
    if (id < m_GraveyardList.size())
    {
        if (m_GraveyardList[id])
            return m_GraveyardList[id];
        else
            sLog->outError(LOG_FILTER_BATTLEFIELD, "Battlefield::GetGraveyardById Id:%u not existed", id);
    }
    else
        sLog->outError(LOG_FILTER_BATTLEFIELD, "Battlefield::GetGraveyardById Id:%u cant be found", id);

    return NULL;
}

WorldSafeLocsEntry const * Battlefield::GetClosestGraveYard(Player* player)
{
    BfGraveyard* closestGY = NULL;
    float maxdist = -1;
    for (uint8 i = 0; i < m_GraveyardList.size(); i++)
    {
        if (m_GraveyardList[i])
        {
            if (m_GraveyardList[i]->GetControlTeamId() != player->GetTeamId())
                continue;

            float dist = m_GraveyardList[i]->GetDistance(player);
            if (dist < maxdist || maxdist < 0)
            {
                closestGY = m_GraveyardList[i];
                maxdist = dist;
            }
        }
    }

    if (closestGY)
        return sWorldSafeLocsStore.LookupEntry(closestGY->GetGraveyardId());

    return NULL;
}

void Battlefield::AddPlayerToResurrectQueue(uint64 npcGuid, uint64 playerGuid)
{
    if (!m_GraveyardList[0]->HasPlayer(playerGuid))
		m_GraveyardList[0]->AddPlayer(playerGuid);
}

void Battlefield::RemovePlayerFromResurrectQueue(uint64 playerGuid)
{
    if (m_GraveyardList[0]->HasPlayer(playerGuid))
		m_GraveyardList[0]->RemovePlayer(playerGuid);
}

void Battlefield::SendAreaSpiritHealerQueryOpcode(Player* player, const uint64 &guid)
{
	uint32 time = m_LastResurectTimerAlliance;
    WorldPacket data(SMSG_AREA_SPIRIT_HEALER_TIME, 12);
	/*
	if(!player->GetTeamId())
		time = m_LastResurectTimerAlliance;
	else
		time = m_LastResurectTimerHorde;
		*/
    data << guid << time;
    ASSERT(player && player->GetSession());
    player->GetSession()->SendPacket(&data);
}

// ----------------------
// - BfGraveyard Method -
// ----------------------
BfGraveyard::BfGraveyard(Battlefield* battlefield)
{
    m_Bf = battlefield;
    m_GraveyardId = 0;
    m_ControlTeam = TEAM_NEUTRAL;
    m_SpiritGuide[0] = 0;
    m_SpiritGuide[1] = 0;
    m_ResurrectQueue.clear();
}

void BfGraveyard::Initialize(TeamId startControl, uint32 graveyardId)
{
    m_ControlTeam = startControl;
    m_GraveyardId = graveyardId;
}

void BfGraveyard::SetSpirit(Creature* spirit, TeamId team)
{
    if (!spirit)
    {
        sLog->outError(LOG_FILTER_BATTLEFIELD, "BfGraveyard::SetSpirit: Invalid Spirit.");
        return;
    }

    m_SpiritGuide[team] = spirit->GetGUID();
    spirit->SetReactState(REACT_PASSIVE);
}

float BfGraveyard::GetDistance(Player* player)
{
    const WorldSafeLocsEntry* safeLoc = sWorldSafeLocsStore.LookupEntry(m_GraveyardId);
    return player->GetDistance2d(safeLoc->x, safeLoc->y);
}

void BfGraveyard::AddPlayer(uint64 playerGuid)
{
    if (!m_ResurrectQueue.count(playerGuid))
    {
        m_ResurrectQueue.insert(playerGuid);

        if (Player* player = sObjectAccessor->FindPlayer(playerGuid))
            player->CastSpell(player, SPELL_WAITING_FOR_RESURRECT, true);
    }
}

void BfGraveyard::RemovePlayer(uint64 playerGuid)
{
    m_ResurrectQueue.erase(m_ResurrectQueue.find(playerGuid));

    if (Player* player = sObjectAccessor->FindPlayer(playerGuid))
        player->RemoveAurasDueToSpell(SPELL_WAITING_FOR_RESURRECT);
}

void BfGraveyard::Resurrect(uint8 team)
{
    if (m_ResurrectQueue.empty())
        return;

    for (GuidSet::const_iterator itr = m_ResurrectQueue.begin(); itr != m_ResurrectQueue.end(); ++itr)
    {
        // Get player object from his guid
        Player* player = sObjectAccessor->FindPlayer(*itr);
        if (!player)
            continue;

		//if(player->GetTeamId() == team)
		//{
			// Check  if the player is in world and on the good graveyard
			if (player->IsInWorld())
				if (Unit* spirit = sObjectAccessor->FindUnit(m_SpiritGuide[m_ControlTeam]))
					spirit->CastSpell(spirit, SPELL_SPIRIT_HEAL, true);

			// Resurect player
			player->CastSpell(player, SPELL_RESURRECTION_VISUAL, true);
			player->ResurrectPlayer(1.0f);
			player->CastSpell(player, 6962, true);
			player->CastSpell(player, SPELL_SPIRIT_HEAL_MANA, true);

			sObjectAccessor->ConvertCorpseForPlayer(player->GetGUID());
		//}
    }

    m_ResurrectQueue.clear();
}

// For changing graveyard control
void BfGraveyard::GiveControlTo(TeamId team)
{
    m_ControlTeam = team;
    RelocateDeadPlayers();
}

void BfGraveyard::RelocateDeadPlayers()
{
    WorldSafeLocsEntry const* closestGrave = NULL;
    for (GuidSet::const_iterator itr = m_ResurrectQueue.begin(); itr != m_ResurrectQueue.end(); ++itr)
    {
        Player* player = sObjectAccessor->FindPlayer(*itr);
        if (!player)
            continue;

        if (closestGrave)
            player->TeleportTo(player->GetMapId(), closestGrave->x, closestGrave->y, closestGrave->z, player->GetOrientation());
        else
        {
            closestGrave = m_Bf->GetClosestGraveYard(player);
            if (closestGrave)
                player->TeleportTo(player->GetMapId(), closestGrave->x, closestGrave->y, closestGrave->z, player->GetOrientation());
        }
    }
}

// *******************************************************
// *************** End Spirit Guide system ***************
// *******************************************************
// ********************** Misc ***************************
// *******************************************************

Creature* Battlefield::SpawnCreature(uint32 entry, Position pos, TeamId team)
{
    return SpawnCreature(entry, pos.m_positionX, pos.m_positionY, pos.m_positionZ, pos.m_orientation, team);
}

Creature* Battlefield::SpawnCreature(uint32 entry, float x, float y, float z, float o, TeamId team)
{
    //Get map object
    Map* map = const_cast < Map * >(sMapMgr->CreateBaseMap(m_MapId));
    if (!map)
    {
        sLog->outError(LOG_FILTER_BATTLEFIELD, "Battlefield::SpawnCreature: Can't create creature entry: %u map not found", entry);
        return 0;
    }

    Creature* creature = new Creature;
    if (!creature->Create(sObjectMgr->GenerateLowGuid(HIGHGUID_UNIT), map, PHASEMASK_NORMAL, entry, 0, team, x, y, z, o))
    {
        sLog->outError(LOG_FILTER_BATTLEFIELD, "Battlefield::SpawnCreature: Can't create creature entry: %u", entry);
        delete creature;
        return NULL;
    }

    creature->SetHomePosition(x, y, z, o);

    CreatureTemplate const* cinfo = sObjectMgr->GetCreatureTemplate(entry);
    if (!cinfo)
    {
        sLog->outError(LOG_FILTER_BATTLEFIELD, "Battlefield::SpawnCreature: entry %u does not exist.", entry);
        return NULL;
    }
    // force using DB speeds -- do we really need this?
    creature->SetSpeed(MOVE_WALK, cinfo->speed_walk);
    creature->SetSpeed(MOVE_RUN, cinfo->speed_run);

    // Set creature in world
    map->AddToMap(creature);
    creature->setActive(true);

    return creature;
}

// Method for spawning gameobject on map
GameObject* Battlefield::SpawnGameObject(uint32 entry, float x, float y, float z, float o)
{
    // Get map object
    Map* map = const_cast<Map*>(sMapMgr->CreateBaseMap(571)); // *vomits*
    if (!map)
        return 0;

    // Create gameobject
    GameObject* go = new GameObject;
    if (!go->Create(sObjectMgr->GenerateLowGuid(HIGHGUID_GAMEOBJECT), entry, map, PHASEMASK_NORMAL, x, y, z, o, 0, 0, 0, 0, 100, GO_STATE_READY))
    {
        sLog->outError(LOG_FILTER_BATTLEFIELD, "Battlefield::SpawnGameObject: Gameobject template %u not found in database! Battlefield not created!", entry);
        sLog->outError(LOG_FILTER_BATTLEFIELD, "Battlefield::SpawnGameObject: Cannot create gameobject template %u! Battlefield not created!", entry);
        delete go;
        return NULL;
    }

    // Add to world
    map->AddToMap(go);
    go->setActive(true);

    return go;
}