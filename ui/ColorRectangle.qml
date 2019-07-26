import QtQuick 2.9

Rectangle{
    width: units.gu(5)
    height: units.gu(2)
    color: "transparent"
    border.color: "lightgray"
    border.width: 2

    MouseArea{
        anchors.fill: parent
        onClicked: {
            mainCanvas.drawingColor = parent.color;
        }
    }
}
