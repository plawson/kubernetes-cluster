#!/bin/sh

/configure.sh ${ZK_CS_SERVICE_HOST:-$1}

exec bin/storm nimbus
