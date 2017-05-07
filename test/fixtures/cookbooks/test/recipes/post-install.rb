execute 'create-admin-user' do
  command 'chef-server-ctl user-create admin Admin User kk@ibexlabs.com ibexlabs123 --filename /opt/admin.key'
  not_if 'chef-server-ctl user-list | grep "admin"'
end

execute 'create-organization' do
  command 'chef-server-ctl org-create ibexlabs "ibexlabs" --association_user admin --filename /opt/ibexlabs.key'
  not_if 'chef-server-ctl org-list | grep "ibexlabs"'
end
