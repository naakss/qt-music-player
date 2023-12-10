import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.folderlistmodel 2.15

import Controls 1.0
import Themes 1.0

Rectangle {
    id: root
    width: parent.width * 0.5
    height: parent.height - DefaultTheme.rowHeightL
    color: DefaultTheme.backgroundColor

    property bool playing: false

    signal pauseRequest()
    signal continueRequest()

    ListView {
        id: listView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: DefaultTheme.margins
        anchors.bottomMargin: DefaultTheme.spacing
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        model: app.playlistNames
        currentIndex: 0
        delegate: ListDelegate {
            text: modelData
            isCurrentItem: ListView.isCurrentItem
            onClicked: {
                listView.currentIndex = index;
                app.onPlaylistSelected(text);
                songsOpenAnimation.start();
            }
        }
        ScrollBar.vertical: ScrollControl {}
    }

    PlaylistSongs {
        id: songsView
        width: parent.width
        x: listView.x + width
        y: listView.y
        model: app.playlistSongs
        playing: root.playing
        onPauseRequest: {
            root.pauseRequest();
        }
        onContinueRequest: {
            root.continueRequest();
        }

        TextControl {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: DefaultTheme.margins
            anchors.topMargin: DefaultTheme.margins * 1.4
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSize
            text: "\uf060"
            onClicked: {
                songsCloseAnimation.start()
            }
        }
    }

    PropertyAnimation {
        id: songsOpenAnimation
        target: songsView
        property: "x"
        to: listView.x
        duration: 250
    }

    PropertyAnimation {
        id: songsCloseAnimation
        target: songsView
        property: "x"
        to: listView.x + songsView.width
        duration: 250
    }

    function playNext() {
        songsView.playNext();
    }

    function playPrevious() {
        songsView.playPrevious();
    }
}
