// Copyright (c) 2021 udv. All rights reserved.

#include "ProjectsListModel.hpp"

#include "api/ApiWrapper.hpp"
#include "api/Constants.hpp"

namespace qpm {
static void (*const defaultErrorRoutine)(const QJsonObject &) =
    [](const QJsonObject &response) { qDebug() << "Error!" << response; };

ProjectsListModel::ProjectsListModel(QObject *parent)
    : QAbstractListModel(parent) {}

void ProjectsListModel::update() {
  auto &apiWrapper = ApiWrapper::Instance();

  mData.projects.clear();
  apiWrapper.projects(
      [this](auto &&PH1) {
        beginResetModel();
        handleProjectsResponse(std::forward<decltype(PH1)>(PH1));
        endResetModel();
      },
      defaultErrorRoutine);

	for (auto &p : mData.projects) {
		apiWrapper.tickets(
				p.id(),
				[this, &p](auto &&PH1) {
					handleTicketsResponse(std::forward<decltype(PH1)>(PH1), p);
				},
				defaultErrorRoutine);
	}

  emit updated();
}

QList<Project> ProjectsListModel::parseProjects(const QJsonArray &jsonArr) {
  QList<Project> projects;
  for (const auto &jsonValue : jsonArr) {
    auto json = jsonValue.toObject();

    auto project = Project::from(json);
    if (project.has_value()) {
      projects.append(std::move(project.value()));
    }
  }
  return projects;
}

QHash<int, QByteArray> ProjectsListModel::roleNames() const {
  QHash<int, QByteArray> roles;
  roles[TitleRole] = "title";
  roles[ImageRole] = "imageUrl";
  return roles;
}

int ProjectsListModel::rowCount(const QModelIndex &parent) const {
  if (parent.isValid()) {
    return 0;
  }

  return mData.projects.size();
}

QVariant ProjectsListModel::data(const QModelIndex &index, int role) const {
  if (!index.isValid()) {
    return QVariant();
  }

  auto &currentObject = mData.projects.at(index.row());
  switch (role) {
    case TitleRole:
      return QVariant(currentObject.title());
    case ImageRole:
      return QVariant(currentObject.icon());
  }
}

QList<Ticket> ProjectsListModel::parseTickets(const QJsonArray &jsonArr) {
  QList<Ticket> tickets;
  for (const auto &jsonValue : jsonArr) {
    auto json = jsonValue.toObject();

    auto ticket = Ticket::from(json);
    if (ticket.has_value()) {
      tickets.append(std::move(ticket.value()));
    }
  }
  return tickets;
}

void ProjectsListModel::handleProjectsResponse(const QJsonObject &response) {
  qDebug() << "Success:" << response;

  if (response.contains(JSON_KEY_PROJECTS)) {
    QJsonArray projectsJson = response.value(JSON_KEY_PROJECTS).toArray();

    auto projects = parseProjects(projectsJson);
    mData.projects = std::move(projects);
    emit projectsChanged();
  } else {
    qDebug() << "No projects in response!";
  }
}

void ProjectsListModel::handleTicketsResponse(const QJsonObject &response,
                                              Project &project) {
  qDebug() << "Success:" << response;
  mData.projects.clear();

  if (response.contains(JSON_KEY_TICKETS)) {
    QJsonArray projectsJson = response.value(JSON_KEY_TICKETS).toArray();

    auto tickets = parseTickets(projectsJson);
    project.setTickets(tickets);
  } else {
    qDebug() << "No tickets in response!";
  }
}

}  // namespace qpm
