/***************************************************************************/
/*! \file       Application.cpp
 * \brief       The application class definition
 *
 * \copyright   Copyright (c) 2023 Sagar Gurudas Nayak
 * \copyright   MIT License
 *
 * \remark      Email: sagargnayak26@gmail.com
 ***************************************************************************/

#ifndef APPLICATION_H
#define APPLICATION_H

#include <QApplication>
#include <QStringList>
#include <QMap>

class QQmlApplicationEngine;

class Application : public QApplication
{
    Q_OBJECT
    Q_PROPERTY(QString audioSource READ audioSource WRITE setAudioSource NOTIFY audioSourceChanged)
    Q_PROPERTY(QString audioName READ audioName WRITE setAudioName NOTIFY audioNameChanged)
    Q_PROPERTY(QStringList playlistNames READ playlistNames WRITE setPlaylistNames NOTIFY playlistNamesChanged)
    Q_PROPERTY(QStringList playlistSongs READ playlistSongs WRITE setPlaylistSongs NOTIFY playlistSongsChanged)

public:
    explicit Application(int &argc, char **argv);
    virtual ~Application();

    QString audioSource() const;
    QString audioName() const;
    QStringList playlistNames() const;

    QStringList playlistSongs() const;
    void setPlaylistSongs(const QStringList &newPlaylistSongs);

public slots:
    bool init();
    QString songsPath();
    void addSongToPlaylist(const QString& name, const QString& song);
    void deleteSong(const QString& name, const QString& song);
    void addPlaylist(const QString& name, QStringList list);
    void createNewPlaylist(const QString& name, QStringList list);
    void deletePlaylist(const QString& name);
    void onPlaylistSelected(const QString& name);

    void setAudioSource(const QString &newAudioSource);
    void setAudioName(const QString &newAudioName);
    void setPlaylistNames(const QStringList &newPlaylist);

private:
    void createDefaultPlaylists();

signals:
    void audioSourceChanged();
    void audioNameChanged();
    void playlistMapChanged();
    void playlistNamesChanged();
    void playlistSongsChanged();
    void showMessage(const QString &message);

private:
    QQmlApplicationEngine *m_engine = nullptr;
    QString m_audioSource;
    QString m_audioName;
    QMap<QString, QStringList> m_playlistMap;
    QStringList m_playlistNames;
    QString m_selectedPlaylist;
    QStringList m_playlistSongs;
};

#endif // APPLICATION_H
