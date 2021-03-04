import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.12

import "../components/controls" as CControls
import "../styles" as CStyles

import com.udvsharp.AuthController 1.0
import com.udvsharp.ProjectsListModel 1.0

SplitView {
    id: splitView

    handle: Rectangle {
        implicitWidth: 4
        implicitHeight: 4
        color: SplitHandle.pressed ? CStyles.Color.accentDarkest
            : (SplitHandle.hovered ? Qt.lighter(CStyles.Color.accentDark, 1.2) : CStyles.Color.accentDark)
    }

    signal ticketSelected(int index)

    Component.onCompleted: {
        ProjectsListModel.update()
    }

    ProjectsPanel {
        SplitView.minimumWidth: CStyles.Dimen.listItemHeightDefault + CStyles.Dimen.spaceM
        SplitView.preferredWidth: 0.25 * splitView.width
        SplitView.maximumWidth: 0.5 * splitView.width
    }

    TicketsPanel {
        onSelected: {
            ticketSelected(index)
        }
    }
}


