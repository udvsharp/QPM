#include <QtQuick>

#include "api/Api.hpp"
#include "api/ApiWrapper.hpp"
#include "ui/AuthController.hpp"
#include "ui/ProjectsListModel.hpp"
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

  Q_UNUSED(qmlRegisterSingletonType<AuthController>(
      "com.udvsharp.AuthController", 1, 0, "AuthController",
      &AuthController::QMLInstance));
  Q_UNUSED(qmlRegisterType<ProjectsListModel>("com.udvsharp.ProjectsListModel",
                                              1, 0, "ProjectsListModel"));
}
