import QtQuick 2.9
import Ubuntu.Components 1.3
import QtGraphicalEffects 1.0
import "../paintColorUtils.js" as PaintColorUtils

Rectangle {
    anchors.margins: units.gu(2)
    id: frame
    anchors.fill: parent
    color: "transparent"
    property real colHue: 0.0
    property real colSat: 1.0
    property real colLight: 1.0
    property real r: 1.0
    property real g: 1.0
    property real b: 1.0
    property color highlightColor: colLight > 0.35 ? Qt.rgba(0.1,0.1,0.1,0.8) : Qt.rgba(0.9,0.9,0.9,0.8)
    property bool changedByUser: true

    function updateColor(caller) {
        changedByUser = false;
        colorOut.color = Qt.hsla(colHue,colSat,colLight,1);
        if(caller !== hueSlider) hueSlider.value = colHue*360;
        if(caller !== lightSlider) lightSlider.value = colLight*100;
        if(caller !== satSlider) satSlider.value = colSat*100;
        if(caller !== colorHex) { colorHex.text = colorOut.color.toString(); }
        if(caller !== pickerArea) { pickerArea.updatePos() }
        console.log("h:", colHue, "; s:", colSat, "; l:", colLight);
        changedByUser = true;
    }

    Column {
        anchors {
            fill: frame
        }
        spacing: units.gu(2)

        Rectangle {
            id: colorChart
            radius: width/2
            height: parent.height - controls.height - parent.spacing
            width: height
            anchors.horizontalCenter: parent.horizontalCenter

            ConicalGradient {
                id: colorSpectrum
                width: colorChart.width
                height: colorChart.height

                angle: 30
                source: colorChart

                anchors.centerIn: parent

                gradient: Gradient {
                    GradientStop { position: 0.000; color: Qt.hsla(0.166,colSat,0.5,1) }
                    GradientStop { position: 0.166; color: Qt.hsla(1.000,colSat,0.5,1) }
                    GradientStop { position: 0.333; color: Qt.hsla(0.833,colSat,0.5,1) }
                    GradientStop { position: 0.500; color: Qt.hsla(0.666,colSat,0.5,1) }
                    GradientStop { position: 0.666; color: Qt.hsla(0.500,colSat,0.5,1) }
                    GradientStop { position: 0.833; color: Qt.hsla(0.333,colSat,0.5,1) }
                    GradientStop { position: 1.000; color: Qt.hsla(0.166,colSat,0.5,1) }
                }
            }

            RadialGradient {
                id: lightSpectrum

                width: colorChart.width
                height: colorChart.height
                anchors.centerIn: parent

                source: colorChart

                gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.rgba(1,1,1,1) }
                    GradientStop { position: 0.25; color: Qt.rgba(1,1,1,0) }
                    GradientStop { position: 0.250000001; color: Qt.rgba(0,0,0,0) }
                    GradientStop { position: 0.5; color: Qt.rgba(0,0,0,1) }
                }
            }

            Rectangle {
                id: pickerCircle
                color: "transparent"
                property real mid: width/2;
                border.color: highlightColor
                border.width: units.gu(0.2)
                radius: units.gu(0.5)
                width: units.gu(2)
                height: width
                x: colorChart.radius - mid
                y: x
            }

            MouseArea {
                id: pickerArea
                anchors.fill: parent
                drag.target: pickerCircle

                onPositionChanged: mouseUpdatePos()
                onPressed: mouseUpdatePos()

                function mouseUpdatePos() {
                    var dx = mouseX - colorChart.radius;
                    var dy = mouseY - colorChart.radius;
                    var mouseRadius = Math.sqrt(Math.pow(dx,2) + Math.pow(dy,2));
                    if(colorChart.radius > mouseRadius) {
                        pickerCircle.x = mouseX - pickerCircle.mid;
                        pickerCircle.y = mouseY - pickerCircle.mid;
                    }
                    else {
                        var radiiRatio = colorChart.radius / mouseRadius;
                        pickerCircle.x = (dx*radiiRatio) + colorChart.radius - pickerCircle.mid;
                        pickerCircle.y = (dy*radiiRatio) + colorChart.radius - pickerCircle.mid;
                    }
                    var yRatio = pickerCircle.y+pickerCircle.mid-colorChart.radius;
                    var xRatio = colorChart.radius-(pickerCircle.x+pickerCircle.mid);
                    var newColor = PaintColorUtils.pointToHl(xRatio,yRatio);
                    colHue = newColor.pointHue;
                    colLight = newColor.pointLight;
                    updateColor(pickerArea);
                }

                function updatePos() {
                    var newColorPoint = PaintColorUtils.hltoPoint(colHue,colLight);
                    pickerCircle.x = (newColorPoint.hlX*colorChart.radius)-(pickerCircle.width/2) + colorChart.radius;
                    pickerCircle.y = (newColorPoint.hlY*colorChart.radius)-(pickerCircle.height/2) + colorChart.radius;
                }

                Component.onCompleted: {
                    updateColor(pickerArea);
                }
            }
        }

        Column {
            id: controls
            spacing: units.gu(1)
            Row {
                spacing: frame.width - hueLabel.width - hueSlider.width - units.gu(1)
                Label {
                    id: hueLabel
                    text: "Hue:"
                    anchors.verticalCenter: hueSlider.verticalCenter
                }

                Slider {
                    id: hueSlider
                    width: units.gu(25)
                    minimumValue: 0
                    maximumValue: 360
                    live: true

                    onValueChanged: {
                        if(changedByUser) {
                            colHue = value/360;
                            updateColor(hueSlider);
                        }
                    }
                }
            }

            Row {
                spacing: frame.width - satLabel.width - satSlider.width - units.gu(1)

                Label {
                    id: satLabel
                    text: "Saturation:"
                    anchors.verticalCenter: satSlider.verticalCenter
                }

                Slider {
                    id: satSlider
                    width: units.gu(25)
                    minimumValue: 0
                    maximumValue: 100
                    live: true

                    onValueChanged: {
                        if(changedByUser) {
                            colSat = value/100;
                            updateColor(satSlider);
                        }
                    }
                }
            }

            Row {
                spacing: frame.width - lightLabel.width - lightSlider.width - units.gu(1)
                Label {
                    id: lightLabel
                    text: "Lightness:"
                    anchors.verticalCenter: lightSlider.verticalCenter
                }

                Slider {
                    id: lightSlider
                    width: units.gu(25)
                    minimumValue: 0
                    maximumValue: 100
                    live: true

                    onValueChanged: {
                        if(changedByUser) {
                            colLight = value/100;
                            updateColor(lightSlider);
                        }
                    }
                }
            }

            Row {
                spacing: units.gu(1)

                UbuntuShape {
                    id: colorOut
                    width: controls.width - colorHex.width - parent.spacing
                    height: units.gu(5)
                    color: Qt.rgba(r,g,b,100)
                }

                TextField {
                    id: colorHex

                    anchors.verticalCenter: colorOut.verticalCenter
                    height: colorOut.height
                    width: units.gu(15)
                    validator: RegExpValidator { regExp: /[0-9a-fx#]*/i }
                    maximumLength: 8

                    onAccepted: {
                        var textVal = text.replace("#","").toLowerCase();
                        if(textVal.indexOf("x") != -1) textVal = textVal.substring(textVal.indexOf("x")+1);
                        if(textVal.length == 3) {
                            text = textVal.charAt(0)+textVal.charAt(0)+textVal.charAt(1)+textVal.charAt(1)+textVal.charAt(2)+textVal.charAt(2);
                        }
                    }

                    onTextChanged: {
                        if(changedByUser) {
                            var textVal = text.replace("#","").toLowerCase();
                            if(textVal.indexOf("x") != -1) textVal = textVal.substring(textVal.indexOf("x")+1);
                            if(textVal.length == 3 || textVal.length == 6) {
                                var newRgb = PaintColorUtils.hexToColor(textVal,textVal.length == 3);
                                var newHsl = PaintColorUtils.rgbToHsl(newRgb.hexR,newRgb.hexG,newRgb.hexB);
                                colHue = newHsl.rgbHue;
                                colSat = newHsl.rgbSat;
                                colLight = newHsl.rgbLight;
                                updateColor(colorHex);
                            }
                        }
                    }
                }
            }
        }
    }
}
