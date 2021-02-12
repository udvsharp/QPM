import QtQuick 2.0
import QtQuick.Controls 2.0

import "../styles" as CStyles

Rectangle {
    id: container
    // Constants
    readonly property real fieldHeight: CStyles.Dimen.fieldHeightDefault

    // Custom properties
    property alias hint: input.placeholderText
    property bool password: false

    color: CStyles.Color.accentLight

    width: parent.width
    height: this.fieldHeight
    radius: CStyles.Dimen.radiusM

    TextField {
        id: input
        leftPadding: CStyles.Dimen.spaceS
        background: Rectangle {
            color: "transparent"
        }
        anchors.fill: parent

        verticalAlignment: TextInput.AlignVCenter
        font {
            pixelSize: parent.height / 2.5
            italic: true
        }
        color: CStyles.Color.accentDark
        echoMode: container.password ? TextInput.Password : TextInput.Normal
    }

}
