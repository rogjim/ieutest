/*! normalize.css v3.0.2 | MIT License | git.io/normalize */

/**
 * 1. Set default font family to sans-serif.
 * 2. Prevent iOS text size adjust after orientation change, without disabling
 *    user zoom.
 */

html {
  font-family: sans-serif; /* 1 */
  -ms-text-size-adjust: 100%; /* 2 */
  -webkit-text-size-adjust: 100%; /* 2 */
}

/**
 * Remove default margin.
 */

body {
  margin: 0;
}

/* HTML5 display definitions
   ========================================================================== */

/**
 * Correct `block` display not defined for any HTML5 element in IE 8/9.
 * Correct `block` display not defined for `details` or `summary` in IE 10/11
 * and Firefox.
 * Correct `block` display not defined for `main` in IE 11.
 */

article,
aside,
details,
figcaption,
figure,
footer,
header,
hgroup,
main,
menu,
nav,
section,
summary {
  display: block;
}

/**
 * 1. Correct `inline-block` display not defined in IE 8/9.
 * 2. Normalize vertical alignment of `progress` in Chrome, Firefox, and Opera.
 */

audio,
canvas,
progress,
video {
  display: inline-block; /* 1 */
  vertical-align: baseline; /* 2 */
}

/**
 * Prevent modern browsers from displaying `audio` without controls.
 * Remove excess height in iOS 5 devices.
 */

audio:not([controls]) {
  display: none;
  height: 0;
}

/**
 * Address `[hidden]` styling not present in IE 8/9/10.
 * Hide the `template` element in IE 8/9/11, Safari, and Firefox < 22.
 */

[hidden],
template {
  display: none;
}

/* Links
   ========================================================================== */

/**
 * Remove the gray background color from active links in IE 10.
 */

a {
  background-color: transparent;
}

/**
 * Improve readability when focused and also mouse hovered in all browsers.
 */

a:active,
a:hover {
  outline: 0;
}

/* Text-level semantics
   ========================================================================== */

/**
 * Address styling not present in IE 8/9/10/11, Safari, and Chrome.
 */

abbr[title] {
  border-bottom: 1px dotted;
}

/**
 * Address style set to `bolder` in Firefox 4+, Safari, and Chrome.
 */

b,
strong {
  font-weight: bold;
}

/**
 * Address styling not present in Safari and Chrome.
 */

dfn {
  font-style: italic;
}

/**
 * Address variable `h1` font-size and margin within `section` and `article`
 * contexts in Firefox 4+, Safari, and Chrome.
 */

h1 {
  font-size: 2em;
  margin: 0.67em 0;
}

/**
 * Address styling not present in IE 8/9.
 */

mark {
  background: #ff0;
  color: #000;
}

/**
 * Address inconsistent and variable font size in all browsers.
 */

small {
  font-size: 80%;
}

/**
 * Prevent `sub` and `sup` affecting `line-height` in all browsers.
 */

sub,
sup {
  font-size: 75%;
  line-height: 0;
  position: relative;
  vertical-align: baseline;
}

sup {
  top: -0.5em;
}

sub {
  bottom: -0.25em;
}

/* Embedded content
   ========================================================================== */

/**
 * Remove border when inside `a` element in IE 8/9/10.
 */

img {
  border: 0;
}

/**
 * Correct overflow not hidden in IE 9/10/11.
 */

svg:not(:root) {
  overflow: hidden;
}

/* Grouping content
   ========================================================================== */

/**
 * Address margin not present in IE 8/9 and Safari.
 */

figure {
  margin: 1em 40px;
}

/**
 * Address differences between Firefox and other browsers.
 */

hr {
  -moz-box-sizing: content-box;
  box-sizing: content-box;
  height: 0;
}

/**
 * Contain overflow in all browsers.
 */

pre {
  overflow: auto;
}

/**
 * Address odd `em`-unit font size rendering in all browsers.
 */

code,
kbd,
pre,
samp {
  font-family: monospace, monospace;
  font-size: 1em;
}

/* Forms
   ========================================================================== */

/**
 * Known limitation: by default, Chrome and Safari on OS X allow very limited
 * styling of `select`, unless a `border` property is set.
 */

/**
 * 1. Correct color not being inherited.
 *    Known issue: affects color of disabled elements.
 * 2. Correct font properties not being inherited.
 * 3. Address margins set differently in Firefox 4+, Safari, and Chrome.
 */

button,
input,
optgroup,
select,
textarea {
  color: inherit; /* 1 */
  font: inherit; /* 2 */
  margin: 0; /* 3 */
}

/**
 * Address `overflow` set to `hidden` in IE 8/9/10/11.
 */

button {
  overflow: visible;
}

/**
 * Address inconsistent `text-transform` inheritance for `button` and `select`.
 * All other form control elements do not inherit `text-transform` values.
 * Correct `button` style inheritance in Firefox, IE 8/9/10/11, and Opera.
 * Correct `select` style inheritance in Firefox.
 */

button,
select {
  text-transform: none;
}

/**
 * 1. Avoid the WebKit bug in Android 4.0.* where (2) destroys native `audio`
 *    and `video` controls.
 * 2. Correct inability to style clickable `input` types in iOS.
 * 3. Improve usability and consistency of cursor style between image-type
 *    `input` and others.
 */

button,
html input[type="button"], /* 1 */
input[type="reset"],
input[type="submit"] {
  -webkit-appearance: button; /* 2 */
  cursor: pointer; /* 3 */
}

/**
 * Re-set default cursor for disabled elements.
 */

button[disabled],
html input[disabled] {
  cursor: default;
}

/**
 * Remove inner padding and border in Firefox 4+.
 */

button::-moz-focus-inner,
input::-moz-focus-inner {
  border: 0;
  padding: 0;
}

/**
 * Address Firefox 4+ setting `line-height` on `input` using `!important` in
 * the UA stylesheet.
 */

input {
  line-height: normal;
}

/**
 * It's recommended that you don't attempt to style these elements.
 * Firefox's implementation doesn't respect box-sizing, padding, or width.
 *
 * 1. Address box sizing set to `content-box` in IE 8/9/10.
 * 2. Remove excess padding in IE 8/9/10.
 */

input[type="checkbox"],
input[type="radio"] {
  box-sizing: border-box; /* 1 */
  padding: 0; /* 2 */
}

/**
 * Fix the cursor style for Chrome's increment/decrement buttons. For certain
 * `font-size` values of the `input`, it causes the cursor style of the
 * decrement button to change from `default` to `text`.
 */

input[type="number"]::-webkit-inner-spin-button,
input[type="number"]::-webkit-outer-spin-button {
  height: auto;
}

/**
 * 1. Address `appearance` set to `searchfield` in Safari and Chrome.
 * 2. Address `box-sizing` set to `border-box` in Safari and Chrome
 *    (include `-moz` to future-proof).
 */

input[type="search"] {
  -webkit-appearance: textfield; /* 1 */
  -moz-box-sizing: content-box;
  -webkit-box-sizing: content-box; /* 2 */
  box-sizing: content-box;
}

/**
 * Remove inner padding and search cancel button in Safari and Chrome on OS X.
 * Safari (but not Chrome) clips the cancel button when the search input has
 * padding (and `textfield` appearance).
 */

input[type="search"]::-webkit-search-cancel-button,
input[type="search"]::-webkit-search-decoration {
  -webkit-appearance: none;
}

/**
 * Define consistent border, margin, and padding.
 */

fieldset {
  border: 1px solid #c0c0c0;
  margin: 0 2px;
  padding: 0.35em 0.625em 0.75em;
}

/**
 * 1. Correct `color` not being inherited in IE 8/9/10/11.
 * 2. Remove padding so people aren't caught out if they zero out fieldsets.
 */

legend {
  border: 0; /* 1 */
  padding: 0; /* 2 */
}

/**
 * Remove default vertical scrollbar in IE 8/9/10/11.
 */

textarea {
  overflow: auto;
}

/**
 * Don't inherit the `font-weight` (applied by a rule above).
 * NOTE: the default cannot safely be changed in Chrome and Safari on OS X.
 */

optgroup {
  font-weight: bold;
}

/* Tables
   ========================================================================== */

/**
 * Remove most spacing between table cells.
 */

table {
  border-collapse: collapse;
  border-spacing: 0;
}

td,
th {
  padding: 0;
}

/*! fancyBox v2.1.5 fancyapps.com | fancyapps.com/fancybox/#license */
.fancybox-wrap,
.fancybox-skin,
.fancybox-outer,
.fancybox-inner,
.fancybox-image,
.fancybox-wrap iframe,
.fancybox-wrap object,
.fancybox-nav,
.fancybox-nav span,
.fancybox-tmp
{
	padding: 0;
	margin: 0;
	border: 0;
	outline: none;
	vertical-align: top;
}

.fancybox-wrap {
	position: absolute;
	top: 0;
	left: 0;
	z-index: 8020;
}

.fancybox-skin {
	position: relative;
	background: #f9f9f9;
	color: #444;
	text-shadow: none;
	-webkit-border-radius: 4px;
	   -moz-border-radius: 4px;
	        border-radius: 4px;
}

.fancybox-opened {
	z-index: 8030;
}

.fancybox-opened .fancybox-skin {
	-webkit-box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
	   -moz-box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
	        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
}

.fancybox-outer, .fancybox-inner {
	position: relative;
}

.fancybox-inner {
	overflow: hidden;
}

.fancybox-type-iframe .fancybox-inner {
	-webkit-overflow-scrolling: touch;
}

.fancybox-error {
	color: #444;
	font: 14px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
	margin: 0;
	padding: 15px;
	white-space: nowrap;
}

.fancybox-image, .fancybox-iframe {
	display: block;
	width: 100%;
	height: 100%;
}

.fancybox-image {
	max-width: 100%;
	max-height: 100%;
}

#fancybox-loading, .fancybox-close, .fancybox-prev span, .fancybox-next span {
	background-image: url('fancybox_sprite.png');
}

#fancybox-loading {
	position: fixed;
	top: 50%;
	left: 50%;
	margin-top: -22px;
	margin-left: -22px;
	background-position: 0 -108px;
	opacity: 0.8;
	cursor: pointer;
	z-index: 8060;
}

#fancybox-loading div {
	width: 44px;
	height: 44px;
	background: url('fancybox_loading.gif') center center no-repeat;
}

.fancybox-close {
	position: absolute;
	top: -18px;
	right: -18px;
	width: 36px;
	height: 36px;
	cursor: pointer;
	z-index: 8040;
}

.fancybox-nav {
	position: absolute;
	top: 0;
	width: 40%;
	height: 100%;
	cursor: pointer;
	text-decoration: none;
	background: transparent url('blank.gif'); /* helps IE */
	-webkit-tap-highlight-color: rgba(0,0,0,0);
	z-index: 8040;
}

.fancybox-prev {
	left: 0;
}

.fancybox-next {
	right: 0;
}

.fancybox-nav span {
	position: absolute;
	top: 50%;
	width: 36px;
	height: 34px;
	margin-top: -18px;
	cursor: pointer;
	z-index: 8040;
	visibility: hidden;
}

.fancybox-prev span {
	left: 10px;
	background-position: 0 -36px;
}

.fancybox-next span {
	right: 10px;
	background-position: 0 -72px;
}

.fancybox-nav:hover span {
	visibility: visible;
}

.fancybox-tmp {
	position: absolute;
	top: -99999px;
	left: -99999px;
	visibility: hidden;
	max-width: 99999px;
	max-height: 99999px;
	overflow: visible !important;
}

/* Overlay helper */

.fancybox-lock {
    overflow: hidden !important;
    width: auto;
}

.fancybox-lock body {
    overflow: hidden !important;
}

.fancybox-lock-test {
    overflow-y: hidden !important;
}

.fancybox-overlay {
	position: absolute;
	top: 0;
	left: 0;
	overflow: hidden;
	display: none;
	z-index: 8010;
	background: url('fancybox_overlay.png');
}

.fancybox-overlay-fixed {
	position: fixed;
	bottom: 0;
	right: 0;
}

.fancybox-lock .fancybox-overlay {
	overflow: auto;
	overflow-y: scroll;
}

/* Title helper */

.fancybox-title {
	visibility: hidden;
	font: normal 13px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;
	position: relative;
	text-shadow: none;
	z-index: 8050;
}

.fancybox-opened .fancybox-title {
	visibility: visible;
}

.fancybox-title-float-wrap {
	position: absolute;
	bottom: 0;
	right: 50%;
	margin-bottom: -35px;
	z-index: 8050;
	text-align: center;
}

.fancybox-title-float-wrap .child {
	display: inline-block;
	margin-right: -100%;
	padding: 2px 20px;
	background: transparent; /* Fallback for web browsers that doesn't support RGBa */
	background: rgba(0, 0, 0, 0.8);
	-webkit-border-radius: 15px;
	   -moz-border-radius: 15px;
	        border-radius: 15px;
	text-shadow: 0 1px 2px #222;
	color: #FFF;
	font-weight: bold;
	line-height: 24px;
	white-space: nowrap;
}

.fancybox-title-outside-wrap {
	position: relative;
	margin-top: 10px;
	color: #fff;
}

.fancybox-title-inside-wrap {
	padding-top: 10px;
}

.fancybox-title-over-wrap {
	position: absolute;
	bottom: 0;
	left: 0;
	color: #fff;
	padding: 10px;
	background: #000;
	background: rgba(0, 0, 0, .8);
}

/*Retina graphics!*/
@media only screen and (-webkit-min-device-pixel-ratio: 1.5),
	   only screen and (min--moz-device-pixel-ratio: 1.5),
	   only screen and (min-device-pixel-ratio: 1.5){

	#fancybox-loading, .fancybox-close, .fancybox-prev span, .fancybox-next span {
		background-image: url('fancybox_sprite@2x.png');
		background-size: 44px 152px; /*The size of the normal image, half the size of the hi-res image*/
	}

	#fancybox-loading div {
		background-image: url('fancybox_loading@2x.gif');
		background-size: 24px 24px; /*The size of the normal image, half the size of the hi-res image*/
	}
}
/*! jQuery UI - v1.11.2 - 2014-10-16
* http://jqueryui.com
* Includes: core.css, accordion.css, autocomplete.css, button.css, datepicker.css, dialog.css, draggable.css, menu.css, progressbar.css, resizable.css, selectable.css, selectmenu.css, slider.css, sortable.css, spinner.css, tabs.css, tooltip.css, theme.css
* To view and modify this theme, visit http://jqueryui.com/themeroller/?ffDefault=Verdana%2CArial%2Csans-serif&fwDefault=normal&fsDefault=1.1em&cornerRadius=4px&bgColorHeader=cccccc&bgTextureHeader=highlight_soft&bgImgOpacityHeader=75&borderColorHeader=aaaaaa&fcHeader=222222&iconColorHeader=222222&bgColorContent=ffffff&bgTextureContent=flat&bgImgOpacityContent=75&borderColorContent=aaaaaa&fcContent=222222&iconColorContent=222222&bgColorDefault=e6e6e6&bgTextureDefault=glass&bgImgOpacityDefault=75&borderColorDefault=d3d3d3&fcDefault=555555&iconColorDefault=888888&bgColorHover=dadada&bgTextureHover=glass&bgImgOpacityHover=75&borderColorHover=999999&fcHover=212121&iconColorHover=454545&bgColorActive=ffffff&bgTextureActive=glass&bgImgOpacityActive=65&borderColorActive=aaaaaa&fcActive=212121&iconColorActive=454545&bgColorHighlight=fbf9ee&bgTextureHighlight=glass&bgImgOpacityHighlight=55&borderColorHighlight=fcefa1&fcHighlight=363636&iconColorHighlight=2e83ff&bgColorError=fef1ec&bgTextureError=glass&bgImgOpacityError=95&borderColorError=cd0a0a&fcError=cd0a0a&iconColorError=cd0a0a&bgColorOverlay=aaaaaa&bgTextureOverlay=flat&bgImgOpacityOverlay=0&opacityOverlay=30&bgColorShadow=aaaaaa&bgTextureShadow=flat&bgImgOpacityShadow=0&opacityShadow=30&thicknessShadow=8px&offsetTopShadow=-8px&offsetLeftShadow=-8px&cornerRadiusShadow=8px
* Copyright 2014 jQuery Foundation and other contributors; Licensed MIT */

/* Layout helpers
----------------------------------*/
.ui-helper-hidden {
	display: none;
}
.ui-helper-hidden-accessible {
	border: 0;
	clip: rect(0 0 0 0);
	height: 1px;
	margin: -1px;
	overflow: hidden;
	padding: 0;
	position: absolute;
	width: 1px;
}
.ui-helper-reset {
	margin: 0;
	padding: 0;
	border: 0;
	outline: 0;
	line-height: 1.3;
	text-decoration: none;
	font-size: 100%;
	list-style: none;
}
.ui-helper-clearfix:before,
.ui-helper-clearfix:after {
	content: "";
	display: table;
	border-collapse: collapse;
}
.ui-helper-clearfix:after {
	clear: both;
}
.ui-helper-clearfix {
	min-height: 0; /* support: IE7 */
}
.ui-helper-zfix {
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	position: absolute;
	opacity: 0;
	filter:Alpha(Opacity=0); /* support: IE8 */
}

.ui-front {
	z-index: 100;
}


/* Interaction Cues
----------------------------------*/
.ui-state-disabled {
	cursor: default !important;
}


/* Icons
----------------------------------*/

/* states and images */
.ui-icon {
	display: block;
	text-indent: -99999px;
	overflow: hidden;
	background-repeat: no-repeat;
}


/* Misc visuals
----------------------------------*/

/* Overlays */
.ui-widget-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}
.ui-accordion .ui-accordion-header {
	display: block;
	cursor: pointer;
	position: relative;
	margin: 2px 0 0 0;
	padding: .5em .5em .5em .7em;
	min-height: 0; /* support: IE7 */
	font-size: 100%;
}
.ui-accordion .ui-accordion-icons {
	padding-left: 2.2em;
}
.ui-accordion .ui-accordion-icons .ui-accordion-icons {
	padding-left: 2.2em;
}
.ui-accordion .ui-accordion-header .ui-accordion-header-icon {
	position: absolute;
	left: .5em;
	top: 50%;
	margin-top: -8px;
}
.ui-accordion .ui-accordion-content {
	padding: 1em 2.2em;
	border-top: 0;
	overflow: auto;
}
.ui-autocomplete {
	position: absolute;
	top: 0;
	left: 0;
	cursor: default;
}
.ui-button {
	display: inline-block;
	position: relative;
	padding: 0;
	line-height: normal;
	margin-right: .1em;
	cursor: pointer;
	vertical-align: middle;
	text-align: center;
	overflow: visible; /* removes extra width in IE */
}
.ui-button,
.ui-button:link,
.ui-button:visited,
.ui-button:hover,
.ui-button:active {
	text-decoration: none;
}
/* to make room for the icon, a width needs to be set here */
.ui-button-icon-only {
	width: 2.2em;
}
/* button elements seem to need a little more width */
button.ui-button-icon-only {
	width: 2.4em;
}
.ui-button-icons-only {
	width: 3.4em;
}
button.ui-button-icons-only {
	width: 3.7em;
}

/* button text element */
.ui-button .ui-button-text {
	display: block;
	line-height: normal;
}
.ui-button-text-only .ui-button-text {
	padding: .4em 1em;
}
.ui-button-icon-only .ui-button-text,
.ui-button-icons-only .ui-button-text {
	padding: .4em;
	text-indent: -9999999px;
}
.ui-button-text-icon-primary .ui-button-text,
.ui-button-text-icons .ui-button-text {
	padding: .4em 1em .4em 2.1em;
}
.ui-button-text-icon-secondary .ui-button-text,
.ui-button-text-icons .ui-button-text {
	padding: .4em 2.1em .4em 1em;
}
.ui-button-text-icons .ui-button-text {
	padding-left: 2.1em;
	padding-right: 2.1em;
}
/* no icon support for input elements, provide padding by default */
input.ui-button {
	padding: .4em 1em;
}

/* button icon element(s) */
.ui-button-icon-only .ui-icon,
.ui-button-text-icon-primary .ui-icon,
.ui-button-text-icon-secondary .ui-icon,
.ui-button-text-icons .ui-icon,
.ui-button-icons-only .ui-icon {
	position: absolute;
	top: 50%;
	margin-top: -8px;
}
.ui-button-icon-only .ui-icon {
	left: 50%;
	margin-left: -8px;
}
.ui-button-text-icon-primary .ui-button-icon-primary,
.ui-button-text-icons .ui-button-icon-primary,
.ui-button-icons-only .ui-button-icon-primary {
	left: .5em;
}
.ui-button-text-icon-secondary .ui-button-icon-secondary,
.ui-button-text-icons .ui-button-icon-secondary,
.ui-button-icons-only .ui-button-icon-secondary {
	right: .5em;
}

/* button sets */
.ui-buttonset {
	margin-right: 7px;
}
.ui-buttonset .ui-button {
	margin-left: 0;
	margin-right: -.3em;
}

/* workarounds */
/* reset extra padding in Firefox, see h5bp.com/l */
input.ui-button::-moz-focus-inner,
button.ui-button::-moz-focus-inner {
	border: 0;
	padding: 0;
}
.ui-datepicker {
	width: 17em;
	padding: .2em .2em 0;
	display: none;
}
.ui-datepicker .ui-datepicker-header {
	position: relative;
	padding: .2em 0;
}
.ui-datepicker .ui-datepicker-prev,
.ui-datepicker .ui-datepicker-next {
	position: absolute;
	top: 2px;
	width: 1.8em;
	height: 1.8em;
}
.ui-datepicker .ui-datepicker-prev-hover,
.ui-datepicker .ui-datepicker-next-hover {
	top: 1px;
}
.ui-datepicker .ui-datepicker-prev {
	left: 2px;
}
.ui-datepicker .ui-datepicker-next {
	right: 2px;
}
.ui-datepicker .ui-datepicker-prev-hover {
	left: 1px;
}
.ui-datepicker .ui-datepicker-next-hover {
	right: 1px;
}
.ui-datepicker .ui-datepicker-prev span,
.ui-datepicker .ui-datepicker-next span {
	display: block;
	position: absolute;
	left: 50%;
	margin-left: -8px;
	top: 50%;
	margin-top: -8px;
}
.ui-datepicker .ui-datepicker-title {
	margin: 0 2.3em;
	line-height: 1.8em;
	text-align: center;
}
.ui-datepicker .ui-datepicker-title select {
	font-size: 1em;
	margin: 1px 0;
}
.ui-datepicker select.ui-datepicker-month,
.ui-datepicker select.ui-datepicker-year {
	width: 45%;
}
.ui-datepicker table {
	width: 100%;
	font-size: .9em;
	border-collapse: collapse;
	margin: 0 0 .4em;
}
.ui-datepicker th {
	padding: .7em .3em;
	text-align: center;
	font-weight: bold;
	border: 0;
}
.ui-datepicker td {
	border: 0;
	padding: 1px;
}
.ui-datepicker td span,
.ui-datepicker td a {
	display: block;
	padding: .2em;
	text-align: right;
	text-decoration: none;
}
.ui-datepicker .ui-datepicker-buttonpane {
	background-image: none;
	margin: .7em 0 0 0;
	padding: 0 .2em;
	border-left: 0;
	border-right: 0;
	border-bottom: 0;
}
.ui-datepicker .ui-datepicker-buttonpane button {
	float: right;
	margin: .5em .2em .4em;
	cursor: pointer;
	padding: .2em .6em .3em .6em;
	width: auto;
	overflow: visible;
}
.ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current {
	float: left;
}

/* with multiple calendars */
.ui-datepicker.ui-datepicker-multi {
	width: auto;
}
.ui-datepicker-multi .ui-datepicker-group {
	float: left;
}
.ui-datepicker-multi .ui-datepicker-group table {
	width: 95%;
	margin: 0 auto .4em;
}
.ui-datepicker-multi-2 .ui-datepicker-group {
	width: 50%;
}
.ui-datepicker-multi-3 .ui-datepicker-group {
	width: 33.3%;
}
.ui-datepicker-multi-4 .ui-datepicker-group {
	width: 25%;
}
.ui-datepicker-multi .ui-datepicker-group-last .ui-datepicker-header,
.ui-datepicker-multi .ui-datepicker-group-middle .ui-datepicker-header {
	border-left-width: 0;
}
.ui-datepicker-multi .ui-datepicker-buttonpane {
	clear: left;
}
.ui-datepicker-row-break {
	clear: both;
	width: 100%;
	font-size: 0;
}

/* RTL support */
.ui-datepicker-rtl {
	direction: rtl;
}
.ui-datepicker-rtl .ui-datepicker-prev {
	right: 2px;
	left: auto;
}
.ui-datepicker-rtl .ui-datepicker-next {
	left: 2px;
	right: auto;
}
.ui-datepicker-rtl .ui-datepicker-prev:hover {
	right: 1px;
	left: auto;
}
.ui-datepicker-rtl .ui-datepicker-next:hover {
	left: 1px;
	right: auto;
}
.ui-datepicker-rtl .ui-datepicker-buttonpane {
	clear: right;
}
.ui-datepicker-rtl .ui-datepicker-buttonpane button {
	float: left;
}
.ui-datepicker-rtl .ui-datepicker-buttonpane button.ui-datepicker-current,
.ui-datepicker-rtl .ui-datepicker-group {
	float: right;
}
.ui-datepicker-rtl .ui-datepicker-group-last .ui-datepicker-header,
.ui-datepicker-rtl .ui-datepicker-group-middle .ui-datepicker-header {
	border-right-width: 0;
	border-left-width: 1px;
}
.ui-dialog {
	overflow: hidden;
	position: absolute;
	top: 0;
	left: 0;
	padding: .2em;
	outline: 0;
}
.ui-dialog .ui-dialog-titlebar {
	padding: .4em 1em;
	position: relative;
}
.ui-dialog .ui-dialog-title {
	float: left;
	margin: .1em 0;
	white-space: nowrap;
	width: 90%;
	overflow: hidden;
	text-overflow: ellipsis;
}
.ui-dialog .ui-dialog-titlebar-close {
	position: absolute;
	right: .3em;
	top: 50%;
	width: 20px;
	margin: -10px 0 0 0;
	padding: 1px;
	height: 20px;
}
.ui-dialog .ui-dialog-content {
	position: relative;
	border: 0;
	padding: .5em 1em;
	background: none;
	overflow: auto;
}
.ui-dialog .ui-dialog-buttonpane {
	text-align: left;
	border-width: 1px 0 0 0;
	background-image: none;
	margin-top: .5em;
	padding: .3em 1em .5em .4em;
}
.ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset {
	float: right;
}
.ui-dialog .ui-dialog-buttonpane button {
	margin: .5em .4em .5em 0;
	cursor: pointer;
}
.ui-dialog .ui-resizable-se {
	width: 12px;
	height: 12px;
	right: -5px;
	bottom: -5px;
	background-position: 16px 16px;
}
.ui-draggable .ui-dialog-titlebar {
	cursor: move;
}
.ui-draggable-handle {
	-ms-touch-action: none;
	touch-action: none;
}
.ui-menu {
	list-style: none;
	padding: 0;
	margin: 0;
	display: block;
	outline: none;
}
.ui-menu .ui-menu {
	position: absolute;
}
.ui-menu .ui-menu-item {
	position: relative;
	margin: 0;
	padding: 3px 1em 3px .4em;
	cursor: pointer;
	min-height: 0; /* support: IE7 */
	/* support: IE10, see #8844 */
	list-style-image: url("data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7");
}
.ui-menu .ui-menu-divider {
	margin: 5px 0;
	height: 0;
	font-size: 0;
	line-height: 0;
	border-width: 1px 0 0 0;
}
.ui-menu .ui-state-focus,
.ui-menu .ui-state-active {
	margin: -1px;
}

/* icon support */
.ui-menu-icons {
	position: relative;
}
.ui-menu-icons .ui-menu-item {
	padding-left: 2em;
}

/* left-aligned */
.ui-menu .ui-icon {
	position: absolute;
	top: 0;
	bottom: 0;
	left: .2em;
	margin: auto 0;
}

