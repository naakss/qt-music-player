/***************************************************************************/
/*! \file       CheckBoxControl.qml
 * \brief       the custom check box used in the screens
 *
 * \copyright   Copyright (c) 2023 Sagar Gurudas Nayak
 * \copyright   MIT License
 *
 * \remark      Email: sagargnayak26@gmail.com
 ***************************************************************************/

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import Themes 1.0

CheckBox {
    id: control

    contentItem: Text {
        text: control.text
        color: DefaultTheme.textColor
        font.pixelSize: DefaultTheme.fontSize
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
