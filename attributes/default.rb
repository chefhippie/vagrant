#
# Cookbook Name:: vagrant
# Attributes:: default
#
# Copyright 2013, Thomas Boerger
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

default["vagrant"]["plugins"] = %w(
  vbguest
  libvirt
  berkshelf
  hostmanager
  cachier
  rake
  vbox-snapshot
  sync
)

default["vagrant"]["version"] = "1.3.5"

case node["platform_family"]
when "suse"
  default["vagrant"]["package_provider"] = Chef::Provider::Package::Rpm
  default["vagrant"]["package_file"] = "vagrant_#{node["vagrant"]["version"]}_x86_64.rpm"
  default["vagrant"]["package_url"] = "http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/#{node["vagrant"]["package_file"]}"
when "debian"
  default["vagrant"]["package_provider"] = Chef::Provider::Package::Apt
  default["vagrant"]["package_file"] = "vagrant_#{node["vagrant"]["version"]}_x86_64.deb"
  default["vagrant"]["package_url"] = "http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/#{node["vagrant"]["package_file"]}"
end
