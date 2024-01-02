# Cloudflare UFW
A script, that runs weekly to update the UFW firewall to allow cloudflare IP addreses to connect.
If you don't care about how does it work, you can go to [How to install](#how-to-install)
## How does it work?
It is a pretty basic script, it has 2 main steps:
### 1. Deleting old rules
Firstly the script deletes all the rules with the comment "Cloudflare IP".

This is done because Cloudflare can always change their IP addreseses.
### 2. Adding new rules
Secondly, the script contacts the url https://www.cloudflare.com/ips-v4 and https://www.cloudflare.com/ips-v6 to get the latest cloduflare IP addresses.

Next it runs the `ufw allow` command, to allow incoming connections from those IP addresses and assigns the comment "Cloudflare IP" to those rules.
### 3. Reloading the firewall and showing the added rules
Lastly, the script reloads the firewall using `ufw reload` (it's not always needed, but for good measure, the script runs it anyways).

The script also runs the `ufw status` command with grep filters to show the user all of the rules with the comment "Cloudflare IP".
## How to install
The script is very easy and fast to install (less than 5 minutes).
### Installing the script itself
Download the script: [ufw_cloudflare.sh](./ufw_cloudflare.sh) [RAW file](https://raw.githubusercontent.com/PLGameClub-code/Cloudflare-UFW/main/ufw_cloudflare.sh)
Put it in a memorable place (I like using /opt/scripts/ for all my scripts).

Run "chmod a+x /path/to/the/script/ufw_cloudflare.sh" to allow the execution of the script.

> Now you can execute the script manually with `/path/to/the/script/ufw_cloudflare.sh`
### Making the script run weekly
To make it run weekly, use crontab.

Run `sudo crontab -e` to edit the crontab config, you will need to enter your user password and have access to sudo.

Go to the end of the file.
Press INSERT or i on your keyboard.
Make a new line, and paste:
```
0 0 * * 1 /path/to/the/script/ufw_cloudflare.sh > /dev/null 2>&1
```

Press ESC on your keyboard.
Press `:` and type `wq`.

Your condiguration should be saved and runn weekly.
