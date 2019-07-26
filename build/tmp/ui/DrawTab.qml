import QtQuick 2.9
import Ubuntu.Components 1.3

import "../components"

Tab {
    title: i18n.tr("Draw")

    page: Page {
    

        /*
           ### Creates a Grid ###

          *----------*-----------*
          | canvas   |*---------*|
          | border   ||#ToolBox#||
          |*-------* ||         ||
          ||main   | || *tool1  ||
          ||canvas | || *tool2..||
          |*-------* |*---------*|
          *----------*-----------*



          */
        Grid{
            anchors.centerIn: parent
            id: mainLayout
            columns: 2
            rows: 1
            columnSpacing: units.gu(1)

            DrawingFrame{
                id: canvasBorder
                width: units.gu(30)
                height: units.gu(60)
                DrawingSheet{
                    id: mainCanvas
                    DrawingMouse{
                        id: mouse
                    }
                }
            }





            ToolBox{
                id: tools
                height: canvasBorder.height
                width: units.gu(8)

                //This works but should be changed in future
                //cause it's not nice
                //Should unselect all the tools
                onUnsetToolsChanged: {
                    if (unsetTools == true) {
                        tool1.state = "unselected"
                        tool2.state = "unselected"
                        tool3.state = "unselected"
                        tool4.state = "unselected"

                        unsetTools = false
                    }
                }


                Column{
                    id: toolList
                    spacing: units.gu(1)
                    x: x + units.dp(5)
                    y: y + units.dp(3)


                    PencilTool{
                        id: tool1
                        state: "selected"
                    }


                    BrushTool{
                        id: tool2
                        state: "unselected"
                    }

                    FingerTool{
                        id: tool3
                        state: "unselected"
                    }

                    RubberTool{
                        id: tool4
                        state: "unselected"
                    }

                    UbuntuShape{
                        color: "gray"

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {

                                if(mainCanvas.save("/home/fabio/myDraw.png")) {
                                console.log("Saved!")
                                }
                            }
                        }
                    }


                }

            }


        }
        // End of Grid "mainLayout"
    }
}
