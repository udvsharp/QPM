// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_APIWRAPPER
#define QPM_APIWRAPPER

#include "Api.hpp"

namespace qpm {
	class ApiWrapper {
	private:
		ApiWrapper();
	public:
		static ApiWrapper& Instance() {
			if (sInstance == nullptr) {
				sInstance = new ApiWrapper;
			}
			return *sInstance;
		}

		ApiWrapper(const ApiWrapper& other) = delete;
		ApiWrapper& operator=(const ApiWrapper& other) = delete;

		void loginUser(QString login, QString password);
		void projects();
		void tickets(int32_t projectId);
	private:
		Api mApi;
		QString mAuthToken;
	private:
		static ApiWrapper* sInstance;
	};
}

#endif //QPM_APIWRAPPER
