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
    if (isset($_POST['product'])) {
        $product_code = $_POST['product'];
    }
    else {
        $product_code = 1;
    }
    

    //EOL check
    $eol_check_stmt = $conn->prepare('SELECT * FROM eolitems WHERE catalogId = ?;');
    $eol_check_stmt->bind_param("i", $id);
    $id = $product_code;

    
              
    $eol_check_stmt->execute();
    $eol_result = $eol_check_stmt->get_result();
    $eol_result_body = $eol_result->fetch_all();


    //fetch item
    $select_stmt = $conn->prepare('SELECT * FROM catalog WHERE catalogId = ?;');
    $select_stmt->bind_param("i", $id);
    $id = $product_code;

    
              
    $select_stmt->execute();
    $select_result = $select_stmt->get_result();
    $result_body = $select_result->fetch_all();
    
    if (sizeof($eol_result_body) != 0 ){
        ?>
        <h2>Please note that this item has been discontinued, and is no longer available for purchase.</h2>
        <?php
    }
?>

<h1>Product: <?php echo($result_body[0][1]); ?></h1>
<h2>Brand: <?php echo($result_body[0][6]); ?></h2>
<h2>Category: <?php echo($result_body[0][2]); ?></h2>
<h2>Price: $<?php echo($result_body[0][3]); ?></h2>
<h2>Quantity in Stock: <?php echo($result_body[0][5]); ?></h2>


<?php
    session_start();

    if( array_key_exists('username', $_SESSION)) {
        $_SESSION['tocart'] = $id;
        echo("You are logged in!");
        echo "<form action='shoppingCart.php' method=POST>                  <!-- start of form -->
        <p>
            <input type='submit' name='searchCatagory' value='Add to cart' method=POST/>
        </p>
        </form>";
    }
    else {
        echo("you are not logged in!");
    }

?>