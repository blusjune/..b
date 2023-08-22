
_target_dir="/var/www/html";
echo -n ">>> syncing up with $_target_dir ... ";
(cd $_target_dir; tar cf - . ) | tar xf -
echo "done";

