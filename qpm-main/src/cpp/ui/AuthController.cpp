// Copyright (c) 2021 udv. All rights reserved.

#include "AuthController.hpp"

namespace qpm {

	QObject *AuthController::QMLInstance(QQmlEngine *engine, QJSEngine *scriptEngine) {
		Q_UNUSED(engine);
		Q_UNUSED(scriptEngine);
		// C++ and QML instance they are the same instance
		return &AuthController::Instance();
	}

	bool AuthController::tryAuthUser(const QString &login, const QString &password) {
		qDebug() << "Login clicked!"
		         << "Login:" << login
		         << "Password:" << password;

		auto &wrapper = ApiWrapper::Instance();
		wrapper.loginUser(login, password, [](bool success, const QString &msg) {
			emit Instance().authCompleted(success, msg);
		});

		return true;
	}
}
