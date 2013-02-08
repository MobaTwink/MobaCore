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

BattlefieldWG::~BattlefieldWG() { }

bool BattlefieldWG::SetupBattlefield() {	
	uint32 rand = urand(0, 4);
    m_TypeId = BATTLEFIELD_WG;                              // See enum BattlefieldTypes
    m_BattleId = BATTLEFIELD_BATTLEID_WG;
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
	m_chestDepopTimer = 0;
	m_chestTimer = uint32(urand(CHEST_TIME*0.25f, CHEST_TIME*0.75f));
	AnnonceChest = true;

    m_tenacityStack = 0;

    KickPosition.Relocate(5728.117f, 2714.346f, 697.733f, 0);
    KickPosition.m_mapId = m_MapId;

    RegisterZone(m_ZoneId);

    m_Data32.resize(BATTLEFIELD_WG_DATA_MAX);

    m_saveTimer = 60000;

    SetGraveyardNumber(BATTLEFIELD_WG_GRAVEYARD_MAX);

    sWorld->setWorldState(BATTLEFIELD_WG_WORLD_STATE_ACTIVE, uint64(false));
    sWorld->setWorldState(BATTLEFIELD_WG_WORLD_STATE_DEFENDER, uint64(rand % 2));
    sWorld->setWorldState(ClockWorldState[0], uint64(m_NoWarBattleTime));

    m_isActive = bool(sWorld->getWorldState(BATTLEFIELD_WG_WORLD_STATE_ACTIVE));
    m_DefenderTeam = TeamId(sWorld->getWorldState(BATTLEFIELD_WG_WORLD_STATE_DEFENDER));

    m_Timer = sWorld->getWorldState(ClockWorldState[0]);
    if (m_isActive) {
        m_isActive = false;
        m_Timer = m_RestartAfterCrash;
    }

    for (uint8 i = 0; i < BATTLEFIELD_WG_GRAVEYARD_MAX; i++) {
        BfGraveyardWG* graveyard = new BfGraveyardWG(this);
        if (WGGraveYard[i].startcontrol == TEAM_NEUTRAL) {
            graveyard->Initialize(m_DefenderTeam, WGGraveYard[i].gyid);
		} else {
            graveyard->Initialize(WGGraveYard[i].startcontrol, WGGraveYard[i].gyid);
		}
        graveyard->SetTextId(WGGraveYard[i].textid);
        m_GraveyardList[i] = graveyard;
    }

	SpawnCreature(NPC_DWARVEN_SPIRIT_GUIDE,   5660.125488f, 794.830627f, 654.301147f, 5.623914f, TEAM_ALLIANCE); // Spirit Guide Alliance
	SpawnCreature(NPC_TAUNKA_SPIRIT_GUIDE,    5974.947266f, 544.667786f, 661.087036f, 2.607985f, TEAM_HORDE);    // Spirit Guide Horde
    SpawnGameObject(GO_DALARAN_BANNER_HOLDER, 5805.020508f, 639.484070f, 647.782959f, 2.515712f);                // Banner Position Runeweaver 
	m_spiritHorde    = SpawnCreature(NPC_TAUNKA_SPIRIT_GUIDE,  5807.801758f, 588.264221f, 660.939026f, 1.653733f, TEAM_HORDE);
	m_spiritAlliance = SpawnCreature(NPC_DWARVEN_SPIRIT_GUIDE, 5807.801758f, 588.264221f, 660.939026f, 1.653733f, TEAM_ALLIANCE);
    m_eventideBuff   = SpawnGameObject(EventideBuffs[rand],       5641.049316f, 687.493347f, 651.992920f, 5.888998f); // Buff Eventide
    m_memorialBuff   = SpawnGameObject(MemorialBuffs[4-rand], 5967.001465f, 613.845093f, 650.627136f, 2.810238f); // Buff (South)

	if (m_DefenderTeam) {
        HideNpc(m_spiritAlliance);
		m_runeweaverHorde      = SpawnGameObject(GO_DALARAN_RUNEWEAVER_HORDE_BANNER,   5805.020508f, 639.484070f, 647.782959f, 2.515712f);
	} else {
        HideNpc(m_spiritHorde);
		m_runeweaverAlliance   = SpawnGameObject(GO_DALARAN_RUNWEAVER_ALLIANCE_BANNER, 5805.020508f, 639.484070f, 647.782959f, 2.515712f);
	}
    return true;
}

