var categories;
var level1choice;
var level2choice;
var level3choice;
var level4choice;
var current_search_query;

function changeTabs(dontChangeToTodo) //change the todo/mastered tabs so it includes search
{
    
    if (dontChangeToTodo)
    {
        
       $('#select-search').parent().removeClass('disabled-link');
       $('#select-search').parent().addClass('normal-link');
       $('#select-todo').parent().removeClass('normal-link');
       $('#select-todo').parent().addClass('disabled-link');
    }
    else
    {	
       $('#select-search').parent().removeClass('normal-link');
       $('#select-search').parent().addClass('disabled-link');
       $('#select-todo').parent().addClass('normal-link');
       $('#select-todo').parent().removeClass('disabled-link');
       $('#select-mastered').parent().addClass('normal-link');
       $('#select-mastered').parent().removeClass('disabled-link');
        
       $('#todo-mode-left').css('background-color', '#F3F9FF');
       $('#todo-mode-middle').css('background-color', '#F3F9FF');
       $('#todo-mode-right').css('background-color', 'white');
       
       $('#click-mastered').css('display', 'none');
       $('#click-todo').css('display', 'inline-block');
       
	   $('#middle-left-div .block-header').css('background-position', '20px -365px');
       $('#middle-left-div .block-spacer-image-wrapper').css('background-image', 'none');
       
       $('#todo-mode-right').css('display', 'inline-block');
       
       if (!is_logged_in)
            $('#search-results-wrapper').show(200);
    }
    
    $('#select-search')
   .click(function(e) {
       e.preventDefault();
       if (mode != 'search')
       {
		
		   $('#search-description').css('display', 'block');
	   
		   if (displaying_buttons_todo)
				showButtons();
				
		   if (mode == 'todo')
		   {
			   
			   $('#todo-wrapper').hide(200, function () {
				   $('#search-results-wrapper').show(200);
			   });
		   }
		   else if (mode == 'mastered')
		   {
			   $('#mastered-wrapper').hide(200, function () {
				   $('#search-results-wrapper').show(200);
			   });
		   }
				
		   mode = 'search';
		   
		   $(this).parent().removeClass('normal-link');
		   $(this).parent().addClass('disabled-link');
		   $('#select-todo').parent().addClass('normal-link');
		   $('#select-todo').parent().removeClass('disabled-link');
		   $('#select-mastered').parent().addClass('normal-link');
		   $('#select-mastered').parent().removeClass('disabled-link');
		   
		   $('#todo-mode-left').css('background-color', '#F3F9FF');
		   $('#todo-mode-middle').css('background-color', '#F3F9FF');
		   $('#todo-mode-right').css('background-color', 'white');
		   
		   $('#click-mastered').css('display', 'none');
		   $('#click-todo').css('display', 'inline-block');
		   
		   $('#middle-left-div .block-header').css('background-position', '20px -365px');
		   $('#middle-left-div .block-spacer-image-wrapper').css('background-image', 'none');
		   
		   reloadPage();

       }
   });
}

function searchResultHTML()
{
    
    
    $('.page2-options-link').each(function(index) {
            
        $(this)
        .click(function(e) {
        
            e.preventDefault(); 
            
			is_text_search = false;
			
            //alert($(this).text());
            
            var category_string;
            var search_results;
            
            category_string = level1choice + ' - ' + level2choice + ' - ';
            category_string += $(this).parent().parent().parent().parent().children('.page2-div').children('.page2-title').text() + ' - ';
            category_string += $(this).parent().parent().parent().parent().children('.page2-div').children('.page2-a-selected').children('.page2-container').children('.page2-link').text() + ' - ';
            category_string += $(this).parent().children('.page2-options-title').text() + ' - ';
            category_string += $(this).text();
            
            current_search_query = category_string;
            
            //$('#search-results-wrapper').html(category_string);
            $.ajax({
                url: base_uri + '/search.php',
                data: {r: 'get-count', debug: 0, category: category_string},
                success: function(data){ 
                    search_total_pages = Math.ceil(data / 10); 
                    mode = 'search';
                    search_page = 1;
                    reloadPage();
                    changeTabs();
					
					var body = $("body, html");
					body.animate({
						  scrollTop:0
						}, '500', 
						function(){} // callback method use this space how you like
					);
                }
                    
            });
                        
                    
        });
    
    });
}

