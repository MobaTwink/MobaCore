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

// TODO: Implement proper support for vehicle+player teleportation
// TODO: Use spell victory/defeat in wg instead of RewardMarkOfHonor() && RewardHonor
// TODO: Add proper implement of achievement

#include "ObjectMgr.h"
#include "BattlefieldWG.h"
#include "SpellAuras.h"
#include "Vehicle.h"

enum WGVehicles
{
    NPC_WG_SEIGE_ENGINE_ALLIANCE        = 28312,
    NPC_WG_SEIGE_ENGINE_HORDE           = 32627,
    NPC_WG_DEMOLISHER                   = 28094,
    NPC_WG_CATAPULT                     = 27881
};

BattlefieldWG::~BattlefieldWG()
{
}

bool BattlefieldWG::SetupBattlefield()
{
	/*
    for (Workshop::const_iterator itr = WorkshopsList.begin(); itr != WorkshopsList.end(); ++itr)
        delete *itr;

    for (GameObjectBuilding::const_iterator itr = BuildingsInZone.begin(); itr != BuildingsInZone.end(); ++itr)
        delete *itr;
		*/

    m_TypeId = BATTLEFIELD_WG;                              // See enum BattlefieldTypes
    m_BattleId = BATTLEFIELD_BATTLEID_WG;
	m_OldZoneId = BATTLEFIELD_WG_ZONEID;
    m_ZoneId = BATTLEFIELD_DA_ZONEID;
    m_MapId = BATTLEFIELD_WG_MAPID;

    m_MaxPlayer = sWorld->getIntConfig(CONFIG_WINTERGRASP_PLR_MAX);
    m_IsEnabled = sWorld->getBoolConfig(CONFIG_WINTERGRASP_ENABLE);
    m_MinPlayer = sWorld->getIntConfig(CONFIG_WINTERGRASP_PLR_MIN);
    m_MinLevel = sWorld->getIntConfig(CONFIG_WINTERGRASP_PLR_MIN_LVL);
    m_BattleTime = sWorld->getIntConfig(CONFIG_WINTERGRASP_BATTLETIME) * MINUTE * IN_MILLISECONDS;
    m_NoWarBattleTime = sWorld->getIntConfig(CONFIG_WINTERGRASP_NOBATTLETIME) * MINUTE * IN_MILLISECONDS;

    m_TimeForAcceptInvite = 20;
    m_StartGroupingTimer = 15 * MINUTE * IN_MILLISECONDS;
    m_StartGrouping = false;

    m_tenacityStack = 0;

    KickPosition.Relocate(5728.117f, 2714.346f, 697.733f, 0);
    KickPosition.m_mapId = m_MapId;

    RegisterZone(m_ZoneId);

    m_Data32.resize(BATTLEFIELD_WG_DATA_MAX);

    m_saveTimer = 60000;

    // Init GraveYards
    SetGraveyardNumber(BATTLEFIELD_WG_GRAVEYARD_MAX);

    sWorld->setWorldState(BATTLEFIELD_WG_WORLD_STATE_ACTIVE, uint64(false));
    sWorld->setWorldState(BATTLEFIELD_WG_WORLD_STATE_DEFENDER, uint64(urand(0, 1)));
    sWorld->setWorldState(ClockWorldState[0], uint64(m_NoWarBattleTime));

    m_isActive = bool(sWorld->getWorldState(BATTLEFIELD_WG_WORLD_STATE_ACTIVE));
    m_DefenderTeam = TeamId(sWorld->getWorldState(BATTLEFIELD_WG_WORLD_STATE_DEFENDER));

    m_Timer = sWorld->getWorldState(ClockWorldState[0]);
    if (m_isActive)
    {
        m_isActive = false;
        m_Timer = m_RestartAfterCrash;
    }

    for (uint8 i = 0; i < BATTLEFIELD_WG_GRAVEYARD_MAX; i++)
    {
        BfGraveyardWG* graveyard = new BfGraveyardWG(this);

        // When between games, the graveyard is controlled by the defending team
        if (WGGraveYard[i].startcontrol == TEAM_NEUTRAL)
            graveyard->Initialize(m_DefenderTeam, WGGraveYard[i].gyid);
        else
            graveyard->Initialize(WGGraveYard[i].startcontrol, WGGraveYard[i].gyid);

        graveyard->SetTextId(WGGraveYard[i].textid);
        m_GraveyardList[i] = graveyard;
    }

	SpawnCreature(NPC_DWARVEN_SPIRIT_GUIDE, 5660.125488f, 794.830627f, 654.301147f, 5.623914f, TEAM_ALLIANCE); // Spirit Guide Alliance
	SpawnCreature(NPC_TAUNKA_SPIRIT_GUIDE,  5974.947266f, 544.667786f, 661.087036f, 2.607985f, TEAM_HORDE);    // Spirit Guide Horde
    SpawnGameObject(GO_DALARAN_BANNER_HOLDER, 5805.020508f, 639.484070f, 647.782959f, 2.515712f); // Banner Position Runeweaver 
  //  SpawnGameObject(GO_DALARAN_BANNER_HOLDER, 5641.049316f, 687.493347f, 651.992920f, 5.888998f); // Banner Position Eventide
  //  SpawnGameObject(GO_DALARAN_BANNER_HOLDER, 5967.001465f, 613.845093f, 650.627136f, 2.810238f); // Banner Position Memorial (South)
	m_spiritHorde    = SpawnCreature(NPC_TAUNKA_SPIRIT_GUIDE,  5807.801758f, 588.264221f, 660.939026f, 1.653733f, TEAM_HORDE);
	m_spiritAlliance = SpawnCreature(NPC_DWARVEN_SPIRIT_GUIDE, 5807.801758f, 588.264221f, 660.939026f, 1.653733f, TEAM_ALLIANCE);

	if (m_DefenderTeam)
	{
        HideNpc(m_spiritAlliance);
		m_runeweaverHorde      = SpawnGameObject(GO_DALARAN_RUNEWEAVER_HORDE_BANNER,      5805.020508f, 639.484070f, 647.782959f, 2.515712f);
	//	m_eventideAlliance     = SpawnGameObject(GO_DALARAN_EVENTIDE_ALLIANCE_BANNER,    5641.049316f, 687.493347f, 651.992920f, 5.888998f);
	//	m_memorialAlliance     = SpawnGameObject(GO_DALARAN_MEMORIAL_ALLIANCE_BANNER,    5967.001465f, 613.845093f, 650.627136f, 2.810238f);
//		m_BannerCount = 1;
//		SpawnGameObject(GO_DALARAN_AURA_HORDE,    5805.020508f, 639.484070f, 647.782959f, 2.515712f); // Aura Position Runeweaver 
//		SpawnGameObject(GO_DALARAN_AURA_ALLIANCE, 5633.313477f, 691.144043f, 650.627136f, 2.810238f); // Aura Position Memorial (South)
//		SpawnGameObject(GO_DALARAN_AURA_ALLIANCE, 5974.899414f, 610.576599f, 651.992920f, 5.888998f); // Aura Position Eventide
	}
	else
	{
        HideNpc(m_spiritHorde);
		m_runeweaverAlliance   = SpawnGameObject(GO_DALARAN_RUNWEAVER_ALLIANCE_BANNER,   5805.020508f, 639.484070f, 647.782959f, 2.515712f);
	//	m_eventideHorde        = SpawnGameObject(GO_DALARAN_EVENTIDE_HORDE_BANNER,       5641.049316f, 687.493347f, 651.992920f, 5.888998f);
	//	m_memorialHorde        = SpawnGameObject(GO_DALARAN_MEMORIAL_HORDE_BANNER,       5967.001465f, 613.845093f, 650.627136f, 2.810238f);
//		m_BannerCount = 2;
//		SpawnGameObject(GO_DALARAN_AURA_ALLIANCE, 5805.020508f, 639.484070f, 647.782959f, 2.515712f); // Aura Position Runeweaver 
//		SpawnGameObject(GO_DALARAN_AURA_HORDE,    5633.313477f, 691.144043f, 650.627136f, 2.810238f); // Aura Position Memorial (South)
//		SpawnGameObject(GO_DALARAN_AURA_HORDE,    5974.899414f, 610.576599f, 651.992920f, 5.888998f); // Aura Position Eventide
	}

    return true;

}

