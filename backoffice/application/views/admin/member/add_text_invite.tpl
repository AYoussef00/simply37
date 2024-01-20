{extends file=$BASE_TEMPLATE}

{block name=$CONTENT_BLOCK}

<div id="span_js_messages" style="display: none;"> 
    <span id="row_msg">{lang('rows')}</span>
    <span id="show_msg">{lang('shows')}</span>
    <span id="validate_msg1">{lang('you_must_enter_subject')}</span>
    <span id="validate_msg2">{lang('you_must_enter_message')}</span>

</div>

    <div class="button_back">                          
        <a href="{BASE_URL}/admin/member/promotion_tools" class="btn m-b-xs btn-sm btn-info btn-addon"><i class="fa fa-backward"></i>{lang('back')}</a>
    </div>    

        <div class="panel panel-default">
            <div class="tab">
                <div class="content">
                {form_open('','role="form" class="smart-wizard" method="post"  name="invite_text_form" id="invite_text_form"')}
                    {include file="layout/error_box.tpl"}
                    <input type="hidden" id="path_root" name="path_root" value="{$PATH_TO_ROOT_DOMAIN}admin/">
                    <div class="form-group"> 
                        <label class="control-label required">{lang('subject')}</label>
                        <input class="form-control"  type="text"  name ="subject" id ="subject" value=''  autocomplete="Off" >
                        {form_error('subject')}
                    </div>

                    <div class="form-group">
                        <label class="control-label required" for="mail_content">{lang('message')}</label>
                            <textarea id="mail_content"  name="mail_content"   class="ckeditor form-control"    rows='10' >                              
                            </textarea>{form_error('mail_content')}
                    </div>
                        
                  {*  <div class="form-group">
                        <label class="col-sm-2 control-label"></label>
                    </div>*}

                    <div class="form-group">
                        <button class="btn m-b-xs btn-sm btn-primary btn-addon" type="submit"  value="Update" name="update" id="update" ><i class="fa fa-plus"></i>{lang('add_item')}</button>                                                                                       
                    </div>
                {form_close()}
                </div>
            </div>
        </div>
{/block}
                
{block name=script}
  {$smarty.block.parent}
<script src="{$PUBLIC_URL}/plugins/ckeditor/ckeditor.js"></script>
<script src="{$PUBLIC_URL}/plugins/ckeditor/adapters/jquery.js"></script>
<script src="{$PUBLIC_URL}/javascript/validate_invite_config.js"></script>
{/block}

{block name=link}
  {$smarty.block.parent}
<link href="{$PUBLIC_URL}/plugins/ckeditor/contents.css">
{/block}