function getSearchData(query, page)
{
	var data_set;
	
	
	
	if (is_text_search)
	{
		data_set = {r: 'get-results', debug: 0, term: query, page: page};
		
		$('#search-description').html("Showing results for a text search on <b style=\"font-size: 105%;\">\"" + query + "\"</b>");
	}
	else
	{
		data_set = {r: 'get-results', debug: 0, category: query, page: page};
		
		var category_name_array = query.split(' - ');
		
		if (category_name_array[1] == category_name_array[2])
		{
			category_name_array.splice(1, 1);
		}
		
		$('#search-description').html("Showing results in the category <b style=\"font-size: 105%;\">\"" + category_name_array.join(' - ') + "\"</b>");
	}

    $.ajax({
       url: base_uri + '/search.php',
       data: data_set,
       success: function(data){ 
                
                search_results = JSON.parse(data);
                
                var HTML_search_results = '';
                
                $.each(search_results, function (index, value) {
                    
                    
                    //HTML_search_results += category_string;
                    
                    if ((index % 2 - 1) == 0)
                    {
                        background_colour = 'style="background-color: #fff5ee;"';
                    }
                    else
                    {
                        background_colour = 'style="background-color: white;"';
                    }
                    
                    
                    HTML_search_results += '<div class="main-text" ' + background_colour + '>';
                    HTML_search_results += '<div class="thumb-image">';
                    HTML_search_results += '<a href="' + base_uri + '/video/' + value.video_id + '">';
                    
                    if (value.thumbnail !== null)
                    {
                        HTML_search_results += '<img src="' + value.thumbnail + '" class="video-thumb" width="120" height="90" />';
                    
                    }
                    else
                    {
                        HTML_search_results += '<img src="" class="video-thumb" width="180" height="135" />';
                    
                    }
                    
                    //HTML_search_results += '<span class ="thumb-image-stars" style="background-color: white; padding: 5px; opacity: 0.65; filter:alpha(opacity=65) !important;">';
                    
                    
                    //HTML_search_results += '<img src="{$g_config.template_uri}/images/{$video.total_avg_rating|t_nearesthalf}-stars.png" width="80px" height="16px" class="thumb-image-stars" />';
                    
                    
                    //HTML_search_results += '</span>';
                    HTML_search_results += '<span class ="thumb-image-views">';
                    HTML_search_results += '<span style="background-color: white; padding: 5px; opacity: 0.65; filter:alpha(opacity=65) !important;">';
                    HTML_search_results += 'Views: ' + value.total_num_views;
                    HTML_search_results += '</span>';
                    HTML_search_results += '</span>';
                    HTML_search_results += '</a>';
                    HTML_search_results += '</div>';
                    
                    HTML_search_results += '<div class="thumb-description" style="width: 260px;">';
                    HTML_search_results += '<span class="bolder">';
                    
                    HTML_search_results += '<a href="' + base_uri + '/video/' + value.video_id + '" class="search-result-link">';
                    
                    var stars_y = -1 * Math.ceil(value.total_avg_rating / 0.5) * 13 + 1;
                    
                    HTML_search_results += value.title + '</a></span>';
                    HTML_search_results += '<br>'; 
                    HTML_search_results += '<img src="' + template_uri + '/images/1px-transparent.png" class="search-stars-img" width="64" height="13" style="margin-top: 5px; background: url(\'' + template_uri + '/images/stars-small.png\') 0 ' + stars_y + 'px;" />';
                    
                    HTML_search_results += '</div>';
                    HTML_search_results += '</div>';
                    
                });
                
                $('#search-results-wrapper').html(HTML_search_results);
                $('#search-results-wrapper').css('display', 'inline-block');
                $('#mastered-wrapper').css('display', 'none');
                $('#todo-wrapper').css('display', 'none');
                
                
                //When we click a link put some variables in local storage so that we can access them on the next page (eg search results)
                
                $('.search-result-link')
                .click (function(e) {
                    e.preventDefault();
                    
                    //var href = $(this).attr("href");

                    //history.pushState({}, '', href);
                    //$('#middle-main-content').children('.block-main-content').load(href + " .block-main-content");
                    //return false;
                    
                    localStorage['search-query'] = query;
                    localStorage['search-page'] = page;
					
					if (is_text_search)
						localStorage['is-text-search'] = true;
					else
						localStorage['is-text-search'] = false;
						
                    localStorage['came-through-search'] = true; //to indicate that they arrived on the new page by clicking a searched link
                    localStorage['search-total-pages'] = search_total_pages;
                    
                    window.location.replace($(this).attr("href"));
                    
                });
                
            
            },
                   
      });
}

