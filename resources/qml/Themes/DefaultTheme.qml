pragma Singleton
import QtQuick 2.15

QtObject {
    property int width: 800
    property int height: 480

    property int fontSizeL: 30
    property int fontSize: 20
    property int fontSizeS: 18

    property color backgroundColor: "#28243D"
    property color primaryColor: "#645A99"
    property color buttonColor: "#4184AF"
    property color separatorColor: "yellow"
    property color textColor: "#FFFFFF"
    property color logoColor: "#F6781D"

    property int rowHeight: 36
    property int rowHeightL: 50
    property int buttonHeight: 36
    property int logoSize: 120
    property int separatorThickness: 3
    property int scrollBarThickness: 10
    property int borderWidth: 1
    property int spacing: 10
    property int margins: 20
    property int radius: 4
}
