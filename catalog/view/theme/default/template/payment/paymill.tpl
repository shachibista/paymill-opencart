<?php
/**
* paymill
*
* @category   PayIntelligent
* @copyright  Copyright (c) 2011 PayIntelligent GmbH (http://payintelligent.de)
*/
?>
<?php
    echo '<script type="text/javascript">';
    echo 'var PAYMILL_PUBLIC_KEY  = "' . $paymill_publickey . '"; '
       . 'var PAYMILL_CURRENCY  = "' . $paymill_currency . '"; '
       . 'var PAYMILL_AMOUNT  = ' . $paymill_amount * 100 . '; '
       . 'var PAYMILL_PAYMENT  = "' . $paymill_activepayment . '"; '
       . 'var PAYMILL_DEBUG  = "' . $paymill_debugging . '"; '
       . 'var PAYMILL_IMAGE  = "' . $paymill_image_folder . '"; '
       . 'var PAYMILL_TRANSLATION = ' . json_encode($paymill_javascript_error) . '; ';
    echo '</script>';
?>
<script type="text/javascript" src="https://bridge.paymill.com/"></script>
<script type="text/javascript" src="<?php echo $paymill_js; ?>"></script>
<link rel="stylesheet" type="text/css" href="<?php echo $paymill_css; ?>" />

<div class="right">
    <form id='paymill_form' action="<?php echo $paymill_form_action; ?>" method="POST">
        <div id="paymill_errors" style="display: none"></div>
        <div class="debit">
            <?php if($paymill_activepayment === 'paymillcreditcard'){ ?>
            <p class="none">
                <label><?php echo $paymill_cardholder;?></label>
                <input id="paymill_card_holder" type="text" size="20" class="paymill_text" value="<?php echo isset($paymill_prefilled['card_holder'])?$paymill_prefilled['card_holder']:$paymill_fullname;?>"/>
            </p>
            <p class="none" style="margin-bottom:7px;">
                <label><?php echo $paymill_cardnumber;?></label>
                <span id="paymill_card_icon" style="float:right;">
                    <input id="paymill_card_number" type="text" size="20"  value="<?php echo isset($paymill_prefilled['last4'])? '**********'.$paymill_prefilled['last4']:'';?>"/>
                </span>
                <span style="display:block;clear:both;"></span>
            </p>
            <p class="none">
                <label><?php echo $paymill_cvc;?></label>
                <input id="paymill_card_cvc" type="text" size="4" class="paymill_text" value="<?php echo isset($paymill_prefilled['id'])?'***':'' ?>"/>
            </p>
            <p class="none">
                <label><?php echo $paymill_birthday;?></label>
                <select id="paymill_card_expiry_year" style="width: 65px; display: inline-block;" class="paymill_text">
                <?php
                $prefilled = isset($paymill_prefilled['expire_year'])?$paymill_prefilled['expire_year']:null;
                foreach($paymill_form_year as $year){
                    if(!is_null($prefilled) && $prefilled == $year){
                        echo "<option value=$year selected>$year</option>";
                    }else{
                        echo "<option value=$year>$year</option>";
                    }
                }
                ?>
                </select>
                <select id="paymill_card_expiry_month" style="width: 50px; display: inline-block;" class="paymill_text">
                <?php
                $prefilled = isset($paymill_prefilled['expire_month'])?$paymill_prefilled['expire_month']:null;
                foreach($paymill_form_month as $month){
                    if(!is_null($prefilled) && $prefilled == $month){
                        echo "<option value=$month selected>$month</option>";
                    }else{
                        echo "<option value=$month>$month</option>";
                    }
                }
                ?>
                </select>
            </p>
            <p class="description"><?php echo $paymill_description;?></p>
                <?php if($paymill_label){ ?>
                <p>
                <div class="paymill_powered">
                    <div class="paymill_credits">
                        <?php echo $paymill_paymilllabel_cc;?> powered by <a href="http://www.paymill.de" target="_blank">PAYMILL</a>
                    </div>
                </div>
                </p>
                <?php } ?>
            <?php }elseif($paymill_activepayment === 'paymilldirectdebit'){ ?>
            <p class="none">
                <label><?php echo $paymill_accountholder;?></label>
                <input id="paymill_accountholder" type="text" size="20" class="paymill_text" value="<?php echo isset($paymill_prefilled['holder'])?$paymill_prefilled['holder']:$paymill_fullname; ?>"/>
            </p>
            <p class="none">
                <label><?php echo $paymill_accountnumber;?></label>
                <input id="paymill_accountnumber" type="text" size="20" class="paymill_text" value="<?php echo isset($paymill_prefilled['account'])?$paymill_prefilled['account']:''; ?>" />
            </p>
            <p class="none">
                <label><?php echo $paymill_banknumber;?></label>
                <input id="paymill_banknumber" type="text" size="20" class="paymill_text" value="<?php echo isset($paymill_prefilled['code'])?$paymill_prefilled['code']:''; ?>" />
            </p>
            <p class="description"><?php echo $paymill_description;?></p>
                <?php if($paymill_label){ ?>
                <p>
                <div class="paymill_powered">
                    <div class="paymill_credits">
                        <?php echo $paymill_paymilllabel_elv;?> powered by <a href="http://www.paymill.de" target="_blank">PAYMILL</a>
                    </div>
                </div>
                </p>
                <?php } ?>
            <?php } ?>
        </div>
        <div class="buttons">
            <input type="submit" class="button" id="paymill_submit" value="<?php echo $button_confirm; ?>">
        </div>
    </form>
</div>