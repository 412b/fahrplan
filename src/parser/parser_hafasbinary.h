/*******************************************************************************

    This file is a part of Fahrplan for maemo 2009-2012

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

#ifndef PARSER_HAFASBINARY_H
#define PARSER_HAFASBINARY_H

#include <QObject>
#include <QDataStream>
#include <zlib.h>
#include "parser_hafasxml.h"

class ParserHafasBinary : public ParserHafasXml
{
    Q_OBJECT
public:
    explicit ParserHafasBinary(QObject *parent = 0);
    static QString getName() { return "HafasBinary"; }
    QString name() { return "HafasBinary"; }
protected:
    QString baseBinaryUrl;
    void parseSearchJourneyPart1(QNetworkReply *networkReply);
    void parseSearchJourneyPart2(QNetworkReply *networkReply);
    void parseSearchJourney(QNetworkReply *networkReply);
    QByteArray gzipDecompress(QByteArray compressData);
    QDate toDate(quint16 date);
    QDateTime toTime(quint16 time, QDate baseDate);
    QDateTime toTime(quint16 time);
};

#endif // PARSER_HAFASBINARY_H