function categorySearchResults()
{
    //get results from a PHP file
    
    
    $.ajax({
           url: base_uri + '/category_new.php',
           data: {r: 'get-results', debug: 0},
           success: function(data){ 
               
                try {
                   
                    categories = JSON.parse(data);
                } catch (e) {
                    console.error("Parsing error:", e); 
                }
                
                loadMainCategories();
                },
                       
          });
    
}

function getCategoryNames()
{  
    $.ajax({
           url: base_uri + '/category_new.php',
           data: {r: 'get'},
           success: function(data){ 
               
                try {
                   
                    categories = JSON.parse(data);
                } catch (e) {
                    console.error("Parsing error:", e); 
                }
                
                loadMainCategories();
                },
                       
          });
}

function makeDivHTML(divClass, divID, divContents)
{
    var HTMLString = '';
    
    HTMLString += '<div ';
    
    if (divClass !== '')
        HTMLString += 'class="' + divClass + '" ';
        
        
    if (divID !== '')
        HTMLString += 'id="' + divID + '" ';
    
    HTMLString += '>';
    HTMLString += divContents;
    
    HTMLString += "</div>";
    
    return HTMLString;
}

function makeDivsPageTwo(index1, index2)
{
    var HTMLString = '';
    var count = 1;
    var imageURLString = '';
    var index3 = '';
    var index4 = '';
    
    $.each(categories[index1][index2], function (index, value) {
        
        HTMLString += '<div id="div-wrapper-' + count + '" class="page2-div-wrapper">';
        HTMLString += '<div id="div-' + count + '" class="page2-div">';
        HTMLString += '<div id="div-' + count + '-title" class="page2-title">' + index + '</div>';
        HTMLString += '<div id="div-' + count + '-back" class="page2-back"><a href="" class="page2-back-button">(Go back)</a></div><br>';
        
        //alert(categories[index]);
        //alert(Object.keys(categories[index]).length);
        
        var linkcount = 1;
        
        index3 = index;
        
        $.each(categories[index1][index2][index], function (index, value) {
            
            imageURLString = '';
            index4 = index;
            
            index4 = index4.replace('.', '');
            index4 = index4.replace('/', '');
            
            //alert($(this));
            
            HTMLString += '<a href="" class="page2-a">';
            HTMLString += '<div id="div-' + count + '-link-container2-' + linkcount + '" class="page2-container">';
            
            HTMLString += '<div id="div-' + count + '-pic2-' + linkcount + '" class="page2-pic">';
            
            imageURLString += template_uri + '/images/category_images/' + index1 + '/' + index2 + '/' + index3 + '/fm-' + index4 + '.jpg';
            
            HTMLString += '<img src="' + imageURLString + '" class="page2-img">';
            HTMLString += '</div>';
            
            HTMLString += '<div id="div-' + count + '-link2-' + linkcount + '" class="page2-link">';
            linkcount++;
            HTMLString += index;
            HTMLString += '</div>';
            
            HTMLString += '</div>';
            HTMLString += '</a>';
            
            
        });
        
        HTMLString += '</div>';
        HTMLString += '<div id="div-' + count + '-options" class="page2-options"><div class="page2-options-wrapper"></div></div>';
        
        
        
        count++;
    
    });
    
    //HTMLString += '<div id="div-page2-back-button" class="page2-back-button">Back</div>';
    HTMLString += '</div>';
    HTMLString += '</div>';
    
    
    $('#category-div-wrapper2').html(HTMLString);
    
    makeClickEventsPageTwo();
    
    
    $('#category-div-wrapper1').hide(200, function () {
                   $('#category-div-wrapper2').show(200, function () {
                       
                        $('.content').css('min-height', $('#header-wrapper').css('height'));
                   });
    });
}

function makeClickEventsPageOne()
{
    
    $('.page1-a')
    .click(function(e)
    {
       e.preventDefault(); 
       
        level1choice = $(this).parent().children('.page1-title').html();
        level2choice = $(this).children().children('.page1-link').html();
        
        makeDivsPageTwo(level1choice, level2choice); 
        
        $('.page2-options-wrapper').css("display", "none"); 
        
        $(window).scrollTop(0);
    });
}

