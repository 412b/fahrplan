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

import QtQuick 2.0
import Sailfish.Silica 1.0
import Fahrplan 1.0
import "../delegates"

Page {
    id: journeyDetailsResultsPage

    property JourneyDetailResultList currentResult;
    property string journeyTitle
    property string journeyDate
    property string journeyDuration

    allowedOrientations: Orientation.All

    SilicaListView {
        id: listView
        anchors.fill: parent
        width: parent.width
        visible: !indicator.visible

        model: journeyDetailResultModel

        header: Item {
            width: parent.width
            height: journeyStations.height

            PageHeader {
                id: journeyStations
                width: parent.width
                title: journeyTitle
                description: journeyDate + "<br/>" + journeyDuration
            }

        }

        delegate: JourneyDetailsDelegate {

        }

        VerticalScrollDecorator {}

        PushUpMenu {
            id: pushUpMenu
            visible: !indicator.visible && fahrplanBackend.supportsCalendar

            MenuItem {
                id: addToCalendar
                text: qsTr("Add to calendar")
                onClicked: {
                    fahrplanBackend.addJourneyDetailResultToCalendar(currentResult);
                    addToCalendar.enabled = false;
                    pushUpMenu.busy = true;
                }
            }
        }
    }

    onStatusChanged: {
        switch (status) {
            case PageStatus.Activating:
                indicator.visible = true;
                journeyTitle = qsTr("Searching...");
                journeyDate = "";
                journeyDuration = "";
                break;
        }
    }

    BusyIndicator {
        id: indicator
        anchors.centerIn: parent
        running: true
        size: BusyIndicatorSize.Large
    }

    ListModel {
        id: journeyDetailResultModel
    }

    Connections {
        target: fahrplanBackend

        onAddCalendarEntryComplete: {
            addToCalendar.enabled = true;
            pushUpMenu.busy = false;
            console.log("Calendar success");
            console.log(success);
        }

        onParserJourneyDetailsResult: {
            currentResult = result;
            console.log("Got detail results");
            console.log(result.count);

            if (result.count > 0) {
                journeyTitle = result.viaStation.length == 0 ? qsTr("<b>%1</b> to <b>%2</b>").arg(result.departureStation).arg(result.arrivalStation) : qsTr("<b>%1</b> via <b>%3</b> to <b>%2</b>").arg(result.departureStation).arg(result.arrivalStation).arg(result.viaStation);
                var departureDate = Format.formatDate(result.departureDateTime, Format.DateMedium);
                var arrivalDate = Format.formatDate(result.arrivalDateTime, Format.DateMedium);

                if (departureDate === arrivalDate) {
                    arrivalDate = "";
                }


                journeyDate = departureDate + " " + Format.formatDate(result.departureDateTime, Format.TimeValue) + " - " +
                                      arrivalDate + " " + Format.formatDate(result.arrivalDateTime, Format.TimeValue);

                journeyDuration = qsTr("Dur.: %1").arg(result.duration);

                journeyDetailResultModel.clear();
                for (var i = 0; i < result.count; i++) {
                    var item = result.getItem(i);
                    if (item === null) {
                        console.log(i, item, result.count, result)
                    }

                    var isStart = (i === 0);
                    var isStop = (i === result.count - 1);

                    var nextItem = isStop ? null : result.getItem(i+1);

                    /*
                    console.log("-------------" + i);
                    console.log(item.departureStation);
                    console.log(item.train);
                    console.log(item.arrivalStation);
                    if (nextItem) {
                        console.log(nextItem.departureStation);
                        console.log(nextItem.train);
                        console.log(nextItem.arrivalStation);
                    }
                    */

                    //Add first departure Station and the train
                    if (isStart) {
                        journeyDetailResultModel.append({
                                                            "isStart" : true,
                                                            "isStop" : false,
                                                            "trainName" : item.train,
                                                            "trainDirection" : item.direction,
                                                            "trainInfo" : item.info,
                                                            "stationName" : item.departureStation,
                                                            "stationInfo" : item.departureInfo,
                                                            "arrivalTime" : "",
                                                            "departureTime" : Qt.formatTime(item.departureDateTime, "hh:mm"),
                                                            "isStation" : true,
                                                            "isTrain" : true

                        });
                    }

                    //Add arrival station
                    if (isStop) {
                        journeyDetailResultModel.append({
                                                            "isStart" : false,
                                                            "isStop" : isStop,
                                                            "trainName" : "",
                                                            "trainDirection": "",
                                                            "trainInfo" : "",
                                                            "stationName" : item.arrivalStation,
                                                            "stationInfo" :  item.arrivalInfo,
                                                            "arrivalTime" :  Qt.formatTime(item.arrivalDateTime, "hh:mm"),
                                                            "departureTime" : "",
                                                            "isStation" : true,
                                                            "isTrain" : false

                        });
                    }

                    //Add one Station
                    if (nextItem) {
                        var stationInfo = item.arrivalInfo;
                        var stationName = item.arrivalStation;

                        if (stationInfo.length > 0 && nextItem.departureInfo) {
                            stationInfo = stationInfo + " / ";
                        }
                        if (nextItem.departureStation != item.arrivalStation) {
                            stationName += " / " + nextItem.departureStation;
                        }

                        stationInfo = stationInfo + nextItem.departureInfo;

                        journeyDetailResultModel.append({
                                                            "isStart" : false,
                                                            "isStop" : false,
                                                            "trainName" :  nextItem.train,
                                                            "trainDirection" : nextItem.direction,
                                                            "trainInfo" : nextItem.info,
                                                            "stationName" : stationName,
                                                            "stationInfo" : stationInfo,
                                                            "arrivalTime" : Qt.formatTime(item.arrivalDateTime, "hh:mm"),
                                                            "departureTime" :  Qt.formatTime(nextItem.departureDateTime, "hh:mm"),
                                                            "isStation" : true,
                                                            "isTrain" : true

                        });
                    }

                }
                indicator.visible = false;
            } else {
                pageStack.pop();
            }
        }
    }
}
