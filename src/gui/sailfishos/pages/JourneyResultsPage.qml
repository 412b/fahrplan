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
    id: journeyResultsPage

    property string journeyTitle
    property string journeyDate

    allowedOrientations: Orientation.All

    SilicaListView {
        id: listView
        anchors.fill: parent
        width: parent.width
        //visible: !indicator.visible

        model: indicator.visible ? undefined : journeyResultModel

        header: PageHeader {
            id: journeyDesc
            title: journeyTitle
            //description: Format.formatDate(fahrplanBackend.dateTime, Format.Timepoint)//journeyDate
        }

        delegate: JourneyDelegate {
            onClicked: {
                //pageStack.push(detailsResultsPage);
                pageStack.push(Qt.resolvedUrl("JourneyDetailsResultsPage.qml"), {})
                fahrplanBackend.parser.getJourneyDetails(model.id);
            }
        }

        section {
            property: "date"
            delegate: Item {

                anchors {
                    left: parent.left
                    right: parent.right
                }

                height: childrenRect.height + Theme.paddingLarge

                SectionHeader {
                    id: sectionName
                    text: section
                    textFormat: Text.PlainText
                }
                Row {
                    id: listHead
                    width: parent.width
                    visible: !indicator.visible

                    anchors {
                        leftMargin: Theme.paddingMedium
                        rightMargin: Theme.paddingMedium
                        left: parent.left
                        right: parent.right
                        top: sectionName.bottom
                    }

                    Label {
                        text: qsTr("Dep.")
                        width: (parent.width - 3) / 4
                        color: Theme.secondaryColor
                        textFormat: Text.PlainText
                    }

                    Label {
                        text: qsTr("Arr.")
                        width: (parent.width - 3) / 4
                        color: Theme.secondaryColor
                        textFormat: Text.PlainText
                    }

                    Label {
                        horizontalAlignment: Text.AlignHCenter
                        text: qsTr("Dur.")
                        width: (parent.width - 3) / 4
                        color: Theme.secondaryColor
                        textFormat: Text.PlainText
                    }

                    Label {
                        horizontalAlignment: Text.AlignHCenter
                        text: qsTr("Trans.")
                        width: (parent.width - 3) / 4
                        color: Theme.secondaryColor
                        textFormat: Text.PlainText
                    }
                }
            }
        }

        VerticalScrollDecorator {}

        ViewPlaceholder {
          id: errorMsg
        }

        PullDownMenu {
            visible: !indicator.visible
            MenuItem {
                text: qsTr("Earlier")
                enabled: (indicator.visible === false)
                onClicked: {
                    indicator.visible = true;
                    fahrplanBackend.parser.searchJourneyEarlier();
                }
            }
        }

        PushUpMenu {
            visible: !indicator.visible
            MenuItem {
                text: qsTr("Later")
                onClicked: {
                    indicator.visible = true;
                    fahrplanBackend.parser.searchJourneyLater();
                }
            }
        }

    }

    onStatusChanged: {
        switch (status) {
            case PageStatus.Activating:
                if (pageStack.depth === 2) {
                    indicator.visible = true;
                    journeyTitle = qsTr("Searching...");
                    journeyDate = "";
                    errorMsg.visible = false;
                    fahrplanBackend.searchJourney();
                }
                break;
            case PageStatus.Deactivating:
                if (pageStack.depth === 1) {
                    indicator.visible = true;
                    errorMsg.visible = false;
                    fahrplanBackend.parser.cancelRequest();
                    fahrplanBackend.parser.clearJourney();
                }
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
        id: journeyResultModel
    }

    Connections {
        target: fahrplanBackend

        onParserJourneyResult: {
            console.log("Got results");
            console.log(result.count);
            indicator.visible = false;
            errorMsg.enabled = false;
            journeyTitle = result.viaStation.length == 0 ? qsTr("<b>%1</b> to <b>%2</b>").arg(result.departureStation).arg(result.arrivalStation) : qsTr("<b>%1</b> via <b>%3</b> to <b>%2</b>").arg(result.departureStation).arg(result.arrivalStation).arg(result.viaStation)

            journeyDate = result.timeInfo;

            journeyResultModel.clear();
            for (var i = 0; i < result.count; i++) {
                var item = result.getItem(i);
                journeyResultModel.append({
                    "id": item.id,
                    "date": Format.formatDate(item.date, Format.DateMedium),
                    "departureTime": item.departureTime,
                    "arrivalTime": item.arrivalTime,
                    "trainType": item.trainType,
                    "duration": item.duration,
                    "transfers": item.transfers,
                    "miscInfo": item.miscInfo
                });
            }
        }

        onParserErrorOccured: {
            console.log("Got error")
            console.log(msg)
            errorMsg.enabled = true;
            indicator.visible = false;
            journeyTitle = qsTr("Error");
            errorMsg.text = msg;
        }
    }

//    JourneyDetailsResultsPage {
//        id: detailsResultsPage
//    }
}
