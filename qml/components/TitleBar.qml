import QtQuick 1.1

Item {
    id: titleBar

    property alias titleText: title.text
    height: 60

    BorderImage {
        source: "image://theme/meegotouch-container-header-background"
        width: parent.width
        height: parent.height + 14
        y: -7
    }
    Text {
        id: title
        text: ""
        font.bold: true
        font.pixelSize: 32
        style: Text.Raised
        color: "White"
        styleColor: "Black"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
    }
}
