#ifndef TICKETSLISTMODEL_HPP
#define TICKETSLISTMODEL_HPP

#include <QAbstractItemModel>
#include <QJsonObject>
#include <QJsonArray>
#include "model/Ticket.hpp"
#include "model/Project.hpp"

namespace qpm {

	class TicketsListModel : public QAbstractListModel {
	Q_OBJECT
		Q_PROPERTY(QList<Ticket> tickets READ tickets WRITE setTickets NOTIFY
				           ticketsChanged)
	public:
		enum Roles {
			TitleRole = Qt::UserRole + 1,
			DescriptionRole,
            PriorityRole,
		};

	public:
		explicit TicketsListModel(QObject *parent = nullptr);

		QList<Ticket> &tickets() { return mData.tickets; }
	public slots:
		void setTickets(const QList<Ticket> &Tickets) {
			mData.tickets = Tickets;
			emit ticketsChanged();
		}

	signals:
		void updated();
		void ticketsChanged();

	public:  // QML Handlers
		Q_INVOKABLE void update(int32_t pid);
        Q_INVOKABLE Ticket* get(int32_t index) { return &mData.tickets[index]; }

	private:
		void handleTicketsResponse(const QJsonObject &response);

		static QList<Ticket> parseTickets(const QJsonArray &jsonArr);

	private:
		struct Data {
			QList<Ticket> tickets;

			explicit Data(const QList<Ticket> &tickets = {}) : tickets(tickets) {}
		};

	private:
		Data mData;

		// QAbstractItemModel interface
	public:
		QHash<int, QByteArray> roleNames() const override;

		int rowCount(const QModelIndex &parent) const override;

		QVariant data(const QModelIndex &index, int role) const;
	};
};

#endif // TICKETSLISTMODEL_HPP
