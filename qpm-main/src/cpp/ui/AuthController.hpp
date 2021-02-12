// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_AUTHCONTROLLER
#define QPM_AUTHCONTROLLER

#include <QtQuick>

namespace qpm {

	// TODO: singleton
	class AuthController : public QObject {
		Q_OBJECT
	public:
		explicit AuthController(QObject* parent = nullptr) : QObject(parent) {}

		Q_INVOKABLE static bool test(const QString& login, const QString& password) {
			qDebug() << "Login clicked!"
				<< "Login:" << login
				<< "Password:" << password;
			// TODO: Verify Credentials
			return true;
		}

	};
}

#endif //QPM_AUTHCONTROLLER
