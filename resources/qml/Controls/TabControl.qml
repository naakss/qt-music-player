import QtQuick 2.15
import QtQuick.Controls 2.15

import Themes 1.0

MouseArea {
    id: root
    height: DefaultTheme.rowHeight
    width: textItem.width

    property bool active: false
    property alias text: textItem.text

    Text {
        id: textItem
        color: root.active ? DefaultTheme.textColor : DefaultTheme.primaryColor
        opacity: root.active ? 1.0 : 0.8
        font.pixelSize: DefaultTheme.fontSize
        font.bold: true
        verticalAlignment: Text.AlignVCenter
    }

    Separator {
        anchors.bottom: parent.bottom
        visible: root.active
    }
}
