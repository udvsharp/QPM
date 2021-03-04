import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.14

import "components" as CControls
import "styles" as CStyles

import com.udvsharp.TicketsListModel 1.0

ApplicationWindow {
    id: application
    visible: true
    width: 640
    height: 480
    title: qsTr("QPM")
    color: CStyles.Color.white
    visibility: ApplicationWindow.Maximized
    minimumWidth: 640
    minimumHeight: 480

    Rectangle {
        id: header
        height: 60
        visible: stack.currentItem.hasHeader
        color: CStyles.Color.accentDarkest

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        Text {
            text: stack.currentItem.headerText
            font {
                bold: true
                pixelSize: CStyles.Dimen.fontM
            }
            color: CStyles.Color.white

            anchors.centerIn: parent
        }
    }

    StackView {
        id: stack
        initialItem: loginScreen
        anchors {
           top: header.visible ? header.bottom : parent.top
           bottom: parent.bottom
           left: parent.left
           right: parent.right
        }

        Component {
            id: loginScreen

            Rectangle {
                property bool hasHeader: false
                property string headerText: ""

                color: CStyles.Color.main
                CControls.LoginInputForm {
                    onChangeToMemberArea: {
                        console.log("Proceeding to member area...")
                        stack.replace(memberArea)
                    }
                }
            }
        }

        Component {
            id: memberArea
            CControls.MemberArea {
                property bool hasHeader: true
                property string headerText: "Projects"

                onTicketSelected: {
                    console.log(TicketsListModel.get(index).title)
                }
            }
        }

        Component {
            id: ticketsView
            CControls.MemberArea {
                property bool hasHeader: true
                property string headerText: "Projects"
            }
        }
    }
}
