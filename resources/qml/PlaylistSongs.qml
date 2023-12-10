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

    property alias folder: folderModel_.folder
    property bool playing: false

    signal pauseRequest()

    onFolderChanged: {
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
        anchors.margins: DefaultTheme.margins
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        model: folderModel_
        delegate: ListDelegate {
            text: formatFilename(fileName)
            isCurrentItem: ListView.isCurrentItem
            onClicked: {
                listView_.currentIndex = index;
                playSelected();
            }
            property string path: filePath
        }
        ScrollBar.vertical: ScrollControl {}
    }

    FolderListModel {
        id: folderModel_
        showDirs: false // Only files are shown, no folders
        nameFilters: [ "*.mp3"]
    }

    function playNext() {
        if (listView_.currentIndex + 1 < listView_.count) {
            listView_.currentIndex = listView_.currentIndex + 1;
            playSelected();
        }
    }

    function playSelected() {
        app.audioSource = "";
        app.audioSource = listView_.currentItem.path;
        app.audioName = listView_.currentItem.text;
        playerOpenAnimation.start();
    }
}
