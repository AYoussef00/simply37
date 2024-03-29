<?php

require_once 'Inf_Controller.php';

class Tree extends Inf_Controller {

    function __construct() {
        parent::__construct();
    }

    function index() {
        $this->redirect("", "genology_tree");
    }

    function genology_tree() {
        $title = lang('genealogy_tree');
        $this->set('title', $this->COMPANY_NAME . " | $title");

        $help_link = "genealogy_tree";
        $this->set("help_link", $help_link);

        $this->HEADER_LANG['page_top_header'] = lang('genealogy_tree');
        $this->HEADER_LANG['page_top_small_header'] = '';
        $this->HEADER_LANG['page_header'] = lang('genealogy_tree');
        $this->HEADER_LANG['page_small_header'] = '';

        $this->load_langauge_scripts();

        $user_type = $this->LOG_USER_TYPE;
        $user_id = $this->LOG_USER_ID;
        $user_name = $this->LOG_USER_NAME;

        if ($user_type == 'employee') {
            $user_id = $this->validation_model->getAdminId();
            $user_name = $this->validation_model->getAdminUsername();
        }
        if ($this->input->get('user_name')) {
            $user_name = $this->input->get('user_name');
            $user_id = $this->validation_model->userNameToID($user_name);
            if (!$user_id) {
                $msg = lang('invalid_user_name');
                $this->redirect($msg, 'genology_tree', FALSE);
            }
        }

        $tree_based_on = $this->configuration_model->getTreeBasedOnConfig();
        $member_status = $this->configuration_model->getMemberStatus();
        
        if($this->MODULE_STATUS['opencart_status'] == "yes") {
            $membership_package = $this->product_model->getPackageListOpenCart($package_type = 'registration', $status = 1);
            $next_index = count($membership_package) + 1;
            $membership_package[$next_index]['product_id'] = 'defualt';
            $membership_package[$next_index]['product_name'] = 'Default';
            $membership_package[$next_index]['tree_icon'] = $this->configuration_model->getDefualtIcon('package');

            foreach ($membership_package as $key => $mem) {
                $membership_package[$key]['product_name'] = isset($mem['package_id']) ? $mem['model'] : $mem['product_id'];
                $tree['member_package'][$mem['product_id']] = isset($mem['package_id']) ? $mem['package_id'] : $mem['product_id'];
            }
        } else {
            $membership_package = $this->product_model->getPackageList($package_type = 'registration', $status = 'yes');
            $next_index = count($membership_package) + 1;
            $membership_package[$next_index]['product_id'] = 'defualt';
            $membership_package[$next_index]['product_name'] = 'Default';
            $membership_package[$next_index]['tree_icon'] = $this->configuration_model->getDefualtIcon('package');

            foreach ($membership_package as $key => $mem) {
                $tree['member_package'][$mem['product_id']] = $mem['product_name'];
            }
        }
        
        $rank_details = $this->configuration_model->getActiveRankDetails();

        $next_index = count($rank_details) + 1;
        $rank_details[$next_index]['rank_id'] = 'defualt';
        $rank_details[$next_index]['rank_name'] = 'Default';
        $rank_details[$next_index]['tree_icon'] = $this->configuration_model->getDefualtIcon('rank');

         
        $this->set('rank_details', $rank_details);
        $this->set('membership_package', $membership_package);
        $this->set('member_status',$member_status);
        $this->set('tree_based_on',$tree_based_on);
        $this->set('user_name', $user_name);

        $this->tree_model->renderTree($user_id, $this->MODULE_STATUS);
        $display_tree = $this->tree_model->display_tree;
        $tooltip_array = $this->tree_model->tree_tooltip_array;
// dd($tooltip_array);
        $tooltip_config = $this->validation_model->getTooltipConfig();
        $this->set('tooltip_config', $tooltip_config);
        $this->set('tooltip_array', $tooltip_array);
        $this->set('display_tree', $display_tree);

        $this->setView();
    }

