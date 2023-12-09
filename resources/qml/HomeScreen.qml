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
            anchors.left: parent.left
        }

        PlaylistTab {
            anchors.right: parent.right
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
        y: height
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

    PropertyAnimation {
        id: playerOpenAnimation
        target: playerScreen
        property: "y"
        to: 0
        duration: 250
    }

    PropertyAnimation {
        id: playerCloseAnimation
        target: playerScreen
        property: "y"
        to: DefaultTheme.height
        duration: 250
    }
}
