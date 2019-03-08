<?php  session_start();
if(isset($_SESSION['user']))
    header("Location:home.php");

if(isset($_POST['login']))
{
    $user = $_POST['user'];
    $pass = $_POST['pass'];

    if($user == "dylan" && $pass == "dylan")
    {
        $_SESSION['user'] = $user;
        echo '<script type="text/javascript"> window.open("index.php","_self");</script>';}

    else
        echo "nope, try again";
}
?>
<html>
<head>
    <title>login</title>
</head>
<body>
<form action="" method="post">
    <table width="200" border="0">
        <tr>
            <td>Login</td>
            <td><input type="text" name="user" > </td>
        </tr>
        <tr>
            <td>Mot de passe</td>
            <td><input type="password" name="pass"></td>
        </tr>
        <tr>
            <td> <input type="submit" name="login" value="Connexion"></td>
            <td></td>
        </tr>
    </table>
</form>
</body>
</html>