/* right-aligned */
.ui-menu .ui-menu-icon {
	left: auto;
	right: 0;
}
.ui-progressbar {
	height: 2em;
	text-align: left;
	overflow: hidden;
}
.ui-progressbar .ui-progressbar-value {
	margin: -1px;
	height: 100%;
}
.ui-progressbar .ui-progressbar-overlay {
	background: url("data:image/gif;base64,R0lGODlhKAAoAIABAAAAAP///yH/C05FVFNDQVBFMi4wAwEAAAAh+QQJAQABACwAAAAAKAAoAAACkYwNqXrdC52DS06a7MFZI+4FHBCKoDeWKXqymPqGqxvJrXZbMx7Ttc+w9XgU2FB3lOyQRWET2IFGiU9m1frDVpxZZc6bfHwv4c1YXP6k1Vdy292Fb6UkuvFtXpvWSzA+HycXJHUXiGYIiMg2R6W459gnWGfHNdjIqDWVqemH2ekpObkpOlppWUqZiqr6edqqWQAAIfkECQEAAQAsAAAAACgAKAAAApSMgZnGfaqcg1E2uuzDmmHUBR8Qil95hiPKqWn3aqtLsS18y7G1SzNeowWBENtQd+T1JktP05nzPTdJZlR6vUxNWWjV+vUWhWNkWFwxl9VpZRedYcflIOLafaa28XdsH/ynlcc1uPVDZxQIR0K25+cICCmoqCe5mGhZOfeYSUh5yJcJyrkZWWpaR8doJ2o4NYq62lAAACH5BAkBAAEALAAAAAAoACgAAAKVDI4Yy22ZnINRNqosw0Bv7i1gyHUkFj7oSaWlu3ovC8GxNso5fluz3qLVhBVeT/Lz7ZTHyxL5dDalQWPVOsQWtRnuwXaFTj9jVVh8pma9JjZ4zYSj5ZOyma7uuolffh+IR5aW97cHuBUXKGKXlKjn+DiHWMcYJah4N0lYCMlJOXipGRr5qdgoSTrqWSq6WFl2ypoaUAAAIfkECQEAAQAsAAAAACgAKAAAApaEb6HLgd/iO7FNWtcFWe+ufODGjRfoiJ2akShbueb0wtI50zm02pbvwfWEMWBQ1zKGlLIhskiEPm9R6vRXxV4ZzWT2yHOGpWMyorblKlNp8HmHEb/lCXjcW7bmtXP8Xt229OVWR1fod2eWqNfHuMjXCPkIGNileOiImVmCOEmoSfn3yXlJWmoHGhqp6ilYuWYpmTqKUgAAIfkECQEAAQAsAAAAACgAKAAAApiEH6kb58biQ3FNWtMFWW3eNVcojuFGfqnZqSebuS06w5V80/X02pKe8zFwP6EFWOT1lDFk8rGERh1TTNOocQ61Hm4Xm2VexUHpzjymViHrFbiELsefVrn6XKfnt2Q9G/+Xdie499XHd2g4h7ioOGhXGJboGAnXSBnoBwKYyfioubZJ2Hn0RuRZaflZOil56Zp6iioKSXpUAAAh+QQJAQABACwAAAAAKAAoAAACkoQRqRvnxuI7kU1a1UU5bd5tnSeOZXhmn5lWK3qNTWvRdQxP8qvaC+/yaYQzXO7BMvaUEmJRd3TsiMAgswmNYrSgZdYrTX6tSHGZO73ezuAw2uxuQ+BbeZfMxsexY35+/Qe4J1inV0g4x3WHuMhIl2jXOKT2Q+VU5fgoSUI52VfZyfkJGkha6jmY+aaYdirq+lQAACH5BAkBAAEALAAAAAAoACgAAAKWBIKpYe0L3YNKToqswUlvznigd4wiR4KhZrKt9Upqip61i9E3vMvxRdHlbEFiEXfk9YARYxOZZD6VQ2pUunBmtRXo1Lf8hMVVcNl8JafV38aM2/Fu5V16Bn63r6xt97j09+MXSFi4BniGFae3hzbH9+hYBzkpuUh5aZmHuanZOZgIuvbGiNeomCnaxxap2upaCZsq+1kAACH5BAkBAAEALAAAAAAoACgAAAKXjI8By5zf4kOxTVrXNVlv1X0d8IGZGKLnNpYtm8Lr9cqVeuOSvfOW79D9aDHizNhDJidFZhNydEahOaDH6nomtJjp1tutKoNWkvA6JqfRVLHU/QUfau9l2x7G54d1fl995xcIGAdXqMfBNadoYrhH+Mg2KBlpVpbluCiXmMnZ2Sh4GBqJ+ckIOqqJ6LmKSllZmsoq6wpQAAAh+QQJAQABACwAAAAAKAAoAAAClYx/oLvoxuJDkU1a1YUZbJ59nSd2ZXhWqbRa2/gF8Gu2DY3iqs7yrq+xBYEkYvFSM8aSSObE+ZgRl1BHFZNr7pRCavZ5BW2142hY3AN/zWtsmf12p9XxxFl2lpLn1rseztfXZjdIWIf2s5dItwjYKBgo9yg5pHgzJXTEeGlZuenpyPmpGQoKOWkYmSpaSnqKileI2FAAACH5BAkBAAEALAAAAAAoACgAAAKVjB+gu+jG4kORTVrVhRlsnn2dJ3ZleFaptFrb+CXmO9OozeL5VfP99HvAWhpiUdcwkpBH3825AwYdU8xTqlLGhtCosArKMpvfa1mMRae9VvWZfeB2XfPkeLmm18lUcBj+p5dnN8jXZ3YIGEhYuOUn45aoCDkp16hl5IjYJvjWKcnoGQpqyPlpOhr3aElaqrq56Bq7VAAAOw==");
	height: 100%;
	filter: alpha(opacity=25); /* support: IE8 */
	opacity: 0.25;
}
.ui-progressbar-indeterminate .ui-progressbar-value {
	background-image: none;
}
.ui-resizable {
	position: relative;
}
.ui-resizable-handle {
	position: absolute;
	font-size: 0.1px;
	display: block;
	-ms-touch-action: none;
	touch-action: none;
}
.ui-resizable-disabled .ui-resizable-handle,
.ui-resizable-autohide .ui-resizable-handle {
	display: none;
}
.ui-resizable-n {
	cursor: n-resize;
	height: 7px;
	width: 100%;
	top: -5px;
	left: 0;
}
.ui-resizable-s {
	cursor: s-resize;
	height: 7px;
	width: 100%;
	bottom: -5px;
	left: 0;
}
.ui-resizable-e {
	cursor: e-resize;
	width: 7px;
	right: -5px;
	top: 0;
	height: 100%;
}
.ui-resizable-w {
	cursor: w-resize;
	width: 7px;
	left: -5px;
	top: 0;
	height: 100%;
}
.ui-resizable-se {
	cursor: se-resize;
	width: 12px;
	height: 12px;
	right: 1px;
	bottom: 1px;
}
.ui-resizable-sw {
	cursor: sw-resize;
	width: 9px;
	height: 9px;
	left: -5px;
	bottom: -5px;
}
.ui-resizable-nw {
	cursor: nw-resize;
	width: 9px;
	height: 9px;
	left: -5px;
	top: -5px;
}
.ui-resizable-ne {
	cursor: ne-resize;
	width: 9px;
	height: 9px;
	right: -5px;
	top: -5px;
}
.ui-selectable {
	-ms-touch-action: none;
	touch-action: none;
}
.ui-selectable-helper {
	position: absolute;
	z-index: 100;
	border: 1px dotted black;
}
.ui-selectmenu-menu {
	padding: 0;
	margin: 0;
	position: absolute;
	top: 0;
	left: 0;
	display: none;
}
.ui-selectmenu-menu .ui-menu {
	overflow: auto;
	/* Support: IE7 */
	overflow-x: hidden;
	padding-bottom: 1px;
}
.ui-selectmenu-menu .ui-menu .ui-selectmenu-optgroup {
	font-size: 1em;
	font-weight: bold;
	line-height: 1.5;
	padding: 2px 0.4em;
	margin: 0.5em 0 0 0;
	height: auto;
	border: 0;
}
.ui-selectmenu-open {
	display: block;
}
.ui-selectmenu-button {
	display: inline-block;
	overflow: hidden;
	position: relative;
	text-decoration: none;
	cursor: pointer;
}
.ui-selectmenu-button span.ui-icon {
	right: 0.5em;
	left: auto;
	margin-top: -8px;
	position: absolute;
	top: 50%;
}
.ui-selectmenu-button span.ui-selectmenu-text {
	text-align: left;
	padding: 0.4em 2.1em 0.4em 1em;
	display: block;
	line-height: 1.4;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.ui-slider {
	position: relative;
	text-align: left;
}
.ui-slider .ui-slider-handle {
	position: absolute;
	z-index: 2;
	width: 1.2em;
	height: 1.2em;
	cursor: default;
	-ms-touch-action: none;
	touch-action: none;
}
.ui-slider .ui-slider-range {
	position: absolute;
	z-index: 1;
	font-size: .7em;
	display: block;
	border: 0;
	background-position: 0 0;
}

/* support: IE8 - See #6727 */
.ui-slider.ui-state-disabled .ui-slider-handle,
.ui-slider.ui-state-disabled .ui-slider-range {
	filter: inherit;
}

.ui-slider-horizontal {
	height: .8em;
}
.ui-slider-horizontal .ui-slider-handle {
	top: -.3em;
	margin-left: -.6em;
}
.ui-slider-horizontal .ui-slider-range {
	top: 0;
	height: 100%;
}
.ui-slider-horizontal .ui-slider-range-min {
	left: 0;
}
.ui-slider-horizontal .ui-slider-range-max {
	right: 0;
}

.ui-slider-vertical {
	width: .8em;
	height: 100px;
}
.ui-slider-vertical .ui-slider-handle {
	left: -.3em;
	margin-left: 0;
	margin-bottom: -.6em;
}
.ui-slider-vertical .ui-slider-range {
	left: 0;
	width: 100%;
}
.ui-slider-vertical .ui-slider-range-min {
	bottom: 0;
}
.ui-slider-vertical .ui-slider-range-max {
	top: 0;
}
.ui-sortable-handle {
	-ms-touch-action: none;
	touch-action: none;
}
.ui-spinner {
	position: relative;
	display: inline-block;
	overflow: hidden;
	padding: 0;
	vertical-align: middle;
}
.ui-spinner-input {
	border: none;
	background: none;
	color: inherit;
	padding: 0;
	margin: .2em 0;
	vertical-align: middle;
	margin-left: .4em;
	margin-right: 22px;
}
.ui-spinner-button {
	width: 16px;
	height: 50%;
	font-size: .5em;
	padding: 0;
	margin: 0;
	text-align: center;
	position: absolute;
	cursor: default;
	display: block;
	overflow: hidden;
	right: 0;
}
/* more specificity required here to override default borders */
.ui-spinner a.ui-spinner-button {
	border-top: none;
	border-bottom: none;
	border-right: none;
}
/* vertically center icon */
.ui-spinner .ui-icon {
	position: absolute;
	margin-top: -8px;
	top: 50%;
	left: 0;
}
.ui-spinner-up {
	top: 0;
}
.ui-spinner-down {
	bottom: 0;
}

/* TR overrides */
.ui-spinner .ui-icon-triangle-1-s {
	/* need to fix icons sprite */
	background-position: -65px -16px;
}
.ui-tabs {
	position: relative;/* position: relative prevents IE scroll bug (element with position: relative inside container with overflow: auto appear as "fixed") */
	padding: .2em;
}
.ui-tabs .ui-tabs-nav {
	margin: 0;
	padding: .2em .2em 0;
}
.ui-tabs .ui-tabs-nav li {
	list-style: none;
	float: left;
	position: relative;
	top: 0;
	margin: 1px .2em 0 0;
	border-bottom-width: 0;
	padding: 0;
	white-space: nowrap;
}
.ui-tabs .ui-tabs-nav .ui-tabs-anchor {
	float: left;
	padding: .5em 1em;
	text-decoration: none;
}
.ui-tabs .ui-tabs-nav li.ui-tabs-active {
	margin-bottom: -1px;
	padding-bottom: 1px;
}
.ui-tabs .ui-tabs-nav li.ui-tabs-active .ui-tabs-anchor,
.ui-tabs .ui-tabs-nav li.ui-state-disabled .ui-tabs-anchor,
.ui-tabs .ui-tabs-nav li.ui-tabs-loading .ui-tabs-anchor {
	cursor: text;
}
.ui-tabs-collapsible .ui-tabs-nav li.ui-tabs-active .ui-tabs-anchor {
	cursor: pointer;
}
.ui-tabs .ui-tabs-panel {
	display: block;
	border-width: 0;
	padding: 1em 1.4em;
	background: none;
}
.ui-tooltip {
	padding: 8px;
	position: absolute;
	z-index: 9999;
	max-width: 300px;
	-webkit-box-shadow: 0 0 5px #aaa;
	box-shadow: 0 0 5px #aaa;
}
body .ui-tooltip {
	border-width: 2px;
}

/* Component containers
----------------------------------*/
.ui-widget {
	font-family: Verdana,Arial,sans-serif;
	font-size: 1.1em;
}
.ui-widget .ui-widget {
	font-size: 1em;
}
.ui-widget input,
.ui-widget select,
.ui-widget textarea,
.ui-widget button {
	font-family: Verdana,Arial,sans-serif;
	font-size: 1em;
}
.ui-widget-content {
	border: 1px solid #aaaaaa;
	background: #ffffff url("images/ui-bg_flat_75_ffffff_40x100.png") 50% 50% repeat-x;
	color: #222222;
}
.ui-widget-content a {
	color: #222222;
}
.ui-widget-header {
	border: 1px solid #aaaaaa;
	background: #cccccc url("images/ui-bg_highlight-soft_75_cccccc_1x100.png") 50% 50% repeat-x;
	color: #222222;
	font-weight: bold;
}
.ui-widget-header a {
	color: #222222;
}

/* Interaction states
----------------------------------*/
.ui-state-default,
.ui-widget-content .ui-state-default,
.ui-widget-header .ui-state-default {
	border: 1px solid #d3d3d3;
	background: #e6e6e6 url("images/ui-bg_glass_75_e6e6e6_1x400.png") 50% 50% repeat-x;
	font-weight: normal;
	color: #555555;
}
.ui-state-default a,
.ui-state-default a:link,
.ui-state-default a:visited {
	color: #555555;
	text-decoration: none;
}
.ui-state-hover,
.ui-widget-content .ui-state-hover,
.ui-widget-header .ui-state-hover,
.ui-state-focus,
.ui-widget-content .ui-state-focus,
.ui-widget-header .ui-state-focus {
	border: 1px solid #999999;
	background: #dadada url("images/ui-bg_glass_75_dadada_1x400.png") 50% 50% repeat-x;
	font-weight: normal;
	color: #212121;
}
.ui-state-hover a,
.ui-state-hover a:hover,
.ui-state-hover a:link,
.ui-state-hover a:visited,
.ui-state-focus a,
.ui-state-focus a:hover,
.ui-state-focus a:link,
.ui-state-focus a:visited {
	color: #212121;
	text-decoration: none;
}
.ui-state-active,
.ui-widget-content .ui-state-active,
.ui-widget-header .ui-state-active {
	border: 1px solid #aaaaaa;
	background: #ffffff url("images/ui-bg_glass_65_ffffff_1x400.png") 50% 50% repeat-x;
	font-weight: normal;
	color: #212121;
}
.ui-state-active a,
.ui-state-active a:link,
.ui-state-active a:visited {
	color: #212121;
	text-decoration: none;
}

/* Interaction Cues
----------------------------------*/
.ui-state-highlight,
.ui-widget-content .ui-state-highlight,
.ui-widget-header .ui-state-highlight {
	border: 1px solid #fcefa1;
	background: #fbf9ee url("images/ui-bg_glass_55_fbf9ee_1x400.png") 50% 50% repeat-x;
	color: #363636;
}
.ui-state-highlight a,
.ui-widget-content .ui-state-highlight a,
.ui-widget-header .ui-state-highlight a {
	color: #363636;
}
.ui-state-error,
.ui-widget-content .ui-state-error,
.ui-widget-header .ui-state-error {
	border: 1px solid #cd0a0a;
	background: #fef1ec url("images/ui-bg_glass_95_fef1ec_1x400.png") 50% 50% repeat-x;
	color: #cd0a0a;
}
.ui-state-error a,
.ui-widget-content .ui-state-error a,
.ui-widget-header .ui-state-error a {
	color: #cd0a0a;
}
.ui-state-error-text,
.ui-widget-content .ui-state-error-text,
.ui-widget-header .ui-state-error-text {
	color: #cd0a0a;
}
.ui-priority-primary,
.ui-widget-content .ui-priority-primary,
.ui-widget-header .ui-priority-primary {
	font-weight: bold;
}
.ui-priority-secondary,
.ui-widget-content .ui-priority-secondary,
.ui-widget-header .ui-priority-secondary {
	opacity: .7;
	filter:Alpha(Opacity=70); /* support: IE8 */
	font-weight: normal;
}
.ui-state-disabled,
.ui-widget-content .ui-state-disabled,
.ui-widget-header .ui-state-disabled {
	opacity: .35;
	filter:Alpha(Opacity=35); /* support: IE8 */
	background-image: none;
}
.ui-state-disabled .ui-icon {
	filter:Alpha(Opacity=35); /* support: IE8 - See #6059 */
}

/* Icons
----------------------------------*/

/* states and images */
.ui-icon {
	width: 16px;
	height: 16px;
}
.ui-icon,
.ui-widget-content .ui-icon {
	background-image: url("images/ui-icons_222222_256x240.png");
}
.ui-widget-header .ui-icon {
	background-image: url("images/ui-icons_222222_256x240.png");
}
.ui-state-default .ui-icon {
	background-image: url("images/ui-icons_888888_256x240.png");
}
.ui-state-hover .ui-icon,
.ui-state-focus .ui-icon {
	background-image: url("images/ui-icons_454545_256x240.png");
}
.ui-state-active .ui-icon {
	background-image: url("images/ui-icons_454545_256x240.png");
}
.ui-state-highlight .ui-icon {
	background-image: url("images/ui-icons_2e83ff_256x240.png");
}
.ui-state-error .ui-icon,
.ui-state-error-text .ui-icon {
	background-image: url("images/ui-icons_cd0a0a_256x240.png");
}

/* positioning */
.ui-icon-blank { background-position: 16px 16px; }
.ui-icon-carat-1-n { background-position: 0 0; }
.ui-icon-carat-1-ne { background-position: -16px 0; }
.ui-icon-carat-1-e { background-position: -32px 0; }
.ui-icon-carat-1-se { background-position: -48px 0; }
.ui-icon-carat-1-s { background-position: -64px 0; }
.ui-icon-carat-1-sw { background-position: -80px 0; }
.ui-icon-carat-1-w { background-position: -96px 0; }
.ui-icon-carat-1-nw { background-position: -112px 0; }
.ui-icon-carat-2-n-s { background-position: -128px 0; }
.ui-icon-carat-2-e-w { background-position: -144px 0; }
.ui-icon-triangle-1-n { background-position: 0 -16px; }
.ui-icon-triangle-1-ne { background-position: -16px -16px; }
.ui-icon-triangle-1-e { background-position: -32px -16px; }
.ui-icon-triangle-1-se { background-position: -48px -16px; }
.ui-icon-triangle-1-s { background-position: -64px -16px; }
.ui-icon-triangle-1-sw { background-position: -80px -16px; }
.ui-icon-triangle-1-w { background-position: -96px -16px; }
.ui-icon-triangle-1-nw { background-position: -112px -16px; }
.ui-icon-triangle-2-n-s { background-position: -128px -16px; }
.ui-icon-triangle-2-e-w { background-position: -144px -16px; }
.ui-icon-arrow-1-n { background-position: 0 -32px; }
.ui-icon-arrow-1-ne { background-position: -16px -32px; }
.ui-icon-arrow-1-e { background-position: -32px -32px; }
.ui-icon-arrow-1-se { background-position: -48px -32px; }
.ui-icon-arrow-1-s { background-position: -64px -32px; }
.ui-icon-arrow-1-sw { background-position: -80px -32px; }
.ui-icon-arrow-1-w { background-position: -96px -32px; }
.ui-icon-arrow-1-nw { background-position: -112px -32px; }
.ui-icon-arrow-2-n-s { background-position: -128px -32px; }
.ui-icon-arrow-2-ne-sw { background-position: -144px -32px; }
.ui-icon-arrow-2-e-w { background-position: -160px -32px; }
.ui-icon-arrow-2-se-nw { background-position: -176px -32px; }
.ui-icon-arrowstop-1-n { background-position: -192px -32px; }
.ui-icon-arrowstop-1-e { background-position: -208px -32px; }
.ui-icon-arrowstop-1-s { background-position: -224px -32px; }
.ui-icon-arrowstop-1-w { background-position: -240px -32px; }
.ui-icon-arrowthick-1-n { background-position: 0 -48px; }
.ui-icon-arrowthick-1-ne { background-position: -16px -48px; }
.ui-icon-arrowthick-1-e { background-position: -32px -48px; }
.ui-icon-arrowthick-1-se { background-position: -48px -48px; }
.ui-icon-arrowthick-1-s { background-position: -64px -48px; }
.ui-icon-arrowthick-1-sw { background-position: -80px -48px; }
.ui-icon-arrowthick-1-w { background-position: -96px -48px; }
.ui-icon-arrowthick-1-nw { background-position: -112px -48px; }
.ui-icon-arrowthick-2-n-s { background-position: -128px -48px; }
.ui-icon-arrowthick-2-ne-sw { background-position: -144px -48px; }
.ui-icon-arrowthick-2-e-w { background-position: -160px -48px; }
.ui-icon-arrowthick-2-se-nw { background-position: -176px -48px; }
.ui-icon-arrowthickstop-1-n { background-position: -192px -48px; }
.ui-icon-arrowthickstop-1-e { background-position: -208px -48px; }
.ui-icon-arrowthickstop-1-s { background-position: -224px -48px; }
.ui-icon-arrowthickstop-1-w { background-position: -240px -48px; }
.ui-icon-arrowreturnthick-1-w { background-position: 0 -64px; }
.ui-icon-arrowreturnthick-1-n { background-position: -16px -64px; }
.ui-icon-arrowreturnthick-1-e { background-position: -32px -64px; }
.ui-icon-arrowreturnthick-1-s { background-position: -48px -64px; }
.ui-icon-arrowreturn-1-w { background-position: -64px -64px; }
.ui-icon-arrowreturn-1-n { background-position: -80px -64px; }
.ui-icon-arrowreturn-1-e { background-position: -96px -64px; }
.ui-icon-arrowreturn-1-s { background-position: -112px -64px; }
.ui-icon-arrowrefresh-1-w { background-position: -128px -64px; }
.ui-icon-arrowrefresh-1-n { background-position: -144px -64px; }
.ui-icon-arrowrefresh-1-e { background-position: -160px -64px; }
.ui-icon-arrowrefresh-1-s { background-position: -176px -64px; }
.ui-icon-arrow-4 { background-position: 0 -80px; }
.ui-icon-arrow-4-diag { background-position: -16px -80px; }
.ui-icon-extlink { background-position: -32px -80px; }
.ui-icon-newwin { background-position: -48px -80px; }
.ui-icon-refresh { background-position: -64px -80px; }
.ui-icon-shuffle { background-position: -80px -80px; }
.ui-icon-transfer-e-w { background-position: -96px -80px; }
.ui-icon-transferthick-e-w { background-position: -112px -80px; }
.ui-icon-folder-collapsed { background-position: 0 -96px; }
.ui-icon-folder-open { background-position: -16px -96px; }
.ui-icon-document { background-position: -32px -96px; }
.ui-icon-document-b { background-position: -48px -96px; }
.ui-icon-note { background-position: -64px -96px; }
.ui-icon-mail-closed { background-position: -80px -96px; }
.ui-icon-mail-open { background-position: -96px -96px; }
.ui-icon-suitcase { background-position: -112px -96px; }
.ui-icon-comment { background-position: -128px -96px; }
.ui-icon-person { background-position: -144px -96px; }
.ui-icon-print { background-position: -160px -96px; }
.ui-icon-trash { background-position: -176px -96px; }
.ui-icon-locked { background-position: -192px -96px; }
.ui-icon-unlocked { background-position: -208px -96px; }
.ui-icon-bookmark { background-position: -224px -96px; }
.ui-icon-tag { background-position: -240px -96px; }
.ui-icon-home { background-position: 0 -112px; }
.ui-icon-flag { background-position: -16px -112px; }
.ui-icon-calendar { background-position: -32px -112px; }
.ui-icon-cart { background-position: -48px -112px; }
.ui-icon-pencil { background-position: -64px -112px; }
.ui-icon-clock { background-position: -80px -112px; }
.ui-icon-disk { background-position: -96px -112px; }
.ui-icon-calculator { background-position: -112px -112px; }
.ui-icon-zoomin { background-position: -128px -112px; }
.ui-icon-zoomout { background-position: -144px -112px; }
.ui-icon-search { background-position: -160px -112px; }
.ui-icon-wrench { background-position: -176px -112px; }
.ui-icon-gear { background-position: -192px -112px; }
.ui-icon-heart { background-position: -208px -112px; }
.ui-icon-star { background-position: -224px -112px; }
.ui-icon-link { background-position: -240px -112px; }
.ui-icon-cancel { background-position: 0 -128px; }
.ui-icon-plus { background-position: -16px -128px; }
.ui-icon-plusthick { background-position: -32px -128px; }
.ui-icon-minus { background-position: -48px -128px; }
.ui-icon-minusthick { background-position: -64px -128px; }
.ui-icon-close { background-position: -80px -128px; }
.ui-icon-closethick { background-position: -96px -128px; }
.ui-icon-key { background-position: -112px -128px; }
.ui-icon-lightbulb { background-position: -128px -128px; }
.ui-icon-scissors { background-position: -144px -128px; }
.ui-icon-clipboard { background-position: -160px -128px; }
.ui-icon-copy { background-position: -176px -128px; }
.ui-icon-contact { background-position: -192px -128px; }
.ui-icon-image { background-position: -208px -128px; }
.ui-icon-video { background-position: -224px -128px; }
.ui-icon-script { background-position: -240px -128px; }
.ui-icon-alert { background-position: 0 -144px; }
.ui-icon-info { background-position: -16px -144px; }
.ui-icon-notice { background-position: -32px -144px; }
.ui-icon-help { background-position: -48px -144px; }
.ui-icon-check { background-position: -64px -144px; }
.ui-icon-bullet { background-position: -80px -144px; }
.ui-icon-radio-on { background-position: -96px -144px; }
.ui-icon-radio-off { background-position: -112px -144px; }
.ui-icon-pin-w { background-position: -128px -144px; }
.ui-icon-pin-s { background-position: -144px -144px; }
.ui-icon-play { background-position: 0 -160px; }
.ui-icon-pause { background-position: -16px -160px; }
.ui-icon-seek-next { background-position: -32px -160px; }
.ui-icon-seek-prev { background-position: -48px -160px; }
.ui-icon-seek-end { background-position: -64px -160px; }
.ui-icon-seek-start { background-position: -80px -160px; }
/* ui-icon-seek-first is deprecated, use ui-icon-seek-start instead */
.ui-icon-seek-first { background-position: -80px -160px; }
.ui-icon-stop { background-position: -96px -160px; }
.ui-icon-eject { background-position: -112px -160px; }
.ui-icon-volume-off { background-position: -128px -160px; }
.ui-icon-volume-on { background-position: -144px -160px; }
.ui-icon-power { background-position: 0 -176px; }
.ui-icon-signal-diag { background-position: -16px -176px; }
.ui-icon-signal { background-position: -32px -176px; }
.ui-icon-battery-0 { background-position: -48px -176px; }
.ui-icon-battery-1 { background-position: -64px -176px; }
.ui-icon-battery-2 { background-position: -80px -176px; }
.ui-icon-battery-3 { background-position: -96px -176px; }
.ui-icon-circle-plus { background-position: 0 -192px; }
.ui-icon-circle-minus { background-position: -16px -192px; }
.ui-icon-circle-close { background-position: -32px -192px; }
.ui-icon-circle-triangle-e { background-position: -48px -192px; }
.ui-icon-circle-triangle-s { background-position: -64px -192px; }
.ui-icon-circle-triangle-w { background-position: -80px -192px; }
.ui-icon-circle-triangle-n { background-position: -96px -192px; }
.ui-icon-circle-arrow-e { background-position: -112px -192px; }
.ui-icon-circle-arrow-s { background-position: -128px -192px; }
.ui-icon-circle-arrow-w { background-position: -144px -192px; }
.ui-icon-circle-arrow-n { background-position: -160px -192px; }
.ui-icon-circle-zoomin { background-position: -176px -192px; }
.ui-icon-circle-zoomout { background-position: -192px -192px; }
.ui-icon-circle-check { background-position: -208px -192px; }
.ui-icon-circlesmall-plus { background-position: 0 -208px; }
.ui-icon-circlesmall-minus { background-position: -16px -208px; }
.ui-icon-circlesmall-close { background-position: -32px -208px; }
.ui-icon-squaresmall-plus { background-position: -48px -208px; }
.ui-icon-squaresmall-minus { background-position: -64px -208px; }
.ui-icon-squaresmall-close { background-position: -80px -208px; }
.ui-icon-grip-dotted-vertical { background-position: 0 -224px; }
.ui-icon-grip-dotted-horizontal { background-position: -16px -224px; }
.ui-icon-grip-solid-vertical { background-position: -32px -224px; }
.ui-icon-grip-solid-horizontal { background-position: -48px -224px; }
.ui-icon-gripsmall-diagonal-se { background-position: -64px -224px; }
.ui-icon-grip-diagonal-se { background-position: -80px -224px; }


/* Misc visuals
----------------------------------*/

/* Corner radius */
.ui-corner-all,
.ui-corner-top,
.ui-corner-left,
.ui-corner-tl {
	border-top-left-radius: 4px;
}
.ui-corner-all,
.ui-corner-top,
.ui-corner-right,
.ui-corner-tr {
	border-top-right-radius: 4px;
}
.ui-corner-all,
.ui-corner-bottom,
.ui-corner-left,
.ui-corner-bl {
	border-bottom-left-radius: 4px;
}
.ui-corner-all,
.ui-corner-bottom,
.ui-corner-right,
.ui-corner-br {
	border-bottom-right-radius: 4px;
}

/* Overlays */
.ui-widget-overlay {
	background: #aaaaaa url("images/ui-bg_flat_0_aaaaaa_40x100.png") 50% 50% repeat-x;
	opacity: .3;
	filter: Alpha(Opacity=30); /* support: IE8 */
}
.ui-widget-shadow {
	margin: -8px 0 0 -8px;
	padding: 8px;
	background: #aaaaaa url("images/ui-bg_flat_0_aaaaaa_40x100.png") 50% 50% repeat-x;
	opacity: .3;
	filter: Alpha(Opacity=30); /* support: IE8 */
	border-radius: 8px;
}

@charset "UTF-8";
/* ----------------------------------------------------------------------------------
 * Compass Imports
 */
/* ----------------------------------------------------------------------------------
 * Variables
 */
/* Main font size */
/* General values */
/* Content Block sizes */
/* Main colors */
/* General values */
/* ----------------------------------------------------------------------------------
 * Media Queries Variables
 */
/* ----------------------------------------------------------------------------------
 * Functions
 */
/* Convert px to em, based on $font-size */
/* ----------------------------------------------------------------------------------
 * Mixins
 */
/* Generated by Font Squirrel (http://www.fontsquirrel.com) on October 14, 2014 */
/* @import must be at top of file, otherwise CSS will not work */
/*@font-face {font-family: 'ProximaNovaA-BoldIt';src: url('../fonts/3130A0_0_0.eot');src: url('../fonts/3130A0_0_0.eot?#iefix') format('embedded-opentype'),url('../fonts/3130A0_0_0.woff2') format('woff2'),url('../fonts/3130A0_0_0.woff') format('woff'),url('../fonts/3130A0_0_0.ttf') format('truetype');}
  
@font-face {font-family: 'ProximaNovaS-BoldIt';src: url('../fonts/3130A0_1_0.eot');src: url('../fonts/3130A0_1_0.eot?#iefix') format('embedded-opentype'),url('../fonts/3130A0_1_0.woff2') format('woff2'),url('../fonts/3130A0_1_0.woff') format('woff'),url('../fonts/3130A0_1_0.ttf') format('truetype');}
 
  
@font-face {font-family: 'ProximaNova-BoldIt';src: url('../fonts/3130A0_2_0.eot');src: url('../fonts/3130A0_2_0.eot?#iefix') format('embedded-opentype'),url('../fonts/3130A0_2_0.woff2') format('woff2'),url('../fonts/3130A0_2_0.woff') format('woff'),url('../fonts/3130A0_2_0.ttf') format('truetype');}
 */
@font-face {
  font-family: 'ProximaNovaA-Bold';
  src: url("../fonts/3130A0_3_0.eot");
  src: url("../fonts/3130A0_3_0.eot?#iefix") format("embedded-opentype"), url("../fonts/3130A0_3_0.woff2") format("woff2"), url("../fonts/3130A0_3_0.woff") format("woff"), url("../fonts/3130A0_3_0.ttf") format("truetype");
}
/*@font-face {font-family: 'ProximaNovaS-Bold';src: url('../fonts/3130A0_4_0.eot');src: url('../fonts/3130A0_4_0.eot?#iefix') format('embedded-opentype'),url('../fonts/3130A0_4_0.woff2') format('woff2'),url('../fonts/3130A0_4_0.woff') format('woff'),url('../fonts/3130A0_4_0.ttf') format('truetype');}
 
  
@font-face {font-family: 'ProximaNova-Bold';src: url('../fonts/3130A0_5_0.eot');src: url('../fonts/3130A0_5_0.eot?#iefix') format('embedded-opentype'),url('../fonts/3130A0_5_0.woff2') format('woff2'),url('../fonts/3130A0_5_0.woff') format('woff'),url('../fonts/3130A0_5_0.ttf') format('truetype');}
*/
@font-face {
  font-family: 'ProximaNovaA-Regular';
  src: url("../fonts/3130A0_6_0.eot");
  src: url("../ProximaNovaA.otf");
  src: url("../fonts/3130A0_6_0.eot?#iefix") format("embedded-opentype"), url("../fonts/3130A0_6_0.woff2") format("woff2"), url("../fonts/3130A0_6_0.woff") format("woff"), url("../fonts/3130A0_6_0.ttf") format("truetype");
}
@font-face {
  font-family: 'ProximaNova-Regular';
  src: url("../fonts/3130A0_8_0.eot");
  src: url("../fonts/3130A0_8_0.eot?#iefix") format("embedded-opentype"), url("../fonts/3130A0_8_0.woff2") format("woff2"), url("../fonts/3130A0_8_0.woff") format("woff"), url("../fonts/3130A0_8_0.ttf") format("truetype");
}
/*@font-face {font-family: 'ProximaNovaS-Regular';src: url('../fonts/3130A0_7_0.eot');src: url('../fonts/3130A0_7_0.eot?#iefix') format('embedded-opentype'),url('../fonts/3130A0_7_0.woff2') format('woff2'),url('../fonts/3130A0_7_0.woff') format('woff'),url('../fonts/3130A0_7_0.ttf') format('truetype');}
 
  
 
  
@font-face {font-family: 'ProximaNovaA-RegularIt';src: url('../fonts/3130A0_9_0.eot');src: url('../fonts/3130A0_9_0.eot?#iefix') format('embedded-opentype'),url('../fonts/3130A0_9_0.woff2') format('woff2'),url('../fonts/3130A0_9_0.woff') format('woff'),url('../fonts/3130A0_9_0.ttf') format('truetype');}
 
  
@font-face {font-family: 'ProximaNovaS-RegularIt';src: url('../fonts/3130A0_A_0.eot');src: url('../fonts/3130A0_A_0.eot?#iefix') format('embedded-opentype'),url('../fonts/3130A0_A_0.woff2') format('woff2'),url('../fonts/3130A0_A_0.woff') format('woff'),url('../fonts/3130A0_A_0.ttf') format('truetype');}
 
  
@font-face {font-family: 'ProximaNova-RegularIt';src: url('../fonts/3130A0_B_0.eot');src: url('../fonts/3130A0_B_0.eot?#iefix') format('embedded-opentype'),url('../fonts/3130A0_B_0.woff2') format('woff2'),url('../fonts/3130A0_B_0.woff') format('woff'),url('../fonts/3130A0_B_0.ttf') format('truetype');}
*/
/*.ProximaNovaA-BoldIt { 
	font-family: ProximaNovaA-BoldIt;
	font-weight: normal;
	font-style: normal;
}
.ProximaNovaS-BoldIt { 
	font-family: ProximaNovaS-BoldIt;
	font-weight: normal;
	font-style: normal;
}
.ProximaNova-BoldIt { 
	font-family: ProximaNova-BoldIt;
	font-weight: normal;
	font-style: normal;
}*/
.ProximaNovaA-Bold {
  font-family: ProximaNovaA-Bold;
  font-weight: normal;
  font-style: normal;
}

/*.ProximaNovaS-Bold { 
	font-family: ProximaNovaS-Bold;
	font-weight: normal;
	font-style: normal;
}
.ProximaNova-Bold { 
	font-family: ProximaNova-Bold;
	font-weight: normal;
	font-style: normal;
}*/
.ProximaNovaA-Regular {
  font-family: ProximaNovaA-Regular;
  font-weight: normal;
  font-style: normal;
}

.ProximaNova-Regular {
  font-family: ProximaNova-Regular;
  font-weight: normal;
  font-style: normal;
}

/*.ProximaNovaS-Regular { 
	font-family: ProximaNovaS-Regular;
	font-weight: normal;
	font-style: normal;
}
.ProximaNovaA-RegularIt { 
	font-family: ProximaNovaA-RegularIt;
	font-weight: normal;
	font-style: normal;
}
.ProximaNovaS-RegularIt { 
	font-family: ProximaNovaS-RegularIt;
	font-weight: normal;
	font-style: normal;
}
.ProximaNova-RegularIt { 
	font-family: ProximaNova-RegularIt;
	font-weight: normal;
	font-style: normal;
}*/
/*@font-face {
    font-family: 'pf_handbook_proregular';
    src: url('../fonts/pfhandbookpro-regular-webfont.eot');
    src: url('../fonts/pfhandbookpro-regular-webfont.eot?#iefix') format('embedded-opentype'),
    url('../fonts/pfhandbookpro-regular-webfont.woff2') format('woff2'),
    url('../fonts/pfhandbookpro-regular-webfont.woff') format('woff'),
    url('../fonts/pfhandbookpro-regular-webfont.ttf') format('truetype'),
    url('../fonts/pfhandbookpro-regular-webfont.svg#pf_handbook_proregular') format('svg');
    font-weight: normal;
    font-style: normal;

}




@font-face {
    font-family: 'pf_handbook_proXThIt';
    src: url('../fonts/pfhandbookpro-extrathinital-webfont.eot');
    src: url('../fonts/pfhandbookpro-extrathinital-webfont.eot?#iefix') format('embedded-opentype'),
    url('../fonts/pfhandbookpro-extrathinital-webfont.woff2') format('woff2'),
    url('../fonts/pfhandbookpro-extrathinital-webfont.woff') format('woff'),
    url('../fonts/pfhandbookpro-extrathinital-webfont.ttf') format('truetype'),
    url('../fonts/pfhandbookpro-extrathinital-webfont.svg#pf_handbook_proXThIt') format('svg');
    font-weight: normal;
    font-style: normal;

}




@font-face {
    font-family: 'pf_handbook_probold';
    src: url('../fonts/pfhandbookpro-bold-webfont.eot');
    src: url('../fonts/pfhandbookpro-bold-webfont.eot?#iefix') format('embedded-opentype'),
    url('../fonts/pfhandbookpro-bold-webfont.woff2') format('woff2'),
    url('../fonts/pfhandbookpro-bold-webfont.woff') format('woff'),
    url('../fonts/pfhandbookpro-bold-webfont.ttf') format('truetype'),
    url('../fonts/pfhandbookpro-bold-webfont.svg#pf_handbook_probold') format('svg');
    font-weight: normal;
    font-style: normal;

}




@font-face {
    font-family: 'pf_handbook_proitalic';
    src: url('../fonts/pfhandbookpro-italic-webfont.eot');
    src: url('../fonts/pfhandbookpro-italic-webfont.eot?#iefix') format('embedded-opentype'),
    url('../fonts/pfhandbookpro-italic-webfont.woff2') format('woff2'),
    url('../fonts/pfhandbookpro-italic-webfont.woff') format('woff'),
    url('../fonts/pfhandbookpro-italic-webfont.ttf') format('truetype'),
    url('../fonts/pfhandbookpro-italic-webfont.svg#pf_handbook_proitalic') format('svg');
    font-weight: normal;
    font-style: normal;

}




@font-face {
    font-family: 'pf_handbook_problack';
    src: url('../fonts/pfhandbookpro-black-webfont.eot');
    src: url('../fonts/pfhandbookpro-black-webfont.eot?#iefix') format('embedded-opentype'),
    url('../fonts/pfhandbookpro-black-webfont.woff2') format('woff2'),
    url('../fonts/pfhandbookpro-black-webfont.woff') format('woff'),
    url('../fonts/pfhandbookpro-black-webfont.ttf') format('truetype'),
    url('../fonts/pfhandbookpro-black-webfont.svg#pf_handbook_problack') format('svg');
    font-weight: normal;
    font-style: normal;

}




@font-face {
    font-family: 'pf_handbook_promedium';
    src: url('../fonts/pfhandbookpro-medium-webfont.eot');
    src: url('../fonts/pfhandbookpro-medium-webfont.eot?#iefix') format('embedded-opentype'),
    url('../fonts/pfhandbookpro-medium-webfont.woff2') format('woff2'),
    url('../fonts/pfhandbookpro-medium-webfont.woff') format('woff'),
    url('../fonts/pfhandbookpro-medium-webfont.ttf') format('truetype'),
    url('../fonts/pfhandbookpro-medium-webfont.svg#pf_handbook_promedium') format('svg');
    font-weight: normal;
    font-style: normal;

}




@font-face {
    font-family: 'pf_handbook_proextra_thin';
    src: url('../fonts/pfhandbookpro-extrathin-webfont.eot');
    src: url('../fonts/pfhandbookpro-extrathin-webfont.eot?#iefix') format('embedded-opentype'),
    url('../fonts/pfhandbookpro-extrathin-webfont.woff2') format('woff2'),
    url('../fonts/pfhandbookpro-extrathin-webfont.woff') format('woff'),
    url('../fonts/pfhandbookpro-extrathin-webfont.ttf') format('truetype'),
    url('../fonts/pfhandbookpro-extrathin-webfont.svg#pf_handbook_proextra_thin') format('svg');
    font-weight: normal;
    font-style: normal;

}




@font-face {
    font-family: 'pf_handbook_probold_italic';
    src: url('../fonts/pfhandbookpro-bolditalic-webfont.eot');
    src: url('../fonts/pfhandbookpro-bolditalic-webfont.eot?#iefix') format('embedded-opentype'),
    url('../fonts/pfhandbookpro-bolditalic-webfont.woff2') format('woff2'),
    url('../fonts/pfhandbookpro-bolditalic-webfont.woff') format('woff'),
    url('../fonts/pfhandbookpro-bolditalic-webfont.ttf') format('truetype'),
    url('../fonts/pfhandbookpro-bolditalic-webfont.svg#pf_handbook_probold_italic') format('svg');
    font-weight: normal;
    font-style: normal;

}




@font-face {
    font-family: 'pf_handbook_prothin';
    src: url('../fonts/pfhandbookpro-thin-webfont.eot');
    src: url('../fonts/pfhandbookpro-thin-webfont.eot?#iefix') format('embedded-opentype'),
    url('../fonts/pfhandbookpro-thin-webfont.woff2') format('woff2'),
    url('../fonts/pfhandbookpro-thin-webfont.woff') format('woff'),
    url('../fonts/pfhandbookpro-thin-webfont.ttf') format('truetype'),
    url('../fonts/pfhandbookpro-thin-webfont.svg#pf_handbook_prothin') format('svg');
    font-weight: normal;
    font-style: normal;

}




@font-face {
    font-family: 'pf_handbook_problack_italic';
    src: url('../fonts/pfhandbookpro-blackitalic-webfont.eot');
    src: url('../fonts/pfhandbookpro-blackitalic-webfont.eot?#iefix') format('embedded-opentype'),
    url('../fonts/pfhandbookpro-blackitalic-webfont.woff2') format('woff2'),
    url('../fonts/pfhandbookpro-blackitalic-webfont.woff') format('woff'),
    url('../fonts/pfhandbookpro-blackitalic-webfont.ttf') format('truetype'),
    url('../fonts/pfhandbookpro-blackitalic-webfont.svg#pf_handbook_problack_italic') format('svg');
    font-weight: normal;
    font-style: normal;

}




@font-face {
    font-family: 'pf_handbook_promedium_italic';
    src: url('../fonts/pfhandbookpro-meditalic-webfont.eot');
    src: url('../fonts/pfhandbookpro-meditalic-webfont.eot?#iefix') format('embedded-opentype'),
    url('../fonts/pfhandbookpro-meditalic-webfont.woff2') format('woff2'),
    url('../fonts/pfhandbookpro-meditalic-webfont.woff') format('woff'),
    url('../fonts/pfhandbookpro-meditalic-webfont.ttf') format('truetype'),
    url('../fonts/pfhandbookpro-meditalic-webfont.svg#pf_handbook_promedium_italic') format('svg');
    font-weight: normal;
    font-style: normal;

}




@font-face {
    font-family: 'pf_handbook_prothin_italic';
    src: url('../fonts/pfhandbookpro-thinitalic-webfont.eot');
    src: url('../fonts/pfhandbookpro-thinitalic-webfont.eot?#iefix') format('embedded-opentype'),
    url('../fonts/pfhandbookpro-thinitalic-webfont.woff2') format('woff2'),
    url('../fonts/pfhandbookpro-thinitalic-webfont.woff') format('woff'),
    url('../fonts/pfhandbookpro-thinitalic-webfont.ttf') format('truetype'),
    url('../fonts/pfhandbookpro-thinitalic-webfont.svg#pf_handbook_prothin_italic') format('svg');
    font-weight: normal;
    font-style: normal;

}*/
body {
  background-color: white;
  color: #656565;
  font-family: "ProximaNovaA-Regular";
  font-size: 16px;
}

/* body */
a {
  text-decoration: none;
}

/* a */
p {
  margin-top: 0;
}

strong {
  font-family: "ProximaNovaA-Bold";
  font-weight: normal;
}

h1, h2, h3, h4, h5, h6 {
  font-family: "ProximaNovaA-Regular";
  font-weight: normal;
}

.content-block {
  margin: 0 auto;
  position: relative;
  /* from-tablet */
  /* from-small-desktop */
  /* large-desktop */
}
@media screen and (min-width: 768px) {
  .content-block {
    width: 768px;
  }
}
@media screen and (min-width: 1024px) {
  .content-block {
    width: 1004px;
  }
}
@media screen and (min-width: 1280px) {
  .content-block {
    width: 1260px;
  }
}

/* .content-block */
.container {
  padding: 0 0.9375em;
  /* on-tablet */
  /* on-small-desktop */
}
@media screen and (min-width: 768px) {
  .container {
    padding: 0 1.25em;
  }
}
@media screen and (min-width: 1024px) {
  .container {
    padding: 0 0.625em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .container.more-space {
    margin: 0 5em;
  }
}
@media screen and (min-width: 1280px) {
  .container.more-space {
    margin: 0 9.375em;
  }
}

/* .container */
.mobile-show {
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  .mobile-show {
    display: none !important;
    visibility: hidden !important;
  }
}

/* mobile-show */
.mobile-hide {
  /* mobile */
}
@media screen and (max-width: 767px) {
  .mobile-hide {
    display: none !important;
    visibility: hidden !important;
  }
}

/* mobile-hide */
@media screen and (min-width: 1024px) {
  .tablet-show {
    display: none !important;
    visibility: hidden !important;
  }
}

@media screen and (min-width: 768px) and (max-width: 1023px) {
  .tablet-hide {
    display: none !important;
    visibility: hidden !important;
  }
}

@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .desktop-hide {
    display: none !important;
    visibility: hidden !important;
  }
}

.under-header {
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  .under-header {
    padding-top: 12.5em;
  }
}

/* .under-header */
/* ----------------------------------------------------------------------------------
 * Titles
 */
.page-title {
  color: white;
  font-size: 1.5625em;
  font-weight: normal;
  margin-top: .5em;
  color: #ff4801;
}
@media screen and (min-width: 768px) {
  .page-title {
    text-shadow: 1px 1px 0 rgba(0, 0, 0, 0.4);
    color: white;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .page-title {
    font-size: 3.125em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .page-title {
    font-size: 3.75em;
  }
}
@media screen and (min-width: 1280px) {
  .page-title {
    font-size: 4.0625em;
  }
}
.page-title.page-title-type2 {
  color: #ff4801;
}
.page-title.page-title-with-subtitle {
  margin-bottom: 0;
}

.page-subtitle {
  color: #656565;
  /*font-family: 'pf_handbook_prothin';*/
  font-size: 1.25em;
  margin: 0;
}
@media screen and (min-width: 1024px) {
  .page-subtitle {
    font-size: 1.625em;
  }
}

.title-features {
  font-size: 1.875em;
  /*font-family: "pf_handbook_proregular";*/
  margin: 0;
  padding: .8em 0;
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  .title-features {
    font-size: 3.125em;
    text-align: center;
  }
}

.title-features-lite {
  font-size: 2.5em;
  color: white;
  /*font-family: "pf_handbook_prothin";*/
  margin: 0;
}
@media screen and (min-width: 1024px) {
  .title-features-lite {
    font-size: 3.125em;
  }
}

.title-description {
  font-size: 1.125em;
  color: #ff4801;
  margin: 0  0 .8em;
  line-height: 1em;
  /*font-family: "pf_handbook_prothin";*/
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  .title-description {
    font-size: 1.125em;
  }
}
@media screen and (min-width: 1280px) {
  .title-description {
    font-size: 1.875em;
  }
}
.title-description.title-description-line {
  border-bottom: 1px solid #ff4801;
  margin-bottom: .4em;
  padding-bottom: .4em;
}

/* .title-description */
.title-description-sub {
  font-size: 1.5625em;
  margin-top: 0;
}

.title-small {
  margin: .8em 0;
  font-size: 1.5625em;
  color: #ff4801;
  /*font-family: "pf_handbook_prothin";*/
}

.title-share {
  font-size: 1.5625em;
  color: #656565;
  /*font-family: "pf_handbook_proregular";*/
}

.title-bottoms {
  font-size: 2.5em;
  /*font-family: "pf_handbook_proextra_thin";*/
  font-weight: normal;
  color: white;
  text-shadow: 1px 1px 0 rgba(0, 0, 0, 0.5);
}

.subtitle-block {
  font-size: 1.875em;
  margin: .5em 0;
}
@media screen and (min-width: 1024px) {
  .subtitle-block {
    font-size: 2.1875em;
  }
}

/* ----------------------------------------------------------------------------------
 * Misc
 */
.ui-datepicker {
  font-size: .8em;
}
.ui-datepicker .ui-datepicker-title select {
  font-size: .8em;
  margin: 0 3px;
}

.shrink {
  padding: 0 2.5em;
}

.with-vertical-dividers {
  position: relative;
}

.no-margins {
  margin: 0 !important;
}

.big-step, .small-step {
  font-size: 2.75em;
  /*font-family: "pf_handbook_proregular";*/
  line-height: 1.5em;
  text-align: center;
  color: white;
  background: #007573;
  display: inline-block;
  width: 1.5em;
  height: 1.5em;
  border-radius: .75em;
}
@media screen and (min-width: 1024px) {
  .big-step, .small-step {
    font-size: 3.75em;
  }
}

.small-step {
  font-size: 1.875em;
}

.divider {
  height: 0;
  border-bottom: 1px solid #ccc;
  margin: 1px 0;
}
.divider.divider-type2 {
  border-color: #ff4801;
  margin: 20px 0;
}
.divider.divider-white {
  border-color: white;
}

/* .divider */
.divider-vertical {
  height: 80%;
  width: 1px;
  background: #fff;
  position: absolute;
  left: 50%;
  top: 10%;
}
.divider-vertical.divider-vertical-type2 {
  background: #ff4801;
}
.divider-vertical.divider-vertical-by3-one {
  left: 33.33%;
}
.divider-vertical.divider-vertical-by3-two {
  left: 66.66%;
}

.logo-wrapper {
  border: 1px solid #007573;
}

/* .logo-wrapper */
.text-center {
  text-align: center;
}

/* .text-center */
.text-center-spaced {
  text-align: center;
  width: 90%;
  margin: 0 auto;
}
@media screen and (min-width: 1024px) {
  .text-center-spaced {
    width: 60%;
  }
}

.text-justify {
  text-align: justify;
}

.text-left {
  text-align: left;
}

.text-right {
  text-align: right;
}

.text-big {
  font-size: 1.875em;
}

.text-medium {
  font-size: 1.125em;
}

.text-small {
  font-size: 0.9375em;
}

.desktop-right {
  float: right !important;
}

/* .desktop-right */
.pull-left {
  float: left !important;
}

.pull-right {
  float: right !important;
}

.clearfix:before, .clearfix:after {
  content: " ";
  display: table;
}
.clearfix:after {
  clear: both;
}

/* .clearfix */
.photo-wrapper {
  background-position: center center;
}

/* .photo-wrapper */
.features-wrapper {
  background-color: #ff4801;
  color: white;
}

.no-space-on-top {
  margin-top: 0 !important;
}

.no-space-on-bottom {
  margin-bottom: 0 !important;
}

@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .space-on-the-sides {
    padding-left: 2em !important;
    padding-right: 2em !important;
  }
}
@media screen and (min-width: 1280px) {
  .space-on-the-sides {
    padding-left: 6.25em !important;
    padding-right: 6.25em !important;
  }
}

@media screen and (max-width: 767px) {
  .payments-calculator-text {
    text-align: left;
    float: right;
    margin: 1em 1em 0 0;
    font-size: 1.25em;
  }
  .payments-calculator-text span {
    display: block;
  }
}

.list-item {
  margin-bottom: 1.5em;
}
.list-item:before, .list-item:after {
  content: " ";
  display: table;
}
.list-item:after {
  clear: both;
}

.list-item-bullet {
  background-color: #007573;
  color: white;
  vertical-align: top;
  font-size: 1.5625em;
  line-height: 1.4em;
  width: 1.4em;
  text-align: center;
  float: left;
}

.list-item-bullet-big {
  background-color: #007573;
  color: white;
  /*font-family: 'pf_handbook_proregular';*/
  vertical-align: top;
  font-size: 50px;
  line-height: 1.4em;
  width: 1.4em;
  text-align: center;
  float: left;
}

.list-item-content {
  margin-left: 3.125em;
}

.text-bold {
  font-size: 1.25em;
  /*font-family: "pf_handbook_proregular";*/
  font-family: "ProximaNovaA-Bold";
}

.head-block-text {
  width: 55%;
  float: left;
  margin: 0;
  line-height: 1em;
}
.head-block-text.wide {
  width: 75%;
}

.head-block-button {
  float: right;
  margin-top: 1.2em;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .head-block-button {
    margin-top: 1.5em;
  }
}
@media screen and (min-width: 1280px) {
  .head-block-button {
    margin-top: .5em;
  }
}

.backdrop-type-1 {
  background-color: #ffb69a;
  color: white;
}

/* ----------------------------------------------------------------------------------
 * Buttons
 */
.btn {
  border: 0;
  display: inline-block;
  margin: 0;
  padding: 0;
  text-transform: uppercase;
  /*font-family: "pf_handbook_proregular";*/
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  font-size: 14px;
  line-height: 3.125em;
}
.btn:disabled {
  background-color: #888 !important;
  color: white !important;
}

.btn-type-1 {
  background-color: #ff4801;
  color: white;
  padding: 0 3.75em;
}
@media screen and (min-width: 1024px) {
  .btn-type-1:hover {
    background-color: #ff9167;
  }
}

.btn-type-2 {
  background-color: white;
  border: 1px solid #007573;
  color: #007573;
  width: 100%;
  text-align: center;
}
@media screen and (min-width: 1024px) {
  .btn-type-2:hover {
    background-color: #007573;
    color: white;
  }
}

.btn-type-3 {
  background-color: #ff4801;
  color: white;
  padding: 0 2.1875em;
}
@media screen and (min-width: 1024px) {
  .btn-type-3:hover {
    background-color: #ff9167;
    color: #043b42;
  }
}

.btn-type-4 {
  background-color: #2bcfa3;
  color: white;
  padding: 0 2.1875em;
}
@media screen and (min-width: 1024px) {
  .btn-type-4:hover {
    background-color: white;
    color: #007573;
  }
}

.btn-type-5 {
  background-color: #ff4801;
  border: 1px solid white;
  color: white;
  padding: 0 2.1875em;
}
@media screen and (min-width: 1024px) {
  .btn-type-5:hover {
    background-color: white;
    color: #ff4801;
  }
}

.btn-type-6 {
  background-color: #007573;
  border: 1px solid white;
  color: white;
  padding: 0 2.1875em;
}
@media screen and (min-width: 1024px) {
  .btn-type-6:hover {
    background-color: white;
    color: #007573;
  }
}

.btn-type-7 {
  background-color: transparent;
  border: 1px solid white;
  color: white;
  padding: 0 2.1875em;
}
@media screen and (min-width: 1024px) {
  .btn-type-7:hover {
    background-color: white;
    color: #007573;
  }
}

.btn-type-8 {
  background-color: #007573;
  border: 1px solid #007573;
  color: white;
  padding: 0 2.1875em;
}
@media screen and (min-width: 1024px) {
  .btn-type-8:hover {
    background-color: #ffffff;
    color: #007573;
  }
}

/* ----------------------------------------------------------------------------------
 * Blocks
 */
.block-type1 {
  background-color: #007573;
  border-bottom: 3px solid #002928;
  color: white;
  padding: 1em .5em;
  margin: 1.5em 0;
}
.block-type1:before, .block-type1:after {
  content: " ";
  display: table;
}
.block-type1:after {
  clear: both;
}
.block-type1.more-spaced {
  padding: 3em 1.5em;
}
.block-type1 a {
  color: white;
}
@media screen and (min-width: 1024px) {
  .block-type1 a:hover {
    text-decoration: underline;
  }
}
.block-type1 h2 {
  margin-top: 0;
  font-size: 1.375em;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .block-type1 h2 {
    font-size: 1.875em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .block-type1 h2 {
    font-size: 2em;
  }
}
@media screen and (min-width: 1280px) {
  .block-type1 h2 {
    font-size: 2.1875em;
  }
}
.block-type1 ul {
  float: left;
  margin: 0;
  font-size: 1em;
  width: 50%;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  padding-left: 15px;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .block-type1 ul {
    float: none;
    width: auto;
  }
}
@media screen and (min-width: 768px) {
  .block-type1 ul {
    font-size: 16px;
  }
}
.block-type1 .label {
  color: #007573;
  /*font-family: "pf_handbook_proregular";*/
  margin-top: .8em;
}
@media screen and (min-width: 768px) {
  .block-type1 .label {
    font-size: 1.25em;
  }
}

.block-type2 {
  background-color: #ff4801;
  border-bottom: 3px solid #b43200;
  color: white;
  padding: 1em .5em;
  margin: 1.5em 0;
}
.block-type2:before, .block-type2:after {
  content: " ";
  display: table;
}
.block-type2:after {
  clear: both;
}
.block-type2.more-spaced {
  padding: 3em 1.5em;
}
.block-type2 a {
  color: white;
}
@media screen and (min-width: 1024px) {
  .block-type2 a:hover {
    text-decoration: underline;
  }
}
.block-type2 h2 {
  margin-top: 0;
  font-size: 1.375em;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .block-type2 h2 {
    font-size: 1.875em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .block-type2 h2 {
    font-size: 2em;
  }
}
@media screen and (min-width: 1280px) {
  .block-type2 h2 {
    font-size: 2.1875em;
  }
}
.block-type2 ul {
  float: left;
  margin: 0;
  font-size: 1em;
  width: 50%;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  padding-left: 15px;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .block-type2 ul {
    float: none;
    width: auto;
  }
}
@media screen and (min-width: 768px) {
  .block-type2 ul {
    font-size: 16px;
  }
}
.block-type2.block-type2-head {
  font-size: 1.125em;
  padding: 1.08696em;
}
@media screen and (min-width: 1024px) {
  .block-type2.block-type2-head {
    padding: 0.76667em 1em;
    font-size: 1.375em;
  }
}
.block-type2.block-type2-head.aqua {
  background-color: #2bcfa3;
  border-bottom: 3px solid #007573;
}
.block-type2.color-change {
  background-color: #007573;
}

.block-type3 {
  background-color: #007573;
  border-bottom: 3px solid #38a5b3;
  color: white;
  padding: 1em .5em;
  margin: 1.5em 0;
}
.block-type3:before, .block-type3:after {
  content: " ";
  display: table;
}
.block-type3:after {
  clear: both;
}
.block-type3.more-spaced {
  padding: 3em 1.5em;
}
.block-type3 a {
  color: white;
}
@media screen and (min-width: 1024px) {
  .block-type3 a:hover {
    text-decoration: underline;
  }
}
.block-type3 h2 {
  margin-top: 0;
  font-size: 1.375em;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .block-type3 h2 {
    font-size: 1.875em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .block-type3 h2 {
    font-size: 2em;
  }
}
@media screen and (min-width: 1280px) {
  .block-type3 h2 {
    font-size: 2.1875em;
  }
}
.block-type3 ul {
  float: left;
  margin: 0;
  font-size: 1em;
  width: 50%;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  padding-left: 15px;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .block-type3 ul {
    float: none;
    width: auto;
  }
}
@media screen and (min-width: 768px) {
  .block-type3 ul {
    font-size: 16px;
  }
}
.block-type3 .label-help {
  color: #007573;
}
.block-type3 .subtitle-block {
  color: #2bcfa3;
}

.block-mosaic-wrapper {
  padding: 0;
  position: relative;
}

.block-mosaic {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  border: 1px solid #007573;
  width: 50%;
  float: left;
  border-width: 1px 0 0 1px;
  padding: 1.5em;
}
.block-mosaic:first-child {
  border-left: none;
}

.block-mosaic-row:first-child:before, .block-mosaic-row:first-child:after {
  content: " ";
  display: table;
}
.block-mosaic-row:first-child:after {
  clear: both;
}
.block-mosaic-row:first-child .block-mosaic {
  border-top: none;
}

/* ----------------------------------------------------------------------------------
 * Forms
 */
.label-help {
  font-size: 0.9375em;
}
@media screen and (min-width: 768px) {
  .label-help {
    font-size: 1.125em;
    /*font-family: "pf_handbook_prothin";*/
  }
}

.form-control {
  background: white;
  border: 1px solid #c8c8c8;
  color: #656565;
  font-size: 0.9375em;
  line-height: 2.42857em;
  height: 2.42857em;
  margin: 0;
  padding: 0 .5em;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}
@media screen and (min-width: 768px) {
  .form-control {
    color: #333;
    font-size: 17px;
  }
}
.form-control[disabled="disabled"], .form-control:disabled {
  background-color: #c8c8c8;
  color: #656565;
}

.form-vertical .label-help {
  display: block;
  margin: .5em 0;
}
.form-vertical .form-control {
  display: block;
  width: 100%;
  margin: 0.5em 0;
}

.form-group {
  padding-bottom: .5em;
}

label .required {
  color: #ff4801;
}

/* ----------------------------------------------------------------------------------
 * Contact Tools
 */
.contact-tools-tool {
  height: 14.375em;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .contact-tools-tool .btn-multiline {
    line-height: 1.5625em;
  }
  .contact-tools-tool .btn-multiline span {
    display: block;
  }
}

.contact-tools-icon {
  margin: 2em 0;
}

.contact-tools-phone {
  font-size: 2.8125em;
  color: #007573;
  line-height: 1.11111em;
}
@media screen and (max-width: 767px) {
  .contact-tools-phone {
    font-size: 1.125em;
    line-height: normal;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .contact-tools-phone {
    font-size: 1.25em;
    line-height: 1.66667em;
  }
}
@media screen and (min-width: 1280px) {
  .contact-tools-phone {
    font-size: 1.875em;
    line-height: 1.25em;
  }
}

.contact-tools-mobile-tool {
  margin-bottom: 2em;
}
.contact-tools-mobile-tool:before, .contact-tools-mobile-tool:after {
  content: " ";
  display: table;
}
.contact-tools-mobile-tool:after {
  clear: both;
}
.contact-tools-mobile-tool .contact-tools-icon {
  float: left;
  width: 35%;
  margin: 0;
}
.contact-tools-mobile-tool .contact-tools-text {
  float: left;
  width: 65%;
}
.contact-tools-mobile-tool .btn-multiline {
  line-height: 1.5625em;
}
.contact-tools-mobile-tool .btn-multiline span {
  display: block;
}

.contact-tools-mobile-title {
  font-size: 1.5625em;
  color: #ff4801;
  margin: 0 0 .2em 0;
}

.contact-tools-mobile-text {
  font-size: 1.25em;
}

.contact-tools-mobile-subtitle {
  font-size: 1.25em;
  color: #ff4801;
  /*font-family: "pf_handbook_proregular";*/
  margin-bottom: .5em;
}

.contact-tools-mobile-lada {
  font-size: 1.25em;
  /*font-family: "pf_handbook_proregular";*/
  color: #007573;
  margin-top: 1em;
}

/* ----------------------------------------------------------------------------------
 * Tables
 */
.table {
  width: 100%;
}
.table tbody tr:nth-child(odd) {
  background-color: #e5f4f6;
}
.table th {
  color: #ff4801;
  padding: .5em 0;
  /*font-family: "pf_handbook_proregular";*/
  font-weight: normal;
}
.table td {
  padding: .2em 0;
}

@media screen and (min-width: 768px) and (max-width: 1023px) {
  .ts-large {
    font-size: 18px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .ts-large {
    font-size: 22px;
  }
}
@media screen and (min-width: 1280px) {
  .ts-large {
    font-size: 28px;
  }
}

.ts-xlarge {
  font-size: 35px;
}

.sprite {
  background-image: url('../images/sprites-s42472133bc.png');
  background-size: 202px 9610px;
  display: inline-block;
  overflow: hidden;
  text-indent: 100%;
  white-space: nowrap;
  vertical-align: middle;
}

/* .sprite */
.sprite-acreditaciones-y-convenios {
  width: 83px;
  height: 82px;
  background-position: 0 0;
}

.sprite-badge-star {
  width: 121px;
  height: 121px;
  background-position: 0 -84px;
}

.sprite-btn-agreements {
  width: 200px;
  height: 50px;
  background-position: 0 -259px;
}

.sprite-btn-alert-close {
  width: 36px;
  height: 36px;
  background-position: 0 -349px;
}

.sprite-btn-more {
  width: 200px;
  height: 50px;
  background-position: 0 -439px;
}

.sprite-btn-savings {
  width: 115px;
  height: 115px;
  background-position: 0 -608px;
}

.sprite-calculadora-aqua {
  width: 115px;
  height: 115px;
  background-position: 0 -842px;
}

.sprite-calculadora-logo {
  width: 82px;
  height: 81px;
  background-position: 0 -1076px;
}

.sprite-calculadora {
  width: 115px;
  height: 115px;
  background-position: 0 -1159px;
}

.sprite-career-mode-ejecutiva-logo {
  width: 111px;
  height: 111px;
  background-position: 0 -1391px;
}

.sprite-career-mode-ejecutiva-white {
  width: 111px;
  height: 111px;
  background-position: 0 -1504px;
}

.sprite-career-mode-ejecutiva {
  width: 81px;
  height: 113px;
  background-position: 0 -1617px;
}

.sprite-career-mode-online-aqua {
  width: 111px;
  height: 111px;
  background-position: 0 -1732px;
}

.sprite-career-mode-online-logo {
  width: 111px;
  height: 111px;
  background-position: 0 -1960px;
}

.sprite-career-mode-online-white {
  width: 111px;
  height: 111px;
  background-position: 0 -2073px;
}

.sprite-career-mode-online {
  width: 81px;
  height: 113px;
  background-position: 0 -2186px;
}

.sprite-career-mode-presencial-logo {
  width: 111px;
  height: 111px;
  background-position: 0 -2416px;
}

.sprite-career-mode-presencial-white {
  width: 111px;
  height: 111px;
  background-position: 0 -2529px;
}

.sprite-career-mode-presencial {
  width: 81px;
  height: 113px;
  background-position: 0 -2642px;
}

.sprite-check {
  width: 82px;
  height: 82px;
  background-position: 0 -2757px;
}

.sprite-circle-at {
  width: 94px;
  height: 94px;
  background-position: 0 -2841px;
}

.sprite-circle-campus {
  width: 94px;
  height: 94px;
  background-position: 0 -2937px;
}

.sprite-circle-chat {
  width: 94px;
  height: 94px;
  background-position: 0 -3033px;
}

.sprite-circle-phone-contact-white {
  width: 71px;
  height: 71px;
  background-position: 0 -3129px;
}

.sprite-circle-phone-contact {
  width: 94px;
  height: 94px;
  background-position: 0 -3202px;
}

.sprite-circle-phone {
  width: 94px;
  height: 94px;
  background-position: 0 -3298px;
}

.sprite-companies {
  width: 82px;
  height: 79px;
  background-position: 0 -3394px;
}

.sprite-consultancy {
  width: 79px;
  height: 69px;
  background-position: 0 -3475px;
}

.sprite-coordination {
  width: 80px;
  height: 92px;
  background-position: 0 -3546px;
}

.sprite-cuerpo-academico {
  width: 83px;
  height: 82px;
  background-position: 0 -3640px;
}

.sprite-degree-career-mode-ejecutiva {
  width: 102px;
  height: 102px;
  background-position: 0 -3724px;
}

.sprite-degree-career-mode-online {
  width: 102px;
  height: 102px;
  background-position: 0 -3828px;
}

.sprite-degree-career-mode-presencial {
  width: 102px;
  height: 102px;
  background-position: 0 -3932px;
}

.sprite-document {
  width: 78px;
  height: 90px;
  background-position: 0 -4036px;
}

.sprite-document2 {
  width: 77px;
  height: 77px;
  background-position: 0 -4128px;
}

.sprite-dropdown-arrow {
  width: 30px;
  height: 30px;
  background-position: 0 -4207px;
}

.sprite-exchanges {
  width: 88px;
  height: 88px;
  background-position: 0 -4239px;
}

.sprite-exchanges2 {
  width: 82px;
  height: 82px;
  background-position: 0 -4329px;
}

.sprite-faq {
  width: 116px;
  height: 116px;
  background-position: 0 -4413px;
}

.sprite-filosofia-icon {
  width: 66px;
  height: 66px;
  background-position: 0 -4531px;
}

.sprite-filosofia {
  width: 82px;
  height: 82px;
  background-position: 0 -4599px;
}

.sprite-footer-facebook-aqua {
  width: 42px;
  height: 41px;
  background-position: 0 -4726px;
}

.sprite-footer-facebook {
  width: 41px;
  height: 41px;
  background-position: 0 -4812px;
}

.sprite-footer-foursquare {
  width: 41px;
  height: 41px;
  background-position: 0 -4898px;
}

.sprite-footer-google-aqua {
  width: 42px;
  height: 41px;
  background-position: 0 -4984px;
}

.sprite-footer-google {
  width: 41px;
  height: 41px;
  background-position: 0 -5070px;
}

.sprite-footer-logo-mobile {
  width: 73px;
  height: 111px;
  background-position: 0 -5113px;
}

.sprite-footer-phone {
  width: 38px;
  height: 33px;
  background-position: 0 -5226px;
}

.sprite-footer-twitter-aqua {
  width: 42px;
  height: 41px;
  background-position: 0 -5304px;
}

.sprite-footer-twitter {
  width: 41px;
  height: 41px;
  background-position: 0 -5390px;
}

.sprite-footer-youtube {
  width: 41px;
  height: 41px;
  background-position: 0 -5476px;
}

.sprite-franchises {
  width: 74px;
  height: 65px;
  background-position: 0 -5519px;
}

.sprite-generic-facebook {
  width: 41px;
  height: 41px;
  background-position: 0 -5629px;
}

.sprite-generic-foursquare {
  width: 41px;
  height: 41px;
  background-position: 0 -5715px;
}

.sprite-generic-google {
  width: 41px;
  height: 41px;
  background-position: 0 -5801px;
}

.sprite-generic-twitter {
  width: 41px;
  height: 41px;
  background-position: 0 -5887px;
}

.sprite-generic-youtube {
  width: 41px;
  height: 41px;
  background-position: 0 -5973px;
}

.sprite-government {
  width: 70px;
  height: 70px;
  background-position: 0 -6016px;
}

.sprite-historia {
  width: 83px;
  height: 82px;
  background-position: 0 -6088px;
}

.sprite-history {
  width: 42px;
  height: 68px;
  background-position: 0 -6172px;
}

.sprite-home-features-apoyos {
  width: 81px;
  height: 75px;
  background-position: 0 -6242px;
}

.sprite-home-features-asesoria {
  width: 76px;
  height: 71px;
  background-position: 0 -6319px;
}

.sprite-home-features-cobertura {
  width: 67px;
  height: 67px;
  background-position: 0 -6392px;
}

.sprite-home-features-excelencia {
  width: 81px;
  height: 92px;
  background-position: 0 -6461px;
}

.sprite-home-features-formacion {
  width: 84px;
  height: 58px;
  background-position: 0 -6555px;
}

.sprite-home-features-modalidades {
  width: 80px;
  height: 80px;
  background-position: 0 -6615px;
}

.sprite-home-preinscripcion-step-one-big {
  width: 132px;
  height: 132px;
  background-position: 0 -6697px;
}

.sprite-home-preinscripcion-step-one {
  width: 113px;
  height: 113px;
  background-position: 0 -6831px;
}

.sprite-home-preinscripcion-step-two-big {
  width: 132px;
  height: 132px;
  background-position: 0 -6946px;
}

.sprite-home-preinscripcion-step-two {
  width: 113px;
  height: 113px;
  background-position: 0 -7080px;
}

.sprite-hotel-chains {
  width: 66px;
  height: 71px;
  background-position: 0 -7195px;
}

.sprite-idea {
  width: 90px;
  height: 100px;
  background-position: 0 -7268px;
}

.sprite-ieu-logo-horizontal {
  width: 125px;
  height: 37px;
  background-position: 0 -7370px;
}

.sprite-logo-case {
  width: 61px;
  height: 32px;
  background-position: 0 -7409px;
}

.sprite-logo-cemefi {
  width: 67px;
  height: 42px;
  background-position: 0 -7443px;
}

.sprite-logo-conahec {
  width: 71px;
  height: 53px;
  background-position: 0 -7487px;
}

.sprite-logo-fimpes {
  width: 58px;
  height: 57px;
  background-position: 0 -7542px;
}

.sprite-logo-rvoe {
  width: 161px;
  height: 67px;
  background-position: 0 -7601px;
}

.sprite-logo-sep {
  width: 202px;
  height: 75px;
  background-position: 0 -7670px;
}

.sprite-logo-universia {
  width: 75px;
  height: 19px;
  background-position: 0 -7747px;
}

.sprite-navbar-close-dropdown {
  width: 50px;
  height: 65px;
  background-position: 0 -7768px;
}

.sprite-navbar-facebook {
  width: 53px;
  height: 28px;
  background-position: 0 -7865px;
}

.sprite-navbar-google-plus {
  width: 53px;
  height: 28px;
  background-position: 0 -7925px;
}

.sprite-navbar-header-toggle-menu {
  width: 51px;
  height: 49px;
  background-position: 0 -8006px;
}

.sprite-navbar-menu-caret {
  width: 8px;
  height: 16px;
  background-position: 0 -8057px;
}

.sprite-navbar-search-submit {
  width: 23px;
  height: 23px;
  background-position: 0 -8075px;
}

.sprite-navbar-twitter {
  width: 53px;
  height: 29px;
  background-position: 0 -8131px;
}

.sprite-navbar-youtube {
  width: 53px;
  height: 29px;
  background-position: 0 -8193px;
}

.sprite-official-validity {
  width: 47px;
  height: 72px;
  background-position: 0 -8224px;
}

.sprite-opiniones {
  width: 83px;
  height: 82px;
  background-position: 0 -8298px;
}

.sprite-phone-contact-submit {
  width: 73px;
  height: 17px;
  background-position: 0 -8401px;
}

.sprite-play-video {
  width: 78px;
  height: 78px;
  background-position: 0 -8500px;
}

.sprite-professional-experiences {
  width: 89px;
  height: 88px;
  background-position: 0 -8580px;
}

.sprite-professional-experiences2 {
  width: 98px;
  height: 86px;
  background-position: 0 -8670px;
}

.sprite-publicity-audio {
  width: 46px;
  height: 40px;
  background-position: 0 -8758px;
}

.sprite-publicity-image {
  width: 50px;
  height: 40px;
  background-position: 0 -8800px;
}

.sprite-publicity-video {
  width: 46px;
  height: 40px;
  background-position: 0 -8842px;
}

.sprite-rvoe-logo {
  width: 183px;
  height: 76px;
  background-position: 0 -8884px;
}

.sprite-rvoe {
  width: 82px;
  height: 82px;
  background-position: 0 -8962px;
}

.sprite-savings {
  width: 101px;
  height: 75px;
  background-position: 0 -9046px;
}

.sprite-staff {
  width: 99px;
  height: 79px;
  background-position: 0 -9123px;
}

.sprite-television-broadcasters {
  width: 71px;
  height: 71px;
  background-position: 0 -9204px;
}

.sprite-testimonials {
  width: 95px;
  height: 66px;
  background-position: 0 -9277px;
}

.sprite-trevels {
  width: 88px;
  height: 88px;
  background-position: 0 -9345px;
}

.sprite-trevels2 {
  width: 79px;
  height: 83px;
  background-position: 0 -9435px;
}

.sprite-volunteering {
  width: 90px;
  height: 90px;
  background-position: 0 -9520px;
}

.sprite-btn-agreements.hover {
  background-position: 0 -207px;
}

.sprite-btn-alert-close.hover {
  background-position: 0 -311px;
}

.sprite-btn-more.hover {
  background-position: 0 -387px;
}

.sprite-btn-savings.hover {
  background-position: 0 -491px;
}

.sprite-calculadora-aqua.hover {
  background-position: 0 -725px;
}

.sprite-calculadora.hover {
  background-position: 0 -959px;
}

.sprite-career-mode-ejecutiva.hover {
  background-position: 0 -1276px;
}

.sprite-career-mode-online.hover {
  background-position: 0 -1845px;
}

.sprite-career-mode-presencial.hover {
  background-position: 0 -2301px;
}

.sprite-footer-facebook-aqua.hover {
  background-position: 0 -4683px;
}

.sprite-footer-facebook.hover {
  background-position: 0 -4769px;
}

.sprite-footer-foursquare.hover {
  background-position: 0 -4855px;
}

.sprite-footer-google-aqua.hover {
  background-position: 0 -4941px;
}

.sprite-footer-google.hover {
  background-position: 0 -5027px;
}

.sprite-footer-twitter-aqua.hover {
  background-position: 0 -5261px;
}

.sprite-footer-twitter.hover {
  background-position: 0 -5347px;
}

.sprite-footer-youtube.hover {
  background-position: 0 -5433px;
}

.sprite-generic-facebook.hover {
  background-position: 0 -5586px;
}

.sprite-generic-foursquare.hover {
  background-position: 0 -5672px;
}

.sprite-generic-google.hover {
  background-position: 0 -5758px;
}

.sprite-generic-twitter.hover {
  background-position: 0 -5844px;
}

.sprite-generic-youtube.hover {
  background-position: 0 -5930px;
}

.sprite-navbar-facebook.hover {
  background-position: 0 -7835px;
}

.sprite-navbar-google-plus.hover {
  background-position: 0 -7895px;
}

.sprite-navbar-header-toggle-menu.hover {
  background-position: 0 -7955px;
}

.sprite-navbar-twitter.hover {
  background-position: 0 -8100px;
}

.sprite-navbar-youtube.hover {
  background-position: 0 -8162px;
}

.sprite-phone-contact-submit.hover {
  background-position: 0 -8382px;
}

.sprite-play-video.hover {
  background-position: 0 -8420px;
}

@media screen and (min-width: 1024px) {
  .sprite-btn-agreements:hover {
    background-position: 0 -207px;
  }

  .sprite-btn-alert-close:hover {
    background-position: 0 -311px;
  }

  .sprite-btn-more:hover {
    background-position: 0 -387px;
  }

  .sprite-btn-savings:hover {
    background-position: 0 -491px;
  }

  .sprite-calculadora-aqua:hover {
    background-position: 0 -725px;
  }

  .sprite-calculadora:hover {
    background-position: 0 -959px;
  }

  .sprite-career-mode-ejecutiva:hover {
    background-position: 0 -1276px;
  }

  .sprite-career-mode-online:hover {
    background-position: 0 -1845px;
  }

  .sprite-career-mode-presencial:hover {
    background-position: 0 -2301px;
  }

  .sprite-footer-facebook-aqua:hover {
    background-position: 0 -4683px;
  }

  .sprite-footer-facebook:hover {
    background-position: 0 -4769px;
  }

  .sprite-footer-foursquare:hover {
    background-position: 0 -4855px;
  }

  .sprite-footer-google-aqua:hover {
    background-position: 0 -4941px;
  }

  .sprite-footer-google:hover {
    background-position: 0 -5027px;
  }

  .sprite-footer-twitter-aqua:hover {
    background-position: 0 -5261px;
  }

  .sprite-footer-twitter:hover {
    background-position: 0 -5347px;
  }

  .sprite-footer-youtube:hover {
    background-position: 0 -5433px;
  }

  .sprite-generic-facebook:hover {
    background-position: 0 -5586px;
  }

  .sprite-generic-foursquare:hover {
    background-position: 0 -5672px;
  }

  .sprite-generic-google:hover {
    background-position: 0 -5758px;
  }

  .sprite-generic-twitter:hover {
    background-position: 0 -5844px;
  }

  .sprite-generic-youtube:hover {
    background-position: 0 -5930px;
  }

  .sprite-navbar-facebook:hover {
    background-position: 0 -7835px;
  }

  .sprite-navbar-google-plus:hover {
    background-position: 0 -7895px;
  }

  .sprite-navbar-header-toggle-menu:hover {
    background-position: 0 -7955px;
  }

  .sprite-navbar-twitter:hover {
    background-position: 0 -8100px;
  }

  .sprite-navbar-youtube:hover {
    background-position: 0 -8162px;
  }

  .sprite-phone-contact-submit:hover {
    background-position: 0 -8382px;
  }

  .sprite-play-video:hover {
    background-position: 0 -8420px;
  }
}
/* from-small-desktop */
/*
 * Use this classes for fluid width videos.
 *
 * Example:
 * <div class="embed-video-wrapper">
 *     <iframe class="embed-video" ... ></iframe>
 * </div>
 *
 */
.embed-video-wrapper {
  height: 0;
  position: relative;
  padding-bottom: 60.6%;
}

.embed-video {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

/*
 * Styles for Alerts.
 */
/* ----------------------------------------------------------------------------------
 * Messages box
 */
.message-box {
  border: 1px solid transparent;
  border-radius: 4px;
  margin-bottom: 20px;
  padding: 15px;
}
.message-box.message-box-success {
  background-color: #dff0d8;
  border-color: #d6e9c6;
  color: #3c763d;
}
.message-box.message-box-info {
  background-color: #d9edf7;
  border-color: #bce8f1;
  color: #31708f;
}
.message-box.message-box-warning {
  background-color: #fcf8e3;
  border-color: #faebcc;
  color: #8a6d3b;
}
.message-box.message-box-danger {
  background-color: #f2dede;
  border-color: #ebccd1;
  color: #a94442;
}

.alert-message {
  background-color: white;
  -moz-box-shadow: 0 0 15px rgba(0, 0, 0, 0.85);
  -webkit-box-shadow: 0 0 15px rgba(0, 0, 0, 0.85);
  box-shadow: 0 0 15px rgba(0, 0, 0, 0.85);
  margin-left: -48%;
  left: 50%;
  position: fixed;
  top: 40px;
  width: 96%;
  z-index: 201;
}
@media screen and (min-width: 768px) {
  .alert-message {
    margin-left: -250px;
    top: 100px;
    width: 500px;
  }
}

.alert-message-header {
  background-color: #007573;
  line-height: 70px;
  padding: 0 1em;
  text-align: right;
}

.alert-message-body {
  padding: 1.5em;
  color: #007573;
}

.alert-message-footer {
  padding: 1.5em;
  padding-top: 0;
}

#alert-message-backdrop {
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  z-index: 200;
  background-color: black;
  opacity: 0.7;
}

.alert-message-featured {
  color: #007573;
  font-size: 1.2em;
}

#phone-contact-wrapper {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 201;
  /* mobile */
}
@media screen and (max-width: 767px) {
  #phone-contact-wrapper {
    display: none;
  }
}

/* #phone-contact-wrapper */
#phone-contact {
  background-color: #007573;
  border-color: #ff4801;
  border-style: solid;
  border-width: 0 0.1875em;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  color: white;
  line-height: 50px;
  height: 50px;
}

/* #phone-contact */
#phone-contact-heading {
  display: inline-block;
  line-height: 1em;
  vertical-align: middle;
  /* on-large-desktop */
}
@media screen and (min-width: 1280px) {
  #phone-contact-heading {
    vertical-align: baseline;
  }
}

/* #phone-contact-heading */
#phone-contact-title {
  color: #2bcfa3;
  display: block;
  text-transform: uppercase;
  font-size: 0.75em;
  /* on-small-desktop */
  /* on-large-desktop */
}
@media screen and (min-width: 1024px) {
  #phone-contact-title {
    font-size: 0.875em;
  }
}
@media screen and (min-width: 1280px) {
  #phone-contact-title {
    display: inline;
  }
}

