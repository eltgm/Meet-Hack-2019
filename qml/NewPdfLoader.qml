import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Pickers 1.0
import "pages"

ApplicationWindow
{
    initialPage: Component {FirstPage { }}
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

    Item {
        id: file
        property string selectedFile
        property int page
    }
}
