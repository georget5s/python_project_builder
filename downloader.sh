if [[ ! -d ~/tools ]]; then mkdir ~/tools; fi

curl --output ~/tools/set_host_and_ip.sh https://raw.githubusercontent.com/georget5s/python_project_builder/main/build.sh
curl --output ~/tools/build.sh https://raw.githubusercontent.com/georget5s/python_project_builder/main/build.sh
curl --output ~/tools/generate_self_signed_cert.sh https://raw.githubusercontent.com/georget5s/python_project_builder/main/generate_self_signed_cert.sh
curl --output ~/tools/setup_flask_server.sh https://raw.githubusercontent.com/georget5s/python_project_builder/main/setup_flask_server.sh
curl --output ~/tools/ssl.conf https://raw.githubusercontent.com/georget5s/python_project_builder/main/ssl.conf

chmod 700 ~/tools/*.sh
