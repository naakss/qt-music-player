/***************************************************************************/
/*! \file       PlaylistSongs.qml
 * \brief       list view showing songs in the playlist
 *
 * \copyright   Copyright (c) 2023 Sagar Gurudas Nayak
 * \copyright   MIT License
 *
 * \remark      Email: sagargnayak26@gmail.com
 ***************************************************************************/

import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.folderlistmodel 2.15

import Controls 1.0
import Themes 1.0

Rectangle {
    id: root
    width: parent.width * 0.5
    height: parent.height
    color: DefaultTheme.backgroundColor

    property bool playing: false
    property alias model: listView_.model

    signal pauseRequest()
    signal continueRequest()
    signal deleteSongRequest(string path)

    onModelChanged: {
        if (listView_.count > 0) {
            listView_.currentIndex = 0;
        }
    }

    MouseArea {
        anchors.fill: parent
    }

    ButtonControl {
        id: playButton_
        anchors.top: parent.top
        anchors.topMargin: DefaultTheme.margins
        anchors.horizontalCenter: parent.horizontalCenter
        width: height * 4
        buttonIcon: root.playing ? "\uf04c" : "\uf04b"
        buttonText: root.playing ? qsTr("Pause") : qsTr("Play")
        onClicked: {
            if (listView_.count > 0) {
                if (root.playing) {
                    root.pauseRequest();
                } else {
                    root.playSelected();
                }
            }
        }
    }

    ListView {
        id: listView_
        anchors.top: playButton_.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: DefaultTheme.margins * 1.5
        anchors.margins: DefaultTheme.margins
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        delegate: ListDelegate {
            text: formatFilename(modelData)
            isCurrentItem: ListView.isCurrentItem
            deleteVisible: true
            onClicked: {
                listView_.currentIndex = index;
                playSelected();
            }
            onDeleteItem: {
                root.deleteSongRequest(path)
            }

            property string path: modelData
        }
        ScrollBar.vertical: ScrollControl {}
    }

    function playNext() {
        if (listView_.currentIndex + 1 < listView_.count) {
            listView_.currentIndex = listView_.currentIndex + 1;
            playSelected();
        }
    }

    function playSelected() {
        if (app.audioSource !== listView_.currentItem.path) {
            app.audioSource = "";
            app.audioSource = listView_.currentItem.path;
            app.audioName = listView_.currentItem.text;
        } else {
            root.continueRequest();
        }
    }

    function playPrevious() {
        if (listView_.currentIndex - 1 >= 0) {
            listView_.currentIndex = listView_.currentIndex - 1;
            playSelected();
        }
    }
}
