// add ability to add more widening participations
function addWp() {
  var container = document.getElementById("wp-section");

  numberOfWps++;
  
  // header
  var header = document.createElement("h3");
  header.innerText = "New Widening Participation";

  // get select options
  options = document.getElementById("wp_sel_wp1").options;

  // add a select field to select from existing wps
  var div1 = document.createElement("div");
  div1.className = "form-group select optional wp_sel_wp" + numberOfWps;

  var label1 = document.createElement("label");
  label1.className = "control-label select optional";
  label1.setAttribute("for", "wp_sel_wp" + numberOfWps);
  label1.innerText = "Select New Widening Participation";

  var select1 = document.createElement("select");
  select1.setAttribute("id", "wp_sel_wp" + numberOfWps);
  select1.className = "form-control select optional";
  select1.setAttribute("name", "wp[sel_wp" + numberOfWps+"]");
  for (i = 0; i < options.length; i++) {
    var option = document.createElement("option");
    option.value = options[i].text;
    option.innerText = options[i].text;
    select1.appendChild(option);
  }

  div1.appendChild(label1);
  div1.appendChild(select1);

  // add a text field
  var div2 = document.createElement("div");
  div2.className = "form-group string optional wp_new_wp" + numberOfWps;

  var label2 = document.createElement("label");
  label2.className = "control-label string optional";
  label2.setAttribute("for", "wp_new_wp" + numberOfWps);
  label2.innerText = "Enter New Widening Participation. Enter the title of a "+
                      "new widening participation if you can't find a suitable "+
                      "one above. If you wish to keep the above selection, keep "+
                      "this section empty or it will be overwritten.";

  textInput2 = document.createElement("input");
  textInput2.setAttribute("id", "wp_new_wp" + numberOfWps);
  textInput2.className = "form-control string optional";
  textInput2.setAttribute("name", "wp[new_wp" + numberOfWps+"]");

  div2.appendChild(label2);
  div2.appendChild(textInput2);

  // add all to form
  container.insertBefore(header, addWpButton);
  container.insertBefore(div1, addWpButton);
  container.insertBefore(div2, addWpButton);
}

// add ability to add more fees
function addFee() {
  var container = document.getElementById("fee-section");

  numberOfFees++;

  // header
  var header = document.createElement("h3");
  header.innerText = "New Fee";

  // get select options
  options = document.getElementById("add_fee_stu1").options;

  // add a select field to select student type
  var div1 = document.createElement("div");
  div1.className = "form-group select optional add_fee_stu" + numberOfFees;

  var label1 = document.createElement("label");
  label1.className = "control-label select optional";
  label1.setAttribute("for", "add_fee_stu" + numberOfFees);
  label1.innerText = "Select Student Type";

  var select1 = document.createElement("select");
  select1.setAttribute("id", "add_fee_stu" + numberOfFees);
  select1.className = "form-control select optional";
  select1.setAttribute("name", "add_fee[stu" + numberOfFees+"]");
  for (i = 0; i < options.length; i++) {
    var option = document.createElement("option");
    option.value = options[i].value;
    option.innerText = options[i].text;
    select1.appendChild(option);
  }

  div1.appendChild(label1);
  div1.appendChild(select1);

  // add a text input to enter fee amount
  var div2 = document.createElement("div");
  div2.className = "form-group string optional add_fee_fee" + numberOfFees;

  var label2 = document.createElement("label");
  label2.className = "control-label string optional";
  label2.setAttribute("for", "add_fee_fee" + numberOfFees);
  label2.innerText = "Fee (Integer)";

  textInput2 = document.createElement("input");
  textInput2.setAttribute("id", "add_fee_fee" + numberOfFees);
  textInput2.className = "form-control string optional";
  textInput2.setAttribute("type", "text");
  textInput2.setAttribute("name", "add_fee[fee" + numberOfFees+"]");

  div2.appendChild(label2);
  div2.appendChild(textInput2);

  // add a text input to enter time period
  var div3 = document.createElement("div");
  div3.className = "form-group string optional add_fee_time" + numberOfFees;

  var label3 = document.createElement("label");
  label3.className = "control-label string optional";
  label3.setAttribute("for", "add_fee_time" + numberOfFees);
  label3.innerText = "Time Period of the Fee. e.g. 'Year 1', 'Whole Course'";

  textInput3 = document.createElement("input");
  textInput3.setAttribute("id", "add_fee_time" + numberOfFees);
  textInput3.className = "form-control string optional";
  textInput3.setAttribute("type", "text");
  textInput3.setAttribute("name", "add_fee[time" + numberOfFees+"]");

  div3.appendChild(label3);
  div3.appendChild(textInput3);

  // add all to form
  container.insertBefore(header, addFeeButton);
  container.insertBefore(div1, addFeeButton);
  container.insertBefore(div2, addFeeButton);
  container.insertBefore(div3, addFeeButton);

}

