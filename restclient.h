#ifndef RESTCLIENT_H
#define RESTCLIENT_H

#include <QObject>
#include <QDebug>
#include <QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>

class RESTClient : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString responseText READ responseText NOTIFY responseTextUpdated)
    Q_PROPERTY(QString imageUrl READ imageUrl NOTIFY imageUrlUpdated)
public:
    RESTClient();

    Q_INVOKABLE void createGetRequest(QUrl requestUrl);

    QString responseText() {
        return m_responseString;
    }
    QString imageUrl() {
        return m_imageUrl;
    }

public slots:
    void onResponseRecieved(QNetworkReply *reply);
    \
signals:
    void responseTextUpdated();
    void imageUrlUpdated();

private:
    void parseImageUrl(QJsonObject jsonObj);
    QNetworkAccessManager *m_networkManager;

    QString m_responseString;

    QString m_imageUrl;
};

#endif // RESTCLIENT_H
