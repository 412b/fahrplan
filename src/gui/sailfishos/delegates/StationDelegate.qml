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

ListItem {
    id: root
    property ListView listView: ListView.view
    width: listView.width
    signal stationSelected()
    contentHeight: Theme.itemSizeSmall
    showMenuOnPressAndHold: false

    Label {
        id: lbl_name
        anchors {
            left: parent.left
            leftMargin: Theme.paddingLarge
            rightMargin: model.miscInfo ? Theme.paddingMedium : 0
            right: lbl_miscinfo.left
            verticalCenter: parent.verticalCenter
        }
        text: model.name
    }

    Label {
        id: lbl_miscinfo
        anchors {
            right: parent.right
            rightMargin: Theme.paddingLarge
            verticalCenter: parent.verticalCenter
        }
        color: Theme.secondaryColor
        text: model.miscInfo
    }

    onClicked: {
        listView.model.selectStation(stationSelect.type, model.index);
        root.stationSelected();
    }

    onPressAndHold: showMenu({model: listView.model, favorite: model.isFavorite, index: model.index})

}
