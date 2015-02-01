# Time zone

## Set you time zone

On dual boot with windows there are conflicts because Windows uses local time,
and Linux UTC (more logical...). you must either tell Linux to use local,
or better, Windows to use UTC.

    TIMEZONE_LOCATION=/usr/share/zoneinfo
    cd "$TIMEZONE_LOCATION"
    ls
    TIMEZONE_NAME=
    cp "$TIMEZONE_LOCATION/$TIMEZONE_NAME" /etc/localtime