function makeClickEventsPageTwo()
{
    $('.page2-a')
    .click(function(e)
    {
       e.preventDefault(); 
       
       $('.page2-container').css('background-color', '');
       
       //$(this).parent().children().children('.page2-container').css('background-color', '');
       $(this).parent().children().children('.page2-container').css('border-color', '#f6f6f6');
       $(this).parent().children('.page2-a-selected').removeClass('page2-a-selected');
       $(this).children('.page2-container').css('background-color', 'rgb(193, 235, 255)');
       $(this).addClass('page2-a-selected');
       //$(this).children('.page2-container').css('border-color', '#707080');
       
       
        level3choice = $(this).parent().children('.page2-title').html();
        level4choice = $(this).children().children('.page2-link').html();
        
        var HTMLString = '';
        var count = 1;
		
		var HTMLString_array = []; //needed to reverse the order of the divs
        
        
        $.each(categories[level1choice][level2choice][level3choice][level4choice], function (index, value) {
            
            HTMLString += '<div id="div-' + count + '" class="options-div">';
            HTMLString += '<div id="div-' + count + '-options-title" class="page2-options-title" style="font-weight: bold">' + index + '</div>';
            
            var linkcount = 1;
            var level5choice = index;
            
            $.each(categories[level1choice][level2choice][level3choice][level4choice][index], function (index, value) {
         
                HTMLString += '<div id="div-' + count + '-options-link-' + linkcount + '" class="page2-options-link">';
                linkcount++;
                HTMLString += '<a href="';
                /*HTMLString += base_uri + '/index.php?r=category&c[0]=';
                
                var categoryString = level1choice + ' - ' + level2choice + ' - ' + level3choice + ' - ' + level4choice + ' - ' + level5choice + ' - ' + value;
                categoryString = categoryString.replace(/ /g, '+');
                
                HTMLString += categoryString + '">';
                */
                
                HTMLString += '">';
                HTMLString += value;
                HTMLString += '</a></div>';
            });
                
            HTMLString += '</div>';
			HTMLString_array.push(HTMLString);
			HTMLString = '';
            count++;
        });
		
		HTMLString_array.reverse();
		
		HTMLString = HTMLString_array.join('');
        
        var title_offset = $(this).parent().children('.page2-title').offset();
        var options_height;
        var image_offset = $(this).offset();
        
        var total_height = $(this).parent().height();
        var options_margin = image_offset.top - title_offset.top;
        
       
       if ($(this).parent().parent().children('.page2-options').children('.page2-options-wrapper').css("display") != "block")
       {
            
            $(this).parent().parent().children('.page2-options').children('.page2-options-wrapper').html(HTMLString); 
            $(this).parent().parent().children('.page2-options').children('.page2-options-wrapper').css('display', 'inline-block');
            options_height = $(this).parent().parent().children('.page2-options').children('.page2-options-wrapper').height();
            
            if (total_height > options_height)
            {
                $(this).parent().css('height', 'auto');  
            }
            else
            {
                
                $(this).parent().css('height', options_height + 40); 
                total_height = options_height + 40;
            }
            
            if ((options_margin + options_height) > (total_height - 20))
                options_margin = total_height - options_height - 20;
               
            
            
            
			$('.page2-options-wrapper').css('display', 'none');
            $(this).parent().parent().children('.page2-options').css('margin-top', options_margin + 'px');
            $(this).parent().parent().children('.page2-options').children('.page2-options-wrapper').css('display', 'none');
            $(this).parent().parent().children('.page2-options').children('.page2-options-wrapper').show(100, function() { searchResultHTML(); } );
       }
       else
       {
           $(this).parent().parent().children('.page2-options').children('.page2-options-wrapper').stop(true, true).hide(100, function() {
            
                $(this).parent().parent().children('.page2-options').children('.page2-options-wrapper').html(HTMLString); 
                $(this).parent().parent().children('.page2-options').children('.page2-options-wrapper').css('display', 'inline-block');
                options_height = $(this).parent().parent().children('.page2-options').children('.page2-options-wrapper').height();
               
                if (total_height > options_height)
                {
                    $(this).parent().css('height', 'auto');
                }
                else
                {
                    $(this).parent().css('height', options_height + 40); 
                    total_height = options_height + 40;
                }
                
                if ((options_margin + options_height) > (total_height - 20))
                    options_margin = total_height - options_height - 20;
                 
                    
                
                $(this).parent().parent().children('.page2-options').css('margin-top', options_margin + 'px');
                
                $(this).parent().parent().children('.page2-options').children('.page2-options-wrapper').css('display', 'none');
                
                
                $('.page2-options-wrapper').css('display', 'none');
                $(this).parent().parent().children('.page2-options').children('.page2-options-wrapper').show(100, function() { searchResultHTML(); } );
                
           });
       }
       
    });
    
    $('.page2-back-button')
    .click(function(e) 
    {
        e.preventDefault();
        
        $('#category-div-wrapper2').hide(200, function () {
               $('#category-div-wrapper1').show(200, function() {
                   $('.content').css('min-height', $('#header-wrapper').css('height'));
                });
        });
        
        $(window).scrollTop(0);
    });
}

