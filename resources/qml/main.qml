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
    property string songsPath: app.songsPath()

    FontLoader
    {
        id: fontLoader
        source: "qrc:/fonts/fontawesome.otf"
    }

    HomeScreen {}

    SplashScreen {}

    function formatFilename(filename) {
        let name = filename.endsWith(".mp3") ? filename.substring(0, filename.length - 4) : filename;

        return name.includes(mainWindow.songsPath) ? name.replace(songsPath, "") : name;
    }
}
