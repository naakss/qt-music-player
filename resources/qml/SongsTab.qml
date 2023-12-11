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

    property alias folder: folderModel.folder
    property bool playing: false

    signal pauseRequest()
    signal continueRequest()

    MouseArea {
        anchors.fill: parent
    }

    ButtonControl {
        id: playButton
        anchors.top: parent.top
        anchors.topMargin: DefaultTheme.margins
        anchors.horizontalCenter: parent.horizontalCenter
        width: height * 4
        buttonIcon: root.playing ? "\uf04c" : "\uf04b"
        buttonText: root.playing ? qsTr("Pause") : qsTr("Play")
        onClicked: {
            if (listView.count > 0) {
                if (root.playing) {
                    root.pauseRequest();
                } else {
                    root.playSelected();
                }
            }
        }
    }

    ListView {
        id: listView
        anchors.top: playButton.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: DefaultTheme.margins
        anchors.bottomMargin: DefaultTheme.spacing
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        model: folderModel
        delegate: ListDelegate {
            text: formatFilename(fileName)
            addVisible: true
            isCurrentItem: ListView.isCurrentItem
            onClicked: {
                listView.currentIndex = index;
                playSelected();
            }
            onAddItem: {
                root.openAddPopup(path)
            }

            property string path: filePath
        }
        ScrollBar.vertical: ScrollControl {}
    }

    Rectangle {
        id: addPopup
        anchors.centerIn: parent
        width: parent.width * 0.5 + DefaultTheme.borderWidth
        height: parent.height
        color: DefaultTheme.backgroundColor
        border.width: DefaultTheme.borderWidth
        border.color: DefaultTheme.textColor
        radius: DefaultTheme.radius
        visible: false

        property string path: ""

        Text {
            id: title
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: DefaultTheme.margins
            font.pixelSize: DefaultTheme.fontSize
            font.bold: true
            color: DefaultTheme.textColor
            text: qsTr("Add to Playlist")
        }

        ListView {
            id: list
            anchors.top: title.bottom
            anchors.left: title.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: DefaultTheme.margins
            anchors.rightMargin: DefaultTheme.margins
            anchors.bottomMargin: DefaultTheme.buttonHeight + DefaultTheme.margins * 2
            boundsBehavior: Flickable.StopAtBounds
            clip: true
            model: app.playlistNames
            delegate: ListDelegate {
                width: list.width
                text: modelData
                isCurrentItem: ListView.isCurrentItem
                onClicked: {
                    list.currentIndex = index;
                }
            }
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
                    app.addSongToPlaylist(list.currentItem.text, addPopup.path);
                    root.closeAddPopup();
                }
            }

            ButtonControl {
                width: height * 4
                buttonText: qsTr("Cancel")
                onClicked: {
                    root.closeAddPopup();
                }
            }
        }
    }

    FolderListModel {
        id: folderModel
        showDirs: false // Only files are shown, no folders
        nameFilters: [ "*.mp3"]
    }

    function playNext() {
        if (listView.currentIndex + 1 < listView.count) {
            listView.currentIndex = listView.currentIndex + 1;
            playSelected();
        }
    }

    function playSelected() {
        if (app.audioSource !== listView.currentItem.path) {
            app.audioSource = "";
            app.audioSource = listView.currentItem.path;
            app.audioName = listView.currentItem.text;
        } else {
            root.continueRequest();
        }
    }

    function playPrevious() {
        if (listView.currentIndex - 1 >= 0) {
            listView.currentIndex = listView.currentIndex - 1;
            playSelected();
        }
    }

    function openAddPopup(path) {
        addPopup.path = path;
        addPopup.visible = true;
    }

    function closeAddPopup() {
        addPopup.path = "";
        addPopup.visible = false;
    }
}
