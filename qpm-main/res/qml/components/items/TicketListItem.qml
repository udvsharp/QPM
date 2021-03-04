import QtQuick 2.12
import QtGraphicalEffects 1.12

import "../controls" as CControls
import "../../styles" as CStyles

Rectangle {
    height: childrenRect.height
    color: "transparent"

    signal selected(int index)

    Rectangle {
        id: ticketDelegateContainer

        color: CStyles.Color.white
        height: childrenRect.height
        width: parent.width
        radius: CStyles.Dimen.radiusL

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
                text: model.description

                font {
                    bold: false
                    pixelSize: CStyles.Dimen.fontS
                }
            }



            Canvas {
                id: priorityCanvas

                width: 200
                height: 36
                onPaint: {
                    function rgba(r, g, b, a) {
                        return Qt.rgba(r / 255, g / 255, b / 255, a);
                    }

                    const priorityColors =
                         [
                             rgba(218, 223, 225, 1),
                             rgba(107, 235, 52, 1),
                             rgba(225, 235, 52, 1),
                             rgba(235, 192, 52, 1),
                             rgba(235, 64, 52, 1),
                         ];

                    var ctx = getContext("2d");
                    function circle(x, y, radius, style) {
                        ctx.beginPath();
                        ctx.fillStyle = style;
                        ctx.arc(x, y, radius, 0, Math.PI * 2);
                        ctx.fill();
                    }

                    function drawColumn(n, color) {
                        const radius = height / 4;
                        const spacingModifier = 0.9;
                        const finalRadius = radius * spacingModifier;

                        const xOffset = radius * (1 + n * 2);
                        circle(xOffset, radius, finalRadius, color);
                        circle(xOffset, radius * 3, finalRadius, color);
                    }

                    function drawPriority(priority) {
                        const activeColor = priorityColors[priority - 1];
                        const inactiveColor = rgba(230, 220, 220, 0.5);

                        let i = 0;
                        for (i = 0; i < priority && i < 5; ++i) {
                            drawColumn(i, activeColor);
                        }

                        for (; i < 5; ++i) {
                            drawColumn(i, inactiveColor);
                        }
                    }

                    drawPriority(model.priority);
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
                selected(index)
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
