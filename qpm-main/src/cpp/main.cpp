#include <QtQuick>

#include "api/Api.hpp"
#include "api/ApiWrapper.hpp"
#include "ui/AuthController.hpp"
#include "ui/ProjectsListModel.hpp"
#include "ui/TicketsListModel.hpp"
#include "util/Singleton.hpp"

void registerQmlTypes();

int main(int argc, char **argv) {
	QGuiApplication app(argc, argv);

	registerQmlTypes();
	QQmlApplicationEngine engine;
	engine.load("qrc:///qml/main.qml");

	if (engine.rootObjects().isEmpty()) {
		qDebug() << "engine.rootObjects() is empty!";
		return -1;
	}

	return QGuiApplication::exec();
}

void registerQmlTypes() {
	using namespace qpm;

	auto *projectsListModel = new ProjectsListModel;
	auto *ticketsListModel = new TicketsListModel;
	projectsListModel->connectTo(ticketsListModel);

	Q_UNUSED(qmlRegisterSingletonType<AuthController>(
			"com.udvsharp.AuthController", 1, 0, "AuthController",
			&AuthController::QMLInstance));
	Q_UNUSED(qmlRegisterSingletonInstance<ProjectsListModel>("com.udvsharp.ProjectsListModel",
	                                                         1, 0, "ProjectsListModel", projectsListModel));

	Q_UNUSED(qmlRegisterSingletonInstance<TicketsListModel>("com.udvsharp.TicketsListModel",
	                                                        1, 0, "TicketsListModel", ticketsListModel));
}
