node.default['chef-server']['api_fqdn'] = 'chef-server-tk.example.com'
node.default['chef-server']['addons'] = ['manage']
node.default['chef-server']['accept_license'] = true

apt_update 'update'

include_recipe 'chef-server::default'
#include_recipe 'chef-server::addons'

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


execute 'create-admin-user' do
  command 'chef-server-ctl user-create admin Admin User kk@ibexlabs.com ibexlabs123 --filename /opt/admin.key'
  not_if 'chef-server-ctl user-list | grep "admin"'
end

execute 'create-organization' do
  command 'chef-server-ctl org-create ibexlabs "ibexlabs" --association_user admin --filename /opt/ibexlabs.key'
  not_if 'chef-server-ctl org-list | grep "ibexlabs"'
end

