<?php
  $con = mysql_connect($server = "mysql-shared-02.phpfog.com", $username = "Custom App-35792", $password = "Asdf1234");
  if (!$con) {
    die('Could not connect: ' . mysql_error());
  }
  mysql_select_db("oora_phpfogapp_com");

  if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $sql="INSERT INTO Order (RestaurantName, Name, Orders, Status, Comment) VALUES ('$_POST[restaurantName]','$_POST[name]','$_POST[order]'),'$_POST[status]'),'$_POST[comment]')";
    if (!mysql_query($sql,$con)) {
      die('Error: ' . mysql_error());
    }
    echo "Your order has been placed. Thank you.";
  }
  elseif ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $result = mysql_query("SELECT * FROM Order WHERE RestaurantName='//restaurant name'");
    while($row = mysql_fetch_array($result)) {
      //echo $row['FirstName'] . " " . $row['LastName'];
      //echo "<br />";
      //fetch all information
    }
    //need update??
  }

  mysql_close($con);
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
