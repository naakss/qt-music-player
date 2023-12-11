/***************************************************************************/
/*! \file       SliderControl.qml
 * \brief       the custom slider that can optionally have a container
 *
 * \copyright   Copyright (c) 2023 Sagar Gurudas Nayak
 * \copyright   MIT License
 *
 * \remark      Email: sagargnayak26@gmail.com
 ***************************************************************************/

import QtQuick 2.15
import QtQuick.Controls 2.15

import Themes 1.0

Slider {
    id: control
    padding: 0

    property bool showContainer: false

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
            color: control.showContainer ? DefaultTheme.textColor : DefaultTheme.primaryColor
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

    Rectangle {
        anchors.centerIn: parent
        width: control.width + height * 0.7
        height: DefaultTheme.buttonHeight * 1.2
        radius: height * 0.5
        color: DefaultTheme.primaryColor
        z: parent.z - 1
        visible: control.showContainer
    }
}
