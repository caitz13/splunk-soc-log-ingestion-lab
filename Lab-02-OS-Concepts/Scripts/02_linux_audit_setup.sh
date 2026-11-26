sudo apt-get install -y auditd
sudo bash -c 'cat >/etc/audit/rules.d/sshd.rules << "EOF"
-w /etc/ssh/sshd_config -p wa -k sshd_config_change
EOF'
sudo augenrules --load
sudo systemctl restart auditd