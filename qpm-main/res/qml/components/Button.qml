import QtQuick 2.0
import QtQuick.Controls 2.0 as Controls

import "../styles" as CStyles

Controls.Button {
    id: button

    required property color colorDefault
    required property color colorPressed
    required property color colorHovered
    required property color textColorDefault
    required property color textColorPressed
    property color textColorHovered: textColorDefault

    property real radius: CStyles.Dimen.radiusM

    height: CStyles.Dimen.fieldHeightDefault

    hoverEnabled: false

    contentItem: Text {
        id: textContent
        text: button.text
        font {
            bold: true
            pixelSize: button.height / 3
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: button.textColorDefault
    }

    background: Rectangle {
        id: backgroundItem
        radius: button.radius
        color: button.colorDefault
    }

    PropertyAnimation {
        id: enteredColorAnimation
        target: backgroundItem
        properties: "color"
        to: button.colorHovered
        duration: 100
    }

    PropertyAnimation {
        id: exitedColorAnimation
        target: backgroundItem
        properties: "color"
        to: button.colorDefault
        duration: 100
    }

    PropertyAnimation {
        id: clickedColorAnimation
        target: backgroundItem
        properties: "color"
        to: button.colorPressed
        duration: 100
    }

    PropertyAnimation {
        id: clickedTextAnimation
        target: textContent
        properties: "color"
        to: button.textColorPressed
        duration: 100
    }

    // TODO: fix this animation on release
    PropertyAnimation {
        id: releasedTextAnimation
        target: textContent
        properties: "color"
        to: button.textColorDefault
        duration: 100
    }

    MouseArea {
        id: mouseArea; anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            enteredColorAnimation.start()
            textContent.color = button.textColorHovered
        }

        onExited: {
            exitedColorAnimation.start()
            textContent.color = button.textColorDefault
        }

        onClicked: {
            button.onClicked()
            clickedColorAnimation.start()
            clickedTextAnimation.start()
        }
    }
}
