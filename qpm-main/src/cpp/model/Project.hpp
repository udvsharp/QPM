// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_PROJECT
#define QPM_PROJECT

#include <QLIst>
#include "Ticket.hpp"

namespace qpm {
	class Project {
	public:

	private:
		QString mName;
		QList<Ticket> mTickets;
	};
}

#endif //QPM_PROJECT