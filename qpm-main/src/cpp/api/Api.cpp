// Copyright (c) 2021 udv. All rights reserved.

#include "Api.hpp"

#include <QJsonDocument>

#include <utility>

namespace qpm {
	Api::Api(QString baseUrl, const QSslConfiguration &sslConfig)
			: mBaseUrl(std::move(baseUrl)), mManager(this), mSSLConfig(sslConfig) {
		mManager.setStrictTransportSecurityEnabled(false);
	}

	QNetworkReply *Api::loginUser(const QString &login, const QString &password) {
		QUrl url = mBaseUrl.arg("login");
		QNetworkRequest request = makeRequest(url);

		QNetworkReply *reply;
		QByteArray dataByteArray = makeParamsJson(
				{
						{"login",    login},
						{"password", password}
				});
		reply = mManager.post(request, dataByteArray);
		ignoreDefaultErrors(reply);

		return reply;
	}

	QByteArray Api::makeParamsJson(const std::unordered_map<QString, QVariant>& map) {
		QVariantMap data;
		for (const auto &i : map) {
			data.insert(i.first, i.second);
		}

		QByteArray dataByteArray = variantMapToJson(data);
		return dataByteArray;
	}

	QNetworkRequest Api::makeRequest(const QUrl &url, const QString &authToken) {
		QNetworkRequest request;
		request.setUrl(url);

		if (!authToken.isEmpty()) {
			request.setRawHeader("authorization", authToken.toUtf8());
		} else {
			request.setRawHeader("Content-Type", "application/json");
		}

		request.setSslConfiguration(mSSLConfig);

		return request;
	}

	QNetworkReply *Api::registerUser(const QString &login, const QString &password) {
		QUrl url = mBaseUrl.arg("register");
		QNetworkRequest request = makeRequest(url);

		QNetworkReply *reply;
		QByteArray dataByteArray = makeParamsJson(
				{
						{"login",    login},
						{"password", password}
				});
		reply = mManager.post(request, dataByteArray);
		ignoreDefaultErrors(reply);

		return reply;
	}

	QNetworkReply *Api::projects(const QString &authToken) {

		QUrl url = mBaseUrl.arg("projects");
		QNetworkRequest request = makeRequest(url, authToken);

		QNetworkReply *reply;
		reply = mManager.get(request);
		ignoreDefaultErrors(reply);

		return reply;
	}

	QNetworkReply *Api::tickets(const QString &authToken, int32_t projectId) {
		QUrl url = mBaseUrl.arg("tickets/%1/").arg(projectId);
		QNetworkRequest request = makeRequest(url, authToken);

		QNetworkReply *reply;
		reply = mManager.get(request);
		ignoreDefaultErrors(reply);

		return reply;
	}

	void Api::ignoreDefaultErrors(QNetworkReply *reply) {
		static QList<QSslError> expectedErrors{
				QSslError(QSslError::SelfSignedCertificate),
				QSslError(QSslError::InvalidCaCertificate),
				QSslError(QSslError::CertificateUntrusted),
		};

		QObject::connect(reply, &QNetworkReply::sslErrors, [reply](const auto &errorList) {
			for (auto &sslError : errorList) {
				qDebug() << "Recieved QNetworkReply::sslError:" << sslError;
			}
			reply->ignoreSslErrors(errorList);
		});
	}

	QByteArray Api::variantMapToJson(const QVariantMap &data) {
		QJsonDocument postDataDoc = QJsonDocument::fromVariant(data);
		QByteArray postDataByteArray = postDataDoc.toJson();

		return postDataByteArray;
	}

}
