set(PROJECT_SOURCES

		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/main.cpp"
		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/ui/AuthController.hpp"
		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/ui/AuthController.cpp"
		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/ui/ProjectsListModel.hpp"
		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/ui/ProjectsListModel.cpp"
		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/ui/TicketsListModel.hpp"
		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/ui/TicketsListModel.cpp"

		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/model/Ticket.hpp"
		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/model/Ticket.cpp"
		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/model/Project.hpp"
		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/model/Project.cpp"

		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/api/Api.hpp"
		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/api/Api.cpp"
        "${CMAKE_CURRENT_SOURCE_DIR}/cpp/api/ApiLink.hpp"
		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/api/ApiWrapper.hpp"
		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/api/ApiWrapper.cpp"

		"${CMAKE_CURRENT_SOURCE_DIR}/cpp/util/Singleton.hpp"

		PARENT_SCOPE)
