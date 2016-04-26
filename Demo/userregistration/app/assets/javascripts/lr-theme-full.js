//customization
var j = jQuery.noConflict();
j(document).ready(function() {
	j("#fade").click(function() {
		j('#fade').hide();
	});
	show_birthdate_date_block();
	LoginRadiusRaaS.$hooks.setProcessHook(function() {
		lrThemeSettings.form_render_submit_hook.start();
	}, function() {
		lrThemeSettings.form_render_submit_hook.end();
	});
	if (isloggedin != "true") {
		LoginRadiusRaaS.CustomInterface(".interfacecontainerdiv", raasoption);
	}
	LrRaasTheme.init();
});
var raasoption = {};
raasoption.apikey = lrThemeSettings.raasoption.apikey;
raasoption.appname = lrThemeSettings.raasoption.appname;
raasoption.emailVerificationUrl = lrThemeSettings.raasoption.emailVerificationUrl;
raasoption.forgotPasswordUrl = lrThemeSettings.raasoption.forgotPasswordUrl;

if (navigator.userAgent.match('CriOS')) {
	raasoption.templatename = "loginradiuscustom_tmpl_IOS";
} else {
	raasoption.templatename = "loginradiuscustom_tmpl";
}
raasoption.hashTemplate = true;
raasoption.V2Recaptcha = true;

