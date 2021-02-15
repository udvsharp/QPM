// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_AUTHCONTROLLER
#define QPM_AUTHCONTROLLER

#include <QtQuick>

namespace qpm {

	class AuthController : public QObject {
		Q_OBJECT
	public:
		static AuthController *instance();
		static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);

		Q_INVOKABLE static bool test(const QString& login, const QString& password) {
			qDebug() << "Login clicked!"
				<< "Login:" << login
				<< "Password:" << password;
			// TODO: Verify Credentials
			return true;
		}
	private:
		explicit AuthController(QObject* parent = nullptr) : QObject(parent) {}

		static AuthController* sInstance;
	};
}

#endif //QPM_AUTHCONTROLLER
