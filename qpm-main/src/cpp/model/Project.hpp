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
	class Project {
	Q_GADGET
	public:
		Project(QString name, QUrl icon, int32_t id, const QList<Ticket> &tickets = {});

		Project(const Project &other) { *this = other; };
		Project &operator=(const Project &other);

		Project(Project &&other) noexcept { *this = std::move(other); };
		Project &operator=(Project &&other) noexcept;
	public:
		void setTickets(const QList<Ticket> &tickets) { mTickets = tickets; };
		int32_t id() const { return mId; };

		const QString &title() const;
		const QUrl &icon() const;
		const QList<Ticket> &tickets() const;
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