if (lrThemeSettings.auto_login_after_verify_email) {
	raasoption.enableLoginOnEmailVerification = true;
} else {
	raasoption.enableLoginOnEmailVerification = false;
}
var LrRaasTheme = {
	init : function(body) {
		this.createParent();
		this.appendOverlayDiv();
		if (isloggedin != "true") {
			this.createPopup('register');
			this.createPopup('login');
			this.createPopup('forgot');
			this.raasFormInject();
			this.appendFooter();
		}

	},
	appendOverlayDiv : function() {
		var div = document.createElement('div');
		div.id = 'lr-overlay';
		document.getElementById('lr-pop-group').appendChild(div);
	},
	createParent : function() {
		var group = document.createElement('div');
		group.id = 'lr-pop-group';
		document.body.appendChild(group);
	},
	createPopup : function(action) {
		var div = document.createElement('div');
		var header_div;
		var body_div;
		var footer_div;

		switch(action) {
		case 'register':
			div.id = 'lr-register-container';
			div.className = 'lr-popup-container';
			header_div = this.createHeader(lrThemeSettings.caption_message.register);

			break;

		case 'login':
			div.id = 'lr-login-container';
			div.className = 'lr-popup-container';
			header_div = this.createHeader(lrThemeSettings.caption_message.login);

			break;

		case 'forgot':
			div.id = 'lr-fp-container';
			div.className = 'lr-popup-container';
			header_div = this.createHeader(lrThemeSettings.caption_message.forgot_password);

			break;

		case 'reset':
			div.id = 'lr-rp-container';
			div.className = 'lr-popup-container';
			header_div = this.createHeader(lrThemeSettings.caption_message.reset_password);

			break;

		case 'social':
			div.id = 'lr-social-container';
			div.className = 'lr-popup-container';
			header_div = this.createHeader(lrThemeSettings.caption_message.fields_missing);

			break;

		default:
			break;
		}

		body_div = this.createBody(action);
		div.appendChild(header_div);
		div.appendChild(body_div);

		document.getElementById('lr-pop-group').appendChild(div);
	},
	createHeader : function(message) {
		var div = document.createElement('div');
		div.className = 'lr-popup-header';
		//the close btn
		var closeSpan = document.createElement('span');
		closeSpan.className = 'lr-popup-close-span';
		closeSpan.innerHTML = '<a class="lr-popup-close-btn" onclick="LrRaasTheme.closeAllPopups()">&#215</a>';
		div.appendChild(closeSpan);
		//customizable logo section
		var logo_div = document.createElement('div');
		logo_div.className = 'lr-header-logo';
		logo_div.innerHTML = '<img src="' + lrThemeSettings.logo.logo_image_path + '" alt="' + lrThemeSettings.logo.logo_alt_text + '" class="lr-header-logo-img" />';
		logo_div.innerHTML += '<p class="lr-header-caption">' + message + '</p>';
		div.appendChild(logo_div);

		return div;
	},
	createBody : function(action) {
		var div = document.createElement('div');
		div.id = 'lr-popup-body-container';

		var message_header = document.createElement('div');
		message_header.id = 'lr-' + action + '-popup-message';
		message_header.className = 'lr-popup-message';

		div.appendChild(message_header);

		switch(action) {
		case 'register':
		case 'login':
			var social_div = document.createElement('div');
			social_div.className = 'interfacecontainerdiv lr-sl-shaded-brick-frame lr-column';
			var reg_div = document.createElement('div');
			reg_div.id = action + '-div';
			reg_div.className = 'lr-column';

			div.appendChild(social_div);
			div.appendChild(reg_div);

			break;

		case 'forgot':
		case 'reset':
			var fp_div = document.createElement('div');
			fp_div.id = action + 'password-div';
			div.appendChild(fp_div);

			break;

		case 'social':
			var social_div = document.createElement('div');
			social_div.id = 'sociallogin-container';
			div.appendChild(social_div);
			break;

		default:
			break;
		}

		return div;
	},
	createFooter : function(action) {
		var div = document.createElement('div');
		div.id = 'lr-popup-footer';
		div.className = 'lr-popup-footer';
		switch(action) {

		case 'register':
			div.innerHTML = "<a class='lr-raas-theme-fp'>Forgot Password</a> <a class='lr-raas-theme-login'>Login</a>";
			break;
		case 'forgot':
		case 'reset':
			div.innerHTML = "<a class='lr-raas-theme-login'>Login</a>";
			break;
		case 'login':
			div.innerHTML = "<a class='lr-raas-theme-fp'>Forgot Password</a> <a class='lr-raas-theme-register'>Register</a>";
			break;
		default:
			break;
		}

		return div;
	},
	raasFormInject : function() {
		$SL.util.ready(function() {
			LoginRadiusRaaS.init(raasoption, 'registration', function(response) {
				var message_header = document.getElementById('lr-register-popup-message');
				message_header.innerHTML = lrThemeSettings.success_message.register;
				showpopupmessage();
				j('input[type=text],input[type=password],select').val('');
			}, function(errors) {
				var message_header = document.getElementById('lr-register-popup-message');
				message_header.innerHTML = errors[0].description?errors[0].description:errors[0].message;
				showpopupmessage();
			}, "register-div");

			LoginRadiusRaaS.init(raasoption, 'login', function(response) {
				var message_header = document.getElementById('lr-login-popup-message');
				message_header.innerHTML = lrThemeSettings.success_message.login;
				redirect(response.access_token);
				showpopupmessage();
				j('input[type=text],input[type=password],select').val('');
			}, function(errors) {
				var message_header = document.getElementById('lr-login-popup-message');
				message_header.innerHTML = errors[0].description?errors[0].description:errors[0].message;
				showpopupmessage();
			}, "login-div");

			LoginRadiusRaaS.init(raasoption, 'sociallogin', function(response) {

				var social_message_header = document.getElementById('lr-social-popup-message');
				if (document.getElementById('loginradius-raas-social-registration-emailid')) {
					if (social_message_header) {
						social_message_header.innerHTML = lrThemeSettings.success_message.register;
						showpopupmessage();
						j('input[type=text],input[type=password],select').val('');
					}

				} else {
					if (social_message_header) {
						social_message_header.innerHTML = lrThemeSettings.success_message.social_login;
						showpopupmessage();
						j('input[type=text],input[type=password],select').val('');
					}
				}
				if (!response.isPosted) {
					redirect(response);
				} else {
					var sociallogin_container = document.getElementById('sociallogin-container');
					sociallogin_container.innerHTML = '';
				}
				//lrThemeSettings.success_function.social_login();
			}, function(errors) {

				var login_message_header = document.getElementById('lr-login-popup-message');
				var register_message_header = document.getElementById('lr-register-popup-message');
				var sociallogin_message_header = document.getElementById('lr-social-popup-message');
				if (login_message_header != null) {
					login_message_header.innerHTML = errors[0].description?errors[0].description:errors[0].message;
					showpopupmessage();
				}
				if (register_message_header != null) {
					register_message_header.innerHTML = errors[0].description?errors[0].description:errors[0].message;
					showpopupmessage();
				}
				if (sociallogin_message_header != null) {
					sociallogin_message_header.innerHTML = errors[0].description?errors[0].description:errors[0].message;
					showpopupmessage();
				}

			}, "sociallogin-container");

			LoginRadiusRaaS.$hooks.socialLogin.onFormRender = function() {
				LrRaasTheme.createPopup('social');
				LrRaasTheme.showPopup('lr-social-container');
			};

			LoginRadiusRaaS.init(raasoption, 'forgotpassword', function(response) {
				var message_header = document.getElementById('lr-forgot-popup-message');
				message_header.innerHTML = lrThemeSettings.success_message.forgot_password;
				lrThemeSettings.success_function.forgot_password();
				showpopupmessage();
				j('input[type=text],input[type=password],select').val('');
			}, function(errors) {
				var message_header = document.getElementById('lr-forgot-popup-message');
				message_header.innerHTML = errors[0].description?errors[0].description:errors[0].message;
				showpopupmessage();
			}, "forgotpassword-div");
			show_birthdate_date_block();
			var params = LrRaasTheme.getUrlParameters();
			for (var key in params ) {
				if ('emailverification' == params[key]) {
					LoginRadiusRaaS.init(raasoption, 'emailverification', function(response) {
						if (raasoption.enableLoginOnEmailVerification) {
							if (response.access_token != null && response.access_token != "") {
								LrRaasTheme.showPopup('lr-login-container');
								var message_header = document.getElementById('lr-login-popup-message');
								message_header.innerHTML = lrThemeSettings.success_message.verify_email;
								showpopupmessage();
								redirect(response);
							} else {
								LrRaasTheme.showPopup('lr-login-container');
								var message_header = document.getElementById('lr-login-popup-message');
								message_header.innerHTML = lrThemeSettings.success_message.email_verified;
								showpopupmessage();
							}
						} else {
							LrRaasTheme.showPopup('lr-login-container');
							var message_header = document.getElementById('lr-login-popup-message');
							handleResponse(true, lrThemeSettings.success_message.verify_email);
							message_header.innerHTML = lrThemeSettings.success_message.verify_email;
							showpopupmessage();
						}
						j('input[type=text],input[type=password],select').val('');
						j('#fade').hide();
					}, function(errors) {

						LrRaasTheme.showPopup('lr-login-container');
						var message_header = document.getElementById('lr-login-popup-message');
						message_header.innerHTML = errors[0].description?errors[0].description:errors[0].message;
						showpopupmessage();
					});
				} else if ('reset' == params[key]) {
					LrRaasTheme.createPopup('reset');
					LoginRadiusRaaS.init(raasoption, 'resetpassword', function(response) {
						var message_header = document.getElementById('lr-reset-popup-message');
						message_header.innerHTML = lrThemeSettings.success_message.reset_password;
						lrThemeSettings.success_function.reset_password();
						showpopupmessage();
						setTimeout(function() {
							var port = '';
							if(window.location.port != '80'){
								port = ':'+window.location.port;
							}
							window.location.href = location.protocol.concat("//").concat(window.location.hostname)+port;
						}, 10000);
						j('input[type=text],input[type=password],select').val('');
					}, function(errors) {
						var message_header = document.getElementById('lr-reset-popup-message');
						message_header.innerHTML = errors[0].description?errors[0].description:errors[0].message;
						showpopupmessage();
					}, "resetpassword-div");

					LrRaasTheme.showPopup('lr-rp-container');
				} else {
					return true;
				}
			}

		});
	},
	appendFooter : function() {
		var reg_form = document.getElementsByName('loginradius-raas-registration');
		var login_form = document.getElementsByName('loginradius-raas-login');
		var forgot_form = document.getElementsByName('loginradius-raas-forgotpassword');
		var reset_form = document.getElementsByName('loginradius-raas-resetpassword');

		var login_form_interval = setInterval(function() {
			if (document.readyState !== 'complete')
				return;
			clearInterval(login_form_interval);
			var registration_footer_div = LrRaasTheme.createFooter('register');
			reg_form[0].appendChild(registration_footer_div);

			var login_footer_div = LrRaasTheme.createFooter('login');
			login_form[0].appendChild(login_footer_div);

			var forgot_footer_div = LrRaasTheme.createFooter('forgot');
			forgot_form[0].appendChild(forgot_footer_div);

			var reset_footer_div = LrRaasTheme.createFooter('reset');
			if (reset_form[0]) {
				reset_form[0].appendChild(reset_footer_div);
			}
			LrRaasTheme.addClassListener();
			j('#fade').hide();
		}, 2000);
	},
	showPopup : function(popup_id) {
		j('.lr-popup-message').hide();
		console.log(popup_id);
		this.closeAllPopups();
		this.clearAllMessages();
		this.showOverlay();

		var pop = document.getElementById(popup_id);
		pop.className = pop.className + " lr-show";
	},
	hideOverlay : function() {
		document.getElementById('lr-overlay').className = '';
		document.getElementById('lr-pop-group').className = '';
	},
	showOverlay : function() {
		document.getElementById('lr-overlay').className = 'lr-show-layover';
		document.getElementById('lr-pop-group').className = 'lr-show-layover';
	},
	resetAllPopups : function() {
		var form_list = ['loginradius-raas-registration', 'loginradius-raas-login', 'loginradius-raas-forgotpassword'];
		for (var i = 0; i < form_list.length; i++) {
			var form = document.getElementsByName(form_list[i]);
			form[0].reset();
		}
	},
	closeAllPopups : function() {
		if (lrThemeSettings.reset_form_after_close_popup) {
			this.resetAllPopups
		};
		this.hideOverlay();
		var popups = document.getElementsByClassName("lr-popup-container");
		for (var i = 0; i < popups.length; i++) {
			popups[i].className = "lr-popup-container";
		}
	},
	clearAllMessages : function() {
		var message_headers = document.getElementsByClassName('lr-popup-message');
		for (var i = 0; i < message_headers.length; i++) {
			message_headers[i].innerHTML = "";
		}
	},
	addClassListener : function() {
		document.getElementById('lr-overlay').addEventListener("click", function() {
			LrRaasTheme.closeAllPopups();
		});
		var closeBtnClass = document.getElementsByClassName("lr-popup-close-btn");
		for (var i = 0; i < closeBtnClass.length; i++) {
			closeBtnClass[i].addEventListener("click", function(event) {
				LrRaasTheme.closeAllPopups();
				return false;
			});
		}

		var lrSignupClass = document.getElementsByClassName("lr-raas-theme-register");
		for (var i = 0; i < lrSignupClass.length; i++) {
			lrSignupClass[i].addEventListener("click", function(event) {
				LrRaasTheme.showPopup('lr-register-container');
				return false;
			});
		}

		var lrLoginClass = document.getElementsByClassName("lr-raas-theme-login");
		for (var i = 0; i < lrLoginClass.length; i++) {
			lrLoginClass[i].addEventListener("click", function(event) {
				LrRaasTheme.showPopup('lr-login-container');
				return false;
			});
		}

		var fpClass = document.getElementsByClassName("lr-raas-theme-fp");
		for (var i = 0; i < fpClass.length; i++) {
			fpClass[i].addEventListener("click", function(event) {
				LrRaasTheme.showPopup('lr-fp-container');
				return false;
			});
		}
	},
	getUrlParameters : function() {
		var prmstr = window.location.search.substr(1);
		return prmstr != null && prmstr != "" ? this.transformToAssocArray(prmstr) : {};
	},
	transformToAssocArray : function(prmstr) {
		var params = {};
		var prm_array = prmstr.split("&");
		for (var i = 0; i < prm_array.length; i++) {
			var tmp_array = prm_array[i].split("=");
			params[tmp_array[0]] = tmp_array[1];
		}

		return params;
	}
};
function show_birthdate_date_block() {
	var maxYear = new Date().getFullYear();
    var minYear = maxYear - 100;
    $('body').on('focus', ".loginradius-raas-birthdate", function () {
        $('.loginradius-raas-birthdate').datepicker({
            dateFormat: 'mm-dd-yy',
            maxDate:  new Date(),
            minDate: "-100y",
            changeMonth: true,
            changeYear: true,
            yearRange: (minYear + ":" + maxYear)
        });
    });
}

