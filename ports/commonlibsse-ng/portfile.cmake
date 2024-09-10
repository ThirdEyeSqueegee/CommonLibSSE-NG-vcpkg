vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO ThirdEyeSqueegee/CommonLibSSE-NG
  REF faf455d977012a48784f48308fa9bab6b9ce0ab7
  SHA512 a0142490f59761bed08bb3a6780a8c33942b80ac0b8acebf07500af45c152fdc700fb6755e6cfb84908a053bfe41fc36f39068bf6cdf20ed39bb45b4da6ae49f
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

file(
  INSTALL ${SOURCE_PATH}/LICENSE
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT}
  RENAME copyright
)
