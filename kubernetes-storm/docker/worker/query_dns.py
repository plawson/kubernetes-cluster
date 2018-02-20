#!/usr/bin/env python3

import socket

(hostname, aliaslist, ipaddrlist) = socket.gethostbyname_ex('kafka-hs')
for ipaddr in ipaddrlist:
    (hostname, aliaslist, hostip) = socket.gethostbyaddr(ipaddr)
    print('{}\t{}'.format(hostip[0], hostname))
