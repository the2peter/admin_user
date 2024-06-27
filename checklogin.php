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
