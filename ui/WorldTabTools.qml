import QtQuick 2.9
import Ubuntu.Components 1.3

ToolbarItems {
    ToolbarButton {
        iconSource: Qt.resolvedUrl("../graphics/toolbarIcon.png")
        text: i18n.tr("Tap me!")


        
        onTriggered: {
            console.log(i18n.tr("Toolbar tapped"))
        }
    }
}
