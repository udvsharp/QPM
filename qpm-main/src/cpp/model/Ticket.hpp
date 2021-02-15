// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_TICKET
#define QPM_TICKET

#include <QString>

namespace qpm {
	class Ticket {
	public:

	private:
		QString mName;
		QString mDescription;
		QString mPriority; // TODO: enum
		int32_t mId;
	};
}

#endif //QPM_TICKET