    function tree_view() {
        $post_array = $this->input->post(NULL, TRUE);
        $post_array = $this->validation_model->stripTagsPostArray($post_array);
        $user_name = $post_array['user_name'];
        $user_id = $this->validation_model->userNameToID($user_name);

        if ($user_id) {
            //$this->tree_model->getAllTreeUsers($user_id);
            // $this->tree_model->getTreeView($user_id);
            $this->tree_model->renderTree($user_id, $this->MODULE_STATUS);
            $display_tree = $this->tree_model->display_tree;
            $tooltip_array = $this->tree_model->tree_tooltip_array;
            $tooltip_config = $this->validation_model->getTooltipConfig();
            $this->set('tooltip_config', $tooltip_config);
            $this->set('tooltip_array', $tooltip_array);
            $this->set('display_tree', $display_tree);
            $this->set('user_name', $user_name);
            $this->setView();
        } else {
            echo 'Invalid User Name...';
            die();
        }
    }

    function sponsor_tree() {
        $title = lang('sponsor_tree');
        $this->set('title', $this->COMPANY_NAME . " | $title");

        $help_link = "sponsor-tree";
        $this->set("help_link", $help_link);

        $this->HEADER_LANG['page_top_header'] = lang('sponsor_tree');
        $this->HEADER_LANG['page_top_small_header'] = '';
        $this->HEADER_LANG['page_header'] = lang('sponsor_tree');
        $this->HEADER_LANG['page_small_header'] = '';

        $this->load_langauge_scripts();

        $user_type = $this->LOG_USER_TYPE;
        $user_id = $this->LOG_USER_ID;
        $user_name = $this->LOG_USER_NAME;

        if ($user_type == 'employee') {
            $user_id = $this->validation_model->getAdminId();
            $user_name = $this->validation_model->getAdminUsername();
        }
        if ($this->input->get('user_name')) {
            $user_name = $this->input->get('user_name');
            $user_id = $this->validation_model->userNameToID($user_name);
            if (!$user_id) {
                $msg = lang('invalid_user_name');
                $this->redirect($msg, 'sponsor_tree', FALSE);
            }
        }
        $tree_based_on = $this->configuration_model->getTreeBasedOnConfig();
        $member_status = $this->configuration_model->getMemberStatus();
        
        if($this->MODULE_STATUS['opencart_status'] == "yes") {
            $membership_package = $this->product_model->getPackageListOpenCart($package_type = 'registration', $status = 1);
            $next_index = count($membership_package) + 1;
            $membership_package[$next_index]['product_id'] = 'defualt';
            $membership_package[$next_index]['product_name'] = 'Default';
            $membership_package[$next_index]['tree_icon'] = $this->configuration_model->getDefualtIcon('package');

            foreach ($membership_package as $key => $mem) {
                $membership_package[$key]['product_name'] = isset($mem['package_id']) ? $mem['model'] : $mem['product_id'];
                $tree['member_package'][$mem['product_id']] = isset($mem['package_id']) ? $mem['package_id'] : $mem['product_id'];
            }
        } else {
            $membership_package = $this->product_model->getPackageList($package_type = 'registration', $status = 'yes');
            $next_index = count($membership_package) + 1;
            $membership_package[$next_index]['product_id'] = 'defualt';
            $membership_package[$next_index]['product_name'] = 'Default';
            $membership_package[$next_index]['tree_icon'] = $this->configuration_model->getDefualtIcon('package');

            foreach ($membership_package as $key => $mem) {
                $tree['member_package'][$mem['product_id']] = $mem['product_name'];
            }
        }
        
        $rank_details = $this->configuration_model->getActiveRankDetails();

        $next_index = count($rank_details) + 1;
        $rank_details[$next_index]['rank_id'] = 'defualt';
        $rank_details[$next_index]['rank_name'] = 'Default';
        $rank_details[$next_index]['tree_icon'] = $this->configuration_model->getDefualtIcon('rank');

         
        $this->set('rank_details', $rank_details);
        $this->set('membership_package', $membership_package);
        $this->set('member_status',$member_status);
        $this->set('tree_based_on',$tree_based_on);
        
        $this->set('user_name', $user_name);

        $this->tree_model->renderTree($user_id, $this->MODULE_STATUS, 'sponsor_tree');
        $display_tree = $this->tree_model->display_tree;
        $tooltip_array = $this->tree_model->tree_tooltip_array;
        $tooltip_config = $this->validation_model->getTooltipConfig();
        $this->set('tooltip_config', $tooltip_config);
        $this->set('tooltip_array', $tooltip_array);
        $this->set('display_tree', $display_tree);
        
        $this->setView();
    }

