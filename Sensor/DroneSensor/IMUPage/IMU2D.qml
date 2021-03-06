﻿import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: imu2dpage

    width: 400
    height: 400

//    function setimuBearing(headingIn)
//    {
//        imu2dimage.angle = headingIn
//    }

    Image {
        id: imu2dimage

        x: 175
        y: 175
        width: 50
        height: 50

        source: "../../../Component/qipao.png"

        transform: Rotation {
            id: imuRotation
            angle: 0
            origin.x: imu2dimage.width / 2; origin.y: imu2dimage.height / 2;
//                Behavior on angle {
//                    SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
////                    SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
//                }
        }
    }

    Text {
        id: element2
        x: 207
        y: 362
        text: qsTr("横滚角：")
        font.pixelSize: 30
    }

    Text {
        id: rolltext
        x: 317
        y: 362
        text: qsTr("0°")
        font.pixelSize: 30
    }

    Text {
        id: element
        x: 15
        y: 362
        text: qsTr("俯仰角：")
        font.pixelSize: 30
    }

    Text {
        id: pitchtext
        x: 124
        y: 362
        text: qsTr("0°")
        font.pixelSize: 30
    }

    Timer{
        interval: 100
        repeat: true
        triggeredOnStart: false
        running: true

        onTriggered: {
            imu2dimage.x = 175 + myclassExposeByRegType.getOffsetX();
            imu2dimage.y = 175 + myclassExposeByRegType.getOffsetY();
            pitchtext.text = myclassExposeByRegType.getAnglePitch();
            rolltext.text = myclassExposeByRegType.getAngleRoll();
//            imuRotation.angle = myclassExposeByRegType.getAngleYaw();
//            console.log(myclassExposeByRegType.getOffsetX(), myclassExposeByRegType.getOffsetY());
        }
    }

}
