import QtQuick 2.15
import QtQuick.Controls 2.15

import Themes 1.0

Text {
    id: control
    color: DefaultTheme.textColor
    font.pixelSize: DefaultTheme.fontSize

    signal clicked()

    MouseArea {
        anchors.fill: parent
        anchors.margins: -DefaultTheme.spacing
        onClicked: {
            control.clicked()
        }
    }
}
