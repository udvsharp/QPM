import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../components" as CControls
import "../styles" as CStyles

import com.udvsharp.ProjectsListModel 1.0
import com.udvsharp.AuthController 1.0
import com.udvsharp.TicketsListModel 1.0

SplitView {
    id: splitView

    Component.onCompleted: {
        ProjectsListModel.update()
    }

    ListView {
        id: projectsListView

        SplitView.minimumWidth: 0.1 * splitView.width
        SplitView.preferredWidth: 0.25 * splitView.width
        SplitView.maximumWidth: 0.5 * splitView.width

        Component {
            id: projectDelegate

            Rectangle {
                id: projectDelegateContainer
                width: ListView.view.width
                height: 50

                color: ListView.isCurrentItem ? "lightblue" : "transparent"
                Rectangle {
                    Image {
                        id: projectImage
                        width: height
                        height: projectDelegateContainer.height;
                        source: model.imageSrc // TODO: connect to model
                    }

                    Text {
                        id: projectTitle
                        text: model.title

                        anchors {
                            leftMargin: CStyles.Dimen.spaceM
                            left: projectImage.right
                            verticalCenter: projectDelegateContainer.verticalCenter
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
            }
        }

        model: ProjectsListModel
        delegate: projectDelegate
        focus: true
    }

    ListView {
        id: ticketsListView

        SplitView.minimumWidth: 0.1 * splitView.width
        SplitView.preferredWidth: 0.25 * splitView.width
        SplitView.maximumWidth: 0.5 * splitView.width

        Component {
            id: ticketDelegate

            Rectangle {
                width: ListView.view.width
                height: 50

                color: ListView.isCurrentItem ? "lightblue" : "transparent"
                Column {
                    Text { text: '<b>Title:</b> ' + model.title }
                    Text { text: '<b>Description:</b> ' + model.description }
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

        delegate: ticketDelegate
        model: TicketsListModel
        focus: true
    }
}
