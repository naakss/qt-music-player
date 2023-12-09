import QtQuick 2.15
import QtQuick.Controls 2.15

import Themes 1.0

Rectangle {
    id: control

    property int orientation: Qt.Horizontal

    height: orientation == Qt.Vertical ? parent.height : DefaultTheme.separatorThickness
    width: orientation == Qt.Vertical ? DefaultTheme.separatorThickness : parent.width
    color: DefaultTheme.separatorColor
}
