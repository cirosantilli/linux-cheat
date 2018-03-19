# OverlayFS

<https://askubuntu.com/questions/699565/example-overlayfs-usage>

Basic:

    mkdir -p lower upper work overlay
    sudo mount -t overlay -o lowerdir=lower,upperdir=upper,workdir=work none overlay
    touch lower/a upper/b overlay/c
    ls lower upper overlay
    sudo umount overlay

Outcome:

    lower:
    a

    overlay:
    a  b  c

    upper:
    b  c

Preparing to override root:

    mkdir -p lower lower/upper lower/work overlay
    sudo mount -t overlay -o lowerdir=lower,upperdir=lower/upper,workdir=lower/work none lower
    touch lower/a lower/upper/b
    ls lower lower/upper
    sudo umount overlay
