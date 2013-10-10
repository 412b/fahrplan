/****************************************************************************
**
**  This file is a part of Fahrplan.
**
**  This program is free software; you can redistribute it and/or modify
**  it under the terms of the GNU General Public License as published by
**  the Free Software Foundation; either version 2 of the License, or
**  (at your option) any later version.
**
**  This program is distributed in the hope that it will be useful,
**  but WITHOUT ANY WARRANTY; without even the implied warranty of
**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
**  GNU General Public License for more details.
**
**  You should have received a copy of the GNU General Public License along
**  with this program.  If not, see <http://www.gnu.org/licenses/>.
**
****************************************************************************/

#ifndef PARSER_DEFINITIONS_H
#define PARSER_DEFINITIONS_H

#include <QObject>
#include <QDate>
#include <QVariant>
#include <QDebug>

namespace FahrplanNS
{
    enum curReqStates {
        noneRequest,
        stationsByNameRequest,
        stationsByCoordinatesRequest,
        searchJourneyRequest,
        searchJourneyLaterRequest,
        searchJourneyEarlierRequest,
        journeyDetailsRequest,
        getTimeTableForStationRequest
    };
}

struct Station
{
    bool valid;
    QVariant id;
    QString name;
    QString type;
    QString miscInfo;
    qreal latitude;
    qreal longitude;

public:
    Station();
    explicit Station(bool isValid);

    bool operator ==(const Station &other) const;
    bool operator <(const Station &other) const;
};


struct StopStation : Station {
    QDateTime departureDateTime;
    QDateTime arrivalDateTime;

public:
    StopStation& operator=(const Station& station);
};


typedef QList<Station> StationsList;
Q_DECLARE_METATYPE(Station)
Q_DECLARE_METATYPE(StopStation)
Q_DECLARE_METATYPE(StationsList)

struct TimetableEntry
{
    StopStation currentStation;
    StopStation destinationStation;
    QString trainType;
    QString platform;
    QString miscInfo;

public:
    TimetableEntry();
};
typedef QList<TimetableEntry> TimetableEntriesList;
Q_DECLARE_METATYPE(TimetableEntry)
Q_DECLARE_METATYPE(TimetableEntriesList)

struct JourneyResultItem
{
    QString id;
    QDateTime departureDateTime;
    QDateTime arrivalDateTime;
    QString trainType;
    QString duration;
    QString transfers;
    QString miscInfo;
    QString internalData1;
    QString internalData2;

public:
    JourneyResultItem();
};

typedef QList<JourneyResultItem> JourneyResultList;
Q_DECLARE_METATYPE(JourneyResultItem)
Q_DECLARE_METATYPE(JourneyResultList)

struct JourneyResultHeader
{
    Station departureStation;
    Station arrivalStation;
    Station viaStation;
    QString timeInfo;
    JourneyResultList items;

public:
    JourneyResultHeader();
};

Q_DECLARE_METATYPE(JourneyResultHeader)

class JourneyDetailResultItem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(StopStation departureStation READ departureStation WRITE setDepartureStation)
    Q_PROPERTY(QString departureInfo READ departureInfo WRITE setDepartureInfo)
    Q_PROPERTY(StopStation arrivalStation READ arrivalStation WRITE setArrivalStation)
    Q_PROPERTY(QString arrivalInfo READ arrivalInfo WRITE setArrivalInfo)
    Q_PROPERTY(QString info READ info WRITE setInfo)
    Q_PROPERTY(QString train READ train WRITE setTrain)

    //Some Internal Data fields, primarly to store additional data per backend, like the details url
    Q_PROPERTY(QString internalData1 READ internalData1 WRITE setInternalData1)
    Q_PROPERTY(QString internalData2 READ internalData2 WRITE setInternalData2)
    public:
        StopStation &departureStation();
        void setDepartureStation(const StopStation &);
        QString departureInfo() const;
        void setDepartureInfo(const QString &);
        StopStation &arrivalStation();
        void setArrivalStation(const StopStation &);
        QString arrivalInfo() const;
        void setArrivalInfo(const QString &);
        QString info() const;
        void setInfo(const QString &);
        QString train() const;
        void setTrain(const QString &);
        QString internalData1() const;
        void setInternalData1(const QString &);
        QString internalData2() const;
        void setInternalData2(const QString &);
    private:
        StopStation m_departureStation;
        QString m_departureInfo;
        StopStation m_arrivalStation;
        QString m_arrivalInfo;
        QString m_info;
        QString m_train;
        QString m_internalData1;
        QString m_internalData2;
};

class JourneyDetailResultList : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString id READ id WRITE setId)
    Q_PROPERTY(qreal count READ itemcount)
    Q_PROPERTY(QString duration READ duration WRITE setDuration)
    Q_PROPERTY(QString info READ info WRITE setInfo)
    Q_PROPERTY(StopStation departureStation READ departureStation WRITE setDepartureStation)
    Q_PROPERTY(StopStation viaStation READ viaStation WRITE setViaStation)
    Q_PROPERTY(StopStation arrivalStation READ arrivalStation WRITE setArrivalStation)

    public slots:
        JourneyDetailResultItem *getItem(int);
    public:
        void appendItem(JourneyDetailResultItem *item);
        qreal itemcount();
        QString id() const;
        void setId(const QString &);
        StopStation &departureStation();
        void setDepartureStation(const StopStation &);
        StopStation &viaStation();
        void setViaStation(const StopStation &);
        StopStation &arrivalStation();
        void setArrivalStation(const StopStation &);
        QString info() const;
        void setInfo(const QString &);
        QString duration() const;
        void setDuration(const QString &);
    private:
        QList<JourneyDetailResultItem*> m_items;
        QString m_id;
        StopStation m_departureStation;
        StopStation m_viaStation;
        StopStation m_arrivalStation;
        QString m_info;
        QString m_duration;
};

#endif // PARSER_DEFINITIONS_H
