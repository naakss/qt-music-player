import QtQuick 2.15

import Themes 1.0
import Controls 1.0

Rectangle {
    id: root
    width: DefaultTheme.width - 3 * DefaultTheme.margins
    height: DefaultTheme.rowHeightL
    color: "transparent"
    border.width: isCurrentItem ? DefaultTheme.borderWidth : 0
    border.color: DefaultTheme.primaryColor
    radius: DefaultTheme.radius

    property alias text: textContent.text
    property bool isCurrentItem: false

    signal clicked()

    Rectangle {
        id: musicIcon
        anchors.left: parent.left
        anchors.leftMargin: DefaultTheme.spacing
        anchors.verticalCenter: parent.verticalCenter
        color: DefaultTheme.primaryColor
        radius: DefaultTheme.radius
        height: parent.height * 0.68
        width: height

        TextControl {
            anchors.centerIn: parent
            font.family: mainWindow.fontName
            font.pixelSize: DefaultTheme.fontSizeS
            text: "\uf001"
        }
    }

    Text {
        id: textContent
        anchors.verticalCenter: musicIcon.verticalCenter
        anchors.left: musicIcon.right
        anchors.leftMargin: DefaultTheme.margins
        font.pixelSize: DefaultTheme.fontSizeS
        color: DefaultTheme.textColor
    }

    TextControl {
        anchors.right: parent.right
        anchors.rightMargin: DefaultTheme.spacing
        anchors.verticalCenter: musicIcon.verticalCenter
        font.family: mainWindow.fontName
        font.pixelSize: DefaultTheme.fontSize
        text: "\uf142"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.clicked()
        }
    }
}
