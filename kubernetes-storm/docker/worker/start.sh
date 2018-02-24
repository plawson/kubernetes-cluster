#!/bin/sh

/configure.sh ${ZK_CS_SERVICE_HOST:-$1} ${NIMBUS_SERVICE_HOST:-$2}

exec bin/storm supervisor -c storm.local.hostname=$(hostname -i | awk '{print $1;}')