bool BattlefieldWG::Update(uint32 diff)
{
    bool m_return = Battlefield::Update(diff);

	// This is what happen when you're a dick in c++, don't try this at home.
	if (m_runeweaverBannerTimerHorde)
	{
		if (m_runeweaverBannerTimerHorde > diff)
			m_runeweaverBannerTimerHorde -= diff;
		else
		{
			m_runeweaverBannerTimerHorde = 0;
			if (BfGraveyard* graveyard = GetGraveyardById(0))
				graveyard->GiveControlTo(TEAM_HORDE);

			if (m_runeweaverHContested)
				m_runeweaverHContested->RemoveFromWorld();

			m_runeweaverHorde = SpawnGameObject(GO_DALARAN_RUNEWEAVER_HORDE_BANNER, 5805.020508f, 639.484070f, 647.782959f, 2.515712f);

			sWorld->SendWorldText(MOBA_DALARAN_HORDE_RUNWEAVER_CONTROL);

			ShowNpc(m_spiritHorde, false);
			HideNpc(m_spiritAlliance);
//			m_BannerCount++;
		}
	}

	if (m_runeweaverBannerTimerAlliance)
	{
		if (m_runeweaverBannerTimerAlliance > diff)
			m_runeweaverBannerTimerAlliance -= diff;
		else
		{
			m_runeweaverBannerTimerAlliance = 0;
			if (BfGraveyard* graveyard = GetGraveyardById(0))
				graveyard->GiveControlTo(TEAM_ALLIANCE);

			if (m_runeweaverAContested)
				m_runeweaverAContested->RemoveFromWorld();

			m_runeweaverHorde = SpawnGameObject(GO_DALARAN_RUNWEAVER_ALLIANCE_BANNER, 5805.020508f, 639.484070f, 647.782959f, 2.515712f);

			sWorld->SendWorldText(MOBA_DALARAN_ALLIANCE_RUNWEAVER_CONTROL);

			ShowNpc(m_spiritAlliance, false);
			HideNpc(m_spiritHorde);
//			m_BannerCount--;
		}
	}

	if (m_eventideBannerTimerHorde)
	{
		if (m_eventideBannerTimerHorde > diff)
			m_eventideBannerTimerHorde -= diff;
		else
		{
			if (m_eventideHContested)
				m_eventideHContested->RemoveFromWorld();

			m_eventideBannerTimerHorde = 0;
			m_eventideHorde = SpawnGameObject(GO_DALARAN_EVENTIDE_HORDE_BANNER, 5641.049316f, 687.493347f, 651.992920f, 5.888998f);
//			m_BannerCount++;
		}
	}

	if (m_eventideBannerTimerAlliance)
	{
		if (m_eventideBannerTimerAlliance > diff)
			m_eventideBannerTimerAlliance -= diff;
		else
		{
			if (m_eventideAContested)
				m_eventideAContested->RemoveFromWorld();

			m_eventideBannerTimerAlliance = 0;
			m_eventideHorde = SpawnGameObject(GO_DALARAN_EVENTIDE_ALLIANCE_BANNER, 5641.049316f, 687.493347f, 651.992920f, 5.888998f);
//			m_BannerCount--;
		}
	}

	if (m_memorialBannerTimerHorde)
	{
		if (m_memorialBannerTimerHorde > diff)
			m_memorialBannerTimerHorde -= diff;
		else
		{
			if (m_memorialHContested)
				m_memorialHContested->RemoveFromWorld();

			m_memorialBannerTimerHorde = 0;
			m_memorialHorde = SpawnGameObject(GO_DALARAN_MEMORIAL_HORDE_BANNER, 5967.001465f, 613.845093f, 650.627136f, 2.810238f);
//			m_BannerCount++;
		}
	}

	if (m_memorialBannerTimerAlliance)
	{
		if (m_memorialBannerTimerAlliance > diff)
			m_memorialBannerTimerAlliance -= diff;
		else
		{
			if (m_memorialAContested)
				m_memorialAContested->RemoveFromWorld();

			m_memorialBannerTimerAlliance = 0;
			m_memorialHorde = SpawnGameObject(GO_DALARAN_MEMORIAL_ALLIANCE_BANNER, 5967.001465f, 613.845093f, 650.627136f, 2.810238f);
//			m_BannerCount--;
		}
	}

    return m_return;
}

