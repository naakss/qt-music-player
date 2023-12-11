/***************************************************************************/
/*! \file       ScrollControl.qml
 * \brief       the custom scroll bar used in the screens
 *
 * \copyright   Copyright (c) 2023 Sagar Gurudas Nayak
 * \copyright   MIT License
 *
 * \remark      Email: sagargnayak26@gmail.com
 ***************************************************************************/

import QtQuick 2.15
import QtQuick.Controls 2.15

import Themes 1.0

ScrollBar {
    id: control
    active: false
    orientation: Qt.Vertical
    width: orientation == Qt.Vertical ? DefaultTheme.scrollBarThickness : parent.width
    height: orientation == Qt.Vertical ? parent.width : DefaultTheme.scrollBarThickness

    background: Rectangle {
        anchors.fill: parent
        color: DefaultTheme.primaryColor
        radius: DefaultTheme.radius
        opacity: 0.5
    }

    contentItem: Rectangle {
        radius: DefaultTheme.radius
        color: DefaultTheme.backgroundColor
    }
}
