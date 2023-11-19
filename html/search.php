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
    
    $dblist = "SELECT * FROM accounts";
    $result = $conn->query($dblist);
    $resdata = $result->fetch_all();
?>

<form action="productPage.php" method=POST>
<p>

<?php
    if(isset($_POST['searchCatagory'])){
        $dblist = "SELECT catalogId, itemName, categoryName FROM catalog INNER JOIN categories ON (category = categoryName);";
        $result = $conn->query($dblist);
        $resdata = $result->fetch_all();

        for($i = 0; $i < $result->num_rows; $i++){
            if($resdata[$i][2] === $_POST['search'])
                echo "<p><button name='product' value=" . $resdata[$i][0] . ">" . $resdata[$i][1] . "</button></p>";
        }
        
    }
?>

<?php
    if(isset($_POST['searchName'])){
        $dblist = "SELECT catalogId, itemName FROM catalog;";
        $result = $conn->query($dblist);
        $resdata = $result->fetch_all();

        for($i = 0; $i < $result->num_rows; $i++){
            if($resdata[$i][1] === $_POST['search'])
                echo "<p><button name='product' value=" . $resdata[$i][0] . ">" . $resdata[$i][1] . "</button></p>";
        }
        
    }
?>


</p>
</form>

</html>