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
		QNetworkRequest request;

		QUrl url = mBaseUrl.arg("login");
		request.setUrl(url);

		request.setRawHeader("Content-Type", "application/json");
		request.setSslConfiguration(mSSLConfig); // TODO: question that

		QVariantMap data;
		data.insert("login", login);
		data.insert("password", password);
		// TODO: SSLOption
		QNetworkReply *reply;
		QByteArray dataByteArray = variantMapToJson(data);
		reply = mManager.post(request, dataByteArray);
		ignoreDefaultErrors(reply);

		return reply;
	}

	QNetworkReply *Api::registerUser(const QString &login, const QString &password) {
		QNetworkRequest request;

		QUrl url = mBaseUrl.arg("register");
		request.setUrl(url);

		request.setRawHeader("Content-Type", "application/json");
		request.setSslConfiguration(mSSLConfig); // TODO: question that

		QVariantMap data;
		data.insert("login", login);
		data.insert("password", password);
		QNetworkReply *reply;
		QByteArray dataByteArray = variantMapToJson(data);
		reply = mManager.post(request, dataByteArray);
		ignoreDefaultErrors(reply);

		return reply;
	}

	QNetworkReply *Api::projects(const QString &authToken) {
		QNetworkRequest request;

		QUrl url = mBaseUrl.arg("projects");
		request.setUrl(url);

		request.setRawHeader("authorization", authToken.toUtf8());
		request.setSslConfiguration(mSSLConfig); // TODO: question that

		QNetworkReply *reply;
		reply = mManager.get(request);
		ignoreDefaultErrors(reply);

		return reply;
	}

	QNetworkReply *Api::tickets(const QString &authToken, int32_t projectId) {
		QNetworkRequest request;

		QUrl url = mBaseUrl.arg("tickets/%1/").arg(projectId);
		request.setUrl(url);

		request.setRawHeader("authorization", authToken.toUtf8());
		request.setSslConfiguration(mSSLConfig); // TODO: question that

		QNetworkReply *reply;
		reply = mManager.get(request);
		ignoreDefaultErrors(reply);

		return reply;
	}

	void Api::ignoreDefaultErrors(QNetworkReply *reply) {
		// TODO: make this work maybe
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
