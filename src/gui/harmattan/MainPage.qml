import QtQuick 1.1
import com.meego 1.0
import com.nokia.extras 1.0
import "components" as MyComponents
import Fahrplan 1.0 as Fahrplan

Page {
    id: mainPage

    tools: mainToolbar

    MyComponents.TitleBar {
        id: titleBar
        titleText: "Fahrplan"
        width: parent.width * 2
        opacity: 0.9
    }

    ButtonColumn {
        id: buttons

        anchors {
            topMargin: 20
            top: titleBar.bottom
            leftMargin: 10
            rightMargin: 10
            left: parent.left
        }

        width: parent.width - 20
        exclusive: false

        MyComponents.SubTitleButton {
            id: departureButton
            titleText: "Departure Station"
            subTitleText: "please select"
            width: parent.width
            onClicked: {
                pageStack.push(departureStationSelect)
            }
        }
        MyComponents.SubTitleButton {
            id: arrivalButton
            titleText: "Arrival Station"
            subTitleText: "please select"
            width: parent.width
            onClicked: {
                pageStack.push(arrivalStationSelect)
            }
        }
        MyComponents.SubTitleButton {
            id: datePickerButton
            titleText: "Date"
            subTitleText: "please select"
            width: parent.width
            onClicked: {
                var d = new Date();
                datePicker.year = d.getFullYear();
                datePicker.month = d.getMonth() + 1; // month is 0 based in Date()
                datePicker.day = d.getDate();
                datePicker.open();
            }
        }
        MyComponents.SubTitleButton {
            id: timePickerButton
            titleText: "Time"
            subTitleText: "please select"
            width: parent.width
            onClicked: {
                var d = new Date();
                timePicker.hour = d.getHours();
                timePicker.minute = d.getMinutes();
                timePicker.second = d.getSeconds();
                timePicker.open();
            }
        }
    }

    Button {
        id: startSearch
        text: "Start search"
        anchors {
            top: buttons.bottom
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }

        onClicked: {
            console.log("Searching")
            pageStack.push(loadingPage)
            var selDate = new Date(datePicker.year, datePicker.month - 1, datePicker.day);
            var selTime = new Date(1970, 2, 1, timePicker.hour, timePicker.minute, timePicker.second);
            fahrplanBackend.parser.searchJourney(departureButton.subTitleText, arrivalButton.subTitleText, "", selDate, selTime, 0, 0);
        }
    }

    MyComponents.StationSelect {
        id: departureStationSelect

        onStationSelected: {
            departureButton.subTitleText = name;
            pageStack.pop();
        }
    }

    MyComponents.StationSelect {
        id: arrivalStationSelect

        onStationSelected: {
            arrivalButton.subTitleText = name;
            pageStack.pop();
        }
    }

    JourneyResultsPage {
        id: resultsPage
    }

    LoadingPage {
        id: loadingPage
    }

    DatePickerDialog {
        id: datePicker
        titleText: "Date"
        acceptButtonText: "Ok"
        rejectButtonText: "Cancel"
        onAccepted: {
            var selDate = new Date(datePicker.year, datePicker.month - 1, datePicker.day);
            datePickerButton.subTitleText = Qt.formatDate(selDate);
        }
    }

    TimePickerDialog {
        id: timePicker
        titleText: "Time"
        acceptButtonText: "Ok"
        rejectButtonText: "Cancel"
        onAccepted: {
            var selTime = new Date(1970, 2, 1, timePicker.hour, timePicker.minute, timePicker.second);
            timePickerButton.subTitleText = Qt.formatTime(selTime);
        }
    }

    ToolBarLayout {
        id: mainToolbar
    }

    InfoBanner{
            id: banner
            objectName: "fahrplanInfoBanner"
            text: ""
            anchors.top: button.bottom
            anchors.topMargin: 10
    }

    Fahrplan.Backend {
        id: fahrplanBackend
        onParserJourneyResult: {
            if (result.count > 0) {
                pageStack.push(resultsPage);
            } else {
                pageStack.pop();
                banner.text = "No results found";
                banner.show();
            }

        }
    }
}
