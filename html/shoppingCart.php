<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
?>

<html>

<?php
    $config = parse_ini_file('/home/noahm/mysql.ini');
    $dbhost = $config['mysqli.default_host'];
    $dbuser = $config['mysqli.default_user'];
    $dbpass = $config['mysqli.default_pw'];
?>

<?php

    $conn = new mysqli($dbhost, $dbuser, $dbpass);
    
    if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit; // Quit this PHP script if the connection fails.
    }
?>

<?php
    $dblist = "USE upward;";                        //set the db
    $result = $conn->query($dblist);                //
    
    $dblist = "SELECT * FROM accounts";
    $result = $conn->query($dblist);
    $resdata = $result->fetch_all();
?>

<p> SHOPPING CART </p>

<form action="shoppingCart.php" method=POST>
<?php
    session_start();
    if(isset($_SESSION['username'])){
    if(isset($_SESSION['cart'])){

        
        for($i = 0; $i < count($_SESSION['cart']); $i++)
            if(isset($_SESSION[$i . 'dlt'])){
                array_splice($_SESSION['cart'], $i, 1);
            }
        

        if(isset($_SESSION['tocart'])){
            array_push($_SESSION['cart'], $_SESSION['tocart']);
            unset($_SESSION['tocart']);
        }

        $dblist = "SELECT catalogId, itemName FROM catalog;";
        $result = $conn->query($dblist);
        $resdata = $result->fetch_all();
        for($i = 0; $i < $result->num_rows; $i++){
            for($j = 0; $j < count($_SESSION['cart']); $j++)
                if($resdata[$i][0] === $_SESSION['cart'][$j])
                echo "<p>" . $resdata[$i][1] . " <input type='submit' name='" . $j . "dlt' value='remove from cart' method=POST/></p>";
        }

    }else{
        if(isset($_SESSION['tocart'])){
            $_SESSION['cart'] = array($_SESSION['tocart']);
            unset($_SESSION['tocart']);
        }

        $dblist = "SELECT catalogId, itemName FROM catalog;";
        $result = $conn->query($dblist);
        $resdata = $result->fetch_all();

        
        for($i = 0; $i < $result->num_rows; $i++){
            for($j = 0; $j < count($_SESSION['cart']); $j++)
                    if($resdata[$i][0] === $_SESSION['cart'][$j])
                        echo "<p>" . $resdata[$i][1] . " <input type='submit' name='" . $j . "dlt' value='remove from cart' method=POST/></p>";
        }
    }
    }
    
?>
</form>


<form action="checkout.php" method=POST>
<?php
    echo "<p><input type=\"submit\" name=\"gotoCheckout\" value=\"Go to Checkout\" method=POST/></p>";
?>
</form>

<form action="index.php" method=POST>
<?php
    echo "<p><input type=\"submit\" name=\"returnHome\" value=\"Return to Homepage\" method=POST/></p>";
?>
</form>

</html>