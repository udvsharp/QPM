// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_MEMBERAREACONTROLLER
#define QPM_MEMBERAREACONTROLLER

#include <QAbstractListModel>
#include <QtQuick>

#include "api/ApiWrapper.hpp"
#include "model/Project.hpp"
#include "util/Singleton.hpp"
#include "TicketsListModel.hpp"

namespace qpm {

	class ProjectsListModel : public QAbstractListModel {
	Q_OBJECT
		Q_PROPERTY(QList<Project> projects READ projects WRITE setProjects NOTIFY
				           projectsChanged)
	public:
		enum Roles {
			TitleRole = Qt::UserRole + 1,
			ImageRole,
		};

	public:
		explicit ProjectsListModel(QObject *parent = nullptr);

		QList<Project> &projects() { return mData.projects; }

		void connectTo(TicketsListModel *model) { mTicketsModel = model; }
	public slots:
		void setProjects(const QList<Project> &projects) {
			mData.projects = projects;
			emit projectsChanged();
		}

	signals:
		void updated();
		void projectsChanged();

	public:  // QML Handlers
		Q_INVOKABLE void update();
        Q_INVOKABLE void select(int32_t index);

	private:
		void handleProjectsResponse(const QJsonObject &response);
		void handleTicketsResponse(const QJsonObject &response, Project &project);

		static QList<Ticket> parseTickets(const QJsonArray &jsonArr);
		static QList<Project> parseProjects(const QJsonArray &jsonArr);

	private:
		struct Data {
			QList<Project> projects;

			explicit Data(const QList<Project> &projects = {}) : projects(projects) {}
		};

	private:
		Data mData;
		TicketsListModel *mTicketsModel = nullptr;

		// QAbstractItemModel interface
	public:
		QHash<int, QByteArray> roleNames() const override;

		int rowCount(const QModelIndex &parent) const override;

		QVariant data(const QModelIndex &index, int role) const;
	};
}  // namespace qpm

#endif  // QPM_MEMBERAREACONTROLLER
