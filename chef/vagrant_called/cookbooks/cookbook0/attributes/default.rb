# Sets default values for attributes.
# Attributes are visible on the recipes as: `node[:cookbook0][:a]`
default[:cookbook0][:a] = "b"
default[:cookbook0][:override] = "b"

# It is not mandatory to use the cookbook name as the first part of the attribute,
# although it is a very common and sane practice.
default[:anything][:a]  = "c"
