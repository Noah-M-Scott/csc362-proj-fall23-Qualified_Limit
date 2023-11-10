<html>
<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
?>

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
    } else {
        echo "<p>Connected Successfully!</p>";
    }
?>

<?php 
    $edited = FALSE; //variable that tracks if we need to redirect or not
?>

<?php
    $dblist = "USE upward;";                        //set the db
    $result = $conn->query($dblist);                //
    
    $dblist = "SELECT userName, userPassWord FROM accounts";
    $result = $conn->query($dblist);
?>

<?php 
    session_start();                                                //start session

    if(isset($_POST['logoutBtn'])){                                 //are we loging out
        session_unset();                                            //log out
        session_destroy();
        $edited = TRUE;                                             //reload
    }else if(isset($_POST['loginBtn'])){                            //else are we loging in
        if($_POST['username'] !== ""){                              //did they bother to enter a usrname
            for($i = 0; $i < $result->num_rows; $i++){                  //for all the rows
                if($resdata[$i][0] == $_POST['username']){
                    if($resdata[$i][1] == $_POST['password']){
                        $_SESSION['username'] = $_POST['username'];             //if so, set it
                        $_SESSION['loginTime'] = time();                        //the time we log in
                        $edited = TRUE;                                         //reload
                    }
                }
            }
        }
    }

    if(isset($_SESSION['username'])){                               //check we're logged in
        if(time() - $_SESSION['loginTime'] > 1800){                 //if we've been logged in > 30mins
            session_unset();                                        //unlog in
            session_destroy();
            $edited = TRUE;                                         //reload page
        }
    }

?>

<?php 
    if($edited == TRUE){                                            //if we need to reload the page...
        header("Location: {$_SERVER['REQUEST_URI']}", true, 303);   //...redirect design pattern
        exit();
    }
?>

<form action="manageInstruments.php" method=POST>                  <!-- start of form -->
<?php
if(isset($_SESSION['username'])){   //if there's a username, we're logged in
    echo "<p>Hello ";
    echo $_SESSION['username'];
    echo "</p>";
    echo "<input type=\"submit\" name=\"logoutBtn\" value=\"Log Out\" method=POST/>";
}else{                              //else, log in prompt
    echo "<input type=text name='username' placeholder='Enter name...'/>";
    echo "<input type=text name='password' placeholder='Enter name...'/>";
    echo "<input type=\"submit\" name=\"loginBtn\" value=\"Log In\" method=POST/>";
}
?>
</form>


</html>