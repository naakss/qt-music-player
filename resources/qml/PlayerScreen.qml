import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15

import Controls 1.0
import Themes 1.0

Rectangle {
    id: root
    width: DefaultTheme.width
    height: DefaultTheme.height
    color: DefaultTheme.backgroundColor
    radius: y > 0 ? DefaultTheme.radius : 0

    property bool playing: mediaPlayer.playbackState === MediaPlayer.PlayingState

    MediaPlayer {
        id: mediaPlayer
        source: "file://" + app.audioSource
    }

    TextControl {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: DefaultTheme.margins
        font.family: mainWindow.fontName
        font.pixelSize: DefaultTheme.fontSizeL
        text: "\uf107"
        onClicked: {
            playerCloseAnimation.start()
        }
    }

    Rectangle {
        id: musicIcon
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.3
        anchors.horizontalCenter: parent.horizontalCenter
        color: DefaultTheme.primaryColor
        radius: DefaultTheme.radius
        height: DefaultTheme.logoSize
        width: height

        TextControl {
            anchors.centerIn: parent
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSizeL * 2
            text: "\uf001"
        }
    }

    Text{
        id: songName
        anchors.top: musicIcon.bottom
        anchors.topMargin: DefaultTheme.spacing * 3
        anchors.horizontalCenter: musicIcon.horizontalCenter
        color: DefaultTheme.textColor
        font.pixelSize: DefaultTheme.fontSizeL
        text: formatFilename(app.audioName)
    }

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: DefaultTheme.margins * 2
        spacing: DefaultTheme.margins * 3

        TextControl {
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSizeL
            text: "\uf04a"
        }

        TextControl {
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSizeL
            text: root.playing ? "\uf04c" : "\uf04b"
            onClicked: {
                if (root.playing) {
                    mediaPlayer.pause()
                } else {
                    mediaPlayer.play()
                }
            }
        }

        TextControl {
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSizeL
            text: "\uf04e"
        }
    }

    function formatFilename(filename) {
        if (filename.endsWith(".mp3")) {
            return filename.substring(0, filename.length - 4);
        }
        return filename;
    }

    Connections {
        target: app

        function onAudioSourceChanged() {
            mediaPlayer.seek(0);
            mediaPlayer.play();
        }
    }
}
