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
    $edited = FALSE; //variable that tracks if we need to redirect or not
?>

<?php
    $dblist = "USE upward;";                        //set the db
    $result = $conn->query($dblist);                //
    
    $dblist = "SELECT * FROM accounts";
    $result = $conn->query($dblist);
    $resdata = $result->fetch_all();
?>

<?php
    session_start();                                                //start session

    if(isset($_POST['logoutBtn'])){                                 //are we loging out
        session_unset();                                            //log out
        session_destroy();
        $edited = TRUE;                                             //reload
    }else if(isset($_POST['loginBtn'])){                            //else are we loging in
        for($i = 0; $i < $result->num_rows; $i++){                  //for all the rows
            if($resdata[$i][3] == $_POST['username']){              //check password
                if($resdata[$i][4] == $_POST['password']){          //check username
                    $_SESSION['username'] = $_POST['username'];             //if so, set it
                    $_SESSION['accountId'] = $resdata[$i][0];
                    $_SESSION['loginTime'] = time();                        //the time we log in
                    $edited = TRUE;                                         //reload
                    goto successLogIn;
                }
            }
        }
        echo "<p>Failed to Log in</p>";
        successLogIn:;
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
    if(isset($_POST['makeAccount'])){
        $dblist = "SELECT * FROM accounts";
        $result = $conn->query($dblist);
        $resdata = $result->fetch_all();

        $makestmt = $conn->prepare(file_get_contents('../sql_scripts/ONE_LINE_SCRIPT/SCRIPT_accountInsertion.sql'));
        $makestmt->bind_param('ssss', $_POST['email'], $_POST['phone'], $_POST['username'], $_POST['password']);

        for($i = 0; $i < $result->num_rows; $i++){
            if($resdata[$i][3] === $_POST['username'])
                goto usernameTaken;                         //skip insertion if username taken
        }
        
        if(!$makestmt->execute()){                          //execute prprd stmt
            echo $conn->error;                              //err on fail
        }
        $edited = TRUE;

        usernameTaken:;
        echo "<p>User name taken</p>";
    }
?>

<?php
    if(isset($_POST['deleteAccount'])){
        $dblist = "SELECT userName FROM accounts";
        $result = $conn->query($dblist);
        $resdata = $result->fetch_all();

        $makestmt = $conn->prepare(file_get_contents('../sql_scripts/ONE_LINE_SCRIPT/SCRIPT_accountDelete.sql'));
        $makestmt->bind_param('i', $_SESSION['accountId']);


        if(!$makestmt->execute()){                          //execute prprd stmt
            echo $conn->error;                              //err on fail
        }

        session_unset();                                            //log out
        session_destroy();
        $edited = TRUE;       
    }
?>


<?php 
    if($edited == TRUE){                                            //if we need to reload the page...
        header("Location: {$_SERVER['REQUEST_URI']}", true, 303);   //...redirect design pattern
        exit();
    }
?>

<form action="loginPage.php" method=POST>                  <!-- start of form -->
<?php
if(isset($_POST['wannaLog'])){
    if(isset($_SESSION['username'])){   //if there's a username, we're logged in
        echo "<p>Hello ";
        echo $_SESSION['username'];
        echo "</p>";
        echo "<input type=\"submit\" name=\"logoutBtn\" value=\"Log Out\" method=POST/>";
        echo "<input type=\"submit\" name=\"deleteAccount\" value=\"Delete Account\" method=POST/>";
    }else{                              //else, log in prompt
        echo "<p>Login</p>";
        echo "<p><input type=text name='username' placeholder='Enter username...'/></p>";
        echo "<p><input type=text name='password' placeholder='Enter password...'/></p>";
        echo "<p><input type=\"submit\" name=\"loginBtn\" value=\"Log In\" method=POST/></p>";
    }
}else if(isset($_POST['wannaMake'])){
    echo "<p>Make Account</p>";
    echo "<p><input type=text name='username' placeholder='Enter username...'/></p>";
    echo "<p><input type=text name='password' placeholder='Enter password...'/></p>";
    echo "<p><input type=text name='email' placeholder='Enter Email...'/></p>";
    echo "<p><input type=text name='phone' placeholder='Enter Phone Number...'/></p>";
    echo "<p><input type=\"submit\" name=\"makeAccount\" value=\"Make Account\" method=POST/></p>";
}else{
    if(isset($_SESSION['username'])){   //if there's a username, we're logged in
        echo "<p>Hello ";
        echo $_SESSION['username'];
        echo "</p>";
    }else{
        echo "<p>Not Logged In...</p>";
    }
    echo "<p>Account</p>";
    echo "<p><input type=\"submit\" name=\"wannaLog\" value=\"Manage Account\" method=POST/></p>";
    if(!isset($_SESSION['username']))
    echo "<p><input type=\"submit\" name=\"wannaMake\" value=\"Make Account\" method=POST/></p>";
}
?>
</form>

<form action="shoppingCart.php" method=POST>
<?php
    if(!isset($_POST['wannaLog']))
    if(isset($_SESSION['username']))
        echo "<p><input type=\"submit\" name=\"gotoCart\" value=\"Go to Cart\" method=POST/></p>";
?>
</form>

<form action="claimWarranty.php" method=POST>
<?php
    if(!isset($_POST['wannaLog']))
    if(isset($_SESSION['username']))
        echo "<p><input type=\"submit\" name=\"gotoWarranty\" value=\"Claim a Warranty\" method=POST/></p>";
?>
</form>

<form action="index.php" method=POST>
<?php
    if(!isset($_POST['wannaLog'])){
        echo "<p><input type=\"submit\" name=\"returnHome\" value=\"Return to Homepage\" method=POST/></p>";
    }
?>
</form>


</html>