function makeDivsPageOne()
{
    var HTMLString = '';
    var imageURLString = '';
     var count = 1;
     var category_name = '';
    
    
    $.each(categories, function (index, value) {
         //alert (index);
         
         
        var linkcount = 1;
         
         if (value != 'Uncategorised')
         {
            
            //if (Object.keys(categories[index]).length > 1)
            //{
                HTMLString += '<div id="div-' + count + '" class="page1-div">';
                HTMLString += '<div id="div-' + count + '-title" class="page1-title">' + index + '</div>';
                
                category_name = index;
                
                //alert(categories[index]);
                //alert(Object.keys(categories[index]).length);
                
                $.each(categories[index], function (index, value) {
             
                    imageURLString = '';
                    
                    //alert($(this));
                    HTMLString += '<a href="" class="page1-a">';
                    
                    imageURLString += template_uri + '/images/category_images/' + category_name + '/fm-' + index + '.jpg';
                   // alert (imageURLString);
                    
                    HTMLString += '<div id="div-' + count + '-link-container-' + linkcount + '" class="page1-container">';
                    HTMLString += '<div id="div-' + count + '-pic-' + linkcount + '" class="page1-pic">';
                    HTMLString += '<img src="' + imageURLString + '" class="page1-img">';
                    //HTMLString += '<img src="" class="page1-img">';
                    HTMLString += '</div>';
                    
                    HTMLString += '<div id="div-' + count + '-link-' + linkcount + '" class="page1-link">';
                    linkcount++;
                    HTMLString += index;
                    HTMLString += '</div>';
                    HTMLString += '</div>';
                    
                    HTMLString += '</a>';
                    
                    
                    
                    
                });
                
                HTMLString += '</div>';
            
            //}
            /*else
            {
                HTMLString += '<div id="div-' + count + '" class="page1-div">';
                HTMLString += '<div id="div-' + count + '-title" class="page1-title">';
                
                HTMLString += '<a href="" class="page1-a-title">' + index + '</a>';
                
                HTMLString += '</div>';
                HTMLString += '</div>';
            }*/
                
            count++;
            
         }
         
    });
    
    return HTMLString;
}

function loadMainCategories()
{
    var HTMLString = ''; //For the wrapper
    var innerHTMLString = ''; //For the contents inside the wrapper
    var wrapperHTMLString = ''; //For the wrappers
    var counter = 1;
    
    HTMLString = makeDivsPageOne();
    
    
    wrapperHTMLString += makeDivHTML('category-div-wrapper', 'category-div-wrapper1', HTMLString);
    
    wrapperHTMLString += makeDivHTML('category-div-wrapper', 'category-div-wrapper2', '');
    
    
    
    //$('#middle-main-content .block-main-content').html(wrapperHTMLString);
    
    $('#search-dropdown-categories').html(wrapperHTMLString);
    
    makeClickEventsPageOne();
    
    $('#category-div-wrapper2').css('display', 'none');
    
}

$( document ).ready( getCategoryNames );


$(function() {  
    $('.link-bar').submit( function(e) {
		e.preventDefault();
		
		is_text_search = true;
		current_search_query = $('#search-bar').val();
		
		$.ajax({
                url: base_uri + '/search.php',
                data: {r: 'get-count', debug: 0, term: $('#search-bar').val()},
                success: function(data){ 
                    search_total_pages = Math.ceil(data / 10); 
                    mode = 'search';
                    search_page = 1;
                    reloadPage();
                    changeTabs();
                }
                    
            });
	});
});  