vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO ThirdEyeSqueegee/CommonLibSSE-NG
  REF f163af505f6a9b9bb7bb511e55df12280a7be7f0
  SHA512 91ad650998bcc5e49b74a0481be4762cdd9ab42547d65ea117e983ec54b8d332cd709f770e58d017001833a6206a89bcac42fd6aa0f5504257f17e86f73f4ad0
  HEAD_REF main
)

vcpkg_check_features(
  OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
  xbyak SKSE_SUPPORT_XBYAK
  INVERTED_FEATURES
  flatrim ENABLE_SKYRIM_VR
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
  INSTALL ${SOURCE_PATH}/cmake/CommonLibSSE.cmake ${SOURCE_PATH}/cmake/FindOpenVR.cmake
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/CommonLibSSE
)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/CommonLibSSE/CommonLibSSE)

file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})

vcpkg_install_copyright(FILE_LIST ${SOURCE_PATH}/LICENSE)
