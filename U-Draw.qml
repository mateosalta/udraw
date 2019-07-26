import QtQuick 2.9
import Ubuntu.Components 1.3

import "ui" // Import the "ui" folder
import "components"

/*!
    \brief MainView with Tabs element.
           First Tab has a single Label and
           second Tab has a single ToolbarAction.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    
    // Note! applicationName needs to match the .desktop filename 
    applicationName: "udraw.mateo-salta"
    
    /* 
     This property enables the application to change orientation 
     when the device is rotated. The default is false.
    */
   // automaticOrientation: true
    
    width: units.gu(40)
    height: units.gu(71)
    
    Tabs {
        id: tabs

        DrawTab {
            objectName: "Draw"
        }

        WorldTab {
            objectName: "worldTab"
        }

        Tab {
            title: "Color"
            page: Page {
                ColorPicker {
                    id: colorPicker
                }
            }
        }
    }
}
