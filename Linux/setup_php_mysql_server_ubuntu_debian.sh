if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

# Update the system
apt update && apt upgrade -y
# Installing PHP MYSQL Server (apache) and CertBot(apache) for SSL
apt install lamp-server^ certbot python3-certbot-apache wget curl zip unzip -y &&
    ##Create New User.
    read -p "Do you want to create a new user? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

#Take username and add the user
read -p "Enter user: " user
adduser $user &&
    groups $user &&
    usermod -aG sudo $user

##Download
read -p "Do you want to download Wordpress? (Y/N): " confirm2 && [[ $confirm2 == [yY] || $confirm2 == [yY][eE][sS] ]] || exit 1
echo "Saving wordpress to ${user}'s home directory.."
wget -O /home/$user/wordpress.zip https://wordpress.org/latest.zip
echo "Downloaded Location : /home/${user}/wordpress.zip"
echo "Done!"
exit 1
