// Copyright (c) 2021 udv. All rights reserved.

#include "DataProvider.hpp"

#include "api/Constants.hpp"
#include "api/ApiWrapper.hpp"

namespace qpm {
	static void (*const defaultErrorRoutine)(const QJsonObject &) = [](const QJsonObject &response) {
		qDebug() << "Error!" << response;
	};

	DataProvider::DataProvider(QObject *parent) : QObject(parent) {}

	void DataProvider::update() {
		auto &apiWrapper = ApiWrapper::Instance();

		mData.projects.clear();
		apiWrapper.projects(
				[this](auto && PH1) { handleProjectsResponse(std::forward<decltype(PH1)>(PH1)); },
				[](const QJsonObject &response) {
					qDebug() << "Error!" << response;
				}
		);

		for (auto &p : mData.projects) {
			apiWrapper.tickets(
					p.id(),
					[this, &p](auto && PH1) { handleTicketsResponse(std::forward<decltype(PH1)>(PH1), p); },
					[](const QJsonObject &response) {
						qDebug() << "Error!" << response;
					}
			);
		}

		emit updated();
	}

	QList<Project> DataProvider::parseProjects(const QJsonArray &jsonArr) {
		QList<Project> projects;
		for (const auto &jsonValue : jsonArr) {
			auto json = jsonValue.toObject();

			auto project = Project::from(json);
			if (project.has_value()) {
				projects.append(std::move(project.value())); // FIXME: project move problem
			}
		}
		return projects;
	}

	QList<Ticket> DataProvider::parseTickets(const QJsonArray &jsonArr) {
		QList<Ticket> tickets;
		for (const auto &jsonValue : jsonArr) {
			auto json = jsonValue.toObject();

			auto ticket = Ticket::from(json);
			if (ticket.has_value()) {
				tickets.append(std::move(ticket.value())); // FIXME: ticket move problem
			}
		}
		return tickets;
	}

	void DataProvider::handleProjectsResponse(const QJsonObject &response) {
		qDebug() << "Success:" << response;

		if (response.contains(JSON_KEY_PROJECTS)) {
			QJsonArray projectsJson = response.value(JSON_KEY_PROJECTS).toArray();

			auto projects = parseProjects(projectsJson);
			mData.projects = std::move(projects);
		} else {
			qDebug() << "No projects in response!";
		}
	}

	void DataProvider::handleTicketsResponse(const QJsonObject &response, Project &project) {
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

	QList<Project> DataProvider::getProjects() const {
		return mData.projects;
	}

	QObject *DataProvider::QMLInstance(QQmlEngine *engine, QJSEngine *scriptEngine) {
		Q_UNUSED(engine);
		Q_UNUSED(scriptEngine);
		// C++ and QML instance they are the same instance
		return &DataProvider::Instance();
	}
}