void BattlefieldWG::OnBattleStart()
{
}

void BattlefieldWG::UpdateCounterVehicle(bool init)
{
}

void BattlefieldWG::OnBattleEnd(bool endByTimer)
{
}

// *******************************************************
// ******************* Reward System *********************
// *******************************************************
void BattlefieldWG::DoCompleteOrIncrementAchievement(uint32 achievement, Player* player, uint8 /*incrementNumber*/)
{
}

void BattlefieldWG::OnStartGrouping()
{
}

uint8 BattlefieldWG::GetSpiritGraveyardId(uint32 areaId, uint32 gyteam)
{
	//	uint32 gyteam = player->GetTeamId();
	if(gyteam == GetDefenderTeam() && areaId != BATTLEFIELD_DA_ZONEID)
		return BATTLEFIELD_WG_GY_KEEP;
	else
		return gyteam == TEAM_ALLIANCE ? BATTLEFIELD_WG_GY_ALLIANCE : BATTLEFIELD_WG_GY_HORDE;

    return 0;
}

void BattlefieldWG::OnCreatureCreate(Creature* creature)
{
    // Accessing to db spawned creatures
    switch (creature->GetEntry())
    {
        case NPC_DWARVEN_SPIRIT_GUIDE:
                m_GraveyardList[2]->SetSpirit(creature, TEAM_ALLIANCE);
            break;
        case NPC_TAUNKA_SPIRIT_GUIDE:
                m_GraveyardList[1]->SetSpirit(creature, TEAM_HORDE);
            break;
	}
}