//Customizing
//
function redirect(token, name) {
	var port = '';
	if(window.location.port != '80'){
		port = ':'+window.location.port;
	}
	var token_name = name ? name : 'token';
	var form = document.createElement('form');
	form.action = location.protocol.concat("//").concat(window.location.hostname)+port+'/callback';
	form.method = 'POST';

	var hiddenToken = document.createElement('input');
	hiddenToken.type = 'hidden';
	hiddenToken.value = token;
	hiddenToken.name = token_name;
	form.appendChild(hiddenToken);

	document.body.appendChild(form);
	form.submit();
}

function get_form_for_hidden_value(array) {
	var form = document.createElement('form');
	var key;
	form.action = '';
	form.method = 'POST';
	for (key in array) {
		var hiddenToken = document.createElement('input');
		hiddenToken.type = 'hidden';
		hiddenToken.value = array[key];
		hiddenToken.name = key;
		form.appendChild(hiddenToken);
	}
	document.body.appendChild(form);
	form.submit();
}

function linking() {
	j(".lr-linked-data, .lr-unlinked-data").html('');
	j(".lr-linked").each(function() {
		j(".lr-linked-data").append(j(this).html());
	});
	j(".lr-unlinked").each(function() {
		j(".lr-unlinked-data").append(j(this).html());
	});
	var linked_val = j('.lr-linked-data').html();
	var unlinked_val = j('.lr-unlinked-data').html();
	if (linked_val != '') {

		j(".lr-linked-data").prepend('<div class="lr-heading">Linked Accounts</div>');
	}
	if (unlinked_val != '') {
		j(".lr-unlinked-data").prepend('<div class="lr-heading lr-heading-small">Choose a social account to link</div>');
	}
	j('#interfacecontainerdiv').hide();
}

