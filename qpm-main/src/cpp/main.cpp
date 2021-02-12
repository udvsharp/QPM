#include <QtQuick>

#include "ui/AuthController.hpp"

int main(int argc, char** argv)
{
    QGuiApplication app(argc, argv);
    // TODO: registerSingleton
	qmlRegisterType<qpm::AuthController>("com.udvsharp", 1, 0, "AuthController");

	QQmlApplicationEngine engine;
	engine.load("qrc:///qml/main.qml");
	if (engine.rootObjects().isEmpty()) {
		return -1;
	}

	return QGuiApplication::exec();
}
