{extends file=$BASE_TEMPLATE}
{block name=user_style}
  <link href="{$PUBLIC_URL}css/user_profile.css" rel="stylesheet">
  <link rel="stylesheet" href="{$PUBLIC_URL}javascript/toastr/jquery.toast.min.css">
  <link rel="stylesheet" href="{$PUBLIC_URL}javascript/toastr/jquery.toast.min.css">
<style>
.profile-email {
  margin-bottom: 10px;
}
.avatar-upload {
  position: relative;
  max-width: 205px;
  margin: 0 auto;
}
.avatar-upload .avatar-edit {
  position: absolute;
  right: 12px;
  z-index: 1;
  bottom: 0;
}
.avatar-upload .avatar-edit input {
  display: none;
}
.avatar-upload .avatar-edit input + label {
  color: #fff;
  display: inline-block;
  width: 34px;
  height: 34px;
  margin-bottom: 0;
  border-radius: 100%;
  background: #201e1ed4;;
  box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.12);
  cursor: pointer;
  font-weight: normal;
  transition: all 0.2s ease-in-out;
}
.avatar-upload .avatar-edit input + label:hover {
  background: #201e1ed4;
  border-color: #d6d6d6;
}
.avatar-upload .avatar-edit input + label:after {
  content: "\f040";
  font-family: 'FontAwesome';
  color: #fff;
  position: absolute;
  top: 10px;
  left: 0;
  right: 0;
  text-align: center;
  margin: auto;
}
.avatar-upload .avatar-preview {
  width: 125px;
  height: 125px;
  position: relative;
  border-radius: 100%;
  box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.1);
}
.avatar-upload .avatar-preview > div {
  width: 100%;
  height: 100%;
  border-radius: 100%;
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
}
</style>
{/block}
{block name=$CONTENT_BLOCK}
  {form_open_multipart('','role="form" class="" name= "edit_user_profile"  id="edit_user_profile"')}
    <input type="hidden" id="passwordPolicyJson" value='{$passwordPolicyJson}'>
    <input type="hidden" value='{$age_limit}' name="age_limit" id="age_limit">
    <input type="hidden" value='{$u_name}' name="profile_user" id="profile_user">
    <input type="hidden" id="site_url" value="{$SITE_URL}">
    <input type="hidden" name="otp" id="otp" value="">
    <div class="row">
    <div class="col-lg-12 col-md-12">
      <div class="graph-profile-grid padding-zero">
         <!-- Profile/Promotion -->
         <div class="panel item">
            <div class="userprof-top profile_user">
               <div class="panel-body profile-section">
                  <div class="dashbord-profile">

                    <div class="avatar-upload">
                      <div class="avatar-edit" title="{lang('ideal_imagesize_profile')}">
                          <input type='file' id="imageUpload" 
                          accept=".png, .jpg, .jpeg" 
                          />
                          <label for="imageUpload"></label>
                      </div>
                      <div class="avatar-preview">
                          <div id="imagePreview" style="background-image: url({$SITE_URL}/uploads/images/profile_picture/{$profile_details["profile_photo"]});">
                          </div>
                      </div>
                    </div>

                     <div class="profile-avatar">
                        <h3 class="profile-name full_name" id="profile_full_name" title="{$full_name}">
                          {if strlen($full_name) > 14}
                           {$full_name|truncate:28}..
                          {else}
                          {$full_name}
                          {/if}
                        </h3>
                        <h5 class="profile-name2 user_name2">{$u_name}</h5>
                        <p class="profile-email" id="profile-email">{$profile_details['email']}</p>
                        <a  data-toggle="modal" data-backdrop="static" data-keyboard="false" data-target=".change_user_password" class="pswRest">{lang('change_password')}</a>

                         <a data-toggle="modal" data-backdrop="static" data-keyboard="false" data-target=".change_transaction_password" class="pswRest">{lang('change_transaction_password')}</a>

                        {* kyc status verified *}
                        {if $MODULE_STATUS['kyc_status'] == 'yes'}
                          <div class="kyc">
                            <div>{lang('kyc')}: 
                              {if $kyc_status=='yes' }<span style="color: #34A402;">{lang('verified')}</span>
                              {else} <span style="color: #CB2323;">{lang('not_verified')}</span>
                              {/if}
                            </div>
                            <button class="more_info"><a href="{BASE_URL}/user/kyc_upload" >{lang('more_info')}</a></button>
                          </div>
                        {/if}
                        {* end of kyc status verified *}

                     </div>
                  </div>
               </div>
               <!-- Start Promotion Tools html  -->

               <div class="Promotion-Tools">
                {* rank name *}
                {if $MODULE_STATUS['rank_status'] == "yes" && $rank_configuration['joinee_package'] != 1 }
                <h6 class="rankPro">{lang('rank')}: <span class="orange" style="color: {$rank_color}">{$profile_details['rank_name']}</span></h6>
                {/if}
                {* end of rank *}

                {if $product_status == "yes"}
                  <div class="pakage-renewal">
                     <div class="pakage">
                        <p class="fontH-small">{lang('membership_packge')}:</p>
                        {if empty($product_name)}
                          {assign var="product_name" value="NA"}
                        {/if}
                        <p class="fontH-medium"><span class="black_text">{$product_name}</span></p>

                        {* package button *}
                        {if $MODULE_STATUS['package_upgrade'] == "yes"}
                          {if !empty($upgradable_package_list)}
                          <div class="pakage_button m-t-xs">
                             <a href="{BASE_URL}/package_upgrade" class="profile-edit c-profile-edit renew_upgrade">{lang('upgrade')}</a>
                          </div>
                          {/if}
                        {/if}
                        {* end of package button *}
                     </div>

                     {if $MODULE_STATUS['subscription_status'] == 'yes'}
                     <div class="renewal">
                        <div class="expiry">
                          <p class="fontH-small">{lang('membership_expired_on')}</p>
                          <p class="fontH-medium">
                            {if $product_validity != "NA"}
                              <span class="black_text">
                                {date("d F Y - h:i:s A", strtotime($product_validity))}
                              </span>
                            {else}
                              <span class="black_text">
                                {lang('NA')}
                              </span>
                            {/if}
                          </p>
                        </div>
                        {*  *}
                        {if $MODULE_STATUS['subscription_status'] == "yes"}
                          {if $MODULE_STATUS['opencart_status'] == "yes"}
                            <div class="renewal_button m-t-xs">
                               <a href="{SITE_URL}/store/index.php?route=renewal/renewal{$store_id}" class="profile-edit c-profile-edit renew_upgrade" target="__blank">{lang('renew_membership')}</a>
                            </div>
                          {else}
                            <div class="renewal_button m-t-xs">
                               <a href="{BASE_URL}/user/upgrade_package_validity" class="profile-edit c-profile-edit renew_upgrade">{lang('renew_membership')}</a>
                            </div>
                          {/if}
                        {/if}
                     </div>
                     {/if}
                  </div>
                  {/if}
                  <!--Close pakage-renewal  -->

                  <div class="clearfix"></div>
                  <div class="Sponsor-Placement">
                    <div>
                      <p class="fontH-small">{lang('sponsor')}</p>
                      <p class="fontH-medium"><span class="black_text">{$profile_details['sponsor_name']}</span></p>
                    </div>
                    <div>
                      <p class="fontH-small">{lang('placement')}</p>
                      <p class="fontH-medium"><span class="black_text">{$profile_details['father_name']}</span></p>
                    </div>
                    {if $MLM_PLAN== "Binary"}
                    <div>
                      <p class="fontH-small">{lang('position')}</p>
                      <p class="fontH-medium">
                        <span class="black_text">
                            {if $profile_details["position"]=='L'} 
                                {lang('left')} 
                            {elseif $profile_details["position"]=='R'} 
                                {lang('right')} 
                            {else}
                                NA
                            {/if}
                        </span>
                      </p>
                    </div>
                    {/if}
                  </div>

                  <div class="clearfix"></div>

                  <div class="user-det">
                    <div class="pv">
                      
                       <div class="sponsor-details vertical_line">
                          <div class="sponsor-details-icon"><i class="fa fa-user" aria-hidden="true"></i></div>
                          <span class="extra_data_title">
                          {lang('personal_pv')}</span>
                          <div style="color: #333;" class="extra_data">{$profile_extra_data.personal_pv }
                          </div>
                       </div>
                       <div class="sponsor-details vertical_line">
                          <div class="sponsor-details-icon"><i class="fa fa-users" aria-hidden="true"></i></div>
                          <span class="extra_data_title">
                          {lang('group_pv')}
                          </span>
                          <div class="extra_data">{$profile_extra_data.group_pv}</div>
                       </div>
                       {if $MLM_PLAN== "Binary"}
                        {if isset($binary_tree_carry)}
                       <div class="sponsor-details vertical_line">
                          <div class="sponsor-details-icon"><i class="fa fa-long-arrow-left" aria-hidden="true"></i></div>
                          <span class="extra_data_title">
                          {lang('total_left_carry')}
                          </span>
                          <div class="extra_data">{$binary_tree_carry.total_left_carry}
                          </div>
                       </div>
                       <div class="sponsor-details vertical_line">
                          <div class="sponsor-details-icon"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></div>
                          <span class="extra_data_title">
                          {lang('total_right_carry')}
                          </span>
                          <div class="extra_data">{$binary_tree_carry.total_right_carry}
                          </div>
                       </div>
                       {/if}
                       {/if}
                    </div>
                 </div>


                  <div class="row mob- ">
                     <div class="panel padder-v item padding_top_zero padding_bottom_zero"><br>
                      <div class="pakage_button m-t-xs">&nbsp;&nbsp;&nbsp;
                                <a  href="{BASE_URL}/user/select_report/pv_report" class="profile-edit c-profile-edit renew_upgrade" >{lang('pv_history')}</a>
                      </div>
                     </div>

                  </div>
               </div>
               <!-- Close Promotion Tools html -->
            </div>
         </div>
         <!-- Profile/Promotion end -->

      </div>
   </div>
  </div> 
  <!-- Profile Section -->
  <div class="row">
    <div class="profile-form-grid">
      <div class="panel panel-default profile-form" id="personal_info_div">
        <div class="form-head">
          <h3>{lang('personal_details')}</h3>
          {if $kyc_status=='no' }<button id="edit_personal_info" type="button" class="btn BtnDefault"><i class="fa fa-pencil"  aria-hidden="true"></i></button>{/if}
        </div>
        
          <div class="form-group">
            <label class="{if search_array($dynamic_fields, 'field_name', 'first_name', 'required', "yes")}required{/if}" for="">{lang('first_name')}</label>
            {if $kyc_status=='yes' }
                <label class="form-control" disabled="disabled">{$profile_details["name"]}</label>
            {else}
            <input type="text" name="first_name" id="first_name" style="padding: 5px 12px;" value="{$profile_details["name"]}" class="form-control" {if search_array($dynamic_fields, 'field_name', 'first_name', 'required', "yes")}required{/if}  data-value="{$profile_details["name"]}">
            {/if}
          </div>
          <div class="form-group">
            <label class="{if search_array($dynamic_fields, 'field_name', 'last_name', 'required', "yes")}required{/if}">{lang('last_name')}</label>
            {if $kyc_status=='yes' }
                <label class="form-control" disabled="disabled">{$profile_details["user_detail_second_name"]}</label>
            {else}
            <input type="text" name="last_name" id="last_name" value="{$profile_details["user_detail_second_name"]}" class="form-control" {if search_array($dynamic_fields, 'field_name', 'last_name', 'required', "yes")}required{/if} data-value="{$profile_details["user_detail_second_name"]}">
            {/if}
          </div>
          <div class="form-group">
            <label class="{if search_array($dynamic_fields, 'field_name', 'gender', 'required', "yes")}required{/if}">{lang('gender')}</label>
             <select class="form-control" name="gender" id="gender" {if search_array($dynamic_fields, 'field_name', 'gender', 'required', "yes")}required{/if} data-value="{$profile_details["gender"]}">
                  <option value='M' {if $profile_details["gender"] == 'M'} selected {/if}>{lang('male')}</option>
                  <option value='F' {if $profile_details["gender"] == 'F'} selected {/if}>{lang('female')}</option>
              </select>
          </div>
          <div class="form-group">
            <label class="{if search_array($dynamic_fields, 'field_name', 'date_of_birth', 'required', "yes")}required{/if}">{lang('date_of_birth')}</label>
            {if $kyc_status=='yes' }
                <label class="form-control" disabled="disabled">{$profile_details["dob"]}</label>
            {else}
            <input type="date" name="dob" id="user_dob" data-value="{$profile_details["dob"]}" value="{$profile_details["dob"]}"  class="form-control" {if search_array($dynamic_fields, 'field_name', 'date_of_birth', 'required', "yes")}required{/if} >
            {/if}
          </div>   
          <div class="FormBtn">        
          <button type="button" id="update_personal_info" class="btn BtnDefault">{lang('update')}</button>
          <button type="button" id="cancel_personal_info" class="btn btn-default">{lang('cancel')}</button>
        </div> 
      </div>

      <!-- Form Container -->
      {* start contact info *}
      <div class="panel panel-default profile-form grid-culoum2" id="contact_info_div">
        <div class="form-head">
          <h3>{lang('contact_details')}</h3>
          {if $kyc_status=='no' }<button type="button" id="edit_contact_info" class="btn BtnDefault"><i class="fa fa-pencil" aria-hidden="true"></i></button>{/if}
        </div>
        <div class="grid-2">
          <div class="form-group">
            <label class="{if search_array($dynamic_fields, 'field_name', 'adress_line1', 'required', "yes")}required{/if}">{lang('adress_line1')}</label>
            {if $kyc_status=='yes' || 1==1}
            <label class="form-control" disabled="disabled">{$profile_details["address"]}</label>
            {else}
            <input type="text" class="form-control" value="{$profile_details["address"]}" name="address" id="address" {if search_array($dynamic_fields, 'field_name', 'adress_line1', 'required', "yes")}required{/if} data-value="{$profile_details["address"]}">
            {/if}
          </div>
          <div class="form-group">
            <label class="{if search_array($dynamic_fields, 'field_name', 'adress_line2', 'required', "yes")}required{/if}">{lang('adress_line2')}</label>
            {if $kyc_status=='yes' || 1==1}
            <label class="form-control" disabled="disabled">{$profile_details["user_detail_address2"]}</label>
            {else}
            <input type="text" name="address2" id="address2" value="{$profile_details["user_detail_address2"]}" class="form-control" {if search_array($dynamic_fields, 'field_name', 'adress_line2', 'required', "yes")}required{/if} data-value="{$profile_details["user_detail_address2"]}">
             {/if}
          </div>
          <div class="form-group">
            <label class="{if search_array($dynamic_fields, 'field_name', 'country', 'required', "yes")}required{/if}">{lang('country')}</label>
            {if $kyc_status=='yes' || 1==1}
                <label class="form-control" disabled="disabled">{$country_name}</label>
            {else}
            <select name="country" id="country" onChange="getAllStates(this.value, 'user');" class="form-control" {if search_array($dynamic_fields, 'field_name', 'country', 'required', "yes")}required{/if} data-value="{$user_country_id}">{$countries}</select>
            {/if}
          </div>
          <div class="form-group">
            <label class="{if search_array($dynamic_fields, 'field_name', 'state', 'required', "yes")}required{/if}">{lang('state')}</label>
            {if $kyc_status=='yes' }
                <label class="form-control" disabled="disabled">{$state_name}</label>
            {else}
            <span id="prof_state_div">
                <select name="state" id="state" class="form-control" {if search_array($dynamic_fields, 'field_name', 'state', 'required', "yes")}required{/if} data-value="{$user_state_id}">{$states}</select>
            </span>
            {/if}
          </div> 
          <div class="form-group">
                <label class="{if search_array($dynamic_fields, 'field_name', 'city', 'required', "yes")}required{/if}">{lang('city')}</label>
                <input type="text" name="city" id="city" value="{$profile_details["user_detail_city"]}" class="form-control" {if search_array($dynamic_fields, 'field_name', 'city', 'required', "yes")}required{/if} data-value="{$profile_details["user_detail_city"]}">
             </div>
            <div class="form-group">
                  <label class="{if search_array($dynamic_fields, 'field_name', 'pin', 'required', "yes")}required{/if}">{lang('zip_code')}</label>
                   <input type="text" name="pincode" id="pincode" value="{$profile_details["pincode"]}" class="form-control" {if search_array($dynamic_fields, 'field_name', 'pin', 'required', "yes")}required{/if} data-value="{$profile_details["pincode"]}">
            </div>
            <div class="form-group">
                <label class="{if search_array($dynamic_fields, 'field_name', 'email', 'required', "yes")}required{/if}">{lang('email')}</label>
                {if $kyc_status=='yes' || 1==1}
                <label class="form-control" disabled="disabled">{$profile_details["email"]}</label>
                {else}
                <input type="text" name="email" id="email" value="{$profile_details["email"]}" class="form-control" {if search_array($dynamic_fields, 'field_name', 'email', 'required', "yes")}required{/if} data-value="{$profile_details["email"]}">
                {/if}
            </div>
            <div class="form-group">
                <label class="{if search_array($dynamic_fields, 'field_name', 'mobile', 'required', "yes")}required{/if}">{lang('mob_no_10_digit')}</label>
                <input type="hidden" name="mobile_code" id="mobile_code" value="{$mobile_code}" readonly data-value="{$mobile_code}">
                <div class="input-group" >
                    <span class="input-group-addon"><span id="mcode">{$mobile_code}</span></span>
                    <input type="text" class="form-control" name="mobile" id="mobile" value="{$profile_details["mobile"]}" {if search_array($dynamic_fields, 'field_name', 'mobile', 'required', "yes")}required{/if} data-value="{$profile_details["mobile"]}">
                </div>
            </div> 
             <div class="form-group">
                <label class="{if search_array($dynamic_fields, 'field_name', 'land_line', 'required', "yes")}required{/if}">{lang('land_line_no')}</label>
                <input type="text" name="land_line" id="land_line" value="{$profile_details["land"]}" class="form-control" {if search_array($dynamic_fields, 'field_name', 'land_line', 'required', "yes")}required{/if}  data-value="{$profile_details["land"]}">
            </div> 
        </div>
          <div class="FormBtn">
          <button type="button" class="btn BtnDefault" id="update_contact_info">{lang('update')}</button>
          <button type="button" class="btn btn-default" id="cancel_contact_info">{lang('cancel')}</button>
        </div> 
      </div>
      {* END OF CONTACT INFO *}


      <!-- Form Container -->
      {* start bank info *}
      {if $bank_info_status == 'yes'}
      <div class="panel panel-default profile-form" id="bank_info_div">
        <div class="form-head">
          <h3>{lang('bank_details')}</h3>
          {if $kyc_status=='no' }<button type="button" class="btn BtnDefault" id="edit_bank_info"><i class="fa fa-pencil" aria-hidden="true"></i></button>{/if}
        </div>
        <form autocomplete="off">
                  <div class="form-group">
                        <label>{lang('bank_name')}</label>
                        <input type="text" name="bank_name" id="bank_name" value="{$profile_details["nbank"]}" class="form-control" data-value="{$profile_details["nbank"]}">
                    </div>
                    <div class="form-group">
                        <label>{lang('branch_name')}</label>
                        <input type="text" name="branch_name" id="branch_name" value="{$profile_details["nbranch"]}" class="form-control" data-value="{$profile_details["nbranch"]}">
                    </div>
                    <div class="form-group">
                        <label>{lang('account_holder')}</label>
                        <input type="text" name="account_holder" id="account_holder" value="{$profile_details["user_detail_nacct_holder"]}" class="form-control" data-value="{$profile_details["user_detail_nacct_holder"]}">
                    </div>
                    <div class="form-group">
                        <label>{lang('account_no')}</label>
                        <input type="text" name="account_no" id="account_no" value="{$profile_details["acnumber"]}" class="form-control" data-value="{$profile_details["acnumber"]}">
                    </div>
                    <div class="form-group">
                        <label>{lang('ifsc')}</label>
                        <input type="text" name="ifsc" id="ifsc" value="{$profile_details["ifsc"]}" class="form-control" data-value="{$profile_details["ifsc"]}">
                    </div>
                    <div class="form-group">
                        <label>{lang('pan')}</label>
                       <input type="text" name="pan" id="pan" value="{$profile_details["pan"]}" class="form-control" data-value="{$profile_details["pan"]}">
                    </div>  
          <div class="FormBtn">        
          <button type="button" class="btn BtnDefault" id="update_bank_info">{lang('update')}</button>
          <button type="button" class="btn btn-default" id="cancel_bank_info">{lang('cancel')}</button>
          </div> 
        </form>
      </div>
      {/if}
      <!-- Form Container -->
      {* payment method *}
      {if count($payment_gateway) > 0}
      <div class="panel panel-default profile-form" id="payment_details_div">
        <div class="form-head">
          <h3>{lang('payment_details')}</h3>
          <button type="button" class="btn BtnDefault" id="edit_payment_details"><i class="fa fa-pencil" aria-hidden="true"></i></button>
        </div>
        <form autocomplete="off">
          {assign var="gateway_addr" value=""}
          {assign var="gateway_id" value=""}
          {foreach from=$payment_gateway item=v}
            <div class="form-group">
              <label>
                {if $v.gateway_name == "Paypal"}
                  {lang('paypal_account')}
                    {$gateway_addr = $profile_details["paypal_account"]}
                    {$gateway_id = "paypal_account"}
                {/if}
                {if $v.gateway_name == "Bitcoin"}
                    {lang('blocktrail')}
                    {$gateway_addr = $profile_details["blocktrail_account"]}
                    {$gateway_id = "blocktrail_account"}
                {/if}
                {if $v.gateway_name == "Blockchain"}
                    {lang('blockchain_wallet_address')}
                    {$gateway_addr = $profile_details["blockchain_account"]}
                    {$gateway_id = "blockchain_account"}
                {/if}
                {if $v.gateway_name == "Bitgo"}
                    {lang('bitgo')}
                    {$gateway_addr = $profile_details["bitgo_account"]}
                    {$gateway_id = "bitgo_account"}
                {/if}
              </label>
              <input type="text" value="{$gateway_addr}" class="form-control" name="{$gateway_id}" id="{$gateway_id}" data-value="{$gateway_addr}">
              </div>
            {/foreach}  
           
              <legend><span class="fieldset-legend">{lang('payment_method')}</span></legend>
              <div class="form-group">
                   <select class="form-control" name="payment_method" id="payment_method" data-value="{$profile_details['payout_type']}">
                            {* <option value="bank">{lang('bank')}</option> *}
                      {if count($gateway_list) >0}
                          {foreach from=$gateway_list item="v"}
                              <option value="{$v.gateway_name}" {if $profile_details['payout_type'] == $v.gateway_name}selected="selected"{/if}>{if $v.gateway_name=="Bitcoin"}{lang('blocktrail')}{else}{$v.gateway_name}{/if}</option>
                          {/foreach}
                      {/if}
                  </select>
            </div>
          <div class="FormBtn">        
          <button type="button" id="update_payment_details" class="btn BtnDefault">{lang('update')}</button>
          <button type="button" id="cancel_payment_details" class="btn btn-default">{lang('cancel')}</button>
        </div> 
        </form>
      </div>
      {/if}

      {if $MODULE_STATUS['multy_currency_status']=='yes' || $MODULE_STATUS['lang_status'] == 'yes' || $MODULE_STATUS['mlm_plan'] == 'Binary' || $MODULE_STATUS['google_auth_status']=='yes'}
      <!-- Form Container -->
      <div class="panel panel-default profile-form" id="settings_details_div">
        <div class="form-head">
          <h3>{lang('settings')}</h3>
          <button type="button" id="edit_settings_details" class="btn BtnDefault"><i class="fa fa-pencil" aria-hidden="true"></i></button>
        </div>
        <form autocomplete="off">
          {if $MODULE_STATUS['lang_status'] == 'yes'}
          <div class="form-group">
              <label>{lang('language')}</label>
              <input type="hidden" id="prev_language" name="prev_language" value="{$profile_details['lang_id']}" data-value="{$profile_details['lang_id']}">
              <select class="form-control" name="language" id="language" data-value="{$profile_details['lang_id']}">
                  {foreach from=$LANG_ARR item=v}
                      <option value="{$v.lang_id}" {if $v.lang_id == $profile_details['lang_id']} selected {/if}>{$v.lang_name_in_english|ucfirst}</option>
                  {/foreach}
              </select>
          </div>
          {/if}
          {if $MODULE_STATUS['mlm_plan'] == 'Binary'}
          <div class="form-group">
            <label for="">{lang('binary_leg_settings')}</label>
            <select class="form-control" id="binary_leg" name="binary_leg" data-value="{$get_leg_type}">
                {if $get_leg_settings =='any'}
                    <option value="any" {if $get_leg_type == 'any'} selected="" {/if} >{lang('none')}</option>
                {/if}
                {if $get_leg_settings =='any' || $get_leg_settings =='left'}
                    <option value="left" {if $get_leg_type == 'left'} selected="" {/if}>{lang('left_leg')}</option>
                {/if}
                {if $get_leg_settings =='any' || $get_leg_settings =='right'}
                    <option value="right" {if $get_leg_type == 'right'} selected="" {/if}>{lang('right_leg')}</option>
                {/if}
                {if $get_leg_settings =='any'}
                    <option value="weak_leg" {if $get_leg_type == 'weak_leg'} selected="" {/if}>{lang('weak_leg')}</option>
                {/if}
            </select>
          </div>
          {/if}
          {if $MODULE_STATUS['multy_currency_status']=='yes'}
          <div class="form-group">
              <label>{lang('currency')}</label>
              <input type="hidden" id="prev_currency" name="prev_currency" value="{$profile_details['default_currency']}">
              <select class="form-control" name="currency" id="currency" data-value="{$profile_details['default_currency']}">
                  {foreach from=$CURRENCY_ARR item=v}
                      <option value="{$v.id}" {if $v.id == $profile_details['default_currency']} selected {/if}>{$v.symbol_left}{$v.title}{$v.symbol_right}</option>
                  {/foreach}
              </select>
          </div>
          {/if}
          {if $MODULE_STATUS['google_auth_status']=='yes'}
          <div class="form-group">
            <label>{lang('google_auth_status')}</label>
            <select class="form-control" name="google_auth_status" id="google_auth_status" data-vale="{$profile_details['google_auth_status']}">
              <option {if $profile_details['google_auth_status'] == 'yes'} selected {/if} value="yes">{lang('enabled')}</option>
              <option {if $profile_details['google_auth_status'] == 'no'} selected {/if} value="no">{lang('disabled')}</option>
            </select>
          </div> 
          {/if}  
          <div class="FormBtn">        
          <button type="button" id="update_settings_details" class="btn BtnDefault">{lang('update')}</button>
          <button type="button" id="cancel_settings_details" class="btn btn-default">{lang('cancel')}</button>
        </div> 
        </form>
      </div><!-- Form Container -->  
      {/if}

      {* custom feild *}

       {if count($custom_details) > 0}
       <div class="panel panel-default profile-form grid-culoum3" id="custom_details_div">
        <div class="form-head">
          <h3>{lang('more_details')}</h3>
          <button type="button" class="btn BtnDefault" id="edit_custom_details"><i class="fa fa-pencil" aria-hidden="true"></i></button>

        </div>
        {foreach from=$custom_details item=v}
            <div class="form-group">
              <label {if $v.required =="yes"} class="required" {/if}>{$v.custom_name}</label>
              <input type="text" value="{$v.field_value}" class="form-control custom_field {if $v.required =="yes"} required {/if}" maxlength="50" name="{$v.field_name}" id="{$v.field_name}">
            </div>
        {/foreach}
        <div class="FormBtn">        
          <button type="button" class="btn BtnDefault" id="update_custom_details">{lang('update')}</button>
          <button type="button" class="btn btn-default" id="cancel_custom_details">{lang('cancel')}</button>
        </div> 
      </div>
      {/if}
        
      {* end of custom feild *}

    </div>
  </div>
    
    
    <div id="alert_div" style="display: none;">
        <div id="alert_box_err" class="alert alert-dismissable">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        </div>
    </div>
    {form_close()}
{include file="user/profile/password_change_modal.tpl"}
                      
{/block}

{block name=script}
{$smarty.block.parent}
<script>
  function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#imagePreview').css('background-image', 'url('+e.target.result +')');
            $('#imagePreview').hide();
            $('#imagePreview').fadeIn(650);
        }
        reader.readAsDataURL(input.files[0]);
    }
  }
  
  $("#imageUpload").change(function() {
      var file = this;
      data = new FormData();
      data.append('file', this.files[0]);
      data.append('inf_token', $('input[name="inf_token"]').val());
      data.append('user_name', $('input[name="user_name"]').val());
      $.ajax({
        method: 'POST', 
        url: 'user_profile_upload',
        cache:false,
        contentType: false,
        processData: false,
        data: data,
        success: function(data) {
          data = JSON.parse(data);
          readURL(file);
          showSuccessAlert(data.message, 'top-right')
          loadProfile();
        }, 
        error: function(jqXHR, textStatus, errorThrown) {
          error = JSON.parse(jqXHR.responseText);
          if (error.message) {
            showErrorAlert(error.message, 'top-right');
          }
        }
        
      });
  });

</script>
  
{/block}
