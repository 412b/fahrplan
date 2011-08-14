/*******************************************************************************

    This file is a part of Fahrplan for maemo 2009-2011

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

*/

#include "parser_definitions.h"

//-------------- StationsResultItem

QString StationsResultItem::stationName() const
{
    return m_stationName;
}

void StationsResultItem::setStationName(const QString &stationName)
{
    m_stationName = stationName;
}

QString StationsResultItem::stationType() const
{
    return m_stationName;
}

void StationsResultItem::setStationType(const QString &stationType)
{
    m_stationType = stationType;
}

QString StationsResultItem::miscInfo() const
{
    return m_miscInfo;
}

void StationsResultItem::setMiscInfo(const QString &miscInfo)
{
    m_miscInfo = miscInfo;
}

qreal StationsResultItem::longitude()
{
    return m_longitude;
}

void StationsResultItem::setLongitude(qreal longitude)
{
    m_longitude = longitude;
}

qreal StationsResultItem::latitude()
{
    return m_latitude;
}

void StationsResultItem::setLatitude(qreal latitude)
{
    m_latitude = latitude;
}

//------------- StationsResultList

qreal StationsResultList::itemcount()
{
    return m_items.count();
}

StationsResultItem *StationsResultList::getItem(int index)
{
    return  m_items.at(index);
}

void StationsResultList::appendItem(StationsResultItem *item)
{
    m_items.append(item);
}

//------------- JourneyResultList

qreal JourneyResultList::itemcount()
{
    return m_items.count();
}

JourneyResultItem *JourneyResultList::getItem(int index)
{
    return  m_items.at(index);
}

void JourneyResultList::appendItem(JourneyResultItem *item)
{
    m_items.append(item);
}

QString JourneyResultList::departureStation() const
{
    return m_departureStation;
}

void JourneyResultList::setDepartureStation(const QString &departureStation)
{
    m_departureStation = departureStation;
}

QString JourneyResultList::arrivalStation() const
{
    return m_arrivalStation;
}

void JourneyResultList::setArrivalStation(const QString &arrivalStation)
{
    m_arrivalStation = arrivalStation;
}

QString JourneyResultList::timeInfo() const
{
    return m_timeInfo;
}

void JourneyResultList::setTimeInfo(const QString &timeInfo)
{
    m_timeInfo = timeInfo;
}

//------------- JourneyResultItem

QString JourneyResultItem::id() const
{
    return m_id;
}

void JourneyResultItem::setId(const QString &id)
{
    m_id = id;
}

QDate JourneyResultItem::date() const
{
    return m_date;
}

void JourneyResultItem::setDate(const QDate &date)
{
    m_date = date;
}

QString JourneyResultItem::departureTime() const
{
    return m_departureTime;
}

void JourneyResultItem::setDepartureTime(const QString &departureTime)
{
    m_departureTime = departureTime;
}

QString JourneyResultItem::arrivalTime() const
{
    return m_arrivalTime;
}

void JourneyResultItem::setArrivalTime(const QString &arrivalTime)
{
    m_arrivalTime = arrivalTime;
}

QString JourneyResultItem::trainType() const
{
    return m_trainType;
}

void JourneyResultItem::setTrainType(const QString &trainType)
{
    m_trainType = trainType;
}

QString JourneyResultItem::duration() const
{
    return m_duration;
}

void JourneyResultItem::setDuration(const QString &duration)
{
    m_duration = duration;
}

QString JourneyResultItem::transfers() const
{
    return m_transfers;
}

void JourneyResultItem::setTransfers(const QString &transfers)
{
    m_transfers = transfers;
}

QString JourneyResultItem::miscInfo() const
{
    return m_miscInfo;
}

void JourneyResultItem::setMiscInfo(const QString &miscInfo)
{
    m_miscInfo = miscInfo;
}

QString JourneyResultItem::internalData1() const
{
    return m_internalData1;
}

void JourneyResultItem::setInternalData1(const QString &internalData1)
{
    m_internalData1 = internalData1;
}

QString JourneyResultItem::internalData2() const
{
    return m_internalData2;
}

void JourneyResultItem::setInternalData2(const QString &internalData2)
{
    m_internalData2 = internalData2;
}

//------------- JourneyDetailResultList

qreal JourneyDetailResultList::itemcount()
{
    return m_items.count();
}

JourneyDetailResultItem *JourneyDetailResultList::getItem(int index)
{
    return  m_items.at(index);
}

void JourneyDetailResultList::appendItem(JourneyDetailResultItem *item)
{
    m_items.append(item);
}

QString JourneyDetailResultList::departureStation() const
{
    return m_departureStation;
}

void JourneyDetailResultList::setDepartureStation(const QString &departureStation)
{
    m_departureStation = departureStation;
}

QString JourneyDetailResultList::arrivalStation() const
{
    return m_arrivalStation;
}

void JourneyDetailResultList::setArrivalStation(const QString &arrivalStation)
{
    m_arrivalStation = arrivalStation;
}

QString JourneyDetailResultList::info() const
{
    return m_info;
}

void JourneyDetailResultList::setInfo(const QString &info)
{
    m_info = info;
}

QString JourneyDetailResultList::duration() const
{
    return m_duration;
}

void JourneyDetailResultList::setDuration(const QString &duration)
{
    m_duration = duration;
}

//------------- JourneyDetailResultItem


QString JourneyDetailResultItem::departureStation() const
{
    return m_departureStation;
}

void JourneyDetailResultItem::setDepartureStation(const QString &departureStation)
{
    m_departureStation = departureStation;
}

QString JourneyDetailResultItem::departureInfo() const
{
    return m_departureInfo;
}

void JourneyDetailResultItem::setDepartureInfo(const QString &departureInfo)
{
    m_departureInfo = departureInfo;
}

QDateTime JourneyDetailResultItem::departureDateTime() const
{
    return m_departureDateTime;
}

void JourneyDetailResultItem::setDepartureDateTime(const QDateTime &departureDateTime)
{
    m_departureDateTime = departureDateTime;
}

QString JourneyDetailResultItem::arrivalStation() const
{
    return m_arrivalStation;
}

void JourneyDetailResultItem::setArrivalStation(const QString &arrivalStation)
{
    m_arrivalStation = arrivalStation;
}

QString JourneyDetailResultItem::arrivalInfo() const
{
    return m_arrivalInfo;
}

void JourneyDetailResultItem::setArrivalInfo(const QString &arrivalInfo)
{
    m_arrivalInfo = arrivalInfo;
}

QDateTime JourneyDetailResultItem::arrivalDateTime() const
{
    return m_arrivalDateTime;
}

void JourneyDetailResultItem::setArrivalDateTime(const QDateTime &arrivalDateTime)
{
    m_arrivalDateTime = arrivalDateTime;
}

QString JourneyDetailResultItem::info() const
{
    return m_info;
}

void JourneyDetailResultItem::setInfo(const QString &info)
{
    m_info = info;
}

QString JourneyDetailResultItem::train() const
{
    return m_train;
}

void JourneyDetailResultItem::setTrain(const QString &train)
{
    m_train = train;
}

QString JourneyDetailResultItem::internalData1() const
{
    return m_internalData1;
}

void JourneyDetailResultItem::setInternalData1(const QString &internalData1)
{
    m_internalData1 = internalData1;
}

QString JourneyDetailResultItem::internalData2() const
{
    return m_internalData2;
}

void JourneyDetailResultItem::setInternalData2(const QString &internalData2)
{
    m_internalData2 = internalData2;
}
