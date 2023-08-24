20230822_231059

== Guide ==

You need to make a symbolic link "_b" which points to "/home/blusjune/..b/_" in the root "/" directory.

 <pre>
$ ls -alF /_b;
lrwxrwxrwx 1 root root 20 Aug 21 22:43 /_b -> /home/blusjune/..b/_/
</pre>

This is very essential to enable BWX (B's Web eXection) to execute .bx.*.sh commands under the ..b/_/x directory.
Then BWX will use the path '/_b/x/.bx.bmm.sh' to access '/home/blusjune/..b/_/x/.bx.bmm.sh' file.


 <pre>
_b -> /home/blusjune/..b/_/

$ ls -alF /;
total 80
drwxr-xr-x  19 root root  4096 Aug 21 22:44 ./
drwxr-xr-x  19 root root  4096 Aug 21 22:44 ../
lrwxrwxrwx   1 root root    20 Aug 21 22:43 _b -> /home/blusjune/..b/_/
lrwxrwxrwx   1 root root     7 Feb 17  2023 bin -> usr/bin/
drwxr-xr-x   4 root root  4096 Aug 18 23:16 boot/
drwxr-xr-x  19 root root  5360 Aug 22 20:55 dev/
drwxr-xr-x 164 root root 12288 Aug 22 21:15 etc/
drwxr-xr-x   3 root root  4096 Apr 17 23:44 home/
lrwxrwxrwx   1 root root     7 Feb 17  2023 lib -> usr/lib/
lrwxrwxrwx   1 root root     9 Feb 17  2023 lib32 -> usr/lib32/
lrwxrwxrwx   1 root root     9 Feb 17  2023 lib64 -> usr/lib64/
lrwxrwxrwx   1 root root    10 Feb 17  2023 libx32 -> usr/libx32/
drwx------   2 root root 16384 Apr 17 23:26 lost+found/
drwxr-xr-x   3 root root  4096 Apr 21 22:45 media/
drwxr-xr-x   2 root root  4096 Feb 17  2023 mnt/
drwxr-xr-x   4 root root  4096 Apr 29 16:11 opt/
dr-xr-xr-x 459 root root     0 Aug 22 20:55 proc/
drwx------   9 root root  4096 Aug 21 23:36 root/
drwxr-xr-x  45 root root  1340 Aug 22 21:15 run/
lrwxrwxrwx   1 root root     8 Feb 17  2023 sbin -> usr/sbin/
drwxr-xr-x  25 root root  4096 Jun  6 22:03 snap/
drwxr-xr-x   3 root root  4096 Jul  5 23:24 srv/
dr-xr-xr-x  13 root root     0 Aug 22 20:55 sys/
drwxrwxrwt  33 root root  4096 Aug 22 23:02 tmp/
drwxr-xr-x  14 root root  4096 Feb 17  2023 usr/
drwxr-xr-x  15 root root  4096 Apr 18 00:48 var/
</pre>


Do not forget to add 'www-data' group ID to the 'blusjune' group
 <pre>
$ sudo vigr;
$ sudo vigr -s;
$ sudo systemctl restart apache2;
</pre>


== BWX (B's Web eXecution) troubleshooting ==
: 20230822_224457

 <pre>
* Error: BWX execution failure
** Tried to execute the command '/_b/x/bmmpy wiki' via BWX
** but it generated an error: /_b/x/bmmpy permission denied

* How to investigate the problematic situation
** check the following logs
*** /var/log/apache2/error.log
*** /var/log/apache2/access.log
*** /var/log/syslog

* Root cause:
** Apache2+PHP uses 'www-data' account ID/group
** But the ~blusjune/ directory has 'drwxr-x---' permission
** So Apache2+PHP could not access the file '/_b/x/bmmpy'

* Solution:
** add 'www-data' group ID to the 'blusjune' group
** vigr; vigr -s; systemctl restart apache2;
</pre>
