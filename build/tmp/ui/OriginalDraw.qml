import QtQuick 2.9
import Ubuntu.Components 1.3
import "../components"

Column {
    spacing: units.gu(2)
    anchors.centerIn: parent

    DrawingFrame{
        id: canvasBorder
        width: units.gu(25)
        height: units.gu(45)
        DrawingSheet{
            id: mainCanvas
        }
    }

    Label {
        objectName: "canvasLabel"

        anchors.horizontalCenter: parent.horizontalCenter

        text: mainCanvas.drawName
    }

    Grid{
        width: canvasBorder.width
        columns: 3
        rows: 1
        anchors.horizontalCenter: parent.horizontalCenter
        columnSpacing: units.gu(5)


        Palette{
            height: units.gu(6)

        }

        Button {
            text: i18n.tr("Clear")
            onClicked: {
                var ctx = mainCanvas.getContext('2d')
                ctx.rect(0, 0, mainCanvas.width, mainCanvas.height);
                ctx.fillStyle = "white";
                ctx.fill;
                mouse.isPressed = true;
                mainCanvas.requestPaint();
                mouse.isPressed = false
                console.log("Clear called")
            }
        }

        Slider {
            id: lineSlider

            value: 1
            minimumValue: 1
            maximumValue: 35
            onValueChanged: {
                mainCanvas.lineWidth = value
            }
        }


    }



}
