import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Label {
        id: selectedFile
        anchors.centerIn: parent
        wrapMode: Text.Wrap
        width: parent.width
        text: file.selectedFile
    }

    Label {
        id: page
        anchors.top: selectedFile.bottom
        text: file.page
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-next"
        }

        CoverAction {
            iconSource: "image://theme/icon-cover-pause"
        }
    }
}
