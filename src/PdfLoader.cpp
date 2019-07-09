#include "PdfLoader.h"

#include <QDebug>

/*!
 * \brief Initialize the number of document pages as 0 and set the intital resolution for .pdf page
 * \param parent The parent QQuickItem instance
 */
PDFLoader::PDFLoader(QQuickItem *parent)  :
    QQuickPaintedItem(parent) {
    currentPageNumber = 0;
    resolution = 200;
}

/*!
 * \brief Clean fields
 */
PDFLoader::~PDFLoader() {
    if (pdfPage)
        delete pdfPage;
    if (document)
        delete document;
}

/*!
 * \brief Load the .pdf and display its first page
 * \param filename the name and the path to the .pdf file
 */
void PDFLoader::loadPDF(QString filename) {
    if (pdfPage)
        delete pdfPage;
    if (document)
        delete document;
    document = Poppler::Document::load(filename);
    if (!document || document->isLocked()) {
        emit sendErrorTextToQml("The document can not be loaded");
        return;
    }
    document->setRenderHint(Poppler::Document::TextAntialiasing);
    document->setRenderHint(Poppler::Document::Antialiasing);
    document->setRenderHint(Poppler::Document::TextHinting);
    drawPageByNumber(0);
    currentPageNumber = 1;
    emit currentPageChanged(currentPageNumber);
}

/*!
 * \brief Draw the image with the current page
 * \param painter The painter performs drawing
 */
void PDFLoader::paint(QPainter *painter) {
    if (!image.isNull()) {
        QRectF r(0,0, image.width(), image.height());
        painter->drawImage(r, image);
    }
}

/*!
 * \brief Display the page with the given number. If there is no page with this number, the displayed page will not be changed
 * \param pageNumber The number of the page to be displayed
 */
void PDFLoader::drawPageByNumber(int pageNumber) {
    if (pageNumber >= document->numPages() || pageNumber < 0)
        return;
    pdfPage = document->page(pageNumber);
    if (pdfPage == 0) {
      emit sendErrorTextToQml("No pages in the document");
      return;
    }
    image = pdfPage->renderToImage(resolution, resolution);
    image = image.scaled(width(), height(), Qt::KeepAspectRatio);
    if (image.isNull()) {
      emit sendErrorTextToQml("The page can not be displayed");
      return;
    }
    update();
}

/*!
 * \brief Display the previous page if it exists
 */
void PDFLoader::drawPreviousPage() {
    if (!image.isNull() && currentPageNumber > 1) {
        currentPageNumber--;
        drawPageByNumber(currentPageNumber - 1);
        emit currentPageChanged(currentPageNumber);
    }
}

/*!
 * \brief Display the next page if it exists
 */
void PDFLoader::drawNextPage() {
    if (!image.isNull() && currentPageNumber < document->numPages()) {
        currentPageNumber++;
        drawPageByNumber(currentPageNumber - 1);
        emit currentPageChanged(currentPageNumber);
    }
}

/*!
 * \return The number of the displayed page
 */
int PDFLoader::currentPage() const {
    return currentPageNumber;
}

/*!
 * \return the resolution for .pdf page
 */
int PDFLoader::pdfResolution() const {
    return resolution;
}

/*!
 * \brief Set the resolution for .pdf page
 * \param res resolution
 */
void PDFLoader::setPDFResolution(int res) {
    if (res < 0)
        return;
    this->resolution = res;
}
