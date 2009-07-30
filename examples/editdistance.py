#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import sys
sys.path.insert(0, '../')
from onp import onp

if __name__ == "__main__":
    diff = onp(sys.argv[1], sys.argv[2])
    diff.compose()
    print diff.getEditDistance()

