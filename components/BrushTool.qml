import QtQuick 2.9
import Ubuntu.Components 1.3
import "../components"

BasicDrawTool{
    image: Image{
        source: "../graphics/brush.png"
        fillMode: Image.PreserveAspectCrop
    }

    states: [
        State {
            name: "selected"
            PropertyChanges {
                target: mainCanvas
                onPaint: {
                    if (mouse.isPressed) {
                        console.log("Paint request accepted from BrushTool");
                        var ctx = mainCanvas.getContext('2d');

                        var mx = mouse.mouseX;
                        var my = mouse.mouseY;

                        //Check that a line has already been drawn
                        if (mxBuffer != -1 && mxBuffer != -1) {
                            ctx.beginPath();
                            ctx.moveTo(mxBuffer, myBuffer);
                            ctx.lineTo(mx, my);
                            ctx.lineCap = "round"


                            ctx.lineWidth = mainCanvas.lineWidth*5;
                            ctx.strokeStyle = "lightblue";


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
                target: drawTool
                x: x + units.dp(2)

            }

        },
        State {
            name: "unselected"
            PropertyChanges {
                target: drawTool
                x: x - units.dp(2)

            }
        }
    ]



}


