#!/bin/bash
echo -e "Install httpd..."
dnf install httpd -y

echo -e "\nInstall httpd-devel..."
dnf install httpd-devel -y

echo -e "\nInstall python3..."
dnf install python3 -y

echo -e "\nInstall python3-pip..."
dnf install python3-pip -y

echo -e "\nInstall python3-mod-wsgi..."
dnf install python3-mod_wsgi -y

echo -e "\nInstall virtualenv..."
dnf install virtualenv -y

echo -e "\nOpen port 80..."
firewall-cmd --permanent --add-port=80/tcp

echo -e "Open port 443..."
firewall-cmd --permanent --add-port=443/tcp

echo -e "Reload firewall"
firewall-cmd --reload

echo -e "\nWrite out wsgi configuration..."
cat > /etc/httpd/conf.d/python-wsgi.conf << __WSGICONF__
WSGIDaemonProcess myapp processes=1 threads=10 display-name=%{GROUP} python-home=/opt/gtsi/sample_flask_webapp/venv
WSGIProcessGroup myapp
WSGIApplicationGroup %{GLOBAL}
WSGIScriptAlias / /var/www/html/app.py
<Directory /var/www/html>
    Order allow,deny
    Allow from all
</Directory>
__WSGICONF__

echo -e "\nWrite bootstrap flask app..."
cat > /var/www/html/app.py << __FLASK_BOOT_STRAP__
from gtsi.webapp import flask_app
application =  flask_app.app
if __name__ == "__main__":
    flask_app.app.run()
__FLASK_BOOT_STRAP__

echo -e "\nEnable httpd..."
systemctl enable httpd

# Needed to allow wsgi daemon to do outbound connections
echo -e "\nSet wsgi to allow outbound connections..."
/usr/sbin/setsebool -P httpd_can_network_connect 1

echo -e "\nInstall java..."
dnf install java -y

echo -e "\nInstall git..."
dnf install git -y

echo -e "\nInstall tar..."
dnf install tar -y


echo -e "\nInstall mod_ssl"
yum install mod_ssl -y

echo -e "\nInstall expect"
yum install expect -y


echo -e "\nCreate dir for ssl cert..."
mkdir -p /etc/httpd/ssl

echo -e "\nGenerate self signed certificate..."
./generate_self_signed_cert.sh

echo -e "\nConfigure apache ssl..."
cp ./ssl.conf /etc/httpd/conf.d/ssl.conf
