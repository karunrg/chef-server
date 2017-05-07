node.default['chef-server']['api_fqdn'] = ''

apt_update 'update'

include_recipe 'chef-server::default'

execute 'chef-manage-install' do
  command 'chef-server-ctl install chef-manage'
  not_if 'chef-server-ctl user-list | grep "admin"'
end

execute 'chef-reconfigure' do
  command 'chef-server-ctl reconfigure'
  not_if 'chef-server-ctl org-list | grep "ibexlabs"'
end

execute 'chef-manage-accept-license' do
  command 'chef-manage-ctl reconfigure --accept-license'
  not_if 'chef-server-ctl org-list | grep "ibexlabs"'
end
