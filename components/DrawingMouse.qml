import QtQuick 2.9

MouseArea {
    id:mouse
    anchors.fill: parent


    property bool isPressed: false


    onPressed: {
        isPressed = true
        mainCanvas.requestPaint();
        console.log("Pressing and holding");
        console.log("Requesting to paint in " + mouseX + ", " + mouseY );
    }

    onMouseXChanged: {
        mainCanvas.requestPaint();
        console.log("Requesting to paint in " + mouseX + ", " + mouseY );
    }

    onMouseYChanged: {
        mainCanvas.requestPaint();
        console.log("Requesting to paint in " + mouseX + ", " + mouseY );
    }

    onReleased: {
        isPressed = false;
        mainCanvas.mxBuffer = -1
        mainCanvas.myBuffer = -1
    }
}
