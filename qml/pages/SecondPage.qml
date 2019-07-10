import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Pickers 1.0
import harbour.MyPdfReader.pdf 1.0

Page {
    id: pageTwo

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill:parent

        PDFLoader {
            id: pdfLoader
            anchors.fill:parent

            onSendErrorTextToQml: {
                console.log(errorMessage)
            }
        }

        VerticalScrollDecorator {}

        Row {
            id:row
            spacing:Theme.paddingLarge

            anchors.horizontalCenter: parent.Center
            anchors.bottom: parent.bottom

            //добавить элемент Button с названием "Previous" для переключения на предыдущую старницу документа
            Button {
                id: previous
                text: qsTr("Previous")

                onClicked: {
                    pdfLoader.drawPreviousPage()
                    currentPage.text = pdfLoader.currentPage
                    file.page = pdfLoader.currentPage
                }
            }

            //добавить элемент Label для отображения текущей страницы документа
            Label {
                id: currentPage
            }

            // добавить элемент Button с названием "Next" для переключения на следующую страницу документа
            Button {
                id: next
                text: qsTr("Next")

                onClicked: {
                    pdfLoader.drawNextPage()
                    currentPage.text = pdfLoader.currentPage
                    file.page = pdfLoader.currentPage
                }
            }
         }
     }

    //Загрузка документа с помощью класса PDFLoader

     Component.onCompleted: {
         pdfLoader.loadPDF(file.selectedFile);
         currentPage.text = pdfLoader.currentPage
         file.page = pdfLoader.currentPage
         file.openedFile = file.selectedFile
     }

     Component.onDestruction: {
         file.openedFile = ""
         file.page = 0
     }
}

