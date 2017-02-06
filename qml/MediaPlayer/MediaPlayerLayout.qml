import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtMultimedia 5.7
import QtQuick.Dialogs 1.0
import "../theme"

Item {
    id: __media_player_layout
    function getReadableTime(milliseconds){
        var minutes = Math.floor(milliseconds / 60000);
        var seconds = ((milliseconds % 60000) / 1000).toFixed(0);
        return (seconds == 60 ? (minutes+1) + ":00" : minutes + ":" + (seconds < 10 ? "0" : "") + seconds);
    }
    property bool isBase: false
    function changeState(caller){
        if(__media_player_layout.state == "" && caller == "button"){
            __media_player_layout.state="drawer";
            top_menu.menuButtonActive = true;
            isBase = false;
        } else if(caller == "button"){
            __media_player_layout.state="";
            top_menu.menuButtonActive = false;
            isBase = false;
        } else if(caller == "toList"){
            __media_player_layout.state="media list";
        } else if(caller == "toContainer"){
            __media_player_layout.state="container list";
        }
    }
    Item {
        id: main
        anchors.top: top_menu.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0


        Item {
            id: wrapper
            anchors.rightMargin: 15
            anchors.leftMargin: 15
            anchors.bottomMargin: 15
            anchors.topMargin: 15
            anchors.fill: parent

            Item {
                id: slider_wrapper
                height: parent.height * 0.2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0

                Slider {
                    id: sliderHorizontal1
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    value: mediaplayer.position
                    maximumValue: mediaplayer.duration
                    stepSize: 1
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    onValueChanged: {
                        if(value != mediaplayer.position){
                            mediaplayer.seek(value)
                        }
                    }
                }

                Text {
                    id: text1
                    text: getReadableTime(mediaplayer.position)
                    anchors.top: sliderHorizontal1.bottom
                    anchors.topMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    font.pixelSize: 12
                }

                Text {
                    id: text2
                    text: getReadableTime(mediaplayer.duration)
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.top: sliderHorizontal1.bottom
                    font.pixelSize: 12
                    anchors.topMargin: 0
                }
            }

            RowLayout {
                id: buttons
                height: parent.height * 0.2
                anchors.bottom: slider_wrapper.top
                anchors.bottomMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.left: parent.left
                anchors.leftMargin: 8

                Image {
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    source: "qrc:/qml/icons/shuffle.png"

                    MouseArea {
                        id: mouseArea4
                        anchors.fill: parent
                        onClicked: nowPlaying.shuffle()
                    }
                }

                Image {
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    source: "qrc:/qml/icons/skip-backward.png"

                    MouseArea {
                        id: mouseArea2
                        anchors.fill: parent
                        onClicked: mediaplayer.playlist.previous()
                    }
                }

                Image {
                    id:playButton
                    width: 100
                    height: 100
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    source: "qrc:/qml/icons/play.png"
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        onClicked:{
                            switch (mediaplayer.playbackState){
                            case MediaPlayer.PlayingState:
                                mediaplayer.pause()
                                break;
                            case MediaPlayer.PausedState:
                            case MediaPlayer.StoppedState:
                                mediaplayer.play()
                                break;
                            }
                        }
                    }
                }

                Image {
                    width: 100
                    height: 100
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    source: "qrc:/qml/icons/skip-forward.png"
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        id: mouseArea1
                        anchors.fill: parent
                        onClicked: mediaplayer.playlist.next()
                    }
                }

                Image {
                    width: 100
                    height: 100
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    source: "qrc:/qml/icons/refresh.png"
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        id: mouseArea3
                        anchors.fill: parent
                        onClicked: mediaplayer.loops = MediaPlayer.Infinite
                    }
                }

            }

            Item {
                id: track_info
                height: parent.height * 0.4
                anchors.bottom: buttons.top
                anchors.bottomMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.left: parent.left
                anchors.leftMargin: 8

                Text {
                    id: media_title
                    text: mediaplayer.metaData.title?mediaplayer.metaData.title:""
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 24
                }

                Text {
                    id: media_author
                    x: 127
                    y: -129
                    text:mediaplayer.getArtist(mediaplayer.metaData)
                    anchors.top: media_title.bottom
                    anchors.topMargin: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 16
                }

                Text {
                    id: media_album_title
                    x: 39
                    y: -108
                    text: mediaplayer.metaData.albumTitle?mediaplayer.metaData.albumTitle:""
                    anchors.top: media_author.bottom
                    anchors.topMargin: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 16
                }


            }

            Image {
                id: image1
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.bottom: track_info.top
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 8
                source: typeof(mediaplayer.metaData.coverArtUrlLarge) != "undefined"?mediaplayer.metaData.coverArtUrlLarge:""
            }
        }

        Rectangle {
            id: overlay
            color: "#00000000"
            z: 10
            anchors.topMargin: 0
            visible: false
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            opacity: 0.5
        }
    }

    Playlist{
        id: nowPlaying
    }

    MediaPlayer {
        id: mediaplayer
        source: "file:///media/gino/Gino HDD/music/Trap/VA_-_All_Trap_Music_Vol_3-WEB-2014-BiLDERBERG/14-massappeals_-_im_good.mp3"
        playlist: nowPlaying
        onPaused: {
            playButton.source = "qrc:/qml/icons/play.png";
        }
        onStopped: {
            playButton.source = "qrc:/qml/icons/play.png";
        }
        onPlaying: {
            playButton.source = "qrc:/qml/icons/pause.png";
        }
        function getArtist(){
            var m = metaData;
            return m.contributingArtist?m.contributingArtist:
                                         m.contributingArtist?m.leadPerformer:
                                                               m.contributingArtist?m.albumArtist:
                                                                                     m.contributingArtist?m.metaData.author:
                                                                                                           m.contributingArtist?m.writer:"";
        }
    }

    MediaList {
        id: mediaList
        width: parent.width * 0.7
        anchors.leftMargin: -1 * width
        opacity: 0
        anchors.top: top_menu.bottom
        anchors.topMargin: 0
        anchors.left: main.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        onItemClicked: {
            changeState("button");
            mediaplayer.playlist.clear();
            var itemToPlay = 0;
            for(var i=0; i<model.length; i++){
                if(model[i].playNow)
                    itemToPlay = i+1;
                mediaplayer.playlist.addItem("file://"+model[i].path + '/' + model[i].name );
            }
            //No function in QT to play a song with a given id so we skip to it
            for(var i=0; i<itemToPlay; i++){
                mediaplayer.playlist.next();
            }
            mediaplayer.play();
        }
        onBack: changeState("toContainer")
    }


    MediaContainerList {
        id: mediaContainerList
        width: parent.width * 0.7
        anchors.leftMargin: parent.width
        opacity: 0
        anchors.top: top_menu.bottom
        anchors.topMargin: 0
        anchors.left: main.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        onItemClicked: {
            changeState("toList");
            mediaList.model = mediaLibrary.audioFolderContent(id);
            mediaList.thumbnail = thumbnail;
            mediaList.title = name;
            mediaList.sub_title = path;
        }
    }


    MediaDrawer {
        id: mediaDrawer
        width: parent.width * 0.3
        top_margin: top_menu.height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: main.left
        anchors.rightMargin: 0
        onItemClicked: {
            switch(item_type){
            case "folders":
                mediaContainerList.model = mediaLibrary.audioFolders;
                break;
            case "playlists":
                mediaContainerList.model = mediaLibrary.playlists;
                break;
            default:
                mediaContainerList.model = 0;
                break;
            }
            mediaContainerList.icon = icon;
            mediaContainerList.name = name;
            mediaContainerList.item_type = item_type;
            __media_player_layout.changeState("toContainer")
        }
    }

    TopMenu{
        id: top_menu
        height: parent.height*0.10
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        onMenuClicked: changeState("button")
        bg_opacity: overlay.opacity
    }

    states: [
        State {
            name: "drawer"
            PropertyChanges {
                target: main
                anchors.topMargin: 0
                anchors.rightMargin: -1* parent.width * 0.3
                anchors.leftMargin: parent.width * 0.3
            }
        },
        State {
            name: "container list"

            PropertyChanges {
                target: main
                anchors.topMargin: 0
                anchors.rightMargin: -1* parent.width * 0.3
                anchors.leftMargin: parent.width * 0.3
            }

            PropertyChanges {
                target: overlay
                color: "#000000"
                opacity: 0.9
                visible: true
            }

            PropertyChanges {
                target: mediaContainerList
                anchors.leftMargin: 0
                opacity: 1
                visible: true
            }

            PropertyChanges {
                target: __media_player_layout
                clip: true
            }
        },
        State {
            name: "media list"
            PropertyChanges {
                target: main
                anchors.leftMargin: parent.width * 0.3
                anchors.rightMargin: -1* parent.width * 0.3
                anchors.topMargin: 0
            }

            PropertyChanges {
                target: overlay
                color: "#000000"
                opacity: 0.9
                visible: true
            }

            PropertyChanges {
                target: mediaContainerList
                opacity: 0.5
                visible: false
            }

            PropertyChanges {
                target: __media_player_layout
                clip: true
            }

            PropertyChanges {
                target: mediaList
                anchors.leftMargin: 0
                opacity: 1
                visible: true
            }
        }
    ]
    transitions:
        Transition {
        SequentialAnimation {
            NumberAnimation { properties: "anchors.leftMargin,anchors.rightMargin,opacity,width"; duration: 250}
            NumberAnimation { properties: "visible"; duration: 1}
        }
    }



}
