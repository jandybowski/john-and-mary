
<style>
    /*  Remodal styles  */
/* ==========================================================================
   Remodal's necessary styles
   ========================================================================== */

/* Hide scroll bar */

html.remodal-is-locked {
  overflow: hidden;

  -ms-touch-action: none;
  touch-action: none;
}



/* Necessary styles of the overlay */

.remodal-overlay {
  position: fixed;
  z-index: 9999;
  top: -5000px;
  right: -5000px;
  bottom: -5000px;
  left: -5000px;

  display: none;
}

/* Necessary styles of the wrapper */

.remodal-wrapper {
  position: fixed;
  z-index: 10000;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;

  display: none;
  overflow: auto;

  text-align: center;

  -webkit-overflow-scrolling: touch;
}

.remodal-wrapper:after {
  display: inline-block;

  height: 100%;
  margin-left: -0.05em;

  content: "";
}

/* Fix iPad, iPhone glitches */

.remodal-overlay,
.remodal-wrapper {
  -webkit-backface-visibility: hidden;
  backface-visibility: hidden;
}

/* Necessary styles of the modal dialog */

#instockRemodal {
  position: relative;
  text-align:center;
  outline: none;

  -webkit-text-size-adjust: 100%;
  -moz-text-size-adjust: 100%;
  -ms-text-size-adjust: 100%;
  text-size-adjust: 100%;
}

.remodal-is-initialized {
  /* Disable Anti-FOUC */
  display: inline-block;
}

/*
 *  Remodal - v1.0.6
 *  Responsive, lightweight, fast, synchronized with CSS animations, fully customizable modal window plugin with declarative configuration and hash tracking.
 *  http://vodkabears.github.io/remodal/
 *
 *  Made by Ilya Makarov
 *  Under MIT License
 */

/* ==========================================================================
   Remodal's default mobile first theme
   ========================================================================== */

/* Default theme styles for the background */

.remodal-bg.remodal-is-opening,
.remodal-bg.remodal-is-opened {
  -webkit-filter: blur(3px);
  filter: blur(3px);
}

/* Default theme styles of the overlay */

.remodal-overlay {
  background: rgba(43, 46, 56, 0.9);
}

.remodal-overlay.remodal-is-opening,
.remodal-overlay.remodal-is-closing {
  -webkit-animation-duration: 0.3s;
  animation-duration: 0.3s;
  -webkit-animation-fill-mode: forwards;
  animation-fill-mode: forwards;
}

.remodal-overlay.remodal-is-opening {
  -webkit-animation-name: remodal-overlay-opening-keyframes;
  animation-name: remodal-overlay-opening-keyframes;
}

.remodal-overlay.remodal-is-closing {
  -webkit-animation-name: remodal-overlay-closing-keyframes;
  animation-name: remodal-overlay-closing-keyframes;
}

/* Default theme styles of the wrapper */

.remodal-wrapper {
  padding: 10px 10px 0;
}

/* Default theme styles of the modal dialog */

#instockRemodal {
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  width: 100%;
  margin-bottom: 10px;
  padding: 35px;

  -webkit-transform: translate3d(0, 0, 0);
  transform: translate3d(0, 0, 0);

  color: #2b2e38;
  background: #fff;
}

#instockRemodal.remodal-is-opening,
#instockRemodal.remodal-is-closing {
  -webkit-animation-duration: 0.3s;
  animation-duration: 0.3s;
  -webkit-animation-fill-mode: forwards;
  animation-fill-mode: forwards;
}

#instockRemodal.remodal-is-opening {
  -webkit-animation-name: remodal-opening-keyframes;
  animation-name: remodal-opening-keyframes;
}

#instockRemodal.remodal-is-closing {
  -webkit-animation-name: remodal-closing-keyframes;
  animation-name: remodal-closing-keyframes;
}

/* Vertical align of the modal dialog */

#instockRemodal,
.remodal-wrapper:after {
  vertical-align: middle;
}

