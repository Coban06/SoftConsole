# -----------------------------------------------------------------------------
# This file is part of the xPacks distribution.
#   (https://xpack.github.io)
# Copyright (c) 2019 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software 
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# Helper script used in the second edition of the GNU MCU Eclipse build 
# scripts. As the name implies, it should contain only functions and 
# should be included with 'source' by the container build scripts.

# -----------------------------------------------------------------------------

function prepare_versions()
{
  # The \x2C is a comma in hex; without this trick the regular expression
  # that processes this string in the Makefile, silently fails and the 
  # bfdver.h file remains empty.
  BRANDING="${BRANDING}\x2C ${TARGET_MACHINE}"

  OPENOCD_PROJECT_NAME="openocd"
  OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-""}
  README_OUT_FILE_NAME="README-${RELEASE_VERSION}.md"

  OPENOCD_SRC_FOLDER_NAME=${OPENOCD_SRC_FOLDER_NAME:-"${OPENOCD_PROJECT_NAME}.git"}
  OPENOCD_GIT_URL=${OPENOCD_GIT_URL:-"https://github.com/xpack-dev-tools/openocd.git"}

  LIBFTDI_PATCH=""
  LIBUSB_W32_PATCH=""

  USE_TAR_GZ="y"
  USE_SINGLE_FOLDER_PATH="y"

  # Keep them in sync with combo archive content.
  if [[ "${RELEASE_VERSION}" =~ 0\.10\.0-14 ]]
  then

    # -------------------------------------------------------------------------
    
    OPENOCD_VERSION="0.10.0-14"

    # Used in the licenses folder.
    OPENOCD_FOLDER_NAME="openocd-${OPENOCD_VERSION}"

    OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack"}
    # OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack-develop"}
    OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-"e5be992df1a893e2e865419a02a564d5f9ccd9dd"}
    
    # -------------------------------------------------------------------------

    do_libusb1 "1.0.22"
    if [ "${TARGET_PLATFORM}" == "win32" ]
    then
      do_libusb_w32 "1.2.6.0"
    else
      do_libusb0 "0.1.5"
    fi

    do_libftdi "1.4"

    build_libiconv "1.15"

# MICROSEMI MODs
# by switching to libusb repository of the hidapi, we can use newer releases
    do_hidapi "0.9.0"
# /MICROSEMI MODs    

    # -------------------------------------------------------------------------
echo "--- do_openocd --- begin"
    do_openocd
echo "--- do_openocd --- end"

echo "--- run_openocd --- begin"
    run_openocd
echo "--- run_openocd --- end"

    # -------------------------------------------------------------------------
  elif [[ "${RELEASE_VERSION}" =~ 0\.10\.0-13 ]]
  then

    # -------------------------------------------------------------------------
    
    OPENOCD_VERSION="0.10.0-13"

    # Used in the licenses folder.
    OPENOCD_FOLDER_NAME="openocd-${OPENOCD_VERSION}"

    OPENOCD_GIT_BRANCH=${OPENOCD_GIT_BRANCH:-"xpack"}
    OPENOCD_GIT_COMMIT=${OPENOCD_GIT_COMMIT:-"191d1b176cf32280fc649d3c5afcff44d6205daf"}
    
    # -------------------------------------------------------------------------

    USE_TAR_GZ=""

    do_libusb1 "1.0.22"
    if [ "${TARGET_PLATFORM}" == "win32" ]
    then
      do_libusb_w32 "1.2.6.0"
    else
      do_libusb0 "0.1.5"
    fi

    do_libftdi "1.4"

    build_libiconv "1.15"

# MICROSEMI MODs
# by switching to libusb repository of the hidapi, we can use newer releases
    do_hidapi "0.9.0"   
# /MICROSEMI MODs


    # -------------------------------------------------------------------------
echo "--- do_openocd --- begin"
    do_openocd
echo "--- do_openocd --- end"

echo "--- run_openocd --- begin"
    run_openocd
echo "--- run_openocd --- end"

    # -------------------------------------------------------------------------
  else
    echo "Unsupported version ${RELEASE_VERSION}."
    exit 1
  fi
}

# -----------------------------------------------------------------------------
