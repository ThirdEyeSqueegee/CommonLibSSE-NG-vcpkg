vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO gabime/spdlog
  REF 1.14.1
  SHA512 2dc1f1d8dd3a4733442d9c7ff2583469321068d8ee16df0ccd4561b0ff8654cf5ac62b72ed7b1c9f8241e4fdf8020eddccffee57ed4d2e8e7eafd9a56e71a0d6
  HEAD_REF v1.x
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
  wchar SPDLOG_WCHAR_SUPPORT
)

# SPDLOG_WCHAR_FILENAMES can only be configured in triplet file since it is an alternative (not additive)
if(NOT DEFINED SPDLOG_WCHAR_FILENAMES)
  set(SPDLOG_WCHAR_FILENAMES OFF)
endif()

if(NOT VCPKG_TARGET_IS_WINDOWS AND SPDLOG_WCHAR_FILENAMES)
  message(FATAL_ERROR "Build option 'SPDLOG_WCHAR_FILENAMES' is for Windows.")
endif()

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" SPDLOG_BUILD_SHARED)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
  ${FEATURE_OPTIONS}
  -DSPDLOG_USE_STD_FORMAT=ON
  -DSPDLOG_INSTALL=ON
  -DSPDLOG_BUILD_SHARED=${SPDLOG_BUILD_SHARED}
  -DSPDLOG_WCHAR_FILENAMES=${SPDLOG_WCHAR_FILENAMES}
  -DSPDLOG_BUILD_EXAMPLE=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/spdlog)
vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

if(SPDLOG_WCHAR_SUPPORT)
  vcpkg_replace_string(${CURRENT_PACKAGES_DIR}/include/spdlog/tweakme.h
    "// #define SPDLOG_WCHAR_TO_UTF8_SUPPORT"
    "#ifndef SPDLOG_WCHAR_TO_UTF8_SUPPORT\n#define SPDLOG_WCHAR_TO_UTF8_SUPPORT\n#endif"
  )
endif()

if(SPDLOG_WCHAR_FILENAMES)
  vcpkg_replace_string(${CURRENT_PACKAGES_DIR}/include/spdlog/tweakme.h
    "// #define SPDLOG_WCHAR_FILENAMES"
    "#ifndef SPDLOG_WCHAR_FILENAMES\n#define SPDLOG_WCHAR_FILENAMES\n#endif"
  )
endif()

file(REMOVE_RECURSE
  "${CURRENT_PACKAGES_DIR}/debug/include"
  "${CURRENT_PACKAGES_DIR}/debug/share"
)

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
