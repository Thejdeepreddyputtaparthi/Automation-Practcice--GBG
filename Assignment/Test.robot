*** Settings ***

Documentation     A resource file with reusable keywords and variables.
Resource     Settings.robot

Test Setup   Setup Browser   ${platform}   ${env}




*** Test Cases ***


Verify Survey monkey page Test

    [Documentation]   Verify Survey monkey page and assert Have a nice day
    [tags]   test
    Given launch surveymoney home page    ${URL} 
    Then verify page is loaded 
    when select Good radio button option 
    When click next button
    Then verify text exists have a nice day
   


        
