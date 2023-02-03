
home_servers:
    hosts:
        %{ for index, ip in home_app ~}

        home-${index}:
            ansible_host: ${ip}
            ansible_user: ec2-user
            ansible_ssh_private_key_file: privateKey
        %{ endfor ~}
        
products_servers:
    hosts:
        %{ for index, ip in products_app ~}

        products-${index}:
            ansible_host: ${ip}
            ansible_user: ec2-user
            ansible_ssh_private_key_file: privateKey
        %{ endfor ~}

webservers:
    children:
        home_servers:
        products_servers:
#ansible_ssh_private_key_file=primeStore