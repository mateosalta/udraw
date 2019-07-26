import QtQuick 2.9
import Ubuntu.Components 1.3

Canvas{
    id: mainCanvas

    renderStrategy: Canvas.Threaded //Needed to save()

    property string drawName: "Draw 001" // Name of the current file
    property color drawingColor: "darkgray" // Name of the current color
    property int lineWidth: units.dp(1)
    property int mxBuffer: -1 // mouse X coordinate buffer
    property int myBuffer: -1 // mouse Y coordinate buffer

    anchors.fill: parent
    smooth: true
    antialiasing: true

}







