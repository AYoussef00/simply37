<?php
$ch = curl_init();
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($ch, CURLOPT_URL, 'http://localhost/WC/Revamp_Responsive/backoffice/admin/cron/auto_cache_clear');
$store = curl_exec($ch);
curl_close($ch);
?>