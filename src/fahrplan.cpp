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

#include "fahrplan.h"

ParserAbstract *Fahrplan::m_parser;

Fahrplan::Fahrplan(QObject *parent) :
    QObject(parent)
{
    if (!m_parser) {
        m_parser = new ParserHafasXml();
    }

    connect(m_parser, SIGNAL(stationsResult(StationsResultList*)), this, SLOT(stationsResult(StationsResultList*)));
    connect(m_parser, SIGNAL(journeyResult(JourneyResultList*)), this, SLOT(journeyResult(JourneyResultList*)));
}

ParserAbstract* Fahrplan::parser()
{
    return m_parser;
}

void Fahrplan::stationsResult(StationsResultList *result)
{
    emit parserStationsResult(result);
}

void Fahrplan::journeyResult(JourneyResultList *result)
{
    emit parserJourneyResult(result);
}
