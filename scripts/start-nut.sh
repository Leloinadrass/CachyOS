# ~/.local/bin/start-nut.sh
#!/bin/bash
/usr/bin/upsdrvctl start
/usr/bin/upsd
/usr/bin/upsmon
