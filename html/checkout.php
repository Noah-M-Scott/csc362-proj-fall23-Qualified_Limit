<?php

    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

?>

<html>

<?php
//mode = 0 : add warranty; mode 1 = remover warranty
function result_to_html_table($result, $mode) {
        // $result is a mysqli result object. This function formats the object as an
        // HTML table. Note that there is no return, simply call this function at the 
        // position in your page where you would like the table to be located.
        $total = 0;

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
            echo "<td><b> add waranty </b></td>";
            if( $mode == 0 )
                echo "<td><b> Shipping Cost </b></td>";
        ?>

        </tr>
        </thead>
        
        <!-- Begin body - - - - - - - - - - - - - - - - - - - - - -->
        <tbody>
        <?php 
            if( $mode == 0 ){
                $_SESSION['shippingCost'] = array(0);
                $_SESSION['transactionAmount'] = array(0);
                $_SESSION['inStock'] = array(0);
                $_SESSION['catalogId'] = array(0);
            }
            for ($i=0; $i<$num_rows; $i++){ ?>
            <?php $id = $result_body[$i][0]; ?>
            <tr>     

            <?php for($j=0; $j<$num_cols; $j++){ ?>
                <td><?php echo $result_body[$i][$j]; ?></td>
            <?php } ?>

            <!-- delete checkbox -->
            <?php
                $total += $result_body[$i][2];
                if( $mode == 0 ){
                    echo "<td><input type=\"submit\" name=\"warranty". $result_body[$i][0] ."\" value=\"Add a Warranty\" method=POST/></td>";
                    echo "<td>" . $result_body[$i][2] * 0.25 . "</td>";
                    $total += $result_body[$i][2] * 0.25;
                    array_push($_SESSION['transactionAmount'], $result_body[$i][2]);
                    array_push($_SESSION['shippingCost'], $result_body[$i][2] * 0.25);
                    array_push($_SESSION['inStock'], $result_body[$i][3] <= 0);
                    array_push($_SESSION['catalogId'], $result_body[$i][4]);
                }else{
                    echo "<td><input type=\"submit\" name=\"remove". $result_body[$i][1] ."\" value=\"Remove this Warranty\" method=POST/></td>";                
                }
            ?>
            
            </tr>
        <?php } ?>
        </tbody></table>
<?php return $total; } ?>

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

<html lang="en">
    <p>CHECKOUT:</p>
    <p>SHOPPING CART</p>
<?php

    session_start();
    if(isset($_SESSION['cart'])){
    $dblist = "SELECT catalog_catalogId, catalog_itemName, catalog_currentPrice FROM Catalog;";
    $result = $conn->query($dblist);
    $resdata = $result->fetch_all();
    
    $skiprebuild = FALSE;
    //add waranties
    //remove waranties
    if(isset($_SESSION['madeTransactions']))
    for($i = 0; $i < count($_SESSION['madeTransactions']); $i++){
        if( $_SESSION['madeTransactions'][$i] == 0 )
            continue;

        $j = $_SESSION['madeTransactions'][$i];

        if(isset($_POST['warranty' . $j])){
            $dela_stmt = $conn->prepare("CALL warrantyInsertion(?, ?, ?)");
            $flatCost = '30.0';
            $flatDayrate = 10;
            $dela_stmt->bind_param('isd', $j, $flatCost, $flatDayrate);
            $dela_stmt->execute();
            $skiprebuild = TRUE;
        }

        if(isset($_POST['remove' . $j])){
            $dela_stmt = $conn->prepare("CALL warrantyDeleteByTransaction(?)");
            $dela_stmt->bind_param('i', $j);
            $dela_stmt->execute();
            $skiprebuild = TRUE;
        }
    }

    if(!$skiprebuild){
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
                    $transactionId = $dela_stmt->get_result()->fetch_all()[0][0];
                    array_push($_SESSION['madeTransactions'], $transactionId);
                }
    }
    }



    $conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname);
    
    if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit; // Quit this PHP script if the connection fails.
    }



    //I know what your thinking, "this should be a prepaired stmt";
    //counterpoint -> we only accept ids, those id's are verified to be numbers,
    //and there is no penalty, outside of an hidden err, if the numbers are out of range

    //this was just the cleanest way to do it, since php/sql doesn't have good vararg support

    if(!is_numeric($_SESSION['accountId']))
        goto SESSION_ERROR;

    $accumulatorStmt = "SELECT transaction_transactionId AS id, 
    catalog_itemName AS name, 
    catalog_currentPrice AS price,
    catalog_numberInStock AS stock,
    catalog_catalogId AS item_id
    FROM Transactions INNER JOIN Catalog USING (catalog_catalogId)
    WHERE account_accountId = " . $_SESSION['accountId'] . " AND ";

    $bccumulatorStmt = "SELECT warranty_warrantyId AS warranty_id,
    transaction_transactionId AS product_id,
    warranty_warrantyCost AS price,
    warranty_warrantyDate AS start_date,
    warranty_lengthInDays AS length
    FROM Warranties INNER JOIN Transactions USING (transaction_transactionId)
    WHERE account_accountId = " . $_SESSION['accountId'] . " AND ";

    for($i = 0; $i < COUNT($_SESSION['madeTransactions']); $i++){
        if($_SESSION['madeTransactions'][$i] == 0)
            continue;
        
        if(!is_numeric($_SESSION['madeTransactions'][$i]))
            goto SESSION_ERROR;

        $accumulatorStmt = $accumulatorStmt . "transaction_transactionId = " . $_SESSION['madeTransactions'][$i];
        $bccumulatorStmt = $bccumulatorStmt . "transaction_transactionId = " . $_SESSION['madeTransactions'][$i];
      
        if($i + 1 < COUNT($_SESSION['madeTransactions'])){
            $accumulatorStmt = $accumulatorStmt ." || ";
            $bccumulatorStmt = $bccumulatorStmt ." || ";
        }
    }

    $transactionRow = $conn->query($accumulatorStmt);
    $warrantyRow = $conn->query($bccumulatorStmt);
?>

<form action="checkout.php" method=POST>
    <?php
    $total = result_to_html_table($transactionRow, 0);

    echo "<p>SHOPPING CART WARRANTIES</p>";
    $total += result_to_html_table($warrantyRow, 1);
    ?>
</form>

<?php
SESSION_ERROR:

    echo "<p> TOTAL: $" . $total . "</p>";
    }
?>

<?php
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $_SESSION['shippingCode'] = '';
    for ($i = 0; $i < 20; $i++) {
        $_SESSION['shippingCode'] .= $characters[random_int(0, 35)];
    }
?>

<form action="finalizePayment.php" method=POST>
    <p><input type="text" name='cardnumber' value='Card Number'/></p>
    <p><input type="text" name='expdate' value='Expiration Date'/></p>
    <p><input type="text" name='cvv2' value='CVV2'/></p>
    <p><input type="text" name='cardname' value='Card Holder name'/></p>
    <p><input type="text" name='mailaddr' value='Mailing Address'/></p>
    <p><input type="text" name='shipaddr' value='Delivery Address'/> SHIPPED WITH UPS, TRACKING ID : <?php echo $_SESSION['shippingCode']; ?> </p>
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