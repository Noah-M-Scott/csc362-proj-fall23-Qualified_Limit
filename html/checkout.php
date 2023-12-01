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

<html lang="en">
    <p>CHECKOUT:</p>
    <p>SHOPPING CART</p>
<?php
    $transactionId = random_int(4, 10);
    session_start();
    if(isset($_SESSION['cart'])){
    $dblist = "SELECT catalogId, itemName, currentPrice FROM catalog;";
    $result = $conn->query($dblist);
    $resdata = $result->fetch_all();
    $total = 0;
    for($i = 0; $i < $result->num_rows; $i++){
        for($j = 0; $j < count($_SESSION['cart']); $j++)
                if($resdata[$i][0] === $_SESSION['cart'][$j]){
                    echo "<p>" . $resdata[$i][1] . " : $" . $resdata[$i][2] . " | " . "Item Code ( " . $transactionId . " ) " .  " <input type='submit' name='" . $j . "dlt' value='add waranty' method=POST/>" . " <input type='submit' name='" . $j . "r' value='pay with exchange' method=POST/></p>";
                    $total += $resdata[$i][2];
                    $transactionId += 1;
                }
    }
    echo "<p> TOTAL: $" . $total . "</p>";
    echo "<p> DELIVERY: $" . $total * 0.23 . "</p>";
    echo "<p> NET TOTAL: $" . ($total + $total * 0.23) . "</p>";
    }
?>

<?php
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $shippingCode = '';
    for ($i = 0; $i < 20; $i++) {
        $shippingCode .= $characters[random_int(0, 35)];
    }
?>

    <form action="finalizePayment.php" method=POST>
        <p><input type="text" name='cardnumber' value='Card Number'/></p>
        <p><input type="text" name='expdate' value='Expiration Date'/></p>
        <p><input type="text" name='cvv2' value='CVV2'/></p>
        <p><input type="text" name='cardname' value='Card Holder name'/></p>
        <p><input type="text" name='mailaddr' value='Mailing Address'/></p>
        <p><input type="text" name='shipaddr' value='Delivery Address'/> SHIPPED WITH UPS, TRACKING ID : <?php echo $shippingCode; ?> </p>
        <p><input type="submit" name="gotoFinalize" value="CheckOut" method=POST/></p>
    </form>



    <form action="shoppingCart.php" method=POST>
    <?php
    echo "<p>";
    if( array_key_exists('username', $_SESSION))
    if(isset($_SESSION['username']))
        echo "<input type=\"submit\" name=\"gotoCart\" value=\"Go to Cart\" method=POST/>";
    ?>
    </form>

    <form action="loginPage.php" method=POST>
    <?php
    echo " <input type=\"submit\" name=\"gotoAccount\" value=\"Account\" method=POST/>";
    echo "</p>";
    ?>
    </form>

    <form action="index.php" method=POST>
<?php
    echo "<p><input type=\"submit\" name=\"returnHome\" value=\"Return to Homepage\" method=POST/></p>";
?>
</form>



</html>