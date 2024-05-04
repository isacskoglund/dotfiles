# Increase KeyRepeat beyond max
defaults write -g InitialKeyRepeat -int 10 
defaults write -g KeyRepeat -int 1

# Enable touch id for sudo
echo "auth sufficient pam_tid.so\n$(cat /etc/pam.d/sudo)" > /etc/pam.d/sudo
