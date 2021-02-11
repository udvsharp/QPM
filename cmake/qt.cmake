list(APPEND CMAKE_PREFIX_PATH "${QPM_QT_PATH}")

# Check paths
if (NOT CMAKE_PREFIX_PATH)
	message(WARNING "CMAKE_PREFIX_PATH is not defined, you may need to set it "
			"(-DCMAKE_PREFIX_PATH=\"path/to/Qt/lib/cmake\" or -DCMAKE_PREFIX_PATH=/usr/include/{host}/qt{version}/ on Ubuntu)")
endif ()

# Qualified names
set(REQUIRED_QT_LIBS_QUALIFIED)
foreach (QT_LIB IN LISTS REQUIRED_QT_LIBS)
	list(APPEND REQUIRED_QT_LIBS_QUALIFIED Qt${QT_VERSION_MAJOR}::${QT_LIB})
endforeach ()

# Append lists
list(APPEND REQUIRED_LIBS_QUALIFIED ${REQUIRED_QT_LIBS_QUALIFIED})
list(APPEND REQUIRED_LIBS ${REQUIRED_QT_LIBS})

# Find Packages
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS ${REQUIRED_QT_LIBS} REQUIRED)

set(QT_DEFAULT_POSTBUILD_TARGET_NAME Qt${QT_VERSION_MAJOR}CopyBinaries)

# Build steps
macro (configure_qt_for TARGET_NAME)
	message(STATUS "Adding post-build Qt steps to ${TARGET_NAME}")

	if (WIN32)
		# Figure out binaries path
		set(QT_INSTALL_PATH "${CMAKE_PREFIX_PATH}")
		if (NOT EXISTS "${QT_INSTALL_PATH}/bin")
			set(QT_INSTALL_PATH "${QT_INSTALL_PATH}/..")
			if (NOT EXISTS "${QT_INSTALL_PATH}/bin")
				set(QT_INSTALL_PATH "${QT_INSTALL_PATH}/..")
			endif ()
		endif ()
		set(QT_BIN_PATH "${QT_INSTALL_PATH}/bin")
		set(QT_PLUGINS_PATH "${QT_INSTALL_PATH}/plugins")
		set(QT_QML_PATH "${QT_INSTALL_PATH}/qml")

		# Fix debug postfixes
		set(DEBUG_SUFFIX)
		if (CMAKE_BUILD_TYPE MATCHES "Debug" AND MSVC)
			set(DEBUG_SUFFIX "d")
		endif ()

		# Copy windows platform dll
		if (EXISTS "${QT_INSTALL_PATH}/plugins/platforms/qwindows${DEBUG_SUFFIX}.dll")
			add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
					COMMAND ${CMAKE_COMMAND} -E make_directory
					"$<TARGET_FILE_DIR:${TARGET_NAME}>/plugins/platforms/")

			add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
					COMMAND ${CMAKE_COMMAND} -E copy
					"${QT_INSTALL_PATH}/plugins/platforms/qwindows${DEBUG_SUFFIX}.dll"
					"$<TARGET_FILE_DIR:${TARGET_NAME}>/plugins/platforms/")
		endif ()

		#		# Copy Default DLLs
		#		add_custom_target(${QT_DEFAULT_POSTBUILD_TARGET_NAME}
		#				# Copy
		#				COMMAND ${CMAKE_COMMAND} -E copy "${QT_INSTALL_PATH}/bin/Qt${QT_VERSION_MAJOR}Core${DEBUG_SUFFIX}.dll"     "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
		#				COMMAND ${CMAKE_COMMAND} -E copy "${QT_INSTALL_PATH}/bin/Qt${QT_VERSION_MAJOR}Gui${DEBUG_SUFFIX}.dll"      "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
		#				COMMAND ${CMAKE_COMMAND} -E copy "${QT_INSTALL_PATH}/bin/Qt${QT_VERSION_MAJOR}Network${DEBUG_SUFFIX}.dll"  "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
		#				COMMAND ${CMAKE_COMMAND} -E copy "${QT_INSTALL_PATH}/bin/Qt${QT_VERSION_MAJOR}OpenGL${DEBUG_SUFFIX}.dll"   "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
		#				COMMAND ${CMAKE_COMMAND} -E copy "${QT_INSTALL_PATH}/bin/Qt${QT_VERSION_MAJOR}Sql${DEBUG_SUFFIX}.dll"      "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
		#				COMMAND ${CMAKE_COMMAND} -E copy "${QT_INSTALL_PATH}/bin/Qt${QT_VERSION_MAJOR}Widgets${DEBUG_SUFFIX}.dll"  "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
		#				COMMAND ${CMAKE_COMMAND} -E copy "${QT_INSTALL_PATH}/bin/Qt${QT_VERSION_MAJOR}Xml${DEBUG_SUFFIX}.dll"      "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
		#				# Output Message
		#				COMMENT "Copying Qt binaries from '${QT_INSTALL_PATH}/bin' to '${CMAKE_BINARY_DIR}'" VERBATIM
		#				)
		#
		#		# Copy required dlls
		#		foreach (QT_LIB ${REQUIRED_QT_LIBS})
		#			add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
		#					COMMAND ${CMAKE_COMMAND} -E copy
		#					"${QT_INSTALL_PATH}/bin/Qt${QT_VERSION_MAJOR}${QT_LIB}${DEBUG_SUFFIX}.dll"
		#					"$<TARGET_FILE_DIR:${TARGET_NAME}>")
		#		endforeach ()
		#
		#		# TODO: fix QML copying
		#		add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
		#				COMMAND ${CMAKE_COMMAND} -E copy_directory
		#				"${QT_INSTALL_PATH}/qml"
		#				"$<TARGET_FILE_DIR:${TARGET_NAME}>/qml")
		#
		#		add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
		#				COMMAND ${CMAKE_COMMAND} -E copy_directory
		#				"${QT_INSTALL_PATH}/plugins"
		#				"$<TARGET_FILE_DIR:${TARGET_NAME}>/plugins")

		# Copy Qt directories
		# TODO: find more efficient way to copy only required DLLs
		add_custom_target(${QT_DEFAULT_POSTBUILD_TARGET_NAME}
				COMMAND ${CMAKE_COMMAND} -E copy_directory "${QT_INSTALL_PATH}/bin" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
				COMMAND ${CMAKE_COMMAND} -E copy_directory "${QT_INSTALL_PATH}/plugins" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
				COMMAND ${CMAKE_COMMAND} -E copy_directory "${QT_INSTALL_PATH}/qml" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"

				COMMENT "Copying Qt binaries from '${QT_INSTALL_PATH}/bin' to '${CMAKE_BINARY_DIR}'" VERBATIM
				)

		# TO be run by hand
		#		add_dependencies(${TARGET_NAME} ${QT_DEFAULT_POSTBUILD_TARGET_NAME})
	endif ()
endmacro ()