function unLinkAccount(name, id) {
	handleResponse(true, "");
	if (confirm('Are you sure you want to unlink!')) {
		j('#fade').show();
		var array = {};
		array['value'] = 'accountUnLink';
		array['provider'] = name;
		array['providerId'] = id;
		get_form_for_hidden_value(array);
	} else {
		j('#fade').hide();
	}
}


j(document).ready(function() {
	j('.lr-menu-buttons .lr-buttons').click(function() {
		var dataTab = j(this).attr("data-tab");
		j('.lr-menu-buttons .lr-buttons').removeClass('lr-tab-active');
		j('.lr-frame').removeClass('lr-tab-active');

		if (dataTab == 'lr-profile') {
			j("#lr-basic").addClass('lr-tab-active');
			j('.lr-submenu-buttons .lr-buttons').removeClass('lr-tab-active');
			j("#lr-tab-basic").addClass('lr-tab-active');
		}
		j(this).addClass('lr-tab-active');
		j("#" + dataTab).addClass('lr-tab-active');
	});
	j('.lr-submenu-buttons .lr-buttons').click(function() {
		var dataTab = j(this).attr("data-tab");
		j('.lr-submenu-buttons .lr-buttons').removeClass('lr-tab-active');
		j('.lr-frame .lr-subframe').removeClass('lr-tab-active');

		j(this).addClass('lr-tab-active');
		j("#" + dataTab).addClass('lr-tab-active');
	});

	// this makes the first element with that class visible.. if you don't want this.. add that class manually
	//j('.lr-menu-buttons .lr-buttons:eq(0)').addClass('lr-tab-active');
	//j('.lr-profile-frame .lr-frame:eq(0)').addClass('lr-tab-active');
});

