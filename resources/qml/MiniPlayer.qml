import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import Controls 1.0
import Themes 1.0

Rectangle {
    id: miniPlayer
    height: DefaultTheme.rowHeightL
    width: parent.width
    radius: parent.radius * 2
    color: DefaultTheme.primaryColor
    clip: true

    property bool playing: false
    property alias name: textContentMini.text
    property real progress: 0

    signal play()
    signal next()
    signal previous()

    Rectangle {
        id: musicIconMini
        anchors.left: parent.left
        anchors.leftMargin: DefaultTheme.spacing
        anchors.verticalCenter: parent.verticalCenter
        color: DefaultTheme.backgroundColor
        radius: DefaultTheme.radius
        height: parent.height * 0.68
        width: height
        visible: app.audioSource.length > 0

        TextControl {
            anchors.centerIn: parent
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSizeS
            text: "\uf001"
        }
    }

    Text {
        id: textContentMini
        anchors.verticalCenter: musicIconMini.verticalCenter
        anchors.left: musicIconMini.right
        anchors.leftMargin: DefaultTheme.margins
        font.pixelSize: DefaultTheme.fontSizeS
        color: DefaultTheme.textColor
        visible: musicIconMini.visible
    }

    RowLayout {
        anchors.right: parent.right
        anchors.rightMargin: DefaultTheme.margins
        anchors.verticalCenter: parent.verticalCenter
        spacing: DefaultTheme.margins * 3
        visible: musicIconMini.visible

        TextControl {
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSize
            color: DefaultTheme.backgroundColor
            text: "\uf04a"
            onClicked: {
                miniPlayer.previous();
            }
        }

        TextControl {
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSize
            color: DefaultTheme.backgroundColor
            text: miniPlayer.playing ? "\uf04c" : "\uf04b"
            onClicked: {
                miniPlayer.play();
            }
        }

        TextControl {
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSize
            color: DefaultTheme.backgroundColor
            text: "\uf04e"
            onClicked: {
                miniPlayer.next();
            }
        }
    }

    Separator {
        anchors.bottom: parent.bottom
        color: DefaultTheme.textColor
    }

    Separator {
        anchors.bottom: parent.bottom
        width: miniPlayer.progress
    }
}
