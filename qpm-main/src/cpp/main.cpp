#include <QtQuick>

#include "ui/AuthController.hpp"

int main(int argc, char **argv) {
	using namespace qpm;

	QGuiApplication app(argc, argv);

	// Register qml types
	qmlRegisterSingletonType<AuthController>("com.udvsharp.AuthController", 1, 0, "AuthController",
	                                         &AuthController::qmlInstance);
	QQmlApplicationEngine engine;
	engine.load("qrc:///qml/main.qml");

	if (engine.rootObjects().isEmpty()) {
		qDebug() << "engine.rootObjects() is empty!";
		return -1;
	}

	return QGuiApplication::exec();
}
