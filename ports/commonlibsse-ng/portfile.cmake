vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO ThirdEyeSqueegee/CommonLibSSE-NG
  REF a529024adce7aa6be2f44253272123a597983538
  SHA512 5ba7132b31a458d0b44875dbc41fc5c99bda6c7bfacde7ae7e9f30949ee6ff8f16d9b3f4fbe81a80c12cae3981f0f458d2de6ffdd8c9dda8f73d5020254f20dc
  HEAD_REF main
)

vcpkg_check_features(
  OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
  xbyak SKSE_SUPPORT_XBYAK
)

vcpkg_cmake_configure(
  SOURCE_PATH ${SOURCE_PATH}
  OPTIONS ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
  PACKAGE_NAME CommonLibSSE
  CONFIG_PATH lib/cmake
)

vcpkg_copy_pdbs()

file(GLOB CMAKE_CONFIGS ${CURRENT_PACKAGES_DIR}/share/CommonLibSSE/CommonLibSSE/*.cmake)

file(
  INSTALL ${CMAKE_CONFIGS}
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/CommonLibSSE
)
file(
  INSTALL ${SOURCE_PATH}/cmake/CommonLibSSE.cmake
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/CommonLibSSE
)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/CommonLibSSE/CommonLibSSE)

file(
  INSTALL ${SOURCE_PATH}/LICENSE
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT}
  RENAME copyright
)
