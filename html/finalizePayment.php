<?php
    /*
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    */
?>


<?php
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
                $total += $result_body[$i][2] + $result_body[$i][2] * 0.25;
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

<b> Thank You For Your Purchase! </b>

<?php
    
    session_start();

    for($j = 0; $j < count($_SESSION['madeTransactions']); $j++)
        if($_SESSION['madeTransactions'][$j] != 0){
            $dela_stmt = $conn->prepare("CALL shippingDataInsert(?, ?, ?, ?, ?, ?);");
            $ups = 'UPS';
            $trueValue = TRUE;
            $dela_stmt->bind_param('issssi',    $_SESSION['madeTransactions'][$j], 
                                                $_SESSION['shippingCode'], 
                                                $_POST['shipaddr'], 
                                                $_SESSION['shippingCost'][$j],
                                                $ups,
                                                $trueValue);
            $dela_stmt->execute();

            $dela_stmt =  $conn->prepare("CALL transactionUpdate(?, ?, ?, ?);");
            $dela_stmt->bind_param('iiis',  $_SESSION['madeTransactions'][$j], 
                                            $trueValue, 
                                            $_SESSION['inStock'][$j],
                                            $_SESSION['transactionAmount'][$j] 
                                            );
            $dela_stmt->execute();

            $dela_stmt =  $conn->prepare("CALL catalogDecrement(?);");
            $dela_stmt->bind_param('i',  $_SESSION['catalogId'][$j]);
            $dela_stmt->execute();
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
    shippingDatum_destinationAddress AS destination,
    shippingDatum_shippingCost AS shipping_cost,
    transaction_onHold AS on_hold,
    warranty_warrantyId AS warranty_id,
    warranty_warrantyCost AS price,
    warranty_warrantyDate AS start_date,
    warranty_lengthInDays AS length
    FROM Transactions INNER JOIN Catalog USING (catalog_catalogId)
    INNER JOIN ShippingData USING (transaction_transactionId)
    LEFT OUTER JOIN Warranties USING (transaction_transactionId)
    WHERE account_accountId = " . $_SESSION['accountId'] . " AND ";

    for($i = 0; $i < COUNT($_SESSION['madeTransactions']); $i++){
        if($_SESSION['madeTransactions'][$i] == 0)
            continue;
        
        if(!is_numeric($_SESSION['madeTransactions'][$i]))
            goto SESSION_ERROR;

        $accumulatorStmt = $accumulatorStmt . "transaction_transactionId = " . $_SESSION['madeTransactions'][$i];

        if($i + 1 < COUNT($_SESSION['madeTransactions'])){
            $accumulatorStmt = $accumulatorStmt ." || ";
        }
    }

    $transactionRow = $conn->query($accumulatorStmt);
?>

<?php
SESSION_ERROR:
    $total = result_to_html_table($transactionRow, 0);
    echo "<p> TOTAL: $" . $total . "</p>";

    unset($_SESSION['madeTransactions']);
    unset($_SESSION['cart']);
    unset($_SESSION['shippingCost']);
    unset($_SESSION['transactionAmount']);
    unset($_SESSION['inStock']);
    unset($_SESSION['catalogId']);

?>

<form action="shoppingCart.php" method=POST>
    <?php
    echo "<p>";
    if( array_key_exists('username', $_SESSION))
    if(isset($_SESSION['username']))
        echo "<input type=\"submit\" name=\"gotoCart\" value=\"Return to Cart\" method=POST/>";
    ?>
</form>