bool BattlefieldWG::Update(uint32 diff) {
    bool m_return = Battlefield::Update(diff);

	if (m_runeweaverBannerTimerHorde) {
		if (m_runeweaverBannerTimerHorde > diff) {
			m_runeweaverBannerTimerHorde -= diff;
		} else {
			m_runeweaverBannerTimerHorde = 0;
			if (BfGraveyard* graveyard = GetGraveyardById(0)) {
				graveyard->GiveControlTo(TEAM_HORDE);
			}
			if (m_runeweaverHContested) {
				m_runeweaverHContested->RemoveFromWorld();
			}
			m_runeweaverHorde = SpawnGameObject(GO_DALARAN_RUNEWEAVER_HORDE_BANNER, 5805.020508f, 639.484070f, 647.782959f, 2.515712f);
			sWorld->SendWorldText(NEVA_DALARAN_HORDE_RUNWEAVER_CONTROL);
			ShowNpc(m_spiritHorde, false);
			HideNpc(m_spiritAlliance);
		}
	}
	if (m_runeweaverBannerTimerAlliance) {
		if (m_runeweaverBannerTimerAlliance > diff) {
			m_runeweaverBannerTimerAlliance -= diff;
		} else {
			m_runeweaverBannerTimerAlliance = 0;
			if (BfGraveyard* graveyard = GetGraveyardById(0)) {
				graveyard->GiveControlTo(TEAM_ALLIANCE);
			}
			if (m_runeweaverAContested) {
				m_runeweaverAContested->RemoveFromWorld();
			}
			m_runeweaverHorde = SpawnGameObject(GO_DALARAN_RUNWEAVER_ALLIANCE_BANNER, 5805.020508f, 639.484070f, 647.782959f, 2.515712f);
			sWorld->SendWorldText(NEVA_DALARAN_ALLIANCE_RUNWEAVER_CONTROL);
			ShowNpc(m_spiritAlliance, false);
			HideNpc(m_spiritHorde);
		}
	}
	if (uint32 PlayerCount = sWorld->GetPlayerCount() > 1) {
		if (m_chestTimer > diff) {
			if (m_chestTimer > (5*MINUTE*IN_MILLISECONDS)) {
				if (PlayerCount > 24) {
					PlayerCount = 24;
				}
				m_chestTimer -= ceil(PlayerCount / 2) * diff;
			} else {
				if (AnnonceChest) {
					sWorld->SendWorldText(NEVA_CHEST_SOON);
					AnnonceChest = false;
				}
				m_chestTimer -= diff;
			}
		} else {
			sWorld->SendWorldText(NEVA_CHEST_EVENT);
			m_chest = SpawnGameObject(GO_DALARAN_CHEST, 5804.437500f, 640.036133f, 609.886597f, 2.32635f);
			m_chestTimer = CHEST_TIME;
			AnnonceChest = true;
		}
	}
	if (m_chestDepopTimer && m_chest) {
		if (m_chestDepopTimer > diff) {
			m_chestDepopTimer -= diff;
		} else {
			m_chest->RemoveFromWorld();
			m_chestDepopTimer = 0;
		}
	}
	if (m_eventideBankTimer) {
		if (m_eventideBankTimer > diff) {
			m_eventideBankTimer -= diff;
		} else {
			m_eventideBankTimer = 0;
            m_eventideBuff = SpawnGameObject(EventideBuffs[urand(0,4)], 5641.049316f, 687.493347f, 651.992920f, 5.888998f); // Buff Eventide
		}
	}
	if (m_memorialBankTimer) {
		if (m_memorialBankTimer > diff) {
			m_memorialBankTimer -= diff;
		} else {
			m_memorialBankTimer = 0;
		    m_memorialBuff = SpawnGameObject(MemorialBuffs[urand(0,4)], 5967.001465f, 613.845093f, 650.627136f, 2.810238f); // Buff (South)
		}
	}
    return m_return;
}

