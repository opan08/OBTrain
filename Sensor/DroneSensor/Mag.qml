﻿import QtQuick 2.9
import QtQuick.Controls 2.2

import QtMultimedia 5.4

import ".."
import "../../Component"
//import "./PresentPage"
import "./MagPage"
import "./UartData"

import RegisterMyType 1.0
import RegisterSystemOpen 1.0



Page {

    property StackView stack: null
    width: 1920
    height: 1080

    background: Image {
        source: "../../images/background.png"
    }

    Button {
        height: 32
        width: 120
        text: "<-"
        anchors.left: parent.left
        anchors.top: parent.top
        onClicked: {
            if(true === myclassExposeByRegType.getserialOpenFlag()){
                //myclassExposeByRegType.closePort();
                qmlToggleButton.toggleRight();
//                qmlToggleButton.state = "right";
//                qmlToggleButton.color = "#CCCCCC";

            }
            stack.pop()
        }
    }

    ComboBox {
        id: comboBox
        objectName: "portComboBox"
        x: 146
        y: 48
        font.bold: true
        font.pointSize: 20

        model:comboModel.comboList
//        model: portlistmodel

//        pressed: true
//        down: true

//        MouseArea{
//            onPressed: {
//                console.info("aa");
//                myclassExposeByRegType.getPortInfo();
//                comboModel.setComboList(myclassExposeByRegType.receivePort());
//            }
//        }
//        onActivated: {
//            console.info("aa");
//        }

    }

    QmlToggleButton{
        id: qmlToggleButton
        anchors.centerIn: parent
        height: 40
        radius: 20
        border.width: 1
        anchors.verticalCenterOffset: -472
        anchors.horizontalCenterOffset: -614
        width: 106
//        leftString: qsTr("打开")
//        rightString: qsTr("关闭")

//        onToggleLeft: label.text = qmlToggleButton.leftString
//        onToggleRight: label.text = qmlToggleButton.rightString
//        onToggleLeft: {
//            timerSend.start();
//        }

//        onToggleRight: {
//            timerSend.stop();
//        }


    }

    Button {
        id: button7
        x: 437
        y: 48
        text: qsTr("配置无线地址")
        font.bold: true
        font.pointSize: 20

        onClicked:
        {
            rfsetpage.show();
        }
    }


    MyClassType
    {
        id:myclassExposeByRegType
    }




    Button {
        id: button1
        x: 653
        y: 50
        text: qsTr("教学资料")
        font.bold: true
        font.pointSize: 20

        onClicked:
        {
            maginfopage.show();
        }
    }


    Button {
        id: button2
        x: 821
        y: 48
        text: qsTr("工程实例")
        font.bold: true
        font.pointSize: 20

        onClicked:
        {
            magprojectdeveloppage.active;
            magprojectdeveloppage.show();
        }
    }

    Connections {
        target: qmlToggleButton
        onToggleRight: {
            myclassExposeByRegType.closePort();

        }

    }

    Connections {
        target: qmlToggleButton
        onToggleLeft: {
            var portName;
            var keys = Object.keys(comboBox);
            for(var i = 0; i < keys.length; i++) {
                var key = keys[i];

                if (key === "currentIndex") {
//                    console.log("key FOUND:" + comboBox[key]);
                    portName = comboModel.getElement(comboBox[key]);

                    break;
                }
            }
            myclassExposeByRegType.openAndSetPort(portName,3,3,0,0,0);

        }
    }


    CompassUi
    {
        id: compassui
        x: 146
        y: 155
        width: 400
        height: 400
    }


    MagCharViewPage
    {
        id:magcharview
        x:550
        y:155
        visible: true
    }

    Rectangle {
        x:1262
        y:570
        width: 402
        height: 400
        color: "#00000000"
        border.width: 1

        DataBasicRecAndSendPage{
            id:magbasicrecandsendpage
            x:2
            y:2
            width: 400
            height: 400
        }
    }


    Rectangle {
        x:1263
        y:130
        width: 402
        height: 400
        color: "#00000000"
        border.width: 1

        MagDataApplicatePage{
            id:magdataapplicatepage
            x:2
            y:2
            width: 400
            height: 400
        }
    }

    MagControlPage{
        id:magcongrolPage

        x:146
        y:595
        width: 400
        height: 400
    }


    Component.onCompleted: {

//        myclassExposeByRegType.setMagCornerStr("0° 北")
        myclassExposeByRegType.getPortInfo();
        comboModel.setComboList(myclassExposeByRegType.receivePort());
//        portlistmodel.append({"portnam" : "hello"});
//        portlistmodel.append({"portnam" : "hel2lo"});
//        portlistmodel.append("zark");

    }


    MagDataPage{
        id:magdatapage
    }

    MagInfoPage{
        id:maginfopage
    }

    RFSetPage{
        id:rfsetpage
    }

    MagProjectDevelopPage{
        id:magprojectdeveloppage
    }

}