/* Close button */

.remodal-close.reminder-close {
  position: absolute;
  top: 0;
  right: 0;

  display: block;
  overflow: visible;

  width: 35px;
  height: 35px;
  margin: 0;
  padding: 0;

  cursor: pointer;
  -webkit-transition: color 0.2s;
  transition: color 0.2s;
  text-decoration: none;

  color: #95979c;
  border: 0;
  outline: 0;
  background: transparent;
}

.remodal-close:hover,
.remodal-close:focus {
  color: #2b2e38;
}
.remodal-close.reminder-close:after {
    display: none;
}
.remodal-close.reminder-close:before {
  font-family: Arial, "Helvetica CY", "Nimbus Sans L", sans-serif !important;
  font-size: 25px;
  line-height: 35px;

  position: absolute;
  top: 0;
  left: 0;

  display: block;

  width: 35px;

  content: "\00d7";
  text-align: center;
}

/* Dialog buttons */

.remodal-confirm,
.remodal-cancel {
  font: inherit;

  display: inline-block;
  overflow: visible;

  min-width: 110px;
  margin: 0;
  padding: 12px 0;

  cursor: pointer;
  -webkit-transition: background 0.2s;
  transition: background 0.2s;
  text-align: center;
  vertical-align: middle;
  text-decoration: none;

  border: 0;
  outline: 0;
}

.remodal-confirm {
  color: #fff;
  background: #81c784;
}

.remodal-confirm:hover,
.remodal-confirm:focus {
  background: #66bb6a;
}

.remodal-cancel {
  color: #fff;
  background: #e57373;
}

.remodal-cancel:hover,
.remodal-cancel:focus {
  background: #ef5350;
}

/* Remove inner padding and border in Firefox 4+ for the button tag. */

.remodal-confirm::-moz-focus-inner,
.remodal-cancel::-moz-focus-inner,
.remodal-close::-moz-focus-inner {
  padding: 0;

  border: 0;
}

/* Keyframes
   ========================================================================== */

@-webkit-keyframes remodal-opening-keyframes {
  from {
    -webkit-transform: scale(1.05);
    transform: scale(1.05);

    opacity: 0;
  }
  to {
    -webkit-transform: none;
    transform: none;

    opacity: 1;
  }
}

@keyframes remodal-opening-keyframes {
  from {
    -webkit-transform: scale(1.05);
    transform: scale(1.05);

    opacity: 0;
  }
  to {
    -webkit-transform: none;
    transform: none;

    opacity: 1;
  }
}

@-webkit-keyframes remodal-closing-keyframes {
  from {
    -webkit-transform: scale(1);
    transform: scale(1);

    opacity: 1;
  }
  to {
    -webkit-transform: scale(0.95);
    transform: scale(0.95);

    opacity: 0;
  }
}

@keyframes remodal-closing-keyframes {
  from {
    -webkit-transform: scale(1);
    transform: scale(1);

    opacity: 1;
  }
  to {
    -webkit-transform: scale(0.95);
    transform: scale(0.95);

    opacity: 0;
  }
}

@-webkit-keyframes remodal-overlay-opening-keyframes {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes remodal-overlay-opening-keyframes {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@-webkit-keyframes remodal-overlay-closing-keyframes {
  from {
    opacity: 1;
  }
  to {
    opacity: 0;
  }
}

@keyframes remodal-overlay-closing-keyframes {
  from {
    opacity: 1;
  }
  to {
    opacity: 0;
  }
}

/* Media queries
   ========================================================================== */

@media only screen and (min-width: 641px) {
  #instockRemodal {
    max-width: 700px;
  }
}

/* IE8
   ========================================================================== */

.lt-ie9 .remodal-overlay {
  background: #2b2e38;
}

.lt-ie9 #instockRemodal {
  width: 700px;
}