/* #phone-contact-title */
#phone-contact-subtitle {
  font-size: 0.75em;
  /* on-small-desktop */
  /* on-large-desktop */
}
@media screen and (min-width: 1024px) {
  #phone-contact-subtitle {
    font-size: 0.875em;
  }
}
@media screen and (min-width: 1280px) {
  #phone-contact-subtitle {
    margin: 0 1.25em;
  }
  .ie8 #phone-contact-subtitle {
    margin: 0 0.625em;
  }
}

/* #phone-contact-subtitle */
#phone-contact-form {
  display: inline-block;
  /* label */
  /* input[type="text"] */
}
#phone-contact-form label {
  margin: 0 0.625em;
  font-size: 0.875em;
  /* on-small-desktop */
}
@media screen and (min-width: 1024px) {
  #phone-contact-form label {
    margin: 0 0.9375em 0 1.875em;
    font-size: 1em;
  }
  .ie8 #phone-contact-form label {
    margin: 0 0.3125em;
  }
}
#phone-contact-form input[type="text"] {
  border: 0;
  color: #333;
  line-height: 2.0625em;
  margin: 0;
  padding: 0 0.625em;
  width: 5em;
  /* on-small-desktop */
}
@media screen and (min-width: 1024px) {
  #phone-contact-form input[type="text"] {
    width: 8.125em;
  }
}

