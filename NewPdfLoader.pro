# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = NewPdfLoader

CONFIG += sailfishapp

SOURCES += src/NewPdfLoader.cpp \
    src/PdfLoader.cpp

DISTFILES += qml/NewPdfLoader.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/NewPdfLoader.changes.in \
    rpm/NewPdfLoader.changes.run.in \
    rpm/NewPdfLoader.spec \
    rpm/NewPdfLoader.yaml \
    translations/*.ts \
    NewPdfLoader.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/NewPdfLoader-de.ts

HEADERS += \
    src/PdfLoader.h

#INCLUDEPATH +=c:/SailfishOS/mersdk/targets/SailfishOS-2.2.0.29-i486/usr/include/poppler/qt5

LIBS +=-L isystem/usr/lib -lpoppler-qt5

INCLUDEPATH +=-isystem /usr/include/poppler/qt5

DEPENDPATH += c:/SailfishOS/mersdk/targets/SailfishOS-2.2.0.29-i486/usr/include/poppler/qt5
