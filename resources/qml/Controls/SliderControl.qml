import QtQuick 2.15
import QtQuick.Controls 2.15

import Themes 1.0

Slider {
    id: control
    padding: 0

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: control.availableWidth
        height: implicitHeight
        radius: 2
        color: DefaultTheme.textColor

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: DefaultTheme.primaryColor
            radius: 2
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 20
        implicitHeight: 20
        radius: 10
        color: DefaultTheme.textColor
    }
}