void BattlefieldWG::OnCreatureRemove(Creature* /*creature*/)
{
}

void BattlefieldWG::OnGameObjectCreate(GameObject* go)
{
}

// Called when player kill a unit in wg zone
void BattlefieldWG::HandleKill(Player* killer, Unit* victim)
{
    if (killer == victim)
        return;

    bool again = false;
    TeamId killerTeam = killer->GetTeamId();

    if (victim->GetTypeId() == TYPEID_PLAYER)
    {
        for (GuidSet::const_iterator itr = m_PlayersInWar[killerTeam].begin(); itr != m_PlayersInWar[killerTeam].end(); ++itr)
            if (Player* player = sObjectAccessor->FindPlayer(*itr))
                if (player->GetDistance2d(killer) < 40)
                    PromotePlayer(player);
        return;
    }

    for (GuidSet::const_iterator itr = KeepCreature[GetOtherTeam(killerTeam)].begin();
         itr != KeepCreature[GetOtherTeam(killerTeam)].end(); ++itr)
    {
        if (Unit* unit = sObjectAccessor->FindUnit(*itr))
        {
            if (Creature* creature = unit->ToCreature())
            {
                if (victim->GetEntry() == creature->GetEntry() && !again)
                {
                    again = true;
                    for (GuidSet::const_iterator iter = m_PlayersInWar[killerTeam].begin(); iter != m_PlayersInWar[killerTeam].end(); ++iter)
                        if (Player* player = sObjectAccessor->FindPlayer(*iter))
                            if (player->GetDistance2d(killer) < 40.0f)
                                PromotePlayer(player);
                }
            }
        }
    }
    // TODO:Recent PvP activity worldstate
}

bool BattlefieldWG::FindAndRemoveVehicleFromList(Unit* vehicle)
{
    return false;
}

void BattlefieldWG::OnUnitDeath(Unit* unit)
{
}

// Update rank for player
void BattlefieldWG::PromotePlayer(Player* killer)
{
    if (!m_isActive)
        return;
    // Updating rank of player
    if (Aura* aur = killer->GetAura(SPELL_RECRUIT))
    {
        if (aur->GetStackAmount() >= 5)
        {
            killer->RemoveAura(SPELL_RECRUIT);
            killer->CastSpell(killer, SPELL_CORPORAL, true);
            SendWarningToPlayer(killer, BATTLEFIELD_WG_TEXT_FIRSTRANK);
        }
        else
            killer->CastSpell(killer, SPELL_RECRUIT, true);
    }
    else if (Aura* aur = killer->GetAura(SPELL_CORPORAL))
    {
        if (aur->GetStackAmount() >= 5)
        {
            killer->RemoveAura(SPELL_CORPORAL);
            killer->CastSpell(killer, SPELL_LIEUTENANT, true);
            SendWarningToPlayer(killer, BATTLEFIELD_WG_TEXT_SECONDRANK);
        }
        else
            killer->CastSpell(killer, SPELL_CORPORAL, true);
    }
}

