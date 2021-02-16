// Copyright (c) 2021 udv. All rights reserved.

#include "Api.hpp"

#include <utility>

namespace qpm {
	Api::Api(QString baseUrl, const QSslConfiguration &sslConfig)
			: mBaseUrl(std::move(baseUrl)), mManager(this), mSSLConfig(sslConfig) {
	}

	std::optional<QJsonObject> Api::loginUser(QString login, QString password) {
		QNetworkRequest request;

		QUrl url = mBaseUrl.append("/login/");
		request.setUrl(url);

		request.setRawHeader("Content-Type", "application/json");
		request.setSslConfiguration(mSSLConfig); // TODO: question that



		return QJsonObject();
	}

	void Api::registerUser(QString login, QString password) {

	}

	std::optional<QJsonObject> Api::projects(QString authToken) {
		return QJsonObject();
	}

	std::optional<QJsonObject> Api::tickets(QString authToken, int32_t projectId) {
		return QJsonObject();
	}
}