j(document).ready(function() {
	j('.lr-show-pw').click(function() {
		var dataTab = j('.lr-tab-active').attr("data-tab");
		var placeholder = '';
		var showPass = function() {
			j('.' + dataTab).find('input:password').each(function() {

				j("<input type='text' class='showPass' />").attr({
					name : this.name,
					value : this.value
				}).insertBefore(this);
			}).remove();
		};
		var hidePass = function() {
			j('.' + dataTab).find('input.showPass').each(function() {

				j("<input type='Password' />").attr({
					name : this.name,
					value : this.value
				}).insertBefore(this);
			}).remove();
		};

		if (j('.' + dataTab + ' input:password').is(':visible')) {
			showPass();
			j('.lr-show-pw').addClass('lr-toggle');
			//   j('.'+dataTab+' input:text').focus();
		} else {
			hidePass();
			j('.lr-show-pw').removeClass('lr-toggle');
			//  j('.'+dataTab+' input:password').focus();
		}
	});
});

function handle_ajax_functionality(data, success) {
	j('#fade').show();
	$.ajax({
		type : "POST",
		url : '',
		data : data,
		success : success,
		error : function(jqXHR, textStatus, errorThrown) {
			j('#fade').hide();
		}
	});

}

function login_radius_log_out() {
	//handleResponse(true, "");
	var data = 'value=logout';
	handle_ajax_functionality(data, function(data) {
		window.location = LocalDomain;
		j('#fade').hide();
	});
}