/* #phone-contact-form */
#phone-contact-phone-label {
  display: inline-block;
  line-height: 1em;
  vertical-align: middle;
  /* small */
}
#phone-contact-phone-label small {
  display: block;
  font-size: 0.75em;
}

/* #phone-contact-phone-label */
#phone-contact-submit {
  border: none;
  padding: 0;
  margin-left: 0.75em;
  /* on-small-desktop */
}
@media screen and (min-width: 1024px) {
  #phone-contact-submit {
    margin-left: 3.125em;
  }
}

/* #phone-contact-submit */
.phone-contact-name-wrapper {
  display: inline-block;
  position: relative;
}

.phone-contact-name-tooltip {
  color: white;
  position: absolute;
  top: 110%;
  left: 0;
  line-height: normal;
  background-color: #007573;
  width: 300px;
  text-align: center;
  font-size: 1.2em;
  padding: .5em 0;
  display: none;
}

.phone-contact-name-tooltip-big-text {
  color: #ff9167;
}

.phone-contact-name-tooltip-caret {
  width: 0;
  height: 0;
  border-style: solid;
  font-size: 10px;
  border-width: 0 1em 1em;
  border-color: transparent transparent #007573 transparent;
  position: absolute;
  top: -1em;
  left: 15%;
}

@media screen and (max-width: 767px) {
  #navbar-submenu,
  #navbar-menu-logo,
  #navbar-social-networks,
  .sprite-navbar-menu-caret {
    display: none;
  }

  body.navbar-menu-open {
    /* #navbar-wrapper */
  }
  body.navbar-menu-open #navbar-wrapper {
    height: 26.875em;
  }

  /* body.navbar-menu-open */
  #navbar-wrapper {
    margin-top: 1px;
    position: relative;
    height: 0;
    overflow: hidden;
    -moz-transition: height 250ms ease-out;
    -o-transition: height 250ms ease-out;
    -webkit-transition: height 250ms ease-out;
    transition: height 250ms ease-out;
    /* ul */
    /* .container */
  }
  #navbar-wrapper ul {
    padding: 0;
    margin: 0;
    list-style: none;
  }
  #navbar-wrapper .container {
    padding: 0;
  }

  /* #navbar-wrapper */
  #navbar-mobile-header {
    background-color: #007573;
    height: 49px;
  }

  /* #navbar-mobile-header */
  #navbar-mobile-logo {
    margin: 5px 0 0 15px;
  }

  /* #navbar-mobile-logo */
  #navbar-mobile-toggle-menu {
    position: absolute;
    right: 0;
  }

  /* #navbar-mobile-toggle-menu */
  /* ----------------------------------------------------------------------------------
   * Navbar Menu
   */
  #navbar-menu {
    font-size: 16px;
    /* ul */
    /* > ul > li > a */
    /* a */
    /* > ul */
    /* li.active */
  }
  #navbar-menu ul {
    height: 430px;
    overflow: auto;
  }
  #navbar-menu > ul > li,
  #navbar-menu ul.navbar-dropdown > li {
    border-bottom: 1px solid white;
    /* &:first-child */
    /* > a */
  }
  #navbar-menu > ul > li:last-child,
  #navbar-menu ul.navbar-dropdown > li:last-child {
    border-bottom: none;
  }
  #navbar-menu > ul > li > a,
  #navbar-menu ul.navbar-dropdown > li > a {
    display: block;
    line-height: 3.625em;
    padding-left: 1.6875em;
    text-transform: uppercase;
  }
  #navbar-menu a {
    color: white;
  }
  #navbar-menu > ul {
    background-color: #ff4801;
  }
  #navbar-menu li.active > ul {
    -moz-transform: translate3d(0, 0, 0);
    -ms-transform: translate3d(0, 0, 0);
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
  }

  /* #navbar-menu */
  ul.navbar-dropdown,
  ul.navbar-deep-dropdown {
    padding-left: 3.125em !important;
    position: absolute;
    width: 100%;
    left: 0;
    top: 0;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    -moz-transform: translate3d(-100%, 0, 0);
    -ms-transform: translate3d(-100%, 0, 0);
    -webkit-transform: translate3d(-100%, 0, 0);
    transform: translate3d(-100%, 0, 0);
    -moz-transition: -moz-transform 250ms ease-out;
    -o-transition: -o-transform 250ms ease-out;
    -webkit-transition: -webkit-transform 250ms ease-out;
    transition: transform 250ms ease-out;
  }

  ul.navbar-dropdown {
    background-color: #007573;
  }

  ul.navbar-deep-dropdown {
    background-color: #38a5b3;
    /* a */
  }
  ul.navbar-deep-dropdown a {
    display: block;
    font-size: 1.125em;
    line-height: normal;
    padding: 0.625em 0;
  }

  li.navbar-close-dropdown {
    border-bottom: none !important;
    position: absolute;
    left: 0;
    top: 0;
    height: 100%;
    /* a */
  }
  li.navbar-close-dropdown a {
    padding: 0 !important;
    line-height: normal !important;
    top: 50%;
    margin-top: -50%;
    position: relative;
  }

  /* .navbar-close-dropdown */
  .navbar-subdegree-title {
    color: white;
    border-bottom: 1px solid white;
    padding-left: 0.4375em;
    text-transform: uppercase;
    line-height: 2.8125em;
    margin-bottom: 0.625em;
  }

  /* .navbar-subdegree-title */
}
/* mobile */
@media screen and (min-width: 768px) {
  #navbar-wrapper.scrolled {
    /*
     * Note:
     * The "position" properties are modified within
     * the javascript method: Navbar.setScrollStyle()
     */
    /* .content-block */
    /* #navbar-menu */
    /* #navbar-submenu */
    /* #navbar-social-networks */
    /* #navbar-menu-logo */
  }
  #navbar-wrapper.scrolled .content-block {
    height: 3.75em;
    -moz-box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
    -webkit-box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
  }
  #navbar-wrapper.scrolled #navbar-menu {
    padding-top: 0;
  }
  #navbar-wrapper.scrolled #navbar-submenu {
    height: 0;
  }
  #navbar-wrapper.scrolled #navbar-social-networks {
    height: 0;
  }
  #navbar-wrapper.scrolled #navbar-menu-logo {
    height: 100%;
    top: 0;
  }

  /* #navbar-wrapper.scrolled */
  #navbar-wrapper {
    position: absolute;
    top: 69px;
    left: 0;
    width: 100%;
    z-index: 200;
    /* .content-block */
  }
  #navbar-wrapper .content-block {
    background-color: white;
    height: 7.125em;
    position: relative;
    -moz-transition: height 250ms ease-in;
    -o-transition: height 250ms ease-in;
    -webkit-transition: height 250ms ease-in;
    transition: height 250ms ease-in;
  }
}
@media screen and (min-width: 768px) and (min-width: 768px) and (max-width: 1023px) {
  #navbar-wrapper .container {
    padding: 0 !important;
  }
}

