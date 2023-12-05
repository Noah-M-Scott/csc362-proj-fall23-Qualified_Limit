<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
?>

<html>

<?php
//mode = 0 : no selector; mode = 1 : selector
function result_to_html_table($result, $mode) {
        // $result is a mysqli result object. This function formats the object as an
        // HTML table. Note that there is no return, simply call this function at the 
        // position in your page where you would like the table to be located.

        $result_body = $result->fetch_all();
        $num_rows = $result->num_rows;
        $num_cols = $result->field_count;
        $fields = $result->fetch_fields();
        ?>
        <!-- Description of table - - - - - - - - - - - - - - - - - - - - -->
        <!-- <p>This table has <?php //echo $num_rows; ?> and <?php //echo $num_cols; ?> columns.</p> -->
        
        <!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
        <table>
        <thead>
        <tr>

        <?php for ($i=0; $i<$num_cols; $i++){ ?>
            <td><b><?php echo $fields[$i]->name; ?></b></td>
        <?php } ?>

        <?php
            if( $mode == 1 ){
                echo "<td><b> add waranty </b></td>";
            }
        ?>

        </tr>
        </thead>
        
        <!-- Begin body - - - - - - - - - - - - - - - - - - - - - -->
        <tbody>
        <?php for ($i=0; $i<$num_rows; $i++){ ?>
            <?php $id = $result_body[$i][0]; ?>
            <tr>     

            <?php for($j=0; $j<$num_cols; $j++){ ?>
                <td><?php echo $result_body[$i][$j]; ?></td>
            <?php } ?>

            <!-- delete checkbox -->
            <?php
                if( $mode == 1 ){
                    echo "<td><input type=\"number\" name=\"number";
                    echo str_replace(' ', '', $id);
                    echo "\" min=\"0\" value=\"0\" step=\"1\" /></td>";                
                }
            ?>
            
            </tr>
        <?php } ?>
        </tbody></table>
<?php } ?>

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

    session_start();
    if(isset($_SESSION['cart'])){
    $dblist = "SELECT catalog_catalogId, catalog_itemName, catalog_currentPrice FROM Catalog;";
    $result = $conn->query($dblist);
    $resdata = $result->fetch_all();
    $total = 0;
    
    if(isset($_SESSION['madeTransactions']))
        for($i = 0; $i < count($_SESSION['madeTransactions']); $i++){
            if( $_SESSION['madeTransactions'][$i] == 0 )
                continue;

            $dela_stmt = $conn->prepare("CALL transactionDelete(?)");
            $dela_stmt->bind_param('i', $_SESSION['madeTransactions'][$i]);
            $dela_stmt->execute();                       
        }
    

    $_SESSION['madeTransactions'] = array(0);
    for($i = 0; $i < $result->num_rows; $i++){
        for($j = 0; $j < count($_SESSION['cart']); $j++)
                if($resdata[$i][0] === $_SESSION['cart'][$j]){
                    $dela_stmt = $conn->prepare("SELECT transactionInsert(?, ?)");
                    $dela_stmt->bind_param('ii', $resdata[$i][0], $_SESSION['accountId']);
                    $dela_stmt->execute();
                    $total += $resdata[$i][2];
                    $transactionId = $dela_stmt->get_result()->fetch_all()[0][0];
                    array_push($_SESSION['madeTransactions'], $transactionId);
                }
    }


    //I know what your thinking, "this should be a prepaired stmt";
    //counterpoint -> we only accept ids, those id's are verified to be numbers,
    //and there is no penalty, outside of an hidden err, if the numbers are out of range

    //this was just the cleanest way to do it, since php/sql doesn't have good vararg support

    if(!is_numeric($_SESSION['accountId']))
        goto SESSION_ERROR;

    $accumulatorStmt = "SELECT transaction_transactionId AS id, 
    catalog_itemName AS name, 
    catalog_currentPrice AS price
    FROM Transactions INNER JOIN Catalog USING (catalog_catalogId) 
    WHERE account_accountId = " . $_SESSION['accountId'] . " AND ";

    for($i = 0; $i < COUNT($_SESSION['madeTransactions']); $i++){
        if($_SESSION['madeTransactions'][$i] == 0)
            continue;
        
        if(!is_numeric($_SESSION['madeTransactions'][$i]))
            goto SESSION_ERROR;

        $accumulatorStmt = $accumulatorStmt . "transaction_transactionId = " . $_SESSION['madeTransactions'][$i];
        
        if($i + 1 < COUNT($_SESSION['madeTransactions']))
            $accumulatorStmt = $accumulatorStmt ." || ";
    }

    $transactionRow = $conn->query($accumulatorStmt);
    result_to_html_table($transactionRow, 1);

SESSION_ERROR:

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