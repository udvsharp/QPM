#include <QtQuick>

#include "api/Api.hpp"
#include "api/ApiWrapper.hpp"
#include "ui/AuthController.hpp"
#include "ui/DataProvider.hpp"

#include "util/Singleton.hpp"

int main(int argc, char **argv) {
	using namespace qpm;

	// auto& s = Singleton<ApiWrapper>::Instance();

	QGuiApplication app(argc, argv);

	// Register qml types
	qmlRegisterSingletonType<AuthController>("com.udvsharp.AuthController", 1, 0, "AuthController",
	                                         &AuthController::QMLInstance);
	qmlRegisterSingletonType<AuthController>("com.udvsharp.DataProvider", 1, 0, "DataProvider",
	                                         &DataProvider::QMLInstance);
	QQmlApplicationEngine engine;
	engine.load("qrc:///qml/main.qml");

	if (engine.rootObjects().isEmpty()) {
		qDebug() << "engine.rootObjects() is empty!";
		return -1;
	}

	return QGuiApplication::exec();
}
