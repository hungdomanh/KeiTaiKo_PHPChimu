$(window).on('load', function () {
	var showPopupBought = function() {
	    $('#popup-alert').addClass('show');
	    setTimeout(function() {
	      $('#popup-alert').removeClass('show');
	    },5000)
	}

	$('.close-poup').on('click', function(){
		$('#popup-alert').removeClass('show');
	});

	// $('#btn-full-page-search').on('click', function(){
	// 	$('#full-page-search').addClass('open');
	// });

	// $('#full-page-search .close').on('click', function(){
	// 	$('#full-page-search').removeClass('open');
	// });

	showPopupBought();
	
	$('#comment-show').on('click', '.hihi', function(){
	    var drop = $(this).parent().find('.dropdown-content');
	    if (drop.is(":hidden")) {
	    $('.dropdown-content').hide();
	      drop.show();
	    } else {
	      drop.hide();
	    }
	})

	$('.btn.btn-color.btn-md.btn-message').on('click', function() {
		setTimeout(function(){ $('.form-group.message #comment_content').val(''); }, 1000);
	})

	$('.star').on('click', function() {
		setTimeout(function(){ location.reload(); }, 500);
	})
});