void BattlefieldWG::RemoveAurasFromPlayer(Player* player)
{
    player->RemoveAurasDueToSpell(SPELL_RECRUIT);
    player->RemoveAurasDueToSpell(SPELL_CORPORAL);
    player->RemoveAurasDueToSpell(SPELL_LIEUTENANT);
    player->RemoveAurasDueToSpell(SPELL_TOWER_CONTROL);
    player->RemoveAurasDueToSpell(SPELL_SPIRITUAL_IMMUNITY);
    player->RemoveAurasDueToSpell(SPELL_TENACITY);
    player->RemoveAurasDueToSpell(SPELL_ESSENCE_OF_WINTERGRASP);
    player->RemoveAurasDueToSpell(SPELL_WINTERGRASP_RESTRICTED_FLIGHT_AREA);
}

void BattlefieldWG::OnPlayerJoinWar(Player* player)
{
}

void BattlefieldWG::OnPlayerLeaveWar(Player* player)
{
}

void BattlefieldWG::OnPlayerLeaveZone(Player* player)
{
    if (!m_isActive)
        RemoveAurasFromPlayer(player);

    player->RemoveAurasDueToSpell(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT);
    player->RemoveAurasDueToSpell(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT);
    player->RemoveAurasDueToSpell(SPELL_HORDE_CONTROL_PHASE_SHIFT);
    player->RemoveAurasDueToSpell(SPELL_ALLIANCE_CONTROL_PHASE_SHIFT);
}

void BattlefieldWG::OnPlayerEnterZone(Player* player)
{
}

uint32 BattlefieldWG::GetData(uint32 data)
{
    return Battlefield::GetData(data);
}


void BattlefieldWG::FillInitialWorldStates(WorldPacket& data)
{
}

void BattlefieldWG::SendInitWorldStatesTo(Player* player)
{
}

void BattlefieldWG::SendInitWorldStatesToAll()
{
}

void BattlefieldWG::BrokenWallOrTower(TeamId /*team*/)
{
}

// Called when a tower is broke
void BattlefieldWG::UpdatedDestroyedTowerCount(TeamId team)
{
}

