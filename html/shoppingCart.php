
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
    
    $dblist = "SELECT * FROM Accounts";
    $result = $conn->query($dblist);
    $resdata = $result->fetch_all();
?>

<?php 
    $edited = FALSE; //variable that tracks if we need to redirect or not
?>

<p> SHOPPING CART </p>

<form action="shoppingCart.php" method=POST>
<?php
    session_start();
    if(isset($_SESSION['username'])){
    if(isset($_SESSION['cart'])){
        
        
        for($i = 0; $i < count($_SESSION['cart']); $i++){
            if(isset($_POST["d" . $i])){
                array_splice($_SESSION['cart'], $i, 1);
                $edited = TRUE;
            }
        }

        if(isset($_SESSION['tocart'])){
            array_push($_SESSION['cart'], $_SESSION['tocart']);
            unset($_SESSION['tocart']);
            $edited = TRUE;
        }

        $dblist = "SELECT catalog_catalogId, catalog_itemName, catalog_currentPrice FROM Catalog;";
        $result = $conn->query($dblist);
        $resdata = $result->fetch_all();
        $total = 0;
        for($i = 0; $i < $result->num_rows; $i++){
            for($j = 0; $j < count($_SESSION['cart']); $j++)
                    if($resdata[$i][0] === $_SESSION['cart'][$j]){
                        echo "<p>" . $resdata[$i][1] . " : $" . $resdata[$i][2] . " <input type='submit' name='" . "d" . $j . "' value='remove from cart' method=POST/></p>";
                        $total += $resdata[$i][2];
                    }
        }
        echo "<p> TOTAL: $" . $total . "</p>";

    }else{
        if(isset($_SESSION['tocart'])){
            $_SESSION['cart'] = array($_SESSION['tocart']);
            unset($_SESSION['tocart']);
            $edited = TRUE;
        }

        $dblist = "SELECT catalog_catalogId, catalog_itemName, catalog_currentPrice FROM Catalog;";
        $result = $conn->query($dblist);
        $resdata = $result->fetch_all();

        $total = 0;
        for($i = 0; $i < $result->num_rows; $i++){
            for($j = 0; $j < count($_SESSION['cart']); $j++)
                    if($resdata[$i][0] === $_SESSION['cart'][$j]){
                        echo "<p>" . $resdata[$i][1] . " : $" . $resdata[$i][2] . " <input type='submit' name='" . "d" . $j . "' value='remove from cart' method=POST/></p>";
                        $total += $resdata[$i][2];
                    }
        }
        echo "<p> TOTAL: $" . $total . "</p>";
    }
    }
    
?>
</form>

<?php 
    if($edited == TRUE){                                            //if we need to reload the page...
        header("Location: {$_SERVER['REQUEST_URI']}", true, 303);   //...redirect design pattern
        exit();
    }
?>


<form action="search.php" method=POST>
<?php
    echo "<p><input type=\"submit\" name=\"gotoSearch\" value=\"Go back to Search\" method=POST/></p>";
?>
</form>

<form action="checkout.php" method=POST>
<?php
    if($total != 0) //awful fix
    echo "<p><input type=\"submit\" name=\"gotoCheckout\" value=\"Go to Checkout\" method=POST/></p>";
?>
</form>

<form action="loginPage.php" method=POST>
<?php
    echo " <input type=\"submit\" name=\"gotoAccount\" value=\"Account\" method=POST/>";
?>
</form>

<form action="index.php" method=POST>
<?php
    echo "<p><input type=\"submit\" name=\"returnHome\" value=\"Return to Homepage\" method=POST/></p>";
?>
</form>

</html>