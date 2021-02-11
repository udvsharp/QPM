import QtQuick 2.0
import QtQuick.Controls 2.0

ApplicationWindow {
    id: applicationWindow

    // TODO: move to another module
    Item {
        id: colors
        readonly property color accent: "#4b7eb7"
        readonly property color accentLight: "#8daed9"
        readonly property color accentDark: "#29619e"
        readonly property color accentDarkest: "#083055"
        readonly property color main: "#4b7eb7"
        readonly property color white: "#ffffff"
    }

    // TODO: move to another module
    Item {
        id: dimensions
        readonly property int spaceM: 25
        readonly property int fieldHeight: 40
    }

    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    color: colors.main
    minimumWidth: inputForm.width + 2 * dimensions.spaceM

    Rectangle {
        id: inputForm
        visible: true
        width: 320
        height: 120
        anchors.centerIn: parent
        color: colors.accentDark

        TextInput {
            id: textInput
            width: parent.width
            height: dimensions.fieldHeight
//            background: colors.accentLight

            text: qsTr("Text Input")

            font.pixelSize: height / 2.5
        }

    }

    Rectangle {
        id: logo
        anchors {
            bottom: inputForm.top
            horizontalCenter: inputForm.horizontalCenter

            bottomMargin: width / 2
        }
        width: 40
        height: width
        color: "transparent"

        Text {
            anchors.horizontalCenter: parent
            text: qsTr("Q")
            font {
                family: "Helvetica"
                pixelSize: parent.width
                bold: true
            }
            color: colors.accentDarkest
        }
    }
}
