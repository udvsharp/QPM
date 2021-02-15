import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "../components" as CControls
import "../styles" as CStyles

import com.udvsharp 1.0

SplitView {
    id: splitView

    Rectangle {
        color: "red"
        SplitView.minimumWidth: 0.1 * parent.width
        SplitView.preferredWidth: 0.25 * parent.width
    }

    Rectangle {
        color: "blue"
    }
}
