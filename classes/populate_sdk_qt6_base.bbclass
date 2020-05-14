inherit qt6-paths

create_sdk_files_prepend () {
    # Generate a qt.conf file to be deployed with the SDK
    qtconf=${SDK_OUTPUT}/${SDKPATHNATIVE}${QT6_INSTALL_BINDIR}/qt.conf
    touch $qtconf
    echo '[Paths]' >> $qtconf
    echo 'Prefix = ${OE_QMAKE_PATH_PREFIX}' >> $qtconf
    echo 'Headers = ${OE_QMAKE_PATH_QT_HEADERS}' >> $qtconf
    echo 'Libraries = ${OE_QMAKE_PATH_LIBS}' >> $qtconf
    echo 'ArchData = ${OE_QMAKE_PATH_QT_ARCHDATA}' >> $qtconf
    echo 'Data = ${OE_QMAKE_PATH_QT_DATA}' >> $qtconf
    echo 'Binaries = ${OE_QMAKE_PATH_QT_BINS}' >> $qtconf
    echo 'LibraryExecutables = ${OE_QMAKE_PATH_LIBEXECS}' >> $qtconf
    echo 'Plugins = ${OE_QMAKE_PATH_PLUGINS}' >> $qtconf
    echo 'Qml2Imports = ${OE_QMAKE_PATH_QML}' >> $qtconf
    echo 'Translations = ${OE_QMAKE_PATH_QT_TRANSLATIONS}' >> $qtconf
    echo 'Documentation = ${OE_QMAKE_PATH_QT_DOCS}' >> $qtconf
    echo 'Settings = ${OE_QMAKE_PATH_QT_SETTINGS}' >> $qtconf
    echo 'Examples = ${OE_QMAKE_PATH_QT_EXAMPLES}' >> $qtconf
    echo 'Tests = ${OE_QMAKE_PATH_QT_TESTS}' >> $qtconf
    echo 'HostPrefix = ${SDKPATHNATIVE}' >> $qtconf
    echo 'HostData = ${SDKTARGETSYSROOT}${OE_QMAKE_PATH_QT_ARCHDATA}' >> $qtconf
    echo 'HostBinaries = ${SDKPATHNATIVE}${OE_QMAKE_PATH_HOST_BINS}' >> $qtconf
    echo 'HostLibraries = ${SDKPATHNATIVE}${OE_QMAKE_PATH_LIBS}' >> $qtconf
    echo 'Sysroot = ${SDKTARGETSYSROOT}' >> $qtconf

    # Generate a toolchain file for using Qt without running setup-environment script
    cat > ${SDK_OUTPUT}/${SDKPATHNATIVE}/usr/share/cmake/Qt6Toolchain.cmake <<EOF
set(ENV{CC} "${TARGET_PREFIX}gcc ${TARGET_CC_ARCH} --sysroot=${SDKTARGETSYSROOT}")
set(ENV{CXX} "${TARGET_PREFIX}g++ ${TARGET_CC_ARCH} --sysroot=${SDKTARGETSYSROOT}")

set(ENV{CFLAGS} "${TARGET_CFLAGS}")
set(ENV{CXXFLAGS} "${TARGET_CXXFLAGS}")

set(ENV{OECORE_NATIVE_SYSROOT} "${SDKPATHNATIVE}")
set(ENV{OECORE_TARGET_SYSROOT} "${SDKTARGETSYSROOT}")
set(ENV{SDKTARGETSYSROOT} "${SDKTARGETSYSROOT}")

set(CMAKE_TOOLCHAIN_FILE "${SDKPATHNATIVE}/usr/share/cmake/OEToolchainConfig.cmake")
include("\${CMAKE_TOOLCHAIN_FILE}")
EOF
}

# default debug prefix map isn't valid in the SDK
DEBUG_PREFIX_MAP = ""
SECURITY_CFLAGS = ""
