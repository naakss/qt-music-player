#ifndef APPLICATION_H
#define APPLICATION_H

#include <QApplication>
#include <QCommandLineParser>
#include <QTranslator>

class QQmlApplicationEngine;

class Application : public QApplication
{
    Q_OBJECT
    Q_PROPERTY(QString audioSource READ audioSource WRITE setAudioSource NOTIFY audioSourceChanged)
    Q_PROPERTY(QString audioName READ audioName WRITE setAudioName NOTIFY audioNameChanged)

public:
    explicit Application(int &argc, char **argv);
    virtual ~Application();

    QString audioSource() const;
    QString audioName() const;

public slots:
    bool init();
    QString songsPath();
    QString playlistPath();

    void setAudioSource(const QString &newAudioSource);
    void setAudioName(const QString &newAudioName);

signals:
    void audioSourceChanged();
    void audioNameChanged();

private:
    QQmlApplicationEngine *m_engine = nullptr;
    QString m_audioSource;
    QString m_audioName;
};

#endif // APPLICATION_H
