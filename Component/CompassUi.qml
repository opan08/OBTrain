import QtQuick 2.0
import QtQuick.Controls 2.2

import RegisterMyType 1.0

Item {
    id : compassui
    anchors.fill: parent

    property real heading

    function setBearing(headingIn)
    {
        heading = headingIn
        backRotation.angle = -heading
    }

    Item {
        //anchors.centerIn: parent
        anchors.fill: parent
        Image { id: background;
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "compass.svg";

            transform: Rotation {
                id: backRotation
                angle: 0
                origin.x: background.width / 2; origin.y: background.height / 2;
                Behavior on angle {
                    SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                }
            }
        }

    }

    Label {
        id: label
        x: 64
        y: 39
        width: 102
        height: 34
        font.pixelSize: 34
        text: qsTr("text")
    }
}
