vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO ThirdEyeSqueegee/CommonLibSSE-NG
  REF 02fcd9d2a2d708cfa2c00587c234f7c8fa1d6b6b
  SHA512 10403c8bad13cb629db0f195a53400cdb1fbba36065d90c75dc81bad6004ea48fe51420d5d73eac7390caf569580231a054be2466f1a2186bdb483e1f987b618
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
