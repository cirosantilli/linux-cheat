File.open("/tmp/cookbook0_default.tmp", 'w') do |f|


  node[:cookbook0][:a] == "b" or raise
  node[:cookbook0][:override] == "d" or raise
  node[:anything][:a]  == "c" or raise

  f.puts(Time.now.to_s)

  ##user and relative paths

    # The commands run as the root user.

    # Relative paths are relative to the root `/`,
    # so you probably don't want to use relative paths.

      f.puts("Process.euid = " + Process.euid.to_s)

  ##file

      file "/tmp/cookbook0_default_file.tmp" do
        content Time.now.to_s
        #owner "root"     # root is the default user
        #group "root"
        mode "0666"
        #action :create   # create is the default action
      end

  ##platform detection

    # `node[:platform]` the following contains a string which identifies the current platform.

    # Possible values include:

    # - "ubuntu"
    # - "debian"
    # - "centos"
    # - "redhat"
    # - "windows"

      f.puts("node[:platform] = " + node[:platform])

  ##directory

  ##env

    # Permanentl sets environment variables on the system.

    # Only works for Windows.

      #env "CHEF_TEST_KEY" do
        #value "CHEF_TEST_VAL"
      #end

  ##package

    # Installs using the native package manager.

    # On Ubuntu 13.04 does `sudo apt-get install $NAME`.

    # If package names are different on different platforms, a `case` statement is needed.

    # If any incompatibility is met such as package conflicts the provision fails.

      package "git" do
        #version "1.7.0"
        #action :install  # default action
      end

  ##group

    # Manage user groups.

      group "newuser" do
      end

  ##user

    # Manage users on the system.

      user "newuser" do
        supports :manage_home => true  # Creates home directory if that is supported.
                                    # On Windows for example, home is only created after the first user login.
        gid "newuser"     # Must already exist before creating the user!
        password "a"
        #action :create   # Default action.
                          # On Linux does `useradd`.
                          # Will fail if done twice.
      end

  ##git

end
