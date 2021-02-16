// Copyright (c) 2021 udv. All rights reserved.

#include "ApiWrapper.hpp"

#include <QObject>
#include <QJsonParseError>
#include <QJsonDocument>
#include <QJsonArray>

#define JSON_KEY_TOKEN "token"

namespace qpm {
	const QString ApiWrapper::KEY_QNETWORK_REPLY_ERROR = "QNetworkReplyError";
	const QString ApiWrapper::KEY_CONTENT_NOT_FOUND = "ContentNotFoundError";

	ApiWrapper::ApiWrapper()
	// TODO: safer way to store constants
			: mApi("https://51.15.247.46:80/852983733:AAHMihiJcpmZBxyAuVkCdFs-NAdyQJgbtZQ/project/%1/") {

	}

	void ApiWrapper::loginUser(const QString &login, const QString &password, const loginFunction &f) {
		auto *reply = mApi.loginUser(login, password);
		setupSignals(reply, &QNetworkReply::finished,
		             [login, password, f, this](const QJsonObject &response) {
			             qDebug() << "Success! Received" << response;

			             if (response.contains(JSON_KEY_TOKEN)) {
				             mAuthToken = response.value(JSON_KEY_TOKEN).toString();
				             f(true, "Success");
			             } else {
				             f(false, "No Token Recieved");
			             }
		             },
		             [login, f, password](const QJsonObject &response) {
			             qDebug() << "Error! Received" << response;
			             f(false, "Error!");
		             }
		);
	}

	void ApiWrapper::projects(
			const handleFunction &successRoutine,
			const handleFunction &errorRoutine) {
		auto *reply = mApi.projects(mAuthToken);
		setupSignals(reply, &QNetworkReply::finished, successRoutine, errorRoutine);
	}

	void ApiWrapper::tickets(int32_t projectId,
	                         const handleFunction &successRoutine,
	                         const handleFunction &errorRoutine) {
		auto *reply = mApi.tickets(mAuthToken, projectId);
		setupSignals(reply, &QNetworkReply::finished, successRoutine, errorRoutine);
	}

	bool ApiWrapper::onFinishRequest(QNetworkReply *reply) {
		auto error = reply->error();
		if (error == QNetworkReply::NoError) {
			auto code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
			if (code >= 200 && code < 300) {
				return true;
			}
		}
		return false;
	}

	void ApiWrapper::handleQtNetworkErrors(QNetworkReply *reply, const QJsonObject &obj) {
		auto error = reply->error();
		if (!(error == QNetworkReply::NoError ||
		      error == QNetworkReply::ContentNotFoundError ||
		      error == QNetworkReply::ContentAccessDenied ||
		      error == QNetworkReply::ProtocolInvalidOperationError
		)) {
			qDebug() << reply->error();
			obj[KEY_QNETWORK_REPLY_ERROR] = reply->errorString();
		} else if (error == QNetworkReply::ContentNotFoundError) {
			obj[KEY_CONTENT_NOT_FOUND] = reply->errorString();
		}
	}

	QJsonObject ApiWrapper::parseReply(QNetworkReply *reply) {
		QJsonObject jsonObj;
		QJsonDocument jsonDoc;
		QJsonParseError parseError;
		auto replyText = reply->readAll();
		jsonDoc = QJsonDocument::fromJson(replyText, &parseError);
		if (parseError.error != QJsonParseError::NoError) {
			qDebug() << "Reply Text:" << replyText;
			qWarning() << "Json parse error: " << parseError.errorString();
		} else {
			if (jsonDoc.isObject()) {
				jsonObj = jsonDoc.object();
			} else if (jsonDoc.isArray()) {
				jsonObj["non_field_errors"] = jsonDoc.array();
			}
		}
		return jsonObj;
	}

	template<typename F>
	void ApiWrapper::setupSignals(QNetworkReply *reply, F f,
	                              const handleFunction &successRoutine,
	                              const handleFunction &errorRoutine) {
		QObject::connect(reply, f, [this, successRoutine, errorRoutine, reply]() {
			QJsonObject obj = parseReply(reply);

			if (onFinishRequest(reply)) {
				if (successRoutine != nullptr)
					successRoutine(obj);
			} else {
				if (errorRoutine != nullptr) {
					handleQtNetworkErrors(reply, obj);
					errorRoutine(obj);
				}
			}
			reply->close();
			reply->deleteLater();
		});
	}
}
