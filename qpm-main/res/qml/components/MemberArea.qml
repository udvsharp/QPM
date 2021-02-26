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

    Component {
        id: projectDelegate

        Rectangle {
            id: projectDelegateContainer
            width: ListView.view.width
            height: 50

            color: {
                ListView.isCurrentItem ? CStyles.Color.accentDark : "transparent"
            }

            Row {
                anchors.fill: parent

                spacing: CStyles.Dimen.spaceM
                Image {
                    id: projectImage
                    source: model.imageSrc

                    width: height
                    height: 50
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }

                    property bool rounded: true
                    property bool adapt: true

                    layer.enabled: rounded
                    layer.effect: ShaderEffect {
                        property real adjustX: projectImage.adapt ? Math.max(width / height, 1) : 1
                        property real adjustY: projectImage.adapt ? Math.max(1 / (width / height), 1) : 1

                        fragmentShader: "#ifdef GL_ES
                            precision lowp float;
                        #endif // GL_ES
                        varying highp vec2 qt_TexCoord0;
                        uniform highp float qt_Opacity;
                        uniform lowp sampler2D source;
                        uniform lowp float adjustX;
                        uniform lowp float adjustY;

                        void main(void) {
                            lowp float x, y;
                            x = (qt_TexCoord0.x - 0.5) * adjustX;
                            y = (qt_TexCoord0.y - 0.5) * adjustY;
                            float delta = adjustX != 1.0 ? fwidth(y) / 2.0 : fwidth(x) / 2.0;
                            gl_FragColor = texture2D(source, qt_TexCoord0).rgba
                                * step(x * x + y * y, 0.25)
                                * smoothstep((x * x + y * y) , 0.25 + delta, 0.25)
                                * qt_Opacity;
                        }"
                    }
                }

                Text {
                    id: projectTitle
                    text: model.title

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

        SplitView.minimumWidth: 0.1 * splitView.width
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
