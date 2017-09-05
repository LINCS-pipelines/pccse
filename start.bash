#!/bin/bash
find . -name "*.gct" -exec sed -i.back 's/\"/\"\"/g; s/[{]/\"\{/g; s/\}/\}\"/g; ' {} \;
