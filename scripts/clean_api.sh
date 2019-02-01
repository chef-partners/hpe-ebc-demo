#!/bin/sh

curl -sSX POST "https://ebcdemochefauto2.hpelab/api/v0/retention/nodes/delete-nodes/config" -k -d '{
  "threshold": "1m",
  "every": "5m",
  "running": true
}' -H "api-token: heR0GS0epk3LS8oJY8Y8wq0FtPA="
