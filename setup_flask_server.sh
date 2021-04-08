#!/bin/bash
echo "Install httpd..."
dnf install httpd -y
echo "Install httpd-devel..."
dnf install httpd-devel -y
echo "Install python3..."
dnf install python3 -y
echo "Install python3-pip..."
dnf install python3-pip -y
echo "Install python3-mod-wsgi..."
dnf install python3-mod_wsgi -y
echo "Install virtualenv..."
dnf install virtualenv -y

echo "Open port 80..."
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload

echo "Write out wsgi configuration..."
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

echo "Write bootstrap flask app..."
cat > /var/www/html/app.py << __FLASK_BOOT_STRAP__
from gtsiweb import flask_app
if __name__ == "__main__":
    flask_app.app.run()
__FLASK_BOOT_STRAP__

echo "Enable httpd..."
systemctl enable httpd

# Needed to allow wsgi daemon to do outbound connections
echo "Set wsgi to allow outbound connections..."
/usr/sbin/setsebool -P httpd_can_network_connect 1

echo "Install java..."
dnf install java -y

echo "Install git..."
dnf install git -y

echo "Install tar..."
dnf install tar -y


