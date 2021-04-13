TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += EMIL_PZI_00Support

# Compile and add code to the support library
EMIL_PZI_00Support_SRCS += xxxRecord.c
EMIL_PZI_00Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
EMIL_PZI_00Support_SRCS += dbSubExample.c
EMIL_PZI_00Support_SRCS += devEMIL_PZI_00Version.c
EMIL_PZI_00Support_SRCS += EMIL_PZI_00Hello.c
EMIL_PZI_00Support_SRCS += initTrace.c

EMIL_PZI_00Support_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = EMIL_PZI_00Version.h
# Macro name
GENVERSIONMACRO = EMIL_PZI_00VERSION

# Build the IOC application
PROD_IOC = EMIL_PZI_00

# EMIL_PZI_00.dbd will be created and installed
DBD += EMIL_PZI_00.dbd

# EMIL_PZI_00.dbd will include these files:
EMIL_PZI_00_DBD += base.dbd
EMIL_PZI_00_DBD += xxxSupport.dbd
EMIL_PZI_00_DBD += dbSubExample.dbd
EMIL_PZI_00_DBD += devEMIL_PZI_00Version.dbd
EMIL_PZI_00_DBD += EMIL_PZI_00Hello.dbd
EMIL_PZI_00_DBD += initTrace.dbd

# EMIL_PZI_00_registerRecordDeviceDriver.cpp derives from EMIL_PZI_00.dbd
EMIL_PZI_00_SRCS += EMIL_PZI_00_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
EMIL_PZI_00_SRCS_DEFAULT += EMIL_PZI_00Main.cpp
EMIL_PZI_00_SRCS_vxWorks += -nil-

# Link in the code from our support library
EMIL_PZI_00_LIBS += EMIL_PZI_00Support

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into EMIL_PZI_00Support
    sncExample_SNCFLAGS += +r
    EMIL_PZI_00_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    EMIL_PZI_00Support_SRCS += sncExample.stt
    EMIL_PZI_00Support_LIBS += seq pv
    EMIL_PZI_00_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    EMIL_PZI_00_LIBS += qsrv
    EMIL_PZI_00_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    EMIL_PZI_00_DBD += PVAServerRegister.dbd
    EMIL_PZI_00_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
EMIL_PZI_00_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devEMIL_PZI_00Version$(DEP): $(COMMON_DIR)/$(GENVERSION)
