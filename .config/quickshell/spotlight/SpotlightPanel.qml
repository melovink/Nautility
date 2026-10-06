import QtQuick
import QtQuick.Effects
import Quickshell

// The floating Spotlight panel. Purely presentational: shell.qml owns the index,
// the selection and every side effect, and drives this through plain properties.
Item {
    id: panel

    property bool shown: false
    property int panelWidth: 680
    property int panelHeight: 88
    property int shadowPad: 46
    property int rowHeight: 40
    property int fieldTopMargin: 22
    property int fieldHeight: 40
    property int dividerTop: 66
    property int listTop: 76
    property int listBottomMargin: 12
    property int hPad: 16
    property int fieldIconGap: 34

    property color nord0: "#2E3440"
    property color nord1: "#3B4252"
    property color nord2: "#434C5E"
    property color nord6: "#ECEFF4"
    property string fontPrimary: "Outfit"

    property var results: []
    property int selectedIndex: 0
    property int iconRevision: 0

    signal queryEdited(string text)
    signal moveSelection(int delta)
    signal selectIndex(int index)
    signal activate()
    signal dismiss()

    width: panelWidth + shadowPad * 2
    height: panelHeight + shadowPad * 2

    // Reads iconRevision so every row's Image re-resolves its source when an
    // AppImage extraction lands mid-session.
    function iconSource(item): string {
        panel.iconRevision;
        if (item.kind === "appimage" && item.iconFile) return "file://" + item.iconFile;
        var themed = item.icon ? Quickshell.iconPath(item.icon, true) : "";
        if (themed !== "") return themed;
        return Quickshell.iconPath("application-x-executable", true);
    }

    // Focus follows the launcher's open state, not this item's own `visible`:
    // `visible` is already true on the focused monitor when the panel is created,
    // so it never changes and would never trigger a reset.
    onShownChanged: {
        if (!shown) return;
        focusTimer.restart();
    }
    onVisibleChanged: {
        if (visible && shown) focusTimer.restart();
    }

    Timer {
        id: focusTimer
        // Deferred so the layer surface is exposed and can actually take focus.
        interval: 80
        onTriggered: {
            field.text = "";
            field.forceActiveFocus();
        }
    }

    onSelectedIndexChanged: revealSelection()

    function revealSelection(): void {
        if (list.count === 0) return;
        if (panel.selectedIndex < list.firstVisibleIndex) list.positionViewAtBeginning();
        else if (panel.selectedIndex > list.lastVisibleIndex) list.positionViewAtIndex(panel.selectedIndex);
    }

    // Drop shadow. This is a layer of its own that contains nothing but a caster
    // shape, because MultiEffect given a source Item re-renders that item stretched
    // across the effect's whole rect, and a soft shadow needs blurEnabled, which
    // would also blur the text. Isolating the caster gives a soft shadow while the
    // panel content stays sharp and is drawn once, on top.
    //
    // The caster is inset by shadowPad, which is wider than the blur radius, so the
    // shadow lands wholly inside the layer bounds and is never clipped.
    Item {
        id: shadowHost
        anchors.fill: parent

        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            blurEnabled: true
            blur: 0.22
            blurMax: 64
            shadowOpacity: 0.5
            shadowHorizontalOffset: 0
            shadowVerticalOffset: 2
            shadowColor: "#000000"
        }

        Rectangle {
            anchors.fill: parent
            anchors.margins: panel.shadowPad
            radius: 14
            color: "#000000"
        }
    }

    Rectangle {
        id: body
        x: panel.shadowPad
        y: panel.shadowPad
        width: panel.panelWidth
        height: panel.panelHeight
        radius: 14
        color: panel.nord0
        border.color: panel.nord2
        border.width: 1
        clip: true

        Behavior on height {
            NumberAnimation { duration: 130; easing.type: Easing.OutCubic }
        }

        // Absorbs clicks on the panel's own padding so they do not fall through to
        // the backdrop. Declared first, so the results list still wins above it.
        MouseArea {
            anchors.fill: parent
            hoverEnabled: false
            onClicked: {}
        }

        // Magnifier. Built from plain primitives rather than QtQuick.Shapes because
        // PathEllipse is not exported by this Qt build.
        Item {
            id: magnifier
            width: 21
            height: 21
            x: panel.hPad
            y: panel.fieldTopMargin + Math.round((panel.fieldHeight - height) / 2)
            opacity: field.text.length === 0 ? 0.4 : 0.75

            Behavior on opacity {
                NumberAnimation { duration: 120 }
            }

            Rectangle {
                width: 13
                height: 13
                radius: 6.5
                color: "transparent"
                border.color: panel.nord6
                border.width: 1.7
            }

            Rectangle {
                width: 2.4
                height: 8
                radius: 1.2
                color: panel.nord6
                rotation: 45
                x: 14.3
                y: 11.5
            }
        }

        TextInput {
            id: field
            x: panel.hPad + panel.fieldIconGap
            y: panel.fieldTopMargin
            width: parent.width - panel.hPad * 2 - panel.fieldIconGap
            height: panel.fieldHeight
            verticalAlignment: TextInput.AlignVCenter
            color: panel.nord6
            selectionColor: panel.nord1
            selectedTextColor: panel.nord6
            font.family: panel.fontPrimary
            font.pixelSize: 21
            clip: true

            onTextChanged: panel.queryEdited(text)

            // One handler for every binding so accept order is explicit and modifiers
            // fall through untouched.
            Keys.onPressed: event => {
                if (event.key === Qt.Key_Escape) {
                    panel.dismiss();
                    event.accepted = true;
                } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    panel.activate();
                    event.accepted = true;
                } else if (event.key === Qt.Key_Up) {
                    panel.moveSelection(-1);
                    event.accepted = true;
                } else if (event.key === Qt.Key_Down) {
                    panel.moveSelection(1);
                    event.accepted = true;
                } else if (panel.results.length > 0 && event.key === Qt.Key_Home) {
                    panel.selectIndex(0);
                    event.accepted = true;
                } else if (panel.results.length > 0 && event.key === Qt.Key_End) {
                    panel.selectIndex(panel.results.length - 1);
                    event.accepted = true;
                }
            }
        }

        // TextInput has no placeholderText in Qt Quick, so it is drawn alongside.
        Text {
            x: field.x
            anchors.verticalCenter: field.verticalCenter
            visible: field.text.length === 0
            text: "Search applications…"
            color: Qt.alpha(panel.nord6, 0.4)
            font.family: panel.fontPrimary
            font.pixelSize: 21
        }

        Rectangle {
            visible: panel.results.length > 0
            x: panel.hPad
            y: panel.dividerTop
            width: parent.width - panel.hPad * 2
            height: 1
            color: panel.nord2
            opacity: 0.75
        }

        ListView {
            id: list
            x: 0
            y: panel.listTop
            width: parent.width
            // Track the animated body height so the list grows with the panel instead
            // of clipping against a height that has not caught up yet.
            height: Math.max(0, body.height - panel.listTop - panel.listBottomMargin)
            model: panel.results
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            flickDeceleration: 3000
            maximumFlickVelocity: 6000

            delegate: SpotlightRow {
                width: list.width
                height: panel.rowHeight
                item: modelData
                selected: index === panel.selectedIndex
                iconSource: panel.iconSource(modelData)
                nord1: panel.nord1
                nord6: panel.nord6
                fontPrimary: panel.fontPrimary
                onPicked: panel.activate()
                onHovered: panel.selectIndex(index)
            }
        }
    }
}