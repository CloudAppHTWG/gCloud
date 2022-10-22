 #! /bin/bash
sudo su
apt update
apt install git
apt-get update
apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
chmod a+r /etc/apt/keyrings/docker.gpg
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

git clone https://github.com/ChrisMythos/CloudApp.git /app
cat > /etc/systemd/system/cloudapp.service << EOF
[Unit]
PartOf=docker.service
After=docker.service

[Service]
Restart=always
User=root
Group=root
WorkingDirectory=/app/
ExecStart=docker compose up
ExecStop=docker compose down

[Install]
WantedBy=multi-user.target
EOF

systemctl enable cloudapp
systemctl start cloudapp