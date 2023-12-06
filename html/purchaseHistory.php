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
?>

<?php

    $conn = new mysqli($dbhost, $dbuser, $dbpass);
    
    if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit;
    }
?>

<form action="loginPage.php" method=POST>
    <?php
        echo "<input type=\"submit\" name=\"gotoAccount\" value=\"Return to Account page\" method=POST/>";
    ?>
</form>

<?php
    session_start(); 

    if( array_key_exists('username', $_SESSION)) {
        echo("ORDER HISTORY");
        $dbset = "USE upward;";                        
        $result = $conn->query($dbset);
        
        $get_userID_stmt = $conn->prepare("SELECT account_accountId FROM Accounts WHERE account_userName = ?;");
        $get_userID_stmt->bind_param("s", $_SESSION['username']);
        $get_userID_stmt->execute();
        
        $user_id = $get_userID_stmt->get_result();
        $user_id_body = $user_id->fetch_all();

        $user_id_int = $user_id_body[0][0];

        $order_list = $conn->prepare("SELECT catalog_itemName, catalog_category, transaction_dateMade, 
        transaction_originalPriceAtTransaction, transaction_onHold FROM Transactions LEFT JOIN Catalog ON 
        Transactions.catalog_catalogId = Catalog.catalog_catalogId WHERE account_accountId = ? and 
        transaction_transactionCompleteBool = 1;");
        $order_list->bind_param("i", $user_id_int);
        $order_list->execute();
        
        $order_list_result_body = $order_list->get_result();
        $order_list_body = $order_list_result_body->fetch_all();
        ?> </br> <?php
        
        
        ?> <table> 
            <tr>
                <th>Product</th>
                <th>Category</th>
                <th>Purchase Date</th>
                <th>Purchase Price</th>
                <th>On hold?</th>
            </tr>
            <?php
        for ($i = 0; $i < $order_list_result_body->num_rows; $i++) {
            ?> 
            <tr>
              <td><?php echo($order_list_body[$i][0]) ?></td> 
              <td><?php echo($order_list_body[$i][1]) ?></td> 
              <td><?php echo($order_list_body[$i][2]) ?></td> 
              <td><?php echo($order_list_body[$i][3]) ?></td> 
              <td><?php echo($order_list_body[$i][4]) ?></td>  
            </tr>
            <?php
        }

        ?></table><?php
    }
    else {
        echo("To view your purchase history, please log in.");
    }

    $conn->close();
?>

<form action="index.php" method=POST>
<?php
    echo "<p><input type=\"submit\" name=\"returnHome\" value=\"Return to Homepage\" method=POST/></p>";
?>
</form>
