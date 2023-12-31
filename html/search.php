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
        exit; // Quit this PHP script if the connection fails.
    }
?>

<?php 
    $edited = FALSE; //variable that tracks if we need to redirect or not
?>

<form action="search.php" method=POST>                  <!-- start of form -->
<p>
    <input type='text' name='search' placeholder='Enter search term...'/>
    <input type='submit' name='searchCatagory' value='Search by catagory' method=POST/>
    <input type='submit' name='searchName' value='Search by name' method=POST/>
</p>
</form>


<?php
    $dblist = "USE upward;";                        //set the db
    $result = $conn->query($dblist);                //
    
    $dblist = "SELECT * FROM Accounts";
    $result = $conn->query($dblist);
    $resdata = $result->fetch_all();
?>

<p>
<form action="productPage.php" method=POST>

<?php
    if(isset($_POST['searchCatagory'])){
        //Note that we are getting everything from the DB, then filtering. Is this less efficient than filtering in the DB?
        $dblist = "SELECT catalog_catalogId, catalog_itemName, catalog_currentPrice, catalog_numberInStock, 
        catagory_categoryName FROM Catalog INNER JOIN Categories ON (catalog_category = catagory_categoryName);";
        $result = $conn->query($dblist);
        $resdata = $result->fetch_all();

        for($i = 0; $i < $result->num_rows; $i++){
            if($resdata[$i][4] === $_POST['search'])
            echo "<p><button name='product' value=" . $resdata[$i][0] . ">" . $resdata[$i][1] . 
            "</button> Price: $" . $resdata[$i][2] . " Quantity Available: " . $resdata[$i][3] . 
            " Category: " . $resdata[$i][4] . "</p>";        }
        
    }
?>

<?php
    if(isset($_POST['searchName'])){
        $dblist = "SELECT catalog_catalogId, catalog_itemName, catalog_currentPrice, catalog_numberInStock, 
        catagory_categoryName FROM Catalog INNER JOIN Categories ON (catalog_category = catagory_categoryName);";
        $result = $conn->query($dblist);
        $resdata = $result->fetch_all();

        for($i = 0; $i < $result->num_rows; $i++){
            if($resdata[$i][1] === $_POST['search'])
            echo "<p><button name='product' value=" . $resdata[$i][0] . ">" . $resdata[$i][1] . 
            "</button> Price: $" . $resdata[$i][2] . " Quantity Available: " . $resdata[$i][3] . 
            " Category: " . $resdata[$i][4] . "</p>";        }
        
    }
?>

<?php
    if(!isset($_POST['searchName']) && !isset($_POST['searchCatagory'])){
        $dblist = "SELECT catalog_catalogId, catalog_itemName, catalog_currentPrice, catalog_numberInStock, 
        catagory_categoryName FROM Catalog INNER JOIN Categories ON (catalog_category = catagory_categoryName);";
        $result = $conn->query($dblist);
        $resdata = $result->fetch_all();

        for($i = 0; $i < $result->num_rows; $i++){
            echo "<p><button name='product' value=" . $resdata[$i][0] . ">" . $resdata[$i][1] . 
            "</button> Price: $" . $resdata[$i][2] . " Quantity Available: " . $resdata[$i][3] . 
            " Category: " . $resdata[$i][4] . "</p>";
        }
    }
?>

<?php 
    if($edited == TRUE){                                            //if we need to reload the page...
        header("Location: {$_SERVER['REQUEST_URI']}", true, 303);   //...redirect design pattern
        exit();
    }
?>

</form>

<form action="index.php" method=POST>
<?php
    if(!isset($_POST['wannaLog'])){
        echo "<p><input type=\"submit\" name=\"returnHome\" value=\"Return to Homepage\" method=POST/></p>";
    }
?>
</form>
</p>

</html>