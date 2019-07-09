import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Pickers 1.0

Page {
    id: pageOne

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill:parent

        // Добавить заголовок с названием приложения
        PageHeader {
            title: qsTr("PDF Loader")
        }

        Column {
            id: column
            spacing: Theme.paddingLarge
            x: Theme.horizontalPageMargin
            y: Theme.paddingMedium
            anchors.centerIn: parent

            //Добавить объект типа Label с текстом "Last file name:"
            Label {
                id : lastFileName
                x: Theme.horizontalPageMargin
                text: qsTr("Last file name")
            }

            // Добавить объект типа Label с названием последнего файла. Использовать свойство selectedFile элемента file.
            Label {
                id : selectedFileLabel
                wrapMode: Text.Wrap
                width: parent.width
                text : file.selectedFile
            }

            // Добавить объект типа FilePickerPage для загрузки страницы выбора файлов с расширением .pdf. При выборе файла в стек страниц загружается SecondPage.qml
            Component {
                id: filePickerPage
                FilePickerPage {
                    nameFilters: [ '*.pdf' ]
                    onSelectedContentPropertiesChanged: {
                        file.selectedFile = selectedContentProperties.filePath
                        //pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
                    }
                }
            }

            //Добавить объект типа Button. При нажатии на кнопку в стек страниц загружается FilePickerPage
            Button {
                id : loadFile
                text: "Choose file"
                onClicked: pageStack.push(filePickerPage)
            }
        }
    }
}
