{extends file=$BASE_TEMPLATE}

{block name=$CONTENT_BLOCK}
    <div class="panel panel-default">
        <div class="panel-body">
             {form_open('admin/stair_step_report_view','role="form" class="" method="get"    name="repurchase_report" id="repurchase_report" target="_blank"')}
            <div class="col-sm-2 padding_both">
                <div class="form-group">
                    <label>{lang('username')}</label>
                    <input class="form-control user_autolist" type="text" id="user_name" name="user_name" autocomplete="Off">
                </div>
            </div>
            <!--<div class="col-sm-3 padding_both_small">
                <div class="form-group">
                    <label> {lang('from_date')}</label>
                    <input  autocomplete="off"  class="form-control date-picker" type="text"  size="70" maxlength="10" name='week_date1' id='week_date1'>
                </div>{form_error('week_date1')}
            </div>
            <div class="col-sm-3 padding_both_small">
                <div class="form-group">
                    <label> {lang('to_date')}</label>
                    <input  autocomplete="off"  class="form-control date-picker" type="text"  size="70" maxlength="10" name='week_date2' id='week_date2'>
                </div>{form_error('week_date2')}
            </div>-->
            <div class="col-sm-2 padding_both_small">
                <div class="form-group">
                    <label class="" for="daterange">{lang('daterange')}</label>
                    <select name="daterange" id="daterange" class="form-control">
                        <option value="all">{lang('overall')}</option>
                        <option value="today">{lang('today')}</option>
                        <option value="month">{lang('this_month')}</option>
                        <option value="year">{lang('this_year')}</option>
                        <option value="custom">{lang('custom')}</option>
                    </select>
                </div>
            </div>
            <div class="col-sm-2 padding_both_small">
                <div class="form-group">
                    <label>{lang('from_date')}</label>
                    <input autocomplete="off" class="form-control date-picker custom-date" name="from_date" id="from_date" type="text" value="">
                </div>
            </div>
            <div class="col-sm-2 padding_both_small">
                <div class="form-group">
                    <label>{lang('to_date')}</label>
                    <input autocomplete="off" class="form-control date-picker custom-date" name="to_date" id="to_date" type="text" value="">
                </div>
            </div>
            <div class="col-sm-3 padding_both_small">
                <div class="form-group credit_debit_button">
                    <button class="btn btn-primary" name="submit" id="submit" type="submit" value="{lang('submit')}"> {lang('submit')} </button>
                </div>
            </div>
                {form_close()}
        </div>
    </div>
{/block}