// Copyright (c) 2021 udv. All rights reserved.

#include "AuthController.hpp"

namespace qpm {
	AuthController *AuthController::sInstance = nullptr;

	AuthController *AuthController::instance() {
		if (sInstance == nullptr) {
			sInstance = new AuthController;
		}
		return sInstance;
	}

	QObject *AuthController::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine) {
		Q_UNUSED(engine);
		Q_UNUSED(scriptEngine);
		// C++ and QML instance they are the same instance
		return AuthController::instance();
	}
}
