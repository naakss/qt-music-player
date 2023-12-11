/***************************************************************************/
/*! \file       Separator.qml
 * \brief       the separation line (can be either horizontal or vertical)
 *
 * \copyright   Copyright (c) 2023 Sagar Gurudas Nayak
 * \copyright   MIT License
 *
 * \remark      Email: sagargnayak26@gmail.com
 ***************************************************************************/

import QtQuick 2.15
import QtQuick.Controls 2.15

import Themes 1.0

Rectangle {
    id: control

    property int orientation: Qt.Horizontal

    height: orientation == Qt.Vertical ? parent.height : DefaultTheme.separatorThickness
    width: orientation == Qt.Vertical ? DefaultTheme.separatorThickness : parent.width
    color: DefaultTheme.separatorColor
}
