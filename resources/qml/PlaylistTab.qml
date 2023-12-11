/***************************************************************************/
/*! \file       PlaylistTab.qml
 * \brief       list view showing available playlists
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
    height: parent.height - DefaultTheme.rowHeightL
    color: DefaultTheme.backgroundColor

    property bool playing: false

    signal pauseRequest()
    signal continueRequest()

    ButtonControl {
        id: createButton
        anchors.top: parent.top
        anchors.topMargin: DefaultTheme.margins
        anchors.horizontalCenter: parent.horizontalCenter
        width: height * 4
        buttonText: qsTr("Create New")
        onClicked: {
            createPlaylistPopup.visible = true;
        }
    }

    ListView {
        id: listView
        anchors.top: createButton.bottom
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
            deleteVisible: true
            onClicked: {
                listView.currentIndex = index;
                app.onPlaylistSelected(text);
                songsOpenAnimation.start();
            }
            onDeleteItem: {
                root.openDeletePopup(text, false)
            }
        }
        ScrollBar.vertical: ScrollControl {}
    }

    PlaylistSongs {
        id: songsView
        width: parent.width
        x: listView.x + width
        y: createButton.y
        model: app.playlistSongs
        playing: root.playing
        onPauseRequest: {
            root.pauseRequest();
        }
        onContinueRequest: {
            root.continueRequest();
        }
        onDeleteSongRequest: {
            root.pauseRequest();
            root.openDeletePopup(path)
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

    Rectangle {
        id: confirmDeletePopup
        anchors.centerIn: parent
        width: parent.width * 0.5 + DefaultTheme.borderWidth
        height: parent.height * 0.6
        color: DefaultTheme.backgroundColor
        border.width: DefaultTheme.borderWidth
        border.color: DefaultTheme.textColor
        radius: DefaultTheme.radius
        visible: false

        property string path: ""
        property bool isSong: true

        Text {
            id: title
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: DefaultTheme.margins
            font.pixelSize: DefaultTheme.fontSize
            font.bold: true
            color: DefaultTheme.textColor
            text: qsTr("Confirm Deletion")
        }

        Text {
            anchors.top: title.bottom
            anchors.left: title.left
            anchors.right: parent.right
            anchors.topMargin: DefaultTheme.margins
            anchors.rightMargin: DefaultTheme.margins
            font.pixelSize: DefaultTheme.fontSize
            color: DefaultTheme.textColor
            wrapMode: Text.WordWrap
            text: (qsTr("Are you sure you want to delete ") + formatFilename(confirmDeletePopup.path) + "?")
        }

        Row {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: DefaultTheme.margins
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: DefaultTheme.margins

            ButtonControl {
                width: height * 4
                buttonText: qsTr("Yes")
                onClicked: {
                    if (confirmDeletePopup.isSong) {
                        app.deleteSong(listView.currentItem.text, confirmDeletePopup.path);
                    } else {
                        app.deletePlaylist(confirmDeletePopup.path);
                    }

                    root.closeDeletePopup();
                }
            }

            ButtonControl {
                width: height * 4
                buttonText: qsTr("No")
                onClicked: {
                    root.closeDeletePopup();
                }
            }
        }
    }

    Rectangle {
        id: createPlaylistPopup
        anchors.centerIn: parent
        width: parent.width * 0.5 + DefaultTheme.borderWidth
        height: parent.height * 0.6
        color: DefaultTheme.backgroundColor
        border.width: DefaultTheme.borderWidth
        border.color: DefaultTheme.textColor
        radius: DefaultTheme.radius
        visible: false

        Text {
            id: createTitle
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: DefaultTheme.margins
            font.pixelSize: DefaultTheme.fontSize
            font.bold: true
            color: DefaultTheme.textColor
            text: qsTr("Enter Playlist Name")
        }

        TextField {
            id: textField
            anchors.top: createTitle.bottom
            anchors.left: createTitle.left
            anchors.right: parent.right
            anchors.topMargin: DefaultTheme.margins
            anchors.rightMargin: DefaultTheme.margins
            font.pixelSize: DefaultTheme.fontSize
        }

        Row {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: DefaultTheme.margins
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: DefaultTheme.margins

            ButtonControl {
                width: height * 4
                buttonText: qsTr("OK")
                onClicked: {
                    app.createNewPlaylist(textField.text);
                    textField.text = "";
                    createPlaylistPopup.visible = false;
                }
            }

            ButtonControl {
                width: height * 4
                buttonText: qsTr("Cancel")
                onClicked: {
                    textField.text = "";
                    createPlaylistPopup.visible = false;
                }
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

    function openDeletePopup(path, isSong = true) {
        confirmDeletePopup.path = path;
        confirmDeletePopup.isSong = isSong;
        confirmDeletePopup.visible = true;
    }

    function closeDeletePopup() {
        confirmDeletePopup.path = "";
        confirmDeletePopup.visible = false;
    }
}
