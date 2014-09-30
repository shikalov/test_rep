Feature: FUS-15: Request Promo Event ADR
  As a User I want to request a new promo event so that an ADR can triage my request and get the event added to an artist's calendar.
         FUS-3594: Allow for a custom name to be created for a Promo event
  As an ADR I want to be able to create a custom name for a Promo Event as is currently available with One-offs and with Artist/Project Milestone Activities, so that I have more control over the output and display of promo events within the system.


  Background:
    Given User "tour_adr" logged in

  # Add new Promo Event
  @FUS-15 @FUS-343
  Scenario: ADRs open new Promo Event tabs
    When Fusion page is opened by user
    Then user pres Add New Event button on the main page
    And user clicks on the Promo tab
    And Create Promo Event page is opened

  #Save & Request
  @FUS-15 @FUS-346
   Scenario: Validate that 'Add as a Pending Event' and 'Add as a Confirmed Event' buttons present for ADRs user on Promo Event tabs
    When Fusion page is opened by user
    Then user pres Add New Event button on the main page
    And user clicks on the Promo tab
    And Create Promo Event page is opened
    And 'Add as a Pending Event' button present on on Promo Event tab
    And 'Add as a Confirmed Event' button present on on Promo Event tab



  @FUS-2336
  Scenario: ADR is able to add promo as confirmed or pending
    Given Fusion page is opened by user
    When user pres Add New Event button on the main page
    And user clicks on the Promo tab
    And user fill all required fields
    Then add as confirmed button is enabled
    And  add as pending button is enabled

  @FUS-2336
  Scenario: Confirmation is shown when ADR adds promo as confirmed
    Given Fusion page is opened by user
    When user pres Add New Event button on the main page
    And user clicks on the Promo tab
    And user fill all required fields
    When user adds promo request as confirmed
    Then request is successfully sent

  @FUS-2336 @Smoke
  Scenario: Confirmation is shown when ADR adds promo as pending
    Given Fusion page is opened by user
    When user pres Add New Event button on the main page
    And user clicks on the Promo tab
    And user fill all required fields
    When user adds promo request as pending
    Then request is successfully sent

  @FUS-3045
  Scenario: Create two promo events and check that one without start time displays on top on the artist entity page
    When user opens Create Promo Event page
    And fill Tour Artist field with SeparateDateTime Artist
    And click SeparateDateTime Artist from Tour Artist type ahead
    And user select tomorrow date in calendar pop-up
    And user sets start time 09:00 PM
    And user selects TV type
    And user selects TV Performance type on Promo Event tab
    And user fills media in Media Outlet field
    And user adds promo request as pending
    When user opens Create Promo Event page
    And fill Tour Artist field with SeparateDateTime Artist
    And click SeparateDateTime Artist from Tour Artist type ahead
    And user select tomorrow date in calendar pop-up
    And user selects TV type
    And user selects TV Performance type on Promo Event tab
    And user fills media in Media Outlet field
    And user adds promo request as pending
    And user goes to SeparateDateTime Artist on Artist entity page
    And promo without start time displays on the top


  @FUS-3594
  Scenario: Custom Promo Name Field - check on Add Promo, SERP, Artist Entity and View Promo pages
    When user opens Create Promo Event page
    And user fills all required fields for Custom Promo Name Artist Promo event
    And user fills custom promo name with Some Random Name
    And user save Promo event
    And user goes to Custom Promo Name Artist on Search Results page
    Then SERP contains promo with Some Random Name name
    When user goes to Custom Promo Name Artist on Artist Entity page
    Then Artist Page contains promo with Some Random Name name
    When user navigates to view Promo event from Artist Entity page
    Then Custom Promo Name field has Some Random Name value

