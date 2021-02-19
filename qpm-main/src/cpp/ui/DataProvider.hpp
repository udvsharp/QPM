// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_MEMBERAREACONTROLLER
#define QPM_MEMBERAREACONTROLLER

#include <QtQuick>

#include "api/ApiWrapper.hpp"
#include "model/Project.hpp"
#include "util/Singleton.hpp"

namespace qpm {

	class QT_SINGLETON(DataProvider) {
		Q_OBJECT
	private:
		DECL_SINGLETON(DataProvider)
	public:
		static QObject *QMLInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
	signals:
		void updated();
	public: // QML Handlers
		Q_INVOKABLE QList<Project> getProjects() const;
		Q_INVOKABLE void update();
	private:
		explicit DataProvider(QObject *parent = nullptr);
	private:
		void handleProjectsResponse(const QJsonObject &response);
		void handleTicketsResponse(const QJsonObject &response, Project &project);

		static QList<Ticket> parseTickets(const QJsonArray& jsonArr);
		static QList<Project> parseProjects(const QJsonArray& jsonArr);
	private:
		struct Data {
			QList<Project> projects;

			explicit Data(const QList<Project> &projects = {}) : projects(projects) {}
		};
	private:
		Data mData;
	};
}

#endif //QPM_MEMBERAREACONTROLLER
