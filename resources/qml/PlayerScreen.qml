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
    y: height - miniPlayer.height
    state: ""

    property bool playing: mediaPlayer.playbackState === MediaPlayer.PlayingState
    property bool miniPlayer: true

    signal stopped()
    signal next()
    signal previous()

    states: State {
        name: "fullScreen"
        when: !root.miniPlayer
        PropertyChanges { target: root; y: 0 }
    }

    transitions: Transition {
        NumberAnimation { properties: "y"; easing.type: Easing.InOutQuad; duration: 250 }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (root.miniPlayer) {
                root.miniPlayer = false;
            }
        }
    }

    MiniPlayer {
        id: miniPlayer
        playing: root.playing
        name: songName.text
        progress: (slider.value / slider.to) * miniPlayer.width
        visible: root.miniPlayer
        onPrevious: {
            root.previous();
        }
        onNext: {
            root.next();
        }
        onPlay: {
            if (miniPlayer.playing) {
                mediaPlayer.pause();
            } else {
                mediaPlayer.play();
            }
        }
    }

    MediaPlayer {
        id: mediaPlayer
        source: app.audioSource.length > 0 ? ("file://" + app.audioSource) : ""
        onPositionChanged: {
            updateTime()
        }
        onStopped: {
            if (mediaPlayer.status === MediaPlayer.EndOfMedia) {
              stopTimer.start();
            }
        }
    }

    TextControl {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: DefaultTheme.margins
        font.family: mainWindow.fontName
        font.pixelSize: DefaultTheme.fontSizeL
        text: "\uf107"
        visible: !root.miniPlayer
        onClicked: {
            root.miniPlayer = true;
        }
    }

    Rectangle {
        id: musicIcon
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.25
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
        anchors.topMargin: DefaultTheme.spacing * 2.5
        anchors.horizontalCenter: musicIcon.horizontalCenter
        color: DefaultTheme.textColor
        font.pixelSize: DefaultTheme.fontSizeL
        text: formatFilename(app.audioName)
    }

    SliderControl {
        id: slider
        anchors.left: controlsRow.left
        anchors.bottom: controlsRow.top
        anchors.bottomMargin: DefaultTheme.margins * 2
        width: controlsRow.width
        from: 0
        to: mediaPlayer.duration
        value: mediaPlayer.position
        onPressedChanged: {
            if (!pressed) {
                mediaPlayer.seek(slider.value);
            }
        }
    }

    Text {
        id: elapsedTime
        anchors.top: slider.bottom
        anchors.left: slider.left
        anchors.topMargin: DefaultTheme.spacing * 0.5
        color: DefaultTheme.textColor
        font.pixelSize: DefaultTheme.fontSizeS
        text: "00:00"
    }

    Text {
        id: totalTime
        anchors.top: slider.bottom
        anchors.right: slider.right
        anchors.topMargin: DefaultTheme.spacing * 0.5
        color: DefaultTheme.textColor
        font.pixelSize: DefaultTheme.fontSizeS
        text: "00:00"
    }

    RowLayout {
        id: controlsRow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: DefaultTheme.margins * 2
        spacing: DefaultTheme.margins * 3

        TextControl {
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSizeL
            text: "\uf04a"
            onClicked: {
                root.previous();
            }
        }

        TextControl {
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSizeL
            text: root.playing ? "\uf04c" : "\uf04b"
            onClicked: {
                if (root.playing) {
                    mediaPlayer.pause();
                } else {
                    mediaPlayer.play();
                }
            }
        }

        TextControl {
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSizeL
            text: "\uf04e"
            onClicked: {
                root.next();
            }
        }
    }

    Connections {
        target: app

        function onAudioSourceChanged() {
            mediaPlayer.seek(0);
            mediaPlayer.play();
        }
    }

    Timer {
        id: stopTimer
        interval: 500
        onTriggered: {
            root.stopped();
        }
    }

    function updateTime() {
        // Update elapsed time
        var elapsedMinutes = Math.floor(mediaPlayer.position / 1000 / 60)
        var elapsedSeconds = Math.floor((mediaPlayer.position / 1000) % 60)
        elapsedTime.text = pad(elapsedMinutes) + ":" + pad(elapsedSeconds)

        // Update total time
        var totalMinutes = Math.floor(mediaPlayer.duration / 1000 / 60)
        var totalSeconds = Math.floor((mediaPlayer.duration / 1000) % 60)
        totalTime.text = pad(totalMinutes) + ":" + pad(totalSeconds)
    }

    function pad(number) {
        return (number < 10) ? "0" + number : number
    }

    function pausePlayer() {
        mediaPlayer.pause();
    }

    function continuePlayer() {
        mediaPlayer.play();
    }
}
