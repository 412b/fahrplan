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
import QtPositioning 5.0
import Fahrplan 1.0
import "../delegates"

Page {
    id: stationSelect
    //canAccept: false

    property string searchString

    allowedOrientations: Orientation.All

    onSearchStringChanged: {
        fahrplanBackend.findStationsByName(searchString);
    }

    property int type: FahrplanBackend.DepartureStation
    property FahrplanBackend fahrplanBackend: null

    SilicaFlickable {
        id: listView
        anchors.fill: parent
        contentHeight: column.height
        contentWidth: parent.width

        VerticalScrollDecorator {}

        Column {
            id: column
            spacing: 0
            width: parent.width

            PageHeader {
                title: qsTr("Select station")
            }

            Row {
                width: parent.width

                SearchField {
                    id: searchField
                    width: parent.width - gpsButton.width - 10

                    Binding {
                        target: stationSelect
                        property: "searchString"
                        value: searchField.text.trim()
                    }
                }

                Item {
                    Connections {
                        target: listView
                        onDragStarted: if (searchField.focus) searchField.focus = false;
                    }
                }

                IconButton {
                    id: gpsButton
                    width: icon.width
                    height: parent.height
                    icon.source: "image://theme/icon-m-gps"

                    onClicked: {
                        fahrplanBackend.stationSearchResults.clear();
                        positionSource.update();
                    }
                }
            }

            ListView {
                model: fahrplanBackend.stationSearchResults
                width: parent.width
                height: contentHeight
                visible: count > 0
                interactive: false

                currentIndex: -1

                header: SectionHeader {
                    text: qsTr("Search")
                }

                delegate: StationDelegate {
                    menu: stationContextMenu
                    onStationSelected:  {
                        pageStack.pop();
                    }
                }
            }

            ListView {
                id: favoritesList
                model: fahrplanBackend.favorites
                width: parent.width
                height: contentHeight
                interactive: false

                currentIndex: -1

                header: SectionHeader {
                    text: qsTr("Favorites")
                }

                delegate: StationDelegate {
                    menu: stationContextMenu
                    onStationSelected:  {
                        pageStack.pop();
                    }
                }

                ViewPlaceholder {
                    enabled: favoritesList.model.count === 0
                    text: qsTr("Click and hold in the search results to add or remove a station as a favorite")
                }
            }
        }
    }

    onStatusChanged: {
        switch (status) {
            case PageStatus.Activating:
                gpsButton.visible = fahrplanBackend.parser.supportsGps();
                break;
        }
    }

    Component {
        id: stationContextMenu
        ContextMenu {
            id: contextMenu

            property variant model
            property bool favorite
            property int index

            MenuItem {
                text: favorite ? qsTr("Remove from favorites") : qsTr("Add to favorites")
                onClicked: {
                    if (favorite) {
                        model.removeFromFavorites(index);
                    } else {
                        model.addToFavorites(index);
                    }
                }
            }
        }
    }

    PositionSource {
        id: positionSource
        active: false

        onPositionChanged: {

            //Only do something if active
            if (positionSource.active === false) {
                return;
            }

            if (positionSource.position.latitudeValid && positionSource.position.longitudeValid) {
                console.log(qsTr("Searching for stations..."));
                fahrplanBackend.findStationsByCoordinates(positionSource.position.coordinate.longitude, positionSource.position.coordinate.latitude);
            } else {
                console.log(qsTr("Waiting for GPS lock..."));
                positionSource.update();
            }
        }
    }
}
