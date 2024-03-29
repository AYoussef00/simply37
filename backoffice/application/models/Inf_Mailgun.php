<?php

require_once dirname(__DIR__, 3) . '/vendor/autoload.php';

use Mailgun\Mailgun;

class Inf_mailgun {

    public $mgClient;
    public $domain;
    public $api_key;
    public $mail_from;
    public $mail_reply_to;

    public function __construct(array $config = array()) {
        $this->domain = $config['domain'];
        $this->mail_from = $config['from_name'] . ' <' . $config['from'] . '>';
        $this->mail_reply_to = ' <support@ioss.in>';
        $this->api_key = $config['api_key'];
        $this->mgClient = new Mailgun($this->api_key);
    }
    
    public function send($params = array()) {
        if(isset($params['email']) && isset($params['subject']) && isset($params['text']) && isset($params['html'])) {
        	if(isset($params['cc']) && $params['cc']) {
        		$result = $this->mgClient->sendMessage($this->domain, 
		            array(
		                'from' => $this->mail_from,
		                'to' => $params['name'] . ' <' . $params['email'] . '>',
		                'cc' => $params['cc'],
		                'subject' => $params['subject'],
		                'text' => $params['text'],
		                'html' => $params['html'],
		                'h:Reply-To' => $this->mail_reply_to
		            )
		        );
        	}
        	else {
        		$result = $this->mgClient->sendMessage($this->domain, 
		            array(
		                'from' => $this->mail_from,
		                'to' => $params['name'] . ' <' . $params['email'] . '>',
		                'subject' => $params['subject'],
		                'text' => $params['text'],
		                'html' => $params['html'],
		                'h:Reply-To' => $this->mail_reply_to
		            )
		        );
        	}
            
            return $result->http_response_code === 200;
        }
        else {
            return false;
        }
    }

}