#instockRemodal {
    width: 100%;
    min-height: 100%;
    padding: 35px;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    font-size: 13px;
    background: #f4f4f4;
    background-clip: padding-box;
    color: #000000;
    -webkit-box-shadow: 0px 0px 8px #171a24;
    box-shadow: 0px 0px 8px #171a24;
    -webkit-transform: scale(0.95);
    -moz-transform: scale(0.95);
    -ms-transform: scale(0.95);
    -o-transform: scale(0.95);
    transform: scale(0.95);
    -webkit-transition: -webkit-transform 0.2s linear;
    -moz-transition: -moz-transform 0.2s linear;
    -o-transition: -o-transform 0.2s linear;
    transition: transform 0.2s linear;
    font-family: open sans;
 }


/* Media queries
   ========================================================================== */
@media only screen and (min-width: 40.063em) {
   #instockRemodal {
        max-width: 560px;
        margin: 20px auto;
        min-height: 0;
        -webkit-border-radius: 0px;
        /*tu i linijke nizej ustawiamy radius modala*/
        border-radius: 0px;
        border-style: none;
        border-color: #000000;
        border-width: 1px;
    } }
#modalProductPhoto {
    width: 160px;
    text-align: center;
    float: left;
    margin-right: 20px; }

#modalSection {
    margin: 30px 0 20px; }

#modalProductAction {
    width: 300px;
    float: left; }
#modalProductAction .modal-form-group {
    margin-bottom: 15px; }
#modalProductAction label {
    font-weight:bold;
    display: block;
    font-size: 14px;
    text-align: left;
    margin: 0 0 5px; }
#modalProductAction input, #modalProductAction select {
    width: 100%;
    border: 1px solid #999;
    padding: 5px 10px;
    font-size: 12px;
    background: #fff; }
#modalProductAction button {
    background: #252525;
    font-size: 12px;
    font-weight: bold;
    padding: 5px 20px;
    display: block;
    border: 0;
    color:  #ffffff; }

#modalMessageError {
  display: none; }
  #modalMessageError.modal-message-show {
    display: block; }
  #modalMessageError p {
    font-size: 14px;
    font-weight: 300;
    line-height: 1.3em; }
    #modalMessageError p.modal-success {
      color: green; }
    #modalMessageError p.modal-error {
      color: red; }

#modalMessageSuccess {
  display: none;
  background: #7DC89A;
  width: 100%;
  height: 100%;
  position: absolute;
  top: 0;
  left: 0;
  border-radius: 0px;
  /*dodaj ten sam border radius tu co na modalu*/ }
  #modalMessageSuccess.modal-message-show {
    display: block;
    padding: 50px 15px; }
    #modalMessageSuccess.modal-message-show p {
      padding: 0px 25px;
	line-height: 1.3em;
	font-size: 25px;
      font-weight: 300;
      color: #fff;
      margin-top: 80px; }

#instockreminderForm h3 {
    font-size: 30px;
margin:15px 0;
font-weight:bold;
    color: inherit; 
    font-family: open sans;
}

@media only screen and (max-width: 40.062em) {
    #modalProductPhoto {
        width: 100%;
        text-align: center;
        float: none; }

    #modalProductAction {
        margin-top: 20px;
        width: 100%;
        float: none; } }
.clearfix:before,
.clearfix:after {
    content: " ";
    /* 1 */
    display: table;
    /* 2 */ }

.clearfix:after {
    clear: both; }

.clearfix {
    *zoom: 1; }
    #instockReminderButton {
  cursor: pointer;
  font-size: 12px;
  text-transform: uppercase;
  font-weight: bold;
  position: fixed;
  z-index: 9999;
  line-height: 85px;
  height: 85px;
  width: 200px;
  background: #b5403a;
  text-align: center; }
  #instockReminderButton p {