@media screen and (min-width: 768px) {
  /* #navbar-wrapper */
  #navbar-menu-logo {
    position: absolute;
    top: -10px;
    height: 9em;
    display: block;
    -moz-transition: height 250ms ease-in;
    -o-transition: height 250ms ease-in;
    -webkit-transition: height 250ms ease-in;
    transition: height 250ms ease-in;
    /* img */
  }
  #navbar-menu-logo img {
    display: block;
    height: 100%;
  }

  /* #navbar-ieu-logo */
  #navbar-mobile-header {
    display: none;
  }

  /* #navbar-mobile-header */
  /* ----------------------------------------------------------------------------------
   * Navbar Menu
   */
  .navbar-menu {
    margin-left: 158px;
    -moz-transition: padding-top 250ms ease-in;
    -o-transition: padding-top 250ms ease-in;
    -webkit-transition: padding-top 250ms ease-in;
    transition: padding-top 250ms ease-in;
    /* from-small-desktop */
    /* large-desktop */
    /* ul */
    /* a */
  }
}
@media screen and (min-width: 768px) and (min-width: 1024px) {
  .navbar-menu {
    margin-left: 159px;
  }
}
@media screen and (min-width: 768px) and (min-width: 1280px) {
  .navbar-menu {
    margin-left: 177px;
  }
}
@media screen and (min-width: 768px) {
  .navbar-menu ul {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  .navbar-menu a {
    display: block;
    text-transform: uppercase;
  }

  /* .navbar-menu */
  nav#navbar-menu {
    font-size: 1em;
    padding-top: 54px;
    /* tablet */
    /* > ul */
    /* > ul > li */
    /* > ul > li > a */
  }
}
@media screen and (min-width: 768px) and (min-width: 768px) and (max-width: 1023px) {
  nav#navbar-menu {
    font-size: 0.75em;
  }
}
@media screen and (min-width: 768px) {
  nav#navbar-menu > ul:before, nav#navbar-menu > ul:after {
    content: " ";
    display: table;
  }
  nav#navbar-menu > ul:after {
    clear: both;
  }
  nav#navbar-menu > ul > li {
    float: left;
    /* &:hover */
  }
  nav#navbar-menu > ul > li:hover > ul {
    display: block;
  }
  nav#navbar-menu > ul > li:hover > a {
    color: #999999;
  }
  nav#navbar-menu > ul > li > a {
    color: #007573;
    line-height: 60px;
    text-align: center;
  }

  /* #navbar-menu */
  /* ----------------------------------------------------------------------------------
   * Navbar Menu Items
   */
  #navbar-acerca-ieu {
    width: 70px;
    /* small-desktop */
    /* large-desktop */
  }
}
@media screen and (min-width: 768px) and (min-width: 1024px) and (max-width: 1279px) {
  #navbar-acerca-ieu {
    width: 124px;
  }
}
@media screen and (min-width: 768px) and (min-width: 1280px) {
  #navbar-acerca-ieu {
    width: 146px;
  }
}

@media screen and (min-width: 768px) {
  /* #navbar-acerca-ieu */
  #navbar-modalidades {
    width: 102px;
    /* small-desktop */
    /* large-desktop */
  }
}
@media screen and (min-width: 768px) and (min-width: 1024px) and (max-width: 1279px) {
  #navbar-modalidades {
    width: 127px;
  }
}
@media screen and (min-width: 768px) and (min-width: 1280px) {
  #navbar-modalidades {
    width: 180px;
  }
}

@media screen and (min-width: 768px) {
  /* #navbar-modalidades */
  #navbar-oferta-academica {
    width: 87px;
    /* small-desktop */
    /* large-desktop */
  }
}
@media screen and (min-width: 768px) and (min-width: 1024px) and (max-width: 1279px) {
  #navbar-oferta-academica {
    width: 168px;
  }
}
@media screen and (min-width: 768px) and (min-width: 1280px) {
  #navbar-oferta-academica {
    width: 210px;
  }
}

@media screen and (min-width: 768px) {
  /* #navbar-oferta-academica */
  #navbar-admisiones {
    width: 97px;
    /* small-desktop */
    /* large-desktop */
  }
}
@media screen and (min-width: 768px) and (min-width: 1024px) and (max-width: 1279px) {
  #navbar-admisiones {
    width: 119px;
  }
}
@media screen and (min-width: 768px) and (min-width: 1280px) {
  #navbar-admisiones {
    width: 160px;
  }
}

@media screen and (min-width: 768px) {
  /* #navbar-admisiones */
  #navbar-campus {
    width: 69px;
    /* small-desktop */
    /* large-desktop */
  }
}
@media screen and (min-width: 768px) and (min-width: 1024px) and (max-width: 1279px) {
  #navbar-campus {
    width: 83px;
  }
}
@media screen and (min-width: 768px) and (min-width: 1280px) {
  #navbar-campus {
    width: 120px;
  }
}

@media screen and (min-width: 768px) {
  /* #navbar-campus */
  #navbar-experiencias-ieu {
    width: 119px;
    /* small-desktop */
    /* large-desktop */
    /* > a */
  }
}
@media screen and (min-width: 768px) and (min-width: 1024px) and (max-width: 1279px) {
  #navbar-experiencias-ieu {
    width: 140px;
  }
}
@media screen and (min-width: 768px) and (min-width: 1280px) {
  #navbar-experiencias-ieu {
    width: 159px;
  }
}
@media screen and (min-width: 768px) {
  #navbar-experiencias-ieu > a {
    text-align: right !important;
  }

  /* #navbar-experiencias-ieu */
  .navbar-menu-multiline {
    /* tablet */
  }
}
@media screen and (min-width: 768px) and (min-width: 768px) and (max-width: 1023px) {
  .navbar-menu-multiline {
    padding-top: 10px;
    /* > a */
    /* span */
  }
  .navbar-menu-multiline > a {
    line-height: normal !important;
    height: 50px;
  }
  .navbar-menu-multiline > a > span {
    display: block;
  }
}

@media screen and (min-width: 768px) {
  /* .navbar-menu-multiline */
  /* ----------------------------------------------------------------------------------
   * Navbar Menu Dropdowns
   */
  ul.navbar-dropdown, ul.navbar-deep-dropdown {
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    position: absolute;
    display: none;
  }

  /* ul.navbar-dropdown, ul.navbar-deep-dropdown */
  li.navbar-close-dropdown {
    display: none;
  }

  /* li.navbar-close-dropdown */
  ul.navbar-dropdown {
    background-color: #ff4801;
    padding: 0.625em 0;
    -moz-box-shadow: 0 3px 3px rgba(0, 0, 0, 0.3);
    -webkit-box-shadow: 0 3px 3px rgba(0, 0, 0, 0.3);
    box-shadow: 0 3px 3px rgba(0, 0, 0, 0.3);
    /* > li */
    /* .sprite-navbar-menu-caret */
  }
  ul.navbar-dropdown.navbar-dropdown-oferta-academica {
    /* > li > a */
  }
  ul.navbar-dropdown.navbar-dropdown-oferta-academica > li > a {
    padding-right: 2.5em;
  }
  ul.navbar-dropdown > li {
    /* &:hover */
    /* > a */
  }
  ul.navbar-dropdown > li:hover {
    /* > ul */
    /* > a */
  }
  ul.navbar-dropdown > li:hover > ul {
    display: block;
  }
  ul.navbar-dropdown > li:hover > a {
    color: #ffb69a;
  }
  ul.navbar-dropdown > li:hover > a .sprite-navbar-menu-caret {
    display: block;
  }
  ul.navbar-dropdown > li > a {
    color: white;
    font-size: 1em;
    line-height: 2.1875em;
    padding: 0 1.875em;
    position: relative;
  }
  ul.navbar-dropdown .sprite-navbar-menu-caret {
    position: absolute;
    right: 10px;
    top: 6px;
    display: none;
  }

  /* .navbar-dropdown */
  ul.navbar-deep-dropdown {
    background-color: #007573;
    top: 0;
    left: 100%;
    width: 19.375em;
    padding: 0.625em 0.625em;
    min-height: 10em;
    max-height: 25em;
    overflow: auto;
    /* a */
  }
  ul.navbar-deep-dropdown a {
    font-size: 1em;
    line-height: 1em;
    color: white;
    text-transform: none;
    margin-left: 0.9375em;
    margin-top: 10px;
    overflow: hidden;
    /* &:hover */
  }
  ul.navbar-deep-dropdown a:hover {
    color: #00ccff;
  }

  /* .navbar-deep-dropdown */
  .navbar-subdegree-title {
    border-bottom: 1px solid white;
    color: #007573;
    font-size: 1em;
    line-height: 2.1875em;
    text-transform: uppercase;
    padding-left: 0.9375em;
  }

  /* .navbar-subdegree-title */
}
/* from-tablet */
/* ----------------------------------------------------------------------------------
 * Navbar Submenu
 */
#navbar-submenu {
  font-size: 14px;
  color: white;
  position: absolute;
  top: -10px;
  height: 50px;
  -moz-transition: height 250ms ease-in;
  -o-transition: height 250ms ease-in;
  -webkit-transition: height 250ms ease-in;
  transition: height 250ms ease-in;
  overflow: hidden;
  /* tablet */
  /* ul */
  /* li */
  /* a */
  /* tablet */
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #navbar-submenu {
    font-size: 0.85714em;
  }
}
#navbar-submenu ul:before, #navbar-submenu ul:after {
  content: " ";
  display: table;
}
#navbar-submenu ul:after {
  clear: both;
}
#navbar-submenu li {
  float: left;
}
#navbar-submenu a {
  background-color: #ff4801;
  display: block;
  text-align: center;
  color: white;
  height: 50px;
  padding-top: 20px;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  /* &:hover */
}
#navbar-submenu a:hover {
  color: #ffb69a;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #navbar-submenu {
    /* .navbar-submenu-multiline */
  }
  #navbar-submenu .navbar-submenu-multiline {
    /* a */
    /* span */
  }
  #navbar-submenu .navbar-submenu-multiline a {
    padding-top: 9px;
    font-size: 1.07143em;
  }
  #navbar-submenu .navbar-submenu-multiline span {
    display: block;
  }
}

/* #navbar-submenu */
/* ----------------------------------------------------------------------------------
 * Navbar Submenu Items
 */
#navbar-submenu-acceso-portales {
  width: 190px;
  /* small-desktop */
  /* tablet */
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #navbar-submenu-acceso-portales {
    width: 160px;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #navbar-submenu-acceso-portales {
    width: 90px;
  }
}

/* #navbar-submenu-acceso-portales */
#navbar-submenu-preguntas-frecuentes {
  width: 230px;
  /* small-desktop */
  /* tablet */
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #navbar-submenu-preguntas-frecuentes {
    width: 190px;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #navbar-submenu-preguntas-frecuentes {
    width: 99px;
  }
}

/* #navbar-submenu-preguntas-frecuentes */
#navbar-submenu-contacto {
  width: 155px;
  /* small-desktop */
  /* tablet */
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #navbar-submenu-contacto {
    width: 97px;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #navbar-submenu-contacto {
    width: 85px;
  }
}

/* #navbar-submenu-contacto */
#navbar-submenu-chat-online {
  width: 153px;
  /* small-desktop */
  /* tablet */
  /* a */
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #navbar-submenu-chat-online {
    width: 121px;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #navbar-submenu-chat-online {
    width: 117px;
  }
}
#navbar-submenu-chat-online a {
  background-color: #ff9167;
}

/* #navbar-submenu-chat-online */
#navbar-submenu-form-search {
  background-color: #007573;
  width: 247px;
  /* small-desktop */
  /* tablet */
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #navbar-submenu-form-search {
    width: 194px;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #navbar-submenu-form-search {
    width: 153px;
  }
}

/* #navbar-submenu-form-search */
#navbar-form-search {
  height: 50px;
  /* #navbar-form-search-field */
  /* input */
  /* label */
}
#navbar-form-search #navbar-form-search-field {
  width: 140px;
  /* small-desktop */
  /* tablet */
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #navbar-form-search #navbar-form-search-field {
    width: 90px;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #navbar-form-search #navbar-form-search-field {
    width: 65px;
  }
}
#navbar-form-search input, #navbar-form-search button {
  background-color: transparent;
  border: none;
  margin: 0;
  padding: 0;
}
#navbar-form-search label {
  font-size: 1.07143em;
  margin-left: 1.42857em;
  line-height: 50px;
  /* tablet */
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #navbar-form-search label {
    margin-left: 0.71429em;
  }
}

/* #navbar-form-search */
/* ----------------------------------------------------------------------------------
 * Navbar Social Networks
 */
#navbar-social-networks {
  position: absolute;
  top: 0;
  right: 0;
  height: 114px;
  overflow: hidden;
  -moz-transition: height 250ms ease-in;
  -o-transition: height 250ms ease-in;
  -webkit-transition: height 250ms ease-in;
  transition: height 250ms ease-in;
  /* from-small-desktop */
  /* ul */
  /* li */
}
@media screen and (min-width: 1024px) {
  #navbar-social-networks {
    right: 10px;
  }
}
#navbar-social-networks ul {
  list-style: none;
  padding: 0;
  margin: 0;
}
#navbar-social-networks li {
  display: block;
}

/* #navbar-social-netowkrs */
/*
 * Styles for grid.
 */
.row {
  padding: 1.875em 0;
  /* from-tablet */
}
.row:before, .row:after {
  content: " ";
  display: table;
}
.row:after {
  clear: both;
}
@media screen and (min-width: 768px) {
  .row {
    padding: 3.75em 0;
  }
}
.row.row-without-spaces {
  padding-top: 0;
  padding-bottom: 0;
}

/* .row */
/*
 * Para armado a dos columnas, usar ".col.col-odd" para columna
 * izquierda y ".col.col-even" para columna derecha.
 */
.col {
  float: left;
  width: 100%;
}
.col:before, .col:after {
  content: " ";
  display: table;
}
.col:after {
  clear: both;
}
@media screen and (min-width: 768px) {
  .col {
    width: 48%;
    /* &:nth-child(odd) */
    /* &:nth-child(even) */
  }
  .col.col-odd {
    margin-right: 2%;
  }
  .col.col-even {
    margin-left: 2%;
  }
}
@media screen and (min-width: 768px) and (max-width: 1279px) {
  .col.col-expand {
    width: 100%;
    margin: 0;
  }
}

/* .col */
/**
 * Mobile: 1 column
 * Tablet: 2 columns
 * Desktop: 4 columns
 */
.col-small {
  float: left;
  width: 100%;
}
.col-small:before, .col-small:after {
  content: " ";
  display: table;
}
.col-small:after {
  clear: both;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .col-small {
    width: 48%;
    margin: 0 1%;
  }
}
@media screen and (min-width: 1024px) {
  .col-small {
    width: 23%;
    margin: 0 1%;
  }
}

/*
 * Mobile: 1 column
 * Tablet: 2 columns
 * Desktop: 3 columns
 */
.col-xs {
  float: left;
  width: 99%;
  margin: 0 .5%;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .col-xs {
    width: 49%;
  }
  .col-xs.col-xs-large {
    width: 99%;
  }
}
@media screen and (min-width: 1024px) {
  .col-xs {
    width: 32.33%;
  }
  .col-xs.col-xs-large {
    width: 65.66%;
  }
}

.date-control {
  width: 32.33%;
  margin: 0 .5%;
  float: left;
}
.date-control:first-child {
  margin-left: 0;
  width: 32.83%;
}
.date-control:last-child {
  margin-right: 0;
  width: 32.83%;
}

@media screen and (min-width: 768px) {
  .cell {
    float: left;
    width: 33.3%;
  }
}

.col-block {
  margin: 1em .5em;
}
.col-block:before, .col-block:after {
  content: " ";
  display: table;
}
.col-block:after {
  clear: both;
}
@media screen and (min-width: 768px) {
  .col-block {
    margin: 1.5em 0;
  }
}

/**
 * Make a .xcol-n class.
 */
.xcol-1 {
  width: 14.58333%;
}

.xcol-2 {
  width: 31.66667%;
}

.xcol-3 {
  width: 48.75%;
}

.xcol-4 {
  width: 65.83333%;
}

.xcol-5 {
  width: 82.91667%;
}

.xcol-6 {
  width: 100%;
}

.xcol {
  float: left;
  margin-left: 2.5%;
}

.row .xcol:first-child, .clearfix .xcol:first-child {
  margin-left: 0;
}

/* ----------------------------------------------------------------------------------
 * Apartado: Banners
 */
#home-banners-wrapper {
  height: 14.1875em;
  position: relative;
  overflow: hidden;
  /* tablet */
  /* from-small-desktop */
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #home-banners-wrapper {
    height: 35em;
  }
}
@media screen and (min-width: 1024px) {
  #home-banners-wrapper {
    height: 39em;
  }
}

/* #home-banners-wrapper */
.home-banner {
  background-size: cover;
  background-position: center center;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  display: block;
  height: 100%;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 1;
}

/* .home-banner */
.home-banner-content {
  color: white;
  text-align: center;
  text-shadow: 1px 1px 0 rgba(0, 0, 0, 0.4);
  padding-top: 3.125em;
  /* from-tablet */
  /* h2 */
}
@media screen and (min-width: 768px) {
  .home-banner-content {
    padding-top: 5em;
  }
}
.home-banner-content h2 {
  font-size: 2.5em;
  margin: 0;
  padding: 0;
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  .home-banner-content h2 {
    font-size: 4.375em;
  }
}

/* .home-banner-content */
.home-banner-share {
  font-size: 2.1875em;
}

/* .home-banner-share */
/* ----------------------------------------------------------------------------------
 * Apartado: Calidad y experiencia comprobadas.
 */
.home-big-logo {
  text-align: center;
  line-height: 10.625em;
  height: 10.625em;
  margin-bottom: 0.75em;
  /* small-desktop */
  /* large-desktop */
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .home-big-logo {
    width: 49.8%;
  }
}
@media screen and (min-width: 1280px) {
  .home-big-logo {
    width: 48.5%;
  }
}

