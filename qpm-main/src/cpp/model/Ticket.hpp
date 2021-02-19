// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_TICKET
#define QPM_TICKET

#include <QObject>
#include <QString>
#include <QJsonObject>

#include <optional>

namespace qpm {
	class Ticket : public QObject {
		Q_OBJECT
	public:
		Ticket(QString m_name, QString m_description, int32_t m_priority, int32_t m_id, QObject* parent = nullptr);

		Ticket(const Ticket &other);
		Ticket(Ticket &&other);
	public:
		static std::optional<Ticket> from(const QJsonObject &obj);
	private:
		QString mName;
		QString mDescription;
		int32_t mPriority; // TODO: enum
		int32_t mId;
	};
}

#endif //QPM_TICKET
