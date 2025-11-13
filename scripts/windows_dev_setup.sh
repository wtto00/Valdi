#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

pushd "$SCRIPT_DIR"

if command -v swift >/dev/null 2>&1; then
    echo "Swift has been installed."
    exit 0
fi

SWIFT_VERSION=6.2.1
echo
echo "********************************************************************************"
echo "Installing Swift: $SWIFT_VERSION"

winget install --id Swift.Toolchain -e -v $SWIFT_VERSION

RC_FILE="$HOME/.bash_profile"
SWIFT_BIN_DIR=/c/Users/wtto/AppData/Local/Programs/Swift/Toolchains/6.2.1+Asserts/usr/bin
echo
echo "********************************************************************************"
echo "Updating PATH to contain the Swift toolchain binaries..."
if [[ $PATH == *"$SWIFT_BIN_DIR"* ]]; then
    echo "PATH already contains $SWIFT_BIN_DIR!"
else
    echo "" >>"$RC_FILE"
    echo "export PATH=\"$SWIFT_BIN_DIR:\${PATH}\"" >>"$RC_FILE"
fi

# echo
# echo "********************************************************************************"
# echo "Updating LD_LIBRARY_PATH to contain the Swift toolchain libraries..."
# if [[ $LD_LIBRARY_PATH == *"$SWIFT_LIBS_DIR"* ]]; then
#     echo "LD_LIBRARY_PATH already contains $SWIFT_LIBS_DIR!"
# else
#     echo "" >>"$RC_FILE"
#     echo "export LD_LIBRARY_PATH=\"$SWIFT_LIBS_DIR:\${LD_LIBRARY_PATH}\"" >>"$RC_FILE"
# fi
# popd

# echo
# echo "********************************************************************************"
# echo "Updating LD_LIBRARY_PATH to contain the path to the JavaScriptCore dynamic library..."
# JSCORE_LIB_DIR="$SCRIPT_DIR/../../third-party/jscore/libs/linux/x86_64"
# if [[ $LD_LIBRARY_PATH == *"$JSCORE_LIB_DIR"* ]]; then
#     echo "LD_LIBRARY_PATH already contains $JSCORE_LIB_DIR!"
# else
#     echo "" >>"$RC_FILE"
#     echo "export LD_LIBRARY_PATH=\"$JSCORE_LIB_DIR:\${LD_LIBRARY_PATH}\"" >>"$RC_FILE"
# fi
popd

source "$RC_FILE"