void BattlefieldWG::ProcessEvent(WorldObject *obj, uint32 eventId)
{
    if (!obj)
        return;

    // We handle only gameobjects here
    GameObject* go = obj->ToGameObject();
    if (!go)
        return;

// On click on dalaran Banner
// Runeweaver Banner + Graveyard
	if (eventId)
		return;
		
    if (go->GetEntry() == GO_DALARAN_RUNEWEAVER_HORDE_BANNER)
    {
		if (BfGraveyard* graveyard = GetGraveyardById(0))
			graveyard->GiveControlTo(TEAM_NEUTRAL);
		
		sWorld->SendWorldText(MOBA_DALARAN_ALLIANCE_RUNWEAVER_ATTACK);
		
		m_runeweaverBannerTimerAlliance = CAPTURE_TIME;
		go->RemoveFromWorld();
		m_runeweaverAContested = SpawnGameObject(GO_DALARAN_RUNWEAVER_ACONTESTED_BANNER, 5805.020508f, 639.484070f, 647.782959f, 2.515712f);
		HideNpc(m_spiritHorde);
    }

	if (go->GetEntry() == GO_DALARAN_RUNWEAVER_ALLIANCE_BANNER)
	{
		if (BfGraveyard* graveyard = GetGraveyardById(0))
			graveyard->GiveControlTo(TEAM_NEUTRAL);

		sWorld->SendWorldText(MOBA_DALARAN_HORDE_RUNWEAVER_ATTACK);
		
		m_runeweaverBannerTimerHorde = CAPTURE_TIME;
		go->RemoveFromWorld();
		m_runeweaverHContested = SpawnGameObject(GO_DALARAN_RUNWEAVER_HCONTESTED_BANNER, 5805.020508f, 639.484070f, 647.782959f, 2.515712f);
		HideNpc(m_spiritAlliance);
	}

	if (go->GetEntry() == GO_DALARAN_RUNWEAVER_HCONTESTED_BANNER)
	{
		if (BfGraveyard* graveyard = GetGraveyardById(0))
			graveyard->GiveControlTo(TEAM_ALLIANCE);

		sWorld->SendWorldText(MOBA_DALARAN_ALLIANCE_RUNWEAVER_DEFEND);
		
		m_runeweaverBannerTimerHorde = 0;
		go->RemoveFromWorld();
		m_runeweaverAlliance = SpawnGameObject(GO_DALARAN_RUNWEAVER_ALLIANCE_BANNER,   5805.020508f, 639.484070f, 647.782959f, 2.515712f);
		ShowNpc(m_spiritAlliance, false);
		HideNpc(m_spiritHorde);
//		m_BannerCount--;
	}

	if (go->GetEntry() == GO_DALARAN_RUNWEAVER_ACONTESTED_BANNER)
	{
		if (BfGraveyard* graveyard = GetGraveyardById(0))
			graveyard->GiveControlTo(TEAM_HORDE);

		sWorld->SendWorldText(MOBA_DALARAN_HORDE_RUNWEAVER_DEFEND);
		
		m_runeweaverBannerTimerAlliance = 0;
		go->RemoveFromWorld();
		m_runeweaverHorde = SpawnGameObject(GO_DALARAN_RUNEWEAVER_HORDE_BANNER,   5805.020508f, 639.484070f, 647.782959f, 2.515712f);
		ShowNpc(m_spiritHorde, false);
		HideNpc(m_spiritAlliance);
//		m_BannerCount++;
	}

// Eventide Banner
	if (go->GetEntry() == GO_DALARAN_EVENTIDE_HORDE_BANNER)
	{
		m_eventideBannerTimerAlliance = CAPTURE_TIME;
		go->RemoveFromWorld();
		m_eventideAContested = SpawnGameObject(GO_DALARAN_EVENTIDE_ACONTESTED_BANNER, 5641.049316f, 687.493347f, 651.992920f, 5.888998f); 
	}
	if (go->GetEntry() == GO_DALARAN_EVENTIDE_ALLIANCE_BANNER)
	{
		m_eventideBannerTimerHorde = CAPTURE_TIME;
		go->RemoveFromWorld();
		m_eventideHContested = SpawnGameObject(GO_DALARAN_EVENTIDE_HCONTESTED_BANNER, 5641.049316f, 687.493347f, 651.992920f, 5.888998f); 
	}
	if (go->GetEntry() == GO_DALARAN_EVENTIDE_HCONTESTED_BANNER)
	{
		m_eventideBannerTimerHorde = 0;
		go->RemoveFromWorld();
		m_eventideAlliance = SpawnGameObject(GO_DALARAN_EVENTIDE_ALLIANCE_BANNER, 5641.049316f, 687.493347f, 651.992920f, 5.888998f); 
//		m_BannerCount--;
	}
	if (go->GetEntry() == GO_DALARAN_EVENTIDE_ACONTESTED_BANNER)
	{
		m_eventideBannerTimerAlliance = 0;
		go->RemoveFromWorld();
		m_eventideHorde = SpawnGameObject(GO_DALARAN_EVENTIDE_HORDE_BANNER, 5641.049316f, 687.493347f, 651.992920f, 5.888998f); 
//		m_BannerCount++;
	}

// Memorial Banner
	if (go->GetEntry() == GO_DALARAN_MEMORIAL_HORDE_BANNER)
	{
		m_memorialBannerTimerAlliance = CAPTURE_TIME;
		go->RemoveFromWorld();
		m_memorialAContested = SpawnGameObject(GO_DALARAN_MEMORIAL_ACONTESTED_BANNER, 5967.001465f, 613.845093f, 650.627136f, 2.810238f); 
	}
	if (go->GetEntry() == GO_DALARAN_MEMORIAL_ALLIANCE_BANNER)
	{
		m_memorialBannerTimerHorde = CAPTURE_TIME;
		go->RemoveFromWorld();
		m_memorialHContested = SpawnGameObject(GO_DALARAN_MEMORIAL_HCONTESTED_BANNER, 5967.001465f, 613.845093f, 650.627136f, 2.810238f); 
	}
	if (go->GetEntry() == GO_DALARAN_MEMORIAL_HCONTESTED_BANNER)
	{
		m_memorialBannerTimerHorde = 0;
		go->RemoveFromWorld();
		m_memorialAlliance = SpawnGameObject(GO_DALARAN_MEMORIAL_ALLIANCE_BANNER, 5967.001465f, 613.845093f, 650.627136f, 2.810238f); 
//		m_BannerCount--;
	}
	if (go->GetEntry() == GO_DALARAN_MEMORIAL_ACONTESTED_BANNER)
	{
		m_memorialBannerTimerAlliance = 0;
		go->RemoveFromWorld();
		m_memorialHorde = SpawnGameObject(GO_DALARAN_MEMORIAL_HORDE_BANNER, 5967.001465f, 613.845093f, 650.627136f, 2.810238f); 
//		m_BannerCount++;
	}
}

