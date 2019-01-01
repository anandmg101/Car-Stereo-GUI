import QtQuick 2.6
import QtQuick.Layouts 1.0

Item {
    id: rightMenu
    signal itemChanged(int index);
    function menuItemClicked (index){
        active_button_bg.x = menuItemsRepeater.itemAt(index).x;
        rightMenu.itemChanged(index);
    }

    Rectangle {
        color: "#212121"
        anchors.fill: parent
        opacity: 0.4
    }

    Rectangle {
        id: active_button_bg
        width: (parent.width/menuItems.length)+5
        color: "#80ffffff"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        Layout.columnSpan: 0
        Layout.rowSpan: 0
        border.width: 0

        Behavior on x {

            NumberAnimation {
                //This specifies how long the animation takes
                duration: 600
                //This selects an easing curve to interpolate with, the default is Easing.Linear
                easing.type: Easing.OutBounce
            }
        }

    }
//starting changes from here
    RowLayout {
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        spacing: 5
        anchors.fill: parent

        Repeater{
            id:menuItemsRepeater
            model:menuItems.length
            Rectangle {
                color:menuItems[index].color
                Layout.fillHeight: true
                Layout.rowSpan: 1
                Layout.fillWidth: true

                Image {
                    id: ac_image
                    width: 30
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    fillMode: Image.PreserveAspectFit
                    source: menuItems[index].image
                    mipmap:true
                }

                Text {
                    id: text1
                    color: "#ffffff"
                    text: {
                        if(defaultMenuItem == index)
                            rightMenu.menuItemClicked(index);
                        menuItems[index].text;
                    }
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: ac_image.right
                    anchors.leftMargin: 0
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    font.family: openSansRegular.name
                }

                MouseArea {
                    id: mouseArea1
                    anchors.fill: parent
                    onClicked: menuItemClicked(index)
                }
            }
        }
    }
}
