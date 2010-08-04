{literal}    
    <script type="text/javascript"> 
        
        $(document).ready(function() {
            $('#help').hide();


        $('#edit_in_day').datepicker({
          onSelect: function(dateText, instance) {
            $('#edit_out_day').datepicker( "option", "minDate", $('#edit_in_day').datepicker("getDate") );
          }
         });
        $('#edit_out_day').datepicker({
          onSelect: function(dateText, instance) {
            $('#edit_in_day').datepicker( "option", "maxDate", $('#edit_out_day').datepicker("getDate") );
          }
         });

            $('#ts_ext_form_add_edit_record').ajaxForm(function() { 
                
                $edit_in_time = $('#edit_in_day').val()+$('#edit_in_time').val();
                $edit_out_time = $('#edit_out_day').val()+$('#edit_out_time').val();
                $delete = $('#erase').is(':checked');
                
                if (!$delete && $edit_in_time == $edit_out_time) {
                    alert("{/literal}{$kga.lang.timediff_warn}{literal}");
                } else {
                    floaterClose();
                    ts_ext_reload();
                }
                
            });
            {/literal}{if $id}{literal}
            {/literal}{else}{literal}
            $("#add_edit_zef_pct_ID").selectOptions(""+selected_pct+"");
            $("#add_edit_zef_evt_ID").selectOptions(""+selected_evt+"");
            {/literal}{/if}{literal}

            ts_timeToDuration();
        }); 
        
    </script>
{/literal}


<div id="floater_innerwrap">

    <div id="floater_handle">
        <span id="floater_title">{if $id}{$kga.lang.edit}{else}{$kga.lang.add}{/if}</span>
        <div class="right">
            <a href="#" class="close" onClick="floaterClose();">{$kga.lang.close}</a>
            <a href="#" class="help" onClick="$(this).blur(); $('#help').slideToggle();">{$kga.lang.help}</a>
            <a href="#" class="options down" onClick="floaterOptions(); $(this).blur();">{$kga.lang.options}</a>
        </div>  
    </div>

    <div id="help">
        <div class="content">        
            {$kga.lang.dateAndTimeHelp}
        </div>
    </div>


    <div id="floater_content"><div id="floater_dimensions">

        <form id="ts_ext_form_add_edit_record" action="../extensions/ki_timesheets/processor.php" method="post"> 
            <fieldset>
                
                <ul>
                
                   <li>
                       <label for="pct_ID">{$kga.lang.pct}:</label>
                       <select size = "5" name="pct_ID" id="add_edit_zef_pct_ID" class="formfield" style="width:400px" tabindex="1" onChange="ts_ext_reload_evt($('#add_edit_zef_pct_ID').val());" >
                           {html_options values=$sel_pct_IDs output=$sel_pct_names selected=$pres_pct}
                       </select>
                       <br/>
                       <input type="input" style="margin-left:115px;width:395px;margin-top:3px" tabindex="2" size="10" maxlength="10" name="filter" id="filter" onkeyup="filter_selects('add_edit_zef_pct_ID', this.value); ts_add_edit_validate();"/>
                   </li>
                   


                   <li>
                       <label for="evt_ID">{$kga.lang.evt}:</label>
                       <select size = "5" name="evt_ID" id="add_edit_zef_evt_ID" class="formfield" style="width:400px" tabindex="3" onChange="getBestRate();ts_add_edit_validate();" >
                           {html_options values=$sel_evt_IDs output=$sel_evt_names selected=$pres_evt}
                       </select>
                       <br/>
                      <input type="input" style="margin-left:115px;width:395px;margin-top:3px" tabindex="4" size="10" maxlength="10" name="filter" id="filter" onkeyup="filter_selects('add_edit_zef_evt_ID', this.value); ts_add_edit_validate();" />
                   </li>
                