/* .home-big-logo */
#home-logo-rvoe {
  background-color: #ffb69a;
  /* from-small-desktop */
}
@media screen and (min-width: 1024px) {
  #home-logo-rvoe {
    float: left;
  }
}

/* #home-logo-rvoe */
#home-logo-sep {
  background-color: #ff9167;
  /* from-small-desktop */
}
@media screen and (min-width: 1024px) {
  #home-logo-sep {
    float: right;
  }
}

/* #home-logo-rvoe */
/* ----------------------------------------------------------------------------------
 * Apartado: Validez oficial y acreditaciones.
 */
.home-small-logo {
  border: 1px solid #2bcfa3;
  background-color: white;
  display: inline-block;
  width: 90px;
  line-height: 90px;
  text-align: center;
  margin: 0.125em;
  /* from-tablet */
  /* from-small-desktop */
  /* large-desktop */
}
@media screen and (min-width: 768px) {
  .home-small-logo {
    width: 140px;
    line-height: 140px;
    margin: 0.3125em;
  }
}
@media screen and (min-width: 1024px) {
  .home-small-logo {
    margin: 0.4375em;
  }
}
@media screen and (min-width: 1280px) {
  .home-small-logo {
    margin: 1.25em;
  }
}

/* .home-small-logo */
#home-logo-universia {
  /* tablet */
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #home-logo-universia {
    margin-left: 0;
    margin-right: 0;
    width: 292px;
  }
}

/* #home-logo-universia */
/* ----------------------------------------------------------------------------------
 * Apartado: ¿Por qué el IEU es diferente?
 */
.home-feature:before, .home-feature:after {
  content: " ";
  display: table;
}
.home-feature:after {
  clear: both;
}
@media screen and (min-width: 768px) {
  .home-feature {
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    text-align: center;
    margin: 0 8%;
  }
}
@media screen and (min-width: 1280px) {
  .home-feature {
    margin: 0 10%;
  }
}

@media screen and (max-width: 767px) {
  .home-feature-image {
    float: left;
    width: 35%;
  }
}
@media screen and (min-width: 768px) {
  .home-feature-image {
    height: 7.5em;
  }
}

@media screen and (max-width: 767px) {
  .home-feature-info {
    float: left;
    width: 65%;
  }
}

.home-feature-title {
  font-size: 1.125em;
  font-family: "ProximaNovaA-Bold";
  line-height: 1em;
}
@media screen and (min-width: 768px) {
  .home-feature-title {
    height: 3em;
  }
}

.home-feature-description {
  font-size: 1em;
}
@media screen and (min-width: 768px) {
  .home-feature-description {
    font-size: 1em;
  }
}

/* ----------------------------------------------------------------------------------
 * Apartado: Becas y Apoyos
 */
#home-photo-students {
  background-image: url("../images/home/ieu-students.jpg");
  width: 100%;
  height: 16.5em;
  border-bottom: 3px solid #ff4801;
}

/* #home-photo-students */
/* ----------------------------------------------------------------------------------
 * Apartado: Pre Inscripción
 */
#home-preinscripcion-wrapper {
  background-image: url("../images/home/preinscripcion-bg.jpg");
  background-position: center center;
  color: white;
  height: 480px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #home-preinscripcion-wrapper {
    height: 450px;
  }
}
@media screen and (min-width: 1280px) {
  #home-preinscripcion-wrapper {
    height: 440px;
  }
}
#home-preinscripcion-wrapper .row {
  padding: 0;
}
#home-preinscripcion-wrapper .col:before, #home-preinscripcion-wrapper .col:after {
  content: " ";
  display: table;
}
#home-preinscripcion-wrapper .col:after {
  clear: both;
}

#home-preinscripcion-title {
  font-size: 1.5625em;
  font-weight: normal;
  text-shadow: 1px 1px 0 rgba(0, 0, 0, 0.4);
  text-align: center;
  margin: 0;
  padding: 2.4em 0;
  white-space: nowrap;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #home-preinscripcion-title {
    font-size: 1.875em;
    padding: 2em 0;
  }
}
@media screen and (min-width: 1280px) {
  #home-preinscripcion-title {
    font-size: 2.8125em;
    padding: 1.33333em 0;
  }
}

.home-preinscripcion-step-image {
  float: left;
}

.home-preinscripcion-step-info {
  margin-left: 35%;
}
@media screen and (min-width: 1024px) {
  .home-preinscripcion-step-info {
    margin-left: 30%;
  }
}

.home-preinscripcion-step-description {
  font-size: 1em;
}

.home-preinscripcion-step-title {
  font-family: "ProximaNovaA-Bold";
  font-size: 1.25em;
  margin: 0;
}
@media screen and (min-width: 1024px) {
  .home-preinscripcion-step-title {
    font-size: 1.875em;
  }
}

#home-btn-preinscripcion {
  padding: 0;
  width: 100%;
  text-align: center;
  line-height: 1.7em;
}
@media screen and (min-width: 1024px) {
  #home-btn-preinscripcion {
    line-height: 3.2em;
  }
}

#home_calidad {
  background: url("../images/home/bg1_mobile.jpg") center center no-repeat;
  background-size: contain;
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  #home_calidad {
    background: url("../images/home/bg1.jpg") center bottom no-repeat;
  }
}

#home_becas {
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  #home_becas {
    background: url("../images/home/bg2.jpg") center bottom no-repeat;
    background-size: cover;
  }
}

#degrees-header {
  background-image: url("../images/degrees/head-banner.jpg");
  background-position: top center;
  background-size: auto 100%;
  height: 398px;
}
@media screen and (min-width: 1280px) {
  #degrees-header {
    height: 421px;
  }
}

#degrees-body {
  margin-bottom: 2em;
}

#degrees-gutter {
  width: 5.4%;
}

.degrees-degree {
  margin-bottom: 3.75em;
  width: 47.2%;
}
.degrees-degree.ejecutiva .degrees-degree-title {
  border-color: #007573;
  color: #007573;
}
.degrees-degree.ejecutiva .degrees-degree-image {
  border-color: #007573;
}
.degrees-degree.online .degrees-degree-title {
  border-color: #007573;
  color: #007573;
}
.degrees-degree.online .degrees-degree-image {
  border-color: #007573;
}

.degrees-degree-title {
  border-bottom: 1px solid #ff4801;
  color: #ff4801;
  font-size: 2.5em;
  line-height: .8em;
  margin: .3em 0;
  padding: 0 .5em .5em;
}

.degrees-degree-body {
  border-style: solid;
  border-color: #c8c8c8;
  border-width: 1px 1px 3px 1px;
  padding: 0 0 1.375em 0;
}

.degrees-degree-image {
  background-size: 100% auto;
  border-bottom: 3px solid #ff4801;
  height: 180px;
  position: relative;
}
.degrees-degree-image .sprite {
  position: absolute;
  right: 0;
  bottom: 0;
}

.degrees-degree-careers {
  margin: 5%;
  margin-bottom: 0;
}
.degrees-degree-careers:before, .degrees-degree-careers:after {
  content: " ";
  display: table;
}
.degrees-degree-careers:after {
  clear: both;
}
@media screen and (min-width: 1024px) {
  .degrees-degree-careers {
    margin: 3%;
    margin-left: 0;
    margin-right: 0;
  }
  .degrees-degree-careers > .degrees-careers-list {
    float: left;
    width: 45.5%;
    margin: 0 3%;
  }
  .degrees-degree-careers > .degrees-careers-list:first-child {
    margin-right: 0;
  }
}

@media screen and (min-width: 1024px) {
  .degrees-subdegree {
    float: left;
    margin: 0 1.5%;
    width: 28.5%;
  }
  .degrees-subdegree:first-child {
    margin-left: 5%;
  }
}

.degrees-subdegree-title {
  color: #ff4801;
  font-size: 1.5625em;
  margin: .5em 0;
}

.degrees-careers-list {
  margin: 0;
  font-size: 0.9375em;
  padding-left: 15px;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}
.degrees-careers-list li {
  margin: .2em 0;
}
.degrees-careers-list a {
  color: #656565;
}
.degrees-careers-list a:hover {
  text-decoration: underline;
}

#career-header {
  background-position: center center;
}
@media screen and (min-width: 768px) {
  #career-header {
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    height: 30em;
  }
}
@media screen and (min-width: 768px) {
  #career-header .page-title {
    margin-bottom: .2em;
  }
}

.career-image {
  background-position: center center;
  border-bottom: 3px solid #ff4801;
  height: 10em;
  margin-bottom: 1em;
}
@media screen and (min-width: 768px) {
  .career-image {
    height: 20em;
  }
}

.career-mode {
  float: left;
  width: 33.33%;
  text-align: center;
}

@media screen and (max-width: 767px) {
  #btn-submit-syllabus {
    width: 100%;
  }
}

/* ----------------------------------------------------------------------------------
 * Wrapper and slide of syllabus form, for mobile.
 */
@media screen and (max-width: 767px) {
  #send-syllabus-wrapper {
    padding: 1em 0;
    overflow: hidden;
  }
  #send-syllabus-wrapper.done #send-syllabus-slide {
    -moz-transform: translate3d(-50%, 0, 0);
    -ms-transform: translate3d(-50%, 0, 0);
    -webkit-transform: translate3d(-50%, 0, 0);
    transform: translate3d(-50%, 0, 0);
  }

  #send-syllabus-slide {
    -moz-transform: translate3d(0, 0, 0);
    -ms-transform: translate3d(0, 0, 0);
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
    -moz-transition: -moz-transform 250ms ease;
    -o-transition: -o-transform 250ms ease;
    -webkit-transition: -webkit-transform 250ms ease;
    transition: transform 250ms ease;
    width: 200%;
  }
  #send-syllabus-slide:before, #send-syllabus-slide:after {
    content: " ";
    display: table;
  }
  #send-syllabus-slide:after {
    clear: both;
  }

  .send-syllabus-slide-block {
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    padding-left: .5em;
    padding-right: .5em;
    float: left;
    width: 50%;
  }

  .send-syllabus-done-text {
    margin: 3.4em 0;
  }
}
#scholarships-header {
  background-image: url("../images/scholarships/head-banner-tablet.jpg");
  background-position: center top;
  height: 33.125em;
}
@media screen and (min-width: 1024px) {
  #scholarships-header {
    height: 37.5em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #scholarships-header {
    background-image: url("../images/scholarships/head-banner-small-desktop.jpg");
  }
}
@media screen and (min-width: 1280px) {
  #scholarships-header {
    background-image: url("../images/scholarships/head-banner-large-desktop.jpg");
  }
}

.scholarships-career-modes {
  text-align: center;
  margin-top: 3em;
}
.scholarships-career-modes:before, .scholarships-career-modes:after {
  content: " ";
  display: table;
}
.scholarships-career-modes:after {
  clear: both;
}
.scholarships-career-modes .cell {
  padding: 0 .6em;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}

.scholarships-career-mode-title {
  font-size: 1.5625em;
  color: #ff4801;
  border-bottom: 1px solid #ff4801;
  padding-bottom: .5em;
  margin-bottom: 0;
}

.scholarships-table-footer {
  text-align: center;
  font-size: 0.9375em;
  margin: 2em 0 0 0;
  padding-bottom: 4.5em;
}

.scholarships-features {
  border-bottom: 3px solid #007573;
}
.scholarships-features p, .scholarships-features ul {
  font-size: 1.25em;
}

#scholarships-bottom-wrapper {
  background-image: url("../images/scholarships/bottom-background-tablet.jpg");
  background-position: center 0;
  height: 336px;
  position: relative;
}
@media screen and (min-width: 1024px) {
  #scholarships-bottom-wrapper {
    height: 345px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #scholarships-bottom-wrapper {
    background-image: url("../images/scholarships/bottom-background-small-desktop.jpg");
  }
}
@media screen and (min-width: 1280px) {
  #scholarships-bottom-wrapper {
    background-image: url("../images/scholarships/bottom-background-large-desktop.jpg");
  }
}

.agreements-logo {
  display: inline-block;
  text-align: center;
  width: 32.8%;
}
@media screen and (min-width: 1024px) {
  .agreements-logo {
    width: 24.5%;
  }
}
@media screen and (min-width: 1280px) {
  .agreements-logo {
    width: 300px;
  }
}
.agreements-logo img {
  width: 100%;
}

.agreements-back-button-wrapper {
  width: 35%;
  margin: 0 auto;
}

#calculator-header {
  height: 128px;
}
@media screen and (min-width: 768px) {
  #calculator-header {
    background: url("../images/calculator/calculator-background-768.jpg") no-repeat scroll center 0 transparent;
    height: 450px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #calculator-header {
    background: url("../images/calculator/calculator-background-1024.jpg") no-repeat scroll center 0 transparent;
  }
}
@media screen and (min-width: 1280px) {
  #calculator-header {
    background: url("../images/calculator/calculator-background-1280.jpg") no-repeat scroll center 0 transparent;
    height: 464px;
  }
}

/**
 * Calculator content
 */
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #calculator-content {
    margin-top: -68px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #calculator-content {
    margin-top: -46px;
  }
}
@media screen and (min-width: 1280px) {
  #calculator-content {
    margin-top: 0;
  }
}

@media screen and (min-width: 768px) {
  #calculator-wrapper {
    padding: 0 2.1875em;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #calculator-wrapper label {
    font-size: 1.0625em;
  }
}

@media screen and (max-width: 767px) {
  #calculator-logo {
    text-align: left;
    width: 100%;
  }
}

.title-features {
  font-size: 2.1875em;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .title-features {
    font-size: 2.5em;
  }
}

.form-group select {
  color: #656565;
}

#average {
  background-color: transparent;
  border: 0;
}
#average select:first-child {
  margin: 0 12px 0 0;
}
#average select {
  display: inline;
  margin-left: 12px;
  width: auto;
}

#required-info {
  font-size: 0.8125em;
}

#calculator-submit {
  margin-top: 26px;
  width: 100%;
}
@media screen and (min-width: 768px) {
  #calculator-submit {
    margin-top: 3.25em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #calculator-submit {
    margin-top: 2.5em;
  }
}
@media screen and (min-width: 1280px) {
  #calculator-submit {
    margin-top: 1.5625em;
  }
}

#calculator-program-result-container .block-type1 {
  margin-bottom: 0;
  padding: 3%;
}
#calculator-program-result-container .title-features {
  padding-top: 0;
}

.calculator-result-column1 {
  margin-left: 14.5833% !important;
}

#calculator-content-result {
  margin-top: 0;
}

.calculator-label {
  color: #ffffff;
}
@media screen and (min-width: 768px) {
  .calculator-label {
    font-size: 1.0625em;
    margin-bottom: 0.65em;
    padding-left: 1em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .calculator-label {
    font-size: 0.9375em;
  }
}
@media screen and (min-width: 1280px) {
  .calculator-label {
    font-size: 1.1875em;
  }
}

.calculator-result {
  background-image: url("../images/calculator/bullet.png");
  background-repeat: no-repeat;
  background-size: 0.33333em 0.66667em;
  background-position: 0 5px;
  font-size: 1em;
  height: 1.38889em;
  margin-bottom: 0.72222em;
  padding-left: 0.66667em;
}
@media screen and (min-width: 768px) {
  .calculator-result {
    background-position: 20px 0;
    background-size: 0.4em 0.76em;
    font-size: 1.25em;
    height: 2.4em;
    margin-bottom: 0;
    padding-left: 1.64em;
  }
}
.calculator-result span {
  color: #007573;
  font-size: 0.6em;
}
@media screen and (min-width: 1280px) {
  .calculator-result {
    height: 3em;
  }
}

#calculator-left-column .col-even {
  border-bottom: #ffffff solid 1px;
  margin-bottom: 16px;
}
#calculator-left-column .col-odd:nth-last-child(2), #calculator-left-column .col-even:last-child {
  border-bottom: 0;
}
@media screen and (min-width: 768px) {
  #calculator-left-column {
    width: 100%;
  }
  #calculator-left-column .col-odd {
    border-bottom: #ffffff solid 1px;
    margin-right: 0;
    margin-bottom: 16px;
  }
  #calculator-left-column .col-even {
    margin-bottom: 33px;
    margin-left: 0;
  }
}
@media screen and (min-width: 1024px) {
  #calculator-left-column {
    width: 62.66%;
  }
}
#calculator-left-column #calculator-result-info {
  font-size: 0.8125em;
}

#calculator-right-column {
  padding-top: 20px;
}
#calculator-right-column #calculator-code-info {
  font-size: 0.9375em;
  margin-bottom: 26px;
}
#calculator-right-column #calculator-code-info span {
  color: #ff9167;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #calculator-right-column #calculator-code-info {
    float: left;
    font-size: 1.25em;
    margin-right: 40px;
    width: 210px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #calculator-right-column #calculator-code-info {
    font-size: 1.25em;
    margin-bottom: 200px;
  }
}
@media screen and (min-width: 1280px) {
  #calculator-right-column #calculator-code-info {
    font-size: 1.5em;
    margin-bottom: 260px;
  }
}
#calculator-right-column #calculator-return-btn {
  height: 2.93333em;
  font-size: 0.9375em;
}
@media screen and (min-width: 768px) {
  #calculator-right-column {
    width: auto;
  }
  #calculator-right-column #calculator-return-btn {
    font-size: 1em;
    line-height: 58px;
    height: 58px;
    text-align: center;
    vertical-align: middle;
    width: 249px;
  }
}
@media screen and (min-width: 1024px) {
  #calculator-right-column {
    width: 33.33%;
    padding-top: 20px;
  }
}

#preregistration-mobile-banner {
  height: auto;
  width: 100%;
}

#preregistration-header {
  background-image: url("../images/pre-registration/head-banner-tablet.jpg");
  height: 33.125em;
}
@media screen and (min-width: 1024px) {
  #preregistration-header {
    height: 37.5em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #preregistration-header {
    background-image: url("../images/pre-registration/head-banner-small-desktop.jpg");
  }
}
@media screen and (min-width: 1280px) {
  #preregistration-header {
    background-image: url("../images/pre-registration/head-banner-large-desktop.jpg");
  }
}

#preregistration-block-mosaic-row-1 .block-mosaic {
  height: 300px;
}

#preregistration-block-mosaic-row-2 .block-mosaic {
  height: 400px;
}

#preregistration-documentation-block ul {
  width: auto !important;
}

#preregistration-request-header {
  background-image: url("../images/pre-registration/create/head-banner-tablet.jpg");
  background-position: center;
  height: 420px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #preregistration-request-header {
    background-image: url("../images/pre-registration/create/head-banner-small-desktop.jpg");
  }
}
@media screen and (min-width: 1280px) {
  #preregistration-request-header {
    background-image: url("../images/pre-registration/create/head-banner-large-desktop.jpg");
  }
}

.pre-registration-success-list {
  margin: 2em 0 !important;
}

.career-modes-header .head-block-text {
  width: 75%;
}
.career-modes-header .block-type2 {
  display: table;
}
.career-modes-header .head-block-text {
  display: table-cell;
  float: none;
  vertical-align: middle;
}

.career-modes-scholarships-table {
  width: 60%;
  margin: 0 auto 2em auto;
}
.career-modes-scholarships-table tbody tr {
  background-color: transparent;
}
.career-modes-scholarships-table tbody tr:nth-child(odd) {
  background-color: #2bcfa3;
}

.career-modes-time-description {
  padding: 0 2em;
}

.career-modes-presencial-header {
  background-image: url("../images/career-modes/presencial/head-banner-tablet.jpg");
  background-position: center center;
  height: 33.125em;
}
@media screen and (min-width: 1024px) {
  .career-modes-presencial-header {
    background-image: url("../images/career-modes/presencial/head-banner-small-desktop.jpg");
    height: 37.5em;
  }
}
@media screen and (min-width: 1280px) {
  .career-modes-presencial-header {
    background-image: url("../images/career-modes/presencial/head-banner-large-desktop.jpg");
  }
}

.career-modes-ejecutiva-header {
  background-image: url("../images/career-modes/ejecutiva/head-banner-tablet.jpg");
  background-position: center center;
  height: 33.125em;
}
@media screen and (min-width: 1024px) {
  .career-modes-ejecutiva-header {
    background-image: url("../images/career-modes/ejecutiva/head-banner-small-desktop.jpg");
    height: 37.5em;
  }
}
@media screen and (min-width: 1280px) {
  .career-modes-ejecutiva-header {
    background-image: url("../images/career-modes/ejecutiva/head-banner-large-desktop.jpg");
  }
}

.career-modes-online-header {
  background-image: url("../images/career-modes/online/head-banner-tablet.jpg");
  background-position: center center;
  height: 33.125em;
}
@media screen and (min-width: 1024px) {
  .career-modes-online-header {
    background-image: url("../images/career-modes/online/head-banner-small-desktop.jpg");
    height: 37.5em;
  }
}
@media screen and (min-width: 1280px) {
  .career-modes-online-header {
    background-image: url("../images/career-modes/online/head-banner-large-desktop.jpg");
  }
}

.career-modes-online-laptop {
  background-image: url("../images/career-modes/online/laptop.jpg");
  height: 17.4375em;
  width: 100%;
}

/* ====================
 * MOBILE
 ====================== */
#contact-call-title {
  font-size: 1.5625em;
  line-height: 1em;
  margin-top: 0.4em;
}

#contact-call-slogan {
  margin: 1.66667em 0 0.61111em;
  font-size: 1.125em;
}

#contact-call-send-btn {
  width: 100%;
}

/* ================
 * FROM TABLET
 ================== */
#contact-container {
  margin-bottom: 20px;
}
@media screen and (min-width: 768px) {
  #contact-container {
    margin-bottom: 0;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #contact-container {
    background: url("../images/contact/contact-background-768.jpg") no-repeat scroll center 0;
    height: 340px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #contact-container {
    background-image: url("../images/contact/contact-background-1024.jpg");
    height: 370px;
  }
}
@media screen and (min-width: 1280px) {
  #contact-container {
    background-image: url("../images/contact/contact-background-1280.jpg");
    height: 428px;
  }
}

#contact-content .row {
  padding-top: 0;
}

.contact-title {
  font-size: 1.25em;
  margin: 1.04545em 0 1.68182em;
  text-align: center;
}
@media screen and (min-width: 1024px) {
  .contact-title {
    font-size: 1.125em;
    margin: 0.80769em 0 1.80769em;
  }
}
.contact-title.phone {
  margin: 1.04545em 0 3.08182em;
}
@media screen and (min-width: 1280px) {
  .contact-title.phone {
    margin: 0.80769em 0 35px;
  }
}
@media screen and (min-width: 768px) {
  .contact-title.chat {
    margin: 0.80769em 0 76px;
  }
}
@media screen and (min-width: 1280px) {
  .contact-title.chat {
    margin: 0.80769em 0 57px;
  }
}
.contact-title.campus {
  margin: 1.04545em 0 2.88182em;
}
@media screen and (min-width: 768px) {
  .contact-title.campus {
    margin: 0.80769em 0 98px;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .contact-title.campus {
    margin: 0.80769em 0 101px;
  }
}
@media screen and (min-width: 1280px) {
  .contact-title.campus {
    margin: 0.80769em 0 79px;
  }
}

#contact-form .pull-left {
  box-sizing: border-box;
  padding-right: 6px;
  width: 50%;
}
#contact-form .pull-left.wide {
  width: 100%;
}
#contact-form .pull-left.wide .form-control {
  width: 100%;
}
@media screen and (min-width: 1024px) {
  #contact-form .pull-left {
    min-height: 93px;
    padding-right: 5px;
    width: 33.33%;
  }
  #contact-form .pull-left.contact-email {
    width: 66.67%;
  }
  #contact-form .pull-left.contact-tel {
    width: 50%;
  }
}
@media screen and (min-width: 1280px) {
  #contact-form .pull-left {
    min-height: 86px;
    padding-right: 8px;
  }
}
#contact-form textarea.form-control {
  height: 132px;
}
@media screen and (min-width: 1024px) {
  #contact-form textarea.form-control {
    height: 152px;
  }
}
@media screen and (min-width: 1280px) {
  #contact-form textarea.form-control {
    height: 162px;
  }
}
#contact-form #contact-required-label {
  margin: 1.92308em 0 1.53846em;
  font-size: 0.8125em;
}
@media screen and (min-width: 1024px) {
  #contact-form #contact-required-label {
    margin: 2.69231em 0 1.53846em;
  }
}
#contact-form #contact-checkbox {
  font-size: 1.1875em;
  margin-bottom: 2.63158em;
}
@media screen and (min-width: 1024px) {
  #contact-form #contact-checkbox {
    margin-bottom: 2.84211em;
  }
}
@media screen and (min-width: 768px) {
  #contact-form #contact-send-btn {
    height: 3.75em;
    margin-top: 1.75em;
    width: 19.125em;
  }
}

#contact-icons-column #contact-phone {
  color: #ff4801;
  font-size: 2.5em;
  text-align: center;
}
@media screen and (min-width: 1024px) {
  #contact-icons-column #contact-phone {
    font-size: 25px;
  }
}
@media screen and (min-width: 1280px) {
  #contact-icons-column #contact-phone {
    font-size: 30px;
  }
}
#contact-icons-column .clearfix {
  margin: 2.5em 0;
}

/* =========
 * HEADER
 =========== */
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #contact-answer-container {
    background: url("../images/contact/contact-background-768.jpg") no-repeat scroll center 0;
    height: 351px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #contact-answer-container {
    background-image: url("../images/contact/contact-background-1024.jpg");
    height: 387px;
  }
}
@media screen and (min-width: 1280px) {
  #contact-answer-container {
    background-image: url("../images/contact/contact-background-1280.jpg");
    height: 476px;
  }
}

/* ==========
 * CONTENT
 ============ */
#contact-answer-block {
  margin-top: 0;
  margin-bottom: 100px;
}
#contact-answer-block .btn-type-2 {
  background-color: #ff4801;
  height: 80px;
  line-height: 80px;
  margin-top: 46px;
  margin-right: 16px;
  width: 197px;
}
#contact-answer-block #contact-answer-btn {
  height: 80px;
  line-height: 80px;
  margin-top: 46px;
  width: 209px;
}
@media screen and (min-width: 1024px) {
  #contact-answer-block #contact-pull-right-from-tablet {
    float: right !important;
  }
  #contact-answer-block .btn-type-2 {
    margin-top: 0;
  }
  #contact-answer-block #contact-answer-btn {
    margin-top: 0;
  }
}
@media screen and (min-width: 1280px) {
  #contact-answer-block .btn-type-2 {
    margin-right: 54px;
  }
}

#contact-answer-phone {
  margin: 21px 0 0 10px;
}

/* =============
 * HEADER
 =============== */
@media screen and (min-width: 768px) {
  #about-header {
    background: url("../images/pages/about/about-background-768.jpg") no-repeat scroll center 0;
    background-size: cover;
    height: 530px;
  }
}
@media screen and (min-width: 1024px) {
  #about-header {
    background-image: url("../images/pages/about/about-background-1024.jpg");
    height: 600px;
  }
}
@media screen and (min-width: 1280px) {
  #about-header {
    background-image: url("../images/pages/about/about-background-1080.jpg");
  }
}
@media screen and (min-width: 768px) {
  #about-header .page-title {
    color: #FFFFFF;
  }
}
#about-header .block-type2 {
  box-sizing: border-box;
  padding: 0;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-header .block-type2 {
    height: 151px;
  }
}
@media screen and (min-width: 1280px) {
  #about-header .block-type2 {
    height: 165px;
  }
}
#about-header .block-type2 #about-header-column1 {
  font-size: 2.1875em;
  margin-top: 1.11429em;
  text-align: center;
  /*width: em(230px, 35px);*/
  width: 5.71429em;
}
@media screen and (min-width: 1024px) {
  #about-header .block-type2 #about-header-column1 {
    font-size: 3.125em;
    margin-top: 0.8em;
    width: 6.32em;
  }
}
@media screen and (min-width: 1280px) {
  #about-header .block-type2 #about-header-column1 {
    margin-top: 0.9em;
    width: 6.02em;
  }
}
#about-header .block-type2 #about-header-column2 {
  box-sizing: border-box;
  font-size: 0.9375em;
  padding: 1em 1.8em 1em 0.86667em;
  /*width: em(498px, 15px);*/
  width: 35.2em;
}
#about-header .block-type2 #about-header-column2 .pull-left {
  width: 16%;
}
#about-header .block-type2 #about-header-column2 .pull-left a {
  margin-bottom: 10px;
}
@media screen and (min-width: 1024px) {
  #about-header .block-type2 #about-header-column2 {
    font-size: 1.125em;
    padding: 0.83333em 2.55556em 0.83333em 0.83333em;
    width: 37.11111em;
  }
}
@media screen and (min-width: 1280px) {
  #about-header .block-type2 #about-header-column2 {
    font-size: 1.375em;
    padding: 0.90909em 1.95455em 0.90909em 1.09091em;
    width: 42.5em;
  }
}

