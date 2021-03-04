import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.12

import "../styles" as CStyles
import "../components/items" as CItems

import com.udvsharp.TicketsListModel 1.0

Rectangle {
    id: panel
    signal selected(int index)

    color: CStyles.Color.bgColor

    ListView {
        id: ticketsListView
        orientation: ListView.Vertical

        anchors.fill: parent
        anchors.margins: CStyles.Dimen.spaceS

        spacing: CStyles.Dimen.spaceS

        model: TicketsListModel
        delegate: CItems.TicketListItem {
            width: ListView.view.width

            onSelected: {
                ticketsListView.currentIndex = index
                panel.selected(index)
            }
        }

        focus: true
    }
}
