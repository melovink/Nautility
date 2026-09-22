import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 7

    Repeater { 
        model : 5

        Rectangle {
            id: wsButton
            required property int index

            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

            implicitWidth: label.implicitWidth + 14
            implicitHeight: 22
            radius: 6

            color: isActive ? '#364256' : (ws ? "#202A3D" : "transparent")

            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            Text { 
                id: label
                anchors.centerIn: parent
                text: wsButton.index + 1
                color: wsButton.isActive ? "#88C0D0" : (wsButton.ws ? "#E5E9F0" : "#a6aab0")

                font {
                    family: "SF Mono"
                    pixelSize: 14
                    weight: 600
                }

            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (parent.index + 1) + "})")
            }
        }
    }
}