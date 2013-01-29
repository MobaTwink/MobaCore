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

#include "BattlefieldMgr.h"
#include "Zones/BattlefieldWG.h"
#include "ObjectMgr.h"
#include "Player.h"

BattlefieldMgr::BattlefieldMgr()
{
    m_UpdateTimer = 0;
	m_AnnounceTimer = 0;
    amountHorde = 0;
    amountAlliance = 0;
	rateUndernumber = 0;
	rateOutnumber = 0;
	minCount = 10.0f;
	amountUndernumber = 1.0f;
	amountOutnumber = 1.0f;
	diffMax = 1.0f;
	honorMax = 1.6f;
	honorMin = 0.6f;
    //sLog->outDebug(LOG_FILTER_BATTLEFIELD, "Instantiating BattlefieldMgr");
}

BattlefieldMgr::~BattlefieldMgr()
{
    //sLog->outDebug(LOG_FILTER_BATTLEFIELD, "Deleting BattlefieldMgr");
    for (BattlefieldSet::iterator itr = m_BattlefieldSet.begin(); itr != m_BattlefieldSet.end(); ++itr)
        delete *itr;
}

void BattlefieldMgr::InitBattlefield()
{
    Battlefield* pBf = new BattlefieldWG;
    // respawn, init variables
    if (!pBf->SetupBattlefield())
    {
        sLog->outInfo(LOG_FILTER_GENERAL, "Battlefield : Wintergrasp init failed.");
        delete pBf;
    }
    else
    {
        m_BattlefieldSet.push_back(pBf);
        sLog->outInfo(LOG_FILTER_GENERAL, "Battlefield : Wintergrasp successfully initiated.");
    }

    /* For Cataclysm: Tol Barad
       pBf = new BattlefieldTB;
       // respawn, init variables
       if(!pBf->SetupBattlefield())
       {
       sLog->outDebug(LOG_FILTER_BATTLEFIELD, "Battlefield : Tol Barad init failed.");
       delete pBf;
       }
       else
       {
       m_BattlefieldSet.push_back(pBf);
       sLog->outDebug(LOG_FILTER_BATTLEFIELD, "Battlefield : Tol Barad successfully initiated.");
       } */
}

void BattlefieldMgr::AddZone(uint32 zoneid, Battlefield *handle)
{
    m_BattlefieldMap[zoneid] = handle;
}

void BattlefieldMgr::HandlePlayerEnterZone(Player * player, uint32 zoneid)
{
	if(player->GetTeamId()) {
		amountHorde = (amountHorde > 0) ? amountHorde + 1 : 1;
	} else {
		amountAlliance = (amountAlliance > 0) ? amountAlliance + 1 : 1;
	}
}

void BattlefieldMgr::HandlePlayerLeaveZone(Player * player, uint32 zoneid)
{
	if(player->GetTeamId()) {
		amountHorde = (amountHorde > 0) ? amountHorde - 1 : 0;
	} else {
		amountAlliance = (amountAlliance > 0) ? amountAlliance - 1 : 0;
	}
}

Battlefield *BattlefieldMgr::GetBattlefieldToZoneId(uint32 zoneid)
{
    BattlefieldMap::iterator itr = m_BattlefieldMap.find(zoneid);
    if (itr == m_BattlefieldMap.end())
    {
        // no handle for this zone, return
        return NULL;
    }
    if (!itr->second->IsEnabled())
        return NULL;
    return itr->second;
}

Battlefield *BattlefieldMgr::GetBattlefieldByBattleId(uint32 battleid)
{
    for (BattlefieldSet::iterator itr = m_BattlefieldSet.begin(); itr != m_BattlefieldSet.end(); ++itr)
    {
        if ((*itr)->GetBattleId() == battleid)
            return (*itr);
    }
    return NULL;
}

void BattlefieldMgr::Update(uint32 diff)
{
    m_UpdateTimer += diff;
    m_AnnounceTimer += diff;
    if (m_UpdateTimer > BATTLEFIELD_OBJECTIVE_UPDATE_INTERVAL)  {
		BattlefieldWG* bf = (BattlefieldWG*)sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
		bf->Update(m_UpdateTimer);
        m_UpdateTimer = 0;
    }
    if (m_AnnounceTimer > ANNOUNCE_UPDATE_INTERVAL) {
		if(amountAlliance && amountHorde) {
			std::stringstream s;
			if (amountHorde == amountAlliance) {
				s << "<|cffd88af9Dalaran|r> |cffffffff" << amountAlliance << "|r players in each side, everyone get |cffffffff100%|r honor.";
			} else {
				s << "<|cffd88af9Dalaran|r> |cff00aeff" << amountAlliance << " Alliance|r (honor rate |cffffffff" ;
				if (amountAlliance > amountHorde) {
					amountUndernumber = amountHorde;
					amountOutnumber = amountAlliance;
				} else {
					amountUndernumber = amountAlliance;
					amountOutnumber = amountHorde;
				}
				if (amountUndernumber < minCount) {
					float add = ((2 * (minCount - amountUndernumber)) / 3);
					amountUndernumber += add;
					amountOutnumber += add;
				}
				diffMax = amountUndernumber * honorMax;
				float diffMin = (diffMax - amountOutnumber);
				if(diffMin > 0) {
					rateOutnumber = (100.0f / (diffMax - amountUndernumber)* diffMin);
					if (rateOutnumber < 1.0f) {
						rateOutnumber = 1.0f;
					}
				} else {
					rateOutnumber = 1.0f;
				}
				if(amountUndernumber / amountOutnumber < honorMax) {
					rateUndernumber = ((500.0f / (amountUndernumber * honorMin)) * (amountOutnumber - amountUndernumber)) + 100.0f;
				} else {
					rateUndernumber = 600.0f;
				}
				if (amountAlliance < amountHorde) {	
					s << floor(rateUndernumber+0.5f) <<"%|r) vs |cffff2400" <<  amountHorde << " Horde|r (honor rate |cffffffff" << floor(rateOutnumber+0.5f)   <<"%|r)";
				} else {
					s << floor(rateOutnumber+0.5f)   <<"%|r) vs |cffff2400" <<  amountHorde << " Horde|r (honor rate |cffffffff" << floor(rateUndernumber+0.5f) <<"%|r)";
				}
			}
			sWorld->SendGlobalText((s.str()).c_str(), 0);
		}
		m_AnnounceTimer = 0;
    }
}

ZoneScript *BattlefieldMgr::GetZoneScript(uint32 zoneId)
{
    BattlefieldMap::iterator itr = m_BattlefieldMap.find(zoneId);
    if (itr != m_BattlefieldMap.end())
        return itr->second;
    else
        return NULL;
}
