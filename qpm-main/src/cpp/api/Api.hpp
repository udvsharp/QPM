// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_API
#define QPM_API

#include <QString>
#include <QJsonObject>
#include <QNetworkAccessManager>

#include <optional>

namespace qpm {
	class Api : QObject {
	public:
		explicit Api(QString  baseUrl, const QSslConfiguration& sslConfiguration);

		std::optional<QJsonObject> loginUser(QString login, QString password);
		void registerUser(QString login, QString password);
		std::optional<QJsonObject> projects(QString authToken);
		std::optional<QJsonObject> tickets(QString authToken, int32_t projectId);
	private:
		QString mBaseUrl;
		QNetworkAccessManager mManager;
		QSslConfiguration mSSLConfig;
	};
}

#endif //QPM_API
