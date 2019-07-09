#ifndef PDFLOADER_H
#define PDFLOADER_H

#include <QObject>
#include <QString>
#include <QImage>
#include <QQuickPaintedItem>
#include <QPainter>
#include <poppler-qt5.h>
#include <QSize>

/*!
 * \brief The PDFLoader class loads the .pdf document using Poppler and displays its pages.
 */
class PDFLoader: public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(int currentPage READ currentPage NOTIFY currentPageChanged)
    Q_PROPERTY(int pdfResolution READ pdfResolution WRITE setPDFResolution NOTIFY pdfResolutionChanged)

private:
    /*!
     * \brief The .pdf document
     */
    Poppler::Document* document=0;

    /*!
     * \brief The displayed .pdf page
     */
    Poppler::Page* pdfPage=0;

    /*!
     * \brief The image with the displayed .pdf page
     */
    QImage image;

    /*!
     * \brief The number of the displayed page in the .pdf file (starts with 1)
     */
    int currentPageNumber;

    /*!
     * \brief The resolution of the graphics device for rendering the .pdf page, in dots per inch
     */
    int resolution;

    void drawPageByNumber(int pageNumber);

public:
    PDFLoader(QQuickItem *parent = 0);
    ~PDFLoader();

    void paint(QPainter *painter);
    Q_INVOKABLE void loadPDF(QString filename);
    Q_INVOKABLE void drawPreviousPage();
    Q_INVOKABLE void drawNextPage();

    // The getter for the property
    int currentPage() const;
    int pdfResolution() const;

    void setPDFResolution(int pdfResolution);

signals:
    void currentPageChanged(int);
    void sendErrorTextToQml(QString errorMessage);
    void pdfResolutionChanged(int);
};

#endif // PDFLOADER_H
