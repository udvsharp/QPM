import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "components" as CControls
import "styles" as CStyles

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("QPM")
    color: CStyles.Color.white
    visibility: ApplicationWindow.Maximized
    minimumWidth: 640
    minimumHeight: 480

    StackView {
        id: stack
        initialItem: loginScreen
        anchors.fill: parent

        Component {
            id: loginScreen
            Rectangle {
                anchors.fill: parent
                color: CStyles.Color.main
                CControls.LoginInputForm {
                    onChangeToMemberArea: {
                        console.log("Proceeding to member area...")
                        stack.replace(main)
                    }
                }
            }
        }

        Component {
            id: main
            CControls.MemberArea {

            }
        }
    }
}
