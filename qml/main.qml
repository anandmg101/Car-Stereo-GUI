import QtQuick 2.5
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import QtQuick.Window 2.2

Window {

    id: window
    visible: true
    title: qsTr("Car Stereo")
    visibility: Window.AutomaticVisibility
    width: Screen.width //640
    height: Screen.height //480
    flags: Qt.FramelessWindowHint
    x: Screen.top
    y: Screen.left

    FontLoader{id:openSansRegular; source:"qrc:/qml/fonts/OpenSans-Regular.ttf"}

    Rectangle {
        id: rectangle1
        color: "#000000"
        anchors.fill: parent
    }
    DashView{
        id: dashview
        anchors.fill: parent
    }
    Shortcut {
        sequence: "F11"
        onActivated: {
            if(window.visibility == Window.FullScreen)
                window.visibility = Window.Windowed
            else if(window.visibility == Window.Windowed)
                window.visibility = Window.Maximized
            else
                window.visibility = Window.FullScreen
        }
    }
}
