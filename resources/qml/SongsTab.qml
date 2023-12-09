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
                app.audioSource = listView.currentItem.path
                app.audioName = listView.currentItem.text
                playerOpenAnimation.start()
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
                listView.currentIndex = index
                app.audioSource = path
                app.audioName = text
                playerOpenAnimation.start()
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
}
