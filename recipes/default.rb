#
# Cookbook Name:: vagrant
# Recipe:: default
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

remote_file ::File.join(Chef::Config[:file_cache_path], node["vagrant"]["package_file"]) do
  source node["vagrant"]["package_url"]
  action :create_if_missing
end

case node["platform_family"]
when "debian"
  dpkg_package ::File.join(Chef::Config[:file_cache_path], node["vagrant"]["package_file"]) do
    action :install
  end
when "suse"
  rpm_package ::File.join(Chef::Config[:file_cache_path], node["vagrant"]["package_file"]) do
    action :install
  end
end

node["vagrant"]["plugins"].each do |name|
  node["vagrant"]["mapping"].each do |username, homedir|
    execute "vagrant_plugin_#{name}_#{username}" do
      command "vagrant plugin install #{name}"
      user username

      action :run

      environment(
        "HOME" => homedir
      )

      only_if do
        if ::File.exist? "#{homedir}/.vagrant.d/plugins.json"
          File.foreach(
            "#{homedir}/.vagrant.d/plugins.json"
          ).grep(
            /#{name}/
          ).empty?
        else
          true
        end
      end
    end
  end
end
