import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

ShellRoot {
    PanelWindow {
        implicitHeight: 35
        color: "#202A3D"

        anchors {
            top: true
            left: true
            right: true
        }

        RowLayout {
          anchors.fill: parent
          anchors.leftMargin: 14
          anchors.rightMargin: 14
          spacing: 8

          Workspaces {} 

          Item { Layout.fillWidth: true }

          Volume {}
          Battery {}
          Clock {}
        }

        SystemClock {
          id: clock
          precision:SystemClock.Minutes
        }
    }
}
