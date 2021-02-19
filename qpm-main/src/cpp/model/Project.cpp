// Copyright (c) 2021 udv. All rights reserved.

#include "Project.hpp"

#include <utility>

#include "api/Constants.hpp"

namespace qpm {
	Project::Project(QString name, QUrl icon, int32_t id, const QList<Ticket> &tickets, QObject *parent)
			: QObject(parent), mName(std::move(name)), mIcon(std::move(icon)), mId(id), mTickets(tickets) {}

	std::optional<Project> Project::from(const QJsonObject &json) {
		if (json.contains(JSON_KEY_PROJECT_NAME)
		    && json.contains(JSON_KEY_PROJECT_ICON)
		    && json.contains(JSON_KEY_PROJECT_ID)) {
			return std::make_optional<Project>(
					json.value(JSON_KEY_PROJECT_NAME).toString(),
					QUrl(json.value(JSON_KEY_PROJECT_ICON).toString()),
					json.value(JSON_KEY_PROJECT_ID).toInt()
			);
		} else {
			qDebug() << "Json object keys are invalid (Project)...";
			qDebug() << json;
			return std::nullopt;
		}
	}

	Project::Project(Project &&other) {
		if (this == &other) {
			return;
		}

		mName = std::move(other.mName);
		mId = other.mId;
		mIcon = std::move(other.mIcon);
		mTickets = std::move(other.mTickets);
	}
}
