// Copyright (c) 2021 udv. All rights reserved.

#include "TicketsListModel.hpp"

#include "api/ApiWrapper.hpp"
#include "api/Constants.hpp"

namespace qpm {
	static void (*const defaultErrorRoutine)(const QJsonObject &) =
	[](const QJsonObject &response) { qDebug() << "Error!" << response; };

	TicketsListModel::TicketsListModel(QObject *parent)
			: QAbstractListModel(parent) {}

	void TicketsListModel::update(int32_t id) {
		auto &apiWrapper = ApiWrapper::Instance();

		mData.tickets.clear();
		for (auto &p : mData.tickets) {
			apiWrapper.tickets(
					id,
					[this](auto &&PH1) {
						beginResetModel();
						handleTicketsResponse(std::forward<decltype(PH1)>(PH1));
						endResetModel();
					},
					defaultErrorRoutine);
		}

		emit updated();
	}

	QHash<int, QByteArray> TicketsListModel::roleNames() const {
		QHash<int, QByteArray> roles;
		roles[TitleRole] = "title";
		roles[DescriptionRole] = "description";
		return roles;
	}

	int TicketsListModel::rowCount(const QModelIndex &parent) const {
		if (parent.isValid()) {
			return 0;
		}

		return mData.tickets.size();
	}

	QVariant TicketsListModel::data(const QModelIndex &index, int role) const {
		if (!index.isValid()) {
			return QVariant();
		}

		auto &currentObject = mData.tickets.at(index.row());
		switch (role) {
			case TitleRole:return QVariant(currentObject.title());
			case DescriptionRole:return QVariant(currentObject.description());
		}
	}

	QList<Ticket> TicketsListModel::parseTickets(const QJsonArray &jsonArr) {
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

	void TicketsListModel::handleTicketsResponse(const QJsonObject &response) {
		qDebug() << "Success:" << response;
		mData.tickets.clear();

		if (response.contains(JSON_KEY_TICKETS)) {
			QJsonArray ticketsJson = response.value(JSON_KEY_TICKETS).toArray();

			auto tickets = parseTickets(ticketsJson);
			mData.tickets = tickets;
		} else {
			qDebug() << "No tickets in response!";
		}
	}

}  // namespace qpm
