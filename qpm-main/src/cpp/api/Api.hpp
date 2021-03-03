// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_API
#define QPM_API

#include <QString>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QByteArray>

#include <optional>

namespace qpm {
	class Api : QObject {
	public:
		explicit Api(QString baseUrl, const QSslConfiguration &sslConfiguration = QSslConfiguration());

		QNetworkReply *loginUser(const QString &login, const QString &password);
		QNetworkReply *registerUser(const QString &login, const QString &password);
		QNetworkReply *projects(const QString &authToken);
		QNetworkReply *tickets(const QString &authToken, int32_t projectId);
	private:
		static QByteArray variantMapToJson(const QVariantMap &map);
		static void ignoreDefaultErrors(QNetworkReply *reply);

		QNetworkRequest makeRequest(const QUrl &url, const QString& autoToken = "");

        static QByteArray makeParamsJson(const std::unordered_map<QString, QVariant>& map);
	private:
		QString mBaseUrl;
		QNetworkAccessManager mManager;
		QSslConfiguration mSSLConfig;
	};
}

#endif //QPM_API
