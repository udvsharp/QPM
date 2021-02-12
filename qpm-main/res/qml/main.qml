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
    minimumWidth: stack.childrenRect.width < 1920 ? stack.childrenRect.width + 2 * CStyles.Dimen.spaceM : stack.childrenRect.width < 1920
    minimumHeight: stack.childrenRect.height < 1080 ? stack.childrenRect.height + 6 * CStyles.Dimen.spaceM : stack.childrenRect.height

    StackView {
        id: stack
        initialItem: loginScreen
        anchors.fill: parent

        Component {
            id: loginScreen
            Rectangle {
                color: "transparent"
                CControls.LoginInputForm {

                }
            }
        }

        Component {
            id: main
            Rectangle {
                color: "white"
                CControls.MemberArea {

                }
            }
        }
    }
}
