import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

import "components" as CControls
import "styles" as CStyles

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    color: CStyles.Color.main
    minimumWidth: inputForm.width + 2 * CStyles.Dimen.spaceM
    minimumHeight: inputForm.height + 6 * CStyles.Dimen.spaceM

    ColumnLayout {
        id: inputForm
        visible: true
        width: 320
        height: childrenRect.height
        anchors.centerIn: parent
        spacing: CStyles.Dimen.spaceM

        Rectangle {
            id: logo
            width: 60
            height: width
            color: "transparent"

            Layout.preferredHeight: height
            Layout.preferredWidth: width
            Layout.alignment: Qt.AlignCenter

            Text {
                anchors.centerIn: parent
                text: qsTr("Q")
                font {
                    family: "Helvetica"
                    pixelSize: parent.width
                    bold: true
                }
                color: CStyles.Color.accentDarkest
            }
        }

        CControls.InputField {
            id: emailInput
            hint: "Email"

            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: height
        }

        CControls.InputField {
            id: passwordInput
            hint: "Password"

            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: height

            password: true
        }

        CControls.Button {
            id: loginButton

            text: "Login"

            colorDefault: CStyles.Color.accentDark
            colorHovered: CStyles.Color.accentDarkest
            colorPressed: CStyles.Color.accentLight
            textColorDefault: CStyles.Color.white
            textColorPressed: CStyles.Color.accentDark

            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: height
        }

        Text {
            id: forgotPasswordButton
            text: "Forgot password?"
            color: CStyles.Color.accentDarkest

            Layout.alignment: Qt.AlignCenter
            font {
                pixelSize: CStyles.Dimen.fontXS
                bold: true
            }
        }
    }
}
