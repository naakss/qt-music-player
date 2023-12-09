import QtQuick 2.15
import QtQuick.Window 2.15

import Themes 1.0

Window {
    id: mainWindow
    visible: true
    width: DefaultTheme.width
    height: DefaultTheme.height
    flags: Qt.FramelessWindowHint

    property alias fontName: fontLoader.name

    FontLoader
    {
        id: fontLoader
        source: "qrc:/fonts/fontawesome.otf"
    }

    HomeScreen {}

    SplashScreen {}
}
