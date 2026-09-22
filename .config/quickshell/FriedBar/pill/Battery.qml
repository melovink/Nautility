import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    spacing: 6

    property var battery: UPower.displayDevice
    property bool charging: battery.state === UPowerDeviceState.Charging
    readonly property int level: Math.round(battery.percentage * 100)

    readonly property string icon: {
        if (charging) return String.fromCodePoint(0xF0084)
        if (level >= 100) return String.fromCodePoint(0xF0079)
        if (level < 10) return String.fromCodePoint(0xF0083)

        return String.fromCodePoint(0xF007A + (Math.floor(level / 10) - 1))
    }

    Text {
        text: root.icon
        color: root.charging ? "#A3BE8C" 
                             : root.level <= 20 ? "#BF616A" 
                             : root.level <= 50 ? "#D08770" 
                             : "#A3BE8C"
        font {
            family: "Iosevka Nerd Font Propo"
            pixelSize: 15

        }
    }

    Text{
        text: root.level + "%"
        color: "#E5E9F0"

        font {
            family: "Sazanami"
            weight: 600
            pixelSize: 14
        }
    }
}