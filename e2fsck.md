# e2fsck

Black list bad blocks so that the OS will not use them:

	sudo badblocks -v /dev/sdb > /tmp/bad-blocks.txt
	sudo e2fsck -l /tmp/bad-blocks.txt /dev/sdb

TODO: is black-listing a feature of ext filesystems?
