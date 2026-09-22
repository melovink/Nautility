import QtQuick
import Quickshell

Text {
    text: Qt.formatDateTime(clock.date, "hh:mm")
    color: "#E5E9F0"

    font {
        family: "SF Mono"
        letterSpacing: 0
        pixelSize: 14
        weight: 700
    }

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

}