    function tree_view_sponsor() {
        $post_array = $this->input->post(NULL, TRUE);
        $post_array = $this->validation_model->stripTagsPostArray($post_array);

        $user_name = $post_array['user_name'];
        $user_id = $this->validation_model->userNameToID($user_name);

        if ($user_id) {
            //$this->tree_model->getAllTreeUsers($user_id, "sponsor_tree");
            // $this->tree_model->getTreeView($user_id, 'sponsor_tree');
            $this->tree_model->renderTree($user_id, $this->MODULE_STATUS, 'sponsor_tree');
            $display_tree = $this->tree_model->display_tree;
            $tooltip_array = $this->tree_model->tree_tooltip_array;
            $tooltip_config = $this->validation_model->getTooltipConfig();
            $this->set('tooltip_config', $tooltip_config);

            $this->set('tooltip_array', $tooltip_array);
            $this->set('display_tree', $display_tree);
            $this->setView();
        } else {
            echo 'Invalid User Name...';
            die();
        }
    }

    function select_tree() {

        $title = $this->lang->line('tabular_tree');
        $this->set('title', $this->COMPANY_NAME . " | $title");

        $help_link = "tabular-tree";
        $this->set("help_link", $help_link);

        $this->HEADER_LANG['page_top_header'] = lang('tabular_tree');
        $this->HEADER_LANG['page_top_small_header'] = '';
        $this->HEADER_LANG['page_header'] = lang('tabular_tree');
        $this->HEADER_LANG['page_small_header'] = '';

        $this->load_langauge_scripts();

        $user_type = $this->LOG_USER_TYPE;
        $user_id = $this->LOG_USER_ID;
        $user_name = $this->LOG_USER_NAME;

        if ($user_type == 'employee') {
            $user_id = $this->validation_model->getAdminId();
            $user_name = $this->validation_model->getAdminUsername();
        }

        if ($this->input->get('user_name')) {
            $user_name = $this->input->get('user_name');
            $user_id = $this->validation_model->userNameToID($user_name);
            if (!$user_id) {
                $msg = lang('invalid_user_name');
                $this->redirect($msg, 'select_tree', FALSE);
            }
        }

        $this->set('user_name', $user_name);

        $this->setView();
    }

    function select_tree_view($user_name = "") {
        $user_id = $this->validation_model->userNameToID($user_name);
        if($user_id) {
            echo $this->tree_model->getChildren((int)$user_id);
            exit();
        }
        echo json_encode(array());
        exit();
    }

    function getEncrypt($string) {
        $id_encode = $this->encryption->encrypt($string);
        $id_encode = str_replace("/", "_", $id_encode);
        return $encrypt_id = urlencode($id_encode);
    }

