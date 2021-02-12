// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_AUTHCONTROLLER
#define QPM_AUTHCONTROLLER

#include <QtQuick>

namespace qpm {
	class AuthController : public QObject {
		Q_OBJECT
	public:
		explicit AuthController(QObject* parent = nullptr) : QObject(parent) {}

		Q_INVOKABLE static void test(const QString& login, const QString& password) {
			qDebug() << "Login clicked!" << login << password;
		}

	};
}

#endif //QPM_AUTHCONTROLLER
