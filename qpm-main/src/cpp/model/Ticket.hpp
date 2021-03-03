// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_TICKET
#define QPM_TICKET

#include <QObject>
#include <QString>
#include <QJsonObject>

#include <optional>

namespace qpm {
	class Ticket {
	Q_GADGET
	public:
		Ticket(QString m_name, QString m_description, int32_t m_priority, int32_t m_id);

		Ticket(const Ticket &other) { *this = other; };
		Ticket &operator=(const Ticket &other);

		Ticket(Ticket &&other) noexcept { *this = std::move(other); };
		Ticket &operator=(Ticket &&other) noexcept;
	public:
		static std::optional<Ticket> from(const QJsonObject &obj);
	public:
		const QString &title() const;
        const QString &description() const;
        int32_t priority() const;
	private:
		QString mName;
		QString mDescription;
		int32_t mPriority; // TODO: enum
		int32_t mId;
	};
}

#endif //QPM_TICKET
