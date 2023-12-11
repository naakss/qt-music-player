/***************************************************************************/
/*! \file       AddSongsScreen.qml
 * \brief       list view showing songs to be added to newly created playlist
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
    width: parent.width
    height: parent.height
    color: DefaultTheme.backgroundColor

    property var selectedSongs: []
    property string playlistName: ""

    MouseArea {
        anchors.fill: parent
    }

    Text {
        id: title
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: DefaultTheme.margins
        font.pixelSize: DefaultTheme.fontSize
        font.bold: true
        color: DefaultTheme.textColor
        text: qsTr("Add songs to Playlist")
    }

    ListView {
        id: listView
        anchors.top: title.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: buttonsRow.top
        anchors.margins: DefaultTheme.margins
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        model: folderModel
        delegate: Item {
            width: DefaultTheme.width - 3 * DefaultTheme.margins
            height: DefaultTheme.rowHeightL

            CheckBoxControl {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                font.pixelSize: DefaultTheme.fontSizeS
                text: formatFilename(fileName)
                onCheckedChanged: {
                    if (checked) {
                        addSong(path);
                    } else {
                        removeSong(path);
                    }
                }
            }

            property string path: filePath
        }
        ScrollBar.vertical: ScrollControl {}
    }

    Row {
        id: buttonsRow
        anchors.bottom: parent.bottom
        anchors.bottomMargin: DefaultTheme.margins
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: DefaultTheme.margins

        ButtonControl {
            width: height * 4
            buttonText: qsTr("OK")
            onClicked: {
                app.createNewPlaylist(root.playlistName, selectedSongs);
                reset();
            }
        }

        ButtonControl {
            width: height * 4
            buttonText: qsTr("Cancel")
            onClicked: {
                reset();
            }
        }
    }

    FolderListModel {
        id: folderModel
        showDirs: false // Only files are shown, no folders
        nameFilters: [ "*.mp3"]
        folder: "file:" + app.songsPath()
    }

    Behavior on x { NumberAnimation { duration: 250} }

    function addSong(s) {
        if (!selectedSongs.includes(s)) {
          selectedSongs.push(s);
        }
    }

    function removeSong(s) {
        let indexToRemove = selectedSongs.indexOf(s);
        if (indexToRemove !== -1) {
          selectedSongs.splice(indexToRemove, 1);
        }
    }

    function reset() {
        root.x = root.width;
        root.playlistName = "";
        root.selectedSongs = [];
        listView.model = null; // To reset checkbox selection
        listView.model = folderModel;
    }
}
