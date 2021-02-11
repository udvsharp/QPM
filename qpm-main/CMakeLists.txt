set(PROJECT_SOURCES)
set(PROJECT_RESOURCES)

add_subdirectory(src)
add_subdirectory(res)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(${QPM_TARGET_NAME}
        ${PROJECT_SOURCES}
        ${PROJECT_RESOURCES}
    )
else()
    if(ANDROID)
        add_library(${QPM_TARGET_NAME} SHARED
            ${PROJECT_SOURCES}
            ${PROJECT_RESOURCES}
        )
    else()
        add_executable(${QPM_TARGET_NAME}
            ${PROJECT_SOURCES}
            ${PROJECT_RESOURCES}
        )
    endif()
endif()

qt_postbuild(${QPM_TARGET_NAME})