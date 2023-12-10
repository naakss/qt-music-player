import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.folderlistmodel 2.15

import Controls 1.0
import Themes 1.0

Rectangle {
    width: parent.width * 0.5
    height: parent.height
    color: DefaultTheme.backgroundColor

    ButtonControl {
        id: playButton
        anchors.top: parent.top
        anchors.topMargin: DefaultTheme.margins
        anchors.horizontalCenter: parent.horizontalCenter
        width: height * 4
        buttonIcon: "\uf04b"
        buttonText: qsTr("Play")
        onClicked: {
            if (listView.count > 0) {
                playSelected();
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
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        model: folderModel
        delegate: ListDelegate {
            text: fileName
            isCurrentItem: ListView.isCurrentItem
            onClicked: {
                listView.currentIndex = index;
                playSelected();
            }
            property string path: filePath
        }
        ScrollBar.vertical: ScrollControl {}
    }

    FolderListModel {
        id: folderModel
        folder: "file:" + app.songsPath()
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
        app.audioSource = listView.currentItem.path;
        app.audioName = listView.currentItem.text;
        playerOpenAnimation.start();
    }
}
