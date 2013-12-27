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
default["vagrant"]["package_provider"] = value_for_platform_family(
  "debian" => Chef::Provider::Package::Apt,
  "ubuntu" => Chef::Provider::Package::Apt,
  "suse" => Chef::Provider::Package::Zypper
)
default["vagrant"]["package_file"] = value_for_platform_family(
  "debian" => "vagrant_#{node["vagrant"]["version"]}_x86_64.deb",
  "ubuntu" => "vagrant_#{node["vagrant"]["version"]}_x86_64.deb",
  "suse" => "vagrant_#{node["vagrant"]["version"]}_x86_64.rpm"
)
default["vagrant"]["package_url"] = "http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/#{node["vagrant"]["package_file"]}"
