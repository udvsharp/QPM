// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_AUTHCONTROLLER
#define QPM_AUTHCONTROLLER

#include <QtQuick>

#include "api/ApiWrapper.hpp"
#include "util/Singleton.hpp"

namespace qpm {

	class QT_SINGLETON(AuthController) {
	Q_OBJECT
	private:
		DECL_SINGLETON(AuthController)
	public:
		static QObject *QMLInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
	public slots:

	signals:
		void authCompleted(bool success, const QString &msg);
	public: // QML Handlers
		Q_INVOKABLE static bool tryAuthUser(const QString &login, const QString &password);
	private:
		explicit AuthController(QObject *parent = nullptr) : QObject(parent) {}
	};
}

#endif //QPM_AUTHCONTROLLER
