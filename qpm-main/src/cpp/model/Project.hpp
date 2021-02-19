// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_PROJECT
#define QPM_PROJECT

#include <QLIst>
#include <QObject>
#include <QJsonObject>
#include <optional>
#include <QUrl>

#include "Ticket.hpp"

namespace qpm {
	class Project : public QObject {
	Q_OBJECT
	public:
		Project(QString name, QUrl icon, int32_t id, const QList<Ticket> &tickets = {}, QObject* parent = nullptr);

		Project(Project&& other);
	public:
		void setTickets(const QList<Ticket> &tickets) { mTickets = tickets; };
		int32_t id() const { return mId; };
	public:
		static std::optional<Project> from(const QJsonObject &json);
	private:
		QString mName;
		QUrl mIcon;
		int32_t mId;

		QList<Ticket> mTickets;
	};
}

#endif //QPM_PROJECT
