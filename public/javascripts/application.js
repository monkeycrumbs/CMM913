// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

  function optionDisplay(option) {
 	var list = {'select': 1, 'radio': 1, 'checkbox': 1, 'likert': 1};
	if (option in list) {
      document.getElementById('option_section').style.display = 'block';}
    else {
      document.getElementById('option_section').style.display = 'none';}
    }
