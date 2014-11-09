When installing ruby 1.9.3:
===========================

```
rvm install 1.9.3-p448 --with-gcc=clang
# so that it uses clang instead of gcc46 which doesn't seem to work that easily
```

AutoStarting MySQL on Reboot on Yosemite
========================================

Taken from: http://coolestguidesontheplanet.com/get-apache-mysql-php-phpmyadmin-working-osx-10-10-yosemite/

Currently there's no official MySQL supported version for Mac OS X Yosemite.  You have to download MySQL 5.6.21 for Mac OS X 10.9, install it, then it will fail at the end of the setup because it can't create the auto-load (files will be installed correctly, though).

There was a solution recently posted on how to autostart MySQL 5.6.21 on reboot on Yosemite.  If you follow this it will work:

```
sudo nano /Library/LaunchDaemons/com.mysql.mysql.plist
```

And paste in:

```
<!--?xml version="1.0" encoding="UTF-8"?-->
<plist version="1.0">
  <dict>
    <key>KeepAlive</key>
    <true />
    <key>Label</key>
    <string>com.mysql.mysqld</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/local/mysql/bin/mysqld_safe</string>
      <string>--user=mysql</string>
    </array>        
  </dict>
</plist>
```

Save it and then:

```
sudo chown root:wheel /Library/LaunchDaemons/com.mysql.mysql.plist
sudo chmod 644 /Library/LaunchDaemons/com.mysql.mysql.plist
sudo launchctl load -w /Library/LaunchDaemons/com.mysql.mysql.plist
```

Then it will load on a restart.
