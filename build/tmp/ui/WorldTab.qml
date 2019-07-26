import QtQuick 2.9
import Ubuntu.Components 1.3
import "../components"

Tab {
    title: i18n.tr("Draw")
    
    page: Page {
      


        Grid{
            anchors.centerIn: parent
            id: mainLayout
            columns: 2
            rows: 1
            columnSpacing: units.gu(1)

            DrawingFrame{
                id: canvasBorder
                width: units.gu(25)
                height: units.gu(45)
                DrawingSheet{
                    id: mainCanvas
                    DrawingMouse{
                        id: mouse
                    }
                }
            }

            Column{
                spacing: units.gu(1)

                BasicDrawTool{
                    id: square1
                }

                UbuntuShape{
                    id: square2
                    width: units.gu(5)
                    height: units.gu(5)
                    color: "white"


                    MouseArea{
                        id: myMouse2
                        anchors.fill: parent
                        state: "unselected"

                        onClicked: {
                            state = "selected"
                            myMouse1.state = "unselected"
                        }


                        states: [
                            State {
                                name: "selected"
                                PropertyChanges {

                                    target: mainCanvas
                                    onPaint: {
                                        if (mouse.isPressed) {
                                            console.log("Paint request accepted");
                                            var ctx = mainCanvas.getContext('2d');

                                            var mx = mouse.mouseX;
                                            var my = mouse.mouseY;

                                            //Check that a line has already been drawn
                                            if (mxBuffer != -1 && mxBuffer != -1) {
                                                ctx.beginPath();
                                                ctx.moveTo(mxBuffer, myBuffer);
                                                ctx.lineTo(mx, my);
                                                ctx.lineCap = "round"


                                                ctx.lineWidth = mainCanvas.lineWidth+5;
                                                ctx.strokeStyle = "red";


                                                //ctx.fill();
                                                ctx.stroke();
                                                console.log("onPaint triggered");
                                                mxBuffer = mx;
                                                myBuffer = my;
                                            }
                                            else {
                                                mxBuffer = mx;
                                                myBuffer = my;
                                            }
                                        }

                                        else {
                                            console.log("Paint request rejected");
                                        }
                                    }
                                }
                                PropertyChanges {
                                    target: square2
                                    color: "yellow"

                                }

                            },
                            State {
                                name: "unselected"
                                PropertyChanges {
                                    target: square2
                                    color: "gray"

                                }
                            }
                        ]


                    }


                }

                UbuntuShape{
                    width: units.gu(5)
                    height: units.gu(5)
                    color: "white"
                }

                UbuntuShape{
                    width: units.gu(5)
                    height: units.gu(5)
                    color: "white"
                }
            }

        }


    }
}
