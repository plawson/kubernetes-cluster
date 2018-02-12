#!/bin/bash
ps -ef | grep -i headless | grep -v grep | awk '{print $10}'
