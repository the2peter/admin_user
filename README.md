ก่อนที่จะเริ่มทำ Login ให้สร้างฐานข้อมูลขึ้นมาก่อน จะมี code อยู่ข้างล่าง
ให้นำ code ที่ให้มา ไปวางไว้ใน เมนู SQL ของ xampp หรือ appserv
จะได้ฐานข้อมูลชื่อว่า login_db ตาราง login

 database สำหรับสร้างตารางฐานข้อมูล




SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";
CREATE DATABASE IF NOT EXISTS `login_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `login_db`;
CREATE TABLE `login` (
  `ID` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `level` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `login` (`ID`, `username`, `password`, `name`, `level`) VALUES
(1, '111', '111', 'waiyawut', 'admin'),
(2, '222', '222', 'devtai', 'member');
ALTER TABLE `login`
  ADD PRIMARY KEY (`ID`);
ALTER TABLE `login`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

-----------------------------------------------------------------------------------------------
สร้างฐานข้อมูลเรียบร้อยแล้ว ต่อไปสร้างไฟล์เชื่อมต่อกับฐานข้อมูล
condb.php




<?php
$con= mysqli_connect("localhost","root","","login_db") or die("Error: " . mysqli_error($con));
mysqli_query($con, "SET NAMES 'utf8' ");
error_reporting( error_reporting() & ~E_NOTICE );
date_default_timezone_set('Asia/Bangkok');
?>

---------------------------------------------------------------------------------------
ขั้นต่อมาสร้างไฟล์ index และ ไฟล์ h เพื่อทำ Form Login
index.php 


<?php include('condb.php');?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css&quot; integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css&quot; integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
    <title>Login by.devtai.com</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
  </head>
  <body>
    <div class="container" style="padding-top:100px">
  <div class="row">
    <div class="col-md-4"></div>
    <div class="col-md-4" style="background-color:#D6EAF8">
      <h3 align="center">
      <span class="glyphicon glyphicon-lock"> </span>
      Form Login </h3>
      <form  name="formlogin" action="checklogin.php" method="POST" id="login" class="form-horizontal">
        <div class="form-group">
          <div class="col-sm-12">
            <input type="text"  name="username" class="form-control" required placeholder="Username" />
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-12">
            <input type="password" name="password" class="form-control" required placeholder="Password" />
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-12">
            <button type="submit" class="btn btn-success" id="btn">
            <span class="glyphicon glyphicon-log-in"> </span>
             Login </button>
               <label>
                <input type="checkbox" checked="checked" name="remember"> Remember me
               </label>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>


----------------------------------------------------------
h.php


<?php include('condb.php');?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <!-- Latest compiled and minified CSS -->
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css&quot; integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <!-- Optional theme -->
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css&quot; integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
    <title>Login by.devtai.com</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
  </head>
  <body>

--------------------------------------------------------------------------------------------------
ต่อไปสร้างไฟล์ Admin และ Member เพื่อไว้รับการ Login เข้ามา
admin.php


<?php session_start();
include('condb.php');
 
  $ID = $_SESSION['ID'];
  $name = $_SESSION['name'];
  $level = $_SESSION['level'];
   if($level!='admin'){
    Header("Location: ../logout.php");  
  }  
?>
<!DOCTYPE html>
<html>
<head>
   <title></title>
</head>
<body>
   <form action="logout.php">
   <h1>Admin Page</h1>
   <h3> สวัสดี คุณ <?php echo $name; ?> สถานะ <?php echo $level; ?> </h3>
   <input type="submit" value="ออกจากระบบ">
   </form>
</body>
</html>
----------------------------------------------------------------------------------------------------------------
member.php



<?php session_start();  
include('condb.php');
 
  $ID = $_SESSION['ID'];
  $name = $_SESSION['name'];
  $level = $_SESSION['level'];
   if($level!='member'){
    Header("Location: ../logout.php");  
  }  
?>
<!DOCTYPE html>
<html>
<head>
   <title></title>
</head>
<body>
   <form action="logout.php">
   <h1>Member Page</h1>
   <h3> สวัสดี คุณ <?php echo $name; ?> สถานะ <?php echo $level; ?> </h3>
   <input type="submit" value="ออกจากระบบ">
   </form>
</body>
</html>
ขั้นสุดท้าย สร้างไฟล์ไว้เช็คการ Login เข้ามาเพื่อใช้สิทธิ์ สถานะ เป็นอะไร
และสร้างไฟล์ล้างสถานะ Logout ออกจากระบบ

--------------------------------------------------------------------------------------------------------
checklogin.php


<?php
session_start();
        if(isset($_POST['username'])){
                  include("condb.php");
                  $username = $_POST['username'];
                  $password = $_POST['password'];
 
                  $sql="SELECT * FROM login
                  WHERE  username='".$username."'
                  AND  password='".$password."' ";
                  $result = mysqli_query($con,$sql);
               
                  if(mysqli_num_rows($result)==1){
                      $row = mysqli_fetch_array($result);
 
                      $_SESSION["ID"] = $row["ID"];
                      $_SESSION["name"] = $row["name"];
                      $_SESSION["level"] = $row["level"];
 
                      if($_SESSION["level"]=="admin"){
 
                        Header("Location: admin.php");
                      }
                  if ($_SESSION["level"]=="member"){
 
                        Header("Location: member.php");
                      }
                  }else{
                    echo "<script>";
                        echo "alert(\" user หรือ  password ไม่ถูกต้อง\");";
                        echo "window.history.back()";
                    echo "</script>";

                  }
        }else{
 
             Header("Location: index.php"); //user & password incorrect back to login again

        }
?>

--------------------------------------------------------------------------------------
logout.php


<?php
session_start();
session_destroy();
header("Location: index.php");    
?>
