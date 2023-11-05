<?php

$headers = getallheaders();

// X-Requested-With: XMLHttpRequest
//$sendJson = strpos(@$headers['User-Agent'], 'curl/') === false || strpos(@$headers['Accept'], 'json') !== false;
$sendJson = isset($_REQUEST['json']);

if ($sendJson) {
    //header_remove('Content-Type');
    //header_remove('Content-Type: text/plain');
    header('Content-Type: application/json');
    echo json_encode($headers, JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES|JSON_PRETTY_PRINT) . "\n";
} else {
    header('Content-Type: text/plain');
    $max = max(array_map('strlen', array_keys($headers)));
    foreach ($headers as $header => $val) {
        echo sprintf("%s | %s\n", str_pad($header, $max), $val);
    }
}
