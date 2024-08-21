//==============================================================================
// HTML ENCODE
//==============================================================================
function htmlEncode( html ) {
	return document.createElement( 'a' ).appendChild(
		document.createTextNode( html ) ).parentNode.innerHTML;
};

// CHECK EXIST ELEMENT
function checkExistElement(element) {
	if ($(element).length > 0) {
		return true;
	}
	var $liCurrent = $('a[href="' + element + '"]').parent();
	var count = 0;
	$('li > a', $liCurrent).each(function() {
		var id = $(this).attr('href');
		if ($(id).length > 0) {
			count++;
		}
	});
	return count > 0;
}

//==============================================================================
// SHOW ALL CHILD SECTION
//==============================================================================
function showAllChildSection(element) {
	// SHOW ALL CHILD SECTION
	var $liCurrent = $('a[href="' + element + '"]').parent();
	$('li > a', $liCurrent).each(function() {
		var id = $(this).attr('href');
		$(id).show();
	});
}

//==============================================================================
// SCROLL NAV TO CURRENT LOCATION
//==============================================================================
function scrollToCurrentLocation(id) {
	var liCurrentTop = $('a[href="' + id + '"]').position().top;
	var liHeight = $('a[href="' + id + '"]').outerHeight();
	var scrollTop = $('.nav-wrapper').scrollTop();
	var navWrapperHeight = $('.nav-wrapper').outerHeight();
	if (liCurrentTop < 0) {
		$('.nav-wrapper').animate({scrollTop: (scrollTop + liCurrentTop) + 'px'},300);
	}
	else if (liCurrentTop + liHeight > navWrapperHeight) {
		$('.nav-wrapper').animate({scrollTop: ((liCurrentTop + liHeight - navWrapperHeight) + scrollTop) + 'px'},300);
	}
}

//==============================================================================
// DOCUMENT READY
//==============================================================================
$(document).ready(function() {
	$('textarea[data-lang]').each(function() {
		var $this = $(this);
		var data_lang = $this.attr('data-lang');
		$this.after('<pre class="code-toolbar nowrap"><code class="language-' + data_lang + '">' + htmlEncode($this.val()) + '</code></pre>');
	});
	var pre = document.getElementsByTagName('pre');
	for (var i = 0; i < pre.length; i++) {
		var isLanguage = pre[i].children[0].className.indexOf('language-');
		if ( isLanguage === 0 ) {
			var button           = document.createElement('button');
			button.className = 'copy-button';
			button.textContent = 'Copy';

			pre[i].appendChild(button);
		}
	}

	var copyCode = new Clipboard('.copy-button', {
		target: function(trigger) {
			return trigger.previousElementSibling;
		}
	});

	//==============================================================================
	// PERFECT SCROLL
	//==============================================================================
	$('.nav-wrapper').perfectScrollbar({
		wheelSpeed: 0.5,
		suppressScrollX: true
	});

	// SECTION PROCESS
	var hash = location.hash;
	var currentSection = $('section:first-child').attr('id');
	if (typeof (currentSection) != "undefined") {
		currentSection = '#' + currentSection;
		$('a[href="' + currentSection + '"]').parent().addClass('current');
	}

	var allowClick = true;

	if ((hash != null) && (hash != '')) {
		if (checkExistElement(hash)) {
			allowClick = false;
			$('a[href="' + currentSection + '"]').parent().removeClass('current');
			$('a[href="' + hash + '"]').parent().addClass('current');
			$(currentSection).fadeOut(function() {
				$(hash).fadeIn(function() {
					allowClick = true;
				});
				currentSection = hash;
				showAllChildSection(currentSection);
				scrollToCurrentLocation(currentSection);
			});
		}
	}

	// CLICK NAV
	$('nav li a, a.data-ref').click(function() {
		if (!allowClick) {
			return;
		}
		var id = $(this).attr('href');
		if (typeof (id) != "undefined" && id != null & id != '' && (id.indexOf('#') != -1)) {
			if (checkExistElement(id)) {
				allowClick = false;
				$('a[href="' + currentSection + '"]').parent().removeClass('current');
				$('a[href="' + id + '"]').parent().addClass('current');
				$('section').hide();
				$('html,body').animate({scrollTop: '0px'},10, function() {
					$(id).show();
					currentSection = id;
					showAllChildSection(id);
					allowClick = true;
				});
				scrollToCurrentLocation(id);
			}
		}
	});

});