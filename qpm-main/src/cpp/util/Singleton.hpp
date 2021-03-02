// Copyright (c) 2021 udv. All rights reserved.

#ifndef QPM_SINGLETON
#define QPM_SINGLETON

#include <mutex>
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
            static T instance;
            return instance;
        }

		// forbidden
		ref operator=(const_ref other) = delete;
        Singleton(const_ref other) = delete;
    };
}

// Some macros
#define SINGLETON(x) x : public Singleton<x>
#define QT_SINGLETON(x) x : public QObject, public Singleton<x>
#define DECL_SINGLETON(x) friend Singleton<x>;

#endif //QPM_SINGLETON
