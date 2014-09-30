Feature: FUS-16: Add OneOff Show
  As an ADR I want to add a new 'one off show' so that an artist's calendar is updated


  Background:
    Given User "tour_adr" logged in

  #2	Add button and page navigation
  #3	Presence of fields

  # 5"Required" labels display (on start typing)
  #4	Obligatory fields


  @FUS-16

  Scenario Outline: Show artists (search, select, sorting and remove via Calendar button)
    When user opens Create One Off page
    When start typing into the required fields
    Then all the labels are displayed
    When user adds <artist> to Artist field
    When delete <artist> artist
    Then OneOff artist field is empty

  Examples:
    |artist           |
    |AUTOTEST ARTIST 1|

  @FUS-16

  Scenario Outline: Show artists (Multiple selection via Calendar button)
    When user opens Create One Off page
    And input <artist1> value to the <section> field
    And <section> drop-down list contains <search_results1> item
    And click <search_results1> into <section> section OneOff
    And input <artist2> value to the <section> field
    And <section> drop-down list contains <search_results2> item
    And click <search_results2> into <section> section OneOff
    And artist field contains <search_results1> value
    And artist field contains <search_results2> value

  Examples:
    | artist1             | artist2            | search_results1   | search_results2   | section    |
    | AUTOTEST ARTIST     | AUTOTEST ARTIST    | AUTOTEST ARTIST 1 | AUTOTEST ARTIST 2 | Add_Artist |


  #8	Venues (search, select, sorting)

  @FUS-16

  Scenario Outline: Venue (search, select, sorting via Calendar button)
    When user opens Create One Off page
    And all the fields are present
    And input <value> value to the <section> field
    And Venue drop-down list contains <search_result> item
  #  And all the <section> items are sorted alphabetically
    And click <search_result> into <section> section OneOff
    And OneOff venue field contains <search_result> value

  Examples:

    | value        | search_result                        | section   |
    | !! TEST Venu | !! TEST Venue, Music York, MusicLand | Add_Venue |



