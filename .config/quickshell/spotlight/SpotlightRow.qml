import QtQuick

// One result row: selection fill, icon, label. Selection follows the keyboard
// index and is also pulled along by hover, the way Spotlight behaves.
Item {
    id: row

    property var item: null
    property bool selected: false
    property string iconSource: ""
    property color nord1: "#3B4252"
    property color nord6: "#ECEFF4"
    property string fontPrimary: "Outfit"

    signal picked()
    signal hovered()

    Rectangle {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        radius: 6
        color: row.selected ? row.nord1 : "transparent"

        Behavior on color {
            ColorAnimation { duration: 80 }
        }
    }

    Image {
        id: icon
        x: 16
        width: 32
        height: 32
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        asynchronous: true
        smooth: true
        source: row.iconSource
    }

    Text {
        anchors.left: icon.right
        anchors.leftMargin: 12
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.verticalCenter: parent.verticalCenter
        text: row.item ? row.item.name : ""
        color: row.nord6
        elide: Text.ElideRight
        font.family: row.fontPrimary
        font.pixelSize: 15
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: row.picked()
        onEntered: row.hovered()
    }
}