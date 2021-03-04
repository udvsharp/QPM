import QtQuick 2.12
import QtGraphicalEffects 1.12

import "../controls" as CControls
import "../../styles" as CStyles

Rectangle {
    height: childrenRect.height

    Rectangle {
        id: ticketDelegateContainer

        color: CStyles.Color.accentLight
        height: childrenRect.height
        width: parent.width
        radius: CStyles.Dimen.radiusM

//                property color textColor: ListView.isCurrentItem ? CStyles.Color.white : CStyles.Color.black
//                color: ListView.isCurrentItem ? CStyles.Color.accentDark : "transparent"
        Column {
            id: column
            height: childrenRect.height + 2 * CStyles.spaceS
            width: parent.width
            padding: CStyles.Dimen.spaceS
            spacing: CStyles.Dimen.spaceXS

            Text {
                text: model.title

                font {
                    bold: true
                    pixelSize: CStyles.Dimen.fontS
                }
            }
            Text {
                text: model.priority + ": " + model.description

                font {
                    bold: false
                    pixelSize: CStyles.Dimen.fontS
                }
            }
        }

        MouseArea {
            id: itemArea
            z: 1
            hoverEnabled: true
            anchors.fill: parent

            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: {
                ticketsListView.currentIndex = index
                // TODO: open tickets window
            }
        }
    }


    DropShadow {
        anchors.fill: ticketDelegateContainer
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: CStyles.Color.shadowColor
        source: ticketDelegateContainer
    }

}
