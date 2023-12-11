/***************************************************************************/
/*! \file       HomeScreen.qml
 * \brief       the home screen of the app containing songs & playlist tabs
 *
 * \copyright   Copyright (c) 2023 Sagar Gurudas Nayak
 * \copyright   MIT License
 *
 * \remark      Email: sagargnayak26@gmail.com
 ***************************************************************************/

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import Controls 1.0
import Themes 1.0

Rectangle {
    id: root
    anchors.fill: parent
    color: DefaultTheme.backgroundColor

    QtObject {
        id: internal
        property int activeTab: 1
        onActiveTabChanged: {
            if (activeTab === 2) {
                slideInAnimation.start()
            } else {
                slideOutAnimation.start()
            }
        }
    }

    TextControl {
        id: barIcon
        anchors.top: parent.top
        anchors.topMargin: DefaultTheme.margins
        anchors.left: parent.left
        anchors.leftMargin: DefaultTheme.margins
        font.family: mainWindow.fontName
        font.pixelSize: DefaultTheme.fontSize
        text: "\uf03a"
    }

    Text {
        id: header
        anchors.verticalCenter: barIcon.verticalCenter
        anchors.left: barIcon.right
        anchors.leftMargin: DefaultTheme.margins
        font.pixelSize: DefaultTheme.fontSizeL
        color: DefaultTheme.textColor
        text: qsTr("Music Player")
    }

    Item {
        id: tabView
        y: rowLayout.y + rowLayout.height
        x: 0
        width: DefaultTheme.width * 2
        height: DefaultTheme.height - y

        SongsTab {
            id: songsTab
            anchors.left: parent.left
            folder: "file:" + app.songsPath()
            playing: playerScreen.playing
            onPauseRequest: {
                playerScreen.pausePlayer();
            }
            onContinueRequest: {
                playerScreen.continuePlayer();
            }
        }

        PlaylistTab {
            id: playlistTab
            anchors.right: parent.right
            playing: playerScreen.playing
            onPauseRequest: {
                playerScreen.pausePlayer();
            }
            onContinueRequest: {
                playerScreen.continuePlayer();
            }
        }
    }

    Separator {
        anchors.bottom: rowLayout.bottom
        color: DefaultTheme.primaryColor
        height: DefaultTheme.borderWidth
        opacity: 0.3
    }

    RowLayout {
        id: rowLayout
        anchors.top: header.bottom
        anchors.topMargin: DefaultTheme.margins
        anchors.left: parent.left
        anchors.leftMargin: DefaultTheme.margins
        spacing: DefaultTheme.margins

        TabControl {
            text: qsTr("Songs")
            active: internal.activeTab === 1
            onClicked: {
                internal.activeTab = 1
            }
        }

        TabControl {
            text: qsTr("Playlist")
            active: internal.activeTab === 2
            onClicked: {
                internal.activeTab = 2
            }
        }
    }

    PlayerScreen {
        id: playerScreen
        onStopped: {
            if (internal.activeTab === 2) {
                playlistTab.playNext();
            } else {
                songsTab.playNext();
            }
        }
        onNext: {
            if (internal.activeTab === 2) {
                playlistTab.playNext();
            } else {
                songsTab.playNext();
            }
        }
        onPrevious: {
            if (internal.activeTab === 2) {
                playlistTab.playPrevious();
            } else {
                songsTab.playPrevious();
            }
        }
    }

    PropertyAnimation {
        id: slideInAnimation
        target: tabView
        property: "x"
        to: -DefaultTheme.width
        duration: 250
    }

    PropertyAnimation {
        id: slideOutAnimation
        target: tabView
        property: "x"
        to: 0
        duration: 250
    }
}
