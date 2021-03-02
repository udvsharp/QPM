import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.14

import "../components/controls" as CControls
import "../styles" as CStyles

import com.udvsharp.ProjectsListModel 1.0
import com.udvsharp.AuthController 1.0
import com.udvsharp.TicketsListModel 1.0

SplitView {
    id: splitView

    Component {
        id: projectDelegate

        Rectangle {
            id: projectDelegateContainer
            width: ListView.view.width
            height: 70

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
    }

    Component {
            id: ticketDelegate

            Rectangle {
                width: ListView.view.width
                height: 60
                radius: CStyles.Dimen.radiusM

//                property color textColor: ListView.isCurrentItem ? CStyles.Color.white : CStyles.Color.black
//                color: ListView.isCurrentItem ? CStyles.Color.accentDark : "transparent"
                Column {
                    Text {
                        text: '<b>Title:</b> ' + model.title
//                        color: parent.textColor
                    }
                    Text {
                        text: '<b>Description:</b> ' + model.description
//                        color: parent.textColor
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
                    }
                }
            }
    }

    Component.onCompleted: {
        ProjectsListModel.update()
    }

    ListView {
        id: projectsListView

        SplitView.minimumWidth: 70
        SplitView.preferredWidth: 0.25 * splitView.width
        SplitView.maximumWidth: 0.5 * splitView.width

        spacing: 0

        model: ProjectsListModel
        delegate: projectDelegate
        focus: true
    }

    ListView {
        id: ticketsListView

        SplitView.minimumWidth: 0.1 * splitView.width
        SplitView.preferredWidth: 0.75 * splitView.width
        SplitView.maximumWidth: 0.5 * splitView.width

        spacing: CStyles.Dimen.spaceS

        delegate: ticketDelegate
        model: TicketsListModel
        focus: true
    }
}


