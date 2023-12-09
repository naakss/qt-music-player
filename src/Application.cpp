#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include <QDebug>

#include "Application.h"

Application::Application(int &argc, char **argv) : QApplication(argc, argv)
{
    m_engine = new QQmlApplicationEngine(this);

    QCoreApplication::setApplicationName("Music Player");
    QCoreApplication::setApplicationVersion("1.0.0");

    m_engine->addImportPath("qrc:/qml");
    m_engine->rootContext()->setContextProperty("app", this);
    m_engine->load(QStringLiteral("qrc:/qml/main.qml"));
}

Application::~Application()
{
    delete m_engine;
}

bool Application::init()
{
    return true;
}

QString Application::songsPath()
{
    QDir dir;
    return dir.currentPath() + "/songs";
}

QString Application::audioSource() const
{
    return m_audioSource;
}

void Application::setAudioSource(const QString &newAudioSource)
{
    if (m_audioSource == newAudioSource)
        return;

    m_audioSource = newAudioSource;
    emit audioSourceChanged();
}

QString Application::audioName() const
{
    return m_audioName;
}

void Application::setAudioName(const QString &newAudioName)
{
    if (m_audioName == newAudioName)
        return;

    m_audioName = newAudioName;
    emit audioNameChanged();
}
