#include <QtQuick>

#include "ui/AuthController.hpp"

int main(int argc, char **argv) {
	using namespace qpm;

	QGuiApplication app(argc, argv);
	qmlRegisterSingletonType<AuthController>("com.udvsharp.AuthController", 1, 0, "AuthController",
	                                              &AuthController::qmlInstance);

	QQmlApplicationEngine engine;
	engine.load("qrc:///qml/main.qml");
	if (engine.rootObjects().isEmpty()) {
		return -1;
	}

	return QGuiApplication::exec();
}
