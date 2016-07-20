%w(server-backend server-frontend analytics supermarket compliance).each do |machine|
  node.default['chef']['provisioning']["#{machine}-options"] = {
     'bootstrap_options' => {
      'image_id' => 'ami-12663b7a',
      'subnet_id' => 'subnet-be7f5dd7',
      'security_group_ids' => Array('sg-34b4a658')
     }
   }
end

 ## might need to override these too:
  # 'ssh_username' => 'ec2-user',
  # 'use_private_ip_for_ssh' => false,

include_recipe 'provision::cluster'
