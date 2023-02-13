import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls 2.15


Window {
    id: rootWindow
    width: 1200
    height: 1000
    visible: true
    title: qsTr("REST Client")

    property string selDate: ""
    Column {
        anchors.fill: parent
        anchors.leftMargin: 10
        spacing: 10
        Row {
            Button {
                id: buttonId
                text: "Get APOD"
                onClicked: {
                    // send get request
                    restClient.createGetRequest("https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY" + "&date=" + selDate);
                }
            }
            Button {
                id: dateSelector
                text: "Select Date"
                onClicked: {
                    callDialog.visible = true
                }
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter

                text: selDate
                font.pointSize: 10
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
    Calendar {
        id: callDialog
        visible: false
        anchors.top: parent.top
        anchors.topMargin: 40
        onSelectedDateChanged: {
            var locale = Qt.locale()
            selDate = selectedDate.toLocaleDateString(locale,"yyyy-MM-dd")
            visible = false
        }
    }
}
