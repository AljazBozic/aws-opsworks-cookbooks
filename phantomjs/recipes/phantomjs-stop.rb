execute "start phantomjs" do
  command "bash /etc/init.d/phantomjs.sh stop"
  only_if { ::File.exists?("/etc/init.d/phantomjs.sh")}
end