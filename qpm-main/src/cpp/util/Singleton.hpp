// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_SINGLETON
#define QPM_SINGLETON

#include <QOBject>

namespace qpm {
	template<typename T>
	class Singleton {
		using type = Singleton<T>;
		using ref = Singleton<T> &;
		using const_ref = Singleton<T> &;
		using ptr = Singleton<T> *;
	protected:
		Singleton() = default;
	public:
		static T &Instance() {
			if (sInstance == nullptr) {
				sInstance = new T();
			}
			return *sInstance;
		}

		template<typename... Args>
		static T &Reset(Args &&... args) {
			sInstance = new T(std::forward<Args>(args)...);
			return *sInstance;
		}

		~Singleton() {
			delete sInstance;
		}

		// forbidden
		ref operator=(const_ref other) = delete;
		Singleton(const_ref other) = delete;
	private:
		static T *sInstance;
	};

	template<typename T> T *Singleton<T>::sInstance = nullptr;
}

// Some macros
#define SINGLETON(x) x : public Singleton<x>
#define QT_SINGLETON(x) x : public QObject, public Singleton<x>
#define DECL_SINGLETON(x) friend Singleton<x>;

#endif //QPM_SINGLETON
