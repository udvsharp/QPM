// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_APIWRAPPER
#define QPM_APIWRAPPER

#include "Api.hpp"
#include "util/Singleton.hpp"

#include <functional>

namespace qpm {
	class SINGLETON(ApiWrapper) {
		DECL_SINGLETON(ApiWrapper)
	private:
		using handleFunction = std::function<void(const QJsonObject &)>;
		using finishFunction = std::function<void()>;


		using loginFunction = std::function<void(bool, const QString&)>;
	private:
		static const QString KEY_QNETWORK_REPLY_ERROR;
		static const QString KEY_CONTENT_NOT_FOUND;
	private:
		ApiWrapper();
	public:
		void loginUser(const QString &login, const QString &password, const loginFunction &f);
		void projects(
				const handleFunction &successRoutine,
				const handleFunction &errorRoutine);
		void tickets(int32_t projectId,
		             const handleFunction &successRoutine,
		             const handleFunction &errorRoutine);
	private:
		static bool onFinishRequest(QNetworkReply *reply);
		static void handleQtNetworkErrors(QNetworkReply *reply, const QJsonObject &obj);
		static QJsonObject parseReply(QNetworkReply *reply);

		template<typename F>
		void setupSignals(QNetworkReply *reply, F f,
		                  const handleFunction &successRoutine,
		                  const handleFunction &errorRoutine);
	private:
		Api mApi;
		QString mAuthToken;
	};
}

#endif //QPM_APIWRAPPER
