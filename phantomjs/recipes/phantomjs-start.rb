execute "start phantomjs" do
  command "bash /etc/init.d/phantomjs.sh start"
  only_if { ::File.exists?("/etc/init.d/phantomjs.sh")}
end