#!/bin/sh

/configure.sh ${ZK_CS_SERVICE_HOST:-$1} ${NIMBUS_SERVICE_HOST:-$2}

exec bin/storm ui
