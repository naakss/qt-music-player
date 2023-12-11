/***************************************************************************/
/*! \file       Application.cpp
 * \brief       The application class implementation
 *
 * \copyright   Copyright (c) 2023 Sagar Gurudas Nayak
 * \copyright   MIT License
 *
 * \remark      Email: sagargnayak26@gmail.com
 ***************************************************************************/

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

    QObject::connect(this, &Application::playlistMapChanged, [=]() {
        setPlaylistNames(m_playlistMap.keys());
    });
}

Application::~Application()
{
    delete m_engine;
}

bool Application::init()
{
    createDefaultPlaylists();
    return true;
}

QString Application::songsPath()
{
    QDir dir;
    return dir.currentPath() + "/songs/";
}

void Application::addSongToPlaylist(const QString &name, const QString &song)
{
    QStringList playlist = m_playlistMap.value(name);

    if (!playlist.contains(song)) {
        playlist << song;
        addPlaylist(name, playlist);
        emit showMessage("Song added!");
        return;
    }

    emit showMessage("Song already present in playlist!");
}

void Application::addPlaylist(const QString &name, QStringList list)
{
    m_playlistMap.insert(name, list);
    emit playlistMapChanged();
}

void Application::deletePlaylist(const QString &name)
{
    if (m_playlistMap.remove(name) == 1) {
        emit playlistMapChanged();
    }
}

void Application::onPlaylistSelected(const QString &name)
{
    m_selectedPlaylist = name;
    setPlaylistSongs(m_playlistMap.value(name));
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

void Application::createDefaultPlaylists()
{
    QStringList playlist1;
    playlist1 << (songsPath() + "Electronic-rock-king.mp3");
    playlist1 << (songsPath() + "Jazzy-abstract-beat.mp3");
    playlist1 << (songsPath() + "Forest-lullaby.mp3");
    playlist1 << (songsPath() + "Lofi-study.mp3");
    playlist1 << (songsPath() + "Chill-abstract-intention.mp3");
    addPlaylist("MyPlaylist", playlist1);

    QStringList playlist2;
    playlist2 << (songsPath() + "Calm-mind.mp3");
    playlist2 << (songsPath() + "Chill-abstract-intention.mp3");
    playlist2 << (songsPath() + "Lofi-study.mp3");
    addPlaylist("Relax", playlist2);
}

QStringList Application::playlistNames() const
{
    return m_playlistNames;
}

void Application::setPlaylistNames(const QStringList &newPlaylistNames)
{
    if (m_playlistNames == newPlaylistNames)
        return;

    m_playlistNames = newPlaylistNames;
    emit playlistNamesChanged();
}

QStringList Application::playlistSongs() const
{
    return m_playlistSongs;
}

void Application::setPlaylistSongs(const QStringList &newPlaylistSongs)
{
    if (m_playlistSongs == newPlaylistSongs)
        return;

    m_playlistSongs = newPlaylistSongs;
    emit playlistSongsChanged();
}
