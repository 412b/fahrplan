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

import QtQuick 2.3
import Ubuntu.Components 1.1
import Fahrplan 1.0
import "../about.js" as About

Page {
    id: aboutPage

    title: qsTr("About")
    flickable: null

    head.sections.model: [qsTr("About"), qsTr("Credits"), qsTr("License")]

    VisualItemModel {
        id: tabs

        Item {
            width: tabView.width
            height: tabView.height

            Column {
                spacing: units.gu(4)
                anchors.centerIn: parent
                width: parent.width > units.gu(50) ? units.gu(50) : parent.width

                UbuntuShape {
                    id: logo2

                    width: parent.width / 2
                    height: width
                    radius: "medium"
                    anchors.horizontalCenter: parent.horizontalCenter

                    image: Image {
                        source: "qrc:/fahrplan2.svg"
                    }
                }

                Column {
                    width: parent.width

                    Label {
                        width: parent.width
                        fontSize: "x-large"
                        font.weight: Font.DemiBold
                        horizontalAlignment: Text.AlignHCenter
                        text: "Fahrplan"
                    }

                    Label {
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        text: qsTr("Version %1").arg(fahrplanBackend.version)
                    }
                }

                Column {
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: units.gu(2)
                    }

                    Label {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        text: "(C) 2014 smurfy (maemo@smurfy.de)"
                    }

                    Label {
                        fontSize: "small"
                        width: parent.width
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        text: i18n.tr("Released under the terms of the GNU GPL v2 or higher")
                    }
                }

                Label {
                    width: parent.width
                    wrapMode: Text.WordWrap
                    fontSize: "small"
                    horizontalAlignment: Text.AlignHCenter
                    text: i18n.tr("Source code available on ") + "<a href=\"https://github.com/smurfy/fahrplan\">github</a>"
                    onLinkActivated: Qt.openUrlExternally(link)
                }
            }
        }

        Item {
            width: tabView.width
            height: tabView.height

            Flickable {
                clip: true
                anchors.fill: parent
                anchors.margins: units.gu(2)
                flickableDirection: Flickable.VerticalFlick

                contentWidth: width
                contentHeight: creditText.height + units.gu(2)

                Label{
                    id: creditText

                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                    }

                    width: parent.width
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    onLinkActivated : Qt.openUrlExternally(link);
                    text: About.aboutText.split("<p><b>License</b></p>")[0]
                }
            }
        }

        Item {
            width: tabView.width
            height: tabView.height

            Flickable {
                clip: true
                anchors.fill: parent
                anchors.margins: units.gu(2)
                flickableDirection: Flickable.VerticalFlick

                contentWidth: width
                contentHeight: licenseText.height + units.gu(2)

                Label{
                    id: licenseText

                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                    }

                    wrapMode: Text.WordWrap
                    width: parent.width
                    textFormat: Text.RichText
                    onLinkActivated : Qt.openUrlExternally(link)
                    text: About.aboutText.split("<p><b>License</b></p>")[1]
                }
            }
        }
    }

    ListView {
        id: tabView
        model: tabs
        interactive: false
        anchors.fill: parent
        orientation: Qt.Horizontal
        snapMode: ListView.SnapOneItem
        currentIndex: aboutPage.head.sections.selectedIndex
        highlightMoveDuration: UbuntuAnimation.SlowDuration
    }
}
