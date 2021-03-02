import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.14

import "../components/controls" as CControls
import "../styles" as CStyles

import com.udvsharp.AuthController 1.0

ColumnLayout {

    signal changeToMemberArea()

    id: inputForm
    visible: true
    width: CStyles.Dimen.fieldWidthDefault
    anchors.centerIn: parent
    spacing: CStyles.Dimen.spaceM

    Connections {
        target: AuthController

        function onAuthCompleted(success, msg) {
            if (success) {
                inputForm.changeToMemberArea()
            } else {
                error.text = msg
                error.visible = true
            }
        }
    }

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
        placeholderText: "Email"

        Layout.alignment: Qt.AlignCenter
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: CStyles.Dimen.fieldHeightDefault

        KeyNavigation.up: passwordInput
        Keys.onEnterPressed: loginButton.onClicked()
        Keys.onReturnPressed: loginButton.onClicked()
    }

    CControls.InputField {
        id: passwordInput
        placeholderText: "Password"

        Layout.alignment: Qt.AlignCenter
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: CStyles.Dimen.fieldHeightDefault

        password: true

        KeyNavigation.up: emailInput
        Keys.onEnterPressed: loginButton.onClicked()
        Keys.onReturnPressed: loginButton.onClicked()
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
        Layout.preferredHeight: CStyles.Dimen.fieldHeightDefault

        onClicked: {
            let login = emailInput.text
            let password = passwordInput.text
            if (login.length <= 2 || password.length <= 2) {
                error.text = "At least 3 symbols are expected..."
                error.visible = true
                return
            }

            error.visible = false
            AuthController.tryAuthUser(login, password)
        }
    }

    Text {
        id: forgotPasswordButton
        text: "Forgot password?"
        color: CStyles.Color.accentDarkest

        MouseArea {
            anchors.fill: parent
            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
            z: 1
            hoverEnabled: true
        }

        Layout.alignment: Qt.AlignCenter
        font {
            pixelSize: CStyles.Dimen.fontS
            bold: true
        }
    }

    Text {
        id: error
        visible: false

        text: "You aren't authorized!"
        color: CStyles.Color.red
        font {
            pixelSize: CStyles.Dimen.fontXS
            bold: false
        }

        Layout.alignment: Qt.AlignCenter
    }
}
