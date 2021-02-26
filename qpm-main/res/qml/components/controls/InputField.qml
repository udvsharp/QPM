import QtQuick
import QtQuick.Controls

import "../styles" as CStyles

TextField {
    id: input
    leftPadding: CStyles.Dimen.spaceS

    property bool password: false

    height: CStyles.Dimen.fieldHeightDefault

    background: Rectangle {
        color: CStyles.Color.accentLight

        width: this.width
        height: this.height
        radius: CStyles.Dimen.radiusM
    }
    focus: true

    verticalAlignment: TextInput.AlignVCenter
    font {
        pixelSize: height / 3
        italic: true
    }
    color: CStyles.Color.accentDark
    echoMode: this.password ? TextInput.Password : TextInput.Normal
}
