import QtQuick 2.9
import Ubuntu.Components 1.3

UbuntuShape{
    id: drawTool
    width: units.gu(7)
    height: units.gu(7)


    onStateChanged: {
        console.log(drawTool.id + " current state: " + state)
    }

    MouseArea{
        id: myMouse1
        anchors.fill: parent


        onClicked: {
            //tools.unsetTools = true
            drawTool.state = "selected"

            console.log(drawTool.id + " selected")

        }
    }
}
