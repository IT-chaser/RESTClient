#include "restclient.h"

RESTClient::RESTClient()
{
    m_networkManager = new QNetworkAccessManager(this);

    connect(m_networkManager, &QNetworkAccessManager::finished, this, &RESTClient::onResponseRecieved);
    qDebug() << QSslSocket::supportsSsl() << QSslSocket::sslLibraryBuildVersionString() << QSslSocket::sslLibraryVersionString();
}

void RESTClient::onResponseRecieved(QNetworkReply *reply) {
    QByteArray respBytes = reply->readAll();
    QJsonDocument jsonDocResp = QJsonDocument::fromJson(respBytes);
    QJsonObject jsonRespObject = jsonDocResp.object();

    parseImageUrl(jsonRespObject);

    QString jsonStringResp(jsonDocResp.toJson(QJsonDocument::Indented));

    m_responseString = jsonStringResp;
    emit responseTextUpdated();
    /* QString rep = QString::fromStdString(reply->readAll().toStdString());
    qDebug() << rep; */
}

void RESTClient::parseImageUrl(QJsonObject jsonObj) {
    QJsonValue imageUrlValue = jsonObj.value(QStringLiteral("url"));
    m_imageUrl = imageUrlValue.toString();
    emit imageUrlUpdated();
}

void RESTClient::createGetRequest(QUrl requestUrl) {
    if(!requestUrl.isEmpty()) {
        QNetworkRequest request(requestUrl);
        m_networkManager->get(request);
    } else {
        qDebug() << "Requested URL is empty";
        m_responseString = m_responseString + "Requested URL is empty";
        emit responseTextUpdated();
    }
}
