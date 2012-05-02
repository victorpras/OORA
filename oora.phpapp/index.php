<?php
  require "lib/Services/Twilio.php";
  $phoneNum = $_POST["dataNum"];
  $orderID = $_POST["dataID"];
  $restName = $_POST["dataRest"];
  $AccountSid = "AC5660ef3978e789901ae909cca3b5dec5";
  $AuthToken = "fd0af4db87137c0cb6b3b050c37bcb93";
  $client = new Services_Twilio($AccountSid, $AuthToken);
  $sms = $client->account->sms_messages->create("562-275-8881",$phoneNum,"http://dl.dropbox.com/u/12374742/page.html?restName=".$restName."&orderID=".$orderID);
  echo "Message has been sent ";
  echo $phoneNum . " ";
  echo $orderID . " ";
  echo $restName;
?>