{* -------------------------------------------------------------------- *} 

                <li>
                     <label for="edit_in_day">{$kga.lang.day}:</label>
                     <input id='edit_in_day' type='text' name='edit_in_day' value='{$edit_in_day}' maxlength='10' size='10' tabindex='5' onChange="ts_timeToDuration();" {if $kga.conf.autoselection}onClick="this.select();"{/if} />
                     -
                     <input id='edit_out_day' type='text' name='edit_out_day' value='{$edit_out_day}' maxlength='10' size='10' tabindex='6' onChange="ts_timeToDuration();" {if $kga.conf.autoselection}onClick="this.select();"{/if} />
                </li>


              
                   <li>
                       <label for="time">{$kga.lang.timelabel}:</label>
                        <input id='edit_in_time' type='text' name='edit_in_time' value='{$edit_in_time}' maxlength='8'  size='8'  tabindex='7' onChange="ts_timeToDuration();" {if $kga.conf.autoselection}onClick="this.select();"{/if} />
                        -
                        <input id='edit_out_time' type='text' name='edit_out_time' value='{$edit_out_time}' maxlength='8'  size='8'  tabindex='8' onChange="ts_timeToDuration();" {if $kga.conf.autoselection}onClick="this.select();"{/if} />
                        <a href="#" onClick="pasteNow(); ts_timeToDuration(); $(this).blur(); return false;">{$kga.lang.now}</a>
                   </li>
                   <li>
                       <label for="duration">{$kga.lang.durationlabel}:</label>
                        <input id='edit_duration' type='text' name='edit_duration' value='' onChange="ts_durationToTime();" maxlength='8'  size='8'  tabindex='9' {if $kga.conf.autoselection}onClick="this.select();"{/if} />
                   </li>
                   
{* -------------------------------------------------------------------- *}       
        
                   <li class="extended">
                        <label for="rate">{$kga.lang.rate}:</label>
                        <input id='rate' type='text' name='rate' value='{$rate}' maxlength='50' size='20' tabindex='10' {if $kga.conf.autoselection}onClick="this.select();"{/if} />
                   </li>

                   <li class="extended">
                        <label for="zlocation">{$kga.lang.zlocation}:</label>
                        <input id='zlocation' type='text' name='zlocation' value='{$zlocation}' maxlength='50' size='20' tabindex='11' {if $kga.conf.autoselection}onClick="this.select();"{/if} />
                   </li>

				{if $kga.show_TrackingNr}
                   <li class="extended">
                        <label for="trackingnr">{$kga.lang.trackingnr}:</label>
                        <input id='trackingnr' type='text' name='trackingnr' value='{$trackingnr}' maxlength='20' size='20' tabindex='12' {if $kga.conf.autoselection}onClick="this.select();"{/if} />
                   </li>
				{/if}
                           
                   <li>
                        <label for="comment">{$kga.lang.comment}:</label>
                        <textarea id='comment' style="width:395px" class='comment' name='comment' cols='40' rows='5' tabindex='13'>{$comment}</textarea>
                   </li>
                   
                   <li>
                       <label for="comment_type">{$kga.lang.comment_type}:</label>
                       <select id="comment_type" class="formfield" name="comment_type" tabindex="14" >
                           {html_options values=$comment_values output=$comment_types selected=$comment_active}
                       </select>
                   </li>
                   
                    <li class="extended">
                        <label for="erase">{$kga.lang.erase}:</label>
                        <input type='checkbox' id='erase' name='erase' tabindex='15'/>
                   </li>

                    <li class="extended">
                        <label for="cleared">{$kga.lang.cleared}:</label>
                        <input type='checkbox' id='cleared' name='cleared' {if $cleared} checked="checked" {/if} tabindex='16'/>
                   </li>
        
                </ul>

{* -------------------------------------------------------------------- *} 

                <input name="id" type="hidden" value="{$id}" />
                <input name="axAction" type="hidden" value="add_edit_record" />

                <div id="formbuttons">
                    <input class='btn_norm' type='button' value='{$kga.lang.cancel}' onClick='floaterClose(); return false;' />
                    <input class='btn_ok' type='submit' value='{$kga.lang.submit}' />
                </div>

{* -------------------------------------------------------------------- *} 

            </fieldset>
        </form>

    </div></div>
</div>
