# GPT

Arbitrary amount of primary partitions.

<https://en.wikipedia.org/wiki/GUID_Partition_Table>

Newer than MBR, in the process of replacing it.

No logical partitions since we can have a lot of base partitions.

You should unmount partitions before making change to them.

To get info on partitions, start/end, filesystem type and flags, consider: `parted`, `df -f`
