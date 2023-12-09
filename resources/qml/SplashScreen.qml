import QtQuick 2.15

import Themes 1.0

Rectangle {
    id: root
    anchors.fill: parent
    color: DefaultTheme.backgroundColor

    Rectangle {
        id: logo
        anchors.centerIn: parent
        width: DefaultTheme.logoSize
        height: width
        color: DefaultTheme.logoColor
        radius: DefaultTheme.radius
        opacity: 0.0

        NumberAnimation on anchors.verticalCenterOffset { to: -50; duration: 700 }
        NumberAnimation on opacity { to: 1.0; duration: 1000 }

        Text {
            anchors.centerIn: parent
            text: "M"
            color: DefaultTheme.textColor
            font.pixelSize: DefaultTheme.fontSizeL * 2
            font.bold: true
        }
    }

    Text{
        id: appName
        anchors.top: logo.bottom
        anchors.topMargin: DefaultTheme.spacing * 4
        anchors.horizontalCenter: logo.horizontalCenter
        color: DefaultTheme.textColor
        font.pixelSize: DefaultTheme.fontSizeL
        text: qsTr("Music Player")
        opacity: 0.0
    }

    SequentialAnimation {
        running: true

        PauseAnimation { duration: 1000 }
        NumberAnimation { target: appName; property: "opacity"; to: 1.0; duration: 1000 }
    }

    Timer {
        interval: 3500
        running: true
        onTriggered: root.visible = false
    }
}
