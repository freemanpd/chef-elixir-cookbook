# vars
install_dir = "#{node[:elixir][:art_dir]}"
e_ver = "#{node[:elixir][:erl_ver]}"
elix_ver = "#{node[:elixir][:elixir_ver]}"
arch = "#{node[:elixir][:rpm_arch]}"

# install unzip package
%w{unzip}.each do |pak|
  package "#{pak}" do 
    action :install
  end
end

#to-do:
# ruby_block "update" do
# block do
# back up existing directory, name it the versiion.bak and proceed with installation
# end
#end

# create erlanf and elixir dirs
%w{elixir erlang}.each do |dir|
  directory "#{install_dir}/#{dir}" do
    mode '0755'
    owner 'root'
    group 'root'
    action :create
    recursive true
  end
end

#erlang centos/rhel 6
remote_file "#{install_dir}/erlang/esl-erlang_#{e_ver}.#{arch}.rpm" do
  source "http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_3_general/esl-erlang_#{e_ver}~centos~6_amd64.rpm"
  #       http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_3_general/esl-erlang_17.4-1~centos~6_amd64.rpm
  mode 0755
end

# to-do:
# if centos/rhel 7 
# http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_3_general/esl-erlang_17.4-1~centos~7_amd64.rpm

# install erlang
package "esl-erlang_#{e_ver}" do
  source "#{install_dir}/erlang/esl-erlang_#{e_ver}.#{arch}.rpm"
  action :install
end

# elixir
remote_file "#{install_dir}/elixir/elixir.zip" do
  source "https://github.com/elixir-lang/elixir/releases/download/#{elix_ver}/Precompiled.zip"
  mode 0755
  notifies :run, "execute[elixir-zip]", :immediately
end

# install elixir
execute "elixir-zip" do
  command "unzip /opt/elixir/elixir.zip"
  action :nothing
end

# create elixir system-wide environment viriabled
bash "elixir-profiled" do
  code  <<-EOH
  echo "export PATH="$PATH:/opt/bin"" > /etc/profile.d/elixir.sh
  EOH
  not_if {File.exist?("/etc/profile.d/elixir.sh") }
end

