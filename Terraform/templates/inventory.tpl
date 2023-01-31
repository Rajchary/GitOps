
home_servers:
    hosts:
        %{ for index, ip in home_app ~}

        home-${index}:
            ansible_host: ${ip}
            ansible_user: ec2-user
            

        %{ endfor ~}
        
products_servers:
    hosts:
        %{ for index, ip in products_app ~}

        products-${index}:
            ansible_host: ${ip}
            ansible_user: ec2-user
        %{ endfor ~}

webservers:
    children:
        home_servers:
        products_servers:
#ansible_ssh_private_key_file=primeStore