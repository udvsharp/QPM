import QtQuick 2.12

import "../controls" as CControls
import "../../styles" as CStyles

import com.udvsharp.ProjectsListModel 1.0

Rectangle {
    id: projectDelegateContainer
    width: ListView.view.width
    height: CStyles.Dimen.listItemHeightDefault

    color: {
        ListView.isCurrentItem ? CStyles.Color.accentDark : "transparent"
    }

    Row {
        anchors.fill: parent
        spacing: CStyles.Dimen.spaceM
        padding: CStyles.Dimen.spaceS

        CControls.RoundedImage {
            id: projectImage
            source: model.imageSrc

            width: height
            height: projectDelegateContainer.height - 2 * CStyles.Dimen.spaceXS
            anchors {
                verticalCenter: parent.verticalCenter
            }
        }

        Text {
            id: projectTitle
            text: model.title
            wrapMode: Text.Wrap

            color: {
                projectDelegateContainer.ListView.isCurrentItem ? CStyles.Color.white : CStyles.Color.black
            }
            font {
                bold: true
                pixelSize: CStyles.Dimen.fontS
            }

            anchors {
                verticalCenter: parent.verticalCenter
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
            projectsListView.currentIndex = index
            ProjectsListModel.select(index)
        }
    }

    states: [
        State {
            name: "Full Width"
            when: projectDelegateContainer.width > 240
            PropertyChanges {
                target: projectTitle
                visible: true
            }
        },
        State {
            name: "Minimal Width"
            when: projectDelegateContainer.width <= 240
            PropertyChanges {
                target: projectTitle
                visible: false
                width: 0
            }
        }
    ]
}

