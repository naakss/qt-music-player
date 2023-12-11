/***************************************************************************/
/*! \file       Toast.qml
 * \brief       shows messages in the screen with a time-out
 *
 * \copyright   Copyright (c) 2023 Sagar Gurudas Nayak
 * \copyright   MIT License
 *
 * \remark      Email: sagargnayak26@gmail.com
 ***************************************************************************/

import QtQuick 2.15

import Themes 1.0

Rectangle {
    id: control
    anchors.bottom: parent.bottom
    anchors.bottomMargin: DefaultTheme.rowHeight
    anchors.horizontalCenter: parent.horizontalCenter
    color: "black"
    height: DefaultTheme.buttonHeight * 1.3
    width: message.width + DefaultTheme.margins * 1.6
    radius: height * 0.5
    opacity: 0.0
    onOpacityChanged: {
        if (opacity == 1.0) {
            hideTimer.start();
        }
    }

    property alias text: message.text

    Text {
        id: message
        anchors.centerIn: parent
        font.pixelSize: DefaultTheme.fontSize
        color: DefaultTheme.textColor
    }

    Behavior on opacity { NumberAnimation { duration: 700 } }

    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: {
            control.opacity = 0.0;
        }
    }

    function show(msg) {
        control.text = msg;
        control.opacity = 1.0;
    }
}
