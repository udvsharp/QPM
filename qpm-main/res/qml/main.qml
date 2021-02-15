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
    title: qsTr("QPM")
    color: CStyles.Color.main
    minimumWidth: 640
    minimumHeight: 480

    StackView {
        id: stack
        initialItem: loginScreen
        anchors.fill: parent

        Component {
            id: loginScreen
            Rectangle {
                color: "transparent"
                CControls.LoginInputForm {
                    onChangeToMemberArea: {
                        stack.replace(main)
                        console.log("Proceeding to member area...")
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
