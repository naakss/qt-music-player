/***************************************************************************/
/*! \file       main.qml
 * \brief       the root of all qml files
 *
 * \copyright   Copyright (c) 2023 Sagar Gurudas Nayak
 * \copyright   MIT License
 *
 * \remark      Email: sagargnayak26@gmail.com
 ***************************************************************************/

import QtQuick 2.15
import QtQuick.Window 2.15

import Controls 1.0
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

    Toast {
        id: toast
    }

    function formatFilename(filename) {
        let name = filename.endsWith(".mp3") ? filename.substring(0, filename.length - 4) : filename;

        return name.includes(mainWindow.songsPath) ? name.replace(songsPath, "") : name;
    }

    Connections {
        target: app

        function onShowMessage(msg) {
            toast.show(msg);
        }
    }
}
