// Copyright (c) 2021 udv. All rights reserved.

#include "Ticket.hpp"

#include <utility>

#include "api/Constants.hpp"

namespace qpm {
	Ticket::Ticket(QString m_name, QString m_description, int32_t m_priority, int32_t m_id) : mName(std::move(
			m_name)), mDescription(std::move(m_description)), mPriority(m_priority), mId(m_id) {}

	Ticket &Ticket::operator=(const Ticket &other) {
		if (this == &other) {
			return *this;
		}

		mName = other.mName;
		mDescription = other.mDescription;
		mPriority = other.mPriority;
		mId = other.mId;

		return *this;
	}

	Ticket &Ticket::operator=(Ticket &&other) noexcept {
		if (this == &other) {
			return *this;
		}

		mName = std::move(other.mName);
		mDescription = std::move(other.mDescription);
		mPriority = other.mPriority;
		mId = other.mId;

		return *this;
	}

	std::optional<Ticket> Ticket::from(const QJsonObject &json) {
		if (json.contains(JSON_KEY_TICKET_NAME)
		    && json.contains(JSON_KEY_TICKET_DESCRIPTION)
		    && json.contains(JSON_KEY_TICKET_PRIORITY)
		    && json.contains(JSON_KEY_TICKET_ID)) {
			return std::make_optional<Ticket>(
					json.value(JSON_KEY_TICKET_NAME).toString(),
					json.value(
							JSON_KEY_TICKET_DESCRIPTION).toString(),
					json.value(JSON_KEY_TICKET_PRIORITY).toInt(),
					json.value(JSON_KEY_TICKET_ID).toInt()
			);
		} else {
			qDebug() << "Json object keys are invalid (Project)...";
			qDebug() << json;
			return std::nullopt;
		}
	}

	const QString &Ticket::title() const {
		return mName;
	}

	const QString &Ticket::description() const {
		return mDescription;
	}

    int32_t Ticket::priority() const {
        return mPriority;
    }
}