void BattlefieldWG::OnBattleStart() { }

void BattlefieldWG::UpdateCounterVehicle(bool init) { }

void BattlefieldWG::OnBattleEnd(bool endByTimer) { }

void BattlefieldWG::DoCompleteOrIncrementAchievement(uint32 achievement, Player* player, uint8 /*incrementNumber*/) { }

void BattlefieldWG::OnStartGrouping() { }

uint8 BattlefieldWG::GetSpiritGraveyardId(uint32 areaId, uint32 gyteam) {
	if(gyteam == GetDefenderTeam() && areaId != BATTLEFIELD_DA_ZONEID) { return BATTLEFIELD_WG_GY_KEEP; }
	else { return gyteam == TEAM_ALLIANCE ? BATTLEFIELD_WG_GY_ALLIANCE : BATTLEFIELD_WG_GY_HORDE; }
    return 0;
}

void BattlefieldWG::OnCreatureCreate(Creature* creature) {
    switch (creature->GetEntry()) {
        case NPC_DWARVEN_SPIRIT_GUIDE:
                m_GraveyardList[2]->SetSpirit(creature, TEAM_ALLIANCE);
            break;
        case NPC_TAUNKA_SPIRIT_GUIDE:
                m_GraveyardList[1]->SetSpirit(creature, TEAM_HORDE);
            break;
	}
}

void BattlefieldWG::OnCreatureRemove(Creature* /*creature*/) { }

void BattlefieldWG::OnGameObjectCreate(GameObject* go) { }

// Called when player kill a unit in wg zone
void BattlefieldWG::HandleKill(Player* killer, Unit* victim) { }

bool BattlefieldWG::FindAndRemoveVehicleFromList(Unit* vehicle) { return false; }

void BattlefieldWG::OnUnitDeath(Unit* unit) { }

// Update rank for player
void BattlefieldWG::PromotePlayer(Player* killer) { }

void BattlefieldWG::RemoveAurasFromPlayer(Player* player) { }

void BattlefieldWG::OnPlayerJoinWar(Player* player) { }

void BattlefieldWG::OnPlayerLeaveWar(Player* player) { }

void BattlefieldWG::OnPlayerLeaveZone(Player* player) { }

void BattlefieldWG::OnPlayerEnterZone(Player* player) { }

uint32 BattlefieldWG::GetData(uint32 data) { return Battlefield::GetData(data); }


void BattlefieldWG::FillInitialWorldStates(WorldPacket& data) { }

void BattlefieldWG::SendInitWorldStatesTo(Player* player) { }

void BattlefieldWG::SendInitWorldStatesToAll() { }

void BattlefieldWG::BrokenWallOrTower(TeamId /*team*/) { }

void BattlefieldWG::UpdatedDestroyedTowerCount(TeamId team) { }