/* =============
 * Filosofia
 =============== */
#about-filosofia-container .sprite-filosofia-icon {
  display: none;
}
@media screen and (min-width: 768px) {
  #about-filosofia-container .sprite-filosofia-icon {
    display: block;
  }
}
#about-filosofia-container #about-filosofia-description {
  font-size: 0.9375em;
}
@media screen and (min-width: 768px) {
  #about-filosofia-container #about-filosofia-description {
    font-size: 1.125em;
    width: 16.38095em;
  }
  #about-filosofia-container #about-filosofia-description .block-type1 {
    margin-top: 1.14286em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-filosofia-container #about-filosofia-description {
    width: 22.47619em;
  }
  #about-filosofia-container #about-filosofia-description .block-type1 {
    margin-top: 2.14286em;
  }
}
@media screen and (min-width: 1280px) {
  #about-filosofia-container #about-filosofia-description {
    font-size: 1.25em;
    width: 26.08696em;
  }
  #about-filosofia-container #about-filosofia-description .block-type1 {
    margin-top: 2.26087em;
  }
}
#about-filosofia-container #about-filosofia-description h3 {
  color: #ff4801;
}
#about-filosofia-container #about-filosofia-description #about-filosofia-title {
  color: #ff4801;
  font-size: 1.375em;
  border-bottom: #ff4801 solid 1px;
}
@media screen and (min-width: 768px) {
  #about-filosofia-container #about-filosofia-description #about-filosofia-title {
    padding-top: 2em;
  }
}
#about-filosofia-container #about-filosofia-description #about-filosofia-title h2 {
  margin-top: 23px;
}
@media screen and (min-width: 768px) {
  #about-filosofia-container #about-filosofia-description #about-filosofia-title h2 {
    padding-left: 2em;
  }
}
#about-filosofia-container #about-filosofia-image {
  background-image: url("../images/pages/about/filosofia.jpg");
  background-size: cover;
  height: 219px;
  width: 100%;
  margin-top: 3em;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #about-filosofia-container #about-filosofia-image {
    background-image: url("../images/pages/about/filosofia-768.jpg");
    height: 501px;
    width: 345px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-filosofia-container #about-filosofia-image {
    background-image: url("../images/pages/about/filosofia-768.jpg");
    height: 367px;
    width: 473px;
  }
}
@media screen and (min-width: 1280px) {
  #about-filosofia-container #about-filosofia-image {
    background-image: url("../images/pages/about/filosofia-1024.jpg");
    height: 367px;
    width: 600px;
  }
}

/**
  NUESTROS VALORES
**/
#about-nuestros-valores {
  color: white;
  background: transparent url("../images/pages/about/nuestros-valores.jpg");
  height: 750px;
  margin-bottom: 1.5em;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #about-nuestros-valores {
    background-image: url("../images/pages/about/nuestros-valores-768.jpg");
    height: 329px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-nuestros-valores {
    background-image: url("../images/pages/about/nuestros-valores-1024.jpg");
    height: 358px;
  }
}
@media screen and (min-width: 1280px) {
  #about-nuestros-valores {
    background-image: url("../images/pages/about/nuestros-valores-1280.jpg");
    height: 358px;
  }
}
#about-nuestros-valores #about-nuestros-valores-title {
  padding: .5em 0;
  text-align: center;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #about-nuestros-valores #about-nuestros-valores-title {
    padding: .1em 0;
  }
}
#about-nuestros-valores #about-nuestros-valores-title h2 {
  font-size: 2.2em;
  font-weight: lighter;
  text-shadow: rgba(0, 0, 0, 0.5) 1px 1px;
}
#about-nuestros-valores #about-nuestros-valores-content {
  text-align: center;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #about-nuestros-valores #about-nuestros-valores-content .col-xs {
    width: 32%;
  }
}
#about-nuestros-valores #about-nuestros-valores-content h3 {
  font-size: 1.5em;
}
#about-nuestros-valores #about-nuestros-valores-content p {
  font-size: 1.2em;
}

/* =============
 * WELCOME
 =============== */
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #about-welcome-container {
    margin-top: 44px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-welcome-container {
    margin-top: 51px;
  }
}
@media screen and (min-width: 1280px) {
  #about-welcome-container {
    margin-top: 70px;
  }
}
#about-welcome-container #about-welcome-title {
  border-bottom: #ff4801 solid 1px;
  margin-bottom: 1.8125em;
  padding-bottom: 1.25em;
}
#about-welcome-container #about-welcome-image {
  background-image: url("../images/pages/about/acerca-de-ieu.jpg");
  background-size: cover;
  height: 219px;
  width: 100%;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #about-welcome-container #about-welcome-image {
    background-image: url("../images/pages/about/acerca-de-ieu-768.jpg");
    height: 501px;
    width: 345px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-welcome-container #about-welcome-image {
    background-image: url("../images/pages/about/acerca-de-ieu-1024.jpg");
    height: 367px;
    width: 473px;
  }
}
@media screen and (min-width: 1280px) {
  #about-welcome-container #about-welcome-image {
    background-image: url("../images/pages/about/acerca-de-ieu-1080.jpg");
    height: 367px;
    width: 600px;
  }
}
#about-welcome-container #about-welcome-description {
  font-size: 0.9375em;
}
@media screen and (min-width: 768px) {
  #about-welcome-container #about-welcome-description {
    font-size: 1.125em;
    width: 16.38095em;
  }
  #about-welcome-container #about-welcome-description .block-type1 {
    margin-top: 1.14286em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-welcome-container #about-welcome-description {
    width: 22.47619em;
  }
  #about-welcome-container #about-welcome-description .block-type1 {
    margin-top: 2.14286em;
  }
}
@media screen and (min-width: 1280px) {
  #about-welcome-container #about-welcome-description {
    font-size: 1.25em;
    width: 26.08696em;
  }
  #about-welcome-container #about-welcome-description .block-type1 {
    margin-top: 2.26087em;
  }
}
#about-welcome-container #about-welcome-description #about-welcome-title {
  color: #ff4801;
  font-size: 1.375em;
}

/* ==========
 * HISTORY
 ============ */
#about-history-title {
  border-bottom: #ff4801 solid 1px;
  margin-bottom: 1.8125em;
  padding-bottom: 1.25em;
  width: 29.5625em;
}
#about-history-title #about-history-title-desc {
  color: #ff4801;
  font-size: 2.1875em;
  padding: 20px 0 0 24px;
}

#about-history-container {
  background: url("../images/pages/about/history/history-background-768.jpg?v=1") no-repeat scroll center 0;
  font-size: 1.1875em;
  height: 25.78947em;
  transition: background-position 1s ease 300ms;
  -webkit-transition: background-position 1s ease 300ms;
  -moz-transition: background-position 1s ease 300ms;
  -o-transition: background-position 1s ease 300ms;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-history-container {
    background: url("../images/pages/about/history/history-background-1024.jpg?v=1") no-repeat scroll center 0;
  }
}
@media screen and (min-width: 1280px) {
  #about-history-container {
    height: 23.15789em;
    background: url("../images/pages/about/history/history-background-1280.jpg?v=1") no-repeat scroll center 0;
  }
}

#about-history-controls {
  position: relative;
  z-index: 2;
}
#about-history-controls .about-history-btn {
  box-sizing: border-box;
  border: 1px solid #FFFFFF;
  display: block;
  height: 214px;
  line-height: 214px;
  position: absolute;
  top: 114px;
  width: 51px;
}
#about-history-controls .about-history-btn#about-history-prev-btn {
  background: url("../images/pages/about/history/prev-arrow.png") no-repeat scroll center center;
}
#about-history-controls .about-history-btn#about-history-next-btn {
  background: url("../images/pages/about/history/next-arrow.png") no-repeat scroll center center;
  left: auto;
  right: 0;
}

#about-history-carousel {
  position: relative;
  height: 25.78947em;
  overflow: hidden;
  z-index: 1;
}
@media screen and (min-width: 1280px) {
  #about-history-carousel {
    height: 23.15789em;
  }
}
#about-history-carousel #about-history-carousel-wrapper {
  box-sizing: border-box;
  left: 0;
  position: absolute;
  top: 0;
  transition: left 1s ease 0s;
  -webkit-transition: left 1s ease 0s;
  -moz-transition: left 1s ease 0s;
  -o-transition: left 1s ease 0s;
}
#about-history-carousel .about-history-slide {
  box-sizing: border-box;
  padding: 2.15789em 3.36842em 0 4.05263em;
  height: 25.78947em;
  width: 100%;
}
@media screen and (min-width: 1280px) {
  #about-history-carousel .about-history-slide {
    height: 23.15789em;
  }
}
#about-history-carousel .about-history-year {
  color: #ffffff;
  font-size: 2.36842em;
}
#about-history-carousel .about-history-text {
  color: #FFFFFF;
}
#about-history-carousel .about-history-left-img {
  margin-bottom: 0.52632em;
  height: 11.63158em;
  width: 14.05263em;
}
#about-history-carousel .about-history-left-img.about-history-2014-img {
  background: url("../images/pages/about/history/2014-768.png") no-repeat scroll 0 0;
}
#about-history-carousel .about-history-left-img.about-history-1976-img {
  background: url("../images/pages/about/history/1976-768.jpg") no-repeat scroll 0 0;
}
#about-history-carousel .about-history-left-img.about-history-1990-img {
  background: url("../images/pages/about/history/1990-768.jpg") no-repeat scroll 0 0;
}
#about-history-carousel .about-history-left-img.about-history-2002-img {
  background: url("../images/pages/about/history/2002-768.jpg") no-repeat scroll 0 0;
}
#about-history-carousel .about-history-left-img.about-history-2005-img {
  background: url("../images/pages/about/history/2005-768.jpg") no-repeat scroll 0 0;
}
#about-history-carousel .about-history-left-img.about-history-2010-img {
  background: url("../images/pages/about/history/2010-768.jpg") no-repeat scroll 0 0;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-history-carousel .about-history-left-img {
    width: 20.84211em;
  }
  #about-history-carousel .about-history-left-img.about-history-2014-img {
    background: url("../images/pages/about/history/2014-1024.png") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-left-img.about-history-1976-img {
    background: url("../images/pages/about/history/1976-1024.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-left-img.about-history-1990-img {
    background: url("../images/pages/about/history/1990-1024.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-left-img.about-history-2002-img {
    background: url("../images/pages/about/history/2002-1024.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-left-img.about-history-2005-img {
    background: url("../images/pages/about/history/2005-1024.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-left-img.about-history-2010-img {
    background: url("../images/pages/about/history/2010-1024.jpg") no-repeat scroll 0 0;
  }
}
@media screen and (min-width: 1280px) {
  #about-history-carousel .about-history-left-img {
    width: 26.10526em;
  }
  #about-history-carousel .about-history-left-img.about-history-2014-img {
    background: url("../images/pages/about/history/2014-1280.png") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-left-img.about-history-1976-img {
    background: url("../images/pages/about/history/1976-1280.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-left-img.about-history-1990-img {
    background: url("../images/pages/about/history/1990-1280.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-left-img.about-history-2002-img {
    background: url("../images/pages/about/history/2002-1280.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-left-img.about-history-2005-img {
    background: url("../images/pages/about/history/2005-1280.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-left-img.about-history-2010-img {
    background: url("../images/pages/about/history/2010-1280.jpg") no-repeat scroll 0 0;
  }
}
#about-history-carousel .about-history-right-img {
  margin-top: 1.52632em;
  height: 10.31579em;
  width: 14.78947em;
}
#about-history-carousel .about-history-right-img.about-history-2013-img {
  background: url("../images/pages/about/history/2013-768.jpg") no-repeat scroll 0 0;
}
#about-history-carousel .about-history-right-img.about-history-1980-img {
  background: url("../images/pages/about/history/1980-768.jpg") no-repeat scroll 0 0;
}
#about-history-carousel .about-history-right-img.about-history-2000-img {
  background: url("../images/pages/about/history/2000-768.jpg") no-repeat scroll 0 0;
}
#about-history-carousel .about-history-right-img.about-history-2003-img {
  background: url("../images/pages/about/history/2003-768.jpg") no-repeat scroll 0 0;
}
#about-history-carousel .about-history-right-img.about-history-2007-img {
  background: url("../images/pages/about/history/2007-768.jpg") no-repeat scroll 0 0;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-history-carousel .about-history-right-img {
    width: 20.84211em;
  }
  #about-history-carousel .about-history-right-img.about-history-2013-img {
    background: url("../images/pages/about/history/2013-1024.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-right-img.about-history-1980-img {
    background: url("../images/pages/about/history/1980-1024.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-right-img.about-history-2000-img {
    background: url("../images/pages/about/history/2000-1024.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-right-img.about-history-2003-img {
    background: url("../images/pages/about/history/2003-1024.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-right-img.about-history-2007-img {
    background: url("../images/pages/about/history/2007-1024.jpg") no-repeat scroll 0 0;
  }
}
@media screen and (min-width: 1280px) {
  #about-history-carousel .about-history-right-img {
    width: 26.10526em;
  }
  #about-history-carousel .about-history-right-img.about-history-2013-img {
    background: url("../images/pages/about/history/2013-1280.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-right-img.about-history-1980-img {
    background: url("../images/pages/about/history/1980-1280.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-right-img.about-history-2000-img {
    background: url("../images/pages/about/history/2000-1280.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-right-img.about-history-2003-img {
    background: url("../images/pages/about/history/2003-1280.jpg") no-repeat scroll 0 0;
  }
  #about-history-carousel .about-history-right-img.about-history-2007-img {
    background: url("../images/pages/about/history/2007-1280.jpg") no-repeat scroll 0 0;
  }
}

/* =====================
 * OFFICIAL VALIDITY
 ======================= */
#official-validity-left, #official-validity-right {
  box-sizing: border-box;
  margin-top: 24px;
  width: 100%;
}
@media screen and (min-width: 768px) {
  #official-validity-left, #official-validity-right {
    width: 50%;
  }
}

#official-validity-left #official-validity-icon {
  margin-right: 17px;
  width: 44px;
}
@media screen and (min-width: 768px) {
  #official-validity-left #official-validity-title {
    border-bottom: #ff4801 solid 1px;
    padding-bottom: 11px;
  }
}
@media screen and (min-width: 768px) {
  #official-validity-left #official-validity-title-desc {
    width: 214px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #official-validity-left #official-validity-title-desc {
    width: 385px;
  }
}
@media screen and (min-width: 1280px) {
  #official-validity-left #official-validity-title-desc {
    width: 440px;
  }
}
#official-validity-left #official-validity-img {
  background-image: url("../images/pages/about/official-validity-background.jpg");
  background-size: cover;
  height: 241px;
  width: 100%;
}
@media screen and (min-width: 768px) {
  #official-validity-left #official-validity-img {
    background-image: url("../images/pages/about/official-validity-background-768.jpg");
    height: 505px;
    width: 345px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #official-validity-left #official-validity-img {
    background-image: url("../images/pages/about/official-validity-background-1024.jpg");
    height: 418px;
    width: 473px;
  }
}
@media screen and (min-width: 1280px) {
  #official-validity-left #official-validity-img {
    background-image: url("../images/pages/about/official-validity-background-1280.jpg");
    height: 418px;
    width: 600px;
  }
}

#official-validity-right {
  font-size: 0.9375em;
}
@media screen and (min-width: 768px) {
  #official-validity-right {
    line-height: 1.4em;
    font-size: 1.125em;
    margin-top: 10em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #official-validity-right {
    margin-top: 8.1em;
  }
}
@media screen and (min-width: 1280px) {
  #official-validity-right {
    font-size: 1.25em;
    margin-top: 7.78261em;
  }
}

/* =====================
 * BANNERS
 ======================= */
#about-banners {
  text-align: center;
  font-size: 1.375em;
  padding: 76px 0 73px;
}
#about-banners .about-banners-text {
  margin-bottom: 51px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-banners .about-banners-text {
    font-size: 1.2em;
  }
}
@media screen and (min-width: 1280px) {
  #about-banners .about-banners-text {
    font-size: 1.4em;
  }
}
#about-banners .btn {
  width: 300px;
}

/* =====================
 * ACADEMIC STAFF
 ======================= */
#about-staff-container {
  font-size: 20px;
  line-height: 25px;
}
#about-staff-container #about-staff-title {
  border-bottom: #ff4801 solid 1px;
  margin-bottom: 36px;
  padding-bottom: 16px;
}
#about-staff-container #about-staff-title .title-description {
  margin: 0 0 0 120px;
}
@media screen and (min-width: 1024px) {
  #about-staff-container #about-staff-title .title-description {
    margin-top: 39px;
  }
}
#about-staff-container #about-staff-image {
  background-image: url("../images/pages/about/staff-768.jpg?v=1");
  height: 442px;
  margin-top: 14px;
  width: 345px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-staff-container #about-staff-image {
    background-image: url("../images/pages/about/staff-1024.jpg?v=1");
    height: 408px;
    width: 473px;
  }
}
@media screen and (min-width: 1280px) {
  #about-staff-container #about-staff-image {
    background-image: url("../images/pages/about/staff-1280.jpg?v=1");
    height: 413px;
    width: 600px;
  }
}
@media screen and (min-width: 1280px) {
  #about-staff-container {
    font-size: 23px;
  }
}

/*================
 * TESTIMONIALS
 ================= */
#about-testimonial-container #about-testimonial-title {
  padding-bottom: 16px;
}
@media screen and (min-width: 768px) {
  #about-testimonial-container #about-testimonial-title {
    border-bottom: #ff4801 solid 1px;
    width: 344px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #about-testimonial-container #about-testimonial-title {
    width: 472px;
  }
}
@media screen and (min-width: 1280px) {
  #about-testimonial-container #about-testimonial-title {
    width: 600px;
  }
}
#about-testimonial-container #about-testimonial-title #about-testimonial-title-desc {
  margin: 26px 0 0 13px;
}
#about-testimonial-container .col {
  margin-bottom: 40px;
}
#about-testimonial-container .video-center {
  margin-bottom: 40px;
}
@media screen and (min-width: 768px) {
  #about-testimonial-container .video-center {
    text-align: center;
    margin: 0 25% 40px;
    width: 48%;
  }
}

#privacy-header {
  background: url("../images/pages/privacy/privacy-background-768.jpg") no-repeat scroll center 0;
  height: 530px;
}
@media screen and (min-width: 1024px) {
  #privacy-header {
    background-image: url("../images/pages/privacy/privacy-background-1024.jpg");
    height: 600px;
  }
}
@media screen and (min-width: 1280px) {
  #privacy-header {
    background-image: url("../images/pages/privacy/privacy-background-1280.jpg");
  }
}
#privacy-header .block-type2 {
  font-size: 1.4375em;
  text-align: center;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #privacy-header .block-type2 {
    font-size: 1.5625em;
  }
}
@media screen and (min-width: 1280px) {
  #privacy-header .block-type2 {
    font-size: 1.875em;
  }
}

#privacy-container {
  font-size: 20px;
}
#privacy-container .list-item-content {
  margin-left: 5em;
}
#privacy-container .privacy-steps {
  margin-left: 10%;
}
#privacy-container .privacy-step {
  color: #ff4801;
  font-size: 25px;
  display: inline-block;
}

/* ===========
 * HEADER
 ============= */
#faq-header {
  background: url("../images/pages/faq/faq-backgorund-768.jpg") no-repeat scroll center 0;
  height: 381px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #faq-header {
    background-image: url("../images/pages/faq/faq-backgorund-1024.jpg");
    height: 398px;
  }
}
@media screen and (min-width: 1280px) {
  #faq-header {
    background-image: url("../images/pages/faq/faq-backgorund-1280.jpg");
    height: 421px;
  }
}

/* ============
 * QUESTIONS
 ============== */
.faq-category-title {
  color: #ff4801;
  border-bottom: #ff4801 solid 1px;
  font-size: 1.25em;
  padding-bottom: 14px;
  margin-bottom: 34px;
  width: 18.2em;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .faq-category-title {
    font-size: 1.5625em;
    width: 19.68em;
  }
}
@media screen and (min-width: 1280px) {
  .faq-category-title {
    font-size: 1.875em;
    width: 20em;
  }
}

.faq-questions-container {
  margin-bottom: 30px;
}
.faq-questions-container .faq-question-wrapper {
  margin-top: 18px;
  color: inherit;
}
.faq-questions-container .faq-question-wrapper:first-child {
  margin-top: 0;
}
.faq-questions-container .faq-question-wrapper .faq-question-icon {
  background: url("../images/pages/faq/question-icon.gif") no-repeat scroll 0 center;
  height: 1.0625em;
  margin: 9px 0 0 9px;
  width: 1.0625em;
  -moz-transition: transform 200ms ease;
  -webkit-transition: transform 200ms ease;
  -o-transition: transform 200ms ease;
  transition: transform 200ms ease;
}
.faq-questions-container .faq-question-wrapper .faq-question-icon.selected {
  -ms-transform: rotate(90deg);
  -webkit-transform: rotate(90deg);
  -o-transform: rotate(90deg);
  transform: rotate(90deg);
}
.faq-questions-container .faq-question-wrapper .faq-question-text {
  font-size: 1.125em;
}
.faq-questions-container .faq-answer {
  border-left: #007573 solid 0.61111em;
  display: none;
  font-size: 1.125em;
  margin: 0.66667em 0 0 4.11111em;
  padding: 0.61111em 0 0.05556em 1.66667em;
}

/* =========
 * FORM
 =========== */
#faq-form-title {
  margin-bottom: 12px;
}

#faq-form-subtitle {
  margin: 0 0 44px;
}

#faq-form-required-label {
  margin-top: 3.15385em;
  font-size: 0.8125em;
}

#faq-form-message {
  height: 122px;
  margin-bottom: 23px;
}

#faq-form-btn {
  margin-bottom: 60px;
  width: 100%;
}

/* ==========
 * HEADER
 ============ */
#accreditation-header {
  background: url("../images/pages/accreditation/accreditation-background-768.jpg") no-repeat scroll center 0;
  height: 530px;
}
@media screen and (min-width: 1024px) {
  #accreditation-header {
    background-image: url("../images/pages/accreditation/accreditation-background-1024.jpg");
    height: 600px;
  }
}
@media screen and (min-width: 1280px) {
  #accreditation-header {
    background-image: url("../images/pages/accreditation/accreditation-background-1280.jpg");
  }
}

/* ========================
 * ACCREDITATION CONTENT
 ========================== */
.accreditation-container {
  margin-bottom: 3.3125em;
}
.accreditation-container .accreditation-image {
  margin-bottom: 1.8125em;
  min-height: 185px;
  background-repeat: no-repeat;
  background-position: 0 bottom;
}
@media screen and (min-width: 1024px) {
  .accreditation-container .accreditation-image {
    background-position: center top;
    float: left;
    margin-right: 0.625em;
    width: 47%;
  }
}
.accreditation-container .accreditation-image#fimpes-logo {
  background-image: url("../images/pages/accreditation/fimpes-logo.jpg");
}
.accreditation-container .accreditation-image#anefep-logo {
  background-image: url("../images/pages/accreditation/anefep-logo.jpg");
}
.accreditation-container .accreditation-image#reniecyt-logo {
  background-image: url("../images/pages/accreditation/reniecyt-logo.jpg");
}
.accreditation-container .accreditation-image#asrsee-logo {
  background-image: url("../images/pages/accreditation/asrsee-logo.jpg");
}
.accreditation-container .accreditation-image#activate-logo {
  background-image: url("../images/pages/accreditation/activate-logo.jpg");
}
.accreditation-container .accreditation-image#case-logo {
  background-image: url("../images/pages/accreditation/case-logo.jpg");
}
.accreditation-container .accreditation-image#coepes-logo {
  background-image: url("../images/pages/accreditation/coepes-logo.jpg");
}
.accreditation-container .accreditation-image#conahec-logo {
  background-image: url("../images/pages/accreditation/conahec-logo.jpg");
}
.accreditation-container .accreditation-image#coparmex-logo {
  background-image: url("../images/pages/accreditation/coparmex-logo.jpg");
}
.accreditation-container .accreditation-image#consorcio-logo {
  background-image: url("../images/pages/accreditation/consorcio-logo.jpg");
}
@media screen and (min-width: 1024px) {
  .accreditation-container .accreditation-info {
    float: right;
    width: 50%;
  }
}
.accreditation-container .accreditation-info .accreditation-title {
  color: #007573;
  font-size: 1.5625em;
}
.accreditation-container .accreditation-info .accreditation-benefits-title {
  color: #ff4801;
  font-size: 1.25em;
}
.accreditation-container .accreditation-info ul {
  margin-left: 0;
  padding-left: 1.25em;
}

/* ===================
 *  GENERAL CLASSES
 ===================== */
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .experiences-content {
    font-size: 18px;
  }
}
@media screen and (min-width: 1280px) {
  .experiences-content {
    font-size: 20px;
  }
}
.experiences-content .experiences-title {
  border-bottom: #ff4801 solid 1px;
  color: #ff4801;
  font-size: 25px;
  padding-bottom: 20px;
  margin-bottom: 30px;
}
.experiences-content .experiences-title .experiences-title-text {
  margin: 30px 0 0 11px;
}

.experiences-description {
  font-size: 1.125em;
  padding: 1.90909em 2.09091em;
  text-align: center;
}
@media screen and (min-width: 1024px) {
  .experiences-description {
    font-size: 1.25em;
  }
}

/* ===========
 * HEADER
 ============= */
#experiences-header {
  background: url("../images/pages/experiences/experiences-background-768.jpg") no-repeat scroll center 0;
  height: 530px;
}
@media screen and (min-width: 1024px) {
  #experiences-header {
    background-image: url("../images/pages/experiences/experiences-background-1024.jpg");
    height: 600px;
  }
}
@media screen and (min-width: 1280px) {
  #experiences-header {
    background-image: url("../images/pages/experiences/experiences-background-1280.jpg");
  }
}
#experiences-header .head-block-text {
  width: 42%;
  font-size: 18px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #experiences-header .head-block-text {
    font-size: 20px;
  }
}
@media screen and (min-width: 1280px) {
  #experiences-header .head-block-text {
    font-size: 25px;
  }
}
#experiences-header #experiences-header-icons {
  font-size: 18px;
  float: right;
  width: 50%;
}
@media screen and (min-width: 1024px) {
  #experiences-header #experiences-header-icons {
    font-size: 22px;
  }
}
#experiences-header #experiences-header-icons .pull-left {
  width: 33.33%;
}
#experiences-header #experiences-header-icons .sprite {
  margin-bottom: 15px;
}

/* ==========================
 * PROFESSIONAL PRACTICES
 ============================ */
#professional-practices-row {
  padding-bottom: 0;
}

#professional-practices-image {
  background: url("../images/pages/experiences/practices-768.jpg") no-repeat scroll 0 0;
  height: 326px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #professional-practices-image {
    background-image: url("../images/pages/experiences/practices-1024.jpg");
    height: 379px;
  }
}
@media screen and (min-width: 1280px) {
  #professional-practices-image {
    background-image: url("../images/pages/experiences/practices-1280.jpg");
    height: 367px;
  }
}

.practices-icons {
  color: #ff4801;
  font-size: 1.11111em;
  margin-top: 2.5em;
}
@media screen and (min-width: 1024px) {
  .practices-icons {
    font-size: 1.22222em;
    margin-top: 1.8em;
  }
}
.practices-icons .practices-icons-text {
  margin-right: 15%;
  width: 60%;
}
.practices-icons .practices-icons-text.one-line {
  margin-top: 20px;
}

