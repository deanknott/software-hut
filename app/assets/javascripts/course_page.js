function switchTab(tabName) {

  // doesn't change if clicked button is active tab
  if (tabName !== currentTab) {

    // hide current tab
    document.getElementById(currentTab).style.display = "none";

    // display new tab
    document.getElementById(tabName).style.display = "block";

    // reset button styles
    courseButton.style.backgroundColor = "#008196";
    courseButton.style.color = "white";
    courseButton.style.borderRadius = "8px 8px 0 0";

    infoButton.style.backgroundColor = "#008196";
    infoButton.style.color = "white";
    infoButton.style.borderRadius = "8px 8px 0 0";

    contactButton.style.backgroundColor = "#008196";
    contactButton.style.color = "white";
    contactButton.style.borderRadius = "8px 8px 0 0";

    //courseButton.classList.remove('selected');
    //infoButton.classList.remove('selected');
    //contactButton.classList.remove('selected');

    // change active tab's button colour
    switch (tabName) {
    case "course-tab":
      courseButton.style.backgroundColor = "#e1e1e16b";
      courseButton.style.color = "black";
      courseButton.style.borderRadius = "0";
      //courseButton.classList.add('selected');
      break;
    case "additional-info-tab":
      infoButton.style.backgroundColor = "#e1e1e16b";
      infoButton.style.color = "black";
      infoButton.style.borderRadius = "0";
      //infoButton.classList.add('selected');
      break;
    case "contact-tab":
      contactButton.style.backgroundColor = "#e1e1e16b";
      contactButton.style.color = "black";
      contactButton.style.borderRadius = "0";
      //contactButton.classList.add('selected');
      break;
    default: break;
    }

    currentTab = tabName;
  }
}

// set button variables and add listeners
$(document).on('turbolinks:load', function() {
  courseButton = document.getElementById("course-button");
  infoButton = document.getElementById("info-button");
  contactButton = document.getElementById("contact-button");

  $('#course-button').click(function(){
     switchTab('course-tab');
  });

  $('#info-button').click(function(){
     switchTab('additional-info-tab');
  });
  $('#contact-button').click(function(){
     switchTab('contact-tab');
  });
});

var currentTab = "course-tab";
var courseButton;
var infoButton;
var contactButton;
