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
    $config = parse_ini_file('/home/noahm/mysql.ini');
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

$quantity_query = 'SELECT COUNT(catalogId) FROM catalog;';
$quantity = $conn->query($quantity_query);
$quantity_actual = $quantity->fetch_all();

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Upwards Outfitters</title>
    </head>

    <body>
        <h1>Welcome to the Upwards Outfitters About page!</h1>
        <p>We are located at [ADDRESS]</p>
        <p>We were founded by [PERSON] and [PERSON] in [YEAR], and ever since have been driven to excellence in customer service.</p>        
        <p>Our hours are: XXXXXX</p>
        <p>We currently have <?php echo $quantity_actual[0][0] ?> items in our catalog.
    </body>


    <form action="index.php" method=POST>
<?php
    echo "<p><input type=\"submit\" name=\"returnHome\" value=\"Return to Homepage\" method=POST/></p>";
?>
</form>
</html>