font-family: 'Helvetica','Arial','Tahoma',sans-serif;
    margin: 0;
    line-height:20px;
    display: inline-block;
    color: #ffffff;
    vertical-align: middle; }
    #instockReminderButton p:hover {
      cursor: pointer;
      opacity: 0.8; }
  #instockReminderButton.reminder-btn-left {
    left: 0;
    top: 50%;
    -ms-transform: rotate(90deg) translate(-50%, -100%);
    /* IE 9 */
    -webkit-transform: rotate(90deg) translate(-50%, -100%);
    /* Chrome, Safari, Opera */
    transform: rotate(90deg) translate(-50%, -100%);
    -webkit-transform-origin: top left;
    -ms-transform-origin: top left;
    transform-origin: top left; }
    #instockReminderButton.reminder-btn-left p {
      border-radius: 5px 5px 0 0; }
  #instockReminderButton.reminder-btn-right {
    right: 0;
    top: 50%;
    -ms-transform: rotate(-90deg) translate(50%, -100%);
    /* IE 9 */
    -webkit-transform: rotate(-90deg) translate(50%, -100%);
    /* Chrome, Safari, Opera */
    transform: rotate(-90deg) translate(50%, -100%);
    -webkit-transform-origin: top right;
    -ms-transform-origin: top right;
    transform-origin: top right; }
    #instockReminderButton.reminder-btn-right {
      border-radius: 5px 5px 0 0; }
  #instockReminderButton.reminder-btn-top-right {
    right: 20px;
    top: 0;
    border-radius: 0 0 5px 5px; }
  #instockReminderButton.reminder-btn-top-left {
    left: 20px;
    top: 0;
    border-radius: 0 0 5px 5px; }
  #instockReminderButton.reminder-btn-bottom-right {
    right: 20px;
    bottom: 0;
    border-radius: 5px 5px 0 0; }
  #instockReminderButton.reminder-btn-bottom-left {
    left: 20px;
    bottom: 0;
    border-radius: 5px 5px 0 0; }
</style>
<div style="display: none;" id="isLink"></div>
<div style="display: none;" id="productId">{$product->id}</div>
<div style="display: none;" id="sht">35469ec97dd6a172489585f436d691c5cfff352c</div>
<div id="instockRemodal" class="remodal">
<a href="#" class="remodal-close reminder-close" data-remodal-action="close"></a>
<div id="instockreminderForm">
    <h3>Zapisz się</h3>
    <p>
        Padaj nam swój adres e-mail, powiadomimy Cię jak tylko produkt będzie dostępny.
    </p>
    <div id="modalSection" class="clearfix">
	    <div id="modalProductPhoto">

	    </div>
	    <div id="modalProductAction">
		    <form action="">
		    	<div id="variantSelect" class="modal-form-group">
		    		<label for="modalVariant">Wybierz wariant produktu</label>
				    <select name="" id="modalVariant">

				    </select>
			    </div>
			    <div class="modal-form-group">
			    	<label for="modalEmail">Twój email</label>
			    	<input id="modalEmail" type="email" required="required" placeholder="podaj swój email"/>
			    </div>
		    	<div class="modal-form-group">
		    		<label for="modalVariant">Określ ile dni możesz zaczekać na produkt</label>
				    <select name="" id="wait">
					<option value="1">1</option>
					<option value="3">3</option>
					<option value="5">5</option>
					<option value="7">7</option>
					<option value="14">14</option>
					<option value="21">21</option>
					<option selected="selected" value="0">aż będzie dostępny :)</option>
				    </select>
			    </div>
			    <button id="submitInstockForm" type="button">Zapisz mnie</button>
		    </form>
	    </div>
    </div>
<div id="modalMessageSuccess" class="">
	    <p class="modal-success">
		    
	    </p>
    </div>
<div id="modalMessageError" class="">
	    <p class="modal-error">
		    
	    </p>
    </div>
</div>
</div>
<div id="instockReminderButton" class="reminder-btn-left" style="display: none;">
	<p>Zapisz się</p>
</div>
<script src="//instockreminder.shoploapp.com/js/remodal-0.js"></script>
        