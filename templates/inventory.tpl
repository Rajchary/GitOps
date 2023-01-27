[home_servers]:
%{ for index, ip in home_app ~}
home-app-${index} ansible_host=${ip} ansible_user=ec2-user 
%{ endfor ~}

[products_servers]:
%{ for index, ip in products_app ~}
products-app-${index} ansible_host=${ip} ansible_user=ec2-user 
%{ endfor ~}

#ansible_ssh_private_key_file=primeStore