// add ability to add more entry requirements
function addEntryRequirement() {
  var container = document.getElementById("er-section");

  numberOfERs++;

  // header
  var header = document.createElement("h3");
  header.innerText = "New Entry Requirement";

  // get select options
  options = document.getElementById("add_entry_req_inc_qual1").options;

  // add a select field to select incoming qualification
  var div1 = document.createElement("div");
  div1.className = "form-group select optional add_entry_req_inc_qual" + numberOfERs;

  var label1 = document.createElement("label");
  label1.className = "control-label select optional";
  label1.setAttribute("for", "add_entry_req_inc_qual" + numberOfERs);
  label1.innerText = "Select Incoming Qualification";

  var select1 = document.createElement("select");
  select1.setAttribute("id", "add_entry_req_inc_qual" + numberOfERs);
  select1.className = "form-control select optional";
  select1.setAttribute("name", "add_entry_req[inc_qual" + numberOfERs+"]");
  for (i = 0; i < options.length; i++) {
    var option = document.createElement("option");
    option.value = options[i].value;
    option.innerText = options[i].text;
    select1.appendChild(option);
  }

  div1.appendChild(label1);
  div1.appendChild(select1);

  // add a text input to enter fee amount
  var div2 = document.createElement("div");
  div2.className = "form-group string optional add_entry_req_grade" + numberOfERs;

  var label2 = document.createElement("label");
  label2.className = "control-label string optional";
  label2.setAttribute("for", "add_entry_req_grade" + numberOfERs);
  label2.innerText = "Required Grades";

  textInput2 = document.createElement("input");
  textInput2.setAttribute("id", "add_entry_req_grade" + numberOfERs);
  textInput2.className = "form-control string optional";
  textInput2.setAttribute("type", "text");
  textInput2.setAttribute("name", "add_entry_req[grade" + numberOfERs+"]");

  div2.appendChild(label2);
  div2.appendChild(textInput2);

  // add a text input to enter time period
  var div3 = document.createElement("div");
  div3.className = "form-group string optional add_entry_req_info" + numberOfERs;

  var label3 = document.createElement("label");
  label3.className = "control-label string optional";
  label3.setAttribute("for", "add_entry_req_info" + numberOfERs);
  label3.innerText = "Additional info";

  textInput3 = document.createElement("input");
  textInput3.setAttribute("id", "add_entry_req_info" + numberOfERs);
  textInput3.className = "form-control string optional";
  textInput3.setAttribute("type", "text");
  textInput3.setAttribute("name", "add_entry_req[info" + numberOfERs+"]");

  div3.appendChild(label3);
  div3.appendChild(textInput3);

  container.insertBefore(header, addERButton);
  container.insertBefore(div1, addERButton);
  container.insertBefore(div2, addERButton);
  container.insertBefore(div3, addERButton);
}

// set button variables and add listeners
$(document).on("turbolinks:load", function() {

  // called when form is submitted
  if (window.location.hash == "#success") {
    $.flashAlert("Course Successfully Updated", "alert-notice");
    window.location.hash = "";
    $(this).scrollTop(0);

    var msg = document.getElementById("feedback-msg");
    msg.innerText = "SUCCESS! Course was updated."
    msg.style.color = "green";
  }
  if (window.location.hash == "#failure") {
    $.flashAlert("ERROR! Course wasn't updated. Please ensure that your inputs follow the rules.", "alert-alert");
    window.location.hash = "";
    $(this).scrollTop(0);

    var msg = document.getElementById("feedback-msg");
    msg.innerText = "ERROR! Course wasn't updated. There's a problem with your inputs.";
    msg.style.color = "red";
  }

  addWpButton = document.getElementById("add-wp");
  addFeeButton = document.getElementById("add-fee");
  addERButton = document.getElementById("add-er");

  $("#add-wp").click(function(){
    addWp();
  });
  $("#add-fee").click(function(){
    addFee();
  });
  $("#add-er").click(function(){
    addEntryRequirement();
  });
});

var addWpButton;
var numberOfWps = 1;

var addFeeButton;
var numberOfFees = 1;

var addERButton;
var numberOfERs = 1;