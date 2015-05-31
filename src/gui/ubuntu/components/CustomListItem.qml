import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.2
import Ubuntu.Components.ListItems 1.0 as ListItem

ListItem.Base {
    id: customListItem

    property alias text: _title.text
    property alias value: _value.text

    RowLayout {
        spacing: units.gu(1)
        anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter }

        Label {
            id: _title
            Layout.fillWidth: true
            font.bold: true
        }

        Label {
            id: _value
            elide: Text.ElideMiddle
            horizontalAlignment: Text.AlignRight
            Layout.maximumWidth: parent.width - _title.implicitWidth - _progression.width
        }

        Icon {
            id: _progression
            name: "go-next"
            width: units.gu(2)
            height: width
        }
    }
}
