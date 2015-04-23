# lpoptions

Configure the CUPS printing commands like `lp`.

Configuration files:

- `~/.cups/lpoptions`
- `/etc/cups/lpoptions`

## d

Set the default printer:

    lpstat -a

Sample output:

    XP-202-203-206-Series accepting requests since Wed 22 Apr 2015 05:55:22 PM CEST

Then:

    lpoptions -d XP-202-203-206-Series

## l

List custom printig options for the given printer:

    lpoptions -l

Sample output for an Epson XP-202

    PageSize/Paper Size: 4X6FULL T4X6FULL 2L T2L *A4 TA4 L TL Postcard TPostcard INDEX5
    MediaType/Media Type: PMPHOTO_NORMAL PLATINA_NORMAL GLOSSYPHOTO_NORMAL GLOSSYCAST_NORMAL PMMATT_NORMAL *PLAIN_NORMAL RCPC_NORMAL
    Ink/Ink: *COLOR MONO

## o

Set a default option.

Merges existing options with the one given.

the options are modified under `~/.cups/lpoptions`.
