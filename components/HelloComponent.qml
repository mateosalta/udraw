import QtQuick 2.9
import Ubuntu.Components 1.3

UbuntuShape {
    width: 200
    height: width
    
    property alias text : myText.text
    
    Label {
        id: myText
        anchors.centerIn: parent
    }
}