void BattlefieldWG::ProcessEvent(WorldObject *obj, uint32 eventId) {
    if (!obj) { return; }
    GameObject* go = obj->ToGameObject();
	if (!go) { return; }

	switch (go->GetEntry()) {
	case GO_DALARAN_RUNEWEAVER_HORDE_BANNER :
		if (BfGraveyard* graveyard = GetGraveyardById(0)) { graveyard->GiveControlTo(TEAM_NEUTRAL); }
		sWorld->SendWorldText(NEVA_DALARAN_ALLIANCE_RUNWEAVER_ATTACK);
		m_runeweaverBannerTimerAlliance = CAPTURE_TIME;
		go->RemoveFromWorld();
		m_runeweaverAContested = SpawnGameObject(GO_DALARAN_RUNWEAVER_ACONTESTED_BANNER, 5805.020508f, 639.484070f, 647.782959f, 2.515712f);
		HideNpc(m_spiritHorde);
		break;

	case GO_DALARAN_RUNWEAVER_ALLIANCE_BANNER :
		if (BfGraveyard* graveyard = GetGraveyardById(0)) { graveyard->GiveControlTo(TEAM_NEUTRAL); }
		sWorld->SendWorldText(NEVA_DALARAN_HORDE_RUNWEAVER_ATTACK);
		m_runeweaverBannerTimerHorde = CAPTURE_TIME;
		go->RemoveFromWorld();
		m_runeweaverHContested = SpawnGameObject(GO_DALARAN_RUNWEAVER_HCONTESTED_BANNER, 5805.020508f, 639.484070f, 647.782959f, 2.515712f);
		HideNpc(m_spiritAlliance);
		break;

	case GO_DALARAN_RUNWEAVER_HCONTESTED_BANNER :
		if (BfGraveyard* graveyard = GetGraveyardById(0)) { graveyard->GiveControlTo(TEAM_ALLIANCE); }
		sWorld->SendWorldText(NEVA_DALARAN_ALLIANCE_RUNWEAVER_DEFEND);
		m_runeweaverBannerTimerHorde = 0;
		go->RemoveFromWorld();
		m_runeweaverAlliance = SpawnGameObject(GO_DALARAN_RUNWEAVER_ALLIANCE_BANNER,   5805.020508f, 639.484070f, 647.782959f, 2.515712f);
		ShowNpc(m_spiritAlliance, false);
		HideNpc(m_spiritHorde);
		break;

	case GO_DALARAN_RUNWEAVER_ACONTESTED_BANNER :
		if (BfGraveyard* graveyard = GetGraveyardById(0)) { graveyard->GiveControlTo(TEAM_HORDE); }
		sWorld->SendWorldText(NEVA_DALARAN_HORDE_RUNWEAVER_DEFEND);
		m_runeweaverBannerTimerAlliance = 0;
		go->RemoveFromWorld();
		m_runeweaverHorde = SpawnGameObject(GO_DALARAN_RUNEWEAVER_HORDE_BANNER,   5805.020508f, 639.484070f, 647.782959f, 2.515712f);
		ShowNpc(m_spiritHorde, false);
		HideNpc(m_spiritAlliance);
		break;

	case GO_DALARAN_CHEST : if (m_chest) { m_chestDepopTimer = 4*MINUTE*IN_MILLISECONDS; } break;

	case GO_DALARAN_EVENTIDE_BUFF_SPRINT :
		m_eventideBankTimer = 5*MINUTE*IN_MILLISECONDS;
		go->RemoveFromWorld();
		break;

	case GO_DALARAN_MEMORIAL_BUFF_SPRINT :
		m_memorialBankTimer = 5*MINUTE*IN_MILLISECONDS;
		go->RemoveFromWorld();
		break;

	case GO_DALARAN_EVENTIDE_BUFF_REGEN :
		m_eventideBankTimer = 1*MINUTE*IN_MILLISECONDS;
		go->RemoveFromWorld();
		break;
	case GO_DALARAN_MEMORIAL_BUFF_REGEN :
		m_memorialBankTimer = 1*MINUTE*IN_MILLISECONDS;
		go->RemoveFromWorld();
		break;
		
	case GO_DALARAN_EVENTIDE_BUFF_BERSERK :
		m_eventideBankTimer = 2*MINUTE*IN_MILLISECONDS;
		go->RemoveFromWorld();
		break;

	case GO_DALARAN_MEMORIAL_BUFF_BERSERK :
		m_memorialBankTimer = 2*MINUTE*IN_MILLISECONDS;
		go->RemoveFromWorld();
		break;

	default: break;
	}
}

void BattlefieldWG::UpdateDamagedTowerCount(TeamId team) { }

void BattlefieldWG::UpdateVehicleCountWG() { }

void BattlefieldWG::UpdateTenacity() { }

BfGraveyardWG::BfGraveyardWG(BattlefieldWG* battlefield) : BfGraveyard(battlefield) { m_Bf = battlefield; }

