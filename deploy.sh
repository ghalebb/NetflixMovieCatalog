#!/bin/bash

cd ~/app


if [ ! -d "venv" ]; then
  python3 -m venv venv
fi


source venv/bin/activate


pip install -r requirements.txt


deactivate

# Create a systemd service file for the app
SERVICE_FILE="/etc/systemd/system/netflix_movie_catalog.service"

sudo bash -c "cat > $SERVICE_FILE" <<EOL
[Unit]
Description=Netflix Movie Catalog Service
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/app
ExecStart=/home/ubuntu/app/venv/bin/python /home/ubuntu/app/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd to apply the new service
sudo systemctl daemon-reload

# Enable the service to start on boot
sudo systemctl enable netflix_movie_catalog.service

# Start the service
sudo systemctl start netflix_movie_catalog.service
