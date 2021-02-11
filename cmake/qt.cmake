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

# Build steps
macro (qt_postbuild TARGET_NAME)
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

		# Copy Qt directories
		# TODO: find more efficient way to copy only required DLLs
		add_custom_command(TARGET ${TARGET_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${QT_INSTALL_PATH}/bin $<TARGET_FILE_DIR:${TARGET_NAME}>)
		add_custom_command(TARGET ${TARGET_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${QT_INSTALL_PATH}/plugins $<TARGET_FILE_DIR:${TARGET_NAME}>)
		add_custom_command(TARGET ${TARGET_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${QT_INSTALL_PATH}/qml $<TARGET_FILE_DIR:${TARGET_NAME}>)
	endif ()
endmacro ()