function handleResponse(isSuccess, message, show) {
	if (show) {

	} else {
		j('#fade').show();
	}
	if (message != null && message != "") {
		j('#messageinfo').text(message);
		j(".messagediv").show();
		j(".messagediv").css({
			"margin-top" : "85px"
		});
		j('#messageinfo').show();
		j(".lr-profile-frame.lr-input-style").css({
			"margin-top" : "0px"
		});
		if (isSuccess) {
			j('form').each(function() {
				this.reset();
			});
		}
	} else {
		j(".messagediv").hide();
		j('#messageinfo').hide();
		j(".messagediv").css({
			"margin-top" : "0px"
		});
		j(".lr-profile-frame.lr-input-style").css({
			"margin-top" : "85px"
		});
		j('#messageinfo').text("");
	}
}

function editClicked() {
	showSurveyInputBox();
	return false;
}

function showSurveyEditForm() {

	j(".survey-form-input-box").addClass("survey-form-hide-content");
	j(".survey-form-span-answers").removeClass("survey-form-hide-content");

	j("#submit-survey-form").addClass("survey-form-hide-content");
	j("#edit-survey-form").removeClass("survey-form-hide-content");
}

function showSurveySubmitForm() {

	j(".survey-form-input-box").removeClass("survey-form-hide-content");
	j(".survey-form-span-answers").addClass("survey-form-hide-content");

	j("#submit-survey-form").removeClass("survey-form-hide-content");
	j("#edit-survey-form").addClass("survey-form-hide-content");

}

function showpopupmessage() {
	j('.lr-popup-message').show('slow');
	setTimeout(function() {
		j('.lr-popup-message').hide('slow');
	}, 10000);
	j(window).scrollTop(0);
	j('#fade').hide();
	// <-- time in milliseconds
}