// Called when a tower is damaged, used for honor reward calcul
void BattlefieldWG::UpdateDamagedTowerCount(TeamId team)
{
}

// Update vehicle count WorldState to player
void BattlefieldWG::UpdateVehicleCountWG()
{
}

void BattlefieldWG::UpdateTenacity()
{
    TeamId team = TEAM_NEUTRAL;
    uint32 alliancePlayers = m_PlayersInWar[TEAM_ALLIANCE].size();
    uint32 hordePlayers = m_PlayersInWar[TEAM_HORDE].size();
    int32 newStack = 0;

    if (alliancePlayers && hordePlayers)
    {
        if (alliancePlayers < hordePlayers)
            newStack = int32((float(hordePlayers / alliancePlayers) - 1) * 4);  // positive, should cast on alliance
        else if (alliancePlayers > hordePlayers)
            newStack = int32((1 - float(alliancePlayers / hordePlayers)) * 4);  // negative, should cast on horde
    }

    if (newStack == int32(m_tenacityStack))
        return;

    if (m_tenacityStack > 0 && newStack <= 0)               // old buff was on alliance
        team = TEAM_ALLIANCE;
    else if (newStack >= 0)                                 // old buff was on horde
        team = TEAM_HORDE;

    m_tenacityStack = newStack;
    // Remove old buff
    if (team != TEAM_NEUTRAL)
    {
        for (GuidSet::const_iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
            if (Player* player = sObjectAccessor->FindPlayer(*itr))
                if (player->getLevel() >= m_MinLevel)
                    player->RemoveAurasDueToSpell(SPELL_TENACITY);

        for (GuidSet::const_iterator itr = m_vehicles[team].begin(); itr != m_vehicles[team].end(); ++itr)
            if (Unit* unit = sObjectAccessor->FindUnit(*itr))
                if (Creature* creature = unit->ToCreature())
                    creature->RemoveAurasDueToSpell(SPELL_TENACITY_VEHICLE);
    }

    // Apply new buff
    if (newStack)
    {
        team = newStack > 0 ? TEAM_ALLIANCE : TEAM_HORDE;

        if (newStack < 0)
            newStack = -newStack;
        if (newStack > 20)
            newStack = 20;

        uint32 buff_honor = SPELL_GREATEST_HONOR;
        if (newStack < 15)
            buff_honor = SPELL_GREATER_HONOR;
        if (newStack < 10)
            buff_honor = SPELL_GREAT_HONOR;
        if (newStack < 5)
            buff_honor = 0;

        for (GuidSet::const_iterator itr = m_PlayersInWar[team].begin(); itr != m_PlayersInWar[team].end(); ++itr)
            if (Player* player = sObjectAccessor->FindPlayer(*itr))
                player->SetAuraStack(SPELL_TENACITY, player, newStack);

        for (GuidSet::const_iterator itr = m_vehicles[team].begin(); itr != m_vehicles[team].end(); ++itr)
            if (Unit* unit = sObjectAccessor->FindUnit(*itr))
                if (Creature* creature = unit->ToCreature())
                    creature->SetAuraStack(SPELL_TENACITY_VEHICLE, creature, newStack);

        if (buff_honor != 0)
        {
            for (GuidSet::const_iterator itr = m_PlayersInWar[team].begin(); itr != m_PlayersInWar[team].end(); ++itr)
                if (Player* player = sObjectAccessor->FindPlayer(*itr))
                    player->CastSpell(player, buff_honor, true);
            for (GuidSet::const_iterator itr = m_vehicles[team].begin(); itr != m_vehicles[team].end(); ++itr)
                if (Unit* unit = sObjectAccessor->FindUnit(*itr))
                    if (Creature* creature = unit->ToCreature())
                        creature->CastSpell(creature, buff_honor, true);
        }
    }
}

BfGraveyardWG::BfGraveyardWG(BattlefieldWG* battlefield) : BfGraveyard(battlefield)
{
    m_Bf = battlefield;
}

