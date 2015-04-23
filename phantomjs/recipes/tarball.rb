#
# Cookbook Name:: phantomjs
# Recipe:: tarball
# Copyright 2012-2013, Travis CI Development Team <contact@travis-ci.org>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# This recipe provides Phantom.js using official tarball for Linux.
package "libfontconfig1"

# 1. Download the tarball
require "tmpdir"

td           = Dir.tmpdir
tmp          = File.join(td, "phantomjs-#{node.phantomjs.version}.tar.gz")
tarball_dir  = File.join(td, "phantomjs-#{node.phantomjs.version}-linux-#{node.phantomjs.arch}")

remote_file(tmp) do
  source node.phantomjs.tarball.url

  not_if "which phantomjs && [[ `phantomjs --version` == \"#{node.phantomjs.version}\" ]]"
end

# 2. Extract it
# 3. Copy to /usr/local/phantomjs and change permissions of /usr/local/phantomjs
bash "extract #{tmp}, move it to /usr/bin/phantomjs" do
  user "root"
  cwd  "/tmp"

  code <<-EOS
    rm -rf /usr/bin/phantomjs
    tar xfj #{tmp}
    mv --force #{tarball_dir} /usr/bin/phantomjs
    chmod -R 777 /usr/bin/phantomjs
  EOS

  creates "/usr/bin/phantomjs"
end

# 4. Add phantomjs to PATH
cookbook_file "/etc/profile.d/phantomjs.sh" do
  owner "root"
  group "root"
  mode 0644

  source "etc/profile.d/phantomjs.sh"
end

# 5. Copy script to boot phantomjs
cookbook_file "/etc/init.d/phantomjs.sh" do
  owner "root"
  group "root"
  mode 0755

  source "etc/init.d/phantomjs.sh"
end