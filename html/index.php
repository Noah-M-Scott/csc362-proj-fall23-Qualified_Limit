<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
?>

<html>

<?php
    $config = parse_ini_file('/home/upfrog42/CSC362_Rout/html/mysql.ini');
    $dbhost = $config['mysqli.default_host'];
    $dbuser = $config['mysqli.default_user'];
    $dbpass = $config['mysqli.default_pw'];
    $dbname = 'upward';
    

    $productCode = 2;
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



<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Upwards Outfitters</title>
    </head>

    <body>
        <h1>Welcome to Upwards Outfitters, [TOWN]'s premier provider of high-quality climbing and camping equipment since [YEAR]!</h1>
        <b>Want to go to an item page for testing purposes? Then click <a href="productPage.php?product=<?php echo $productCode; ?>"> HERE</a>.</b>
        <p>To make an account with us, or sign in to your existing account, Click <a href="loginPage.php">HERE</a> to log in!</p>
        <p>Know what you want? Click <a href ="search.php">HERE</a> for our search engine!</p>
        <p>Want more information? Click <a href="aboutPage.php">HERE</a> for our About!</p>
        <p>Just browsing? See below for a list of our product categories! We're always expanding our stock, so be sure to check back often!</p>
    </body>

<?php
    $dblist = "SELECT categoryName FROM BaseCategories;";

    $result = $conn->query($dblist);
    $result_body = $result->fetch_all();
?>

<table>
    <?php
    for ($i=0; $i<$result->num_rows; $i++)
    {
        ?>
        <tr>
            <td>
                <?php echo($result_body[$i][0]); ?>
            </td>
        </tr>
        <?php
    }   
        $conn->close();
    ?>
</table>

</html>





