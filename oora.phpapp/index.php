<?php
  //if post request
  $con = mysql_connect($server = "mysql-shared-02.phpfog.com", $username = "Custom App-35792", $password = "Asdf1234");
  if (!$con)
  {
    die('Could not connect: ' . mysql_error());
  }

  mysql_select_db("oora_phpfogapp_com");

  $sql="INSERT INTO Order (RestaurantName, Name, Orders, Status, Comment) VALUES ('$_POST[restaurantName]','$_POST[name]','$_POST[order]'),'$_POST[status]'),'$_POST[comment]')";
  if (!mysql_query($sql,$con))
  {
    die('Error: ' . mysql_error());
  }
  echo "1 record added";

  //if get request
  //pull from database

  if( $_POST["name"] || $_POST["restaurant_name"] || $_POST["order"] )
  {
     echo "Hello ". $_POST['name']. ", Welcome to ". $_POST['restaurant_name']."<br />";
     echo "Your order: ". $_POST['order']. ".";
     exit();
  }
?>

<html>
<body>
  <form action="<?php $_PHP_SELF ?>" method="POST">

  Name: <input type="text" name="name" />
  Restaurant: <input type="text" name="restaurant_name" />
  Order: <input type="text" name="order" />

  <input type="submit" />
  </form>
</body>
</html>
