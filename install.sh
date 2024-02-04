#! /bin/bash
PROJECT_ROOT_DIR=$(pwd)


# Install the required packages
sudo apt update
sudo apt-get install redis -y
sudo apt-get install python3 python3-pip -y
sudo pip3 install virtualenv
pip install celery[redis]

# Load celery config file
. util/systemd/celery.conf

# Create celery user
echo "Creating celery system user"
sudo useradd -M -r -s /bin/false celery || true

# Create the required folders
sudo mkdir -p /var/log/celery
sudo mkdir -p /etc/conf.d
sudo mkdir -p /opt/celery/venv
sudo mkdir -p /var/run/celery

# Copy the celery worker file
echo "Copying the celery worker file"
sudo cp src/celery/tasks.py /opt/celery/tasks.py

# Add permissions for the celery user
sudo chown -R celery:celery /etc/conf.d/celery
sudo chown -R celery:celery /opt/celery
sudo chown -R celery:celery /var/log/celery/
sudo chown -R celery:celery /var/run/celery
sudo chmod -R u+rw /var/log/celery/

# Setup virtual python env for celery
sudo -u celery virtualenv /opt/celery/venv
sudo -u celery /bin/bash -c "source /opt/celery/venv/bin/activate && pip install celery[redis]"

# Copy the systemd service file and the conf file
echo "Copying the systemd service file and the conf file"
sudo cp util/systemd/celery.service /etc/systemd/system/celery.service
sudo cp util/systemd/celery.conf /etc/conf.d/celery

# Reload the systemd daemon
echo "Reloading the systemd daemon"
sudo systemctl daemon-reload

# Enable the celery service
echo "Enabling the celery service"
sudo systemctl enable celery
sudo systemctl start celery

# Get the current stauts of the celery service
echo "Getting the current status of the celery service"
sudo systemctl status celery --no-pager

