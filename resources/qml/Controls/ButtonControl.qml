/***************************************************************************/
/*! \file       ButtonControl.qml
 * \brief       the custom button used in the screens
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

Button {
    id: control
    height: DefaultTheme.buttonHeight

    property string buttonIcon: ""
    property string buttonText: ""

    background: Rectangle {
        id: backRect
        color: DefaultTheme.primaryColor
        radius: control.height * 0.5
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: DefaultTheme.margins

        TextControl {
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSizeS
            text: control.buttonIcon
            visible: text.length > 0
            onClicked: {
                control.clicked()
            }
        }

        Text {
            color: DefaultTheme.textColor
            font.pixelSize: DefaultTheme.fontSize
            text: control.buttonText
        }
    }
}
