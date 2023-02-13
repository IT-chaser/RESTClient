import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15


Window {
    id: rootWindow
    width: 1200
    height: 1000
    visible: true
    title: qsTr("REST Client")

    Column {
        anchors.fill: parent
        anchors.leftMargin: 10
        spacing: 10
        Button {
            id: buttonId
            text: "Get APOD"
            onClicked: {
                // send get request
                restClient.createGetRequest("https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")
            }
        }
        Text {
            text: "Response"
            font.pointSize: 10
        }
        Rectangle {
            width: rootWindow.width * 0.6
            height: rootWindow.height * 0.2
            border.color: "green"

            ScrollView {
                anchors.fill: parent
                TextArea {
                    id: responseText
                    text: restClient.responseText
                    font.pointSize: 10
                    wrapMode: TextEdit.WordWrap
                }
            }
        }
        Text {
            text: "Image"
            font.pointSize: 10
        }
        Rectangle {
            width: rootWindow.width * 0.6
            height: rootWindow.height * 0.4
            border.color: "black"
            Image {
                anchors.fill: parent
                source: restClient.imageUrl
            }
        }
    }
}
