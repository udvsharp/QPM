#ifndef TICKETSLISTMODEL_HPP
#define TICKETSLISTMODEL_HPP

#include <QAbstractItemModel>

class TicketsListModel : QAbstractListModel
{
Q_OBJECT
	Q_PROPERTY(QList<Ticket> tickets READ Tickets WRITE setTickets NOTIFY
			           TicketsChanged)
public:
	enum Roles {
		TitleRole = Qt::UserRole + 1,
		ImageRole,
	};

public:
	explicit TicketsListModel(QObject *parent = nullptr);

	QList<Ticket> &tickets() { return mData.Tickets; }
public slots:
	void setTickets(const QList<Ticket> &Tickets) {
		mData.Tickets = Tickets;
		emit ticketsChanged();
	}

signals:
	void updated();
	void ticketsChanged();

public:  // QML Handlers
	Q_INVOKABLE void update();

private:
	void handleTicketsResponse(const QJsonObject &response);
	void handleTicketsResponse(const QJsonObject &response, Ticket &Ticket);

	static QList<Ticket> parseTickets(const QJsonArray &jsonArr);
	static QList<Ticket> parseTickets(const QJsonArray &jsonArr);

private:
	struct Data {
		QList<Ticket> Tickets;

		explicit Data(const QList<Ticket> &Tickets = {}) : Tickets(Tickets) {}
	};

private:
	Data mData;

	// QAbstractItemModel interface
public:
	QHash<int, QByteArray> roleNames() const override;

	int rowCount(const QModelIndex &parent) const override;

	QVariant data(const QModelIndex &index, int role) const;
};

#endif // TICKETSLISTMODEL_HPP
