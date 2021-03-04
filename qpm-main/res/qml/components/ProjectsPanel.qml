import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.12

import "../styles" as CStyles
import "../components/controls" as CControls
import "../components/items" as CItems

import com.udvsharp.ProjectsListModel 1.0

Rectangle {

    ListView {
        id: projectsListView
        orientation: ListView.Vertical

        anchors.fill: parent
        anchors.margins: 0

        spacing: 0

        model: ProjectsListModel
        delegate: CItems.ProjectListItem {

        }

        focus: true
    }
}
