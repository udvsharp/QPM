import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

import "../components" as CControls
import "../styles" as CStyles

import com.udvsharp 1.0

ColumnLayout {

    // TODO: singleton
    AuthController {
        id: authController
    }

    id: inputForm
    visible: true
    width: CStyles.Dimen.fieldWidthDefault
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
        placeholderText: "Email"

        Layout.alignment: Qt.AlignCenter
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: CStyles.Dimen.fieldHeightDefault

        KeyNavigation.up: passwordInput
        Keys.onEnterPressed: loginButton.onClicked()
        Keys.onReturnPressed: loginButton.onClick()
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
            // TODO: login logic
            let result = authController.test(emailInput.text, passwordInput.text)

            if (result) {
                stack.replace(main)
            } else {
                error.visible = true
            }
        }
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
