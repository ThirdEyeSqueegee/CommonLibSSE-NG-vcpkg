vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO ThirdEyeSqueegee/CommonLibSSE-NG
  REF 6f4b12c095f06a5c22f21e8e45409675fee2a753
  SHA512 20697f657add7993f386542bb1f6c1570b42d1befd85e94058d858b95efc4f928b19d17b34ad29ff180cbe25bf3a15a24fb191500de9b27cfb04113a91390f67
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
