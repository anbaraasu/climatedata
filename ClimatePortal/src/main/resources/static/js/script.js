// This is a sample script file for the ClimatePortal web application

// Function to fetch climate data from the Spring Boot REST API
function fetchClimateData() {
  // Make an AJAX request to the REST API endpoint
  $.ajax({
    url: '/api/climate',
    method: 'GET',
    success: function(response) {
      // Process the response and display the climate data on the web page
      // ...
    },
    error: function(error) {
      // Handle the error case
      // ...
    }
  });
}

// Function to initialize the web application
function init() {
  // Fetch climate data when the page is loaded
  fetchClimateData();
}

// Call the init function when the page is ready
$(document).ready(function() {
  init();
});