#9	Show Date (drop-down, manual entry) positive and negative
  #10	Door Date (drop-down, manual entry) positive and negative
  #11	Venue Service On Date
  #12	Venue Service On Date

  #positive
  #via drop down
  @FUS-16

  Scenario Outline: Date via drop-down (positive via Calendar button)
    When user opens Create One Off page
    And navigate to date fields and select valid date values <door_open_time>,<show_start_time>, <guest_list_closes_date>, <venue_service_closes_date> from drop down list
    And all the date fields contain appropriate data <door_open_time>,<show_start_time>, <guest_list_closes_date>, <venue_service_closes_date>
  Examples:
    | door_open_time | show_start_time | guest_list_closes_date | venue_service_closes_date |
    | 01:15 AM       | 11:15 PM        | 10/28/2013             | 11/25/2014                |



  @FUS-16 @Pending
  Scenario Outline: Date via Manual input (positive via Calendar button)
    When user opens Create One Off page
    And input valid date values <door_open_time>,<show_start_time>, <guest_list_closes_date>, <venue_service_closes_date> to the date fields
    And all the date fields contain appropriate data <door_open_time>,<show_start_time>, <guest_list_closes_date>, <venue_service_closes_date>
  Examples:
    | door_open_time | show_start_time | guest_list_closes_date | venue_service_closes_date |
    | 10:15 PM       | 07:30 AM        | 03/15/2030             | 10/18/2022                |



  @FUS-16

  Scenario Outline: date logic validation (positive via Calendar button)
    When user opens Create One Off page
    And all the fields are present
    And change date in calendar to the <calendar_value>
    And navigate to the Guest List Closes and check that value is <guest_list_close_value>
 Examples:
    | calendar_value | guest_list_close_value |
    | 10/25/2020     | 10/22/2020             |
    | 01/02/2020     | 12/30/2019             |

  @FUS-16
  Scenario: close (cancel button)
    When user opens Create One Off page
    And press Cancel button
    And there are not any messages

  @FUS-2606
  Scenario: Close (negative via cross cancel button)
    When user opens Create One Off page
    And start input the values into the required fields
    And press top cross Cancel button
    And there are messages Are you sure you want to close this page
    When user cancels closing event page
    Then user is on Create One Off page
    When press top cross Cancel button
    And there are messages Are you sure you want to close this page
    And user confirms closing event page
    Then user is not on Create One Off page

  #15	Save Event
  @FUS-16

  Scenario: save functionality (Save button is disabled)
    When user opens Create One Off page
    And start input the values into the required fields
    And Save button is disabled



  @FUS-16 @Smoke

  Scenario: save functionality (Save button is enabled)
    When user opens Create One Off page
    Then user fills all required fields for AUTOTEST ARTIST One-Off event
    And Save button is enabled
    And press Save button


  @FUS-16
  Scenario Outline: Ticket link logic negative
    When user opens Create One Off page
     And user fills all required fields for AAA THIS IS ARTIST One-Off event
    And fill Ticket Link with title Test Link and URL <value>
    Then Save button is disabled

  Examples:
    | value                                      |
    | fdsfsdf                                    |
    | www.wmg dsp.net                            |
  #  | bestmail@google.com                        |


  @FUS-16
  Scenario Outline: Ticket link logic positive
    When user opens Create One Off page
    And user fills all required fields for AAA THIS IS ARTIST One-Off event
    And fill Ticket Link with title Test Link and URL <value>
    Then Save button is enabled

  Examples:
    | value                                                                                       |
    | http://wmgdsp.com                                                                           |
    | http://www.ticketweb.com/t3/sale/SaleEventDetail?dispatch=loadSelectionData&eventId=3879654 |


  @FUS-1229 @Smoke
  Scenario: One off - public/private switching
    When user opens Create One Off page
    Then private event is set to NO by default
    And user can change show to private
    And user can change show to public

  @FUS-1229
  Scenario: One off - private cannot be published
    When user opens Create One Off page
    Then private event is set to NO by default
    And user able publish a show
    And user can change show to private
    Then user not able publish the show

  @FUS-1122
  Scenario: One off - publish/unpublish switching
    When user opens Create One Off page
    Then publish is set to NO by default
    And user can publish show
    And user can unpublish show

  @FUS-1122
  Scenario: One off - private show automatically become unpublished
    When user opens Create One Off page
    Then publish is set to NO by default
    And user can publish show
    And user can change show to private
    Then show automatically become unpublished

  @FUS-1122
  Scenario: One off - unconfirmed show automatically become unpublished
    When user opens Create One Off page
    Then publish is set to NO by default
    And user can publish show
    And user can change show to unconfirmed
    Then show automatically become unpublished

  @FUS-1490 @Pending
  Scenario Outline: One off - time field - fuzzy field
    When user opens Create One Off page
    And fill door open field with <input_time>
    Then door open time shows as <expected_time>
  Examples:
    |input_time|expected_time|
    |7pm       |07:00 PM     |
    |07:00 pm  |07:00 PM     |
    |07:00pm   |07:00 PM     |


  @FUS-1511
  Scenario: Tour Market name should be displayed on create one off page
    When user opens Create One Off page
     And fill remaining fields AUTOTEST VENUE Hirosima; Autotest venue, Hirosima,
    Then tour market name on create tour page should be "New York, NY (Including LI and Northern NJ)"


  @FUS-2163
  Scenario Outline: Tour Manager/Additional Contact fields - Search of existing Contacts on Add One Off page
    When user opens Create One Off page
    And user see and clicks on the <field> field
    And user fills <contact> in the <field> field
    And user see and clicks <suggestions> contact in suggestions
    Then <suggestions> contact is selected
    And user remove <field> contact
  Examples:
    |field             |contact|suggestions                                                              |
    |Tour Manager      |Simpson|Music Awords - Jessica Simpson - 578-316-6546 x732 - marta@gradyyost.info|
    |Additional Contact|Simpson|Music Awords - Jessica Simpson - 578-316-6546 x732 - marta@gradyyost.info|


  @FUS-2163
  Scenario Outline: Tour Manager/Additional Contact fields - Add new contact
    When user opens Create One Off page
    And user see and clicks on the <contact> field
    And user fills <contact_name> in the <contact> field
    And user see and clicks <suggestions> contact in suggestions
    And user fill new <contact> details <contact_name>, <last_name>, <company>, <phone> and <e_mail>
    And user submit <contact> creation
    Then <expected_contact> contact is selected
  Examples:
    |contact           |contact_name|suggestions              |last_name|company|phone        |e_mail    |expected_contact                            |
    |Tour Manager      |Barry       |Create New Contact - Barr|Bigl     |CO     |1111111111111|e@mail.com|CO - Barry Bigl - 1111111111111 - e@mail.com|
    |Additional Contact|Barry       |Create New Contact - Barr|Bigl     |CO     |1111111111111|e@mail.com|CO - Barry Bigl - 1111111111111 - e@mail.com|

  @FUS-2163
  Scenario Outline: Phone and e-mail validation
    When user opens Create One Off page
    And user see and clicks on the <contact> field
    And user fills <contact_name> in the <contact> field
    And user see and clicks <suggestions> contact in suggestions
    And user fill new <contact> details <contact_name>, <last_name>, <company>, <invalid_phone1> and <invalid_e_mail1>
    Then system says that phone number is invalid
    And system says that e-mail number is invalid
    And user fill new <contact> details <contact_name>, <last_name>, <company>, <invalid_phone2> and <invalid_e_mail2>
    Then system says that phone number is invalid
    And system says that e-mail number is invalid
  Examples:
    |contact     |contact_name|suggestions              |last_name|company|invalid_phone1|invalid_phone2|invalid_e_mail1|invalid_e_mail2|
    |Tour Manager|Barry       |Create New Contact - Barr|Bigl     |CO     |23424g2342    |_11111111111111|123.123.com    |@123.com       |
