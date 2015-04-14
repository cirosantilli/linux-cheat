File.open(File.join(Dir.tmpdir, "cookbook0_default.tmp"), 'w') do |f|

  ##output ##log

    # Log is the best way of givint output:

      log "log ========================================"
      log "debug log" do
        level :debug
      end

    # How stdout looks:

      puts "STDOUT ========================================"

    # To make things less messy we will be outputting to a file:

      f.puts(Time.now.to_s)

  ##attributes

      node[:cookbook0][:a] == "b" or raise
      node[:cookbook0][:override] == "d" or raise
      node[:anything][:a]  == "c" or raise

  ##user and relative paths

    # The commands run as the root user.

    # Relative paths are relative to the root `/`,
    # so you probably don't want to use relative paths.

      f.puts("Process.euid = " + Process.euid.to_s)

  ##file

      file File.join(Dir.tmpdir, "cookbook0_default_file.tmp") do
        content Time.now.to_s
        #owner "root"     # root is the default user
        #group "root"
        mode "0666"
        #action :create   # create is the default action
      end

    # Double create overwrites the files:

      file File.join(Dir.tmpdir, "cookbook0_default_file.tmp") do
        content "second time: " + Time.now.to_s
        mode "0666"
      end

  ##template

    # Generates a file from an erb template located under `templates/default`.

    # Typically used for config files which vary from installation to isntallation.

      template File.join(Dir.tmpdir, "cookbook0_template.tmp") do
        source "cookbook0_template.tmp.erb"
        # Do not use `a:` as chef may still be running on Ruby 1.8.
        variables({:a=> '0', :b=> '1'})
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

  # A safe place to write temporary files to.
  # On Chef 1.4.3 on Ubuntu 12.04 this equals `/var/chef/cache`.

    f.puts("Chef::Config[:file_cache_path] = " + Chef::Config[:file_cache_path])

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

      # TODO why fails
      #package "vim"

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
        #password "a"     # TODO. Fails if done twice only is password given?
        #action :create   # Default action.
                          # On Linux does `useradd`.
                          # Will fail if done twice.
      end

  ##git

    # Do git clone to get new directories, and git pull to get new versions.

    # Seems to operate on current branch.

    # At clone automatically creates a branch named `deploy`.

    # Common combo: decide version from an attribute:

      #if node.chef_environment == "production"
        #ref = "1.2"
      #else
        #ref = "master"
      #end

    # The path the clone will be cloned to:

      path = File.join(Chef::Config[:file_cache_path], "git")

    # If relative, relative to `/`.

      git path do
        repository "https://github.com/cirosantilli/small.git"
        reference 'master' # Specify a version, such as a branch head or hash.
                           # Default is master.
        #action :sync  # Clone, or pull.
                       # Overwrites local commited changes, so this is not a good choice for development.
                       # Creates a branch called `deploy` TODO why and how to avoid it?
        #notifies :run, "bash[compile_libvpx]"  # Often used to do something after clone.
      end

      git File.join(Chef::Config[:file_cache_path], "git-checkout") do
        repository "https://github.com/cirosantilli/small.git"
        action :checkout  # If checkout is possible, checkout and do nothing else.
                          # Therefore, if the checkout is a branch, you don't lose local changes.
      end
end