/* ================
 * CENTER BLOCKS
  ================= */
.center-block-content {
  text-align: center;
  padding-top: 3.3125em;
}
.center-block-content .community-title {
  font-size: 1.875em;
  margin-top: 0.88571em;
}
@media screen and (min-width: 1024px) {
  .center-block-content .community-title {
    font-size: 1.88889em;
    margin-top: 1.125em;
  }
}
.center-block-content .community-subtitle {
  font-size: 1.5625em;
  margin-bottom: 2.2em;
}
@media screen and (min-width: 1024px) {
  .center-block-content .community-subtitle {
    font-size: 1.875em;
    margin-bottom: 1.83333em;
  }
}

/* ============
 * TRAVELS
 ============== */
#experiences-travel-container {
  padding-bottom: 0;
}

#travels-image {
  background: url("../images/pages/experiences/travels-768.jpg") no-repeat scroll 0 0;
  height: 392px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #travels-image {
    background-image: url("../images/pages/experiences/travels-1024.jpg");
    height: 418px;
  }
}
@media screen and (min-width: 1280px) {
  #travels-image {
    background-image: url("../images/pages/experiences/travels-1280.jpg");
    height: 418px;
  }
}

/* ============
 * EXCHANGES
 ============== */
#exchanges-image {
  background: url("../images/pages/experiences/exchanges-768.jpg") no-repeat scroll 0 0;
  height: 426px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #exchanges-image {
    background-image: url("../images/pages/experiences/exchanges-1024.jpg");
  }
}
@media screen and (min-width: 1280px) {
  #exchanges-image {
    background-image: url("../images/pages/experiences/exchanges-1280.jpg");
    height: 443px;
  }
}

#advertising-header {
  background: url("../images/pages/publicity/publicity-768.jpg") no-repeat scroll center 0;
  height: 530px;
}
@media screen and (min-width: 1024px) {
  #advertising-header {
    background-image: url("../images/pages/publicity/publicity-1024.jpg");
    height: 600px;
  }
}
@media screen and (min-width: 1280px) {
  #advertising-header {
    background-image: url("../images/pages/publicity/publicity-1280.jpg");
  }
}
#advertising-header #advertising-header-text {
  font-size: 1.875em;
  line-height: 32px;
}

.advertising-wrapper {
  margin-bottom: 2em;
  padding-right: 1.25em;
  box-sizing: border-box;
  width: 229px;
}
@media screen and (min-width: 1024px) {
  .advertising-wrapper {
    width: 316px;
  }
}
@media screen and (min-width: 1280px) {
  .advertising-wrapper {
    width: 401px;
  }
}
.advertising-wrapper #advertising-audio-wrapper {
  margin-top: 5px;
  width: 76%;
}
.advertising-wrapper #advertising-audio-wrapper audio {
  width: 100%;
}
.advertising-wrapper .advertising-image {
  margin: 0.75em 0;
}
.advertising-wrapper .advertising-title {
  border-top: #ff4801 solid 2px;
  color: #007573;
  font-size: 1.375em;
  padding-top: 0.81818em;
}
@media screen and (min-width: 1024px) {
  .advertising-wrapper .advertising-title {
    font-size: 1.5625em;
    padding-top: 0.72em;
  }
}
@media screen and (min-width: 1280px) {
  .advertising-wrapper .advertising-title {
    font-size: 1.875em;
    padding-top: 0.6em;
  }
}

#portals-container {
  background: url("../images/pages/portals/portales-background-768.jpg") no-repeat scroll center 0;
  padding-top: 1px;
  margin-top: -1px;
  height: 635px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #portals-container {
    background-image: url("../images/pages/portals/portales-background-1024.jpg");
    height: 480px;
  }
}
@media screen and (min-width: 1280px) {
  #portals-container {
    background-image: url("../images/pages/portals/portales-background-1280.jpg");
    height: 480px;
  }
}
#portals-container #portals-logo {
  background: url("../images/pages/portals/logo-768.png") no-repeat scroll 0 0;
  height: 128px;
  margin: 79px auto 100px;
  width: 434px;
}
#portals-container #portals-btn-wrapper {
  margin: 0 auto;
}
#portals-container #portals-btn-wrapper .btn {
  margin: 0 0 6px 6px;
}
@media screen and (min-width: 1024px) {
  #portals-container #portals-btn-wrapper .btn {
    margin-left: 3px;
  }
}
#portals-container #portals-btn-wrapper .btn:first-child {
  margin-left: 0;
}

#not-found-container {
  background: url("../images/pages/not-found/404-768.jpg") no-repeat scroll center 0;
  box-sizing: border-box;
  padding-top: 2.5em;
  height: 19.8125em;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #not-found-container {
    height: 39.6875em;
    padding-top: 7.625em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #not-found-container {
    background-image: url("../images/pages/not-found/404-1024.jpg");
    height: 33.125em;
    padding-top: 2.6875em;
  }
}
@media screen and (min-width: 1280px) {
  #not-found-container {
    background-image: url("../images/pages/not-found/404-1280.jpg");
    height: 36.1875em;
    padding-top: 2.5em;
  }
}

#not-found-text1 {
  font-size: 1.375em;
  line-height: 1em;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #not-found-text1 {
    font-size: 2.8125em;
    line-height: 0.71111em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #not-found-text1 {
    font-size: 3.125em;
    line-height: 0.64em;
  }
}
@media screen and (min-width: 1280px) {
  #not-found-text1 {
    font-size: 3.75em;
    line-height: 0.53333em;
  }
}

#not-found-text2 {
  color: #ff4801;
  font-size: 7.8125em;
  line-height: 0.8em;
  text-shadow: 0.008em 0.008em 0.008em rgba(0, 0, 0, 0.4);
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #not-found-text2 {
    font-size: 15.625em;
    line-height: 1em;
    text-shadow: 0.004em 0.004em 0.004em rgba(0, 0, 0, 0.4);
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #not-found-text2 {
    font-size: 15.625em;
    line-height: 1em;
    text-shadow: 0.004em 0.004em 0.004em rgba(0, 0, 0, 0.4);
  }
}
@media screen and (min-width: 1280px) {
  #not-found-text2 {
    font-size: 18.75em;
    line-height: 1em;
    text-shadow: 0.00333em 0.00333em 0.00333em rgba(0, 0, 0, 0.4);
  }
}

#not-found-text3 {
  font-size: 1.5em;
  line-height: 0.66667em;
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #not-found-text3 {
    font-size: 2.8125em;
    line-height: 0.71111em;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #not-found-text3 {
    font-size: 2.5em;
    line-height: 0.8em;
  }
}
@media screen and (min-width: 1280px) {
  #not-found-text3 {
    font-size: 3.75em;
    line-height: 0.53333em;
  }
}

#not-found-text4 {
  font-size: 1em;
  line-height: 1em;
  margin-bottom: 0.875em;
}
@media screen and (min-width: 768px) {
  #not-found-text4 {
    font-size: 1.5625em;
    line-height: 1.28em;
    margin-bottom: 1.16em;
  }
}
@media screen and (min-width: 1280px) {
  #not-found-text4 {
    font-size: 2.1875em;
    line-height: 1.28571em;
    margin-bottom: 0.6em;
  }
}

.campi-wrapper {
  position: relative;
  height: 390px;
  width: 100%;
  padding-top: 200px;
}
@media screen and (min-width: 768px) {
  .campi-wrapper {
    padding-top: 0;
    height: 1180px;
  }
}

#campi-map {
  background-color: gray;
  width: 100%;
  height: 390px;
}
@media screen and (min-width: 768px) {
  #campi-map {
    height: 100%;
  }
}

.campi-selector-wrapper {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 1;
}
@media screen and (min-width: 768px) {
  .campi-selector-wrapper {
    top: 190px;
    left: 50%;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .campi-selector-wrapper {
    width: 384px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .campi-selector-wrapper {
    width: 502px;
  }
}
@media screen and (min-width: 1280px) {
  .campi-selector-wrapper {
    width: 630px;
  }
}

.campi-selector-title {
  color: #ff4801;
  font-size: 2.0625em;
}
@media screen and (max-width: 767px) {
  .campi-selector-title {
    margin: 0;
    height: 70px;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    text-align: center;
    padding-top: .45em;
  }
}
@media screen and (min-width: 768px) {
  .campi-selector-title {
    margin: .3em 0;
    color: white;
    text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.9);
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .campi-selector-title {
    font-size: 2.625em;
  }
}
@media screen and (min-width: 1024px) {
  .campi-selector-title {
    font-size: 3.125em;
  }
}

.campi-selector {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  margin: 0;
  padding: 1em 1.5em;
}
@media screen and (max-width: 767px) {
  .campi-selector {
    height: 130px;
  }
}
.campi-selector.campi-show-campus-info {
  height: auto;
}
.campi-selector.campi-show-campus-info .campi-campus-info {
  display: block;
}
@media screen and (max-width: 767px) {
  .campi-selector.campi-show-campus-info #campi-form {
    display: none;
  }
}
.campi-selector.campi-show-map .campi-campus-info-wrapper {
  display: none;
}
.campi-selector.campi-show-map .campi-view-map-buttons {
  display: block;
}

.campi-campus-info-wrapper pre {
  overflow: hidden;
}
.campi-campus-info-wrapper .label {
  color: #ffffff;
}

.campi-campus-info {
  display: none;
}
@media screen and (max-width: 767px) {
  .campi-campus-info p {
    font-size: 0.9375em;
  }
}

.campi-campus-info-name {
  font-size: 1.4375em;
  border-bottom: 1px solid white;
  padding-bottom: .3em;
}
@media screen and (min-width: 768px) {
  .campi-campus-info-name {
    font-size: 2.1875em;
  }
}

.campi-share-campus-buttons {
  margin: .5em 0 1.5em;
}

.campi-campus-info-buttons .btn {
  width: 100%;
  margin: .2em 0;
  text-align: center;
}

.campi-view-map-buttons {
  display: none;
}

.campi-view-map-buttons {
  text-align: center;
  padding-top: 2px;
}
.campi-view-map-buttons .btn {
  display: inline-block;
  padding: .8em 1em;
  margin: .1em 0;
  line-height: normal;
  font-size: 0.9375em;
}
.campi-view-map-buttons .btn small {
  text-transform: none;
  font-size: .9em;
}

.campi-careers-wrapper {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  /* from-tablet */
  /* from-small-desktop */
  /* large-desktop */
  display: none;
  position: absolute;
  bottom: 25px;
  left: 0;
  width: 100%;
  margin: 0;
  overflow: auto;
  height: 270px;
  padding: .5em 1.5em 0;
  z-index: 1;
}
@media screen and (min-width: 768px) {
  .campi-careers-wrapper {
    width: 768px;
  }
}
@media screen and (min-width: 1024px) {
  .campi-careers-wrapper {
    width: 1004px;
  }
}
@media screen and (min-width: 1280px) {
  .campi-careers-wrapper {
    width: 1260px;
  }
}
@media screen and (max-width: 767px) {
  .campi-careers-wrapper {
    bottom: auto;
    height: 590px;
    top: 0;
  }
}
@media screen and (min-width: 768px) {
  .campi-careers-wrapper {
    left: 50%;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .campi-careers-wrapper {
    margin-left: -384px;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .campi-careers-wrapper {
    margin-left: -502px;
  }
}
@media screen and (min-width: 1280px) {
  .campi-careers-wrapper {
    margin-left: -630px;
  }
}
.campi-careers-wrapper ul {
  float: none !important;
  width: auto !important;
}
.campi-careers-wrapper .btn {
  width: 100%;
  text-align: center;
}

ul.campi-degrees {
  list-style: none;
  padding: 0;
  margin: 0;
}
ul.campi-degrees:before, ul.campi-degrees:after {
  content: " ";
  display: table;
}
ul.campi-degrees:after {
  clear: both;
}
@media screen and (min-width: 768px) {
  ul.campi-degrees > li {
    float: left;
    margin: 0 .5em;
  }
  ul.campi-degrees > li:first-child {
    margin-left: 0;
  }
}

.campi-careers-title {
  font-size: 1.5625em;
  border-bottom: 1px solid white;
  padding-bottom: .4em;
  margin-bottom: .8em;
}

.campi-careers-sub-title {
  font-size: 0.75em;
  font-weight: normal;
}

.campi-degree-name {
  border-bottom: 1px solid white;
  line-height: 3.125em;
}
.campi-degree-name:before, .campi-degree-name:after {
  content: " ";
  display: table;
}
.campi-degree-name:after {
  clear: both;
}
@media screen and (max-width: 767px) {
  .campi-degree-name {
    font-size: 1.25em;
    display: block;
  }
}
@media screen and (min-width: 768px) {
  .campi-degree-name {
    border: 1px solid #ff4801;
    color: #fabc90 !important;
    padding: .4em 1em;
    display: inline-block;
    line-height: normal;
  }
  .campi-degree-name.active {
    border-color: white;
    color: white !important;
  }
}
.campi-degree-name.active .sprite-dropdown-arrow {
  display: none;
}
.campi-degree-name .sprite-dropdown-arrow {
  margin-top: 10px;
}

.campi-degree-careers {
  display: none;
}
.campi-degree-careers ul {
  list-style: disc;
  padding-left: 1em;
}
.campi-degree-careers ul li {
  margin: .2em 0;
}
@media screen and (min-width: 768px) {
  .campi-degree-careers {
    position: absolute;
    left: 0;
    top: 140px;
    width: 100%;
  }
  .campi-degree-careers ul {
    float: left !important;
    padding-left: 2.5em;
    width: 33.33% !important;
  }
}

/**
 * Set the "width" property for the calendar months block.
 */
/* Section header */
#calendar-header {
  background-image: url("../images/calendar/head-banner-tablet.jpg");
  background-position: center top;
  height: 445px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #calendar-header {
    background-image: url("../images/calendar/head-banner-small-desktop.jpg");
  }
}
@media screen and (min-width: 1280px) {
  #calendar-header {
    background-image: url("../images/calendar/head-banner-large-desktop.jpg");
  }
}

/* Pull up the calendar to overlap the banner */
.calendar-content-block {
  margin-top: -60px;
  padding-bottom: 60px;
}

/* This element wraps the entire calendar table */
.calendar-table {
  font-size: 0.8125em;
  margin-left: -1px;
  width: 729px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .calendar-table {
    font-size: 0.875em;
    width: 985px;
  }
}
@media screen and (min-width: 1280px) {
  .calendar-table {
    font-size: 0.875em;
    width: 1241px;
  }
}

.ie8 .calendar-table {
  font-size: 13px !important;
}

/* This element wraps only the calendar header */
.calendar-table-head .ctc {
  background-color: #007573;
  color: white;
  font-size: 1.23077em;
  line-height: 61px;
  text-align: center;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .calendar-table-head .ctc {
    font-size: 1.42857em;
  }
}
@media screen and (min-width: 1280px) {
  .calendar-table-head .ctc {
    font-size: 1.57143em;
  }
}

/*
 * Calendar Table Cell
 * Note: "ctc" means "calendar-table-cell"
 */
.ctc {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  float: left;
  margin-bottom: 1px;
  margin-left: 1px;
  overflow: hidden;
  white-space: nowrap;
}
.ctc:first-child {
  margin-left: 0;
}

/*
 * Cell widths
 * Note: "ctc" prefix means: "calendar-table-cell"
 */
.ctc-career-mode {
  width: 81px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .ctc-career-mode {
    width: 111px;
  }
}
@media screen and (min-width: 1280px) {
  .ctc-career-mode {
    width: 151px;
  }
}

.ctc-degree {
  width: 59px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .ctc-degree {
    width: 124px;
  }
}
@media screen and (min-width: 1280px) {
  .ctc-degree {
    width: 210px;
  }
}

.ctc-step {
  width: 154px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .ctc-step {
    width: 174px;
  }
}
@media screen and (min-width: 1280px) {
  .ctc-step {
    width: 234px;
  }
}

.ctc-dates {
  width: 143px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .ctc-dates {
    width: 163px;
  }
}
@media screen and (min-width: 1280px) {
  .ctc-dates {
    width: 186px;
  }
}

.ctc-month {
  text-transform: capitalize;
  width: 47px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .ctc-month {
    width: 67px;
  }
}
@media screen and (min-width: 1280px) {
  .ctc-month {
    width: 75px;
  }
}

.ct-career-mode {
  margin-bottom: 7px;
}

.ct-career-mode-title {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  background-position: center 100px;
  background-repeat: no-repeat;
  border-bottom: 6px solid white;
  color: white;
  height: 100%;
  font-size: 1.5625em;
  text-indent: 100%;
  white-space: nowrap;
}
.ct-career-mode-title.presencial {
  background-color: #ff4801;
  background-image: url("../images/calendar/presencial-tablet.png");
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .ct-career-mode-title.presencial {
    background-image: url("../images/calendar/presencial-small-desktop.png");
  }
}
@media screen and (min-width: 1280px) {
  .ct-career-mode-title.presencial {
    background-image: url("../images/calendar/presencial-large-desktop.png");
  }
}
.ct-career-mode-title.ejecutiva {
  background-color: #ff9167;
  background-image: url("../images/calendar/ejecutiva-tablet.png");
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .ct-career-mode-title.ejecutiva {
    background-image: url("../images/calendar/ejecutiva-small-desktop.png");
  }
}
@media screen and (min-width: 1280px) {
  .ct-career-mode-title.ejecutiva {
    background-image: url("../images/calendar/ejecutiva-large-desktop.png");
  }
}
.ct-career-mode-title.online {
  background-color: #2bcfa3;
  background-image: url("../images/calendar/online-tablet.png");
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .ct-career-mode-title.online {
    background-image: url("../images/calendar/online-small-desktop.png");
  }
}
@media screen and (min-width: 1280px) {
  .ct-career-mode-title.online {
    background-image: url("../images/calendar/online-large-desktop.png");
  }
}

.ct-degree {
  margin-bottom: 3px;
}
.ct-degree.calendar-even .ct-degree-title {
  background-color: #e1e1e1;
}

.ct-degree-title {
  background-color: #efefef;
  height: 139px;
  text-transform: uppercase;
}
@media screen and (min-width: 1024px) {
  .ct-degree-title {
    padding: .5em 0 0 .8em;
  }
}
@media screen and (min-width: 1280px) {
  .ct-degree-title {
    font-size: 1.25em;
  }
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  .ct-degree-title {
    padding-top: 60px;
  }
  .ct-degree-title .ct-degree-title-rotate {
    -moz-transform: rotate(-90deg);
    -ms-transform: rotate(-90deg);
    -webkit-transform: rotate(-90deg);
    transform: rotate(-90deg);
  }
}

.ct-step {
  line-height: 34px;
  text-transform: uppercase;
}
.ct-step.ct-step-0 .ct-week.ct-week-active {
  background-color: #ff4801 !important;
}
.ct-step.ct-step-1 .ct-week.ct-week-active {
  background-color: #007573 !important;
}
.ct-step.ct-step-2 .ct-week.ct-week-active {
  background-color: #ff9167 !important;
}
.ct-step.ct-step-3 .ct-week.ct-week-active {
  background-color: #007573 !important;
}
.ct-step.calendar-even .ctc-step {
  background-color: #efefef;
}
.ct-step.calendar-even .ctc-dates {
  background-color: #e1e1e1;
}
.ct-step.calendar-even .ct-week {
  background-color: #e1e1e1;
}
.ct-step.calendar-even .ct-week.ct-week-group {
  background-color: #bcbcbc;
}
.ct-step .ctc-step {
  padding-left: .8em;
}
.ct-step .ctc-dates {
  background-color: #efefef;
  padding-left: .9em;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .ct-step .ctc-dates {
    padding-left: 1.2em;
  }
}
@media screen and (min-width: 1280px) {
  .ct-step .ctc-dates {
    padding-left: .45em;
  }
}
.ct-step .ct-week {
  background-color: #efefef;
  width: 11px;
  height: 34px;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .ct-step .ct-week {
    width: 16px;
  }
}
@media screen and (min-width: 1280px) {
  .ct-step .ct-week {
    width: 18px;
  }
}
.ct-step .ct-week.ct-week-group {
  background-color: #d4d4d4;
}
.ct-step .ct-week.ct-week-active {
  background: #007573;
}

.calendar-period.small {
  font-size: .8em;
}

html, body {
  height: 100%;
}

#root {
  clear: both;
  min-height: 100%;
  height: auto !important;
  height: 100%;
  margin-bottom: -500px;
}
#root #root_footer {
  height: 500px;
}

#footer {
  clear: both;
  position: relative;
  height: 500px;
}

/* ----------------------------------------------------------------------------------
 * Footer
 */
#footer {
  background-color: #ff4801;
  color: white;
  /* mobile */
}
@media screen and (max-width: 767px) {
  #footer {
    text-align: center;
  }
}

/* #footer */
#footer-logo {
  position: absolute;
  width: 8.75em;
  top: -1.25em;
  -moz-box-shadow: 0 8px 8px rgba(0, 0, 0, 0.5);
  -webkit-box-shadow: 0 8px 8px rgba(0, 0, 0, 0.5);
  box-shadow: 0 8px 8px rgba(0, 0, 0, 0.5);
  /* img */
}
#footer-logo img {
  display: block;
  width: 100%;
}

/* #footer-logo */
/* ----------------------------------------------------------------------------------
 * Footer Top
 */
#footer-top {
  /* from-tablet */
  /* small-desktop */
  /* large-desktop */
}
@media screen and (min-width: 768px) {
  #footer-top {
    margin-left: 10.625em;
  }
  #footer-top:before, #footer-top:after {
    content: " ";
    display: table;
  }
  #footer-top:after {
    clear: both;
  }
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #footer-top {
    margin-left: 19.75em;
  }
}
@media screen and (min-width: 1280px) {
  #footer-top {
    margin-left: 20.625em;
  }
}

/* #footer-top */
#footer-social-networks, #footer-phone-wrapper {
  font-family: 'ProximaNova-Regular';
  padding-top: 2.1875em;
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  #footer-social-networks, #footer-phone-wrapper {
    padding-top: 3.125em;
  }
}

/* #footer-social-networks, #footer-phone-wrapper */
#footer-social-networks {
  color: white;
  /* from-tablet */
  /* ul */
}
@media screen and (min-width: 768px) {
  #footer-social-networks {
    float: right;
  }
}
#footer-social-networks ul {
  display: inline-block;
  list-style: none;
  padding: 0;
  margin: 0;
  /* li */
}
#footer-social-networks ul:before, #footer-social-networks ul:after {
  content: " ";
  display: table;
}
#footer-social-networks ul:after {
  clear: both;
}
#footer-social-networks ul li {
  float: left;
  margin-left: 0.5em;
  /* &:first-child */
}
#footer-social-networks ul li:first-child {
  margin-left: 0;
}

/* #footer-social-networks */
#footer-social-networks-title {
  font-size: 1.25em;
  margin-right: 0.5em;
  /* from-small-desktop */
}
@media screen and (min-width: 1024px) {
  #footer-social-networks-title {
    font-size: 1.875em;
  }
}

/* #footer-social-networks-title */
#footer-phone-wrapper {
  color: white;
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  #footer-phone-wrapper {
    color: white;
    float: left;
  }
}

/* #footer-phone-wrapper */
#footer-phone-text {
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  #footer-phone-text {
    display: inline-block;
    vertical-align: middle;
  }
}

/* #footer-phone-text */
.sprite-footer-phone {
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  .sprite-footer-phone {
    margin-right: 1.25em;
  }
}

/* .sprite-footer-phone */
#footer-phone-lada {
  font-size: 0.9375em;
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  #footer-phone-lada {
    font-size: 0.9375em;
    line-height: 1em;
  }
}

/* #footer-phone-lada */
#footer-phone-number {
  font-size: 1.875em;
  line-height: .75em;
  /* tablet */
  /* from-tablet */
  /* from-small-desktop */
}
@media screen and (min-width: 768px) and (max-width: 1023px) {
  #footer-phone-number {
    font-size: 1.875em;
    line-height: 1em;
  }
}
@media screen and (min-width: 1024px) {
  #footer-phone-number {
    font-size: 1.875em;
  }
}

/* #footer-phone-number */
/* ----------------------------------------------------------------------------------
 * Footer Body
 */
#footer-body {
  /* small-desktop */
  /* large-desktop */
  padding-top: 3.75em;
  padding-bottom: 2em;
  /* from-small-desktop */
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  #footer-body {
    margin-left: 19.75em;
  }
}
@media screen and (min-width: 1280px) {
  #footer-body {
    margin-left: 20.625em;
  }
}
#footer-body:before, #footer-body:after {
  content: " ";
  display: table;
}
#footer-body:after {
  clear: both;
}
@media screen and (min-width: 1024px) {
  #footer-body {
    padding-top: 2.5em;
  }
}

/* #footer-body */
.footer-links-list {
  float: left;
  width: 9.6875em;
  margin-left: 2.1875em;
  /* &:first-child */
  /* small-desktop */
  /* large-desktop */
  /* ul */
  /* a */
}
.footer-links-list:first-child {
  margin-left: 0;
}
@media screen and (min-width: 1024px) and (max-width: 1279px) {
  .footer-links-list {
    margin-left: 0.875em;
  }
}
@media screen and (min-width: 1280px) {
  .footer-links-list {
    margin-left: 5.9375em;
  }
}
.footer-links-list ul {
  list-style: none;
  padding: 0;
  margin: 0;
}
.footer-links-list a {
  color: white;
  font-size: 0.875em;
  /* from-small-desktop */
}
@media screen and (min-width: 1024px) {
  .footer-links-list a {
    /* &:hover */
  }
  .footer-links-list a:hover {
    color: #007573;
    text-decoration: underline;
  }
}

/* .footer-links-list */
.footer-links-list-title {
  color: white;
  display: inline-block;
  font-size: 0.9375em;
  font-weight: normal;
  height: 2.5em;
}

/* .footer-links-list-title */
/* ----------------------------------------------------------------------------------
 * IEU Logo Mobile
 */
.sprite-footer-logo-mobile {
  margin-top: 20px;
}

/* .sprite-footer-logo-mobile */
/* ----------------------------------------------------------------------------------
 * Footer Inception
 */
#footer-footer {
  padding: 1em 0 2.5em;
  background-color: #ff9167;
  position: absolute;
  bottom: 0;
  width: 100%;
  height: auto;
  /* from-tablet */
}
#footer-footer:before, #footer-footer:after {
  content: " ";
  display: table;
}
#footer-footer:after {
  clear: both;
}
@media screen and (min-width: 768px) {
  #footer-footer {
    padding: 0;
    height: 6.875em;
  }
}

/* #footer-footer */
#footer-footer-copyright {
  font-size: 0.875em;
  /* from-tablet */
}
@media screen and (min-width: 768px) {
  #footer-footer-copyright {
    float: left;
    line-height: 7.85714em;
  }
}

/* #footer-copyright */
#footer-footer-links {
  float: right;
  position: absolute;
  right: 1em;
  /* ul */
  /* li */
  /* a */
}
#footer-footer-links ul {
  list-style: none;
  margin: 0;
  padding: 0;
}
#footer-footer-links ul:before, #footer-footer-links ul:after {
  content: " ";
  display: table;
}
#footer-footer-links ul:after {
  clear: both;
}
#footer-footer-links li {
  float: left;
  margin: 1em 0 0 1.875em;
}
#footer-footer-links a {
  color: white;
  font-size: 1em;
  /* from-small-desktop */
}
@media screen and (min-width: 1024px) {
  #footer-footer-links a {
    /* &:hover */
  }
  #footer-footer-links a:hover {
    color: #007573;
  }
}

/* #footer-footer-links */
#contact-footer-button {
  display: none;
}
@media screen and (min-width: 768px) {
  #contact-footer-button {
    background: url("../images/contact/contact-button.png") no-repeat scroll 0 0 transparent;
    bottom: 0;
    display: block;
    height: 48px;
    position: fixed;
    right: 200px;
    width: 316px;
    z-index: 100;
  }
}
@media screen and (min-width: 768px) {
  #contact-footer-button:hover {
    background-position: 0 bottom;
    height: 63px;
  }
}
