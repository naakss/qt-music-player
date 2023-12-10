QT += core widgets quick multimedia qml

QML_IMPORT_PATH += $$PWD/resources/qml

SOURCES += \
        src/Application.cpp \
        src/main.cpp

HEADERS += \
    src/Application.h

RESOURCES += resources/qml.qrc \
    resources/fonts.qrc

# Copy songs directory to build directory
songFiles.commands = $(COPY_DIR) $$PWD/songs $$OUT_PWD/songs
songFiles.target = copy_songs_folder
QMAKE_EXTRA_TARGETS += songFiles
PRE_TARGETDEPS += copy_songs_folder

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