    function board_view($board_id = '', $encrypted_id = "") {
        $title = $this->lang->line('board_view');
        $this->set('title', $this->COMPANY_NAME . " | $title");

        $this->load->model('configuration_model');
        $board_config = $this->configuration_model->getBoardSettings($board_id);

        $this->HEADER_LANG['page_top_header'] = $board_config[0]['board_name'];
        $this->HEADER_LANG['page_top_small_header'] = lang('');
        $this->HEADER_LANG['page_header'] = $board_config[0]['board_name'];
        $this->HEADER_LANG['page_small_header'] = lang('');

        $help_link = "Board View";
        $this->set("help_link", $help_link);

        $this->load_langauge_scripts();

        $user_id = "";
        // $id = urldecode($encrypted_id);
        // $id_decode = str_replace("_", "/", $id);
        // $id_decrypt = $this->encryption->decrypt($id_decode);

        $id_decrypt = urldecode($encrypted_id);

        if ($this->validation_model->isUserAvailableinBoard($id_decrypt, $board_id)) {
            $user_id = $id_decrypt;
            $user_name = $this->validation_model->IdToUserName($user_id);
            if (isset($this->MODULE_STATUS['table_status']) && $this->MODULE_STATUS['table_status'] == "yes") {
                $this->load->model('configuration_model');
                $board_config = $this->configuration_model->getBoardSettings($board_id);
                $user_board_details = $this->tree_model->getUserBoard($user_id, $board_id);
                $tooltip_array = $this->tree_model->board_tooltip_array;
                $this->set("board_config", $board_config[0]);
                $this->set("user_board_details", $user_board_details);
                $this->set("tooltip_array", $tooltip_array);
            } else {
                $this->load->model('boardview_model');
                $this->boardview_model->getAllBoardUsers($user_id, $board_id);
                $display_tree = $this->boardview_model->display_tree;
                $tooltip_array = $this->boardview_model->tree_tooltip_array;

                $this->set('tooltip_array', $tooltip_array);
                $this->set('display_tree', $display_tree);
                $this->set('user_name', $user_name);
            }
        } else {
            $this->redirect("Invalid User", "boardview/board_view_management/$board_id", FALSE);
        }

        $tooltip_config = $this->validation_model->getTooltipConfig();
        $this->set('tooltip_config', $tooltip_config);
        $this->set('user_name', $user_name);
        $this->set("board_id", $board_id);
        $this->set("board_config", $board_config[0]);
        $this->set("board_name", $board_config[0]['board_name']);

        $this->setView();
    }

    function step_view() {
        $title = $this->lang->line('step_view');
        $this->set('title', $this->COMPANY_NAME . " | $title");


        $this->HEADER_LANG['page_top_header'] = $this->lang->line('step_view');
        $this->HEADER_LANG['page_top_small_header'] = lang('');
        $this->HEADER_LANG['page_header'] =$this->lang->line('step_view');
        $this->HEADER_LANG['page_small_header'] = lang('');

        $help_link = "Step View";
        $this->set("help_link", $help_link);

        $this->load_langauge_scripts();

        $user_id = $this->LOG_USER_ID;  
        $user_name = $this->LOG_USER_NAME;

        if($this->input->post('user_name')){
            $user_name = $this->input->post('user_name', TRUE);
            $user_id = $this->validation_model->userNameToID($user_name);
            if (!$this->validation_model->isUserAvailable($user_id)) {
                $this->redirect( lang('invalid_user_name'), "tree/step_view", FALSE);
            }
            $user_id = $this->validation_model->getUserLeaderId($user_id);

        }

        $this->tree_model->getAllStepUsers($user_id);

        $user_step_details['tree_depth'] = count($this->tree_model->step_array) - 1;
        $user_step_details['tree_width'] = $this->tree_model->step_array['width'];
        unset($this->tree_model->step_array['width']);

        $user_step_details['users'] = $this->tree_model->step_array;
        $tooltip_array = $this->tree_model->step_tooltip_array;
        $tooltip_config = $this->validation_model->getTooltipConfig();
        $this->set('tooltip_config', $tooltip_config);

        $this->set("user_step_details", $user_step_details);
        $this->set("tooltip_array", $tooltip_array);
        $this->set('user_name', $user_name);

        $row_span = $user_step_details['tree_depth'];
        $row_span_array = array();
        
        foreach ($user_step_details['users'] as $step_id => $value) {
            $row_step_width = ($user_step_details['tree_depth'] - $step_id + 1) * count($value) ;
            $row_span = max($row_step_width , $user_step_details['tree_depth']);
        
            $row_span_array[$step_id]= $row_span;
        }

        $row_span = max($row_span_array);
        $this->set('row_span', $row_span);
        $this->set('row_span_array', $row_span_array);

        $this->setView();
    }
    
}
