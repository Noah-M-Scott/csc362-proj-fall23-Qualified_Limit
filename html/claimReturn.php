<?php
    /*
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    */
?>

<html>

<?php
    $config = parse_ini_file('../../mysql.ini');
    $dbhost = $config['mysqli.default_host'];
    $dbuser = $config['mysqli.default_user'];
    $dbpass = $config['mysqli.default_pw'];
    $dbname = 'upward';

?>

<?php

    $conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname);
    
    if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit; // Quit this PHP script if the connection fails.
    }
?>


<?php
    if(isset($_POST['submitClaim'])){
        $dela_stmt = $conn->prepare("CALL returnsInsert(?, ?);");
        $current_date = date("Y-m-d");
        $dela_stmt->bind_param('is', $_POST['idClaim'], $current_date);
        $dela_stmt->execute();

        $dela_stmt = $conn->prepare("CALL shippingDataInsert(?, ?, ?, ?, ?, ?);");
        $cost = 0;
        $headquaters = 'Headquaters';
        $trueValue = TRUE;
        $dela_stmt->bind_param('issssi', $_POST['idClaim'], $_POST['textClaim'], $headquaters, $cost, $_POST['company'], $trueValue);

        $dela_stmt->execute();
    }
?>


<p><b>REPORT RETURN</b></p>


<?php
if(!isset($_POST['submitClaim'])){
    echo "<form action=\"claimReturn.php\" method=POST>";
    echo "<input type=\"number\" name=\"idClaim\" value=\"Transaction Id\" step=\"1\" method=POST/>";
    echo "<input type=\"text\" name=\"textClaim\" value=\"Shipping Label\" method=POST/>";
    echo "<input type=\"text\" name=\"company\" value=\"Shipping Company\" method=POST/>";
    echo "<input type=\"submit\" name=\"submitClaim\" value=\"Submit Return\" method=POST/>";
    echo "</form>";
}else{
    unset($_POST['submitClaim']);
    unset($_POST['textClaim']);
    unset($_POST['idClaim']);
    echo "Thank You for sending a return, it will be reviewed shortly";
}
?>

<form action="loginPage.php" method=POST>
    <?php
    echo " <input type=\"submit\" name=\"gotoAccount\" value=\"Return to Account\" method=POST/>";
    echo "</p>";
    ?>
</form>

</html>