import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../components" as CControls
import "../styles" as CStyles

import com.udvsharp.ProjectsListModel 1.0
import com.udvsharp.AuthController 1.0
//import com.udvsharp.TicketsModel 1.0

SplitView {
    id: splitView

    ListModel {
        id: projectsModel
        ListElement {
            pid: 0
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            pid: 1
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            pid: 2
            name: "Sam Wise"
            number: "555 0473"
        }
    }

    ListModel {
        id: ticketsModel
        ListElement {
            pid: 0
            tid: 0
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            pid: 0
            tid: 1
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            pid: 1
            tid: 2
            name: "Sam Wise"
            number: "555 0473"
        }
    }

    ProjectsListModel {
        id: projectsListModel
    }

    Component.onCompleted: {
        projectsListModel.update()
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
                Row {
                    Image {
                        id: projectImage
                        width: height
                        height: projectDelegateContainer.height;
                        source: "somefile" // TODO: connect to model
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

                        let project = projectsModel.get(index)
                        let filteredTicketsModel = Qt.createQmlObject('import QtQuick;
                            ListModel {}', parent);
                        for(let i = 0; i < ticketsModel.count; ++i) {
                            let ticket = ticketsModel.get(i);
                            if (ticket.pid === project.pid) {
                                filteredTicketsModel.append(ticket);
                            }
                        }

                        ticketsListView.model = filteredTicketsModel
                    }
                }
            }
        }

        model: projectsListModel
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
                    Text { text: '<b>Name:</b> ' + name }
                    Text { text: '<b>Number:</b> ' + number }
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
        focus: true
    }
}
