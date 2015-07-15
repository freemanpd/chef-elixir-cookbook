# vars
install_dir = "#{node[:elixir][:art_dir]}"
erlang_source = "#{node[:elixir][:elang_source]}"
elixir_source = "#{node[:elixir][:elixir_source]}"

# install unzip package
%w{unzip}.each do |pak|
  package "#{pak}" do 
    action :install
  end
end

# create erlang and elixir dirs
%w{elixir erlang}.each do |dir|
  directory "#{install_dir}/#{dir}" do
    mode '0755'
    owner 'root'
    group 'root'
    action :create
    recursive true
  end
end

# download erlang 
remote_file "#{install_dir}/erlang/esl-erlang.rpm" do
  source "#{erlang_source}"
  mode 0755
end

# install erlang
package "esl-erlang" do
  source "#{install_dir}/erlang/esl-erlang.rpm"
  action :install
end

# elixir
remote_file "#{install_dir}/elixir/elixir.zip" do
  source "#{elixir_source}"
  mode 0755
  notifies :run, "execute[elixir-zip]", :immediately
end

# install elixir
execute "elixir-zip" do
  command "unzip #{install_dir}/elixir/elixir.zip"
  action :nothing
end

# create elixir system-wide environment variables
bash "elixir-profiled" do
  code  <<-EOH
  echo "export PATH="$PATH:#{install_dir}/bin"" > /etc/profile.d/elixir.sh
  EOH
  not_if {File.exist?("/etc/profile.d/elixir.sh") }
end

